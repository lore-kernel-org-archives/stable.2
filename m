Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD1383339
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272204; cv=none; b=Ju3QuaxBBef1lpE7fH2jsyKciWCD81mmwWa83c2esxd5tIQGfo/YYbiCkDx4QsMFpIDRPXLLx6/e5etWdFMfPWxSD3gFz99UQo7pBHjU55M/0nePBaQiZPr/tdWMmj/6u+aNEauicq8CkgkP6uqHnCUESZoctlnJynpXbyykGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272204; c=relaxed/simple;
	bh=4eRp9ovMmpBudHPEfFmH+GHalK0lB41ROHYez3TAZNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRmSNsxBf66K24V3ExcudOLjxc47Or9zEQ7IZvemfT6emJDU7RiWOnj5+WBNJJKmlL9uR0GtAw2KlGtFKXv2OKrqfQDmmSCn5zS29MbIofvRT3ueC8HbQ3L/24xNTir+O97KNy5YGrhIrhjQ2o1Df/+1Azk9r4urMnn5FPNN9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMhXzdm6; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMhXzdm6"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so2858351cf.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272202; x=1789877002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0RPsG5ANJXum6qiiDCl2HWvCcb2vrljQ6NDoFmQS7k=;
        b=TMhXzdm6RzpAgkxS+iTTvqN3G5kSltF00lFB5Kbi/uQR198rm9I0AR3iXHxhppdPDs
         McHXclarAr14t49ntxVMGEkvpWBKPwtsC2u3zDE6gezdWZq8ja5FJ1X3OOaSBAtzlum+
         HxutLO2DEmZM+6ZRcPK2oS1oKo1tNQ32jgK2ZJuURQEDWvqFsJafhUGVFJQ8UNKW6XKm
         9AHa1lKrQmRjoB+gnH3go/BvzbPnyW5M4YKOrZyFkbKenk2/oIXRTI7PxdT6jezfayZu
         Ip1RsZQ+Pm4wrfCJMJryenGrNSoAAPz7HBkKbp3mzNBHyV72NUBSpjNOLd095WHAASla
         vjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272202; x=1789877002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0RPsG5ANJXum6qiiDCl2HWvCcb2vrljQ6NDoFmQS7k=;
        b=Gj2oTLr78EXqPAk8rMsxaZqGF9Q/2KcVXj3pJdgY0Zgz6JVqsLGcjpatLztyoD/4wu
         MujU8yAg+ZuLQHZMCVAYQGwJLAjeb5wS1rgGvrdUHTHMRD4OCxCLEsB1MLiO3KAXF2rR
         nPSAYKG97DtgtzqONy3oDu7YT+F1MHQaQEXg6GiNZMlzJ42aOCcTcfe/XhZglLIQXE/8
         O+PFhIJqiTwG0ThmtoGXGyXQGwS6SIGTFqMaGxE3ZwjzRAUO2AyGIhfNW6mA8QRyi1aL
         RxLow8NqvgapiQhBCXrbdMfWQzot1a/1FiBu8P9gx6RSi22pNsSNxDFTYGZGJM8KDIJ2
         5u1w==
X-Forwarded-Encrypted: i=1; AKwUvBy47FgaT0NhwiA54/T8Qm0blPaSsUviBuOODD6xqtwr9JT80vg9k8WYw321jeUB4bQ3MfDcR2k=@vger.kernel.org
X-Gm-Message-State: AFuF++kKTrrka+5+oIvjOavNC3U0JHWEqmVV0nIWCuookIxiYGiYYm9g
	dpMJ33QLo2SEUieq8twOBCKbM90bEOahfHyrIzN8DYLAopXtlTUmTOI=
X-Gm-Gg: AYBFou2ftc7W3v+MNmMWUhpf7JtTSbWs8RUIgbw+UnZ8pFTfHjm6GcVhjdtQX6nLaTI
	0q/U2py0VfGnuFjxt/WXIZEyEQ6D0WRrWaiYGJ/AFwfUz2EEXN+B2aI7XUaBVY8OcOVEuudm25l
	zWVpkzi45ucgPA2lmfIYeg9IqGA+54//POgg2HfUDOlXpIKsKLvtBMLhA4HAyRcZEHgVJqpMNHV
	xGaP/dKXwRBwCsLgpRND2FFeJ3PlYuiSNwuv89fOV2Iaz/KN7rhYZnZT2zhn4vcDOCp5UAoVyKm
	Yh7QLglz6oOHlGcw6h4pHZwJxyvdBRwFeG6q4kUFZBKUTSVr4PfQPzwkDkVTX/PJTajC+2A65Jw
	GfOmpv5XejVDv8OD8lQjVEWJM8Fo5gKTsww7NCsRR3E1dxRZv8WdJxSC5sroOk5Z+Y3/iLwEhfT
	+WWlEib9Qb3x3Piof8QxjK/9DTYROIHsHJHIeCxpPAtPgNAfy8Hx6CvDmMEwrixjMLxjuzohDhh
	K8MXDCMG/VteSQd2wFn2aG+ufChAmERzQl9oMIr5FmimHzqZlsJB93L7cL+fTFwTVU3RNd2upvZ
	MXuoWNAIq0YWba4bHEmvWVm0nnla3OkDEA==
X-Received: by 2002:a05:622a:507:b0:527:631:8d6 with SMTP id d75a77b69052e-530c859b38fmr160895371cf.25.1789272202056;
        Sat, 12 Sep 2026 21:03:22 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca460a32sm62329021cf.9.2026.09.12.21.03.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:03:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] pinctrl: single: free the IRQ on domain creation failure
Date: Sun, 13 Sep 2026 00:03:12 -0400
Message-ID: <20260913040312.21966-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcs_irq_init_chained_handler() requests a shared IRQ on affected SoCs, but
its domain creation failure path only removes a chained handler. That does
not release the action installed by request_irq(). The probe can continue
without interrupt support while leaving the shared IRQ action registered.

Use pcs_irq_free() to undo the appropriate type of handler registration.
At this point pcs->domain is NULL, so the helper only releases the parent
IRQ handler. Then mark the IRQ invalid, as the other initialization error
paths already do, to prevent another release from a later probe unwind or
remove.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3e6cee1786a1 ("pinctrl: single: Add support for wake-up interrupts")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4d5f85b7e..e0eb7240a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1628,7 +1628,8 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 					       &pcs_irqdomain_ops,
 					       pcs_soc);
 	if (!pcs->domain) {
-		irq_set_chained_handler(pcs_soc->irq, NULL);
+		pcs_irq_free(pcs);
+		pcs_soc->irq = -1;
 		return -EINVAL;
 	}
 
