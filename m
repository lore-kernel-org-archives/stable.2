Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296670;
	b=ePh1fQ9WTeVzegjgU5C3BUOinOAfY7VwIWOsxCzUyGJvVfdJfwsuqlOwvvO0bd0HmPs2
	 EqkTD6EPjdATbQcdUPtHbo5soNC9IbhIGEn/ggdFgZRVGbNTb0OztXlclod9xn/zFOs8j
	 HQ5UJavAxlRRq2hWsL+vPrY9XPzhb5fB85oGkdlhswJAV9lL3YbArseX6TBknfefZnIrk
	 TIFGU+pSRjWhRM5zJr2ow/2ORsXBy3ntbWR0Z1By8+RSHVMVJ7cBTF9q2ptjIl5fM17rc
	 0sqpx+2OI8j4TrNfuEF+Q1VMGYP1xWBO4IU4xwTP0+JodzPiESqj9bCsvWXQQcbZUgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=voK/m/0LjKsE69Vx8vfpwezNjXzx9PXLhXcwUwPwAtg=;
	b=f55Z6QE1CaDqWjLwSd1MMNYlJCW3gJP2wECu4ZD6HYkx/TPzvVDsbU9KTfxtE2TB9SZN
	 THGkMXe3/hcd9LUJ1VI8q9WvH95CrKVFnYcekigbfnjGVCyWo3+GW0uTJoFPlPUOCZFlu
	 nmoZaUiVANW8C3awhlW25e0MDogxAGtQl9lm8zCe0Nh6hFjbW8EmrqLofbqFvw0C9CcNj
	 XcHw5PjpRSDBb41gd60sZP0zznq2RUytxTi3gMUxWEBJutxwe8A6PijRAsAJZt49TGeaX
	 Z85vCmf0ejm4XixUSu+wrX9wTkMBFjEdCcwBcwHKtIQevs5sBfoPeUVYC5giR1O/caw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=zcjwQcwz;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD8606A682
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABD8606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=zcjwQcwz
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-71ac798b8bbso1374215eaf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296668; x=1795901468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=voK/m/0LjKsE69Vx8vfpwezNjXzx9PXLhXcwUwPwAtg=;
        b=zcjwQcwzbaT/2sIxdkhkDuQ9ZRyMcKQAbLgvE5mtDbV6pX6ZnrxsYrBbG+jEc4STnr
         mw1729+MQFJkslmoZSW89xDoSCm6SxFpcsA8fZ7z5nSED0GdbL3ZHWbX1LGXeFshtgvV
         U20o5qNwVmuv/tSLhI4YSAe2E5Bz3vPjq3+8nudasw3SK8FjOEpDRJX6mA1X2ODDLuIk
         K7j0t/G+/gFC0ygIYPMyQnJXI5bDZ64jUP9UFBI1MqblCFAWYgITbJgTTFNq20YDAKDc
         1VaSbW4oicths/wYX95TGRqJ5kO0HiJpKQ8QISJr9kw52GXMFHza0GZ2TQ/D4qL075Bp
         DxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296668; x=1795901468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=voK/m/0LjKsE69Vx8vfpwezNjXzx9PXLhXcwUwPwAtg=;
        b=GX9Pio318v2q9/eWApYJTICtGFakjBVLNSP7xyQRBKFKOQRtyYkfAExS+Kn6lU1rtS
         7D35gaGgioZfCllbdcy18H5kfbyJqfDFg3ukFFW2+Hqdo2FEHGrMMCpMk/c6mpo12w/p
         tcZEeVLPEG558o7Fwx8seGDTm3aGPfDK8OycN1QNrRuAwHSatRuN/WgIg7QOd+pHrB83
         PyMlJEsP2x5D6zkHwvVbNi5HJ/RAr4ZXD7V2xA3w9/3qPk5K8MbHFK+tGf9W42SZPQVu
         /yJYd9l5A5+AhrRMfvDP/CxjEnUF9FKMOmai3LaBxFCq8/NrjoY8l+aluV2W8vMHoFKn
         Sg7A==
X-Gm-Message-State: APuU4Z/CQiDr1QVRIssjzOYUv7apmYWH+DSEI3gim1Rr1uCaav6tV36H
	O+nvm2GKRwLc/cJpxLeLLWBz+4bMEVXBpn4r8wuCAgUPOMPapjMhn1rCLHCjKwRtyulhfQT03tb
	BFcxucMg=
X-Gm-Gg: AZFdTZewSM/sLMoqRjH+yhY8Q1KS8NrGE3nuRgne47iTRL9dkdWWKUaMSmXVmdecEPk
	n88cKIybmL85lx15AL3SFmU4WbAi9ol/Wb8/C0iZ+5pG7fCrLsvtCWTQeCn1gK6kPd/mdKFKbjM
	UCgj1OXboShzACKJFJjvHycGk6JtZue453W/XA+sCGuQk/U3OoPvId0CxYzt1StgHzJVP98R8f8
	NxAkKX1REcHTHExw1uL8e0dgZ4ZtlBh9PrUDb78AVd4TUEUhz6OqNjBp9sujQSI+LTlLU3V8Iy2
	WGwKv3KII7P00Wv6nVX9FW3LcxLQmtHVh2pzYkan0Ekq/NPYMCuYy49Sy1d8b8u5Bdfd7LdCuNI
	zstAq+G2k7G4Y/idOCEi4s960Ls15rCO1GBwxL4x2K9UxA+HpXjNYkQgu+1fgH9ARTx+h6PHJ1L
	ZlbmqKYv2V1oPMLkHECF9SAPNa+NEkqm7zxYvSntm1KOnXr+XdhHk7AZ+XAJEvx7VvmUcczNUZg
	j23+yhKeS/n3MJNiBbgHY310jntQG3CkYu9+eXxG+HYJGp+/2cEh4lfoyN5xCln/7TsvNP/Z6IX
	aF7phSHIMUgWFUJF1zHxSFBpEAfv0W96GzK54GcSP2HEt10QczLKmZKgnTQrPda4Q60s1H7AytA
	gCQ6/PnvmUhWZF3VDT07TQna4Nrv9FTAEP8k/
X-Received: by 2002:a05:6820:8597:20b0:71a:f794:49a3 with SMTP id 006d021491bc7-71b3961a87emr3997419eaf.73.1795296668566;
        Sat, 21 Nov 2026 13:31:08 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 13/19] io_uring: signal SQPOLL task_work with TWA_SIGNAL_NO_IPI
Date: Sat, 21 Nov 2026 21:30:43 +0000
Message-ID: <20261121213049.1788332-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit dbcabac138fdfc730ba458ed2199ff1f29a271fc upstream.

Before SQPOLL was transitioned to managing its own task_work, the core
used TWA_SIGNAL_NO_IPI to ensure that task_work was processed. If not,
we can't be sure that all task_work is processed at SQPOLL thread exit
time.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 895011a3d8ce..4c88bd805b8c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1412,8 +1412,8 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		struct io_sq_data *sqd = ctx->sq_data;
 
-		if (wq_has_sleeper(&sqd->wait))
-			wake_up(&sqd->wait);
+		if (sqd->thread)
+			__set_notify_signal(sqd->thread);
 		return;
 	}
 
-- 
2.55.0

