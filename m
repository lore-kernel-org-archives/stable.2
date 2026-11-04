Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817826;
	b=DmgYu9UDFPgkC4CJlxR6WYu0tJMB3JhxRut/XAzXC6D2V5FwyV1tG3OT18NBJS9skBm2
	 ZXfKU5eXgjyqxknzXXGiTGc3U79x0GkSfz+5c4nWFLx9n1HL6PIDd0UpthJQ69WFaJYTG
	 EjR5xnTk4JSRtc9n039jJL7u/4wD5LAG6Jwer7iTXditqj0GO9eZQPfwB+lsPDOoZT0uT
	 AV3Sxd+vij8GvnbDwlMpYc++sk85BMFBp3ZuT+nEBeJspBnXyqPPtSdF01p4yZD+W1YOE
	 9bXDdPc7Xy31G0O+na5Tyj7TVBd1UqT5NMS7rz21N756e1+ADT3lTApcmkf2eCx8QXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W9CV8nbEdr92gXoeTWDjDC0tg+tmLqzWnVdbsIztbpw=;
	b=lhGv+XmONCSN4tbhp6LpCTolBYRXqW7WmaIa3hM8X8Rew79EC+IPN4nhTp67CWOJZWKn
	 M5jJeswlZFAiuyIYdhQLZsSFEDrLznA6haBRY/3dJDE5pf4/VsrSqdtPInTzeyKQd0nSK
	 R6E18xD9fnCszNoZ/yBX+azVeTZVSMySl67YsQPhxHmt/bokHgNZeBG+WDt2y6YqmZ8OH
	 QTsIRY8fQ1WKpX9OKWMjVeseUfXIMPfOwAn6syOrRNPKduJXN2hncDLRWAcZ1HXrI4Tlc
	 AW3Fi2OLnQq4+Q1f78C7MUv2HUcEJsGv0lpHQj8/JRAvA1Hdq1RzW14B9hXEszIlNtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H6BvCkGt;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93D606A33E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D93D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H6BvCkGt
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-483d290f398so686374fac.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817824; x=1794422624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W9CV8nbEdr92gXoeTWDjDC0tg+tmLqzWnVdbsIztbpw=;
        b=H6BvCkGt/LkwLIoup8aW1Y2vnTyIXBq4dFPOt1S60/fClsAibMzhugVlheJV5mcu4K
         PWXLYfmhx6YTX3KjriLQE6u3mMZ9F4B1scKrS1yHIsEWZeVGdALX+DtorrAInmB/dT2C
         fUkKDg4Ioi+gu7aJmPzzQ6aESJGMq3h+M7+bfWYANczVHpe0cgz+Yco8fSnM8tLiC9E4
         1y9TNuZEKLDiAsEezRSQ6wEfX5ayot07ycChsAKMPLb6d6CMLipZfPy1kq0OJKMsgJ8i
         WB2FW8Ek98hXZAacL78stLYMlk8CbB35nPjItMtMUR9VjU3Jagg2weePsDE6Iqdd+ExI
         6s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817824; x=1794422624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W9CV8nbEdr92gXoeTWDjDC0tg+tmLqzWnVdbsIztbpw=;
        b=ClEFuYZznXDeDPFm9e3HxEXRlrSR8ipEippKiyv6wVAFHjrKf478cdoKRHs4NDhGTv
         F2NxKUFwWt0iVFHA1IjVkmKVFiXG2CsxcIZWWljux9OBJXpaw2RizoCzfSh0xUeCSDFF
         YFxhyCRSkeJydsFowZWZXrA/shC6pSBCYL+iDLNNOccWZFPxDglZli6RkxkUIgHdpnfY
         lY36sBoBFyZqszMHhXIWPiUHHidqrQd6Qp/4jFQBEBvCZfDX0zDIu8pTx2FSelYSAOEB
         4G78tA80LzZuMwP4Am+kFwy8rYysOjTL/D7Q+VQyLKfqdzzrb2nyF175yzdKlHzXDppg
         SwAA==
X-Gm-Message-State: APuU4Z9SG/RkW2aBJJsloVDG4ojMTakyqGFUbY33QYLAx+O5Btcgu2Ut
	yQlu50soNebivNBIvipPpJiSDeTukL+kcDdG9Us9ygmz++09yc8gqwPVGNHp0qJq8PZ1MfwdZpg
	jUdkXc/k=
X-Gm-Gg: AYBFou0AX6KyV+I11LhTbAvutR6PpM77mt0N+IYxrc5nLugfICoePiBe5uKGkcJCbC9
	mP5k+djwGM5QbCpYujXo0tsrsADTB3+gDxgyi6sQ5WBOhUy7DrYDYgQuyq2iO8fxRu8pI8TfsY/
	tDB6wYUPepXD+QqRNyOS3VZUo8JOvc2fVVIWVcjA8C1opDTkQUyd3hPuflI6B/xf8IwDbO+N3uY
	eJLkO6jVRwVscQKjXBOuK7ooM/dTzDG4LkvgqYRRU9Hqs2AAYXv0e/ivl5qwo3kUHrV9YlTLICp
	/LXKi29es/BVGSeQJ4m5ll2xEYqJS1hqAhbG6P/yjAw6c7ufam9vVXKY9K4g5OIb19e0lbQc7VS
	xAeouXrnxSEjnjZ0/ALPd5H0fcyALgECrQp1139cQVlngEJjvagb4Ow9dFXm190uHyLlRJP2V2X
	uPjQ1Rpllb50o1eLXpPYRkoEpOxqTchYUdv57u3kFUbLpELL37mct0xoPfq00eSZDdSlKf1TWtQ
	ceeGtSyDU3PvV/3LWnE3eG+DtGBPU9KT84yAJBTlNbfUVibBkyZfut4RUZXcVr92TZFZ8hMEUzE
	myiJB50uqT39S/oTNQt4boq3tVWqDXOqKvvEfde37kTfPycOHqwdIO5ZCf4N//S+zDKpOH1UBA=
	=
X-Received: by 2002:a05:6870:1d14:b0:47b:df9f:6c0 with SMTP id 586e51a60fabf-4a90729b9demr11296325fac.4.1793817824481;
        Wed, 04 Nov 2026 10:43:44 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/8] io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
Date: Wed,  4 Nov 2026 11:43:34 -0700
Message-ID: <20261104184341.516297-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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

Commit 18d3f56eb6e6500a65d81cf265f0fe74fd9ecab6 upstream.

io_recvmsg() takes the transfer length from the ring provided buffer when
sqe->len is 0, and such a buffer can be up to 4G. min_ret is an int, so 2G
or more makes it negative and the (ret < min_ret) block is skipped, and the
oversized length reaches the socket layer unchanged: an empty socket then
completes with 0 instead of arming poll, and a short read is reported as
complete. Clamp the length to MAX_RW_COUNT, as io_recv() does.

Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023112209.87979-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index e7f8a79e049c..bfb128ff2333 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -857,6 +857,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		buf = io_buffer_select(req, &len, issue_flags);
 		if (!buf)
 			return -ENOBUFS;
+		len = min_t(size_t, len, MAX_RW_COUNT);
 
 		if (req->flags & REQ_F_APOLL_MULTISHOT) {
 			ret = io_recvmsg_prep_multishot(kmsg, sr, &buf, &len);
-- 
2.56.0

