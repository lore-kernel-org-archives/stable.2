Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817814;
	b=HZkB1tFDxjHAKGiVJEXLAB5XI+ly8L5ctNMkAR8dpKqQJnKvSmpYDbkRFMZW269aFwpX
	 K22VKaltRwXWjY0fS2JmU3qWyt6vIzZbprWb7XVDTGu4NLvnJsoggQI9q2/k/T7X3wI41
	 K3mlBNlMpi9dUTHrAIpsEbQB2QJTXk4Sy7K0zmoP61v0/xlUHpyaDFSulICAFowNI/+zO
	 G2zI2g2sNAu8opBs0r6xZMjBKkwXB5CN943awiHXUkBvaOONr74ujZntXnnfnk5IjQUnK
	 8EzTyv+jqo/a0a3dXGVPPReLxrwwTNJm743hrBOR2cp3Td0B4UpCpnMOOjKNm3DQQbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9WWOBFPJaZGwCPOQ/2zySHt7tNNKY2bLRzryB+jwHy8=;
	b=uGExOrtwyzZilDHgLLff7WHnPVe3Uxs8yPPyyW4qPfxC6GjeW0QyHoXnQafckMerpPdH
	 3tcko2qf96DmnQ4g6iXAcvlULfa8XjphVVngUOg7hphvyAjEhNt2fnScaRRJISPHQ0jRq
	 ovUxk3H7pbp9FZcIl2jYdQoCpIBLIpvUsp/wUQ/mEJIzhTAXHHaHaHJIikYiqoWt2HUgn
	 SNs9jGauW6kGJvMFvECxQaBJcBBvGSHZv4ESQoN8wOHloGUS7eruZsdGvn9q0FIcKAFdq
	 DIqnWrkE8V3SsP+neLtYKCNEILzmNKvsIqNb5G9yDkUQ1r1dgU7M8h93dG2KogrP9mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="ZdBwWn7/";
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EC606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B6EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZdBwWn7/
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-843ea301d60so673226a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817812; x=1794422612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9WWOBFPJaZGwCPOQ/2zySHt7tNNKY2bLRzryB+jwHy8=;
        b=ZdBwWn7/JZdBwAuCto1lYb4i7w6bo2nrfkS/2NsZmok8tzJrFUz/5gySpRZ2Kbwfyy
         Pa5QiMSKO52ZN6mEfkKtNYIMpxREzqwfXkTsrT3frE1o7Q4FjeRFQwhwm3jk3a9gHAvq
         ZTDNnDOj+FI8QCQ60HawdFBq7PgC1MPropcJ3Wgb/nb4KxQ8nlZIvaZuOa+DuoVKSl0+
         9bQ69J7XjrHAHxundRN2yvuH8ZaJy7XP7erP+yid0qHGuas+cMXTcma21K8eiBp3ic70
         Jys7dV0hhhKuLi7wvJFlbOlbx4w+3EmrOj2T6qolUHfTqhY668MhZHPBDjRC0Dt6bjZd
         qwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817812; x=1794422612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9WWOBFPJaZGwCPOQ/2zySHt7tNNKY2bLRzryB+jwHy8=;
        b=zINPU6TjaFqGW/bKWZhhNpKwiPA0gPv7Cx4oQU1wyVJnDIL+p6BGDw1TUfW6O6v9pG
         EiV8B9nqjYD85lyAHenhQvBFXa2rG81TRNGPMbZS2sSzwlX38o35I/fpc0WpLu0AvZ++
         psfDCliXPHCKYGm2lU899InyqLqrBZ/IxnJ29GcoyBFfmMWLmMOyOkmp+SCA2KdJehxJ
         b/wSTEw1NydUdg5EPKSUT+ilxa7FlmiMRyoQsZdophmgQ7/oLx0co3cKjt/1PfNeRvsF
         FbAF7yV65ooiPUtfbRxHicrHMHdrRLj4LoXiwD7jTkHURiQTSRzVlJH0yEzipL4Vj+p1
         +8TA==
X-Gm-Message-State: APuU4Z96HDyb0/Ul5KGSOSmebHtoBSePoKH0L/70E0hg5uhgcq3E50QI
	n1I6/EJv600bpTb7ti8fXO3b6Iff31OAyAoICC0WRQGdAKsvwMJkV0prbJFkjIaaU6uXp0rqRQ7
	xbR8+w5U=
X-Gm-Gg: AYBFou0k4thKAWEcuBqwLfpz+V6fQUie/G0Fj/YIJr5sq0P2y5rZEgdylI0+NMk2FJT
	2zvBi2SEEWu58ePvnzb5ntiguQttYKrKLqjE83AirZuGdzaMVJGQ/XHgeg/xNRstQ2BGE778rHO
	wU2ubk4+C3IF92AtOS9fivpK0HsVu4sybPbysuJmHT/L6Z25R85M+rQlYHumRKiYDM3sFVgGilO
	1m+KNV6Q0wVYfAEI4fm6u8KYAmSEP7jrMHUH0TEVVXj8f2AC5jMJ9fS41+XpXmgiK4wH2FgMh7l
	s3lGNGgdqAYPzD7S82yTHws4tyizUW7Klfgnm+WN41sYJhkq1+seR9k9k/ywwqAnwKKqralflkS
	SWoznDIs+MVtZwH1b0Vqe55mD+aPSyXRUAyE31j1leKSnpL8Dme/owVAoY/urhfOkMuqYigYf1x
	ioHg4Bmxfu1QyYtsRr+ARLg5iu4+3oqTm02wnDvbHrmd43mzvu77hlmHQpDBy5IwAFoV0HY8em2
	cwk+SD/ejYIQgXfzazVudTf4X9muVvNd30hQwaTty+xAx7wmc4yDpDlMG0UKOlL3wSzz9/yImE+
	LAmD9F7gwIQ91+Sz2hX6qeroQiVgejhVqnavs6GFQLPl8ZD562N+spc1jv9US+twJBljAj1Viw=
	=
X-Received: by 2002:a05:6830:4423:b0:81f:8f5f:f1dc with SMTP id 46e09a7af769-85d364e270dmr14088171a34.8.1793817812000;
        Wed, 04 Nov 2026 10:43:32 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 2/8] io_uring/net: don't retry a non-blocking connect() that fails with -EAGAIN
Date: Wed,  4 Nov 2026 11:43:22 -0700
Message-ID: <20261104184328.516206-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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
index 86a18814c628..669cd54cccf0 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1510,6 +1510,17 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
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

