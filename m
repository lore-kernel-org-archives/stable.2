Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461478;
	b=Vu6yWeN4ckwiaLjiwOFGfL+8i7e53pABSbpc5VdoxWDOf2cOAPiTnmRDwn7qJB3KZlf/
	 zhUvNCJQFOkjFAR5/2zn65+WwahMv2YvlbvXYUNyNof9R5vZdpuj2qT78Aqdf1Dc5jCqD
	 MwscZtnrBRRxCUvuVq0uz7y3FqFdnRgW4eR3mIFEd82rp8S6rYhRQFE4Z+V5YxPdCH/tq
	 mg3G+vqxT9V2vq1jQJbzj05O84F0JKolpO8riuXtXP8RDbCDDpCaUzMgH45v8QDxrMXc6
	 fPlyD2eH0e1koICE0dTYlwN8wgPFZczthG25nhS7DPwbrph/62P7YYswFspS+rpzCqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q8DOoHoK2agKTRSI1QvotHZVuC//gdFVWTTraIvdnew=;
	b=Q7vVes+JEBTpKNyBvVOTowXwbbTu9zg1dyk+p6D6sxpIpnu09urs6jUGQ/8aoYGwTv8G
	 42GRiI51oAN4jc7Vyb/MqFBFtJ4N47QRFof/yUlxXwmdBH3SWf8yT8y6TXRhoxldELJzW
	 fkPViq0FyF6kbjFf0+7BxsA8kRZ7YuM0cGf2qZHuOMh9iWQKq5dzYLwAQLGqccEgZZhRn
	 +aVxL6NkVn0wu672JuBSlr/NaiYL/E63bkUcPaJX164/fUkFTYtvzAKCCvZ/7olJODZR/
	 PAr7mBkGByb2v3yjhGI/Dgv0becodOs7/PM7rJh7ckZYWnQDDFxnY5I8kEnrogilMGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzNeHPV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A4606A327;
	Mon, 23 Nov 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzNeHPV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B0C1F000CA;
	Mon, 23 Nov 2026 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461477;
	bh=q8DOoHoK2agKTRSI1QvotHZVuC//gdFVWTTraIvdnew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fzNeHPV13w4KNibNsol2j8hMb7RRqlaH0iq4fUyBySWsSUlnimFPuEH34lMxQkOfU
	 Pidy92HwWabacNwXgBOsn/PShq2nNjdacZSwma6Bk+l0/uy7FN425MU1hl6gRCgtKQ
	 hFp+mLeM/5OVbaM0cKFaCSSPoTZajKKrMYW2SKL/spfu/VshLsr8ZzwFrfR0rof4Ku
	 IPYVNxWWnFC6n+8OkIJwNlPgAXxDEi921R/B1UkoIUJHNGHY1xw52Ckov6IR+yIuKD
	 5Lz9c6kSE5/YPDzPudNW/OilLWKvQjB39dnHqQhz75i3mzu6DsAKopSNOf3Spfe8Qj
	 JQLEzpM+fTFIQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Apelete Seketeli <apelete@seketeli.net>,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/13] mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
Date: Mon, 23 Nov 2026 19:15:49 +0000
Message-ID: <20261123191703.179283-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
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

When DMA channel acquisition fails during probe, the JZ4740 MMC driver
falls back to PIO mode with host->use_dma set to false and host->dma_tx
or host->dma_rx left holding an ERR_PTR() or released channel pointer.
Unlike jz4740_mmc_pre_request(), jz4740_mmc_post_request() does not
check host->use_dma before calling dmaengine_terminate_all() on error,
resulting in an invalid or dangling DMA channel pointer dereference
whenever a PIO data transfer encounters an error.

Return early from jz4740_mmc_post_request() when host->use_dma is false,
matching jz4740_mmc_pre_request().

Fixes: bb2f45927f8e ("mmc: jz4740: prepare next dma transfer in parallel with current transfer")
Closes: https://sashiko.dev/#/bug/linux-735efbcb-99f8-4d4a-8814-aa31e3634f29
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/jz4740_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 923cf1450de5..e398a575f2dc 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -392,6 +392,9 @@ static void jz4740_mmc_post_request(struct mmc_host *mmc,
 	struct jz4740_mmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
+	if (!host->use_dma)
+		return;
+
 	if (data && data->host_cookie != COOKIE_UNMAPPED)
 		jz4740_mmc_dma_unmap(host, data);
 
-- 
2.56.1.750.gf70dc682cf-goog

