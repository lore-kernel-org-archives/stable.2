Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D43C2B8F
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750902; cv=none; b=t82nQU8dPKRwmU9BW6fVPbcNOEN35vRbucGu7tiHNGNR8bY07qCZHSw6FiU/RY32y46qkv6s4YM4RY45j5NKOW6dAMO9hsQLFzLJWzR2kS8zhhU7uR4PdqInp6gptKZOdC6SPUho8TN1v2qBdjyh918QKAwkEvVnNI+zWcnuKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750902; c=relaxed/simple;
	bh=8pPUPEpS4/9H0EzasgtYbbVYQh+w382UIvaqr+P9H7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktTBv1I1YTgWF+dMC9RBuzWMWCNpnosnQjKkql1olMj0S764d4eGoAL5gT2joo0tkyJ2+0LeIRH2nhXPiLKGepCAjvJdrXga9e24oQ4KFyVC7RQMt2nDu1ghskXAC2Ao7fXWcknOf5P0og9FokTPoa1xtHSGBdoWq0dMJnp14sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn00dsAW; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn00dsAW"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9144e8021d3so20686436d6.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791750899; x=1792355699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5hMfMkm1g5zpUNftZ1rPfIr43hX0MYnqvDCNhs3New=;
        b=hn00dsAWdKDDfHwe/LFNImtujQEDBDLVpJWQMZJlEzXYRKxnQFR6nMoU3tU8ASFGYN
         2987sdmASY0VWIcZ7u+vMvEix0hd2ryyCAKRi4mNgxee077jTWhmwJ9IOQjIKK2vGkuP
         5Tp43lVSEt99mKkLSjznrRoaF4bVTU+S6O67AdiK7sggySAJA5fUfFx+y5DwVX9gwxje
         Pi5UZ0QMc+lE20pwiHi1BpZmLkkGks6Az/GjxsbSIIohoQ6HsBrlSwhuMKZOacS62wDq
         Uk0sKtJF4/TLNVQVGlbaCJ2Ukj62BB/dlbob1bCscwqTQbVL9XwKzYPWCseXsN7yDY95
         l/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791750899; x=1792355699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5hMfMkm1g5zpUNftZ1rPfIr43hX0MYnqvDCNhs3New=;
        b=QW2t0lfVn/ZakTOFL/qpwkGKvYjtCVz3AGeovK8Kjk23Dkr7xETVWmGO5rhMmHP+13
         vJweEjS9dlSgfZC8zT7iYu8YRc3Vqguy5WmNWsyw+Bx4KSNlIPQ+nUgfIU1YYxqbuIXD
         7OX2/2aP+e8U/VnzD++SXIIWOjrHqjrTrBteIx0y1ffRttLCWJ12E9k3lyOuNaXK/vHd
         GnnagS7JtnLDm7UzJNygiGmpvtTlEHqqO56gGevlqCArB4+Slsb0QGATpuAAuIV9Sgkv
         DmUVdhRqbdMpQRhtAQ3MtCq08/B3e+2IpuEZl+rWL4KOE0X3QAktMpCz7KgTFh7HbDtK
         xmzA==
X-Forwarded-Encrypted: i=1; AKwUvBzTB3DnzY3rRWwiW/Qj5TfSZQVWP0YwJPlCB2qh8DtplyB8aqMF9zlZmL5CRLPhwYdN+ajiLFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwfa+FjJfOFNd6u3wIG7vN5hblz3z4lOBgM2QqCxphB4LX7ACQ
	9VpJED9EVQMDRQqSamncBZrdEWZ1wUWyEgBF9N8IcFk3RpXiLgPQx8g=
X-Gm-Gg: AYBFou2zAf4lnqgAmFDUYlcx2utiJTt21QI/8SXsYCBJkzyP55E2L2+FeyefdFos55H
	IAHC+ASlL8jzSNPmviNOeTtl+cGHwS1glOR8docA6iWr9czkk9US+XPUNh3i+M+O7WATwO+FElV
	cGqAOnG1fWgTHmIBcH/8W1CKKzhbUpcAGXD2uUuXWWU8QbP/6OBXmegZpRuFq7yj0Y9hEVCvZrJ
	Ms9KiEdcXCLqcWEJ1mO8goJTvf0bZMfFljq7TiKPoEb17DZCXSVluW+3/xjTbpswyL/lfGQO7oR
	9pZ4Hks0y/GHG3fst4TwsUNRx5cJDG5wXQAITzzDw5dmTOrMiR5SZ4GiF9uKHo22a5NCx/DHUco
	dRXH42V9y4qrN2oa7PyaMOks2tLiE8268UYmb1SExxopbg+yebDx6JhhaM/ychuOOFzdy7LgfaF
	VF9x4c/+fL6LHhknIrYdryzsdK14geQyeFccvTa8PYMS2wJqeb8f6NV5hJRmJcxwE6szQvLuWL+
	1FlQCIbEm5QGVSMuGBViis7G8HPqZlA9Gnol2EApTbDpYJ5Y/ZhBhBqiNIlwRTm6XvRs50Ee4Qq
	uADKtoSet4ev7idZmyoVxda7YBe7
X-Received: by 2002:a05:6214:5904:b0:91b:7f54:8db3 with SMTP id 6a1803df08f44-91b7f548fa1mr27453476d6.47.1791750899068;
        Sun, 11 Oct 2026 13:34:59 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501f2e3sm78200556d6.8.2026.10.11.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 13:34:58 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Lukasz Bartosik <lbartosik@marvell.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] crypto: marvell/octeontx - clean up VF resources when DOWN fails
Date: Sun, 11 Oct 2026 16:34:56 -0400
Message-ID: <20261011203456.1879639-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed DOWN mailbox notification makes otx_cptvf_remove() skip all
local cleanup. The driver core still completes unbind and releases the
devm-allocated cptvf, leaving the raw IRQ handlers registered with that
object as their argument. The sysfs group, crypto device-table entry,
software queues and PCI resources also remain uncleaned.

Keep the notification error diagnostic, but run local cleanup regardless
of the PF response. The PF only acknowledges DOWN; it does not disable the
VF queue. Disable the VQ locally and poll its INFLIGHT count for up to one
second before releasing the DMA command queues. Warn if the queue does
not become idle, but continue local teardown. Clear PCI bus mastering
before freeing resources. Remove both IRQ handlers before killing the
tasklet and releasing its resources.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Disable the local VQ and poll INFLIGHT for up to one second before
  freeing DMA command queues.
- Warn on an idle timeout and continue local cleanup.
- Clear PCI bus mastering before releasing resources.

v1: https://lore.kernel.org/r/20261004042634.1130247-1-mhun512@gmail.com
Review: https://sashiko.dev/#/patchset/20261004042634.1130247-1-mhun512%40gmail.com

 .../crypto/marvell/octeontx/otx_cptvf_main.c  | 44 ++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index 159c1d2..047bfc0 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include "otx_cptvf.h"
 #include "otx_cptvf_algs.h"
@@ -930,6 +931,8 @@ clear_drvdata:
 static void otx_cptvf_remove(struct pci_dev *pdev)
 {
 	struct otx_cptvf *cptvf = pci_get_drvdata(pdev);
+	union otx_cptx_vqx_inprog vqx_inprog;
+	int ret;
 
 	if (!cptvf) {
 		dev_err(&pdev->dev, "Invalid CPT-VF device\n");
@@ -937,22 +940,33 @@ static void otx_cptvf_remove(struct pci_dev *pdev)
 	}
 
 	/* Convey DOWN to PF */
-	if (otx_cptvf_send_vf_down(cptvf)) {
+	if (otx_cptvf_send_vf_down(cptvf))
 		dev_err(&pdev->dev, "PF not responding to DOWN msg\n");
-	} else {
-		sysfs_remove_group(&pdev->dev.kobj, &otx_cptvf_sysfs_group);
-		otx_cpt_crypto_exit(pdev, THIS_MODULE, cptvf->vftype);
-		cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_DONE);
-		cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_MISC);
-		free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_DONE), cptvf);
-		free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_MISC), cptvf);
-		cptvf_sw_cleanup(cptvf);
-		pci_free_irq_vectors(cptvf->pdev);
-		pci_iounmap(pdev, cptvf->reg_base);
-		pci_release_regions(pdev);
-		pci_disable_device(pdev);
-		pci_set_drvdata(pdev, NULL);
-	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &otx_cptvf_sysfs_group);
+	otx_cpt_crypto_exit(pdev, THIS_MODULE, cptvf->vftype);
+
+	/* Disable the VQ and wait for in-flight instructions to complete. */
+	cptvf_write_vq_ctl(cptvf, 0);
+	ret = readq_poll_timeout(cptvf->reg_base + OTX_CPT_VQX_INPROG(0),
+				 vqx_inprog.u, !vqx_inprog.s.inflight,
+				 10, 1000000);
+	if (ret)
+		dev_warn(&pdev->dev, "Timed out waiting for VQ to become idle\n");
+
+	/* Disable PCI bus mastering before releasing resources. */
+	pci_clear_master(pdev);
+
+	cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_DONE);
+	cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_MISC);
+	free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_DONE), cptvf);
+	free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_MISC), cptvf);
+	cptvf_sw_cleanup(cptvf);
+	pci_free_irq_vectors(cptvf->pdev);
+	pci_iounmap(pdev, cptvf->reg_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
 }
 
 /* Supported devices */
-- 
2.53.0
