Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A594028CA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149781; cv=none; b=j1rR1Jh1rldEY3DVMrteQIdJYGthVYoqZw9ABV+9Z4+Epa0yfJvOGcafpdZO2XlBqjrnD1RaxjMAfoBFrRl5RLC0sfN8bAG31zV+I1omXLuszxdIjw2RKhwrXhfV9serhRRfKnq6wvx33fbk5mpbnBWlnizukbvIk/TIS0Te8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149781; c=relaxed/simple;
	bh=58zmak3D4O3ScLko3YFxQk7A53rZ4PB381sHrZn1Xn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEPv8d5op1E9dT2OgESWQ01aoaomnvEsPpKNTx0M35abKGxOHhk7xiR3VlOluLZwwjG6jAnCieVWDodiuYIK5Lt7iKU/MZ89jcPMbpw81X9OjDhYu901PWTmive26H59VTdkAJCUxBVyC2F+enyWXYs2uDvW7tHk0YvM6V6EY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxkgHuRk; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxkgHuRk"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so67598366b.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149774; x=1790754574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEde7YfaloBRyUhSbmNY1j2NkDWIsjwrgzwyBWTrgFY=;
        b=mxkgHuRk7jvAftQdmDglaLGhTWlGFECYLREkdvk4gSj6Nh92XCzFTtRaoPgaLM8E3+
         dFxhHuJ0CzRT+3yN775E3y6gj2xSjAf/1RQuTZlnXRGbX3fz3PsiN7rab+hJ2XT3fNA9
         +1GSIcpxAR5JJSF8glxtKq2hd+9nEN+kFY8Dy1VG4LjvkOvaLvrJHVg6HsCTWBwzKOBr
         UWdf8jy85wPKBjJNlkuhUiR01g91JblMz1j1AUz+oabO6O1mqcNuwFA5u/lj1AOh2aw0
         hN7fJD7GYAclIhcu9l4JnFniYjR/qV/ws/3J/pH3J+BuRIveMz73KPScGZrYn8OR+8q6
         ff7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149774; x=1790754574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEde7YfaloBRyUhSbmNY1j2NkDWIsjwrgzwyBWTrgFY=;
        b=iOb+CVBcnb3ob+JlfHIWZevXKX13pjNztMt9RIwZt/8Ikl5oZ2J8Ko7iMpgFq/t04n
         Q9nFLm59CM3FBxGfHgvASQSk+8iTe9AcI097xibWY8SH8c167hXbiUCDuOh5GBzPPg2w
         bioN4QUU5lLMrcTP9IwX2R6U1RA8b05qmo90Dv4fBcP89KAbxr4OxfjcuHYoghM1q8Bw
         G99WbZXpcOFc8g2CaOBu9mR7PWjxt2QkXa8RmR4cpxbQoVot/ka1FQ23BHTZukOhlg4A
         PqsH1CquxJziXmDOQAeHerQrhv5H6jgXzlAWv+XTyO2ooE33eisrY2bAfjqK3wcNv+ga
         nWtg==
X-Forwarded-Encrypted: i=1; AKwUvBwhSrUnU8A7xZIroJVRYASyMXX5OxAdVpan8uie+AvZuSOqxfXBEKOKTazm++yjuTDDlZIDt5M=@vger.kernel.org
X-Gm-Message-State: AFuF++k+gmDgxVRx9pIqgrqJg9PhtD11JQU1xzNOC0nbf6ZhoNUeD6T9
	KjYeHg5BRRR9Io/Qt1a8cra+g/dfFwQQo3g+be7ro4EFlBgEIo4tRA1s
X-Gm-Gg: AYBFou1yVikQhuk2v9qDSMHLqx127lHa11lLOssaCgvWran8K4a99vji1gLVPjl35/m
	W5IWz99KpJ6nMtfNZM7lC1IaOV7Q32o1br1aStY4NP06wR7TfK3PGRi8t5MbDQC8tezfPgsjOr2
	evruz3HhwSz8LzAEDSDqESK4bXm0iWzvakCjemuFk2N47s3w5YECB6lfogkDf8dVDq2xSKa5OVr
	6tOVThz/cuJjr/3AcMCPJhsrN4zY0WT9c/yKnAhA6vqq8KuOH2ZQTFJnqlxXkqY99zWxj1yzmm/
	v7oYaYae7fzs4xNHOeiPmkbg2fKnmG9c1RMcYrutzKARe9Okld+JHKukVK63YIrA/lsksZYyFDc
	Gf3sN3Y6Hco35C2kaiMQQksxRrslv89k71/DxlqDqXIOStGUU1MAbBs3dqFCK0ZMX3gQgGO7xc+
	po0d0kKZXv1hmFVr/DrXeAkxQivCSCpqpYfmyv+7bXi1GQGSYGgnsRvQ7AFqOY1EoBOAqkT8+JL
	YuPgN8V3RPw7ZGab650flUm6icYl/g/Yo/fFdCg
X-Received: by 2002:a17:907:6089:b0:c29:44b0:1428 with SMTP id a640c23a62f3a-c2aae3738e3mr134989366b.42.1790149773766;
        Wed, 23 Sep 2026 00:49:33 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:33 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 5/7] alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Date: Wed, 23 Sep 2026 09:47:48 +0200
Message-ID: <20260923074903.862898-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074903.862898-1-linmag7@gmail.com>
References: <20260923074903.862898-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uniprocessor flush_tlb_page() in asm/tlbflush.h has the same wrong
test as the SMP one: a targeted tbi() is only guaranteed to invalidate
the intended translations when the target mm's context is loaded, but
the gate is current->active_mm, which a lazily borrowed mm also
satisfies.

Test current->mm instead. The else branch it falls to already exists
here, so unlike the SMP side this is the whole fix.
arch/alpha/kernel/smp.c is not built with CONFIG_SMP=n, so this is how
the same defect reaches a uniprocessor, where the flusher kworker
necessarily shares the only CPU with the writer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 0c8529997f54..9ae1902faf8e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -87,7 +87,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (mm == current->active_mm)
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm)
 		flush_tlb_current_page(mm, vma, addr);
 	else
 		flush_tlb_other(mm);
-- 
2.43.0

