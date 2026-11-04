Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817857;
	b=HlgnyqWssPBmrQQZ4+BXhR+W0lD7DT8RAPwyJlmq39LzOIdSSayRYAZSrd3Yeeyk0HLF
	 B/tizbRIddJAGXUKBaxkgDuhVDQilTKTCeahK1omWNQ2QqfVxJGDbMwwingL0YVOgI8vV
	 Oq+eb5TK6rHpDl5HDC+wlTlLt9r+l9iOscoyQWW/5CkhNLXTq0pgZvyjlH0IyrEU9NKHH
	 3z8/N/4/9XH5U9a1GKAqud8jWvmMb9BIW9b/NROVaafaGcljL1+Q1OVcZWrfrwINpMsEy
	 42HEE7BcYMDwGJxXM96F4K3eVwTWihtBtX3VfuXlyWo7CNh0+If9q9JpZeArSz0FKGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0BqHWFqmZfOj/LMmXTZjrUYLAygkx8doXMX+2wbtsEs=;
	b=ydS0a/uOKsjRC8AoW8SYzPRE3SVFa83glkiU23gEREOS0juVkRY7FOdaPzOA55BXKicq
	 rhIxtflMilefIflkoKyozs0ig22ldKU3GJV56y1nCdmwr+eez0toWgDJVAhw9FuMD+NZw
	 EaFFmq31dA7f13C0rEL0ZUoW8FYZxZeUKprjb8gWoOT7+UhsqZ9H2gyksipiPY5Fb38PF
	 oOIz5roq5rf1hWw1GY1cfFM8SayAnFkqocQjoAVjyrbdNIqrlpDgUbFNLpWtp58nJ++Xo
	 7VR4EK+QInFDE9aNuZO5SpSCDWm3Ra3xTRvjDjzR6JeS+YWWev0Q3S9jYpnWI0afK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kvPQTegM;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFF606A33A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1CFF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kvPQTegM
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843ea301d60so673693a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817855; x=1794422655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0BqHWFqmZfOj/LMmXTZjrUYLAygkx8doXMX+2wbtsEs=;
        b=kvPQTegMi7V/xKa4NHZnYG099GikdX+6IwEtx9mHFDdOT17qQeuwBAXzU9Sso/9dZw
         /lRMWUdpwDx7d1278C7IClwZS2B3s6QdwpNTKewNxVRlQAuOR2dm+1uCUh3xG9R2fUdW
         mlwcOSNVBJlo0XT+v3T4nrEgWKm7mH6i6LTlBlbD9oVhYKz6yZ4BZP/BHf2F5flXt8Xw
         vq3UbsmDktomdC4XJzldyjfcJfd9nFgAqaviX+sTYOeSVrhkFAlit8G05XWJZRdsbEVB
         Yxnr5042+7ReBHE39yVZj+DIf/L0sj3YUdj+LFe3vcALjqn9d1AlR/17wSY+7jzuh+r7
         LvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817855; x=1794422655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0BqHWFqmZfOj/LMmXTZjrUYLAygkx8doXMX+2wbtsEs=;
        b=NKcScNsDqMJK/xcxasi4gnFRhB4j9Ip9/htRlCT1YFOhtTUSpHFYwzZ528lyVoQEHw
         4/CkZg8Zj1r131+O/niWsPSZefhDVmxaJP9kjxZJdcOixuzNvkajd2k9XBjskaVVZsbB
         qzt4bDzIdBktdi52PW8GDT0Bo3eX6WckLaanzbebOI4eAs522wwUBSDjwYkU05Ce/YAw
         BPg3DrMe/+vzDepHEnah8wk5oG8/t+gY3JdMJxF5PeldYGsH8eB2MIa7ygjUWOqtuHOv
         WQe5sMEO5zk0VjJrkMeViBLLWA5A4eiHGHyAuECL36HDOikpVKuHnCqDFMsgP2IiPNr0
         ufgg==
X-Gm-Message-State: APuU4Z8kvST0sUdAwrBK1yDKwEhdb3GViYrvw7iv3GsF7Emvl0SsgLN4
	pxhr38U6hOss0Q8fZwcvoJhA9OHFtmF1tptmAT/DG0QjKDT9IMW12zqkMTP+2ksT/SIXFxOemE9
	xxZj8O+0=
X-Gm-Gg: AYBFou3m7c6zhVnYF3ylK9SawgX1Nesk8lcRUFCBTI5IJ+a3QE46l3JHsKtDQioCORY
	7U9Gq6IMV6aFqmLgU9O0LzJuNkydsgKTBUY1JQfMEJyNZKP+PlFSjIwLrQOFHaLmLk293h8O1/C
	g9GAVNqrSkF6b93qx1Kr2XK8E5WEggoYzIaDWsTq6VRskl39T8pqAhvm26udfauSyYbdsdxwTIW
	+9umNfm09iULYY1uMJVcVmYluU5li5cK+evoNn2zfqb/AIWxO2p5gE9GwWQAdGoOKtIEVRKYe4h
	d5CQUAeLdzSklciKQNL4gEdnKCKqBJHEuhbWjoYPfppvcPj0/MT07lGXid4wNN8Fw6Isq1WrNO5
	GGx15l+GoMGAJ+Q15jAYxIJh4zGrZyGik9WsHmxWsFri7bGnC5GY+h/GF13CwPSt4PkJ2xBvLid
	8JACkJFILBKR567SQ3EnWw7TK3Nsl4SSvYk4xMTkqkX4T+6aGcaC8LOlyMYk2WRzsY35TdKVsN3
	fwubN3ER8BiOg3VnAaP5YF5gXIq6MvE5ekxSO+Dj8CwLAp9bGxwSvxJnASJXkb1bDzkacJGMSiY
	IJGOwlytf9paudDmDvz8wxwKvKWMLOmRiyQxW/z02alZqVty208foiYKe3AzPeuhNgq0UbPHBw=
	=
X-Received: by 2002:a05:6830:25cc:b0:81f:6e05:c1aa with SMTP id 46e09a7af769-85d3657604bmr14013782a34.18.1793817855362;
        Wed, 04 Nov 2026 10:44:15 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 01/11] io_uring/kbuf: advance head when a pickup empties the buffer ring
Date: Wed,  4 Nov 2026 11:44:02 -0700
Message-ID: <20261104184412.516558-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yichong Chen <chenyichong@uniontech.com>

Commit 8742f4b5a472c347fe568a73468a2d9e4d630b33 upstream.

io_ring_buffers_peek() flags the request with REQ_F_BL_EMPTY if the
buffers it picked were the last ones available, comparing head to tail.
When the loop breaks because max_len was exhausted the buffer was picked,
but head is left pointing at it, so the flag isn't set if it was the last
buffer. A bundle receive then retries, finds no buffer, and the request,
which has received data, is marked as failed on account of the -ENOBUFS.
That severs a link, and ends a multishot.

Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023091711.83481-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index e1f4ee872740..c091c3c462e1 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -314,8 +314,10 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 
 		arg->out_len += len;
 		arg->max_len -= len;
-		if (!arg->max_len)
+		if (!arg->max_len) {
+			head++;
 			break;
+		}
 
 		buf = io_ring_head_to_buf(br, ++head, bl->mask);
 	} while (--nr_iovs);
-- 
2.56.0

