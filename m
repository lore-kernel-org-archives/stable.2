Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145123D7C2
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791254134; cv=none; b=IM6QlsBoYIqO6c/3O8N/hmkpPidLz+BwFXW8qriX1L808zKxmlDChEU0rSZMpbuCp9bG/3sFcZ8EGYnqlKzB9En6f0w/NfjqE2/nyMk6zzEo716cqV+YOzYtZ42M5rnmd4y9uzGbRnPojwbnT9DN3qfc8qsWoeR0hpT8ZsR97Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791254134; c=relaxed/simple;
	bh=2HZxPYqTZrR6ALsI0xXWeZdWAffgyHiFjQQOcfsqJNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTDy1CtpXFTkbIgTqrp5GKH3iFLIN0VzRCpR/WfpyM2QlXbNxijdhCnhmZtKtUZAS2eQO2YWHGHjJXsaBETnQEE/qpZ89uxmLSCAZtVWAWrSdoPKnip26wVGjjd3A0lXin9MRfEReYyX8xCs+XaVpFNf6BzjJPxQHVnwbcTJUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=rydYGm70; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="rydYGm70"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1572202a91.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 19:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791254130; x=1791858930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP6Cnv3Px2FrRBwEywG/gOFyPcxASJp/FvTXDyrwt5A=;
        b=rydYGm70fljN9we8/UX3hC3C6GaxdhcpfRCbmIfH3RU2NSzo/8tDmH1DkSQSxdWyF4
         zVxr1QNhfnzMvGqYyuNlcXeg2fgrJg1JDC8KcGLtJFShjhOd0t1VWXRqtRCd5eTP2PS4
         +836h+KvACVZ/o4CahRmaH9O2RBjBjJNKXO/6qB9Dze3VIu87eWr+3Rv4ibo6BTFJFm3
         ujCkmTQtKrjz/VVW1EZcv64b6comEKWNbBOAphHInbjrBauJRvlhOCKfgf8dun2ZmjRy
         3WeDB1xiJ3Z7soZ5uG4W6PuAMExpwpsFrwbueju8MAuFM79I6bVjL2iwdTxfER90VukH
         QFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791254130; x=1791858930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP6Cnv3Px2FrRBwEywG/gOFyPcxASJp/FvTXDyrwt5A=;
        b=zPlgbies9bAtM14Cou3bM+rymdik585Ou5Qurg7FvXu5R0Z4UZJsSsLfReyRrD0H5T
         zpLKD1qCikknnT228viWKLQdPaNSEYNkQ3O8x549zQMk6FzLeWcdJ3tTHpTXlYFKcyKG
         CxoRkpa10cP/thlD0WkqfJK0C288U9uZzTXaPXnGvP+miW3X1dfsyj84BDB5z9xx+Iqw
         6GUOEU01P9SvUSSYKDdl1uS0azi007Fm98w7eRhfa+Ise36mQfdNJj1glPpIcbqYcJBv
         4uzOjMrcokNXBJdj7+MeJnIO9Z7o8aQHTUzfPTy7B6oEWbaEGGGx2bMlfCYE1lv1Z4Pk
         HBVw==
X-Gm-Message-State: AFq9FYJaeZEfjfy63SSZlrxch4fk63zodjsrqK9J+1wnAnQU7KHnSU10
	mmv1z5IJcD3nQ9ERnY7uxEd8xgULcnNYz51C/SNoH94x+X5Rf2zFTvWPvwoH0asgGtQ=
X-Gm-Gg: AYBFou0kL2fFVV6QKbyntMRXoS2iU0+7ED0sTCJM2GkBgu5lR+2VJJfZGgAgKVnt/LQ
	TOZOEjEVrO2e5QM4mt2QTb2Khi0EjkPJFFUiRqZNaS/yMY1sPRDWDK2W7ypJMXq6Q19AT7/3bOq
	vSOmHzv2DtGInl8Vxicyc+ap5vZw+3/6oC8rI3272nvmq8gw+2dcwR+goVKX+7ldq64jNXyKVgA
	bqX+ElNnxusQ+u2U/LlByKCY2hEfhMsyvO+O3zp+VdUCUvLbuMxiHyefI3HLsX3kylTvg1iSYxw
	dh/a2VkYfQ3X9glBeueDPsXdD/fghnwREpaYveyysiXpzuH3uB+sgGAWL9ikfOsaKc40zPXVJhE
	M2RNJFRSDhm48GyCvePH+AABpZ19INvKnQ/a6PWmONGJzoA+0rdbkgKsHd+0Fit3SlsEhLb9TIe
	YGo8CQJ+m61+EXIFy7RJA2WhhqvCTuQ3HJw3CaSvcKKJTPgUmIDY7NzlHFPE1T4Y5DKq2if/Eml
	ny7liy21CyV2lNcd4h3QZU/xN+eoHtF
X-Received: by 2002:a17:90b:4fc8:b0:3a7:f7e7:df09 with SMTP id 98e67ed59e1d1-3a7f7e7e431mr4874845a91.55.1791254129975;
        Mon, 05 Oct 2026 19:35:29 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ef5b60sm15092255ad.73.2026.10.05.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 19:35:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	bhelgaas@google.com,
	jbeulich@suse.com,
	konrad.wilk@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2] xen/pcifront: check that an AER callback exists before calling it
Date: Tue,  6 Oct 2026 11:34:43 +0900
Message-ID: <20261006023443.338194-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2: return PCI_ERS_RESULT_RECOVERED for an absent mmio_enabled/slot_reset
    instead of PCI_ERS_RESULT_NONE, which xen-pciback treats as fatal and
    uses to tear the domain down.  (Bjorn acked v1; the ack is dropped here
    because v2 changes the value returned for an absent callback.)
v1: https://lore.kernel.org/all/20261005133019.284053-1-yhlee@isslab.korea.ac.kr/

There is an in-flight fix for a refcount leak in this same function
("xen/pcifront: Fix PCI device reference leak in AER handling"); this
change is orthogonal and applies in either order.

 drivers/pci/xen-pcifront.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index cffc32d660327..5c6f7796d204a 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -599,11 +599,16 @@ static pci_ers_result_t pcifront_common_process(int cmd,
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
2.43.0

