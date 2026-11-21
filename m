Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296729;
	b=YlwSkHoe+qAjPjxkSIrwbIqnq4PP3GI6SkkxRs0eQoWpzu+4h9FfHsm4Bu6HkZxh6qH4
	 rMIiC4IlNPNJdjJ20qqKlAnT9vgOScGoiWa/4FEDQg2lFWLQP2/n+0nBlF8Ejqc7Ck7P6
	 SPx9XYwI2DJm0cHlEcpoZBNb7+/npqtApJleJO4rEB9tIGNAbV6TdNljF1tVGTdq9DnSi
	 GAWtB30iI/R8tiEDDs9y05kLB7g7F/ZqqS70f+xSQpJuYckuh1Z6rQgdInMqsFymNyFVc
	 zZm8T/L46RtEw1mEm+7zu557NOf/IvaBruIGGGESJyicon5Hu7oMcjHbWKNcfGs7SrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G4V1hD6swzbemP7eFXAYkN+AdteqDSaGX/nB2iJ175w=;
	b=zHMP0YPODGPq1xMQtzl7t6rg5r/o9ySsDVLM9cykGTt+8eE98QrF01sCh9AFEjrpab7p
	 4ygMGVG5kHkSzkxVufWhmavU7D7vbdZWKMEOGuHhskoB5fgzPvZqS05jVWppWrxSWFCES
	 pA1rZdL5jS1AjBj9mrmhdY9YY15TT49HuqNc3n+fY+DVyO+egizRiy1rK7w0jdHZ5lSn7
	 IUjJwOJ1GSd5+j5Jcgluz5iY1OCBegU3z9msdYXLitMu3RP88+wdYJ9XtDPq+nlfc+uM7
	 CXaa4HC27c2bN7CNz9HzLLgR042iEwoKbva/Z4+2H9ubZAPWOS4cd2tO35TpEIRDe1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=dGbtS8l9;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14B606A680
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB14B606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=dGbtS8l9
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-451a49abd8aso2218264fac.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296726; x=1795901526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G4V1hD6swzbemP7eFXAYkN+AdteqDSaGX/nB2iJ175w=;
        b=dGbtS8l9Ic+UuWs29/kf3yOobz1qMCCYIoQ+9dX8hm8iok1PjrVIGEtqB+VVsdR3Y1
         v5Zp1IFgCYWQCiKb11K3pFmqsl88iggpZINGAjy9cla5Og38VjEp74AHOly8eam5l7Nz
         w7zwUlGEix0q3bPmzdfA5LziK4CeEz3xAYIQHbloHNrEcrX0AaUz+tUiseAw9iQzzoia
         3U5WZFo8Au2pwMC4b0YcStgOgQ3J7/wZODbUk9GlHMKLYl5X4kaiKzLXYriJqYQyGdhQ
         cwIhPYaw8QTJK6WUiowT4W4lhYrVyVkaIIyajiD7q4fDqqcMun8RIOg81wrmT6Zh2rxe
         U8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296726; x=1795901526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G4V1hD6swzbemP7eFXAYkN+AdteqDSaGX/nB2iJ175w=;
        b=Y7dLQRS3SjB0RzFE6rWKDxOwBYm9pk7akvxB5RyDa5bnIBv8R4NNx5DnXzsOoljbHK
         Ngh4tW6LZKyrnC7HOFInz4oDbCBk1YMmfeeABbqUKKZpR8UToAvot7gZsJq3nhzHGe0B
         V9WavmEi/DMoB50n4Qo2eGz2uaAzYo+3wvWdsD7arKukR5CACaicZUdQJjEcCsUTRIw9
         mKfeat5YqkB9b9Ws0tafsQIwJn778DWJtaAo/lnKSQKuXhRD9pWdq8qSHYXtP/hpoiOf
         ZJmKNIFv8w8qk/AdQz3NogM5HmUeYd7d872JfFbXLnh+dUQaoL5NWGGzCG9cLmzSXDpW
         mgAA==
X-Gm-Message-State: APuU4Z9EIyPDPV4NNl6SZSnu2NRTt/adkypNXK/wHa220Clb/d8EirBL
	ynknFdUHYXInuN6tW1sdIMjyhwVP6huW6S1m6qQksz9G+Zl45NSIc+Wfi2UFpFjjlTeE6LNY83d
	lthWbQZ4=
X-Gm-Gg: AZFdTZefCyy+0oKhenGTc2T7oSNikMGWrFZBwVof6RakLeLVYYTXyYv10JJG0hGk5Kz
	xrjvdtWKh4u/uHaDRH2DlACnpWZTIhj4rC2gpA0iUTMgRtxalYdD/gNGph6JoJZViWYD757e6Ds
	Oto2tEvn2WP+il+7aM/h+yXSRnDjOCcJ8rkEYWQNnPfdZRf+6uX2xqUrTWXR9g5NXT1C2O5/0nT
	Il3glurgiUKjYiOfST/X+/PVWTrrLbOffIpCht5FBnPMNDRjE2Uep+KsaqVMI5h2PAm+uBcXwQc
	QmX9n2ZgMUxqzrH754UdukscgNvtNHZBdcVkmTsJH0Sb+jNT8+AREL0kd0woD01/OoJjgey0T6w
	SBiqTbzZzTBku9ETs4BVzYljectOHL9hYvoGJERd1ebMUYxgGJcGMwj43rlDyXS6WLFX4CU0AYX
	mnQKYMQBDk3PjkQqHOiFgFs1r5++uOMKBG/7LNwY6DxDxSavBRUWawNC7nazZSneoWh6M3QZ+ql
	4b1anBepd3ShGD0eEmRXf+l4KdL7fFjGwtY+A3d/cbuRUSRJzNI3HCx8bn4akMv9ImJ7IbvQzT3
	6esI1CylpIICbUShSS4INB0ciyMrFv4gqQ/ZhSlxzZb2cJs7Lx2B+T1+0ym63prwZncz/+4r61d
	cPxgsYXcGwXpY609mpj1a4kG0Vet8uu4cTpnGptMOuHEeXsWnW22jZyR/SA==
X-Received: by 2002:a05:6871:384b:b0:4b7:f1be:44aa with SMTP id 586e51a60fabf-4bc84c23c1cmr6561393fac.49.1795296726460;
        Sat, 21 Nov 2026 13:32:06 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 8/9] io_uring/kbuf: initialize arg->out_len from arg->max_len in io_buffers_select()
Date: Sat, 21 Nov 2026 21:31:53 +0000
Message-ID: <20261121213154.1790334-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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
index abf44f5dba26..873d66a06b36 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -370,6 +370,7 @@ int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
 				req->flags |= REQ_F_BUF_MORE;
 		}
 	} else {
+		arg->out_len = arg->max_len;
 		ret = io_provided_buffers_select(req, &arg->out_len, sel->buf_list, arg->iovs);
 	}
 out_unlock:
-- 
2.55.0

