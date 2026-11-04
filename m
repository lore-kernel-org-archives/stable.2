Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817821;
	b=V5Fn3Z1cyDp/a6m8z5VXLlB0kYofNA6W1aqDMRm2puRmj8FPEKQDUGsyMn8bHnMppSy4
	 fVOflfqMqrON7CfFBClFS1sgJvWIUW/xKmWYjEJ4dFe3z/Db5dfMqDOtG6sLOLrtkYP1q
	 5vPjD3/UfyQMsNePZEE+xqqL83XMeSzajHjB82asMzgmvft8LfhF6Vftcl/j1jahqGjpT
	 0rHN4qV+gNOfneAhTsjHMY44nvrKq8SdkCBzTDUyI/FNqG/3cthj2r8yfcP3kc/kF47+3
	 m0T0M8W1I40V4COffJTezlYfUDkK9JwmSiLXNL/9Fjkl1T7t7wthWQFpQY7UJDUPskQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q+ustpqBY7DSjfgzbH8b++CS0e5Agr/KMTfvnsggDvs=;
	b=UJmdvyvKbH14XW24OdS3kzWPDX+X57JmOkYADyi784NHhUPOPzK75cz3tBNCUjrvk36N
	 YcG2Np6XHVNcohla54NG+M67I7ryzm4XKZgHRizKWfNSAimonie2j8iw1uHuUZCdctpy2
	 00dQ5SV57f+76Gfh/rN5TKnKEgABm/RRn3NUw8d1T6wlJyLQehYyKYPydVBXelf+/r3Cj
	 PK8E3FqwssHmsH+r0VMlQwHeICyUSHwreFQrfxVNDRIg2Mv2TstFjUwHJRen6gBMSTE9Z
	 XUcQjRHVAP5VUOzGYH7gU6iOO7AH4ccGFDQ/AK2pP5S88t9RBBpBaLS53gYkrsTB0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BHtgDFaX;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB1606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BB1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BHtgDFaX
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70b875f6f1fso957620eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817820; x=1794422620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q+ustpqBY7DSjfgzbH8b++CS0e5Agr/KMTfvnsggDvs=;
        b=BHtgDFaXcJ8fRq+n2QPQa6F0voznyFuQvKMwWOwqHkEyVspXekpxd+yH56L5rXFzm0
         2G1YUU4DO/NT7pYviTa7Q+kY+w15zyfVSoWvkFeZbRZjSXFoFfu/vqJTB27h8vyQPS5I
         o9kqdHyKh/+qHU3DivFrkY+lzaL4uHp6fbmTBpgxoYcXPn7h/bktRS65cMwYY+9zqPRl
         VQGMNpaWkTz2Zxt6DPQZYQ9LA9DLcmxCWvWeRTP66cKjSauSJCiIBzTd5kXbj1IGYno8
         +2RrDNekPxnoATWS2HJEYy6iK9RY4QaJ6YwkY9F3xEMuqQ7QZ4zYzOj3ThDHoPOhq6hG
         kQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817820; x=1794422620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q+ustpqBY7DSjfgzbH8b++CS0e5Agr/KMTfvnsggDvs=;
        b=ZKh6WuF3l5xrmt/rNfUn/Qct2SKZgmKVKtGQoQHG16PGey1oc1cpfHGofting0l3+t
         pzGp+CiTGCe4Do2eXzoJCm2wPdb/UKFE6/QYDQFqkAH5QJHR3DwEJ5Nyg7bwjdwen76X
         NjV/BXPRhk742kEcYP70A+j7pQl1NwAF7UFv+XpsRCf1wvg0di1XMIIo0Hz3XlF5k4XA
         oiFTs/JLFqRcgKv1ZfHBF0iJioDT09MAZMe2X9xOI/lH7JoL+DNig9fCxe1fjDelTvxw
         fZSYBlXJixkNXESo8sHuxB52KHzPc9+zDFMYnbzTjNkw8DOQIJtNx++DBnxn+kDokEBX
         USxg==
X-Gm-Message-State: APuU4Z/MKnEBGOfdRscmD/jpuNDCu5ydsFXaLxdA3skwsRclUK2TYjCy
	QfB5E/8pP3TJTrQQzD35REycODP4mVCvQAaNRtKbtvXh5x4Nt8kH6yDJRpMPID6jgq20Ul3KVIH
	/UQO2BQI=
X-Gm-Gg: AYBFou30DxkwiW4LnF5M4SFY4cW9rWtoclECo4qExTRpW4LV1OPQ/0LYZeOixAYRToU
	EoyKjBYLAUGqvKxiWX37AKyRgVJohi0q+DFdxMr9trLBh3t5Xrch1ouViSLrdkv4oR6Yx2Y9Rge
	0k+tpOHL9FJ6EMn6AZcaiuaJH0XXlBr9/qoBUmTiNTVFIH9gNBK4Hl+HU3X1WyY+VVEx5G/rrT7
	dvzf8H/8HtuqWiyDSpWEVtf6/H0MMSk6GIlqjasC/ZZu8vax4nDEtU1jGUDMO+q24hk/CbmENVD
	wt9IsRKV45GCnCf8kRZcXEFnGxDAICYY988mMMJ4Rrj34MfS2mhGiMtdYqa1nnAn02R4hMjcMLW
	nDyxtfqU+IWvB4j84EBVpnJMMn0zSEwtf3Fx9x/1kQfrxh+CXAJdcJznPC6q5UxhA35YzpD7hZl
	Vy5phONH2TthZZGBnz7uJOaEHLAmWBw7vSCNdWE/eKZAzVK/Xo8XzoOC9avLCuxTRKJbGcS6lCG
	wQwe6duDyYZcAStTidpfSE6ktTb9TKimlxMqCQXuy2s9wkX2Zmqxhp7Z22ahdtHQWFiYiuk/yC/
	9uNTXD2Rh0oUojK4xJF0zIIiMvFD6RzyE/mdtP+8Oj3Jr/rTHx2pIEZXgIlcPjc0y20Wh4VzVg=
	=
X-Received: by 2002:a05:6820:4488:b0:6d7:7d89:54fc with SMTP id 006d021491bc7-714f2aa2fc5mr8464084eaf.73.1793817819592;
        Wed, 04 Nov 2026 10:43:39 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 8/8] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed,  4 Nov 2026 11:43:28 -0700
Message-ID: <20261104184328.516206-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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

From: Cheng Yongkang <teel4res@gmail.com>

Commit 1c8b49851543f41fc8bb18bcd1f15cc93d14b530 upstream.

io_timeout_cancel() posts the cancelled timeout's -ECANCELED CQE without
advancing ctx->cq_timeouts.  io_timeout_fn() and io_kill_timeout()
advance it for every timeout CQE they post, and io_flush_timeouts()
computes the number of non-timeout completions as

    seq = cached_cq_tail - cq_timeouts

to compare against each off timeout's target_seq.  The cancelled
timeout's CQE is therefore counted as a regular completion, so every
cancellation makes an already armed off timeout fire one completion
early.

A ring with a keep-alive timeout of off=4 completes it after two NOPs
when one off=100 victim is cancelled through IORING_OP_ASYNC_CANCEL, and
before any NOP when two victims are cancelled.  The cancel CQE should
count, but the cancelled timeouts' -ECANCELED CQEs must not: the
expected counts are three and two NOPs respectively.

Advance cq_timeouts when io_timeout_extract() succeeds, under
timeout_lock and before the -ECANCELED completion is queued, matching
io_timeout_fn() and io_kill_timeout().  The -ENOENT and -EALREADY paths
post no new timeout CQE and keep their accounting.  Both the
ASYNC_CANCEL and the TIMEOUT_REMOVE path go through io_timeout_cancel().

Fixes: bfe68a221905 ("io_uring: off timeouts based only on completions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314078.648427.13761781546953594668@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 uses a regular spinlock for ->timeout_lock]
---
 io_uring/timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 6238187e7966..d793edae44a8 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -267,6 +267,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.56.0

