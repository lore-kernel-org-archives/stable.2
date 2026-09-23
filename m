Received: from mail-dy2-f21.google.com (mail-dy2-f21.google.com [74.125.229.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452833DEFFA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206973; cv=none; b=IK/cLPyAOyE/Sv/Z5NNNBkWsnS6wpaYjvMeZKK0iuVgybkMsDv9diQA132w/LnR6oMukrrw5mQKf0/0OLbPKAPggCcK43vHNzFkEAqdEiDGBA485HnmVhcLyuGjrA1UgJpqVJjOVJyaEyhlfJOuYCjf/orKlbRdRMKH3LMZA5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206973; c=relaxed/simple;
	bh=scApZ48JKByYXRUZuoAY4Adnb7ZBllREjmuuQPO8t9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stpRPjdt1JKwoxuAh7F96JKpewzA1tHsyeUEZNEDxppBpQ6q23j5HgJgGMpeCH+Br6kqvPExTvfi5l3TQ85VfZDLH1Yki+Rl738mUZKlUTfZo2q2MLOA8y/E2t+33+mV0qFrJtFF8fqmhNgUyqAMxDByVTpBYDQFavco1CPYWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKPc4Dzk; arc=none smtp.client-ip=74.125.229.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKPc4Dzk"
Received: by mail-dy2-f21.google.com with SMTP id 5a478bee46e88-33e46a156f4so868537eec.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790206971; x=1790811771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slUIx4ec0Cimq2PSOCuDVhE9ZpRT6hWAlORZbx5Y+H0=;
        b=NKPc4DzkaKK5W5YSGERvMczCWxYJTcu7/b1Yvy9assFL9J4XysT7WqfXnuVUhBr5FC
         6Ij/i4QxDqRzqG8GjnaTmZQqZm9L0h0hRlJifr2ANXcNto4Apvh4ucp7aSkCZVfuUc4a
         ch5laCCNqHWCiRUt93jErBDCJ1NIalHRG55PnBqRtoUAqa+obcCMcf/yJlvLddL/HfWJ
         9kcLAcPlk3tnq2C+UtemLYI1dcfPIM/NShkEMxmKonQLcLmStMaiw/c16AiRatP22bLG
         sY5fnTE+MNkRYv7prKHSb5t0mfNoFrC4L54TLg7b4Cnh1mlpvYgZetQH0wppiUZLtHlc
         SPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790206971; x=1790811771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slUIx4ec0Cimq2PSOCuDVhE9ZpRT6hWAlORZbx5Y+H0=;
        b=KoNoQ194fzYNJyVs3NQcnL0cDWkaw6aFIKSxoFkRb8P2M+0Q0f2F2SkGnDMu7/SGb1
         tfeEKHyJxUUrPu+cBTSwjV3qhlOrj9fQ/4qppPpAQpU3lFws2Z3BZUNq+6pTv5GOegz2
         LmyY2afyBqEe+jm6f3YNyMiJAqyaeZ0OXdKdI803LQXPaCDaE7odASZIYOL4ZfYYwpEg
         +VDbuiX2YqQ4M1jHFNXrBjYfNX1E7HNvRkFPOk5PK125mk6XqAtCf/DewnXluwQLhkAt
         M/RlnkU2QhjwoEJPa2WhV1ElLGsYDflkec1IS63H//suy+6Cxl4ld0PdFqiAHjaGbT4+
         cPCA==
X-Forwarded-Encrypted: i=1; AKwUvBy10WQ/bJf2V3IDF9YnhxRq1/ID4df+f9bLjIg55a8PTTMqmtrXu6U8Oimjb4A1Q7Np+j/G57Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nAdeJBJmB9Bd/OCXg+1QvCAZDCdGOYrNW2X8hqkg9QNpRWaqeA
	I6bGn9MJ2Fzk8lpSbOEijZrnSrYdgaR2kjDdBBwCUah5u7WvhU95c+Q0
X-Gm-Gg: AYBFou1CU++arJsBh5dfe5H1o6pvhskiX3Q/taYhes4XfS6z20aWMFxDKALTlON5NOU
	8VETxeBywDjQrSTsNNcz8zUjUOmWIdWWvTr8rya1maZp4JQVjU690n98C4/tSSfYxoKNE0zXhee
	nnlOmoiXMNSZXYm56i7I2gLLCzaRUw/90e7phYu8mTJ7QHpYSnt4KZvdgOYTYcqEiLlZrx9KuWH
	JQokKLVjEn81M6t17GHIMUrHkOCxYlMpssv3ACd5/F38NXaBizNREYe7D+aqQWXBQskebZiomRJ
	xSdKzLsRG6P5Q17ZWfkFeP32Wk4QbMxZSG3y0HdcNpiVWm0Bxz/BbOy064uOubPJRqypxuKFs2c
	U7gvKwBR5uq1aBc2v/BJxngcg3+xtUJE9n1MiArDdCSTNryFDr63oA2qlvuzcOOwFvqMv28xOv0
	KFdQdkVGC7RBpL1OO9uihaHjBwQrLcm1aVyMiov3fPs5I6IXP7ZrqNbto82fPdilvjpY8Add2El
	aiQJ2a38H3FFjNWIR8UihiGz0yZ1RcIJ2wp
X-Received: by 2002:a05:693c:621a:b0:33b:c69b:7074 with SMTP id 5a478bee46e88-34002be16ccmr527382eec.4.1790206970986;
        Wed, 23 Sep 2026 16:42:50 -0700 (PDT)
Received: from archsung (186-244-17-112.user3p.vtal.net.br. [186.244.17.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e90ec54d8sm9088502eec.0.2026.09.23.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:42:49 -0700 (PDT)
From: Felipe Calliari <calliarifelipe@gmail.com>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	"Sapre, Sarang" <sarang.sapre@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomas Moro <tmorolias@gmail.com>,
	linux-kernel@vger.kernel.org,
	Felipe Calliari <calliarifelipe@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: ipu6: Only call the isys and psys ISRs for their own interrupts
Date: Wed, 23 Sep 2026 20:42:24 -0300
Message-ID: <20260923234224.325504-3-calliarifelipe@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923234224.325504-1-calliarifelipe@gmail.com>
References: <20260923234224.325504-1-calliarifelipe@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipu6_buttress_isr() calls the isys and psys ISRs on every buttress
interrupt, and only afterwards checks whether the interrupt was theirs.
So each isys interrupt also runs the psys ISR, and each psys interrupt
runs the isys ISR, only to have the result discarded.

Beyond the wasted work, this makes an interrupt for one device
dereference the other device's hooks. After intel_ipu6_psys is unloaded,
its adev->auxdrv_data still points into the unloaded module, and every
isys interrupt, e.g. on the next stream, calls through it. This matches
a hard lockup without a trace reported on the first stream after
unloading the psys driver. On a Samsung Galaxy Book3 Ultra,
instrumenting the ISR showed that a 60-frame capture after
"rmmod intel_ipu6_psys" would have made at least ten calls through the
stale psys hooks. The same capture made none with this change, and
captured all 60 frames.

Check the interrupt status bit before calling the ISR.

Reported-by: Mars-Wave <tmorolias@gmail.com>
Closes: https://lore.kernel.org/linux-media/20260922063507.690-1-tmorolias@gmail.com/
Fixes: ab29a2478e70 ("media: intel/ipu6: add IPU6 buttress interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Felipe Calliari <calliarifelipe@gmail.com>
---
 drivers/media/pci/intel/ipu6/ipu6-buttress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-buttress.c b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
index 63197f746..74c191d72 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-buttress.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-buttress.c
@@ -369,11 +369,13 @@ irqreturn_t ipu6_buttress_isr(int irq, void *isp_ptr)
 		writel(irq_status, isp->base + regs->irq_clear);
 
 		for (i = 0; i < ARRAY_SIZE(adev_irq_mask); i++) {
-			irqreturn_t r = ipu6_buttress_call_isr(adev[i]);
+			irqreturn_t r;
 
 			if (!(irq_status & adev_irq_mask[i]))
 				continue;
 
+			r = ipu6_buttress_call_isr(adev[i]);
+
 			if (r == IRQ_WAKE_THREAD) {
 				ret = IRQ_WAKE_THREAD;
 				disable_irqs |= adev_irq_mask[i];
-- 
2.55.0

