Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8401FCFFC
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757939; cv=none; b=sEO2ise4eyyvN9i/uDp9ar0SsHTzcAw0qxK1fHbCBdq5z34vr0PW6r754TthqXNIFPEb+G4HTVVXBGAu3sshdrROC9S8wAnZhmvQoq7mubPneXPf8nO7wdOVzLbckb47ideLa3DZa+91dav+OrBXxkcxPLw1nOeOfca2LIrlUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757939; c=relaxed/simple;
	bh=mCOXa+UzANBq0YSTWd7h4Gptj1cmZ7Q9m3HFpmaUeyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9Wnln90Sux63CYMcQ3DZQu4GbPl4rueb6+JPcAWFej08CudGv12iP5kMnTiUC4xIv9Fi395pvDIj//5/WTJ/6M07FEQyoFb6dR4q1axAY9D2D6npUrf7fozvzd0JGco8OKwZ7SVrvwuJb3PrHgtr058vS/PDtMVq7j9sUG2jAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cChEtWE1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cChEtWE1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efec2c28f8so10127386d6.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786757937; x=1787362737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0DPz+4csxg4ejb60H4w2G/Kt+5hvp2XVZ2P+UQVR9Dk=;
        b=cChEtWE1wDypLFTDVZvmbKsaRHG6fe1c6ef+TSesD6EFe1y57VCUfeIqFuQvCLbXjO
         NUYp+1DXg9haXqwcdBYugSuPmpVe6QkG4Tagm3KHNkpwpiD/ueMNd/U0AWTtfuuGnlJd
         yzzgCqoz4jUzOfGDhfyoDyIrl7dAHg0RLc7oEzmU5oOppXz329fRquZIbB35kVlMNtGM
         Bw0Ee3q+td35oSwAjrUtQul4/gi1ifG/hoimC9fsx8BUAsWDynqp6qCy/rKu5THbJYTG
         Km8ck/RLIp9UeLXxDudrIuMcASdHilHz3wLqOdgiYRlOKufpuASenbfRN5LNJRC04XsW
         P6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786757937; x=1787362737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DPz+4csxg4ejb60H4w2G/Kt+5hvp2XVZ2P+UQVR9Dk=;
        b=pBk/e6wYvr2dcI0jlSonTADdBfC9SGgrG+81SHcnAV3odilBXYzZ7fetG4bRNP0fzg
         ysE1WcED5z640FL9gFTM3HeE8DCKMBtQ0/SILKSvv3iVlw/ANQKarmowBwHSuOP2E7NZ
         y/VqBriA2003f8+/epS53WOLPirueUTM0mQaJJ6eL1ry+RkWI9aTGeh1Yo1OzEjM0FM4
         bFkEhNJK9SiJ9nM7B1TpVNcNvzhgUg6FQpWdfb/iXIn0u6r2sjHwMwtUixP2/1wCg4GQ
         fp0qu74dXYg9mfiCv/W4WfZcQb0SM5SZlVeJ7o2y74PofeUR3lOnJLghMO+ldBFMmXom
         +hjw==
X-Forwarded-Encrypted: i=1; AHgh+RqGyiJZFU82Q7lBCoAlSZK4csaigFowhRPwma+qTJfDyAqdOISWppDTMPj+O3tjIUwc43nGJu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/fhHTCuXLcSRigX/w+gAW6uUIBLSvIV//OgejWIW9tZQBT2S
	R40VZhG3JPw53guyDIvq9EgjxEwiWj9IpK5NBMOK5VEKjWWqdMlbktC2m2X7YRQR
X-Gm-Gg: AR+sD13mjYIxLw6690KDuL80Q5IG+7aSj/YV5e5TWgKWsVaURoi8ANSNoz8W/F9EZk5
	fnnDK8LzghWmWc3iah063o/xE7RqRu9jRtDzkIIUUnDLtC6VRQKwGb3FWeGUlDxXA6FNmiSWMlm
	JhO9DJavNhxBVxjgvqjgQA4vyCZdCnWzm+OohA09BcWr3puJte+uSJDylSx5otH0wNPjx9t49Vo
	KNrn/y7KrVPC1hM/mhs+M01uwMr+KmyerrbOzwe0Y81p/dtky0+9hpB484nrvzjia60A642AwgS
	rXCtpCppBVPQ4VI7J3FX3ayWATiKGPVk/OTzUNBZ3Ih82auvuNccGMPmJcdMZtlHtwzp/PkC5jg
	zkbqwfyVMTM1uyIy2sv73LFGkFwyYWU4lScf4JWv8JMtuxUkdVfQtfDjyJxKOTCvXJSH4o3JSn7
	XcMAGwr53RatpuKL55T7CogtNRQhwtlAeIWeeFW1wIhY0COoWmvTg4ZGpj2hBgYLg/NBMpsbjDp
	607WmEpRW1D4bEvxGA=
X-Received: by 2002:a05:6214:1316:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-90a91da5cd9mr114078476d6.23.1786757937258;
        Fri, 14 Aug 2026 18:38:57 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9354d2c3sm30800376d6.38.2026.08.14.18.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:38:56 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: viro@zeniv.linux.org.uk,
	r.baldyga@samsung.com,
	balbi@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: fix use-after-free in ffs_func_unbind
Date: Fri, 14 Aug 2026 21:38:18 -0400
Message-ID: <20260815013818.39466-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ffs_func_unbind() continues to access ffs after calling
functionfs_unbind(), including taking ffs->eps_lock for endpoint cleanup.
However, functionfs_unbind() drops the binding reference to ffs.

A concurrent FunctionFS unmount can drop the independent superblock
reference. Either put can then release the final reference and free ffs
before ffs_func_unbind() finishes its endpoint cleanup.

Take a temporary ffs reference for the duration of ffs_func_unbind() and
drop it only after all post-unbind cleanup is complete.

Fixes: a3058a5d82e2 ("usb: gadget: f_fs: remove redundant ffs_data_get()")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 44218be1e676..8acad4564b6c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -4089,6 +4089,9 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	unsigned count = ffs->eps_count;
 	unsigned long flags;
 
+	/* Keep ffs alive until all post-unbind cleanup is complete. */
+	ffs_data_get(ffs);
+
 	if (ffs->func == func) {
 		ffs_func_eps_disable(func);
 		ffs->func = NULL;
@@ -4122,6 +4125,7 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
+	ffs_data_put(ffs);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
-- 
2.43.0

