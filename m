Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817839;
	b=n+G0rVpfrYibyVE2tKPFO9Y8APpMtwqozbJ4JniVSYdV3DF4fc983hj45Q/0KtlofCrM
	 U+Ntn5ePWVcnV47GxcUzJgQvdM+swgsnBw7FqYAe2rXYRdQTdVWznTOSN5qomtlRVEo/U
	 SG8Kv2fnvRaurisWh8FE+SfLR9FwrIFGFnx0cm8eaT7s58xblEZ1ZJclZ+D7eaWYf83pZ
	 z9gkkaO3axr3YD/jEggKzvSxOWEERiwwKMqHhIkVocgZgVInMlOWAMRZGAd4f8rkq3Qhj
	 3FJN1WYUwypuyS4P/K6kRGX+amMo80ufRgdgfqt+NDaiJn6bDvLmObcrdrbttPh9nDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cOA0q7paRIxlLdk5xzmnGNe14MFB+O+MPf0ZyBQ1jhI=;
	b=oy5GXgY4ujOiP9+KOHzMq+DKnRLDkSjoXbOtG2b33SIaspMTye5x19gcrCdtOFvueEbn
	 V3e8Kyn3ndq1IZ2/WnnjN6WSePduExpbEziuqEUJOdUFo2/SlpPZgtl3OWG3cLsruSOg6
	 4ZLutsftfqhWO5hhWfB+pTMspJp7RSmwtWBIaAGAMWVTKSfnwLtpYwbwf8QhU8ypUcEjO
	 yAig/jqDKZiZXF9/S18fFeP71dg2eb3CEKQwf85ePoy9HzPNogQMufUMoeBreAf0hYG8d
	 sC3djTaB5vzozLGofHfwa1qKltyA9fjy9zCJH2n1LQUYzBXWG96lVsltJOyKN6zbfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qu8YkKrC;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A49606D809
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A49606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qu8YkKrC
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-53dda625f63so725617b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817838; x=1794422638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cOA0q7paRIxlLdk5xzmnGNe14MFB+O+MPf0ZyBQ1jhI=;
        b=qu8YkKrCni6cVt48zROXdyKt+BePPaV6b2aZ7Tewqmwvdnkc2HiTzpPm6bt3RY+q9i
         VRDecQAMEsRY1ESDPSOPXenoXhh/TL9QJLaO4zIdsn1puL9mhtEw+qlQWOvFXQOQsAXq
         Yosa+rbl1xkfG9b2qK/xWuVDbK6G1bYoRetPjipabQTV7fSfMtZ17ifbdwVt3L904GXP
         0RDp7ESmE4VzaBH4RpAyjhpOL/3vuJS3sn6W6+eqdvdX82/eU4TYqZjqcl98gGH4khDT
         D1y52ZyGrUdAi7DhCkA0Fh8KZPcZpdc3g0sqb0WTdCkcvk5yqAOmzju7+SPQOGyPPDpO
         jIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817838; x=1794422638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cOA0q7paRIxlLdk5xzmnGNe14MFB+O+MPf0ZyBQ1jhI=;
        b=AyqhHSyUWDT3Au87ANjRZgFU8MN7HVrENB/cWmOu7ZL7KICtNg/5QfDuQ7nL4Vbz2F
         OHhxqwsAPVXNJurAp0ccW5EiyYbOf8qKLhvM8RzSyC+JBJth9fKYNN45IfZRQ4xzAHCh
         pz3W6O9CYYB7EP6esgLQGpXjsPIZSu6DDvEU5U+lB4/lt4PyN/z3NxvbkzPNIWt/Xuhw
         N4JGQWGcQCyuIzSLoxkv9Vl4aalPYo7qyvmZY7qAwgqS0KqBySoxtfTS28tpAsE+gMSl
         +1vJSsK5HIs3LL3Rr0w+VZSpB+g9OS5jBeGnYpDqwVqAUBMwID+RotSax9GXLDiX5Wyz
         xnng==
X-Gm-Message-State: APuU4Z+7k38iKJx0gStZDGYbWEhF0IL8B0AzLEvp3oXu934a11zjYc4J
	y9H3ipU0fFvWFIFeAIGES1aJzlOgm1l0gCDznHxYUZ24pqTE2t4C412CejZw7SbUhzC0VHvNaAO
	U61ATyqQ=
X-Gm-Gg: AYBFou2rLj9Ld1S3rSGcTZjSVviFNUq/k1PT1+Duwa0iHzZBbr8jcvLwcZxk0Yx8y10
	V2DbfiemqMTNQtly6dmyWOR6PW/mNnHZgVQPIDjSAWXyBbZt7/DSmC8T6WQrBXUpnIemkKN19tr
	Ti6sEj1gL/eBsyH28bFywZkDxhgiUxo8exzKWoU84Ld2XEA1EsZEgHrY+uLKIGD06HvGguAHKZW
	AKoN/wYz7fjvarMCQMsDBxo6jJvMheRueLy27Wz8qD1xDCrLf+Yd/u3sQ/ehPdVnGXUct7gsaS6
	VUqn2hfNIUwn+bRd0dihqGv9B9nLVjwoke+TggOxfmApOubKrh2UGdsfrsAdj/0FJpyF6bK7/QP
	oYksz+Ojx1xg+8gxvWKeER642IXo0Nea+sR21sicpecBTN6pD4aellv25J88xLwU4Yu618mpcuk
	oTfJii9WULqWfHNGaOTf07xZlWjcgbjYGlXuUWTeRvQXgwW70Vcv9TKVgIwCLwFTtnZOA+pqSVe
	r2g4732g6NCQQB9RahTQhZaKa7zih4egI8QUYasG7TRQCHKU8rO97VaGJFrgS3C/6v3yTUwW+Ge
	6a2Mh1R7UyvHNBZ/HQi/LyL5mYlJVYrTNToO5CbHt4b2ppnMGvKurTZN9llJ/l8tNvIRveJxlzf
	SGQLYTdDskSj8WIWuWYI=
X-Received: by 2002:a05:6808:148e:b0:551:a229:c8a2 with SMTP id 5614622812f47-5640decc467mr11325621b6e.64.1793817837952;
        Wed, 04 Nov 2026 10:43:57 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.43.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/9] io_uring/kbuf: advance head when a pickup empties the buffer ring
Date: Wed,  4 Nov 2026 11:43:45 -0700
Message-ID: <20261104184353.516403-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
index b1c5e80b94fa..da6b46244e6d 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -302,8 +302,10 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 
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

