Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197055;
	b=YwXNh2WFDIaNM/D5nZet5gTFotGmITyz8EBiSgowpS2LjccGyn4Lw8Ah8ZmaohU386Dk
	 jDhknVW6Ch+fkm/N4DKt/SyGXty54qMNLbJZf+tDCxWmAZTM9H2tZ/7cdSllR+1Uio3Wn
	 /jBbJau+OLHMnTfx40P/Hv+0d+XZfG4CaNKD84tzLCS3annDxKsTk4kU12zcDWcMdGmWd
	 s54mnmXTw6tBGdA4w8SiHA09y4QEMuQ3dqRhMVQGdu4Ko3hOX/R8WZ+0AasyJREHSr4mp
	 Z6DdDWUobku0gTsFfooXRr6n+M4YSKQj3ZU3rH8XTZtSCCf62RLN2E+hgBjtDWNGHCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197055;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fM1eZT2anOiF7+G31jTBlKxdoDjclk3Qkp30YPCrT9k=;
	b=Mw1J6cVnW4dudNA4rUsmzW7sp4yfG5q5K/Sh/7AT05k7gU2s8Ekud59/zlOh4Ho6LYIL
	 kDY2aO/7GOgWk+5DtMV77UFUvmKqSpx8/7r4g3AKPR3JYgvC+J8Tvq9aqyLIEP+f8fgJ2
	 83irCWv0Oj9FZYyVeWugemQm524J+jzLDR71p3dDzqJQfBKXpu88s/5KG9R/ufKNCSMH6
	 o6JNgVcGEcF1r5LF/AhVPI6Gx20NrEsBhetMl3ue+IpWjhXF6t6e9358VDJnPJPZdkomE
	 ByJ89cXiDtiOnqfm03oxDFqt+CDiCA3eqjZKtipRVtYSZG0xSOnJeaWhxSf4yKGjIfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qAVh0LG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D640606A325
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qAVh0LG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EFA1F01829;
	Wed, 28 Oct 2026 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793197055;
	bh=fM1eZT2anOiF7+G31jTBlKxdoDjclk3Qkp30YPCrT9k=;
	h=Subject:To:Cc:From:Date;
	b=qAVh0LG3vbCvNPyUGvTlu0GV8arO4lex7WKVYRsx70UvpUJbGVMNpmBkJqlX/t4xF
	 shpWsAXiFhTlYMpsVcaCbUoLEnab8MnE/zJccYlN2MSS/zhIklA0KESlizxWrr//gg
	 t5HwRqU3GSBQq5VmKd/JY9JyI5Trbcac/gpPT4Eg=
Subject: FAILED: patch "[PATCH] io_uring/poll: avoid retry wakeup loss when dropping" failed to apply to 5.15-stable tree
To: juanlu@fastmail.com,anand@meta.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 15:17:33 +0100
Message-ID: <2026102833-buffing-shone-0fb5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 937d38dcacd675dc0572d6c9b6743960df3128ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102833-buffing-shone-0fb5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 937d38dcacd675dc0572d6c9b6743960df3128ed Mon Sep 17 00:00:00 2001
From: Juanlu Herrero <juanlu@fastmail.com>
Date: Tue, 13 Oct 2026 15:37:20 -0700
Subject: [PATCH] io_uring/poll: avoid retry wakeup loss when dropping
 ownership

If a wakeup sets IO_POLL_RETRY_FLAG between the owning task consuming
the existing instance of IO_POLL_RETRY_FLAG and the loop check
of io_poll_check_events(), then we stall on processing the request
until an unrelated wakeup comes along.

Using atomic_cmpxchg instead of atomic_sub_return to guarantee both the
count v and poll_refs are 0 and no wake-ups are missed.

Cc: stable@vger.kernel.org
Fixes: a26a35e9019f ("io_uring: make poll refs more robust")
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
Assisted-by: LLM
Suggested-by: Anand Natarajan <anand@meta.com>
Link: https://patch.msgid.link/20261013-pu-cmpxchg-v1-1-4ddc10fd8a03@fastmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 7dcb904e8fc3..704a9b6102a9 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -330,7 +330,8 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
+		v &= IO_POLL_REF_MASK;
+	} while (atomic_cmpxchg(&req->poll_refs, v, 0) != v);
 
 	io_napi_add(req);
 	return IOU_POLL_NO_ACTION;

