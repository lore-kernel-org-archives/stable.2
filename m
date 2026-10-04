Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329371EBFE0
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087999; cv=none; b=XuhefbqrYcFieVsa/4pdedlBuI59Qdlxq/ZsEW3UBLOv2/aiJJ9s9l3hQzfBlNDZjVVt42bCs1RNMs/IOw/kqYJvSPcBWNe/ZSLPlEv5pO8296/MNom0YzdG+e3T9OFkt4MmXFPSnDvmjn0Y30X4nJM5EW9pp6G49+dNdwCYTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087999; c=relaxed/simple;
	bh=SA1v7m8+a2Ph1dwt7YN7E3qaLG1ZxbVKpYnbGXKAW/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IitG4TagZAB6d6/ywlU3/gglnmlo32UDLBkmZsszac/cR5E7NNTTvT4aH1oG0KMfzGr0TKAWEu1xtLTZOHV1qoBpKK9iQsiALIcyQHFcIvzk0lOgMUmaFWeRcKb0iUHBRs1QiOy8Pxo0QOvNiZkjkvU7Z/2JKjvlB1EA3eh5zGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnFiLEzk; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnFiLEzk"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so57002685a.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087997; x=1791692797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rrUctqm6Dy9eiIYp5kLscMDUQowC1+vgzYg3FmL2FU=;
        b=SnFiLEzkqkkkzbxW9u/9f6hORs8lmxrnSxeeeU3rn3SvpDXjLjKZQpsrPuqEqpBxWw
         CAoqvWM1/ey8UCc1yJShtaes1qIci+KRcIGpUCHeOdID/VJngQXAdORX4IlM1fZhik7k
         8/Io+36t0YSu6kW93V2i82KUcz/Qj+gHuNL8qznpCvo10gyBft944Z5ORGhg6syl2yhT
         ldnWeSTN/k0CKgjAM1iL5wg/rC7/Wkj3PDyvm7nnBXNK/yui42FfzPs5fMtYHmRRioz4
         titmkzoI1mOfiOfxEsCoq485vqIFduhpfDYsdUb8grU1qi0fVr427R+rsn7cYdBJjhWw
         5SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087997; x=1791692797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rrUctqm6Dy9eiIYp5kLscMDUQowC1+vgzYg3FmL2FU=;
        b=cn9KH7Xquo6cOPCZ5IQkC8QP1fbCGfTABc1x1K6tldjBeweWS0hb9p/9OrUJxtuNLf
         NHqUKq3lw9EbIo2Hz2ObXPBBKHEpKfChAMJzdOot2llfrUKr18d7qxfEK6M7N4IWCBIg
         D40uqGkYZXbYbp+YVSCOEWzvbmmGHyncVG3xqUru9BC6+hii92x1gKnsmmozJHDAS8sI
         kwJOPRqlCLscHLMYiVsg+PO08DiWqfiimn8HZ6BzndlRQ8MsLqo7F7Pr2XdkO4+pOUeC
         RnquETwpHfNLqKnp8Hmq1fpd6Y1gDBpyxX7Xuhj76iKy7/jyPsSDksOgc7POkFqMs3CM
         WvXw==
X-Forwarded-Encrypted: i=1; AKwUvBxgTAUs5/s6EJGCTmFX9+qU4KgqVwiaJItjIW1hkPpki/5Fi0Zv8W4gxkCMopcAUfTqqyrrtLs=@vger.kernel.org
X-Gm-Message-State: AFuF++nRZQq66kGV04VOFRhAMLOD6tW/Z9i+ScZqMPDIdyG7/py15Stw
	qYVeE+3ZNWymp8zQVWINwgCt2x9DZq/BO1ZoZmHxH8PPYEi2/aDXk3Q=
X-Gm-Gg: AYBFou24u6eIi+SA2V/vte5C0XgbGw/sIRNG7Qo3sZAh83fUHcaLB65vncVSHitNQje
	Wdib3SQy0LdmuzdqtGa381hlqbf0UYhAdQ06gRuD4fpcSspR6hM5Os3tB1R0rPwXZXBkLkuQiBs
	2y9c4BDjeWkEJaAXzuhZwNdTK/ZrfvgXQO6nLE79SW/c4xaVVucZSj7znTpgJUa0A5T3T1f+VQR
	1k9lrnWlMVrhsuGha3LR1ordJiNFg1x/VaWP6244zGIN9JdvvUvYMbwmKvMmSi7HPRTLImmDKrI
	xgAadko3phQ5bMnquQeDrP5axTl5rm59nER3QvAzefgejnzFsoSgIKyWrFJaCboqkMlge8+cHiQ
	bDUGNIu3Bz6V1hf9dWJfZonhZ5sesmehAOtXyy8SioZGK6YeKLA7eKjZPc5RJod/Fnq13qwg4TG
	G8rXZ6qfQrD8qfHxoA6mZzzH1KLBIfgarTILKM/0edZd2ytwlpa0matcr/gkJ2JHzOHILwmSiyn
	0c6WSNYUUkQvz0SfMEtq6q1gRyQ8VUvuAEvpwkOhF3MkmAlbwqFfJ7RJQxQK0CpDYlDX1uHbZ6B
	BOAGQvzE/kLx+d6CX8A6PneSomzQ
X-Received: by 2002:a05:620a:2259:20b0:93c:2dae:ec5c with SMTP id af79cd13be357-93cf188f68cmr935971185a.42.1791087996607;
        Sat, 03 Oct 2026 21:26:36 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e4e57b9cbsm367051985a.11.2026.10.03.21.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:26:35 -0700 (PDT)
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
Subject: [PATCH] crypto: marvell/octeontx - clean up VF resources when DOWN fails
Date: Sun,  4 Oct 2026 00:26:34 -0400
Message-ID: <20261004042634.1130247-1-mhun512@gmail.com>
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

Keep the notification error diagnostic, but run the existing local
cleanup regardless of the PF response. This removes both IRQ handlers
before killing the tasklet and releasing its resources, as on the
successful notification path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 .../crypto/marvell/octeontx/otx_cptvf_main.c  | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index 159c1d290a36..27d7b094c861 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -937,22 +937,21 @@ static void otx_cptvf_remove(struct pci_dev *pdev)
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

