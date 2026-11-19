Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079906;
	b=B8wzJkmrKxBnvx0dW0HlfyBhyd4FIoP54ua8siSxmUWtuE0ix25zo5DHb9ssVqL9kgdi
	 eDhLRrIik6K8ScEl+TxWQG6ZCnjUaL1rcxpxljjZkBj5vKM+sobCQJmI9fvcXdb8qljl9
	 Whh616fp8s/vIUcNhLFcEmwNQ3tcNLyHDqlp+6SqposmFD3W5R/H9bpRjLj2QoB3F4/0R
	 WU45QgGm63DK2UsZSfISAGeZpn9iCOOKM4lXtRchoSc0461o+w9YRV8xNlQPIvr99IHVU
	 2i+KX6Iho3dOoUl2G4UWboD1RQFkZp5liBhhEHEr1qz8hcLpMFv8c+d0TgS9eg2vM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079906;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iSVxYVewHdrNAA/zA9iTU0SwXTokhEOkG37PjddJWpY=;
	b=jpgWo62JcOVlqDAytSpjfTCn4mLB+hOpX2oHpD7AkyEAvaxAurYCtQRhQ8vSjrPKW0Y9
	 xi8+C/jJFCI2A4NshSoxVsp30bMwl3NtxgxoLEkh3jZs9kmzHWI/g/ei8K5lu0gc25Ee+
	 sq3bHfDlhjPrzm0nzAyarxYFeuQLfY6R49YVk+2gGbDX5pSnEEncaQfD7E0CKux80Tikk
	 C0WfDOHIYS2ljIa7sTT5LUEfFBJyoCMLLvnRzYBiQVe2qvvh4RyEHN8EWqlO+rU6TLUVS
	 Hom217+IjrTGk2l2JPaU54tZVgdoXOMrPnS6NkLAsG61+tVnTnLU4pX4Jsv/X7bqv2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRXnAIKm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCF606A326;
	Thu, 19 Nov 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRXnAIKm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612881F000C9;
	Thu, 19 Nov 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079905;
	bh=iSVxYVewHdrNAA/zA9iTU0SwXTokhEOkG37PjddJWpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRXnAIKmqaa6Xz5Q1PZo8++oOWj1elK4J0uQ3uNX5TIfKiTkJwqtiTm2wQ/dczLZt
	 m/YOLU5NQFM0pea3+9OPjALA4FelshvYZcVgp2iMmHie+89jSdmSaG7c0H1bQIzrNn
	 1VCJ2XdIxaKSD/Vca0RCmVw89XnIyxhy36PQtt8JQWV1/fWKj5jYpHRGNQjvqyoQYs
	 tHtFshX2mqV2GtIZAAh+5Ry1oFEfiTbUY6HhobDOd50mwQc46MLsJ0fd0lLbkMh7mr
	 es5Di7beA8iqMvJK7ExEbifvIa6gcEnfYiVYMQ54nfNCqeIwGxjm7U3wnVX11ODDcU
	 jkbFth7g3K5Ug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Giulio Benetti <giulio.benetti@benettiengineering.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] spi: fsl-cpm: Map the zero page's address, not its struct page
Date: Thu, 19 Nov 2026 09:17:13 +0000
Message-ID: <20261119091810.3440619-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
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

fsl_spi_cpm_init() maps a dummy TX buffer which is used for transfers
that have no tx_buf.  Since the conversion from empty_zero_page to
ZERO_PAGE(0), the struct page pointer returned by ZERO_PAGE() has been
handed directly to dma_map_single(), which expects a kernel virtual
address.

As a result the mapping covers a PAGE_SIZE window of the memory map
rather than a page of zeroes, and that struct page metadata is then
clocked out onto the SPI bus for every RX-only transfer.

Pass page_address(ZERO_PAGE(0)) instead, so that the zero page itself is
mapped.

Fixes: 3be6acda8241 ("spi: fsl-cpm: substitute empty_zero_page with helper ZERO_PAGE(0)")
Closes: https://sashiko.dev/#/bug/linux-8dbfe527-3ba3-488a-a6fb-d4ee650b8ca7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-fsl-cpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 23ad1249f121..ccdd62f3c74b 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -350,7 +350,8 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 		goto err_bds;
 	}
 
-	mspi->dma_dummy_tx = dma_map_single(dev, ZERO_PAGE(0), PAGE_SIZE,
+	mspi->dma_dummy_tx = dma_map_single(dev, page_address(ZERO_PAGE(0)),
+					    PAGE_SIZE,
 					    DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, mspi->dma_dummy_tx)) {
 		dev_err(dev, "unable to map dummy tx buffer\n");
-- 
2.56.1.708.g77570a6a1d-goog

