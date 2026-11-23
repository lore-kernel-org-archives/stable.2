Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454573;
	b=b6uPWmSNFk3Pu6pDd8vLd4wBtJfDnEg7+1MIG97zl8tCmXOPvswbObDBH8kM8blrsL/a
	 UAKqeGccn3Kiy5HN9V0unb0utD2+GYfsZm7/+ipaOVjpQFmz84a6QKTegIePbXkeeVMdM
	 ctpkwooeQealqf0PUKCsREtgoGH2LTc4AZtWyTbu9UZ35ExAgAxe773fBoSp+wLulBJHq
	 Z17emZ1StvMcSaX7byuQjE21UMgmcHKfKQ0Q3Wtb4QQ/K/uOjaDcAPHGcM4444Wv0k0dw
	 qzUFzLc8fPTz1crQArpGSZQCJOuX3j+OjzcEOk0K+yVhflfk+Uj/phQE49FyoWCRIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3FMYFsYc+wva2H/zEk/C4iK7aMpqtATF1UrEYEweIaM=;
	b=JA6VAqpxjEytRqFiLZxmS/3WkX6NuUwCdPBfJYZxLY/A4d64WH6B/JVi/6Ji2mztmKwf
	 waP1SwWFvRiLTlUsz8DSCv8zjLZ9Qz0Cd5dyWYG0Btz8DLbVkBs0DVNvd27zgD9r5qgu/
	 TreujJ6IzSk90FZzqqBzdQir07epKqrIWUjuXa+2ba6vhuSUyaRR6Aum1VucaAZWFLIMv
	 0yq1IXGWyI08g5MXbH9/CH9injgq4ZljZag8UO2lPv/FoKbkW2L7z0iOv/Z1+DYwehTwu
	 feuKK6LZtjcChnVpS8E+IOBcHlbUNvPH4K2UtYIEeeHD6o/y862qH8AiDh8xeRoiJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mPnPtLD/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40226606A330;
	Mon, 23 Nov 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPnPtLD/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FF21F000E1;
	Mon, 23 Nov 2026 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454572;
	bh=3FMYFsYc+wva2H/zEk/C4iK7aMpqtATF1UrEYEweIaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mPnPtLD/VuZKnc5ZjfURUG5kqQ4DFhH+yLjIQ+XaA753XY/1ZQNEHXIMTKHli2Q+l
	 6QuU+bMnjLB63jE8AnI7N2Lp1Oc7vpoROhVVJx3fvG/8o74wI5S8oXyVbjgeoONuIJ
	 EyvYr0cM6oILwMmEBF7WVnmHM+PFM6D6iwBg5bstkuu1+gJb+WlaLaUqFl1zulSEmy
	 MDUwmI43NgJgVz9Em5ooZ1ecJKfkGgCl0TirKf2zOqhj7Rr6Hzbb0LCDBgblxTXblG
	 GODWu6a078+Wch/je8dTIBfn6/Fe3HNwqEMUubgwKdG/D9riVDrga2c6gHPNigRCqR
	 h7iS7uXaJrImQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] remoteproc: imx_dsp_rproc: Fix pointer stride in imx_dsp_rproc_memset()
Date: Mon, 23 Nov 2026 17:20:53 +0000
Message-ID: <20261123172140.3547896-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
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

Commit 3c497f624d40 ("remoteproc: imx_dsp_rproc: Fix kernel test robot
sparse warning") changed tmp_dst from u32 * to void __iomem *.  In GNU
C, incrementing a void pointer advances it by 1 byte rather than 4
bytes.  Consequently, the word-fill loop in imx_dsp_rproc_memset()
steps by 1 byte per 32-bit writel(), triggering unaligned 32-bit MMIO
accesses on Device-mapped DSP IRAM, mispositioning tmp_dst for the
trailing-byte read-modify-write, and leaving roughly three quarters of
the target region uninitialised.

Advance tmp_dst by 4 bytes per 32-bit word write.

Fixes: 3c497f624d40 ("remoteproc: imx_dsp_rproc: Fix kernel test robot sparse warning")
Closes: https://sashiko.dev/#/bug/linux-720f943f-eefd-4df7-806e-0b50cad1abbe
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 96d619daf3f5..2771043ee433 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -843,8 +843,10 @@ static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
 	q = size / 4;
 	r = size % 4;
 
-	while (q--)
-		writel(tmp_val, tmp_dst++);
+	while (q--) {
+		writel(tmp_val, tmp_dst);
+		tmp_dst += 4;
+	}
 
 	if (r) {
 		affected_mask = GENMASK(8 * r, 0);
-- 
2.56.1.750.gf70dc682cf-goog

