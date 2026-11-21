Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296691;
	b=nbRVWQCORV3uXLz4j3z2JLwkvVnAhMTPSuHIQFemyTJ331wtR8oYVVzazXy1p1sQpnTC
	 iX0KiLj0Tjsu5WEn6dQNqw/9vK1fIBPE54j6fhOVtOvw2sB0P8XcYyI2J0c/quqBmvjNJ
	 rV+IPhhoyLx2vC7iC2SeA+yJE5PRLRUlXe5Tu+S46KIm8Y510A3NT+JDz2UZHYjBR9/gs
	 ExL1peU8jkV2/Z3Sk8NNhnvCWRf3AykIXN1TtP0RO7A0PF8lKaAabev4vmgHnEUoJXQ8i
	 NJbI+7C57nRLWKq2n0eWQUKcNPq5ruN+R+VyfvmqB3vfkxjRyhv1yhFBvLd7Gd3MxLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6V5vz2y4N/rXzwcprT+E6N9DsnvTudO+ZcJlXZDl3fA=;
	b=4IhQOgjpYn+0k+uQvcfq52VCzG/ce56abSmdGT4khOPhNqDQBFVrDEB+bYtJMaEGPXtN
	 3+jUNpNeHF8skbStEgYyCt+ViL+GQGujWwVVHkk7a8Ol47mA7tf3Vxy6TVX+YUPWXSIi8
	 +2vgfVQil7/CAtK0V+pTXjQYGf/tGuPGRMAL938bPrBgCsaZPnKJwc0YA43aO4i2lLYx/
	 p6OrEsBPe0Bk7vWPea7Sy5/Sutq7A726Q8j8t0/BlUccjHOsN8cUJGSd9agaPUAlh9CiF
	 mN86O4LAmMs0mf2ruDO+iywKpwZrzHmNEKEMMwNG0ByyQUeq/GMpuz/1EDpntk/7rrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=xFmd6pYp;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F9606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=xFmd6pYp
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-862df509d48so1646283a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296689; x=1795901489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6V5vz2y4N/rXzwcprT+E6N9DsnvTudO+ZcJlXZDl3fA=;
        b=xFmd6pYp3MQ3OHgXmbFAUf66i9s6WSxvaLeFMiqULNsmovOGwIQ6bSXmVHCKnWQ+nA
         nddclUvOLHU/f1omxXbsJyKwRrriv9q+8S8SnzjO8I4aE3oFfT0f37cwnq+BpTeHfn5d
         UiRg/56swNccDprQB+DNbaMHUrkaK2Kl+3e47V8f0Z7nMr4uZQUjAfY04sPFdLvIV7c3
         lVS31BNglSViPaw1/O962yuUtRrsBjpEK3DEVCEAuVhIR+7jkhGecbbU5Lf5doOiTZu2
         aRnErBytUJeQBELrbdjQ6le0nvz/RjQUQVRzkzY4mFcd1ZYubx1qoT4E67UZnD09DTXv
         W5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296689; x=1795901489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6V5vz2y4N/rXzwcprT+E6N9DsnvTudO+ZcJlXZDl3fA=;
        b=f+UqG7rj8FnDJhsVmbKGvgVagPl0jpdU+CPK0Ykz/b+Ycv3VNB5ULFdJMXIyI5r+33
         RQlmdMHslVx8+CWZEdjMFcfSyuUP7ivEkDLHU6bRunCminOxFrAYgV2l785za08zHpUh
         KfrGISWaeIRb+TTAb6cby5RULonVZGzcMOTY9EWecGnj49J2niwb1faVY5TrVlyOdbMs
         +QXzf6zS4gSLjt04pYIoXGd0JAhfpC5DGaLR05jQibHlF0l7IlDwM62rMMmXWx5XNckG
         qHYjTFxAHks9vjySYAknHGmNsqmrS94dKsONoQM64DBpPW9Wf2//wS2gJKSgzv63WLo9
         +eyw==
X-Gm-Message-State: APuU4Z8xkgOaYvuqgTgUcXeuxM9mh5RGPRhCb5N8fdtEveGfnYlOTUG5
	wE6geARVM1Biz0SjndXamh+KLLhFUICUAHd/kmik79J4EQ5XIUQh+YMiuz5MbEhIm8ErgLEucMe
	vVziBa60=
X-Gm-Gg: AZFdTZecthM+YG9JHFQGISDjgOQtwPTBj+etRUK1vFsworgDI1QtjpHfotRdfnDwSjc
	Hm2ewRg2D2ecAeAfjd8GBOJkFUTvqaZIiWMLuiLrehjBSa2aZ903BmFdnsdnKRrk4c6O3p62MEB
	idt3BgOg5qjJYmO7CRmu4hJYCzYRoNfN9SB/r3upVT/uhWbNkoiFjI8S8qYVxM3ZHJ1bGgpDOTr
	3dGNgELOYZ0WwaqVBfrEn9LoQCaT55EDTwgOTX5B3fa6ptqotygTLv3JcvnFFtvWQ6Tb9YuQ0uS
	AbnNJr1NuqZBVM/JabccfozusdPYvCvkzfiHrPNCXrEV+3mNvGOE9OGAWD8hrgwggpSrPUlguSW
	jLqR2eWK3NnJn0U35c4Jdg0sXRbVOjtDxT49BRyZkQ0lu9/lygoBPN5J5autzLu0s8s3VQ7GvPi
	oUOEw/APlptpFj0bPkz+II/L7g7qUN3iUm4878WPU3Zq5tfDOwlGG8nEwMRA/0UsONYL9iRSDNk
	NqmkbfsDyTsRMmnaV8KzH/RZOjH6TaV302cYmhAfm0ZujZG4ugKxZWTMEInBXI7n32BgYP2Edc6
	aXWruszDrTqAY/hnNNZDBxCLuFdIfIq80hEPfsKFfEAFMyI8RgSF9E/FAs3EhDZ3Lh+JR92oB63
	1/cMgclOoq5grucECw9C3Q62UZJM+c14qwP3h
X-Received: by 2002:a05:6830:3491:b0:863:3892:70d3 with SMTP id 46e09a7af769-86338927828mr934142a34.14.1795296689645;
        Sat, 21 Nov 2026 13:31:29 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 5/9] io_uring/rw: fail soft links on IOPOLL short or error IO
Date: Sat, 21 Nov 2026 21:31:17 +0000
Message-ID: <20261121213121.1789042-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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
index b18b10cdbb52..688ce923f6a3 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -553,8 +553,10 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 
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

