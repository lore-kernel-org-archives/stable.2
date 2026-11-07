Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050421;
	b=LLRSfU8Et+M+eYEeCsBGw+Bps9PInPovfB4zEpLODq1R86q3oKTXWWPSyzJCKcx15FEg
	 0TI82+O++CmmJLdWFFN33V0vmMyyGBDFwqfKFxRZ23OlTYIvbyWFjQvTHJ7LRvguTzevf
	 3//dwfuEWUOMyjro4k1ZVPzn3KID7sv5GnXTnZiPejLl3VOUXuMckD1jjG81e16ZGuklN
	 WYNHU5G/44F8wUqHOZL6wsaWQM29/hvgCsDHHgujZGq1o/u6CyfrZThcvXPOK1gPQZBNp
	 HDVev4PRasjrbFKS8Nzk8Euio/1I2nIRY06J2X9TAIXus2AUSCn/IHu8lcmOvdJvqtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GrwVuwNRNdB1Ahwu44IbR12Z7rZxAcnt9yxGc1kOEfc=;
	b=Ay1M80BMp1xnfmcusigG1bfo3YSvu3tJSUMAK3R4IhwdZ5AtGF3K5RiFgRmHXR4DIOCU
	 EzfYz4FEaR9Z+nZpcfd+d5zMEbFXgCkvGkhY49UOJAOnxCvpVb8trYfTHeDUL6ZgCTCO4
	 7tztd8qk9Gm7bnCeBK/e8FGWEq5gNgxs9ajMdjOzEhaG7SSeANGRTqzwSaIYOAa6guOR3
	 gR1sIYOBUBn+mqDaO0ET4kF/rWSfNoLcSSbd3t8n0rUZHGho4tkrgBc4dTybvLYtLj/c4
	 ShJ/7oNKp3zBTRKxENrh4T+sxFS3f4n1kKO2VcRq6AZ5Eu0fS9i8xzoTOcCfEzo99CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iL3nzfNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C82606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iL3nzfNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17131F0089F;
	Sat,  7 Nov 2026 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050421;
	bh=GrwVuwNRNdB1Ahwu44IbR12Z7rZxAcnt9yxGc1kOEfc=;
	h=From:To:Cc:Subject:Date;
	b=iL3nzfNY6ZNsaEIfxB76ghzaPuvoxVCRmBzSoEfcjUSPQgMDPMm/NKINGUyevw+As
	 PGhODYMqH/Wnp/5HR2M/H1xxEw8DgcagraA09mzbNUyEkq650F5xy8HOMbsDTuN5Pf
	 H73MpiNtD1UfZQZ3qilchxkFmenetciKFoskmouO7GW8RBeOuOZCMF23HpgUis2WPw
	 hvSMotgZe4ihB0ELm0B9sntAky+IDuRIRYoYfloA8gdRvhMsRYfdAXD8JVMbJMtkOD
	 i6vsFuwhOuLn5rXzL68EUi+j9BItGzzCI4sGN/5QgIC6H3sWz9Z58qbdrnpjpSPhh5
	 Rh2D8OGDOJiag==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	jgross@suse.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/pcifront: check that an AER callback exists before calling it" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:19 -0500
Message-ID: <20261107062019-failed-5.10-3b4854b69ee7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3b4854b69ee70fffb2fa7acac09e715a7efcbae1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062019-failed-5.10-3b4854b69ee7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3b4854b69ee70fffb2fa7acac09e715a7efcbae1 Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Tue, 6 Oct 2026 11:34:43 +0900
Subject: [PATCH] xen/pcifront: check that an AER callback exists before
 calling it

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
---
 drivers/pci/xen-pcifront.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 0dea8a69fa36c..b8f2921cc253f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -598,11 +598,16 @@ static pci_ers_result_t pcifront_common_process(int cmd,
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




