Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296703;
	b=ir1dBYV/fhiizgabNIqrzLP3nmXMlp0hshac69J+rFecrj5j4UuGI+D2joZUBt79aL2r
	 +SM45WvoASnvUHDn4IYD7yThuunJUjhXopskMAlKde9k5iC/f5drj7ddj8JujJk+Hr4Tp
	 LYJKig+YjAz8s2SgADeGlGHXQ5IenNE0+hkO9LGPdl+5wxb8pB8KAhpX3nDtlw/tCXYr/
	 IxUgMkZGjjg6TzXnHiThwYKdg6UJoye65db8httIGBahkDnKeH/6SOB3i688bbeuzSt7V
	 LTK+vmyPT2QsFOp1V7XA6E3esizW1QGIBMpKNSSCEhYr5YULY1c8yd1wKzL6pNHNdZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=enGC3Ffyr2geLX1L1caKPg9bPov7cFaEPTo+kuzkUoI=;
	b=1swMOexcncJ0xxB5VBJoPNHMhQLBCDbTyAXIlh86w3CRZg+BKGTg4ShcC+QggSz4db8m
	 xnPlPzcBYsK8HLHg8OghaJHRE+ZxhHupPZG4GKKTLVW8Ppt0hmfzRz9EQkQjUq0qQ305t
	 ZOWriSkAxv3K3IUFdSCUBVEhdIFbx3AQ6HXP07MCFeR4yGUKyHlImA4Zu2/UloupSjmU6
	 J20Q8dUeT6t/uLEbRfPTwboVKdrAWdB/m/EmnSgAV4FLKgtUIgSyZ9/Bor4AykkU8zu/X
	 +UIsI2ejBw+WZuI/n0UP6lYJTnV7QM9mEYRB/oqg3GLfzHTAJ9mtMI7ahFhkNqb3FDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=i977FljT;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E600606A33E
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E600606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=i977FljT
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-833e671ee9fso2040270a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296702; x=1795901502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=enGC3Ffyr2geLX1L1caKPg9bPov7cFaEPTo+kuzkUoI=;
        b=i977FljThPg1s2GXYS4KK+AaCxbr0b8iTzB4A2rxsbOn+r8PoRW+giC+fZ5F6poTwZ
         Rf1TKezEapKwKbpfETilxS2Xh77MgLfh0j9Rkd9KSDk0HHrojgCnZnhSWX7AnZYL9T+o
         z+LV4JJ/1D3jKDwI5SCr+oWOX+3EVxkBc9oi3+trSAS6EocctqFyFh1PfkNdDpN9lc9o
         XR6mi589wcZ0Wyhb5Xgz2VuzA/lZOayGkZTTTepTJTZG8/m5l7MgfTsfrOjs4ZQOoucG
         d9vAysTm7rHsSTsBn4wRHeeA5H5MrY50vx5zwead6PznPBqt7BeBR7rrG/q0STcZ6HCz
         pk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296702; x=1795901502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=enGC3Ffyr2geLX1L1caKPg9bPov7cFaEPTo+kuzkUoI=;
        b=fM3r0ZOw7Gx+fOkUZKpR6wdlGY9hSS6kVlNgMOKCh59fVKLb+hmHc3/sWguO8Mc+/Y
         MZydDegaZp7XgaUQes2Mlwat04DZv7KChRCNgv2/pTZLHRUXM0IWmp1lqm8ZF10bg71v
         Mwvk3pxrubAJMyrxkK/6x3QHRl4MzmxahvHO2lXaR3gVSYdNNN9OI7+qNYV5a1YVWSMs
         +UO2VWz5CubIxJIRhNbxpMVpZyC6NXS+/FWfZIBWUPBeQnb9HbU9JFrKewfI6USXSoPE
         H6ur7Rwx75tlu0uHF5SQC4diRIls0W8mgXx+lkZK3wvarJa0oxrZsUSzeA9cHEHHEzxX
         55Qg==
X-Gm-Message-State: APuU4Z9l3/KTSZbdvcZ4kSXoE/1YofP2Z/3pf6YavVn9D8vMp/5JdmwD
	Uth1Rk1e+FPp50bWam4ZW1pD25wXi5nN+fHoNpA3wtyYtTxBHxul77Hr/i8NXdzIuJGD2Epk/Vd
	q/svw3fI=
X-Gm-Gg: AZFdTZeYRTCCbTCXB3lMmkcexUsae23JCGt8Ki8iCGSQc7J3nSr5lvkSfPwwE+EhW6i
	WK8XAqKsxFm4GgaQ8DYdsDW8Iw1hDH/6RpqUGSMVYGzecwhuJIW2QvYGrHhZFobst5SJ5+3G9Cs
	C9Hg+G0Szfqz0kYDL8vqOImNw5cDIADNMvBXxVttEAdNNPTULAsDq/e13G8DybW5/lAhrphVCsi
	f16kTaYgIFP+nvnoS3vwpBNZIXCAXnZ996FFnnYCOp58NuNyeh2p3yEaDJHpVLCSm4Vh7Ah53PK
	abXbLAmK/82Sq8jgKF4l23khrrka4yWh5YY+R/iY7kwxfCjX5d2YonfmLFDm9T8L24yPPPOii+T
	tCyVF9ufTfEaXo2EULX1SbMUZJeAK+XACOBwPGZizUstwE8TYQr87AIljBU/BR99j4/B0QbUVeL
	WQeQSwlM3pVOF9d/TGGW1fgKGQ3thRjRL9SWHtkHDycyZgagx5qcU0VAelqgeVndnJV7G4HIWnA
	l4c4j6k8VfRB1P0RGFtKbAI33CqV/YsNdtQsWBgK7gjfQIWUWNweo8X2qJQzs0m/Top7EtS5elU
	+101SlFhIG9R1JDXNObFyPTS2+AQ+rMds+d3wsQrlw2nuv2sr5cl19IqilOJ5lNtAN61kvs9sSd
	JBYW7J3NCx295KdV+xMzU3Ld2XTu5XunEJC7mMg==
X-Received: by 2002:a05:6820:a781:10b0:703:8835:5fd6 with SMTP id 006d021491bc7-71b391e77d8mr4543408eaf.13.1795296702590;
        Sat, 21 Nov 2026 13:31:42 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 2/8] io_uring: fail soft links on negative IOU_COMPLETE results
Date: Sat, 21 Nov 2026 21:31:31 +0000
Message-ID: <20261121213137.1789687-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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

Commit 9ed19503a7b34e1ffb2b81236843204c473b0ae0 upstream.

Handlers such as fsync return IOU_COMPLETE with a negative cqe.res.
The old io_req_complete() path called req_set_fail() for res < 0.
After completions moved into the core, that check was dropped,
so IOSQE_IO_LINK dependents kept running after the head failed.

Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114041123.109163-1-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4a9f3a0fe506..df5f33a0f937 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1971,9 +1971,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	ret = __io_issue_sqe(req, issue_flags, def);
 
 	if (ret == IOU_COMPLETE) {
-		/* not all handlers take care of the internal restart codes */
-		if (unlikely(req->cqe.res <= -ERESTARTSYS))
-			req->cqe.res = io_fixup_restart_res(req->cqe.res);
+		if (unlikely(req->cqe.res < 0)) {
+			if (req->cqe.res <= -ERESTARTSYS)
+				req->cqe.res = io_fixup_restart_res(req->cqe.res);
+			req_set_fail(req);
+		}
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
 			io_req_complete_defer(req);
 		else
-- 
2.55.0

