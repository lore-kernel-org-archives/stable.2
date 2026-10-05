Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96047DD63
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199601; cv=none; b=czDQdYq3t2f4smlt+PapE3qDOZzPVrb+H/D3jO0r1DHHHaCIAMMeqm2an9csQqdo8/0GOfF0ksGEu8Y+O3nMjbEAVJwOvvQYq9oyFJclF1q8EG50noHdPSdDEEefKzoZtKxchHOpjaHQKjOQJ4bo6I7xMPedeouopo7yQ52/d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199601; c=relaxed/simple;
	bh=yk/Cc2UXGQJHNPGD+r0qn3N86ApXOo+zkdin0WsYYT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glARUBue1CfMc4Ce6B3cx4XaclqgJ9/G93q1LNLguBZBZ8H6zJoou3Ohdnq237rRimAHFCICQPYL+Q6IKPAjVEIAC/QYzZvX4h38dUawG7rNKGuwTFn6tUQVDbWNJppP8IyQgpY+nkx30oy7aylycsHfo6P9oGv/mYqtHE8hf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3mvDxiv; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3mvDxiv"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3115c4451c8so1068758eec.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791199599; x=1791804399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmAdUzfHpXWCcsCDGufdmZ0OVPyw9FksvaDdRfTvduQ=;
        b=R3mvDxiva4mEre220kZ742GtO1GdjtOrUiebPQytFqrsrdI2ABxNZtZZtWDYZlhZ+x
         aFIbu9aiU51qaCKy5VA+vZvdz4WJWVEbEWKqkiXy2jZGOl+D0ZmCrshuTN+AJrtKJgy8
         pesddhRoIJtdPRPqvFgXGzzyglHvR+eOpbLcoO0ZJ03VVJaGe9EiaBMv55Bc7YpoFAXs
         au7xzuMiolrS4WbPCfmgQQRmizTU+eg1ibnG9iwn978ZqMyxt27+5e/O50mGTA3tJRoN
         N4T8zeWRN0yAnhkQsChibrBGZ38pXQTRjNJW/A66gJc1+DpRsdoP0hMVlrPwaIX8pQlP
         LI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791199599; x=1791804399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmAdUzfHpXWCcsCDGufdmZ0OVPyw9FksvaDdRfTvduQ=;
        b=eu1q0p/cX9Ekpuwa+0ufQy0vnmPnMx63NGYJarTLm07nurVeZtpHC5VYwXzZdI8Pl2
         HWbbUsbv7I6KheX6G8RVyt5/nexe7dmROwUO39Pz3GW5dFBU7ftmQSQNC4u7xgeTvkK/
         TaTc4mAr7z6LhGdWJsaG7voZPenVQBGWf4ytcgJuoozhEqVOj2AEScwS1PsNGc3zHPXl
         wos9nI+DssM/zpSOe/LLLgMknrN4hrt8sTON0FS83YPUEeO9rO3kiXU22PNlZyPqsEPA
         5e1jI1wBzaNlpAFBKyaFydLT6c2fXrzpG59JC0o3mhTEcaK9TQq3CiWfbF03Y+m/pcAD
         GGeA==
X-Forwarded-Encrypted: i=1; AKwUvBy/XKfHTDyP8x8Mf/V14dRPH3AVv0Z5sJl55UKEIhzFKaOBCwvMe90OB53Gy2CKZwlspzPNiN0=@vger.kernel.org
X-Gm-Message-State: AFuF++kB2urQ1SGLcvRJGZddY8lhXtgmbOQWRuunvrR/uZNIN33xSbpo
	TpxVVhkszdp7wnGyeBxXvNi9j0AnOcdK2XlP3IB4JU6T2+1TEUL+wauj
X-Gm-Gg: AYBFou3Qw9Fox5DAEXft1RWyTi65a03CqUwHw95DNBZqo7y6iPR+veXF7ToMyB8lxjT
	hlLx13swiPwzOKT6uNBTbXxle3/pwvDWh2m9jvS4YPrFBWeEqtOKSmkgYqoc4w+8/tiHW23vtEt
	XW6ZM1UNJhOutL4JWfuq1tQx8sz0XLepT/M1Lned/5J+XX2E9/UbcLshNsOcZQ/TgNxFucoGCH2
	yxaImC+43mOHnvNfExabA35svcEFs65h+tmJkyasQrWeNeyhuf+IOD2+6WptNU3TIx/YwceWICz
	SyQqIbN6pQPMdlu6OLDEIBoebUYrj4FNlooRYfka1aApQkhF93EHfB3Zdu1Sxnt6EzTCUpXnLT2
	KVapDFyNfalp4LveaWjjym4aSrrnHejmUSald+ru/QBhK0mYTuK21H9Qd/cTKJgBBfA7d3BWA0I
	KZMX65yK89f8f+K4QOpkZcJroD0eq081Njac0a6tLZ74OVy9jT/WON5iItLTB7d9yqjmEZsVRZk
	X/ugB7mNRleDb70
X-Received: by 2002:a05:7301:6195:20b0:33e:61ab:8309 with SMTP id 5a478bee46e88-34db72e503amr14890548eec.23.1791199598602;
        Mon, 05 Oct 2026 04:26:38 -0700 (PDT)
Received: from JMD.localdomain ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351277a2fb4sm14902080eec.26.2026.10.05.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:26:38 -0700 (PDT)
From: Atul Akella <atul.akella@gmail.com>
To: linux-remoteproc@vger.kernel.org
Cc: Atul Akella <atul.akella@gmail.com>,
	stable@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pi-Hsun Shih <pihsun@chromium.org>,
	Nicolas Boichat <drinkcat@chromium.org>,
	Erin Lo <erin.lo@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] remoteproc: mtk_scp: Fix bounds check in mt8183_scp_da_to_va()
Date: Mon,  5 Oct 2026 11:25:17 +0000
Message-ID: <2e32034b79ea7cad99b7ea9edfb8b2ad64f5096b.1791198233.git.atul.akella@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791198233.git.atul.akella@gmail.com>
References: <cover.1791198233.git.atul.akella@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20261005112517.TCcy8Ww9owcTtzKzn2mULhIaaEeS3nhA5ThIABD8zpU@z>

mt8183_scp_da_to_va() translates a device address to a pointer into
SCP SRAM or DRAM. Its bounds check is wrong in two ways:

- offset is an int but is assigned from a u64. For the DRAM window,
  da = dma_addr + 0x100000010 is truncated to offset 0x10 and passes
  the check. There is also no da >= dma_addr check, so a da below
  dma_addr wraps in the u64 subtraction and can truncate to a small
  positive offset.

- (offset + len) is computed in size_t and wraps for a large len.
  With offset = 0x100 and len = (size_t)-0x80, the sum is 0x80 and
  the check passes.

da and len come from the firmware's ELF program headers
(p_paddr/p_memsz) via rproc_da_to_va(), and the returned pointer is
then written to by the ELF loader, so a malformed firmware image can
make the loader write outside the intended region.

Use a u64 offset, check da >= dma_addr before subtracting, and
compare len against the remaining window size instead of adding it
to offset.

Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/mtk_scp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 9751acc2bf83..d18ae676260a 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -754,17 +754,19 @@ static int scp_start(struct rproc *rproc)
 
 static void *mt8183_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
 {
-	int offset;
+	u64 offset;
 	const struct mtk_scp_sizes_data *scp_sizes;
 
 	scp_sizes = scp->data->scp_sizes;
 	if (da < scp->sram_size) {
 		offset = da;
-		if (offset >= 0 && (offset + len) <= scp->sram_size)
+		if (len <= scp->sram_size - offset)
 			return (void __force *)scp->sram_base + offset;
 	} else if (scp_sizes->max_dram_size) {
 		offset = da - scp->dma_addr;
-		if (offset >= 0 && (offset + len) <= scp_sizes->max_dram_size)
+		if (da >= scp->dma_addr &&
+		    offset <= scp_sizes->max_dram_size &&
+		    len <= scp_sizes->max_dram_size - offset)
 			return scp->cpu_addr + offset;
 	}
 
-- 
2.43.0

