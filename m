Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C849E5C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105636; cv=none; b=oUcZ24DZnrjrfjJgNe3lgnCdp4ynqUxSufbMDx5qiJGShTO1nFfHit5Q/CPCVX1ZYaCJjBmnOJztrgzA9sgTJJNM4tz7hMks2Z+mJJCcjHW4s/xPW1BzEI38Bf6fc5cawCPzevR8qkFy7C5aZ7IvRMZna3QCRL0Jf6RA/XXI+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105636; c=relaxed/simple;
	bh=dBdPDwznAHzi469boPxyQ2fAxjiW9fSP9qRCTCPa9rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0A7Pop31PLh6dKjInv2C4q3X2haEIPYxflQQyvTvGVaNJswsIRssxPKdFO2Y3OAqG2X2cWshT6ikvmGCTvk7mpdf1/4bq99L2xuZPPBCgeR+8iUn6Hv9jP48kWXBAtWuJXh0pT+djFYiO/SSTTtjbpXEsN9QZstsvzbL80OhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D73ob1Y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D73ob1Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261991F00898;
	Tue, 22 Sep 2026 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105635;
	bh=1uGogvfX/sFytmiinUEUS64nwoanKpw5tye/yRJIyas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D73ob1Y4d6hu0fpPQ4wexz6Um6egQEQOdnc8CoPU3TQ8hS2peCp2ngwZrrl7zH5JR
	 va9nKXKyXX67raBy/GOPy6451/LOF0XlpwNnoNUjHW+QZoF88oSEbi8/igB6CDYDAq
	 JYRWUngTBQINTvqVpH2BiDJhehCY85MD8sJyRnj0Ew1A6ib3dYRR0YMdQ84uqYMsGq
	 BcFtGf3MdDDSInSQPKQkQw666cDngKg4vF9tASbnCKjyrEuVlGTCfbQWSzK4M/97q2
	 w1nFqQKuvKKSZd5O79wacUgj+PNB0nE1MDdhJxkphXVMuGzObpvpkz2Huub8KP0a9+
	 A5gL4WV1Eg14A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	syzbot+5003556314abc915a71f@syzkaller.appspotmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] smb: client: cancel reconnect work in clean_demultiplex_info()
Date: Tue, 22 Sep 2026 15:33:52 -0400
Message-ID: <20260922193352.4154615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922193352.4154615-1-sashal@kernel.org>
References: <2026092259-extortion-dragging-26e2@gregkh>
 <20260922193352.4154615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit c65eae6f61d1778ff7a82e4aae4080e26f486af1 ]

clean_demultiplex_info() cancels server->echo delayed work but not
server->reconnect, which can cause a use-after-free when the
demultiplex thread exits while a reconnect work is still queued:

  cifs_demultiplex_thread()
    cifs_readv_from_socket()
      cifs_reconnect()
        __cifs_reconnect()
          cifs_queue_server_reconn()
            mod_delayed_work(cifsiod_wq, &server->reconnect, 0)
    clean_demultiplex_info()
      cancel_delayed_work_sync(&server->echo)   // echo canceled
                                                 // reconnect NOT canceled
      kfree_sensitive(server)                    // server freed

  ...later, on cifsiod_wq:

  smb2_reconnect_server()
    server->srv_count  // UAF read of freed server

Fix this by canceling server->reconnect delayed work in
clean_demultiplex_info() before the server is freed, the same way
cifs_put_tcp_session() already does.

Reported-by: syzbot+5003556314abc915a71f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6aa4a12d.f81106d8.2ab401.0023.GAE@google.com
Fixes: 53e0e11efe92 ("CIFS: Fix a possible memory corruption during reconnect")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 6ded0a1d02c8c..f55dbb85adc70 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -970,6 +970,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&server->srv_lock);
 
 	cancel_delayed_work_sync(&server->echo);
+	cancel_delayed_work_sync(&server->reconnect);
 
 	spin_lock(&server->srv_lock);
 	server->tcpStatus = CifsExiting;
-- 
2.53.0

