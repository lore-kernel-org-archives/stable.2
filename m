Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817842;
	b=LcUeBeVLfPaZlMVW7QE2d+N3hKxBkOG7cC+CuCKsKU7D2tzydLKdOG3N2xxhppNhA7FK
	 HJ+aZp3zXDXk8bJn+ANUTm+vJm2nJ18B4OvLIX/skApstcJlUmj1dmRqHDX+YFiTpcmJq
	 F+CX8lXWgHKHE7aSJTj+QXGHmyjLnc0S2hzI8KPzfX5GJl0NfKQ0zurbBAQP4xosPgOuc
	 APMjjl04w31uR8MIXlZrFrJy0LzFDrNt+LR8n8aq1xIYleVa/BpEqdwDuFieGSVI0GVk/
	 +HJWJoqn0cZ4eZBzrF2u822Pab5U53I+MH6ApfKch8HhWnVtQX0NdYky5ABodVlWOOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FLL6CHOMyYTJavlo3BYUhyKzD6gu6zD7TEkM8D93AiM=;
	b=TAWj35BxlVZ/TJ6SrR5kAsK6s+Uulj7sF+QgELciK+3CG66lStlGnFh8kHzdrolXt+tD
	 AUungr6wQL2GKi7mLK0TcyRSG1vF2YnO1jvY151WTuF6uUTji3Ve/czfH4ZI2ftLME/dz
	 4mwdfr9el6O4AzlCqLVKiXvRzAKkRVX+x6VArkaIhwsRstnH2NvHjwuvVHIpPZhhfhCm7
	 TahryJkIA2yIGU6pQY1cv70U3TmhuVeS/CGgklqw97XjHquUoKsRHUMec2DFR1DTYT5v1
	 Cu/PXeh5nGe1ox4UmJv2NxfoxmU3SwOF26LDs0ba45ZrMS11emVxzP6s1d17dEf6PEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EOJGpuKS;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092D606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8092D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EOJGpuKS
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71528ede7b1so734099eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817840; x=1794422640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FLL6CHOMyYTJavlo3BYUhyKzD6gu6zD7TEkM8D93AiM=;
        b=EOJGpuKSxaSOjIyYVM3Tujvh/K9hcelPHeZZ5MZre8V/l6VquNNwRSfGOsxx5Xn8we
         YX2tWIXF4zddt6h0DsrbGkEaKfsiHHFsB/4l5IsU7+YLfUikwyRgDUaYyy6gA+B1JzYE
         MPv9GRLnb1mL7VHKByW4pjVw4PNMY8tDf+TUdV0ZCA8qbdNvOraNjXEdCag94vzy3CwL
         ljgFbWGd2YS2Vn5Q+4z8fR/IngdTIXPtciHoH6kU9XA5UQVlW10O74AscDmkGC9kLe8H
         92e6oKhCwH6Sk+FiBNcwtgiA4kXUMsZhR/M3xPsLZLCGULrncmAO9EibpPuMHQ3kfkN3
         2kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817840; x=1794422640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FLL6CHOMyYTJavlo3BYUhyKzD6gu6zD7TEkM8D93AiM=;
        b=1X459S7eReng/ct9meo7BjZNunqFXe4E0kJDPwNh/KU2ST+h6BeTz2rRY7VVEy5yQ2
         c/C0Q46xgx8Zg8tZrMkCyX1MSzmLut/p3eLekGIfBkovlwMRmjkqnNOHDbZ5QgVDECPY
         bfv52LQDuKoafEDRnKJ9IGKxw18/QAK1ZcspzcmvSRI3Mspbx6bmBAbNUQ2uVJXsKX3k
         8x2cO7Je7DTuGxsBPVsQJNYZbWOQAQcFAPD5KPGpTFywDEzhS/RcDAkC5CZRKYGmnFNs
         oTk0HllajHIbDK5pZ5R0AA/SMO/DbGnWBPlJgx0Jvf2pmpizQ3A0RYM+WAAKxbFefIy0
         6unw==
X-Gm-Message-State: APuU4Z+xsOcfNlt74//f2MpQ3Hk87tn+cMdqGAut5aSx7KVLb9DYCLEu
	wJ6xIlAdczAzg9AQOyBj68HasjVbsevsu7M+T9RIZQvbuq/j2scYIKopFp24yhTrKwpI5x77f+w
	4wlJnDEs=
X-Gm-Gg: AYBFou3PsomyoLEnuVF75Tgt2l+Nfb8qbMd8M+oLEndUZ7HRl9Y+XX0cOZ6aES9DFtM
	tEWVGXWASVuxOooYdeod/YjCY2vLVO73Klu3Waz5vXTEzfxfq8gfXI4P7NT0VBvRrKBh2CVabkJ
	gCT4HquOA5JLsEAwzpIjWXvXIndPs7VEtzRaww+rBLpdBYwyVWvCwH1eSTw/PGjSReZ2UWmrJdB
	2wFDKNq7bvvKPDPsqwA2YtnZO1c3iEsaTVuGaTUvSt0qtFrmQEPv+PrVPfQlELk/+5pgyFDVdY3
	7ikYc067R0BggeoRiPX/B80rmX2LPqmHANDR+75O3n9AsZfJB7/mrN4J1A+fQO5l75UjPLyFnXd
	fnoV12f1qGj5PMBge+8w+T5UOoUImcAEIVjEPoqN1Rtj+raQfML0Kan5lF4B7aKfW951+fm5wza
	OWkMGdHxp7OVnif+oF4Sn1scF/qv2QT5Z5S5NO3jgqY4UZX5KgmlbgEF2WwxeQLZij4dtf111zM
	J1gXWs9RvqU26AdnJw2wu68FtSmm01grgiH+L9OUvOj/qjF+KaAd1sEDZMCev/EdQ/X/jOlOt06
	UTEIB6kpfKnXb7+KQADkmUm+j8wtQoI+AiPRQC2kVFUlJwQLXk92C02ixBw2IaBrBCJ7Br2/BDU
	=
X-Received: by 2002:a05:6808:bc1:b0:4f1:a873:6efc with SMTP id 5614622812f47-5640de7d17fmr11616206b6e.64.1793817840345;
        Wed, 04 Nov 2026 10:44:00 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.43.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 3/9] io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN
Date: Wed,  4 Nov 2026 11:43:47 -0700
Message-ID: <20261104184353.516403-4-axboe@kernel.dk>
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

From: Daan De Meyer <daan@amutable.com>

Commit 71537ed811107c514c0342e98902d489d6d2b7cd upstream.

IORING_OP_CONNECT on an O_NONBLOCK AF_UNIX stream socket retries a
connect that fails with -EAGAIN because the listener's backlog is full.
Polling the client socket doesn't help: an unconnected stream socket
reports EPOLLOUT and EPOLLHUP right away, before the backlog drains. So
io_uring retries the connect until the apoll retry limit is hit, then
punts the request to io-wq. With a full backlog, io_connect() runs 128
times in the submitting task and once more in a new io-wq worker. That
worker stays in the task's thread group, so a later
unshare(CLONE_NEWUSER) fails with -EINVAL.

None of this changes the result. __sys_connect_file() adds the socket's
own O_NONBLOCK to every attempt, so the attempt from io-wq fails with
-EAGAIN as well. That -EAGAIN becomes the CQE result, and connect(2)
returns the same -EAGAIN.

Let's complete the request with -EAGAIN right away when the socket has
O_NONBLOCK set, like connect(2) does. io_accept() already completes
-EAGAIN this way for IORING_ACCEPT_DONTWAIT. -EINPROGRESS still waits
for the connection to complete. A blocking socket still ends up in
io-wq, where the connect sleeps until the listener accepts.

Fixes: f8e85cf255ad ("io_uring: add support for IORING_OP_CONNECT")
Signed-off-by: Daan De Meyer <daan@amutable.com>
Link: https://patch.msgid.link/20261027-b4-io-uring-connect-eagain-v1-1-f4e3aaaa49ee@amutable.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index 43edc6cf13f6..c6512064bdda 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1811,6 +1811,17 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 			if (connect->seen_econnaborted)
 				goto out;
 			connect->seen_econnaborted = true;
+		} else if (req->file->f_flags & O_NONBLOCK) {
+			/*
+			 * __sys_connect_file() adds O_NONBLOCK from the socket
+			 * to every attempt, so a retry from io-wq fails with
+			 * -EAGAIN as well. A poll on the socket doesn't wait
+			 * until a retry can succeed. For example, an AF_UNIX
+			 * client reports EPOLLOUT right away while the
+			 * listener's backlog is full. Complete the request
+			 * with -EAGAIN, like connect(2) does.
+			 */
+			goto out;
 		}
 		return -EAGAIN;
 	}
-- 
2.56.0

