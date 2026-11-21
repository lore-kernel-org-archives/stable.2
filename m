Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296672;
	b=um8IvGreYpheM4fMw49HS5cH6E92WsJNKkMCp3bybL1QkjNqRsGEUAMAtWowOFF8p+m5
	 mqFoRnfDasKTcy23hW5RaiiIesqyzEBptEbHbFGy3bQSdmfqaZsoa7w33TqpEqr7szLsF
	 Dd3raLvja9AJ3l2P5B49H2sYPHGG9hJo2CsA3pn0NL6qimvbhut0FRNXuNhY5muLz5YJN
	 HzYnKFAxkVL6vcRscRWmh/wbr4vSMgckPpszaNuEoYSk9mJhzy9IYwDSYcoDLOLFkIXDP
	 9d8VgMWgoIls63jKWQ0hT6Ub3tbIlicNOBMS6mxY+LJJmPbz5+CiTok6qHGkXCYQwXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r87AXnhJRL20Dfhvc3pFQMn35AB0EEJgUdq/dBnLMmY=;
	b=cBaN4GaLTkJlycxwfADkowwM7Ce/EvGmhZKx57XQTuh6yXXUyQGo7RR3WShJcZykHe7e
	 FnGBPDx/pTBj98EheyXbud6IGjo17VxXRV0eyQ+ivlHokgG4Lvoerh3YKlgjPi2GPTSHx
	 cyKPQVmduiZYmlNVArVTL3+OiCSZqq6pV02zlZS2exE6IED64ZGdbCyiSBwpL7bVnhLnv
	 nR1xAeIOCQussZ1HDoeUYJpdAQOAPPGOHL1+jxfAeS2f55NMnlD4dZaG/zpWl+O4D44tt
	 TGlmK5QJ6rrF5UgradqT58IToYL58lFBkmNl1e+miZdsCRnp0DAIxlnCPCbkRug8u+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="YgQs/ic8";
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD86606A6A9
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD86606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=YgQs/ic8
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-702fd86d674so1402397eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296671; x=1795901471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r87AXnhJRL20Dfhvc3pFQMn35AB0EEJgUdq/dBnLMmY=;
        b=YgQs/ic8p1qiyQjfxGYO3n88/SfMaTgbBX0frQZdIjz7mlko/oYS3sSSdCULCJ5yYn
         eeZ3VWmCyPzInDfGYQ0VYT/1caNDiszWd6bNpy1KeLF3HEYvvqWgf3Y7rqteMq/op/yf
         Xcur9/4NHgMjLZsle/CJF7u5s6HC4BtjGNux3NkwbYVIfSMOzg/AWI5AKlVuJIa/X5CI
         DRc/x4e2tQuPiRE7aCfI113K3gekB3wOddaMcGujhjLQKyqdgGB+qS5hgmbYtW/PseN/
         Q3LCzSRFhjsBYzdBK95UbzKxZXgqsNyczs2W8xKUxC0bKGGTQNT4ZKG5AERFWmrgQlVf
         z0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296671; x=1795901471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r87AXnhJRL20Dfhvc3pFQMn35AB0EEJgUdq/dBnLMmY=;
        b=YmY5quhTABGXLic8AShsQ3aaPjK7OSbA5pTaM0qOAZL21QpnmL7lqutJf7g1QCoUWv
         /9kJWNdtSHhazGeoZxgi/3MUAETopythx4u12GiFrFH4z3waaqSnn5h2dt7GteUO2atX
         Alp9P6/8FZdzQkiPhL1qVENU0uRCJtwv160ZYD76kUsoruQgQdTZwgGVsKKzauX8tGOz
         d3B9pwSSOkkPgNapzpgelRW+p+xEma0x1ZGW1Eo11ilpiC03sc80fgVAkCODxMvcCMnE
         MdxUddsl6NPp2zI5nH4ke6/bf473RMm8UwRCPHlYIT5TcspeB8KDouR3k2WPFnlZe6JC
         JDYw==
X-Gm-Message-State: APuU4Z8YpyZZdmin6r3oV5TX7gxJyQaU0BB0zwBvZ/cbMG78fRhmADCb
	iPtoMroglRS5byrNAMCNvi1vVdNXyH6lgBbVjXXsx/ye3C8nbMySZb1DNwNAMx3wgL1+Ij1X46C
	9HpuBgRc=
X-Gm-Gg: AZFdTZeRkDVCsMwbZpnLLMNGC8J1RMr8juoCFCKzzLMgTMmvPjyOih7GdfFf/IEmqOF
	zmHunWLvYfLffb8ffvitaARlL4oo2G82S8gUpqgk08Sb6OhOmU2ID23cmmTZQUPH6n9yf4DC2xG
	ZOixM/D8ogmQdfoDjWeW9o6eYnGU4yIH7UVr7Nfj3JKWlXBEzByG9nIiMPuimRhMaaDwubUjely
	WwlL1hPf1RSFBe1ah9ix3Pl7v0kDwI3A7ij7DQ1yGF4L2W3oKo4Nt4sJ3c0GX6NbsyYucorCq2T
	Pf8x6jahKbGW1LQrv6FfsCORJit5xgvjlAVYJ/QiVqXOEEng0ej5s8v8eEPeTqxtNFUsd31TXOz
	nWUMYCHnoI0ABuR69WRsEU/YhfOid1ii/+hnfm8+ScUPlOiF7hFLRWmPBIZw9Ot6q3+hgwJNEA2
	e55ChFEBw4QRYHPv1ApoaLOE2wQJG7RaeRYIrqE6JjSPM6CZuTMZZsbg9w3skmdb7KJ8+SHT8bs
	IjwcIxS3MldKfENooFmYbkDEOpSZZJkGSJugpaljk9RFT64mZuJRfp5s2L7H8CIsVF1zk/TAdId
	m6gpouAZowi8kPWZEMk5dV7wPLBT1+JtUtJHCfAxiMSm4ioEN9juUX9t//0coJE9QTOO/ovWIdh
	9vGb68x2uVSJdv5Jh/Phqz8bKvbqocf9AFPUL
X-Received: by 2002:a05:6820:4185:b0:6b6:c3d2:702e with SMTP id 006d021491bc7-71b392991bcmr4812986eaf.9.1795296671088;
        Sat, 21 Nov 2026 13:31:11 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 15/19] io_uring: don't touch sqd->thread off tw add
Date: Sat, 21 Nov 2026 21:30:45 +0000
Message-ID: <20261121213049.1788332-16-axboe@kernel.dk>
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

From: Pavel Begunkov <asml.silence@gmail.com>

Commit bd2703b42decebdcddf76e277ba76b4c4a142d73 upstream.

With IORING_SETUP_SQPOLL all requests are created by the SQPOLL task,
which means that req->task should always match sqd->thread. Since
accesses to sqd->thread should be separately protected, use req->task
in io_req_normal_work_add() instead.

Note, in the eyes of io_req_normal_work_add(), the SQPOLL task struct
is always pinned and alive, and sqd->thread can either be the task or
NULL. It's only problematic if the compiler decides to reload the value
after the null check, which is not so likely.

Cc: stable@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Reported-by: lizetao <lizetao1@huawei.com>
Fixes: 78f9b61bd8e54 ("io_uring: wake SQPOLL task when task_work is added to an empty queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/1cbbe72cf32c45a8fee96026463024cd8564a7d7.1736541357.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 has no tctx->task, use req->task like the commit message
says. With SQPOLL all requests are allocated by the SQPOLL task, so
req->task is that task]
---
 io_uring/io_uring.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4c88bd805b8c..3108af4514eb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1410,10 +1410,7 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 
 	/* SQPOLL doesn't need the task_work added, it'll run it itself */
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
-		struct io_sq_data *sqd = ctx->sq_data;
-
-		if (sqd->thread)
-			__set_notify_signal(sqd->thread);
+		__set_notify_signal(req->task);
 		return;
 	}
 
-- 
2.55.0

