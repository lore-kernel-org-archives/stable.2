Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068184;
	b=LSSNZgHFYY5uCpFgHiLQpQu/qJYL66j4V1ffV7oSC8FMIGV5pt2Q+vbKADT+y4sxqJKy
	 /QO9YNNtuL/uBDbV7DsrIfKoDus7jB9Pk+ZKSbFuRirZMjA6UoRBHiyuYSlAhEDU82nCW
	 AJSjMaYiNhE7J1+PQNfFsd55lz/57WAGWklf/LtQQMD2C4rg3Uq+mialwJPdENCkUQxBT
	 nIPZI0bffKqBt6d+olNAYFA/x21P8T/GUcPhyh+jhTad12gzV1UziPS5OIL3VgFkI0hAH
	 9RDpU8vmO1CHbh1eKLoC/T4hHfew3278UfLJtctq7aQEtCtfaPkxu15Y+Py4G4522Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=62+cFk1HaMox81dtGmObMrJD2+8cX7oYmC5G7drigAE=;
	b=nfDaIZEl+XFck5XP2N8HsLxG7UDDHPegvpHIhd/s8gkpfCdGq126Z2alHWmkxBXNsjU4
	 wILlKKZ7aqRe3t0B2G5PEobqniWj3OsCzqGPF/UJzZ4ojAFJrsc/OlPXM8b1t3kgt6U5m
	 xGULXsgV55pLJB3XA1fSycbhLDJy+STGt4WLlJm8FK3BTljEM+K43hXJc548F8k7FT1RU
	 OOz679y72DQ4kRZeBVnoY1YwNqvixZIXsCTvtwbsnxvo9hfttaFbHcdwNmm4G6H5loaZr
	 Voqbg8NSPbRqIMuDY79ltLB1MNLfmw3eU3J0fYfuXyhnMkWg3Axuvjii0qu7k0tz3rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LJThFjGy;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6C606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E6C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LJThFjGy
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so637149b3a.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068183; x=1794672983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=62+cFk1HaMox81dtGmObMrJD2+8cX7oYmC5G7drigAE=;
        b=LJThFjGyf1ygTqoQgYS77yoOHnurcSHAKD4yUqazVgUJMZbkSkfnLnTbPbNkPyQvni
         Z8BbeolBWb7tBFQEYuA/JqQ92+9ZuNpkWHsf8wAKsUCk4P9DLhgqTk5UIIWzAC3vWkrt
         Z8zRTlre1N5eaqomozjCzYaa6cVI8yu/NNX09O7igKJbfHJ1a7xvjyryzy/GMzxUw0p5
         sqA4y6Y0u2niMas6ZtnEfDJII8kwXms6mmJnKbtBiCY5uGuK5ktGUYPfaZGSgvNUdfn8
         l1PpsrGa7nqqISbRon+Z/TTYIvCF/OwKbYUuiveKufKBK1oFTxyFaPd941mGN0+kd9v7
         NtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068183; x=1794672983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=62+cFk1HaMox81dtGmObMrJD2+8cX7oYmC5G7drigAE=;
        b=u/ZfTGEnLFS8c1MweCRdBW9cvEN+Ha7ltRcn2K6U5EUcdSWWQAtSj/ufg8lRlW5ZAa
         /B1SQ9rnZF9ZaA4fu4NqsSO0JmNT6aYO7YYwnesX10P7EWrUzTlEIZjQPk4PvQeCwYnK
         Mstbfu/miYVjE7XIPLbahNaznAmx4ShYrl7FwFWFgvJDQ6X0Gh505KoP6Vi5K0401n2P
         KBI1WnAS50al4p6zIPaT3/rwsQHCRqR7w9gthzgbbsAYpEl+KBIpQMzOfH6TmcvFn3cE
         XsAazvUUfeSo1uRwhPvrVEiRH87Yru25iwpdo8byrNSkEKo0jCe/AjZefAo5OZA8yqGg
         KLFA==
X-Gm-Message-State: APuU4Z+CsVAWUhmtWR0zbTmQiA4enYgM34E9qbOY678h6qgjITtS0ROe
	LEd9Q4pL2TF8TfXUtErXHy6r9/YcdZto6ONEhh7N+KL65s9r6lThsNEaZ/Z7p3MCUV1V5zoAbYs
	kBChsjXo=
X-Gm-Gg: AYBFou1kmSumrEiI6uOkZjytGPtpAJwBZIJlW5uTnp7GMgaitIsyLlas1fyeDNlGqM/
	DNSKpPsigVgsb0GetfqNurJCDgwVk0wlWvd6kjSkGLlQJB7WXfSk4oFjWOZ1bbu6gqVEGm0mT8v
	ASXM+oGGguR5mKVrWKNBVoBECvex5ixWNafl62B9rKkM8zSI4wxEHRRVfpqKtuESlTLoFwsmUrH
	apd3s/yb6xgQEe3494yWMV8SKQwI5RQUg33rZiHlCA01HywIM03NP+S0cjiUNFEBKXh9roWouUm
	9PYyJBjd00xCD60Q9AVrDw+4K5bl8ALdbcnG9dIZImTMMITKTnSlhoBfzTH7fzJ/hRim6NnJoUO
	b+aETur3kFn6SbH6hubrHVG3Q/gjG5wzpVLmAnoA53BF15wkBsYmXqcVzrRNHKJXpuubU62d/eN
	yc4gHzOtgvTZiZLJoejf1chEnAKHSf58K1j7H/cCk3JqeCEXd8IqoBnwfJ/unxJb7tloBwN/P5y
	b09/7VV715MYLtpBMyaiWuajr0SFnb2j3gGraM0SbO1IkaGIvKp0JlbHngFr4Vw5q7eE3Qq3iyT
	cBdg8y517RYkBi5gw+DUSbBRZl6N5wu+WKdVdjr7pxImdZCgIE4RB0ISaYQRF0a9bPtVGhMl8BA
	=
X-Received: by 2002:a05:6300:8197:b0:3eb:a890:5f8a with SMTP id adf61e73a8af0-3ebb2ac52d0mr5050759637.86.1794068183043;
        Sat, 07 Nov 2026 08:16:23 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 5/9] io_uring/cancel: count all requests that a CANCEL_ALL cancels
Date: Sat,  7 Nov 2026 09:16:02 -0700
Message-ID: <20261107161606.2500384-6-axboe@kernel.dk>
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
Content-Transfer-Encoding: 8bit

From: Shang En Sim <sim@shangen.org>

Commit 21ddbb14f7c3baab50a2a6c13ee375edc2bbe031 upstream.

With IORING_ASYNC_CANCEL_ALL, __io_async_cancel() counts one for each
io_try_cancel() call that cancels something. io_futex_cancel() and
io_waitid_cancel() cancel every match in one call and return how many,
so four futex waits cancelled with CANCEL_ALL give a result of 1.

Add the number that they return.

Cc: stable@vger.kernel.org
Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Signed-off-by: Shang En Sim <sim@shangen.org>
Link: https://patch.msgid.link/20261030050319.1448530-2-sim@shangen.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/cancel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 13d5d4f2924f..16dd8af6ac98 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -189,7 +189,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		nr++;
+		/* futex and waitid return how many they cancelled */
+		nr += max(ret, 1);
 	} while (1);
 
 	/* slow path, try all io-wq's */
-- 
2.56.0

