Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296662;
	b=HQ+YvbSyKOe+xRD3Zuqjgue1Nx7DXa4LBwCo29sAMGIsOShjz3vIIHYbFk5puCKqM9kw
	 2N1KDWPxQWnGS+ClHxzZPmHj+Z8FguD3Fwgryeq5mK7hPJAMgGLR/Yr+SdehLkW4eTalM
	 fch+gdC1dEUcjQ+SjOtIy1U7nYr6Sw5mo9mFPSM8OXV3X2t61WdX8gDcfOI/nQsT0AfQw
	 ZNDAhTyfaUcUSnvIa0dv1r70xRCLZ4mKwPorg8jv/g7+O2KQISZfRkactwa/UXS32lULu
	 /6XMK+0h7iLYMjgcAUa3FI+cEzOZrwFtPbjethbzsGPWQTsU/N4x00rxi6Kt78KMSKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IbX1kl3frblJuR6RE5lkfaIQhu6QEFy8fufD97FMQOc=;
	b=TxkYclA3Eqp13PsMXOPDP1avmeqxwfReHLVhLRs4jo1DeAAytTQzswt8r3xoHBnN3ceN
	 dkF6srFhpWeM+Tx0QG6FwPPamcLNZ+WyfIOVyNhDROjnx9fGrBK0o4jjAZwlNWnwnVF/V
	 oDJVnUmJJoH8xZGpxOXdZSURN/elMwhO5wDSzil4OnkHLj0zMaIQ8/+x8uDlyFdmtvmQv
	 CRZwcLceFit+uL9MVB/4SGyXrbcoQnvD4eMgVTsH1nHJe54QWKRBLnzwXR7w4AokK/3Gl
	 iScpVK096iP3mLUGdPlFdsq6MmLw+STVtmONtYy7V/TPzNnom2uKgoaQmRzEImWROVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=BHOIszCA;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B8606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=BHOIszCA
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-71b0d330acfso1607361eaf.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296660; x=1795901460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IbX1kl3frblJuR6RE5lkfaIQhu6QEFy8fufD97FMQOc=;
        b=BHOIszCAqOUhzmH3mmP/OvbWeEsoGXIUQGijq1/Ubff0i/dxOeUQRhN1urMr2gxptO
         Q3xjpll9Bh+nDDPtv8yX/QqWaQbD+vl0+siiQLMbl1BrDiqyuUFy3Gs5GbZzH8pAviks
         f9extZctZTrmVPJZ5jR32YKSwmXV+i3g2dbeGvyCiq/0WHdWr4Zqoe0vVIO7OrlXCo/L
         V7/H6Rlf96FPE3KNfWAI61uTaB4T1eVSCHA/nLwNl0YzvJ9tSjgnd7bHsSQsG46UG35f
         8KFJJW64XaxALJxseQynnja9JAvR5CSaAogRGOPkhgRdYhkg2CeyAcKu8clc7DUM7g5z
         s2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296660; x=1795901460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IbX1kl3frblJuR6RE5lkfaIQhu6QEFy8fufD97FMQOc=;
        b=HCKBQCptC6TqxaS231OiHA9vvW2sZALJ9x7rh2MOXnKN5Hepk2ZQpEaHknT96OUDO0
         obIZrClLzVcoEbI1i4HiXsq3w+uvgO+jDWls9iVZ+kxDW/DvvBXJzp81b2mnOPljJphf
         cSzk3dpIZhUDv3seg8H7OnBus5hvL2blsX+laD7EiiZRMLue/NfH9j75JEJ9KAraXkjg
         z0Z3kMu2u6f5MlQIk/QurxgbQEoZi9XJb/M4IOcxQ5sT0/L+EzW8xmSGNbDG/QRTKu8U
         TflNeImhDsVNzpP93iu8jf3uzUTOFZ/G+L8Jh+dfAt2RLZVG2OxqNZpDbmhKN0+WDM17
         BqqA==
X-Gm-Message-State: APuU4Z9R/Fm1e+5a2WxcJ5tAx6vDIGd5tYKeKnXXP+DewnS6bAbsnAi2
	hrVcdtb7CXB/8jWvyHW+KAZTaLYKbE4/nv1hVdRZbQv48SqmsKBpmnWkFUJ3teb9DiusGzieBjZ
	YZGVq9/E=
X-Gm-Gg: AZFdTZfCW50tylyJy4ysXY4PZje2Jbasxii2WI/WlL2afaAYT0AvfVbb/nbgcoRDZ+n
	j2m4cDjnqpjYaIrdJ05/BSSFgy290AF+KHskz5bbufYFRNaY/TcOpKHmjVPIFtSf2t1pb0ArmoL
	7H6T0O4bbFwlzUimH37uIp3pjDGaR2puPMfSRYzGhp1qCHPn1bdYsGNJVpjYv+2pgI5J9ekKELl
	h3xov5XgMULk+CIWRHL9dKyoHnqaI0vYYV6kS7p0hsNWlVTiKZRMo1g6c+cuiFcgZV2uM7Ps1KX
	RZb1FkijeJI6axSS/t/qazbtr/lTi7lkhuItXZlrSUyYPiTwMeDXHi8f3tZ6gkKSGgvIBhvUSMf
	OHwaUdMBsTf/4CYrNMh5Otz5L+1H+1ms7ixp3b9/+gYglb5Ir2ZbG0OpDIgtBqrU50HO0WaWMuw
	jkKENUfEB4VLQE6tUGQ9tGShWPsUxR2mbGEXA2Nufyn+6Q97FKGhIKRDKcnuUpGz5L0YWLpSUY+
	xZx8nBo7+GCHL1K7SMh9x3yISDiN6HlhCDSLIdPslyGkbtc3g3f1drvTe7qyB9KA9EU1xGK3Vy5
	Cyy7H5Bs0qDv7cnw+C9PTEXwMTUAENtN4bkOmEl6+ROEqLXsAA5Di3Palc0/mzJkebP5Zp/3Zbh
	0FjzNoRMYpuC6GphW5zq6KPZT2UokhIMB3pUy
X-Received: by 2002:a05:6820:820:b0:71b:42de:9787 with SMTP id 006d021491bc7-71b42de9ef5mr3255353eaf.22.1795296660614;
        Sat, 21 Nov 2026 13:31:00 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 07/19] io_uring: pass in counter to handle_tw_list() rather than return it
Date: Sat, 21 Nov 2026 21:30:37 +0000
Message-ID: <20261121213049.1788332-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit 2708af1adc11700c6c3ce4109e3b133079a36a78 upstream.

No functional changes in this patch, just in preparation for returning
something other than count from this helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 runs normal task_work in LIFO order, as it doesn't have
170539bdf109 ("io_uring: handle traditional task_work in FIFO order"),
so call handle_tw_list() without llist_reverse_order()]
---
 io_uring/io_uring.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 96474d9ebef8..ddae460e06c0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1197,11 +1197,10 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 	percpu_ref_put(&ctx->refs);
 }
 
-static unsigned int handle_tw_list(struct llist_node *node)
+static void handle_tw_list(struct llist_node *node, unsigned int *count)
 {
 	struct io_ring_ctx *ctx = NULL;
 	struct io_tw_state ts = { };
-	unsigned int count = 0;
 
 	do {
 		struct llist_node *next = node->next;
@@ -1221,7 +1220,7 @@ static unsigned int handle_tw_list(struct llist_node *node)
 				io_poll_task_func, io_req_rw_complete,
 				req, &ts);
 		node = next;
-		count++;
+		(*count)++;
 		if (unlikely(need_resched())) {
 			ctx_flush_and_put(ctx, &ts);
 			ctx = NULL;
@@ -1230,7 +1229,6 @@ static unsigned int handle_tw_list(struct llist_node *node)
 	} while (node);
 
 	ctx_flush_and_put(ctx, &ts);
-	return count;
 }
 
 /**
@@ -1290,7 +1288,7 @@ void tctx_task_work(struct callback_head *cb)
 
 	node = llist_del_all(&tctx->task_list);
 	if (node)
-		count = handle_tw_list(node);
+		handle_tw_list(node, &count);
 
 	/* relaxed read is enough as only the task itself sets ->in_cancel */
 	if (unlikely(atomic_read(&tctx->in_cancel)))
-- 
2.55.0

