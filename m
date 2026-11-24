Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497049;
	b=nxM9IR3/8qa/ru40iVjFq4egamRPcPC08VTcdVustlEoDeQ+gPMm5fZYX+nSaEw2z5o+
	 lx9MqdOB5pcxg89u2n+RNC8j4jS3VVdAqxtr9XeqxAlfEsFbrDxUQZy3ze2nWG1C/QihG
	 o+7XQv7mPK0CpDWElYOQKOu71wfPChWeYs2E345Lud1kSRNEN7/2ZVinZkXpO/bce8pi7
	 a6isKMFYgKSLxBYaMlkD+b47LjD8fwDCJpXBjiKU/7+k2CxgjBcmPBadHn5mm3lqE8rCb
	 wGXXp9HyO3YcrzoNENVodNzjcyicUf2PY51xHL+eXMw+8NhbfPciXCV7Do097RtOg+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=;
	b=NPGa0vNLhjX1yCAkUTj9gUNUkNSo8Ih2CyPWLZ6b8DMn407zbD+iaALqCAdatbCP67Gr
	 oon1ePJmiTcXhABPs+YHlXlhB8YAvlJDkHpIt2409dfdU3ftA0HOkHOKOEV91NXedQenp
	 vkgD7313mN8ae2pGVHHXCNxcMcNqRxaHFp9E/x1BIUtj5k3QSEgqVd4DgszH3EmoTwm1P
	 Y/UtbOC7w06FBJ0fWCiozAyFbG1BhjyVJ6EnPzKg2cMAUATiaLfJQaWR4xFdIhJICsQbW
	 c1uQUQeNMFJ+7MemDyPFF8mRvAHEfZzSI6zZIvxQZGaa1VSNSWVOeqWgrPqITOH//kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d5njrxvc;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C12606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C12606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d5njrxvc
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-49e379ab077so3209132fac.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795497048; x=1796101848; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=;
        b=d5njrxvcr11AFcjMsiaCMO+HNsqngn72VeJHvtow6vjLUbXou5ys+72Hhh6z6pdGwV
         gqv3C5dj0I1w0gptlUAFUuIrpcwpp9h6YSRA8QvV+wcKq7gdUnMK4B2LILDm8lu6mme/
         urqS2HAzn8LHGXWURRepiog+L0KKGrHHf3qLMQ5CuvzvUuDWP8zDgOx3frQ7+9yppblq
         DdznBx91qH2DpFbBKD3OYv4wBnS4oUqTfJ4L1dT/cWhEIF4VjNE4qJ6uigSxVphygYny
         DcerVQFJ/zvu6vGb4VqnZTRcnGuwgQjtl9g5IE0b4McUjN8GcTUZiVxDaLdzQ6GeQ/j3
         2EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497048; x=1796101848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=;
        b=zmcUkhFwGoj+dzWnOLJ/TiOEh5pBXzgRelzbydwOl+GqqbkPo79IxIjhytXGSjmSNr
         K3GKIWSirBGl7ntBABK2grPab1ySQrypXdpeOUmw1O478FHafyK8m2wbk3hJt3fleGVn
         zmbqYjVwLPBdxSfX33hCNk09xgVs4rlO0fRme7qzw9GLTYqmij3IJzzJxtMmUPb3jI2V
         DNPYWBgg7EXb7hYkoGtiNzdEtROhzdLN1zJwBA9TmvusODar82Eh0ebPcjyGzWOACSnl
         hKjNBiiuijmRNnbSXYR3hK3GD9vxbEJW//WAJWn0THMHu6GtSzLOUArB54AoIqzEkRi3
         Fj2w==
X-Forwarded-Encrypted: i=1; AL+hErGzFNTVJWqZjLLDvAZCPp2Qax4/wuR13U9aYyv1YkxUO6y4eY4Y78Dn/oyyEeMlLnwCmHomIAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N4rzvQ21OrbiYY7fuiXdHDQTpdg1/fSaLpvZ7EPbWw+zHrMwD
	blBX49bCIYTlDS9RmPmFxMIMHIuv3QKF25Id7LwwL7hQp5TyMziYEdysZEugE7ftsiy1qUbnbZB
	21qh4ZsIr8EY4MSGw1tqCQlfgBeoqWQ==
X-Received: from oixr26-n2.prod.google.com ([2002:a05:6809:29a:20b0:521:880:fa1e])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:150d:b0:50a:6fcf:d287 with SMTP id 5614622812f47-57a0a71ae3cmr14668369b6e.37.1795497047592;
 Mon, 23 Nov 2026 21:10:47 -0800 (PST)
Date: Tue, 24 Nov 2026 05:10:40 +0000
In-Reply-To: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124051041.3099796-2-zhenwenliang@google.com>
Subject: [PATCH v2 1/2] nvme-tcp: avoid overflow in the R2T length check
From: Zhenwen Liang <zhenwenliang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>, linux-nvme@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

nvme_tcp_handle_r2t() checks the R2T length with

	if (unlikely(req->data_sent + r2t_length > req->data_len))

data_sent is a size_t, which is 32 bits wide on 32-bit architectures,
and r2t_length comes from the controller. A large r2t_length can make
the sum wrap around and pass the check. Compare against the remaining
length instead; data_sent never exceeds data_len, so the subtraction
cannot underflow.

The same check was already in the original driver (on pdu_len, then
filled from the R2T); commit 1d3ef9c3a39e ("nvme-tcp: validate R2T PDU
in nvme_tcp_handle_r2t()") moved it to r2t_length.

Reported by the Sashiko review bot on v1 of "nvme-tcp: set up R2T data
transfer in the send path". The patch and this description were
written with AI assistance and reviewed by a human. Build-tested only
(32-bit not tested).

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9b..4fa4b0199dee 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -847,7 +847,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+	if (unlikely(r2t_length > req->data_len - req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
 			rq->tag, r2t_length, req->data_len, req->data_sent);
-- 
2.56.1.809.ga0b61035b5-goog

