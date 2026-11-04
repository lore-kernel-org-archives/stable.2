Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817907;
	b=KxmvlX0aJj7DhuPfWwATyr01mIWmTILvtSTrkuGwKJMIGEJRwEnTCIkhNsy1McVLnjHH
	 FpF30mjZ7DgyhTt59ahHZ0/VSLnJ0KzdDwqpvchyPHAnfmGPt/O4pNcnimTLktzLB2aCV
	 vMmFAewxEaZPTdFDeLnohjs1RjgNN/dqD4DDPc+yTiNH/RqFKF7KxoeTnt6dJ9DLR9drB
	 RVq/u/W42EBgGiz69sat+3+S7wg9jWkFo5h6KU0UArIqnkabQOJhU6hoeVBNzSSTDCKKE
	 m9fpHboQ21o+U+NfIu7UZYREUCgty20bnaHyoV8Y1sXUq/MOVfq3vb6mCrb6KnXennA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xpQ//ELM/dXg3Oye858m6VaH/gYZHAk+E+a15l9Gz6U=;
	b=AisDiAgvqh3KJwUkLRNB6uT/rLhy5vL0htRLzQ/MkoNKFrT2xU2qJ8SQ7+42Ej6wG9n+
	 N+06BMTdUuTaRjytzCMcsUIoIUHWNyTqcNXe0n5hhN78HAO5NA1J7cxe34/9HjYyOv9tN
	 SYYApmjr9CN0f7doXHRgI6g2fDmHmGVT6eiezxtTfLUTnCJUdiYnNkN8yUItvROHuzEkl
	 K67nAr0qIyNteVib1Ah1uqSrPKzgz4W+011gAMf7DFd2F6q45+42oUeZZ8tivPTTXqoB4
	 yil1LX7x1LcVGWHHi5DR4TUBv15Dks0VQGMoB6HklpsxzDa+j/xm1tfg8ldF5RcWbHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QFm3Op0j;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D5606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 380D5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QFm3Op0j
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702fd86d674so683763eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817906; x=1794422706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xpQ//ELM/dXg3Oye858m6VaH/gYZHAk+E+a15l9Gz6U=;
        b=QFm3Op0jriiSX9anl1KYujAcKS2Ft2/d1/9YJXm27v/jitW7mzouMsaVqtfBjgOfeL
         LTSSD8j3Sph7C2UOPmaTAi8FPyBxERZCVZ1Z4ZWLRoXkBfPVDo7GH2e3FmSGJ/Tb4/Tm
         RVBr51uxlrI15RKtiA19ILVK+tC0kSl79QyrjGkHsesjMEsLfoRgg6mOSBVSOEHBy0lw
         yGxbzShfYBtjmK+kJFZW6ctyBFAJQ8YoIVoYLJrBetJOXAp7urAPVlZroM6u4aExqTbL
         62B/UfstflHHgi8HDf4JjAFao2gYw6GquRpFf2nTb+08zy6fAOEm8bKmcsR9kEEb6pIw
         zq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817906; x=1794422706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xpQ//ELM/dXg3Oye858m6VaH/gYZHAk+E+a15l9Gz6U=;
        b=pDsBFyhJRCbsPEvlH/RcoXHah01goRD6vJNuFQO3yAddKu+IKxM8fHSkkXleOUNOh6
         Hmxq4ucfAdDDTLbKVoHzZqirCZ0DTvYKAN8OECnilbG9J8vQTOoGt2IO50s2ol/TPkcx
         PAStRxTvBGdOJnQtBkaKYlbrvD0VYlx48kV0BiNwJTUxpUn1aeueAeMyNT8yLNZd4Egc
         KdiV7MUwrHMwZu6nbZ93waK3bO4g+WRZWsUy6FLtdAfh+Uw0kzlNWn7tPA8blaVAVJP3
         0V/axFbPzLlQUvKU62Wik2TeYu6Ytpq8BZvmiCmeBaSCFK+48pU3+XMEW0//NbqCoN+V
         oIzg==
X-Gm-Message-State: APuU4Z/zsBdWiiN1dxK4rHZMITpOM77N8ggER2LZjmlIMcnNDekNVk2H
	NCf0AqTi1yzC3LAVhel0kSs/cKicbukP4mInxH+SOX92xNaDwYSkEuiTyamgMkayPELnhLupFyP
	TPyaOtV8=
X-Gm-Gg: AYBFou2NJDPnQysYBQ9wVPc/H6NN47GIa56r4a4Tfmp+SiGpF0wSFtVd1Fo/1dfdsXV
	zY2gBxCXWgNnfYHRtZRzwbXZCFcVP97SxbJ8N0rAA2Xq3EE+VhHBPCzBjqd9DHl3sfy9iWPfof4
	wulw9CXIrdCkGYAthpIQu3movzZV698o8C6i47tTAsFWSyTy0n6gtMtRq40J963DSKMOzTAnVaC
	l8j2DOSb/qCbAL9YWOnNDXiSisFWw7k3Z1SCyWqAqDJ1mVL8tF61kZu+LjT3hrIEg9mi2B3Sqr5
	6GlQL1W2SV2585NwZbkNRwHU6J8J5WIr/FbPLKDTiIVA5+Ok8ZGc//gIF0bjeoa1j+XA2PILNze
	WfSqPQBjccL2OPfDQZowGG9jwq5NK7+QKtXtWQRWiFpgmd3Z7M2MLEC/QRxTn0Yg/aS81TV824Q
	waFf88VdH7M2+3A/HbmPkQBx+Gg16PhweQu79q+gWf+DM8BCaMqnA0Uc7fxcc0zOrvDzF7gF5KX
	F/KdNVMEgfQUvkid2gOjtzutBikuomo8OcO2dTJe5luo6Q5BQHKBmw78Fzwieh2eJSrxvsye4Nu
	c6A7jp4pEJ7ctx+shPaZ7G+/i4K7vT6Qq6SKcRNqfRxwGdmnxA5hcfSYS9d6N3yuGZcYHBqQOg=
	=
X-Received: by 2002:a05:6820:1627:b0:700:8d6d:93fe with SMTP id 006d021491bc7-714f23ffc06mr11382681eaf.38.1793817906120;
        Wed, 04 Nov 2026 10:45:06 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 05/16] io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN
Date: Wed,  4 Nov 2026 11:44:36 -0700
Message-ID: <20261104184447.516768-6-axboe@kernel.dk>
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
index ef455f1a47eb..b62f21df42f2 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1878,6 +1878,17 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
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

