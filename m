Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793534;
	b=e9V2oPbER4HI9nH6kxUEciiuzINVRPqnr50AKUCYl5OhKpBy8DwC+uwgcPX3hl4ZJfs6
	 UmbUwkfSDdEuWRhGE4JcekVh9FZt/WEjvKAF7BkkHU+gyGz3NgCSbYjF62iVtnIMbE/6q
	 D4ii2qWE0fhEK+f/Mnu4zdD7PTSbVONjHpGwRwKHFMVTPhE/cljXR3rVKGaxNg9nhjsvi
	 tSqKrgtuh4jz8sDIBIomNbuKE/Mw8HBLicD0xe7CyatE3uQU5piJk6zRAGbPyiiDDOjOd
	 e6dinedQflgaFI6AL7qkOFCtkvtgJoDzoecgxIl30uk1SYqRjTYoIw5TILdD5pYdybw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G8r4yQOrAcmX2fE4LVBER7tVbHi2beTBJHq1F+6Zxpg=;
	b=z9BYv2bWmyGEc5savJm6CrTFu8YdEb8HUjvojfHuEYnSToCIJs1g/z+ggnnxMX75n3BC
	 hFjh+6r4SXGjAyjrG1uy3qx6EBKhdma1fWiz60vAvFSe6pB6PI5hdxWGDFP78j+thttJd
	 LuzqKwrsZUj04xtAsNhWzWEy06vsaw/DUMjCcYI6ILyfx0UcZf4ekvOy1vr/SX+IIGOOf
	 OkBX04EjtSnAEaX2LSDwUZmpwW4SlasQ8vvJXERxWLFTLdhOh9ykp31zajTQ2Q9Du/Hx7
	 A0NsvE0MkkHdYRMWEnTXeRH+pYTL8G1LP29TysH9umUF/T4QXuu5raV9ryTiAdicd2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHwFSpnu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DA606A31C;
	Fri, 27 Nov 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHwFSpnu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C21F00893;
	Fri, 27 Nov 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793533;
	bh=G8r4yQOrAcmX2fE4LVBER7tVbHi2beTBJHq1F+6Zxpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHwFSpnuJdKlQXvEiupk6O/Ucddiyjg6tDBvhpyD1IqVkbhsIhxOBSE4dZcQhbLY+
	 7KHEFw7LHePd84bzkmHjeVPkTgBtvsncWoJfs8fpP0Od+Joa6o1lNz1QqJqDFdVnxq
	 VgTMuwVFnhk+A7sS73qANSCQwXKaUsSLI2omym2XiXm4FToqfDG6m0a5g9behk7fvX
	 SssnaBR5vyOTaU4QzPZinBZefpq0V3PWReCRtqIrKHYLkEzp1e+llWYKPSpgf9gMXz
	 btxahPa0j1i+YihabNpETBqowW3yWq7i5KMmthF01N8NCUlyfVgHAJG+LdY+v7RcAg
	 IiUhUbQ/cA/Yg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Giulio Benetti <giulio.benetti@benettiengineering.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 01/10] spi: fsl-cpm: Map the zero page's address, not its struct page
Date: Fri, 27 Nov 2026 15:31:04 +0000
Message-ID: <20261127153158.2969573-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

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
2.56.1.839.g22a8290db9-goog

