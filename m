Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D52F260C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089981; cv=none; b=arlj4sfk/LGdNFVbMvE/11afzyNCDR+8iI1G0jXTk9fAd1K5ARlsH3wwMkUjN10uR83nbtMXeHFWUa2Nfq8S3AOtTTgQF2YLEQns+bKBZZjkiS44Fk+b7j3bdndjb6CQlqGckjBxc+EHvP6IEaoT5njj44q9Zls0L+C+7+pIjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089981; c=relaxed/simple;
	bh=kZFQOAe/Bmf8KjgiVl2gcHwBy/UY67119rSYMTNuNpc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GaJVIn5UkItoxjoX2FhEbhepTpMuAVWExNpHdaMyop8UbZ4aP9qpB52mlKGD/RCjtIQQs2RSwhYSUPFRC8vdQoDkXpxV7nP6EXfdCH9q+ADvIZTHVya3RzVpGB3Ao5hEbl8TqH3W04uhYyaBfHJv8EOQQbwzOxAyzRcyTQWzDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aSwuCuDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aSwuCuDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879751F000FF;
	Tue, 22 Sep 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089980;
	bh=h0oEvhul0iUVBi1nMVKvgQF+j/VHmZ3ZVwaBxMHXm4E=;
	h=Subject:To:Cc:From:Date;
	b=aSwuCuDNL/43iZvJPdlQewSwe46lQOqIttXH1zXjVk+FjDOt9e1HbofUF1vvQbeXG
	 T0ZPINAGYzL+3EC5Tbm1yqqz7Jbswdo1wHGSfcQLb1Acl5hUEuHIwWTDtNYY/0fVYa
	 gg4J7XgbEGPqvxA7MMcStTa18S3ZqlvTND6nr0ao=
Subject: FAILED: patch "[PATCH] smb: client: cancel reconnect work in" failed to apply to 5.15-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:05:00 +0200
Message-ID: <2026092200-operating-swinger-d7a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c65eae6f61d1778ff7a82e4aae4080e26f486af1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092200-operating-swinger-d7a7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c65eae6f61d1778ff7a82e4aae4080e26f486af1 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Fri, 11 Sep 2026 22:38:04 -0300
Subject: [PATCH] smb: client: cancel reconnect work in
 clean_demultiplex_info()

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

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index b6e98eb31673..bef710d9a3c3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1067,6 +1067,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&server->srv_lock);
 
 	cancel_delayed_work_sync(&server->echo);
+	cancel_delayed_work_sync(&server->reconnect);
 
 	spin_lock(&server->srv_lock);
 	server->tcpStatus = CifsExiting;

