Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817827;
	b=IkSYUNLmcSuIYI0rQP6y5PaQ1wlYATLC1g36yZ+Qm3F8Xv5Bstzyf8eALIlBb+VpQ0tt
	 swu7BrhHyHzQsCjBSZgC22GGqzvh1CMipMAKJan5YfpvsuMnxmLtS6D9Fz+mVh3Y5KPss
	 y+hW6oQl07iwSMpzBQhzFJz26HWUAv/4Pn3X8xdGQ/vueVZ4PfPmRBhwaH9B8/3C0c1Yi
	 9jBB9k02bfhB3Ji7+9ZfFAelsITZyaEF7FBQF/MS1d1+P8OESuvELVJUXUuV9L0OUvaum
	 bqkfhFnhRgtGRyoIPdPY8fy9/OzQWZ33N8UBMHwN5sL6LHJOVeL/2o0jt9UT9/K43VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u0AXXfcqrxPIDV3H42pcRHxW2tMgCwJ2gAOzkHwZdCA=;
	b=G67MB0LIbqxpNztdB1Gh0luSryV+vLNMTc3n/2ohX52ZkalWdRYhwweGQYTeKD4TTc1F
	 EVT8cyj8WCya7H9YA+eYddfH63e+azjZF1I/+/SavkZJ3FLA8QPUBvIdYIM7zBc+mF9pJ
	 5B7d0WB6t8z37Je3Y5RkhKjswlpN5whqa2iT74CuZDUvtBdS6rr5k+EGD/wDgXOd7g81N
	 QoHnS28UzsDYLzL1b3Z7X9g5ivg6r6rFBuU/fjlJZvtB3igHkCDVnN7S5dxI2TJQ6tQYT
	 OxMRv3i2rRPXrDYWv+zmhOAo2mmhsAejuD2fiWWviV8eTruxmB/Xbv6MUKSIvmoM3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Otahwcao;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9B606D811
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B9B606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Otahwcao
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4911df1e196so703810fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817826; x=1794422626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0AXXfcqrxPIDV3H42pcRHxW2tMgCwJ2gAOzkHwZdCA=;
        b=OtahwcaoyjqsiNFvq7vTvzIqT8ZARgBFXYseipvRN4xyT7O61flraQoCU4YGXpUMha
         45IgUw7YYcLAtCMU8DhdiP0qRfaMQoL5/pRPEF1/CFEhv845Kn7XWwh9NZrDIhSyeH14
         8vS/BshRXt4XPEXCH4a1UGMikyklbw+9QIL9GMRt4GrNZSLmpQ+orchlcob5okmBz1Vv
         tmBgd0Y6wwEmE+3XvshlUERnWowu7gW3lYnWb8iahkKNUlEJJoY1Y6g9VZZMVbQz6DM9
         okN76iewZRThLp7RzBJrKTpmG7BMF/7PrMIF9XKTojJANLqvR7YaFG5lw9ht0kKgM82r
         cRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817826; x=1794422626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u0AXXfcqrxPIDV3H42pcRHxW2tMgCwJ2gAOzkHwZdCA=;
        b=caQgeu2OQtmWBWWLCAw5Da0S28b+7SYqLyS2SL5PpT1S/FGLM7XhLa+w0XvumYjb2H
         pXFbcEjcYHo+7FTfpq+F7n37yVCk6GvSh5gzZxs0M0e6LvaYHlblJ486ycSV+Q5N7cEX
         aALzORMqvipwPtd/pKYOqiSiDiPWQFPlDZZ52qszUKmQ+GN5dBc7wALzADhP0c0kVi8U
         3T8dHEig+pnDTFBYgbs1bGZgwaPPB+jbdFwdboqnVeSTlxeSiITeQRPMahcf+TQDCo4x
         ZSlDVKJc97C6GzUne6++xgrDqnpyuBLOeYc9mWxcQUenkXlgc66R5pDdRCx7iVNU4As5
         4vkw==
X-Gm-Message-State: APuU4Z/LC9VMISV8meHwM9cprHZL6uX5dJMqsCXc6RKx1sJ+DV7ROsGf
	hFwQJBzthXJYoWw4O2xjds+Xz/HkAbJBlTKx261cRY9OiI42GzLXNy1wakzS4dIFzJFfxd/rHH6
	OBZIs6H4=
X-Gm-Gg: AYBFou3U8GDMIIg0mexJjgW9sQdtiMTAxX08Lscco2zkvE1bXZVo+zG4Rcx/wrJgUtT
	mrfquAU3ZPEO+A5ubrnzuf8Pl+ujicGRPfj0q9TVWBmDldrx1X1crRSHNOmalKGNcYUIMVMZ8Kk
	MU7r60vW3RZ7idn81ULUe7Ikp43pcpPPItnJKxttkUMXG1fkXacD7YhW5XxzBGjmLMF2s5FTcdE
	DHv93EZLQGLQ1BqHNdSzNGPZj20+IP9eJVE0dsY4CU5XD9dUZnxmsdEvBAT464iqto/Cda91NoG
	uIfnWMDFW3wNMULX11+YVMCNetdPXbOTYipE435gK91yjjgzCuE/UgeCTTI8QF2xSPfHrYXoI53
	wcIGXh3bHO6aXPI2dD+bmeqjurMSmqc2cMQwnGUGh2aERgdqN+j8sF+Y47YmmyCZO8v/wJI7XJr
	2O829jwbjJf+zub6vqWF4Wd95eeZU9imNGKMSelL6a/tQRDCHI0UVD1pjkY1516+CF6hYVYVmHq
	Ek5KAs7j26p9kUabfZSHLXwWG04IQrU6A5kfDlTil6uNaY+fh0CWGZkR1rmhlhPxNXd2lErOJOB
	gC+SWrawUu3XxIl46KTZrOsnVtYRaIAjqjb6NON2tg6ZiMvE2f5qSrKkarSdMDeSH2VunwgHeg=
	=
X-Received: by 2002:a05:6870:2494:b0:493:d7c8:c71f with SMTP id 586e51a60fabf-4a9076716c5mr11489119fac.27.1793817825587;
        Wed, 04 Nov 2026 10:43:45 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/8] io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN
Date: Wed,  4 Nov 2026 11:43:35 -0700
Message-ID: <20261104184341.516297-3-axboe@kernel.dk>
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
index bfb128ff2333..d944b0466b41 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1564,6 +1564,17 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
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
 		if (req_has_async_data(req))
 			return -EAGAIN;
-- 
2.56.0

