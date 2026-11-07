Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068132;
	b=wEU/z3tpMl1N/CN/QNaUyK3RFA2fB8DOGSaWIMrb6FRnCDfC3P1SuBXzr0v03CmvNAwK
	 x8UoxRb3F+eEfLU4dtQoZ7sJfidlaejsELwBJ2hakgccCqibrz9V4oy5NQrvttEW+6kBI
	 8qwJvBWsF/4ZCg7I1C5Az6fSvkdqvtOYxbcmEibN0IrePqzVXYywIgTsJm+cuR+XeRfS0
	 RoE+FyTl66DDyYPOR/jD6ZK5suK/wzZMhyGlMWW6aNaX8qpWRLNGBsiD/HlQJN9enleyF
	 tQMORK0NXMjKqCWL3ChZNPhjJIqnommvQhannFLpUm0gZJphgOuf8g3MqZv2KHAoSXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mb0DeJwGQREhsD0noOEo3HD4wYnvpZofbNZxUePr0js=;
	b=OTg+8iqlD7EBgyiYMddpWd3uo6EE+ZIyvmtZA3lj4mUgUNvU2DEbOEyEXR9fxgquv3V7
	 gXxvzqbrXPidVnQlfTbEzTlkgm6rLQxGTGE7827zJknGM43NSPqXI5k2QaVTMIXB3xbK5
	 zD4C84JxOcWOodI0aqNpms7rycrILq3EiFGOpoFTpbu1L9vjJKq0hD7rNF716P0aGsp2w
	 upwKnq0GyON0p/anXrJ29fRGAmxB3mvYfxGZQ427AWVky6qbqWble1IyJnNo6M3HqFon9
	 ZlD4fWzKpq1HOywrUD87ehaFcKNVRTnD72VANeQb+VN+CuWxdOoTLlMLeGz1MbVhH3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijtLNoqU;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067B606AC21
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6067B606AC21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijtLNoqU
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1406415a91.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068131; x=1794672931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mb0DeJwGQREhsD0noOEo3HD4wYnvpZofbNZxUePr0js=;
        b=ijtLNoqUnid0gY6gw4GdSNHFhUTb2f6F/nxKdFV6/LURvpmnmeTJ+gzGWosmP3okH7
         8SJcnuk50NdOFfiR0zFfDl9/SkQrSLsumy82F8qY8CO4q4xXZcQUY4L/FUTUDD9DATUA
         zS78vaVXxPPXOp8CjaXByCVinMh8qU9Ql1TefiDzGNaiTSKSrRqIhVpQRapzPGrYvTIV
         8LcZb8EKMo6ZLe5fPK7clNHYXRY0rl/935FleIJ0IMVP4pmZK2tn7uvZTMXui5r/CTgB
         OtK+DX5C2xUGDIwI3+APGNfy4LnNg2ZT9iKdOlV62BJRbbh14FEPegNHgz47SqUC72xB
         bzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068131; x=1794672931;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mb0DeJwGQREhsD0noOEo3HD4wYnvpZofbNZxUePr0js=;
        b=f5KUSpeQ9ABki+htTBiGRlB8i4FzX8/0Ked+ga0suZN36NrLHZNtKZQRbCVlsoN//n
         ZDOMUpLelvJM/KtCwDXoJnqCrxhbKmLqlPv1TIoVJDLse7sOsmjjqT1YYRYfxEKsmCNp
         ns1W4DBWaCgYtJhdYxoEX4vgIQnXa8FImqjCJf6rjuquDIUZFGbX+gRRJUN2rqIUxqsL
         G1biwdRkXTBMveJzP7QHPg6fAqX5QMWvEmW0UScSnz3qL+iVPgHT8TGait/Euxvv4eFB
         UVJqeJZgtngqHxwMtaLk4zh00awdiAMB0tYuG4JlGd/CXkVS/G7gSx+aa22DWvhO51WH
         HIog==
X-Gm-Message-State: APuU4Z99USRz/2XNbhz813ojJSECsmQkZNXvwy2VNr6vTuhfao7m9fF3
	iPiFK5cNqj/hL5Maq9PbN7NEFMRtgYTi0L/2h1wHoj0Ydm98XYn/bVqNXRSB6X8ITbxBAzjzh50
	xjXGgyfc=
X-Gm-Gg: AYBFou1N385RJ8YmTjYmwT2oLq9J+edeS4D3XpRMphImbA/NMETUcMVMjwedKYtLgUE
	N00PJjkTKjeb+USZajMTE3Bg8NIXW3Be/5PPXF9xfl0EmVdLI17MdJmrpNJ50XtP9ZRcJi0IX1a
	5m64hD08hinjOJD/Yey/ELfNy9oFIfPj8xIld+U7x8z9H0o/F1vcA9fkwvFNpofc7ZlHdn3WTev
	3lKyfnlZ++KHHl4VjO+g+2xGUVAeSU+pbEyMsg3XzKNldHabUpa1TvIy0O2p85T5XxBxFMx1Jlg
	hCfMjbnLQqqQRNQy9+GMLO0SUlVQbYNyvDStTNBaQ4rc0UgK0qenjsxeOVjhke90Ox5+n8tkpPb
	Ddwk4E4e+qLlexOMUAVUJLukFXWW9BlivIT48wgEk55OoDj+1jPT4xDpKnbtAT66iZMnAn8B92m
	4ud6h/NC7gXeRFWqncYLIolM2uPuqTrANn1w2rDQPxt0xB2JLuXqsy/aXx2JNlqV1DXJItb7QLR
	QsB5t9smO0kA62gAZnAw7lPAZOSlVkO4ERU5k1XoEaXEQ/GonfBoIBhDRjIZXIdas7ri32fQ9zS
	f/ZbUDiHfN7Mjh5erJ7p6Ytg8644/8UToKa91qMgrNijCUqaYwFsrJlu3WMPLxrAljxfybTZ/bc
	=
X-Received: by 2002:a17:90b:4b10:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3b0db6e4778mr6197175a91.41.1794068130678;
        Sat, 07 Nov 2026 08:15:30 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 5/7] io_uring/poll: don't poll a writer for a read side hangup
Date: Sat,  7 Nov 2026 09:15:12 -0700
Message-ID: <20261107161514.2499962-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 74c1f1048e4401d6a953ab2299b14ace1ad6a899 upstream.

io_init_poll_iocb() adds EPOLLRDHUP to every poll, including the async
poll of a send that waits for buffer space. Once the peer has shut down
its sending side, the socket keeps reporting EPOLLRDHUP, so each re-arm
in __io_arm_poll_handler() finds a ready mask and the request is issued
again. The send still can't make progress, the request burns through
APOLL_MAX_RETRY in a few milliseconds and ends up in io-wq.

A send in io-wq blocks until the peer reads, but sendmsg and writev go
through ____sys_sendmsg() and sock_write_iter(), which turn O_NONBLOCK
into MSG_DONTWAIT, and the application gets -EAGAIN for a request that
never asked for a non-blocking send.

Only add EPOLLRDHUP for polls that want to read. A peer that stopped
sending is no event for a writer, and a poll that asks for it explicitly
still gets it.

Fixes: 464dca612bc6 ("io_uring: mask in error/nval/hangup consistently for poll")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 passes the wake function to io_init_poll_iocb()]
---
 io_uring/poll.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 2b4c3550c455..aa7ffce3a295 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -164,13 +164,25 @@ static void io_poll_tw_hash_eject(struct io_kiocb *req, bool *locked)
 	}
 }
 
+#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL)
+
+static __poll_t io_poll_unmask(__poll_t events)
+{
+	/*
+	 * A peer that stopped sending is an event for a reader, but a write
+	 * only poll must stay armed until the file is writable again.
+	 */
+	if (events & (EPOLLIN | EPOLLRDNORM | EPOLLRDBAND))
+		return IO_POLL_UNMASK | EPOLLRDHUP;
+	return IO_POLL_UNMASK;
+}
+
 static void io_init_poll_iocb(struct io_poll *poll, __poll_t events,
 			      wait_queue_func_t wake_func)
 {
 	poll->head = NULL;
-#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL|EPOLLRDHUP)
 	/* mask in events that we always want/need */
-	poll->events = events | IO_POLL_UNMASK;
+	poll->events = events | io_poll_unmask(events);
 	INIT_LIST_HEAD(&poll->wait.entry);
 	init_waitqueue_func_entry(&poll->wait, wake_func);
 }
@@ -1116,7 +1128,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 			poll->events &= ~0xffff;
 			poll->events |= poll_update->events & 0xffff;
-			poll->events |= IO_POLL_UNMASK;
+			poll->events |= io_poll_unmask(poll->events);
 		}
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
-- 
2.56.0

