Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817902;
	b=AkxUdqdteBgGmGqQJ5xcHGXDRitOHgmzoKGATTxtOsYIjhwdpdEGa4NQHet12DQOdZSv
	 ty/BuO3hZsSCp4ek63QyYefbdC+MSLM/kA2KQEduFLezY/QFU2XKv+ef6WyMmUYOuLBsh
	 Czm9D4kLoisX4oplO6uId/xsjyRQfUybiSFbwN8aOUVgDzKYkV9pDA4sAFWG7mqrKS38R
	 v/xr5J/gWYzpH7eI9bzSP8s9HgJavrxMv8I3i6axNweLbM1zXYIGNfK6eo7pRCAfYthpu
	 gGcpUP+UweDq3wwnptj39bIxS/zKtg7uQPb6/kAx+WAxMevwNlMSKmZNYLuQRGYaiUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Ed1RBU6KSOPwmrvEGQdxd2yjZ9qjAAPrPeuqAImy58=;
	b=tMC7GhxjrJZ6BGaCUUiIvplklTk39HlpWQ38rwFd0SOBvM8yi6U77rYNrNnBhFqe7jWk
	 CFuqoGn3wsz0jOSEMZKbPSmiBaphBs1bq2mIuZcuCn12sOFMQFx3Hcg5cSas+gr7mqI2j
	 0PibY9pCI/wORgMpch6P2jCAEfc09/LI8CzG1vKRAlGe59428Q9NKyphCwYrmYzn1ActB
	 nEWpsP9GtH6ynCpJ+KjMUrkoNbzGNfAPcMlgm3Ou66c/v2lI5v6gCuCeSwvUO07HUd6ez
	 lohyKkEDDlfq3z13oXv4J73o7pONMLla85zv49fPEOdlwo+SzCT5O6pYD9OHe272A6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DPRVPfts;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED1606A33E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96ED1606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DPRVPfts
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-716c0217635so780277eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817901; x=1794422701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Ed1RBU6KSOPwmrvEGQdxd2yjZ9qjAAPrPeuqAImy58=;
        b=DPRVPftsHNk3Le59K6cFptzrdAbBztWOBl/xJAw/gfykRBgaGRezDJOKfIKHtt7FWQ
         TfTaddBw8o/HNkfllArRhlU8rtafjJyO3rwMpJMudOEEGzg7omaBDd4NKZbPzhJIT098
         yI98GZ6DkxEzyzPmWA44ImnQ/MAZsgzDwqeGc6Z54/EODJ0ElOZqTtE6fESOCZrjsuxM
         E5llMiD5Yp5GZ7wffhACu7WPn4V9VBQGO5T1KOssyrFIaGGzj8mPnHERWxx6tAtLQhio
         tca9gjbedQpd3+EUWRYaCQvi7EWISdujnBV92TJ1d8roWIBU7MuXgXGZ2bz/s28jKGsJ
         gjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817901; x=1794422701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+Ed1RBU6KSOPwmrvEGQdxd2yjZ9qjAAPrPeuqAImy58=;
        b=e8SZ7IfE/zXUvKu5nmYpXS9fI856K1Cb1vAGaG10XfpELkZ78xkPPVaRhNwqz2a6to
         vNPDk6xRl97sLB147UJxZGj5aJz2mu1B7lsLz7jFL6pe2Qyu1UKoPhqCsNmJ1c4uC6Er
         6T70HIJtvqg76q9EineyH4oCkQqifpnE9cCiMXH8KtEmcZgMsMqvGQz0WT/kmTfEdAYa
         bDdR2UpSlOmP/c3l5dw78HF4ilzXuumPVDufj3ZsUgkkcE0eF3ot2v1lP5l+f/0iXNg2
         vK43Xyv0cHyqxNXgFNEKLTsfObx12qDfkLrw0/gyA8CaDKjML6Q0DVggzto1HaB6kTwL
         Geqg==
X-Gm-Message-State: APuU4Z+l9lY8/ZBN+66cK7WKg0vbqmFSi6EMHV0qbSN0cnmTz/4/ZSnJ
	8/iNKsI+bAtZanojwlbYxRg0Jc1LfUW3V2sQo6jfcuCYASdj6dWpMutv8dINBAFbOMw7RUrDjV3
	ni0oTaTc=
X-Gm-Gg: AYBFou0psPLeJ+0ZcJjwwtgqFcNUMaWAfK44nngqJCOfSGTnNWjwXPVHJHQUrR8wiPm
	pB2ha1YiSNMEvDws8V3jByA4jKxKaN0WRyQBTn0g/rBm0f+fSZw9wltqCNbQtzfyCJgJGQX6Wtv
	CpQgB+eK7ivh3DdXGR/2yZI25Ev4hZKSkEHUmQUn7Ghq+CUBTStVXWrMOaCwQ3MYFD5O4a7GQYl
	ZHYUahdL9bUu8ATn5QFDK0tRscQbFpFY8aLAIjOTQ15bFGNT3MNRuhIG7SxeR9zWb4MRuZc7kEg
	z1DctScZJnFFwgAJOUWh8Dqoi/eXTOQOONbioP4McekZda6SThX7HK6TUk0qN+LgZuA94u9l386
	EPAS6/Wrkv3MEyVEBMjFxL1HaaYWhl6nT1yQqvXwkzPKHXXFWQg2LpRrCLS0E5NYsX4wBUcojnK
	qO+iQC2TUVorbbHSgPItsVWQda8gZ8PG3BETc36qJHIVFZG0W34u7Q/1lri/yKECIaYHjThgmlF
	Rmm6swfb40VlvsIbuvu6xH9VcVp3ywxGEdYam2FPHtqLHCQK5+vrm4NompuzE4DkpDq5g3N/hvu
	4RJVOPi2qv6rgWqj6q0TMli4m7uhZ/KYfZa+z4LwCq61f9PQxqrZbV7FqMTKWViM/KKwxmm1Tw=
	=
X-Received: by 2002:a05:6820:6acf:b0:6de:9205:845e with SMTP id 006d021491bc7-716d2130668mr238950eaf.27.1793817901168;
        Wed, 04 Nov 2026 10:45:01 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.44.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 03/16] io_uring/net: mask socket type with SOCK_TYPE_MASK in io_socket_bpf_populate()
Date: Wed,  4 Nov 2026 11:44:34 -0700
Message-ID: <20261104184447.516768-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Dominik Maier <dmnk@google.com>

Commit e66907c3ba229399ecfb4ef032b95a4a071c894e upstream.

When an IORING_OP_SOCKET request is prepared in io_socket_prep(),
sock->type retains creation flags such as SOCK_CLOEXEC and SOCK_NONBLOCK
until __sys_socket_file() masks them off with SOCK_TYPE_MASK during
execution.

However, io_socket_bpf_populate() copies sock->type into
bctx->socket.type without masking off ~SOCK_TYPE_MASK. As a result, a
cBPF filter inspecting bctx->socket.type against socket types such as
SOCK_DGRAM or SOCK_STREAM can be bypassed by ORing SOCK_CLOEXEC or
SOCK_NONBLOCK into the socket type.

Mask sock->type with SOCK_TYPE_MASK when populating bctx->socket.type.

Fixes: cff1c26b4223 ("io_uring/net: allow filtering on IORING_OP_SOCKET data")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
Link: https://patch.msgid.link/20261022232120.2537530-1-dmnk@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 4678f29f5177..ef455f1a47eb 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1734,7 +1734,7 @@ void io_socket_bpf_populate(struct io_uring_bpf_ctx *bctx, struct io_kiocb *req)
 	struct io_socket *sock = io_kiocb_to_cmd(req, struct io_socket);
 
 	bctx->socket.family = sock->domain;
-	bctx->socket.type = sock->type;
+	bctx->socket.type = sock->type & SOCK_TYPE_MASK;
 	bctx->socket.protocol = sock->protocol;
 }
 
-- 
2.56.0

