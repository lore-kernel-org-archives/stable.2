Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296723;
	b=eI20U0zos+NY1b8eC17XK+loJZd0omKNeVcZkMzuHtjqqOfMSvCqfVXsK7XIHAnTVrmw
	 nYFz/nYwr69c2F8j+gmovOMOKARz6j47HfqYkPxdmDRoOGtWvHYDBrypnBCSGftMyCwQf
	 o/BmOkMMRI52euRvuIpMb9SEaUoexSM2xPvykUZI3x1q3+SK87v4mqEujEnGxMyRVFZaE
	 QBzsuyUxa55gaZQVSOmCVJohoc6BOcchm44pgwyArwh2tUo9BgaWgQVpi7oti6W/DEvOP
	 8hEUGcjcDE9kbAxlpRwskqKM75+iFax4WqlupaXhsydm5Ip/ITelBTroQYTkBnv4gtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N0L1JWKyg1uI3aMZ/eOzFMbsNupL/wddHz7Bzc0rSgQ=;
	b=h8Nl+v5l+oO/wDHGnyPlyuoYp0B7mV7ISAwjaXSMyKcIC6oqvnrVIORul7MtcPnJTteK
	 AsvpsnUZrmOXqz+K9VksleuMzYZGNsyTXqPAt6ku4OqFXiEJGGmbPvq+e/vKsvz3IFT7C
	 qgXt5FrLd5xJsN4LSi4YSppX9oUmovBFpApc762IDlaIVA1Gj6Pbk20Gci2e9STDJrih0
	 st3QarwuWdEhhYs1hAjCMYwVrekXs6F/6SsIiiUqAUNQcpS/7Qhtwn38ma8QxToNBW1Ob
	 pJA6Ep5IBDRnVRR/knqaCPcJ8ePUCb+el8AxKqd7Ht98gNJyNd614Pp9uqTresh+wgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=aXrAoTKV;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D795606A683
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D795606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=aXrAoTKV
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4ada9579947so1413266fac.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296721; x=1795901521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N0L1JWKyg1uI3aMZ/eOzFMbsNupL/wddHz7Bzc0rSgQ=;
        b=aXrAoTKVi1VuqVt4UW4Q6knueu5JTxcLD9ZGrZsFNZ+WMB9LL1rSDKDh1je7Hmhf3L
         ORz7TZD7AEfphrb4ICSm21mHJ/nGjDiUzEZqA2KJjV7pM9SCGZMqjXJpJp9uhbPjnyiG
         pADRgKi7IX2ZnrSvTo8nRH6N7XmWdXiOMX/4chKF2WXj7QfSY/KWnzb43rVxGqn0eZvF
         I/KEsdCscGppCBtqpyGR8Y4nMJmK6ZgelYQ/F+mUxcuDdA2s+DwuNoBoznkzZ/jCHaPL
         lbnN0SiUq9kZ6PK4cX1CJcp50vH63pnUsxGPb6/rBN5vOd6ZZBtH73bNXQmD6CpONRA+
         F+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296721; x=1795901521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N0L1JWKyg1uI3aMZ/eOzFMbsNupL/wddHz7Bzc0rSgQ=;
        b=Um3o/Rmin+jSwFeLDLwxkQmLIUTS2Sit/dnMRgKUe1I3Ne+G1iBMHE9T7xkg+vnZaW
         DywKXjssRSECcP5RgtZp4BcCVvU8zLY0seWKQfAvHIrKXpqsPXIfyf+8bVpHW6ydOXHv
         mSes29szd8tri/b9DHOGISfyaQUU5+QZJzlaMhFNpXe/hkYdo5yXFXn1tMThCF95789r
         9fbwWe8jTjD5X8L6J+oMPinI18ZVspM59bPJMqdMJ5JGt6ZAdr62KV4ggtWvc+HOQWH+
         zzuFlY7K0GzWDAAUJjKlyeLEjlRnoFYIxmNVyOGtd1fD1tiPB3AQSLQn4zF3/88cT/9m
         sFZg==
X-Gm-Message-State: APuU4Z/y3iKIlBJK/cRc9OdTXE/1mDasDcRGfrCAqSqFceO/mdPeRLHg
	kLRfCNtKj/j0A9b83+1goqbndpbuXcxeJWTkHtpvTOa9rSHfj+UHjGOWoJ/ixrGPCuWZVgx8iLs
	2vGTKjWY=
X-Gm-Gg: AZFdTZerKAYUTbYgs6vKd11V6cy5hCHt1yTAqRT5tcUHuX7vaKQ5DoFZB000KnnpDX3
	tHtzW6XCRCFMOU/6SqPa/hYh26U2lrfN2NT8GfySSMOqL4LH6Phn7p2cZnXZCB8mu6Alx6YN/8z
	0B9Xo//VgWr7OlFpmbbnekOGbpYr3urhM1x/VndaWRT72BJKuxXwzu/9i/aDrh/27jGrFT593Lr
	cr6WPeZRSCJTDTUuFZHGNxs9I3ZrhqQY093RBz4uOXTKNFfA3XYQNQyK1ZAFs3iMPHdd6qEF1ir
	xSgV29+P7Br9xYiQXE6fyBcgs7Xfb8qaZf+UUcYOW9uLuA/0dk62faNe9ce0UMT3vJUy8dy2AXu
	GsE+UXJfjDpCG6B5GJ6va81Z9Y4e04kTLxgolQhoRV/oRrEwhw9s4kKV0cn6xOyGk3MZSf71Ula
	tIjcAkdGVFmuzuFkuGhyNUIwz6c1iFtXmfDWgVWjyJ4KZGxdA+Z/t07oymotfhCGXDv1eqwxHXz
	nCHp2RoZQlvX2Ki/FdZ2z+GBrpajeEr2D0nSDoAZ4e0ZkH9Kol8cnDcRF5roMFLZ649zhB60/0r
	iNyHhq6lLYEOEOQJf5zU4vZPDXJEvZNAHktD2xx7GYt/UHICh4qPPaQCYDWcVwqMacQ6rQTA1+E
	JgrLCBIWskUTkAup6D61+l+3octWj2IqlSHxK
X-Received: by 2002:a05:6870:b50f:b0:48f:e107:3175 with SMTP id 586e51a60fabf-4bc8229d4e3mr6830731fac.40.1795296721379;
        Sat, 21 Nov 2026 13:32:01 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:00 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 4/9] io_uring/rw: fail soft links on IOPOLL short or error IO
Date: Sat, 21 Nov 2026 21:31:49 +0000
Message-ID: <20261121213154.1790334-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 4d3db66c5363dcf42c3d43ebaea330ac2d1888bb upstream.

io_complete_rw_iopoll() updates cqe.res when the transfer does not
match the requested length, but it does not call req_set_fail().
Soft linked requests then still run after a short or failed IOPOLL
read or write.

Fixes: b66ceaf324b3 ("io_uring: move iopoll reissue into regular IO path")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-3-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/rw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index b21daa3cfa5c..0426c27f3c4c 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -603,8 +603,10 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 
 	if (res == -EAGAIN && io_rw_should_reissue(req))
 		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-	else if (unlikely(final_res != req->cqe.res))
+	else if (unlikely(final_res != req->cqe.res)) {
+		req_set_fail(req);
 		req->cqe.res = final_res;
+	}
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);
-- 
2.55.0

