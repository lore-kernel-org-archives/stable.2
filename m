Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336356;
	b=gnORUM7JGCZDpjNFG0v45Qc+WSmVupHEbXssHc2RZhIueId7ywHecMvMcttinBHJeq9B
	 tnN+0vjiUwsVDz/4FAozwLZMMMUK5ZAKRBYce+i+j4x/3pT5woNhj/QlvcU+63tU7MuyX
	 UA22R682wa455iDGzN/OZv3DU4jExj4ler3F/dy2rUonLH8MOljx5kNUJmBRJqcdcZ5x9
	 wKggoxYjb54Fnaw6UPJBlCHOG8bXthQwtaFmiojpAdgLglWfIH0XOH/xAmo6lpW1qnEgn
	 DLA7GR6WtoMHqemKHyvAHIg4oH0363EDmV/IMs55OsolxBlofXy3gzxvIkecoY1+miw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TcyqcLIgUFxJIDXUK93qdHLVOYF9gDA6eecDi782dU0=;
	b=GNcmL++aIO1EedQuLaJNRKurL9cahDrisOsWNxFQq+x+VSALS2iZX67H1mUiLslEtBTP
	 gHbbx0lE5M0havS5ia1ZMT0gTeryGti5A35Q7fR/sc07hCSl9wtbkMoCR4QbdsLmxWOU4
	 LH+rULBKnW6kAXlMKXvj35S5XzUj8iHVnDVFwu8vhM+H2OhXBt0gnxZRrjrk1ibY5eqFv
	 mfjXZMHePupaVC8csyLwZtyeOtea0zSnjttv7oVBNJ7mjia1HIL9ClK7wcJaGEGk0JQ2U
	 49DjqXe7O6rlLwMJeOWKe/2UUtCJVoyqiCv46kCy+BkUHHU0500QWuhBLJ+4PfXNyJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv5Rk3Y7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C480606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iv5Rk3Y7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697851F008A1;
	Tue, 10 Nov 2026 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336356;
	bh=TcyqcLIgUFxJIDXUK93qdHLVOYF9gDA6eecDi782dU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iv5Rk3Y7pMe28wNErAsNTq1Dg6twpX/2TvcYyNrL4o6gPZr2q6er2ivNF7q65byC+
	 xfbG74Si8dSNzr9UrA+PxlOGXfyej5HEXxhhC6kbm/Ur+w2V/dbjs1WywPff4oxhhy
	 08jm28o7PBFzuHLhUenRe8C/WgXqMr+wjWUVwUiVTe0oIb4mAah9514A3B/eG6kc2P
	 zFM6PxSfV7JZkqCibhXqfK45fBLThTYlaAosJLqLcgpP1g4SgTj7ZCoKb0n1l2mcBN
	 XtlKOwb2ZcF6G0qvTdyEv1sdF5QCblr77eju/j0Mw5602SM611TNWq91TQ8kAnKDRX
	 s89BJ7Iumi/QQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] xen/pcifront: check that an AER callback exists before calling it
Date: Tue, 10 Nov 2026 13:45:53 -0500
Message-ID: <20261110184209.3328253-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110184209.3328253-1-sashal@kernel.org>
References: <20261107060339-failed-5.15-3b4854b69ee7@kernel.org>
 <20261110184209.3328253-1-sashal@kernel.org>
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
index aa3b84823e686..1dac92706f1ec 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -612,11 +612,16 @@ static pci_ers_result_t pcifront_common_process(int cmd,
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

