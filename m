Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817860;
	b=lu4pUHj8+e6P8+u/HQ57r4FeatlfMd7NbMmFszY75foJnyCyWbyqn9g66RHtSWM5tMmS
	 YKn7yQr/nzG/VCXmO1urhTLW5LO5kSG9fmndGdJ3RRUSmOQEgHbLG7C+fJvGHmphp/8HX
	 +9KIzKp+si9IkLFUCiMblOok6O923leTAT2571zLavOiOty9mVIWBgspsCatAr5NgpNcg
	 YaMSxXNKlrnhbhU9hFCBAduZzTveF5lY+S+VR8MV5NyIArSxcPXgFfZ6X+t/tgev66gez
	 283lxVkjHSRcgZBeJxiORPBR03nGp8JSAyYTbeoim2BbuXzKUrEn1BvmM2Rb5e1bQFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tbV3dzwt2epJxFxVCfOXzJnQS9OEE654M93XK6KIDcM=;
	b=kpaffhAVX3wMO/Gz0XPCmW8sATacp9VC+MeC9Q8z9/mlEQHzfXw2EC+G+IiCwNnZIlPB
	 ic18XikG2evrHe4z4Xhn4zmtfGUb8++tfy0A+NTHSM19vJC3RRiKbN4bnaK3dvVKEQII7
	 xExTApfItxUSWqkpOcft7QRS2K107AHKHvT0g569UazQWVDbZzO+j3CRi6VCGhQUdhX4y
	 V/knHWYSWK1E8NGlM6b7dUhJugkEL1Eoeq2UhyOMFpssRdPV4qIsDajgEwXyYlyhM4I7O
	 rNbPk+TMVTGtCaBEgLYniXVk/cuN+xqxLEcbpxAvUI/najKpnnp7eyFFDwxskkUyarQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BAmKE6kY;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C60606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C60606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BAmKE6kY
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8451a619da7so694864a34.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817859; x=1794422659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tbV3dzwt2epJxFxVCfOXzJnQS9OEE654M93XK6KIDcM=;
        b=BAmKE6kY1qvb8JqkcAmNYwsD728EKT4KiraV+W/XdemJ+AMdLgXPi6oAMYqE4F/1oW
         8UlzoY1iPMIXtk+ScwXBZ4idMVCIwAXuKiio4drEUM64xiT3DtQ0AmIvtr6Q4FmeiF+E
         CtoZvvk485p1/UYkGq0J6czNLgos7PflwrIpNl/M9+Ohpo/QINpRYmnQ5i1ThcraI0TV
         OdWWvu73O8kpkOweAcTm4mi6MDhMhgt05wEWrGFpYnLXsHR2jS0rKQqJuFU2xTNPRgID
         f/AJ1TcgeA//smucbLsHeF27pg1gsubb1DXB2uX0L7dKHax108lmZTaS792R/en4dG76
         00IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817859; x=1794422659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tbV3dzwt2epJxFxVCfOXzJnQS9OEE654M93XK6KIDcM=;
        b=Y4wLU3buvB+zI2iFXQBKWBa26zCukBJSFf5SRDzD8ZEI0i72wdzsOW5g+Y8jwszrfR
         TM7qq6INQdVzONkdP2XxzxnaViZ8IqK54cCs7suNZHoWQ69XRUtCphgRTJiKlLuy/fN/
         aQ8nFgzu6MX+p4nrBsONyxtxkxOeSJYod/RaOLh2WIHPpNLusymKYR21s1IlzqxyA3+9
         6VXbVwsB2ejzrDup0+g7C/4fUw/wrNmUC3vALd/1c0P52XM/IyZFwq3o/DBpCmjEToIc
         obVSRzhoRG/KCfZG0+FKaCrd4aknItNAOssOSqJpEcvh0mLbNPjluWDGTUVi/MM1rKiQ
         jW9w==
X-Gm-Message-State: APuU4Z+PukMBklnJN7uRxMzD18j43NxiFgUlptQ8R7Jw0xR4scpjlE3Y
	eCjWb02lIFnQUawVNKSphiEhA6+7Xx8sSfoj2hupXk3qeEncmNJseOeEZyHrHTQYYMWMHv87yub
	I9pv8L/Y=
X-Gm-Gg: AYBFou36duX+tW4TDUQ4edIJPCeqgAswLqxjJVG79vMYe5exQoZvKq2nZUeRBWzj3iG
	2rbSVo11VL1X88ObOC51k/IxJN7hEeNJlPRwgm2YlPl72HNnRVFZiY0WUdFZjBlfGSNn3GGAIHz
	7zsI6zRvI7xIR/24dIEtyPbfzf78dRPXHZIax+OtKpppPLJRFV4p6ValsCwx687mHilI3i1ZLhS
	a29b2VRnKjl3MoARovWZ06Q+RR4bySxV9HqCwsHFRHy5clAZB4lgEnT/0f5TO3nruAUgKZ32wNT
	E+1A22rVQGSAV/HhKtegTGYTiWRdlqMbEN7eVAwfJ2apjVA4Bjx9R/IvaSdvltj/XlDZ2v0Tgxb
	CZmSE619uISNa3RzntoNdtDn3bIZimvaAQWaiIie0VoDfPErbFNI74ZWpfCFsuMumlEdgpGQqFm
	uOG0VnRHtVfgwxuuBJCHarMVzLdsrhxqNxLFvjA2ryhB3JsKoaaDqz+jeX3FsqgxVAeVKtA9J7l
	Luv5DGITRsCLyHWHbgoYvZgMsGny9SC/ucRZl0G+CI25bMGYgPQwhj6zdZn269gUTuZhHehbD3J
	cyHdRBs5z1vV4e0y28FdWbqjHTU/YHHMURdAhzz1jQ2FiGj1RSwVeSGMAf95DjzhQ3JcHzHRO7Q
	=
X-Received: by 2002:a05:6830:660f:b0:85d:6045:52c6 with SMTP id 46e09a7af769-85d60457cebmr8110142a34.24.1793817859057;
        Wed, 04 Nov 2026 10:44:19 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 03/11] io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN
Date: Wed,  4 Nov 2026 11:44:04 -0700
Message-ID: <20261104184412.516558-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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
index 622d40336f5a..e78ec89ca5dd 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1864,6 +1864,17 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
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

