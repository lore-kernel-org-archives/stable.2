Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049563;
	b=zlMbJWYRVQqeO4bzHSTKLjM8Ff2Jux81ESzYzSVUtzO5Ajabuhb9tvyRI2g0DpDIKxix
	 ZXSQ2yI9PJ/7h5VhA8U0LzSIyDJrU06FOwAu2E9CmdCUo7tor3s/eo72g/Atv534XU2lb
	 pqj3p4iTQL6E6E+HsuLV01Sx6S7nrzmQHebkSFmtLo3Q2ui0y/+exfS0c5ik5z+OikFds
	 KQB83ZVCriwrIk3UU8JDRbG4gfTaaHF1wDPRU/bQE6PZcroIAaxaN+BUqSiGvsEFKjwC7
	 xVeXkokXG43IcAP5g8m/TUUguyfyVKLPiBOGE4gMCzMQRfX0VCqIEHy8cWfjEO2oXGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Usbzheo2KnjfdqxzPo2P9LPkQEjluR6zK+JUqf+cIzw=;
	b=mMN4KdLIXGIOFOUBbzhKgQzHt+VvBOz4efY3E+LlKJpA7PRI/8c6bhg0VJJ3k5Bxu5wR
	 KAFy0SQDOCmqEgRPou/bPkUwlPkpWOVCx6UBxGK2m2Qkd+Ql3KbvYEJSI3DZlT0Nwbgo4
	 ul6qLSePTJdxmEHzhbzTmK/pgteDIk3sCjf55LwGAZzpsoJI3WXetzYyQvP/Bx16eQPLP
	 88i2qt6DMzVPGWCyXsA9RvbXx8ao7b7TvU4FO4JZBtKaZU1ddGldvAqcihsWtW/Z5T7z2
	 0OnuwNxcorLY4xcwN8QMdc/nY7aLvehfPzFhhefAvdkonYm1K0xTaTvekNgUGeD1/CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZd2IxoN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E202606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZd2IxoN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A61F0089F;
	Sat,  7 Nov 2026 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049562;
	bh=Usbzheo2KnjfdqxzPo2P9LPkQEjluR6zK+JUqf+cIzw=;
	h=From:To:Cc:Subject:Date;
	b=HZd2IxoNvlMt8ZIlHuHXq6474s+hac4Kn6TQsZy5ly2VXNyRXtQkVWAMYk5TpD9vu
	 4dU66ZxDWPVY9I0mqDyUAqf1FIfSI4XVfInwA/7SRFuBVFjN9i13N94KWNk9ju1YHU
	 25zV5Vk/cc8wlFGepVZxPYjTXWp9nKYzUNGIqxxgb0Mx/n9rKclShw5eGYMAlriWDN
	 1JNzVmOU3Y1xdvZfN3FzqgW8QupgENkhFK7UISmJ37y4eryQCXLhVINPkg8JxVE+tR
	 ZSUMZSp6mTAakCAVVFnXolSON80+jr9/YKalU14y39qmTGzlBCbhlIW3nVihLx2JQs
	 MFRq0FoxaThjA==
From: Sasha Levin <sashal@kernel.org>
To: mfleming@cloudflare.com,
	ashish.kalra@amd.com,
	ankit.soni@amd.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/amd: Don't allocate kdump device table from DMA32" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:06:01 -0500
Message-ID: <20261107060601-failed-5.15-bae0d3760661@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bae0d3760661ac77148944e88aafef698cf7b2bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060601-failed-5.15-bae0d3760661@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bae0d3760661ac77148944e88aafef698cf7b2bf Mon Sep 17 00:00:00 2001
From: Matt Fleming <mfleming@cloudflare.com>
Date: Tue, 13 Oct 2026 13:19:44 +0100
Subject: [PATCH] iommu/amd: Don't allocate kdump device table from DMA32

Booting a kdump kernel with crashkernel=X,high crashkernel=0,low on an
AMD system fails the per-segment device table allocation because there
is no memory below 4G:

  swapper/0: page allocation failure: order:9, mode:0x40104(GFP_DMA32|__GFP_ZERO|__GFP_COMP)
  iommu_alloc_pages_node_sz+0x7f/0x150
  alloc_pci_segment+0x4bd/0x650
  iommu_go_to_state+0x213d/0x34e0
  amd_iommu_prepare+0x39/0xa0
  irq_remapping_prepare+0x83/0xd0
  enable_IR_x2apic+0x61/0x370

On our E810 systems, the kdump kernel booted but ice MSI-X interrupts
never fired and the TX queues timed out.

Commit b336781b82cc ("iommu/amd: Allocate memory below 4G for dev table
if translation pre-enabled") allocated device tables below 4G. At the
time, the kdump kernel programmed a copy of the old table into the base
register with the IOMMU still enabled. The 64-bit register is updated
as two 32-bit halves, so the running IOMMU could see a half-written,
invalid table pointer. Keeping both tables below 4G leaves the upper
half zero throughout the update, so the pointer stays valid.

Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
the kdump kernel reuses the previous kernel's table without writing the
base register, so its newly allocated table is discarded when reuse
succeeds. If reuse fails, the previous patch programs the new table only
after disabling the IOMMU. Either way, the kdump kernel's table doesn't
need to be below 4G.

The previous kernel still allocates its table from DMA32, so the kdump
kernel's check that the old table is below 4G still works. Drop
GFP_DMA32 for kdump kernels only.

Cc: stable@vger.kernel.org # 6.18.x
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/amd/init.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1d7b9fe305aca..d5e1acf5d3941 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -628,8 +628,19 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 /* Allocate per PCI segment device table */
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->dev_table = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
-						  pci_seg->dev_table_size);
+	gfp_t gfp = GFP_KERNEL;
+
+	/*
+	 * Keep normal kernel device tables below 4G because a later kdump
+	 * kernel only trusts and reuses old tables below that limit. A kdump
+	 * kernel's new table is either discarded when reuse succeeds or
+	 * programmed after the IOMMU is disabled, so the table does not
+	 * need DMA32 memory (which the crashkernel may not have).
+	 */
+	if (!is_kdump_kernel())
+		gfp |= GFP_DMA32;
+
+	pci_seg->dev_table = iommu_alloc_pages_sz(gfp, pci_seg->dev_table_size);
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
-- 
2.53.0




