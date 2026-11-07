Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068188;
	b=TMtWjalQ7zvwiIrAyDyfW6WPxDLXSejiFuZtQvm/Q1MBik0WlCpqjnGKBMe6dakw28Ph
	 zoXJClFOEGIpScdqF3i3sd0Qs7bZmLO6ifomWetY4Ww3G1gtqgvENH7XABleow47QIEO8
	 rvBYr3gaS25LNLE5aIKsClUcNRfZDvtvDfT/b8itbLl4pm0xQ5kssm5hHJqwEcSbRwf/i
	 Lwl1eK0ypslPBnlYaGh6/ZwgWchf50Wi6odSfaNSvOHL2EqYC4RkBIL67aLntoZ0p7wGI
	 JYXVC5GgN8sT3vxggVwoTugKCeIJGvYAIjBfl7Mdnv1QSeBNTidHuem2IN/Ul6jaHQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qOLe9lZZg8bL8zXuEYinac1nDHGo0GFNokT2vUD/WDk=;
	b=fA/gSSe0Ui7tB/p4BsD0iTi1g4YQrJltfsY8cmNyX+ooOu2RTxigATjCzKP1fKIxuLJW
	 1pnPhQLTD6WhJHbATRT90uS1O7+4CcpVro9XOi67wteMoZ1Qd2WW27TNDbXr/wuUDiuOv
	 mWDcEtxrz+E+MZ0s3PPCpasmmasmWjYa3rjBMmySO66TnOlcxcOg+I+8dpe6biq8+pgRG
	 9NhKqevbYl9Tis63K3NvIkr5tweyL7SsAHAQ1ntDlsDO9p8H2YzcZfGSBRw6KilPUt3dK
	 mAroTttRHM15ZqTkJqvRpkIy9vPUBXM0aXPNoEBf1sYVW9qW+fZ9DpC1xGCtPJnHnMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hZZqzioo;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157A606AC1E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3157A606AC1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hZZqzioo
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so1014483b3a.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068187; x=1794672987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOLe9lZZg8bL8zXuEYinac1nDHGo0GFNokT2vUD/WDk=;
        b=hZZqzioopncZxCOwMSYYP09S5U20zeWk1RytN9aNdb782knxWDaURPu6mphPvOkVe9
         vghV1lRDlpeIQyhsEUNXDZYqMW6+AWVdjIr9DW/SJ2vW5PPO6Ylz1STjg7HU+tTaTe4h
         U3jiUG0D7Qddgo6X76c52LycT9FuDeF+QZYxMuFeVxCcrOhjWfUMuvh53nJ1NkOSOjEf
         Iw+kctandtiNd+yVh6xOGxFwoGYevHST9pBoNB1KzLdZMdoEFDT/6n8ZVgWLt/uRXmUv
         2ZjWJE3dQgvi28ngJGLt5/M3RbsDjgAcBYNhPZrg396kdJnU9rEJq7gglVq8bTcwWkOU
         A4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068187; x=1794672987;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOLe9lZZg8bL8zXuEYinac1nDHGo0GFNokT2vUD/WDk=;
        b=kj4Gh8BC+lBrkF4/5TnBJLn7RDrGA8IhZRgGIRkx/VFI9CFvbtgqo06ZIf2jr4SuvV
         WVI3rwhvLmCW3q8H8ggdPUl8yo7BrhFEo3IRBQtCCcEFX4r+LrJ8K7eQvvPYMh/2hCFA
         xr6TKgCcbCTSsp4qwRi+F85mTZymTT3UnVMBrdJBxGD+MtRfmnUbKUNC/bU/zodg+y0K
         bbuWF3DPSAqk3EKY5rdAt5mE+rfuPIJiVFTkzDHt3LcVFBdrfeiAbEpgcaEouLosPcuP
         7Ri+QiPs0tcAXdR8MIRSd0DBZtzhaF9vlgM8sRWyaH4NxIVr6KAtRGNWU4k2/nYcQTCP
         8nUw==
X-Gm-Message-State: APuU4Z/xI5r2Qslm5GlXlfrALENupT7bQjkRr0OFP5UhNpLGm0jKl/5x
	viUxyymdK+5rYu6PoHFNqRjnNNj0YGbeW9dp5sxt8+8uMTTh8u1gR1Tth05inQD1ayUydUeFw2l
	SC0NVXBs=
X-Gm-Gg: AYBFou2dVKfC52e0tbZbu/4Gyytsa72QQc6//u8ALSexlAFfcgfqx9aWiV5WBxRqYMG
	UHDfOy0GpNe+u62kawehU+cSsGwBBhseSYMqEdH8g2VUOu0zrc/0Q+fGJAVQvEG5IZrflMmOzdt
	EmUvHeTCs+DmydeO3wKiqFiS614bN2Z/rYPrTPMmzAiW3tTY2MbGv5b3E/c9pppZ4cV5ZRlF5Wy
	doqiw25PRA6TJ9hTzISryT6hPb9ukcctMvB6j0WCkzjMIyNL6yuPj66gK7fLw8jyCpYBISNE/sj
	IdKGEGfC5L8AEUqifSNTBpdgBeZXOhdatwzAiKuhrAN2qBCYRQ0LAT9/B8YKVXQZbzUOHFM2gcE
	5ldJguBppXCYFpzgL5HO1d4+TNiOTp0nigsCVoXcS78fAATgf9KnQq5AEvThT8RCgbfiLFHRvwE
	vcWSNP+wEUEebKWA9ulVnKfSd2d4uW3RMTT9irny+dQsrUczHQZkwBUcNGpl5deBJFCujWd4Pxf
	LIDud+L43jh7Vm0d5AjyUzdGlXd56sfFqzzyeJNCW4HHLcGUsUoqLk073ljfu+2B9hWnMdFLWWA
	M9FSBkeFhXvzonIVEgkYvsgECkxa63zaYyxxNd2po+pLSTb3L8KFVBesG00VRYOZD3nsS2weeWA
	=
X-Received: by 2002:a05:6a21:e097:b0:3de:48e4:c37d with SMTP id adf61e73a8af0-3ebb29c3764mr6642023637.26.1794068187536;
        Sat, 07 Nov 2026 08:16:27 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 7/9] io_uring/poll: don't poll a writer for a read side hangup
Date: Sat,  7 Nov 2026 09:16:04 -0700
Message-ID: <20261107161606.2500384-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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
index 39418fe05d59..7884ea7b23c5 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -169,12 +169,24 @@ static void io_poll_tw_hash_eject(struct io_kiocb *req, struct io_tw_state *ts)
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
@@ -1112,7 +1124,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 			poll->events &= ~0xffff;
 			poll->events |= poll_update->events & 0xffff;
-			poll->events |= IO_POLL_UNMASK;
+			poll->events |= io_poll_unmask(poll->events);
 		}
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
-- 
2.56.0

