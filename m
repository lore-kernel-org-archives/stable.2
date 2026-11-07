Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068156;
	b=SHkuH3ZmyBjwnCJ2U1pz6iEDeTajbs+t712hcigiJYiq7PvMUnRe/Agi0kmkhOqtw+nV
	 YKyCohripnfoMpPgP6IDdJvUffZYzyF23TMI6Q7nd77Mi5kvpPGLxEPU0TFjjZ4drVZmL
	 aGyCiXh2T2zuBiY0Kb23xwGDbVpxl9ur8Bqo5MnAcrU+iHzAsM69YA7DuxYpQwwn3+pyw
	 Lwcs38wo5aegTIpVU5nThj0PtXpmfChT/AIxa+papi8dK7Vd5Y9oku5774vIyq8x3K2Ae
	 4xGzctU6Iqm/QwwupHnARNKGxxVPLaUE4A3pdfoVHTEhUIyQcIddzjBIKX2p0M36KZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H31zKYJN7uo2g/SsLMQhJDJIoLZHCVbD7lFEFoGyGH4=;
	b=OsIljPfKhcCFdsl7pYqD3Z4mjn6ib5Dij/IfD+tyQM6log5p7AdiOtc5+6aRGHPzZ6rU
	 z+PDyDrMga6Lz/x/MTAZN111FC1w7qUnmpOPGQSa6XwpMqWHrZtbcsfK2IKk+EtVXO/P3
	 sYjfDums46uKrP1WAKM6pjjc0Kr0ErDf49VUXyTYDvdVhXzP0XOkWK8uWlX3z8xWzjpRh
	 Z8ws479juv47NGb3WihLl732lOPaDJBwYuGHFiG5iytcqyLFv27IhGm+OlefGuRNkenDd
	 F0918lD9qCqmYgewuS5CF/IzbNruBrISoa2yuike30koYNzreJwLxuNR2dU9bBVN1pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cN7fyZZo;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89C606EEAC
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D89C606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cN7fyZZo
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e95bd1c14cso14804845ad.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068155; x=1794672955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H31zKYJN7uo2g/SsLMQhJDJIoLZHCVbD7lFEFoGyGH4=;
        b=cN7fyZZoEL5nQvWI5tvl+rTayakWGB8DC87A5xbvDcy7KO0tyRuVvVyyf6jGlefvQL
         MkWTV5pGWPGoDyh5mEp9UbhFDCtf8qpdEHYokGS6X+DhO5v2k3wtsV2QX42mYTzkTbcc
         bl5VceBQljDC/daHRTxgoJJAnUK7YSFWZzZC/8jjrbdYHkygGwS2UUVxV1b5jDMKSx78
         Ltb+eFz8b6634EP5ckP0GwDAa4cxSOa4V85cstrpGF1ob9WNtd4ADZP4kYaPR7nKcEhf
         LB/wGdqUz3n3wqDbb1twStlspka/dqixt2LEIzFkAKo//dIHP3mwh2zf/iwtp6oxZljt
         bO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068155; x=1794672955;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H31zKYJN7uo2g/SsLMQhJDJIoLZHCVbD7lFEFoGyGH4=;
        b=RW6aAnUIhlRoT4jCDk59g5AoIqbOsolGmGW6hvw+ri6ZUJ+6M8V80O2VOoif8S7do1
         rpdZHEtAY9ziMgi2CEaLS96UQsG6cNlZaYUMRH1bqO/78F6eoVXHt0czxeUo4p+0G4wb
         QX+nEEJBpyIzdWM7dvIYOsFogqez13H3NdG20PvVs38ITkgyGdrqmEZChQ5iqedPLoOn
         BHSwX4tZ8RIleIJU3SlUWqCUgIG94oJZ2KHZrc0xawPFqV4mFhQkR3sCwllRmpiga6LV
         ttBBKWFCAs5R71xoGik11BTrtmVTctzexLhDmhdDvvFn4mGxK3EEi7pMUdYaJDd91km6
         KVBQ==
X-Gm-Message-State: APuU4Z+wwn8DNvF1g4PY92whNmCycnl5dG5LOJczNSx++/TKlKl3tLex
	ykArtUcic+/qkpUUTDqvfGjwygM8mwPcNtv/WsR7rZPu0WlkXjLxqrRwt8Rqx8oHUTTDr/piBsD
	0H4wHpeI=
X-Gm-Gg: AYBFou3FOuOE6n1y2eHhH4Fkuz9nx7vZewC6dfKzC1voWoYq0IvKYnkcwVmkc9Azsto
	FHGZ8QTtgekMI1q+Fw7S+cLj+uKxmH28N+WU1xv7t+brmn+/BGUymi43xJfj1PoWeN/YQj7Rm1O
	vt98492KR/Lhk3+mG5LldNhN3oPTNhYEyMuXqmKpCEYqrtXUnOhUiyFce19N4DpIdFZOzSWvdE6
	WEY8dwHomv8MeVnNpjYZ13cG8TAkITNaPKZ6wMu2JIceNWjK+/PMkaoNH8SnmWNJ1Tbfl18ewbj
	SAfjaDj6TkvoPYY+gvzyOSMP/ahN5XCSBjxw/lM+Mgqu/9yU9fDmUQsTo67EQdLA6mxg2RTf5JG
	5RVP6AcYUuhz/qz2yNKuHO9s1KmFIvU3IAVgAoGqWX2q6qhjGSpql/wHYjOxfBzP36uOCoKdRpu
	wLynHNnZCI4sNVU1+TEtLWruik5yZgkW9NII5o/KGlLI3IJ5WAmgUz9l2g7fxL6xQw5OID29p6V
	d3nnVbGmkEXnKegCQ1rRcqJD3+t1njL3+p1qlgz/qTwdFyTfhb0Pd7TImll1bgPVt/JfZ5F+qn+
	gR4MR2E2VK85P0MH3fNIrU9aMlXvmJBmJfVdlMCDdoPCGr35riRmMF7x/HUxTPR5Ge2uyp+gjZk
	=
X-Received: by 2002:a17:903:1b67:b0:2e2:d77b:e587 with SMTP id d9443c01a7336-2ed40abb311mr78296135ad.18.1794068155448;
        Sat, 07 Nov 2026 08:15:55 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 5/7] io_uring/poll: don't poll a writer for a read side hangup
Date: Sat,  7 Nov 2026 09:15:40 -0700
Message-ID: <20261107161542.2500190-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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
---
 io_uring/poll.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 08d65792f3cb..de7da2bd283a 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -167,12 +167,24 @@ static void io_poll_tw_hash_eject(struct io_kiocb *req, struct io_tw_state *ts)
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
 static void io_init_poll_iocb(struct io_poll *poll, __poll_t events)
 {
 	poll->head = NULL;
-#define IO_POLL_UNMASK	(EPOLLERR|EPOLLHUP|EPOLLNVAL|EPOLLRDHUP)
 	/* mask in events that we always want/need */
-	poll->events = events | IO_POLL_UNMASK;
+	poll->events = events | io_poll_unmask(events);
 	INIT_LIST_HEAD(&poll->wait.entry);
 	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
 }
@@ -1099,7 +1111,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 			poll->events &= ~0xffff;
 			poll->events |= poll_update->events & 0xffff;
-			poll->events |= IO_POLL_UNMASK;
+			poll->events |= io_poll_unmask(poll->events);
 		}
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
-- 
2.56.0

