Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296710;
	b=obuwV38dF2HtKU+eV+gShbJg0NQNWxRYjK2a0EX2kYSri+45cpGtdo7duVaoKM1rIM+L
	 W7HEVEFhhFz5+XYtR0r2UA4pDLjPkx41RQmeuTATUKPrGYzRFsL0e7HGHRJrWcL2AVQpL
	 9WA8cL5JGbg6BrecejDZ44YHTrexpte1E2RDq3emIFclc9J/6M3sCb6os84c/honKYT8J
	 gA7DPeW8o7hF1Z74o7xUiP2OUvn8BwFcSnVn50STdOYBjzAowLHuhh0ltFQxUMnGJ4vPb
	 Jl1LlIdaApllYhJ0NJCQMLxzS4PoImRKi67KpRRXWy/QN8hl24g+gp97HjWIzKuM9RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4E+wZqtD52U5mOH7jvBaplcTy2m04M73hvILVy2hXS0=;
	b=5oMBik2URx9kggU/UQcTMOu6QJY+edSHferg2+if/8xGnGBbSJgJO4o2pU5/im2da9ga
	 G6RDWSbUUfQKdITkCGnys12kJNpp3tdd5z8s5rrudj/DrAQI513lRhHP7rBkwsk+6tsvE
	 PVbzg+NL1wo2Cu6/fQDTq70rgwLEWHqsNGrjrq4/fyJjGe27HdXQtf5jzcr2oSz+Uu6dI
	 sASGTyeMVb40Bgt6BTcilsjMew/B32Sc1NSJqUxnDFkcOC8KIqoQrIwRUshuv9U2OxWPp
	 9MlkWWxIHFt5X0dS0OdqLQiy+GXbp+AVD50K06lVW6xi9weKF0bte0GL3I4+d+jDP6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FL4FoYgc;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD04606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD04606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FL4FoYgc
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-70059e4dab6so1224826eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296709; x=1795901509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4E+wZqtD52U5mOH7jvBaplcTy2m04M73hvILVy2hXS0=;
        b=FL4FoYgcKN27QMOsoGEspIQf5WQH1huvqIj7NG5XPxj/0o//oi3sqDsrnwCTrbdDoF
         wNnW4NdwuhHHNAiyiLcWUAdeFED98EGn0Cqcn2gIzdJbZs29a8EkiBT2HYgByNQ0HZG7
         GY1op5nuc0sLokMxqg/Fn1bmEJfzGv33ez0uzzlAAcBkN0PVPMvx2VRMkgyY+z8D41eZ
         u1u8qgILPqJ7lfJH52zMY2UInVC/0RGOowo3v2iG19VspsMJNwTth3+n/DSK6yHOycAU
         3kZ1yTrHs6M2mz+aG5LLsa5QygL7v8LhlNFaUq6+S5thMv76xV6WynHDiwl0aIhBxAYC
         xW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296709; x=1795901509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4E+wZqtD52U5mOH7jvBaplcTy2m04M73hvILVy2hXS0=;
        b=ohhutF6wEjRl2xZywXwma4ukapZUpo71soe2RGPEslneUhYREAxA89m3SSICrORzVg
         AgAj2Wvo/86TlMutSeNu0P3NwaO6FA77tSjMKPeyO3+VVY+2qGXb/T7DWJ5oQyUstBWq
         u8faN+/b2dt/ujrjz8D+rHG8CssNSnxFH60d3LZbLcUJ9VwA8oM3KywnjaDOpod5bH9l
         7n1V8AWqiCNFSyAJHfwdtSmBOF6CCjad0GzpZMXKeEAlclWRpu9399miFGl/iU7+EZmC
         jgEHMBcdC1C4lWiNXSLwKSEL5cpWibKYzRvcTkDfPK6nQOIVdn8FsyT8yRPIOmCawDcJ
         rlqw==
X-Gm-Message-State: APuU4Z8b9H57N48sDSGnD2WBUWHLStXfq/TYBxuVOVhM+AmAP4oAhtXQ
	bgBIUEqCBGBnz/91iAmFAkyAWK7vU4xDlH9ZsQi93+iMFy9T1785qaPMOKeDklHAF46H/sCkfFg
	QK5d0uLg=
X-Gm-Gg: AZFdTZf9JZ0Yr+N1bIgI0gjj5FmjeixNEzQeqXRzLO17jyPm3D428/NTxWQj793wJ2L
	stw+nLmhRxwqc9cVvrlRGnWQ+LT3+gRjh7iJr2ttrrtYq3WvzCRpuXyfaW8WFVpSPV3tHx3Bifv
	qpaEBzERzMWYoHTrQoMwGtRh6oSyC+t+smVp1ca7suTWS7kl7DQzScm9iyhnZnfrVHvdbFsq8c8
	J4NzUQq4C66uDz5z+wqic70Jx4datS7yYzLT0a/jjDQnLfuo2db+1JHLI4ogZ17Jb5q1U9GwyCt
	jwFmXDo6H1t+KyvUky/vZtZkS7PGjyaiSuTLB6I3x4LY+c09OsbQfiimymQkRc/w9K352lqOfkk
	fIgRCtTYsSMzbsF6zOl0+fO5gesOSu5cC0aJrvYJOM63mrF//nJq6jY/KsyRhSpMMFIfLzrcBqk
	BQMaAzqoqJHvUNNpbjI5nuCmcxLVcq9h5dlK4iVWbRyfeRiXo9M4LNlpbt2KZzo2mejwLwVBMYL
	emoUS3S8TmFTDr+QPaYHf1vzQMqFFBhSEGn0UOP+Za1KQ2lwFzQvFSP7LAI0XBly49TceZ5cip0
	V4aiwQLkK+3A6JaJFOGwhD8BLNScMBLsKli9AKXIEPSWU9s8UT0v84RF1OAbrGga6rFNHmuYR4z
	3tOBC1KcY1OFFJalDxwUaFzUgR/EO1dmS0WlN
X-Received: by 2002:a05:6820:7083:10b0:700:52ae:7e48 with SMTP id 006d021491bc7-71b39577900mr4428061eaf.47.1795296709344;
        Sat, 21 Nov 2026 13:31:49 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 7/8] io_uring/kbuf: initialize arg->out_len from arg->max_len in io_buffers_select()
Date: Sat, 21 Nov 2026 21:31:36 +0000
Message-ID: <20261121213137.1789687-8-axboe@kernel.dk>
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

From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Commit b7322810d1870ccc0d293ad383d94ef583d5057b upstream.

io_buffers_select() passes &arg->out_len to io_provided_buffers_select()
on the legacy provided-buffer path. Because callers initialize
arg->max_len (from sqe->len) while leaving arg->out_len as 0,
io_provided_buffers_select() sees *len == 0 and always selects the full
buffer size buf->len, ignoring the user-specified sqe->len limit.

Initialize arg->out_len = arg->max_len before calling
io_provided_buffers_select().

Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Link: https://patch.msgid.link/20261116193146.65315-1-sidchintamaneni@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index c091c3c462e1..6659f56e91fc 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -355,6 +355,7 @@ int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
 				req->flags |= REQ_F_BUF_MORE;
 		}
 	} else {
+		arg->out_len = arg->max_len;
 		ret = io_provided_buffers_select(req, &arg->out_len, sel->buf_list, arg->iovs);
 	}
 out_unlock:
-- 
2.55.0

