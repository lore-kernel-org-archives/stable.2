Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046204;
	b=Fi7glF59x5/xWiwfFZ0wBPwqP28D53NTAJAteihjafk9eYdVAN2krqmDB67en1PV4mb1
	 clfaNZa6LCjtBnssUR3hJd6zK35X6b7BfcV//8SvvKyoUdEmN8bQOGVWNn6Doa5OEiuti
	 KQCqarxYK1XaF09ClDaaQSzXjwzSsRNJLic3Z1g6OeqTUL/R7lhhjdW/FGLJQSBIkV3PX
	 cLVj1sXLBaJfdzxtSaLlk4m9jVqusL1s2A6pjZi0uBQju3+VR2DH8vy1VCgv7Pk1LFbeI
	 FT1MV7WSEljYHeRL5mTYQ+4Alh4M6pmrNKjd6yN1Ofvs4eGNUtXL+G1a3hiWedviGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046204;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nQGRt1NcoRE0YeyBjA9LGd+43QNA7Z3t60QkTXI4WDc=;
	b=dL7WrxQrgZVnTP2eZ3oynVUjqyMnnuhklno37Gl5xiMNLRSEcJI2OQQX5QFezoMvlLm9
	 ebZVHw2V6YCM8L3KyTzddQ3ufW86MID/w8+H9PTxhzP6SZrROPR6UnEY8JHm93fJnoNBv
	 /RCuAQEBhPvS5E1dNEgNPnaCujYAHV5FQEPknWCYawTnR1+fswVG8/4ktmBD6Ts7ohR8f
	 tOHUvT4SNQxSv/KCMWXhYdqo3DZqvm6o4WyJnb04+Tm6iZlhCGlTTu3ypwNtbrkVv0yFu
	 vPDVVYErYt3VjhgOPoMfDP3/IClL2NYcqE2rZPIvxKsZW9MwnQWQcn/pjbOF/TodZgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu2UZxAK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB580606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu2UZxAK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A901F0089F;
	Sat,  7 Nov 2026 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046203;
	bh=nQGRt1NcoRE0YeyBjA9LGd+43QNA7Z3t60QkTXI4WDc=;
	h=From:To:Cc:Subject:Date;
	b=Vu2UZxAKdwbWTohRjH4OakHRh3EpvM3G4Du8b052WqqeQoEYcd1jRhYVHWCke0Onv
	 sv6hBx9minrigMNkfPJJrf9H8WbqnFMld6+EcCqPQOQxQDaKOYx+uXxINBFZZCQ122
	 1/tmHUVy5katoPyzgJhg7AQP1eYNc8bWbIl8qfyLsEMYH8qYBq5hmC+g6lrG4G7R+Y
	 RZ5NNKAQFGP4ANDm8XvE+vGMK/Hi1lQqiAQ6r6YdRXFWYUXZNUNtfbOPiecDgzbYqw
	 tv7CY2NPlzf+m5YxmjcKOfljnzFrXUtQ0eKCF6PawUw7nGgRR4wXYHzDJJnq2mIWCu
	 KCdDF8ycheBJA==
From: Sasha Levin <sashal@kernel.org>
To: kanie@linux.alibaba.com,
	jonathan.cameron@oss.qualcomm.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cxl/pci: Use the Device GPF DVSEC for restricted endpoints" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:02 -0500
Message-ID: <20261107051002-failed-6.18-d2654fa0d841@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d2654fa0d841fa36ffa76577f83a2810d643ae19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051002-failed-6.18-d2654fa0d841@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d2654fa0d841fa36ffa76577f83a2810d643ae19 Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Thu, 8 Oct 2026 11:46:12 +0800
Subject: [PATCH] cxl/pci: Use the Device GPF DVSEC for restricted endpoints

cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
from the PCIe type of the given device, and only a plain endpoint
counts as a device. A restricted CXL device is an endpoint too, but
it falls into the port case and is probed for the Port GPF DVSEC
instead of the Device GPF DVSEC.

On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
shutdown count stays invalid, and the warning complains about a
missing Port GPF DVSEC on a device.

Treat restricted endpoints as devices.

Fixes: 36aace15d9bd ("cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20261008034619.28059-2-kanie@linux.alibaba.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4af165a436d23..5667b4c5a6f3c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -819,7 +819,8 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		return 0;
 
 	pdev = to_pci_dev(dev);
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT ||
+	    is_cxl_restricted(pdev))
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-- 
2.53.0




