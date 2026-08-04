Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10E30ACF6
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879403; cv=none; b=rpN0Sfe9JJLzTLI4jjcSzqIMrn6pXMiBKeW7HpLAOiYhj7NSb44+5jk8FghgbT5TN6XSf0mRf4rjH595+dyoDq1uHlBUkwV4gdfS4dEebgUvOOncTTXalrdxpDH/wf+g28RVUCfkRQ9qtGuj2vrBWuykHTgP7fUCZqGKOnGrAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879403; c=relaxed/simple;
	bh=YH1N+wRvSRBpaEPyBNpid6Jr+SC4it0QGTm+4oIdieU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4cZU093Yk+1iBDkM+kMExLaPlJzGQoq0RjWHInsVlJLbGBpnQK30QOL+P6sSXtmwBfKdEFskkwIvN6Gr0hF+7oymwhe1Ehp6yrP8P+UFGrtQXByltjtZtvQZi9dz8OhNRV6RCsVLpmmyfVE85fMr456cpaQ2lZn+sYq9/4G/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxlvdvuP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxlvdvuP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbb7926836eso174868a12.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879402; x=1786484202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRZ9KtvM4Uvs1PJvqeEv2QOFNUN6xaam9dkuxhQtkew=;
        b=mxlvdvuPiwFfsAVbYOPmwiIoy1DyWvlb/PRdydqyzQ5hTwqSh3WUz02E8A8URuUHEh
         IJDFCiu9Rh8uezwIKUkFYaZ7KWfn7H6eQJkvEay6utGPmNJ2UZjRBj/I9NXvAU2b65p1
         wrcCtLb/hdAlqIgg/0xAR8XLpRSVunAFdtrXRxkoYBxip+Tyhf6aZgIaKJGVrcoq7zuf
         a3oQTNc9wo99mYcJp5qbpzdZqDKQbcntpZuyaNNw7AA3V5O+P6H2ZItbs9Tu2m+kS2Zh
         8FIs9OXw+KF8P33VpD+GakZ3Rak8uEwuUPbo5vgBzcVRraGlqNO0/8XkTud7arDBF3zv
         8kJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879402; x=1786484202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRZ9KtvM4Uvs1PJvqeEv2QOFNUN6xaam9dkuxhQtkew=;
        b=EqfJdYRJ8u+kPwIrLNK+eDFGSOvKHchZLPFq/jNVJlnX1yKtBLyX931BlHU8cpYQZl
         ep40LSCER0kfjBPLvsNUn9zmg3fAJhzTVn336IoDMrR+9StLJwZkuq+bH3O+9e7q8FuH
         Rik60Y2QHCL1bb9vY1aY+ozwiFELFOuf0AqopiG5r9qNRSLj0oKQffseuP3M2CQ3PUdd
         hZ2wvmXvjAf+FFoFqMBdAzNIU3XjkgFnEh4QJXgIbCKhtKnst/VOl1YLwjDQmnovrO+O
         K1TlJiJy0XknejouIY/M3X+EJYOUlbopd1nWttG4SIXSgVuqxI1QUknEIAa+mPBILVxF
         QinQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXM+zDWEZwEExl7H6MV5kVgsPDwFloU0x0889LrxOyJrwSdlb6z+WAV/oKzIIqC3n1MsuzUAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSUgA5172TQzINQN1Un4cbTdPrOi0wOxa/L+agkE+JIXonsM6
	w95ZlA6Q8Q0WRYhhi7MNGSQqkBad9K2PUAthB3p70k6P9luxMkoTeNLR
X-Gm-Gg: AR+sD10Nxkk0qyZiHwapt4VFasOXab7lRLFjXrNZ9yx4dAu8Sl7iNBVk0/EiglJx7Fg
	jmkS8cZS/HpB+NfO791ipv/ykewiwijc80UXF17eKfA8b/cFWx0d2kRfp5G/Hl6Xwote/6mIlI/
	N4hRgK1Wl7CurjgCgFJAFDiUGGlRWcsIAfwccUVViMWK4dygO88knwMkLXB1mohLLZCGG9bPBW6
	jJ8WqhRfk8xj5uuspdqUQsr2NbpW7wnDiPnFkftjBHDnkoeAuuSMUtSBT/WJonf4Ayq9/xzTQIt
	E+EGSakC6asN4KXCs8Uv/Pwps6B3754QrkNewqQzK/S52j7jAW3aGIojnyTZG0U2al8tnwIJuEA
	oXp5PmOcAEUTOniB+6GM8bAAGztT9D7j+0uICdxivS/n0kgF9JyaT8Qs4eN7oFiqkwEHPaedmsL
	B8dMJEpInDAoD8OdvBkGP9q3cllk+XaaNKKJnpTycHnnLSw0EUOkdIgHicPE7mBZuOOp+Wloa2m
	GrSL20IQysdZJI6uwuqJZkaeTo2qnJJjTmy9451A9Ns1z0TZGLsDg==
X-Received: by 2002:a05:6a21:7a9c:b0:3b1:a9ce:507e with SMTP id adf61e73a8af0-3cb8607a666mr1715295637.32.1785879401687;
        Tue, 04 Aug 2026 14:36:41 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586777bcfsm12780536eec.21.2026.08.04.14.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:36:41 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet: pci-epf: put CQ ref on create_cq mapping failure
Date: Tue,  4 Aug 2026 21:36:25 +0000
Message-ID: <20260804213626.3410403-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_pci_epf_create_cq() calls nvmet_cq_create(), which takes a
reference on the controller and installs the completion queue. If the
subsequent PCI address-space mapping fails or returns a too-small partial
mapping, the function jumps to err_internal / err_unmap_queue without
calling nvmet_cq_put(). The matching put in nvmet_pci_epf_delete_cq() is
gated on NVMET_PCI_EPF_Q_LIVE, which is only set after the mapping
succeeds, so teardown never releases these references. A remote PCI host
that drives Create IO CQ commands with a failing PRP1/pci_addr therefore
leaks the CQ and a controller reference on each attempt.

Drop the CQ reference on the mapping-failure paths. The err_internal and
err_unmap_queue labels are only reachable after nvmet_cq_create() has
succeeded, so this pairs the create/put correctly.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..794e88d1d9a5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1339,6 +1339,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 err_internal:
 	status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+	nvmet_cq_put(&cq->nvme_cq);
 err:
 	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
-- 
2.43.0

