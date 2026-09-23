Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426235F602
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127606; cv=none; b=r5SFgcRfyfh36+BkRGDqVSdMJ3sJsff5hlQrVJNjZ2U5ubfV71hm3SHIDqlxgz3KzbzmlB0npkRyG1hSquf98XRAJU4jqemIbN+L0H4//vq0rHvGoUK51XXLulRaXiXr/1ohLifh2WLY98GVMisEyEHpuAges0fxRWift4q8wNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127606; c=relaxed/simple;
	bh=W62DxU7oVMIS5fUZqb/Bvu7INIz5/t+JwGevZvYU0jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtLvtLhoA9sGm/fgeyYcr2FI3Ku/1vyXFOPmIVUm0/rgv+mVuRKERVA+yfXEca3Sudsr8DPLeLItQXSudffsX7SiZ8bXohJ8aJ9qAmwFQXgG8ld1f0D4RXDH3pRcicXCfEnj1lmFxj2E1lGT0VwuoFHuhXcp8Y6VvGvKFV3A+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffmneccJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffmneccJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796371F000FF;
	Wed, 23 Sep 2026 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127604;
	bh=cGn7LHMqskID52u6Fnyr3u18tH2xg8a64lob9jwXYSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ffmneccJT/i+gE6Mt5Q+09wsSom614bWS+C6wi7Qg7ANB3LkiVnejKMXDvWAKgR+p
	 Ae//VPOzQPTNGVJBw1x6+qIBvAJw8cfjxCcDK5fswENEFaG8npHtFVp/kgu7o1svsd
	 /EClhQPopihDCT+uyVoYSXsqIeW5sFw4AzwJztc47pgUcRARm2PIwOXghEdX51SHor
	 wz5vZ8HdTUQ+wCgbulnQFN1QBcH4fQR7w5a4cEp3pFest7MwizKBupRdX0kAqVw+61
	 HE3tg+qEq84hyZBKGXmurryaPlsAWSegT4qIcWh0AMXwkuFij+PkIAzXKfBg1nIr1D
	 2zeCX4ru+UlTQ==
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
Subject: [PATCH 5.10.y] smb: client: cancel reconnect work in clean_demultiplex_info()
Date: Tue, 22 Sep 2026 21:40:01 -0400
Message-ID: <20260923014001.878777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092201-lethargic-bouncing-9f5e@gregkh>
References: <2026092201-lethargic-bouncing-9f5e@gregkh>
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
[ adapted the patch to fs/cifs/connect.c with its older locking context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a95b9d2318fa2..fc74ac831e197 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -890,6 +890,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	cancel_delayed_work_sync(&server->echo);
+	cancel_delayed_work_sync(&server->reconnect);
 
 	spin_lock(&GlobalMid_Lock);
 	server->tcpStatus = CifsExiting;
-- 
2.53.0

