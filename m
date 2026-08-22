Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAF2FD694
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407270; cv=none; b=PaKv3pclbyHJpTD7TFC25rQy7XF5x0Wq2ZO3PY8jgVk6z3qa0H4isPQ9CpPqLlCcUWr9QwvrEA0Mt195b/QQ2Kzj9Q6Nl1G91R47gR1OeMy2jWQXXdsKYS9EsysX3SQYh2OdAVybbbPOGtOt5EZukZ1nXmwmYfE/FUvivb5Uv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407270; c=relaxed/simple;
	bh=ItAPIJfq+jxhLD6TN4Ax4mr21FpxALWDPXzcFTXc3IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDqmX1ullf3+nH6GEKSAWWOzIZY9fowRm1N9oZlp4yQI8fZHqhyDB0EKVvcD+/6ElY/GyXEWGgTfyRAnjid+eFJtEXyekGCIKXFr4pg98+fUBzG9ulzAM1RWyI9PmIc2VkbVmwsF6Wm35Zpw8Gbbpal60Pzc6yJ0IAtk5PMY0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnJMfj2O; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnJMfj2O"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ec49608332so2215647a34.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787407268; x=1788012068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RAu2d0iA448dCKNC/0dAOo9eNJ/v3Puws2Lutq5hDZo=;
        b=TnJMfj2OInsCpAILIlo2YhMTOXwmMP3OPhvXepJDO6e/kp2VqQeYoT0bjxlle416s4
         TSf2mWyAQ2ajk9YfqSLDeurwqMieKl2cN8I7XBxjEmSg6XQs2H7ykWc0e5MEFwRMelHx
         9VM5jBmwZlgXMAPbGPDSWmvEXbbc2W3NCtAlQnssoiOK81CefZcHpqNq+GTZ+hChHcN1
         WBcKD86OTFGDhiAfMazrRVSLVrVsoW2lukhQVR93lK3Bz1It2LCpj7uxy1yZKmB08Ufz
         1J/g47PJXkvKRXemGNixdRXQ1Phklju5bOlJi/p6hiFqdoclwRX0YHNsecdhWn3rb6G9
         7Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787407268; x=1788012068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAu2d0iA448dCKNC/0dAOo9eNJ/v3Puws2Lutq5hDZo=;
        b=Z5W0+qSwIlYRf9jRRH9Ya56ltDALVYchQQxRt77AIMy4qh2+oS0Z8ksE140zpk9T/e
         sJ6f1QZQKPcziGixN0vCsKJNoVHtjnUs97phDNK7ZVXy5FH6Lql+7cwQ0x76qj5pQOJt
         nOackYK3Pwo0jMTx4SfKAhNN2N8pGuW2dSTfNJBAHfHt4pQbmvYVeHHooX573efYiM/b
         aerKLkbRzMCstV1I797ZVsjwOseasgxlszJlxhcAy+uwMStN023Q/uFO7+1NNQls6lsv
         lw1xCjH7RhDvTMkVdla1nS4arCoYA1wRi0z1SpRp9CvESqsEbLazLTXRx6KCreVYzTJE
         2zHw==
X-Forwarded-Encrypted: i=1; AHgh+RqCxBa8LToHpv2oC44sg0fUBqaLknSEoVQXuTW2hSj8wt2lYzkKahYEuwaKbujc7mSfRd0cg/M=@vger.kernel.org
X-Gm-Message-State: AFuF++nqJgA1/5tEPZbf6lbNCl+903XEKKtS+3hSluSaPtqyB6acUBIN
	minbPRhk+BOv7P6HuXSkco09bc/VboZBU52GwxR/6NXb4EnLfD7YHaQe
X-Gm-Gg: AR+sD10uBGwYUZ5Mn3z/hQS7qhu/YlmXAbfZknflLy91kjk6fMpvMp5OWu+kxzfUCrh
	zYBpQYrLXdb9f5ayww76X7vrgLw4gpeU3qzq+STl3sdc0gLbMhmIruksfcPgj14zjRlYOPFiXGw
	azFLOyJ35kl55eQagtteeLUX1cPswd7P5W3Q1yEojbk7SXMUm6fD6xbL7r9i6vP087YzzY+cD0Q
	T9jBnR5SuTaDKCWnP1KuiWANphVM9QSAjFMDLMOAxXCw3Z1B9hGYyhTuVqJkIFrMGTwPGMUCwWA
	3WC3MBKdBP5WPe8LT90lFequRGJdmRB4Pr8u+56H+Sl015dx2wdQxFHJKG2laAkf/Tiy21AzF35
	RBbb4LNFOtRV+XYJ0kMPWwrzGEq/PoMjOOmao3SyPHvSzUBBIfgLzPD6b9EpR8i3OJEHdHO8xnw
	Fe+y0/WPl7Ita80p+Be5ClswbIfzYXsWduuXb79VNVsCtxJvL1Q09bIcLRZYV78YxG/36chRz26
	0eLfU54H5+RcguK
X-Received: by 2002:a05:6820:1686:b0:6b1:6462:7e4a with SMTP id 006d021491bc7-6b164629665mr9378701eaf.13.1787407267786;
        Sat, 22 Aug 2026 07:01:07 -0700 (PDT)
Received: from White.tail445f11.ts.net ([45.127.44.104])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm7614856c88.14.2026.08.22.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:01:07 -0700 (PDT)
From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	hongbohbli@tencent.com,
	guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] erofs: skip sufficiently large global buffers when resizing
Date: Sat, 22 Aug 2026 19:30:17 +0530
Message-ID: <20260822140017.8119-1-nikhilgurudasani314@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

z_erofs_gbuf_nrpages is advanced only after every global buffer has been
grown. If a resize fails after some buffers were enlarged, a retry
revisits those enlarged buffers.

Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
has no pages to add and the unchanged return value is treated as a
failure. Retrying an intermediate size allocates a temporary pointer
array smaller than gbuf->nrpages and copies more existing pointers than
the array can hold.

Skip buffers that already satisfy the request. Once all remaining
buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
the guaranteed minimum size across the pool.

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
---
 fs/erofs/zutil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index a0ce9226b..6b9bfa2ef 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -79,6 +79,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
 		gbuf = &z_erofs_gbufpool[i];
+		if (gbuf->nrpages >= nrpages)
+			continue;
 		tmp_pages = kzalloc_objs(*tmp_pages, nrpages);
 		if (!tmp_pages)
 			goto out;

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.43.0

