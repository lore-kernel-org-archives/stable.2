Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794699;
	b=AXh99auZ3sC/YGDVD1RF5u8MGc2rCMs3ZvTcyNnfbDtUyWFjode4e77tvuV01GpE9pZp
	 il1ddaMZW1ZLfMNcgpR102uw/Pixr9nDiJcsqbNWhEIcr9+97CcrN45qO7hFriG0hAzsz
	 V5dDvm7aigzp8rnVVSHA74DB0HOg9KVwNl4rzoWcjDEAKEQmP/EG7dwgDjbvRVdgLYUfv
	 bTfZA/OuIHfDQt1CYT1hXNC9U+4JgHMUrbnAfbB/fhH6fLTuBCrYYuW8Ia6hqUZxfXTfj
	 IVp/ENP+yi4tCbKE0oFLmwL8Y7k6CzFWnockNgS1R+xC64DVPVWHJLHOgOzAu7DZP7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Vq0SiGMeLJwIenodVgGZUYIiDAMpKcytjEsIEBfNJlE=;
	b=43xaOx+1KzQlQPRgMtN0ysc9Z3vNiFVT2fKy3o0xVb+xRJyI2TIsbbeL1gDkEQYwKtT1
	 Spx3iBV7Bq5LgIJo3HYvJcwiWvg98i4FuSJhYrJEttU3qndxWxrt9xCcsgf/A4+KSiOGk
	 6sAqFeaxWZuZnVFBLhWuHvB2sWJcY6gsquhRkgAVdyIqbYT+jDxnVXXVbuBlz5PfJeY8+
	 PC/ASTy7l/Gfa09HKTVQkYWBSnxhneYXdAGVSb+7NXxLYaJjHkgRIEXwU+s3QH2S+E2lY
	 6PPLfvSre8KtNshwvj9SckQUMO/PQfzCb593n1lXVhCLMMQiBuYajUWPZkIXkiYIEcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLi471CA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32068606A31B;
	Wed,  4 Nov 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLi471CA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E7B1F0093A;
	Wed,  4 Nov 2026 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794698;
	bh=Vq0SiGMeLJwIenodVgGZUYIiDAMpKcytjEsIEBfNJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLi471CACiKnTdCvn08B7kqta0aEBj2VvHclvkQKyiUocHvz4Wy7xYoK9+WsLhKG/
	 B3g9IWEPBCU4acr3ZWe2bENLCo3Xg+mGBXi7TgardIyGNb3FGqC/IUEn3+4IQfEICh
	 fJFuF5OSfEgkl68Bh+l7tWF7vaitas/L11YQoZ1aKqACgh6cy788XHGrQPRPAHVFoV
	 8zN/vGXtBPPdarcTmZd3eqWBH7qx2y7tcLg7Zu/VZc4o3qxSq09XOvF2zyddDzTYkI
	 CCyDgOz5vdI863KmZH05i8IJpPJlrxeFmHS4gvo9XkD6IkT46ng1ObrfTkC2wIqc0w
	 3MMAJuHYyKMSg==
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
Date: Wed,  4 Nov 2026 07:18:16 -0500
Message-ID: <20261104121816.3726177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104090332.GB30750@lst.de>
References: <20261104090332.GB30750@lst.de>
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

The KIOXIA XG10d reads past the end of a PRP list that completely fills
a 256 byte small pool block. When that block is the last one in its
dmapool page, the read lands on the next page, which usually isn't
mapped. The IOMMU faults it and the controller craps itself:

  arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0001:09:00.0 sid: 0x20900 ssid: 0x0 iova: 0xff7fe000 ipa: 0x0
  nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff

Filling the block requires a slightly larger write, and those became common
with commit 2e8e30b3cf9f ("Revert "nvme-pci: clamp max_hw_sectors based on
DMA optimized limitation"").

Do what we do for other disks and use 512 byte aligned small pool blocks
for this controller.

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

