Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE3226CFE
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149774; cv=none; b=KWVej1d44BYl/fLutehJhnxL3JPxhBN2bf5umsUpjaXoCwsfe5/odXLV/HuP439W8UrioJMqWS6zPOBSJ1q9g/VlPJI/2EWZURWyO+EIDMoDYdnWrPOW1i6Y/7dp7nJYPKP8bN4bEbG5cN92Z19lFZ4l3xU9RR4iRXExrBHr5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149774; c=relaxed/simple;
	bh=rV7RWdoFSE7TTcY6xh9/dbA9ePyW0VsBW9PqTyH7yDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv/mgnLSVy6E8qs0/QH1Aq5OnA8QlzFGmxZgGSr36vb6c1tpu0Ag2GcZCKdrhaX33rH3ko28eEHMukl6Lcv6HsLCssLlRSKpvhMogjzuW60a35XMXlJcnzb60q+WNFckv3PUqg8Dlr3ELTqg6ev29ld4If6v34I2iV3GBfTVqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m89S7nSn; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m89S7nSn"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so84081866b.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790149771; x=1790754571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRt53aoPzlRbit5NvIEMcjCikEfRg5OTPJqgB/oxcpE=;
        b=m89S7nSniZIdefdrBL+NNredO2+gSxWB4VQGfPq+y8sS26/K03t4Y2V4/i2+23/KZT
         7C/gt35guV5bV9Y27bLq4w4vY6S5WEKSFCf35Itlw29j3AngzcYwwQpOsEW8enX/FfHY
         TKvGqMJW5+k/xE6fBhHBfuF38kAf/l0F5w2FsM1a5GQUta1GCJJRSV6Lmr7zKd2hBq8t
         ezIMgcvWhO+RE0l1k8mtZk17UlqjA4KDFRzEXe9W/GmvkipXxO9jpY3MyKEzz4E3Pale
         lNz79BmThrOqjslkUkHQOwUwge1tH5xF5t55wZM9xvVTq+mqrDWlwel3pM4BeSuQtbkx
         F2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149771; x=1790754571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRt53aoPzlRbit5NvIEMcjCikEfRg5OTPJqgB/oxcpE=;
        b=tu+RdjFBGVv/V+u/yAOfMJ/564Iih/4eSBLRpHjwRaqdTcbIqiX5C7op6GZszvW60R
         /I00nAhrENLjqgoQV29sxkKwaNLTa1o3aC0EQway8voSxuqTkvCQedm1fCN8knkzSo6e
         O6ZFPIE64pkNcGl7mgLseT2jmGuFkfHUY38c7cfcr1ZZXiYQp/o/Oyk18b6YnYi5TfUF
         +xvUK0EgVM1zUi7zxOtAK7W+ne2GLwfvYegpEqBn45lkNIqZM5lnUKEGj88YOv+9wBNt
         29RkAWGWi9c9aE5d6YPUrcuIDakzC9wwuydGi6hzsma/WWk0Qp/q+X5Xj195GdwrjTYQ
         egAg==
X-Forwarded-Encrypted: i=1; AKwUvBzDGlXVzrTPP1NM1l7oNr6f2Xw6N8csGylbvswDq24rhEjbQefVAByN7sAvkgpzaN1W8RnNFIk=@vger.kernel.org
X-Gm-Message-State: AFuF++kBhakAWoPdAN2XWL0pBKZ1r7HR0Ch76PKIiaYh/zlzqy2rgLaH
	bMMrTTyTbXVX2iVGYdOo4p5dQQ/Nzjk9wEViKDTw/hvXl+mi884pBwt8
X-Gm-Gg: AYBFou3yzzEzsWSrCp/OmpjRhawocexoGiZQXwxm1FtwAsqcfvZmZl19/RzdnQ+/aNX
	G4gj1fyBP+OGlntg5eSarKYF0loiTAzLEGVecWke/bu4p+pvc6ZQKt6uUU1mNm1c9dfRdHQqA1z
	yfP6WDVF0dDGjYL37mpeU+kbUHRJD0mx1Ts/ClQummz1v3tNeJh9bgKh0ct06K6lchsGGgR3vtp
	41/mrWJrBhrIbWi32wFT5w5LMTFFUkX+x/DGY6NG4K06ks/Nxfad7PCLlDi1+SHVbHTTR3LFCOm
	GTukKHz0qcYPlcIfo3rVeNdLndaSX/VB3v3FzWp3VaQBbuXnwi4cVvXUvmszRBRhnsAtvcvFLYM
	3/VLEXG9YpIPlXO5LrNMTJ3SlQMCuipZc17q1c/1Np2tC0oHhoUF3fa+gEgrzP+g5aE8dwhwy3C
	WSUeiWdbsEmR1cGZqBqM8iIuwRW4+NVY5a0adXkJZ50p4hn8pvWI+3AP69I06n6h1SVqHYGhrcL
	xLXYTUw7RXsRpF2XeY8c/IByxz1/uW2wiopScgU
X-Received: by 2002:a17:907:d8c:b0:c26:2f09:f2d8 with SMTP id a640c23a62f3a-c2aae2b1335mr126539866b.36.1790149770628;
        Wed, 23 Sep 2026 00:49:30 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm64951366b.15.2026.09.23.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:49:29 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/7] alpha: only use a targeted tbi() when the target mm is really current
Date: Wed, 23 Sep 2026 09:47:45 +0200
Message-ID: <20260923074903.862898-3-linmag7@gmail.com>
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

ipi_flush_tlb_page() gates a targeted tbi() on current->active_mm.
tbi() acts on the address space context currently loaded on the CPU, so
it is only guaranteed to reach an mm's translations when a thread of
that mm is running there. current->active_mm is not sufficient: under
lazy TLB an idle or kernel task keeps an mm as its active_mm while a
different ASN is loaded, so the invalidate is issued against the wrong
context and the stale entry can survive. Nothing retires the old ASN
afterwards either, mm->context[cpu] still being valid, so the resuming
thread can reuse it.

Test current->mm instead and otherwise fall back to flush_tlb_other(),
which clears mm->context[cpu] and forces a fresh ASN at the next switch
whatever is loaded now.

This does not cover a task that borrowed an mm through
kthread_use_mm(): both comparisons match such a task, which has
current->mm set while ev5_switch_mm() has only prepared the PCB and
nothing has issued the PAL_swpctx that installs it. asn_locked() does
not identify that window either, for the reason given in the previous
patch. Loading the context on a direct mm switch is what fixes that
case, and is a separate change.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..1ad448105201 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -669,7 +669,8 @@ ipi_flush_tlb_page(void *x)
 	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
-	if (mm == current->active_mm && !asn_locked())
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm && !asn_locked())
 		flush_tlb_current_page(mm, data->vma, data->addr);
 	else
 		flush_tlb_other(mm);
-- 
2.43.0

