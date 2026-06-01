Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAB1E511
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274314; cv=none; b=EUwvPRZ/mDuPLXOjtXeymYuV6nsvcd64yPCvntxN5jQs8SPwBMS9CHsuMNd6W4tpgrOprc1Vthb9xvVbPDEPFxr6a4jTe0NMbZ/pNUfUDRLXaJAT0faxA4VvCO0IarVFxIsiPnYab4qmedrwAeL3Xm6zsNlsp9LAvXeVXuQPBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274314; c=relaxed/simple;
	bh=r9QnXbS/XkVtku61ReWP9gj8rrOBQKSevT7oW9k0b6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR1uwY1vkbUk3ZDY2ZQjgrdg5CrlH2wWQzepE8LdP7wjInA26WcoabURAz+VAG1nwUaz0oe+YjaTXMomsvvLTSjEu/Bi+MHJhMWKzjpE6OCSZd7N2F79SrePpOvEnYeKd7AAYZQuC7bVCXI7k0B9B7itbyFvV8RfJYfoE+FXUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2axhccQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2axhccQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D171F0089A;
	Mon,  1 Jun 2026 00:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780274313;
	bh=l/V1aY8GYyO5z4bYD9aamepkmHBR23qb829t/GwjxdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2axhccQhD1sBfZ4LpZL4Utc7a9uRZBsvoeLSRFWt0OKkCdXkiQpO7fc76xoLQKsk
	 Gcp5ej6p5OQguLjgEJ08sqL0i72Gaf5/NvDs8HwegKc3LB3jQUq1QUvJaM5Phv41h9
	 plbvVRUs4RZtavIWhJw3khKPu6VwdzvFmnDELDojeYVinbsbng0H91hWV5t8mEjeup
	 KmUnULCDXmNLny419AOhBqlAjY+b7t/SQ1EahaTqLzxuU2u8V7BDdCgf5161VqGjJQ
	 W2IqY7OC/WQ8ZfVkMAftojMRpz0qoPoijMQOkqxkzr9vcLqlJPatp+MeFIIDFIR4Ne
	 iH5HVeEzUv8Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] spi: qup: fix error pointer deref after DMA setup failure
Date: Sun, 31 May 2026 20:38:30 -0400
Message-ID: <20260601003830.82222-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601003830.82222-1-sashal@kernel.org>
References: <2026052837-task-immovably-904e@gregkh>
 <20260601003830.82222-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit a7e8f3efd50a165ba0189f6dc57f7e51a7d149db ]

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer (or attempting to release a channel
a second time) on later probe errors or driver unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=4
Cc: stable@vger.kernel.org	# 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260512074334.914735-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2eee5af4cf4b1..4bbee82c5d8a9 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -968,8 +968,11 @@ static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 
-- 
2.53.0

