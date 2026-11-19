Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091758;
	b=RVYOtMjYR2yBCP5w+a8//BhTfBLq298efUbl1C4ZpS/uRuVco/SnJIz/jax1E3JmonSe
	 6vNYF5GQeENMlLcP7gJ4bEdklBQaWAX0GobrNcKYbnwdFckEjAKhAPi79eLYJ366O4aSF
	 dbcrE4ZuJwvqTLVMJL/6WccpfPWNgPjWj+zHXRH5oWFDsQYkkZpRv3xqZxUdZGDaNygyQ
	 MJ8p79lqh9YlST53aBXhBCspOWhzAPyRXXoa+Q3x+wPy1DfGjhhNp13Q6AdQwRiJU6oYr
	 Tn+C88lBqwtC/IAxWlR1nzX0H6+CJgwNLtCi1EsGROcWlDvCUkw0jK84XASzOjeCC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tlh0sDqeWlrC+CughwxhHDNVvfwaR9aGAXcv08hxMJg=;
	b=H7AqmPZhFaTKjaW0ro5sUo33StcMtKLXh3ES0soM1ZZokkbPvEP744GL+fwYCeDMlbhp
	 mH6mxQio3EQINRWx0PWDv97Ps99R5ntz33QtSduBvwRYN5R28Un6hnS49bcuA0aEwRm9D
	 2f6Ika5PPCGN7OzLFvmpMylXPjECLEE+4UkT8kD8Ow30aAtWU71kQptfjRIMeyGDf2XrQ
	 3uuAfsiaKorZLRfq1EmiZPHf/pbXJGEmVjRax/cj1azwvCukTkyvt4PD+lzt6+muujglU
	 n97aXRyiMtJi7wxG9yvi9ls0eshIG9Wr5DusIxSb4jwd+dPRcYzq9uR8YTkbP3ThWtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyEHCG7D;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6493606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6493606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyEHCG7D
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38431138772so1058857eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795091757; x=1795696557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlh0sDqeWlrC+CughwxhHDNVvfwaR9aGAXcv08hxMJg=;
        b=NyEHCG7DVoNCj5XQjqnUzUKFjPI7k/LKK/dVBRMfe/Fjv8BNLzGJmk2y+wNXFgk6Jx
         lMfEf5G9IsQjJmsrmB8jsDCOb1D3HC2uaWLqdqX8U6zWCsFqUucGwof+50UFwNKKm2e3
         9u4lmcYidTcNGPE69H8nyy0/S5ssQICabReyhztN90UWyRLiSSpnZb3FoSwJEd04UJ8J
         tTPQIDjwd9XFeERuy4TbmByegYnuWvwTZ2qivoX63pjiakxiv1QUcN+8KrdCC/sadozc
         F2P8bQQdVtfeICrVLQHHGIVG5E1UBEhW0bQvacunwWLGO4Pik76bVRsZ3b66QeMOeEsF
         g7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795091757; x=1795696557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlh0sDqeWlrC+CughwxhHDNVvfwaR9aGAXcv08hxMJg=;
        b=J9z9L9LXewU0TE+Lyttm0CpzoNrPOBQJTZPLQOUK46NVF81RG/pJjAvcjXi/CjEWqd
         f/2g90uqarVwzialeHmpLWDEcTJqrj9cNarhgnsHsshXNp9kfyFXmDsngSMgtTJ1Dt8M
         CMLIyfEhZb64kETMcM44TlkcSc82KfV5U5qP2IqZ/ZsvNZxuSvhy129IIAgN832mJCTk
         ksXYo3/dc3OLZmDxNEG152tps69sF86MHO6+IUPZ5tA6LEEQfS1ymfno+6RXemwXDIfJ
         YkIrNRzRUd0aphU3CvVwA6CZjzoeoBgnhNA56Wcg6WjfOrM+e4G+KFcmMpsHX6XubjVs
         35AA==
X-Forwarded-Encrypted: i=1; AL+hErEBKPRJUhZYnus+I07pAWHXi39IusRN9n+6bHgiAGq7OLirTAIl6W09yQ0gmMEa8IBQ84xmomk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aawq5lhLhAfXtwWN2JJvOngVxVY9y6NNtgfIOZDHR3XpcJXMJ
	3Htm1+L/510sVHACKXhDsSIYNQlwtYAcDwh1rgscnU6Yrol631ASYmns
X-Gm-Gg: AZFdTZd0af3YXv33z0kvSjmOo/ORPD+XfEbgFSb5xuQDhr3lE1ymeh9ja3S/9189HCl
	fFK0nGW6PZ65uJErzjRmVPCzBz8abaGIjny1VJ9FabGRXzgm59yu+7TWesURJ3ZCofw2iGXXrgx
	W2M36bW0b2Fa7/FbC2DlJ/nUn7Y95BYx23ZwYopBXS8mMUBe4hMNjSYahHTJkiCuihqeBFb8mnO
	gEfazR/I+MYGcQKhCzw/y77NukxnFUCUHpSyACWQkbaasj7UpweCnYYwYZHt6ltpBBaPl+TrNLg
	qqz+iXXrMlKbQ96S5ih/95wC6QP9Jeuv5IWwj5KnRHMze4CSl+ljk1hNi/LxPKaSkfdKHDQ4FmE
	34pEZiu6GkZELl6FuSgL2YTsRjr2tmKfn36/+aa4un2Y9JKwbvNFY4NigRBB6neR4k2wd5hCvKN
	PkH1/4Z9zW5414cp5M736DaXnBU0kQkDAw8vaheyl64E8mXyKZn21K802BUwx9LrqxbvjqHzEjC
	KVTWBb5XNCVNsVRRQ9dSh11Sqmq8rSNWOHTjkXUG16ukqPGN9cI4GiuLb9kCvopxiEnB8WSt2ly
	eHULE8nbWBxk81jVibtc+OF6W+SVT3TrXzQhDy35gkQOUoILC+FigA==
X-Received: by 2002:a05:7300:b594:b0:381:5fe2:8008 with SMTP id 5a478bee46e88-38281eebbb1mr6690547eec.39.1795091757005;
        Thu, 19 Nov 2026 04:35:57 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm26605762eec.5.2026.11.19.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:35:56 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: venus: hfi: check the write index against the queue size
Date: Thu, 19 Nov 2026 20:35:52 +0800
Message-Id: <20261119123552.1378131-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

venus_write_queue() takes read_idx, write_idx and q_size from the queue
header in memory that the firmware also writes. It checks q_size and the
write pointer against the queue memory size, but not write_idx against
q_size.

If q_size is below write_idx, len in the wrap branch underflows, so
memcpy() is asked to copy almost 4 GiB. It reads past the end of the
packet.

Return -EINVAL when write_idx is not below q_size.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
nothing with this patch. Not tested on hardware, only compile-tested
with W=1 on next-20261116.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Cc: stable@vger.kernel.org
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/media/platform/qcom/venus/hfi_venus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index bd82066bb6e77f6..662b7e89a53229d 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -190,6 +190,9 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 	if (qsize > IFACEQ_QUEUE_SIZE / 4)
 		return -EINVAL;
 
+	if (wr_idx >= qsize)
+		return -EINVAL;
+
 	if (wr_idx >= rd_idx)
 		empty_space = qsize - (wr_idx - rd_idx);
 	else

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

