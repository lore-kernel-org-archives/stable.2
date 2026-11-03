Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745676;
	b=LKpX8SD6PVnMu0UC/nuWxk/RaIORl5KbxBO13NfncliYcnThxlnYPgz+VvOwboelSUb5
	 EQ1kwl4juGWQAgJ8LaKG8R9eNvYS6WyCwv47z3ZdYIN8gStdstcOj+P+6t2fMUO6e6lsp
	 eiS60FKZeq4ztYMffO7Ltdvw9VkOaIFiDi2JJHg7gz8rK6leF8DobKObut5PfVoR/ndAC
	 qjTkhgiQxGJEiF74zGOpgizuEbdR5yHbuJIxUqB6g3yBuqESu8X85ERXCbLhAGVG7VEkE
	 y4KcsohKTSJQUpuThoU8Uy0+bTr7hrDPKWFGherqIreE3rTPz5C4m6sBbJraBh/+HqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MsISqNXakbNMhld7Cj1YhO0/ijK5aJ2Aj3UwQYpgHtk=;
	b=opk5G0xJ3JA2mcVK0uF+etwMD6qNoayiL7G+l2iuQKbFVHTKKqczyFk+TXuZHmf4PP4w
	 sPk+Ws4xOG0HigVflo1mSJUKKwUSpOre5mN6n4H7gMditA5p8daQLh9auDxEvPHwdnTLS
	 F4Stby9irQV6kOuAfBJ8X1Bftqv3yul7/66o81z872/07BROHMk0h6bwl6qOSnpwXhPgM
	 MZcuDikkbQS7wOEgNldtDwDu67eJNnzfLQUqKA26CDfOgKxwQeXAp2zgGU3W1Aar0VHja
	 wuAtTuV/BPB4QlI711wWUNTKgUisDKgDa3CrOHAKC06LlqxCeIFahC1KPQzobud1G3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="He/lVY6a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B4606A31B;
	Tue,  3 Nov 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He/lVY6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F61F000C1;
	Tue,  3 Nov 2026 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745676;
	bh=MsISqNXakbNMhld7Cj1YhO0/ijK5aJ2Aj3UwQYpgHtk=;
	h=From:To:Cc:Subject:Date;
	b=He/lVY6aY//OeLZRSDNoP2UvpLz5LU320Owc/DkB4d3RyZrV5R9Mqj3CQee2watyR
	 +CDkkTPgd6X8mpE7I6L7VFPR+wU0r1ksn+vJSrAYBRFpWFOz2m840pGVcW/a72XO5a
	 G+Gf9QdRfgsDISnN7wakErFdSPh1wB8mpatmEKuSiG+T29Rb7nu0DLWbkztPEgxsja
	 fxphOQoXAAzAgvTeGXsxCJMNWvGpevyfE473f/AZr279ZvC90hd3XAO4SbD43+nNZM
	 rHFf1LTBXM0y1AkhB6XYjxJkY9LRBYwoMHwKr9YOGtDxlJbUfW0+aDwp4r2n/3tu0D
	 O26RngXv2D9cQ==
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
Date: Tue,  3 Nov 2026 17:41:14 -0500
Message-ID: <20261103224114.1657779-1-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

The KIOXIA XG10d reads past the end of a PRP List that fills a whole
256 byte small descriptor.  If that descriptor is the last block of its
dmapool page, the read crosses into the following page.  Behind an IOMMU
that is usually an unmapped IOVA, and the controller does not survive
the fault:

  arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0001:09:00.0 sid: 0x20900 ssid: 0x0 iova: 0xff7fe000 ipa: 0x0
  nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
  nvme 0001:09:00.0: Unable to change power state from D3cold to D0, device inaccessible
  nvme nvme0: Disabling device after reset failure: -19

When this fired, sixteen 132 KiB writes were in flight, each with a
32-entry PRP List in a small descriptor from the same dmapool page; the
one at offset 0xF00 ends exactly at the faulting IOVA.

Only full lists trigger it.  The 31-entry lists of aligned 128 KiB
transfers land in that last block too, and never faulted in our testing.
A full list needs a transfer spanning exactly 33 pages, such as an
aligned 132 KiB transfer or a 128 KiB transfer from a buffer that is not
page aligned.  Larger transfers get a 4 KiB descriptor, which a 256 KiB
MDTS never fills.  Transfers above 128 KiB became routine once commit
2e8e30b3cf9f ("Revert "nvme-pci: clamp max_hw_sectors based on DMA
optimized limitation"") lifted the 128 KiB cap behind an IOMMU.  Kernels
before v6.4 are not affected either way: their dmapool never handed out
the last block of a page (see commit da9619a30e73 ("dmapool: link blocks
across pages")).

Align the small descriptor pool to 512 bytes, as is already done for
the O2 Micro and Micron 4100AT controllers.  The last block then starts
at offset 0xE00, and the read stays inside the page.

Cc: stable@vger.kernel.org # 6.4.x
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 019a1e3cc0a2..2be6d1a9ad4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4430,6 +4430,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1344, 0x6004),	/* Micron 4100AT */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
+	{ PCI_DEVICE(0x1e0f, 0x0032),	/* KIOXIA XG10d */
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-- 
2.43.0

