Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296666;
	b=O4AmGicQ44cmSuEUy8lDPWEdymLVcbwV+ulORsuzaFJNtrCRD1k9uuT1LhvhX8BbKlXL
	 QKNjOPWkSvrOANn2El4kNsCV1P+g0ZinO3PHb0OSLHPGJ4kgCMAvF36+LBP/yw/fYjirB
	 ky+h/2TND4KuHgvGyKm6syYBFgM+4ksP5lp5EWkS9fxIHplLAgZnFXOv9ydbOv+a2tIzB
	 sU+aRrPU11yWej9CXB8xycDbFHUz52YTRhVTyS/owCVhAnAyARvpS5Ls8qLMSXfiuEZFR
	 ysczGIWQH2H8Og9I9zwoLTyo5YFEGFE1kUsi12OznJJCiE3HGrJ0ltEdtG7yXkKMpMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BxkNFW7sVIKU+vSLhqvXJJNWi67tlZ/jW97D6uCmjJc=;
	b=T2JBZSXJB6KXV4AMNFZPcX8rWpL2PMugX18OokaAb/Y4Dg69ahlMLpVSkd325/geXZxy
	 bS0O98iprEUl6Qrdg64hi3emP5jb47dr42Ew05hkw0tz8NOj+p8Ql7PRSHnSmeOWGzjcn
	 T5F1NG30iKZOl5NV69M70KxF1xRAPIyllBbsF2e0Pl41alTGlPspXenth2QKR7mwTTS2C
	 Sv++FYrt8aOg8WAT+0dLR5uSBXIZMagnOP/W//a2RVcjOn7pP9rVdV2GeQRN+yLT9vMWN
	 31xYqYqgMYGjYy3gSGkmBwVgy8bKIIchNhhU8AU5WNbTk3fdqkElqaqI6xlVX1GOesA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Mp5Gk872;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF559606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF559606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Mp5Gk872
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so2914029a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296665; x=1795901465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BxkNFW7sVIKU+vSLhqvXJJNWi67tlZ/jW97D6uCmjJc=;
        b=Mp5Gk8726zQTR2+Kvzwg581cujMYEdqcQRos+VF8Pp0Ch8Mk2YNRyCB9xJa2T9OUS1
         DMiTPGX0P3EQNqomXMfwHjAdp4KTZby6H1g1tusvA5BhkbtAP83ssWXUThNRRJCv4Oci
         h9faXOT7WII30U8afKtUTUXVXTa9mSnsurWf7BqUgtYK5drZWj2zZGfurE/vZ096XQIy
         Ax2YUGP2ZVnv5VGR3CvSyT8KLVuuSjUYCBrfoMoxNYZjJuwilWahbTOaREgvbrxG3Xy1
         YjSuSQ7JfH3Ooac7cLWoHb9L5XPCYanKKSkZXadaScf2RmvzmErDokWtT0VMwNcZp0/H
         y5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296665; x=1795901465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BxkNFW7sVIKU+vSLhqvXJJNWi67tlZ/jW97D6uCmjJc=;
        b=tOOkNgzkt35j+PLqZUC2+0Zdb+6/f7SBS5uRip2/lD8GMVWDCnFnfpeF1hP2OUdIeK
         MtRxlaiM64gRVj5MCeU2ByEUnEIPZX6WhpedVRvdRdQJcebD1INy4EqYqChyhZiIG+mD
         gPfdKO85UKoCSAgI8+1UGkTzXF7gZLqIes+GqcItujCQ7AzJ29Q6twAvn3YYiHbBoZ6S
         AzAVm9uucrsdaOrwPCyPPqvT10Dabs8/MptFrQb7jnysU2HomAhNzwHVc2NNLPBjp+fg
         d4li/Tw+tZF4FrqtgJQR2zFtAG/fhijSwSyKD7EoriGG8H+MhjLUWgFiAwVJhX90ekLp
         bDfg==
X-Gm-Message-State: APuU4Z8YRNS13FEZy4GFuacZelZntrWM+AEWnISRWkWzKdmdT2lWAvKu
	K1viWUwYROMUOcEOMo2sTUIDj3CRWxoMjogYMEpDU8R1XQCsrAdlYF7mf7hdoGnL1TGveDpga1t
	rhPBKXCM=
X-Gm-Gg: AZFdTZe0TFbJ0B0GQ31sn4P7Ih9vZfXjV2LaDNob/rzXu3T0hL6e6bJOguQBcN2AXQ2
	kToVo0D1nCRRDIowRCceFzWmHNLliZqguQ37uGuMQzhEcRlCBJh6Cn0XhDDj5+BT0XYSURaYIih
	GpczodPtRWp7RGX+R4JrSBuWrSZunCHUhGHLFsJIzOsJbUx8xO1CMuw+KN9sBdolEUjLoGLwAsY
	q6YjhHh40XgiBCLM6ZLkls4Le2kJ0RbSrEApG0jie6opTq0xv/Mj3GR7ICB36F/9rc59dKHMmgv
	UIwrSuL4HaaJfOTB/S8fTjyDRLc0HYqujyaK89qz8f/ouJaNrBM5bQHE/u1SLPrHJMuDX+v2L76
	XG6iFsCWR0u4/jpgcgpAz7D5LJCE3D7z9x178nakih3jxiMRhxEbXCkURq8c19mkoDIMmxk5ubc
	tcPlw28YOrAdocJEOr6im92NaWFh78Hv9Uw/Qdt8SLEH6HdsJH+yTEcfzEmMLYN7tzU7OROrnCB
	P5uMjKbOrdeTzdY2cq3V9vu4EqI6LU4PJ8A/necx4Q8cs4AWKsj5AUOAKJh4PTF2c8fGW2QAIVQ
	i1e4tB5VZ5P9GUJwrmEvGQ5eFn6Nvcdl5aDWifUGqjfP6O3Rwp0jpZqSSHdkrXlR1gfYLfgvCSN
	yCsCKSB7m8qFENapLopt9W3XEdjRkA7juQgcGe7Xf9NIh1YWki208kZA3Jg==
X-Received: by 2002:a05:6820:c7cf:b0:6da:4b62:b6b2 with SMTP id 006d021491bc7-71b3947b886mr4632991eaf.40.1795296664617;
        Sat, 21 Nov 2026 13:31:04 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 10/19] io_uring/sqpoll: use the correct check for pending task_work
Date: Sat, 21 Nov 2026 21:30:40 +0000
Message-ID: <20261121213049.1788332-11-axboe@kernel.dk>
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

Commit c8d8fc3b2d9d4c81e3d3b23eca504ad713a91219 upstream.

A previous commit moved to using just the private task_work list for
SQPOLL, but it neglected to update the check for whether we have
pending task_work. Normally this is fine as we'll attempt to run it
unconditionally, but if we race with going to sleep AND task_work
being added, then we certainly need the right check here.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 716cb3cc7e2c..ecd336c373b1 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -261,6 +261,13 @@ static unsigned int io_sq_tw(struct llist_node **retry_list, int max_entries)
 	return count;
 }
 
+static bool io_sq_tw_pending(struct llist_node *retry_list)
+{
+	struct io_uring_task *tctx = current->io_uring;
+
+	return retry_list || !llist_empty(&tctx->task_list);
+}
+
 static int io_sq_thread(void *data)
 {
 	struct llist_node *retry_list = NULL;
@@ -324,7 +331,7 @@ static int io_sq_thread(void *data)
 		}
 
 		prepare_to_wait(&sqd->wait, &wait, TASK_INTERRUPTIBLE);
-		if (!io_sqd_events_pending(sqd) && !task_work_pending(current)) {
+		if (!io_sqd_events_pending(sqd) && !io_sq_tw_pending(retry_list)) {
 			bool needs_sched = true;
 
 			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
-- 
2.55.0

