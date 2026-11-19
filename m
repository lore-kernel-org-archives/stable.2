Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079940;
	b=Z48VC3Cv+lxEU5XcsP95yRw5xsjOQwPt3flR3hycaFsNKMTcbD5CbrMuUndD2a852apj
	 Ap6rZ4MPTgBXhXNp/oFmxxh9bg55z1a9Y1g18lbcfPx0f+ybqzgq1XRsQ/1uB+u42kyyD
	 t0zdpqa9TaEmJI0+sbrURgca7SyI+3VqST5Qo0GoQVyy3aIFq873J1/o6bIDP6zIz3inG
	 ayaeVvcNtE/bKCwGAiTodtY5Qda2YmVqO6Z9YUr/Nca9m8HpIcwBWPhisin8UWEoJtRE3
	 u0irwFpY4szyEJ57F7QM8a/SKD8J3fq0D+KLcWgGSnl6cQsY0YO9Oyn2OUQagV5KYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079940;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wWAHpRMjEIilTLG34gMrrF5Fp3ne+eOLzz4gXxJz6oM=;
	b=IoAM6pjLvp9Y4EGawnrZSLvzdWovo8wYmoQD0v1I4rmC4HzZ+347xR+rip8vyMVI7YPf
	 60bFmzDiJOIzGPLt4kXMo1/2Bkd1y/nBXJdh+iKprHiB+f+EKTkBd+MpmPq4TbD4sSaDm
	 vVRjbQG4tJWGdas25XKj1CY7zc4krwevHIOGS887SijouDVi51OD3JvRFtIhvMfEsHMER
	 U8aiBlqDwxOb85CcSzqv0Zy7ytbivjBMyTuPD7xp/GnzWaliZPKA0devMzcqX3ntbZKxg
	 h20teAULP07ceJb3L5BHvnNCdbCfQ8sDgeYV2Su7bjHu9nKArRB8O9Y0Bk60Mu9QA3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO3U2tRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE260A2600;
	Thu, 19 Nov 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO3U2tRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E371F000C4;
	Thu, 19 Nov 2026 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079940;
	bh=wWAHpRMjEIilTLG34gMrrF5Fp3ne+eOLzz4gXxJz6oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO3U2tRqu5hdUq8RLfE9AL+8v5QM1DBGrFkHLz6okbyF3Yih3Ur3kT1WmETbMtLuy
	 g6kncYPF2cy9PcZG0kGkqtcj/gQNzIO/pcpO3/pSV9IczkyLUW+YRbF3wZHX+SMCnp
	 Ubr8Z+e4RmfVSmrZSkmJOZ8qD+fbwcING/YmcuErIMosTt8P+4/WL8Q+dv/QiRj4xS
	 3rywm6ZydP+iqC6OXBl2Je7qVKnyj0zvm3QuhotvKx8044LQ93KqCEsnglIQXQYKqc
	 FBH1FHQlKv2fXOmZR1BraD59/XZGA7iRCpLtgS4nzUK7AXdLcQ3z7vPBWfxI3xG74M
	 G95Z7MOfIQTsw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Foon Tan <lftan@altera.com>,
	Graham Moore <grmoore@opensource.altera.com>,
	Murugan R <vadivel.muruganx.ramuthevar@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <p.yadav@ti.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] spi: cadence-quadspi: Bound chip select against f_pdata array size
Date: Thu, 19 Nov 2026 09:17:18 +0000
Message-ID: <20261119091810.3440619-7-lee@kernel.org>
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

cqspi_setup_flash() uses the chip select taken from each flash child
node's reg property to index the fixed-size cqspi->f_pdata[] array,
which has CQSPI_MAX_CHIPSELECT entries.

The range check now compares the chip select against num_chipselect,
which comes straight from the num-cs property and is never clamped to
CQSPI_MAX_CHIPSELECT.  A device tree which specifies num-cs greater than
CQSPI_MAX_CHIPSELECT together with a flash node at a correspondingly
high reg value therefore causes writes beyond the end of f_pdata[].

Reject chip selects which do not fit in f_pdata[] as well as those which
exceed num-cs.  While at it, store the chip select in a u32, matching
of_property_read_u32(), so that values with the top bit set cannot
become negative and slip past the bounds checks.

Fixes: 0d62c64a8e48 ("spi: cadence-qspi: assert each subnode flash CS is valid")
Closes: https://sashiko.dev/#/bug/linux-cd463fc8-1b94-4bcf-8d06-fae21b88894c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 844df97111d7..fbb917c104b0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1751,7 +1751,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
-	int ret, cs, max_cs = -1;
+	int ret, max_cs = -1;
+	u32 cs;
 
 	/* Get flash device data */
 	for_each_available_child_of_node_scoped(dev->of_node, np) {
@@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 			return ret;
 		}
 
-		if (cs >= cqspi->num_chipselect) {
-			dev_err(dev, "Chip select %d out of range.\n", cs);
+		if (cs >= cqspi->num_chipselect ||
+		    cs >= CQSPI_MAX_CHIPSELECT) {
+			dev_err(dev, "Chip select %u out of range.\n", cs);
 			return -EINVAL;
 		}
 
-- 
2.56.1.708.g77570a6a1d-goog

