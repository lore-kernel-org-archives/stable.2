Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337196;
	b=RTmssqeNeshF4yrj9Bpe40byWzj3NQ6CVDfWRma0xl7nmzQ3b4C3lXV85C9r4ietg/8B
	 w0+voqQNJqi4jJ6EsVRx9g27Xu0fEYh9Ul0I0sezJKLb9fTYhWO8LnzWFzIVaglDS6CoS
	 FfgVarDrF+xrpOLVfg1ADVnFv6TZrAUSti/WsEt1TcXcc/01e8ZEUMQW/DIUsNpi+PSTv
	 ZtDllPXds2nuOAX+0a8UzbElR1FAM9YMdfNfYjtM8QfUnlKVRDjCy4Haki6ZARuCWtoMu
	 Q46wcQb997youh4MdCFNFaixcc6fXQP3dfKzqbQzyHUrpLklBtx9PGYcOZiDS9woWHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J0JCqOk9MsUlJRBcvMytjte58L2BcBKtsjrvqwHUUA0=;
	b=fRdYZpDSu+tkpB9dvAS6FGqkGMsj57SyE0u8hBIvZC57la/1OHDuOcb70d8uZ5PK+XIn
	 5csjk+kgFO0OSJHFdCRhg1q1wFVEa904X70Qh8wVSYlFp1BrPSiAamFzPhqy37qY31N8l
	 uRsMQlo3SuIoOwOCLY7q9qvrQzHz/8JkiiynckpBPTUtqFRmz0SyYsQ+hLSNK25kY9vTR
	 djwfi8Q1D9LUHVqbJ5jE7qYsk1b898Nj8YOl1ajBEekSktYPVvXjGJbLf1GFvsZ9CzsPr
	 bhwj146WGkwiukR860+3qPxrJb3spFwzlMjFTKy4CAoD4q6zurzaa/vlvPu2aiieF+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axNWZXIM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41D606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axNWZXIM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5AE1F008A2;
	Tue, 10 Nov 2026 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337195;
	bh=J0JCqOk9MsUlJRBcvMytjte58L2BcBKtsjrvqwHUUA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axNWZXIM3OzNp3JalhdBTN0tdT3hZx1jJ+gKcKKiW5m62NmYlnwoqi68AhjyA44zP
	 PkR/migIfTpPp1+C5vOw/m8sgqh1Gd111SSbCjm57mb+iOaz7JFl0T2bMY/sY914Rd
	 w4QybBatw9Wwk+mgG4UVd+0Jh22tJzMmPJIx/F1aS7gVsgEChTMKy/WX88NoYRotmy
	 aAwiMx/6TxCQWdhdyBifHQZ4FWdN/E2NADVrOl4lXnxYmcWRvjo4780NIeI5polVXU
	 bQuOJJHInIzqQDt6mK/USFMp5tmS/QjyE/8z/cgd24g09XxtUZXf0/QT6h4+knBe+H
	 /NPAe+bUVmc/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] xen/pcifront: check that an AER callback exists before calling it
Date: Tue, 10 Nov 2026 13:59:53 -0500
Message-ID: <20261110185945.3425744-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110185945.3425744-1-sashal@kernel.org>
References: <20261107062019-failed-5.10-3b4854b69ee7@kernel.org>
 <20261110185945.3425744-1-sashal@kernel.org>
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

From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

[ Upstream commit 3b4854b69ee70fffb2fa7acac09e715a7efcbae1 ]

pcifront_common_process() handles an AER request from the backend by
dispatching on aer_op.cmd to the bound driver's PCI error handler.  It
only checks that err_handler and err_handler->error_detected are present,
then for the mmio_enabled, slot_reset and resume commands it calls the
corresponding callback unconditionally.  Those three callbacks are
optional -- the PCI core NULL-checks each of them individually before
use -- and many drivers (for example igb, igc, ice and ixgbevf) install
error_detected without all of them.

aer_op.cmd comes from the shared ring, so a malicious or buggy backend
can send XEN_PCI_OP_aer_mmio (or _slotreset/_resume) for a device whose
driver leaves that callback NULL and make the frontend call through a
NULL pointer, crashing the guest.

Check each callback before calling it.  When mmio_enabled or slot_reset is
absent, return PCI_ERS_RESULT_RECOVERED so recovery proceeds, as the PCI
core does for a missing callback; returning PCI_ERS_RESULT_NONE would
instead make xen-pciback tear the guest domain down.

Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261006023443.338194-1-yhlee@isslab.korea.ac.kr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/xen-pcifront.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 2ad209ba659bf..4bf3406dfb49e 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -609,11 +609,16 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		case XEN_PCI_OP_aer_detected:
 			return pdrv->err_handler->error_detected(pcidev, state);
 		case XEN_PCI_OP_aer_mmio:
-			return pdrv->err_handler->mmio_enabled(pcidev);
+			if (pdrv->err_handler->mmio_enabled)
+				return pdrv->err_handler->mmio_enabled(pcidev);
+			return PCI_ERS_RESULT_RECOVERED;
 		case XEN_PCI_OP_aer_slotreset:
-			return pdrv->err_handler->slot_reset(pcidev);
+			if (pdrv->err_handler->slot_reset)
+				return pdrv->err_handler->slot_reset(pcidev);
+			return PCI_ERS_RESULT_RECOVERED;
 		case XEN_PCI_OP_aer_resume:
-			pdrv->err_handler->resume(pcidev);
+			if (pdrv->err_handler->resume)
+				pdrv->err_handler->resume(pcidev);
 			return PCI_ERS_RESULT_NONE;
 		default:
 			dev_err(&pdev->xdev->dev,
-- 
2.53.0

