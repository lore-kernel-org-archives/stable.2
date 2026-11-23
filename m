Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452533;
	b=MF1ZxEszf4EzZ1nlESyHT+MR5c5h1Lq6SnhRg7QUd33ldqof3GwKY4dBACIo1/nTSGCO
	 UkY9RiCW51h97ek0vvlJ2kAHrUF1nNFsCbz05ASfdaVTtmM4mUtStX/j0wVmts0EWv111
	 WXSyVjcmrDEERVtxdRbh9h5fBJoH5yB4ilCm8gKJmRvBBG4jr540/k+HcwAn8a2I9NmWD
	 5jxyWx3uQux/h2jYbQ7wWVlV+Q+t+s+ZHmWyH1NFhiX1Mu8wX1gjngR/0qHSslgMS15cR
	 mHx/4ds+86wlNh0SiDwgUDGGXzO0SQzk5mn48whooUwABae3+TqsZ6IG14ATUJREYYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mj9v3GOHXJKCef8hiMsVWQMXbcKUeIq3msDs56h6kEw=;
	b=KVybD+VCyHpm2wUGl7uu+MD4B0yKR7yQhkU/Kuci4aGVmPqH5HOXzAxMuue80bK2Qjud
	 pBj4URsJS3fSoH89QGy0/hDBQw+/p3W+Me5M2vRMSqqW6YZ3DLDND2YpED9e0xlle3gaA
	 CBQe6GPdQncDlZX/dcJqwYw48yurwTzXwqvGoEBLfUHja/H+Efn5cTxI80pI8X2beBMZ5
	 vDDkJVAR9vYUSAF9sSamhiP6M0ARt1fxajfkr5ysCQLtEfyMvWU/T4jFQOwAidDUsRbtv
	 pnNq8Z3E+3fV19ibo4u/FCZo/M0u8vTgu2tWdsn4QUUK2Z7j0zzrfiuvdLtL4QbI8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StDIdhSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F2606A690;
	Mon, 23 Nov 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StDIdhSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3491F000D3;
	Mon, 23 Nov 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452532;
	bh=mj9v3GOHXJKCef8hiMsVWQMXbcKUeIq3msDs56h6kEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StDIdhSulwz6Nl9Q+XH4BeslhAsg/Ce+YaNEbWL/d5RRhcOSjlFB0uOXUJO/UctIh
	 K4B/1G/rQGt/muE80bXhwsNAnbfimhk6iqwgE4Xub1Zz2yrrsc1U+3WlNDN57p5TeN
	 zg++LoQCvdK+7irRuiyH+0nXXNI/qxLaZXsJiWwyBv99EEAHFSWeq4sGy0tpjOZW3a
	 7wa6mGkxB2Pl1VpIKwCXj/3Ckagm38Lu/rFbUFeHVf73fqGTjL/iSSIgkbCeysGAp8
	 usBJYusSPNAf2/7HwdlEn3k/CzaENf632KrrqrdSFysJNVeTwdW3TYLAhlG1fRlbCU
	 6I0mR7dNjFNLA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] clk: imx: imx8qxp-lpcg: Prevent stack overflow when parsing clocks
Date: Mon, 23 Nov 2026 16:47:34 +0000
Message-ID: <20261123164834.3330320-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
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

imx_lpcg_parse_clks_from_dt() allocates output_names, parent_names, and
bit_offset on the stack with IMX_LPCG_MAX_CLKS (8) entries each to match
the hardware limit of eight clock outputs per LPCG block.  However, it
only checks whether of_property_count_u32_elems() returns a negative
error code and enforces no upper bound on count.

If a Device Tree node specifies more than IMX_LPCG_MAX_CLKS entries in
clock-indices, subsequent calls to of_property_read_u32_array(),
of_clk_parent_fill(), and of_property_read_string_array() write past the
end of these stack buffers.  Reject counts exceeding IMX_LPCG_MAX_CLKS.

Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
Closes: https://sashiko.dev/#/bug/linux-22dfac78-f44b-42f8-985a-995308723fc4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 9ad016106b1e..5eb4bdbaf7d8 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -199,6 +199,10 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to count clocks\n");
 		return -EINVAL;
 	}
+	if (count > IMX_LPCG_MAX_CLKS) {
+		dev_err(&pdev->dev, "too many clocks: %d\n", count);
+		return -EINVAL;
+	}
 
 	/*
 	 * A trick here is that we set the num of clks to the MAX instead
-- 
2.56.1.750.gf70dc682cf-goog

