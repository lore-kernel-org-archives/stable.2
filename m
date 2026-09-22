Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41743934D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112232; cv=none; b=YAkRMxPwCUeZBlMrhz5+EdmiE9IJifRkaj5yw4k5AtCv3Z70usJvU31WahNhC+uDA2TeKusIUPAagG7zHUNHfRgA+KCkFvzAxcJVSFB8lDDuNuIfSUu8Kb+5SQ1TIUGv7/Qq3NxWWHCN5a0R2pgnZlsrbO62fqIAfjJ3aniy8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112232; c=relaxed/simple;
	bh=M0hO7F32p3CAz8coqP24OCLQI3KUQ4vPq+ukateq8eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0Z0L0TRKLsXhe4Esbyy6qcia3z/1v5PjJlPfOc+4xNZYWkASAPlHwExaBuw9cANrgfy/sZ3+129EQUR3I4aBZcN4Ed5NGdsHAMeQHT91aEcKhNzNT22Gpn0oAl51sJBPwY8eRu0KjX/f2hq3cj3WyPgvytUH5iPr+AM3qxE5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0BW5jlB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0BW5jlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D731F0089B;
	Tue, 22 Sep 2026 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112211;
	bh=Vls8qaRyb4Z5mZF4aprJ+RylDOGHx/gxgIJgFoSFH7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0BW5jlBrLVBh/S3eZckGtMYvXPE5pNuTJPyks831gQ/6/h3oX9vbj2tnUOBrfbtZ
	 843zYlUY8EsTagpISKcFb5c7Bc+En/CVCAotv9+yQ4XBF/2xAWL5d7LtDL5CMtBJAH
	 DHl9za/g4ogYhwsnDNiDFUZyxy/fjRttWCk2QF1tIik/Srt2mP//4Tg7E6TYci0Ehu
	 z4kEFetU2zKGD7GbyugAFeoL3yZFbJaZc+nx7e0PA7NpXU7X8WE95D7xvpLvh1xsFv
	 JMvDJOZpAE9vzJ2/ssWaiRuZZQXFpJ8JuBnRNE+kjIOril7P1IlaUH65haWB9wB5Nb
	 vhhne+D8dv5bQ==
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
Subject: [PATCH 5.15.y 2/2] smb: client: cancel reconnect work in clean_demultiplex_info()
Date: Tue, 22 Sep 2026 17:23:27 -0400
Message-ID: <20260922212327.752944-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922212327.752944-1-sashal@kernel.org>
References: <2026092200-operating-swinger-d7a7@gregkh>
 <20260922212327.752944-1-sashal@kernel.org>
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
 fs/cifs/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 424cc901fb27a..19d4ea7359da4 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -725,6 +725,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	cancel_delayed_work_sync(&server->echo);
+	cancel_delayed_work_sync(&server->reconnect);
 
 	spin_lock(&GlobalMid_Lock);
 	server->tcpStatus = CifsExiting;
-- 
2.53.0

