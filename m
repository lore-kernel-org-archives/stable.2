Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794461287;
	b=BjRZRYOBrFH/uY1eriU1p6jcN2Kf93NeLSax5kXALgpm5Dvy+2X5ZsD2hONzkpaTVCqw
	 MNeV9nsMbQztae2w+++7zA1zU2S6YUnSHr39+7PnRbI8h+2jnA5KWDqeIA5m3Xb6xZgcr
	 mXsw8yjjIXluISpg9mirTVu0j8hwt1iS9jolv82yFNdE1H0DKOhBUEa6nyMNeWqA1nUXv
	 lnqzl60pXtfAcCklMb/F5bgkZWobFUtqzMsXSaYVzwNkjyfRZGDJVHYDAOslKHXTWVOdY
	 x3SLhU42qYrEjz/5hCyJwoHG/OvQ1LTngHzWpzzPn1uR5hjUFZgCMTeSRpEcVzKc3IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461287;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=W6mZOJg0qLo6Oh/FE3CEb1vYHcaROZa/HUARz/kORXE=;
	b=GiA3p2vSPgvLXYkyykb+/Hjg52Olfni68H0Rb0UpuXw3UWTJlEfnb0eaz5kgG0IqFHxf
	 Byivht8jWedQUC48K+QVKq4AZb+7adkKukrirvY2ASlWr687FTuU4lxvX3/p/Hz1G5wUk
	 JOPZGfgbGTAnzZGaB5osEnmpUMfAG4lGP81JHjm47w4BYYC4eoDRf8vVVzwH76qQ2td21
	 ycV3WxqeH/VJL74LIJ+DDaduEoOgo2VrsQZ79qxsVZqfu+KSHMFtQihGNrTQHIktWXreU
	 L7HFhs3pXNCPwW1ispN8u/EP0Fwap3DU6iXWpFHq2UTgq8xRHf+/3yekwMvMtNFPvdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZiRt3k+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD2606A324;
	Thu, 12 Nov 2026 05:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZiRt3k+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794461286;
	b=H9vUwjI/2pkawjH/yZx1jvNuHTPxjiRtRdl7q3GBJiAW+cGTyKvzraBxdjf3ac8KUJlS
	 BhSHLgKygYT2buK7BE/zxMQTr8yah58ekCGWBlac0UiqDtWS1sR6lIXXRzYyFEGCLbtnC
	 jdR71tL69Rv4BPzsdR1kP0Xl/EoD6ZjUvxdCqRK1R79Mx430WOtx+sC65Jwi31/tHMHrn
	 S0JmzKtxhLkSFtmrvwxFmecaSBc0OQ+NqJJlU5j7qLrmTXqdfVZdrDPQIVDv+5Lt8MmzA
	 m+Sxzm3WNYhaDPsUW31rve1VL5++iatVtfGhp554KL2KjPB/UyETXwyVy2ciT0TyiQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794461286;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=W6mZOJg0qLo6Oh/FE3CEb1vYHcaROZa/HUARz/kORXE=;
	b=0hMwJi/5kZc60K2cThvoO09Io1eeh0RrhWnGdZXC3eFF0SjfZj5LZvtO0AcaKqHIbffy
	 qiSD7LzvrjXJtS5/3MKy+LUm9ZnKAL8Btlnp/Si/XVaOOVdGY1vhQ1x+SOLR30dqoSVHC
	 pNI7ADcZ4TxbTZSnGVImx3Jigl9WYpkIAZDtENfBo49eq4ZE5/Rq1oVc9XGjhKX0delAM
	 /8TIle5esV+XRKMwOW8BlSt8qJJyWazvS4Kf4UTTLd7M3/lRs+v++8WE8rUQhhe7jYCpi
	 uM/+kM5o/0YGgjbQSI/y3x/dHXdhfTz5Okhr7PUl9cDdVCA0MT4KRgm9aCX2kGabTQw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE6021F00A09;
	Thu, 12 Nov 2026 05:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461286;
	bh=W6mZOJg0qLo6Oh/FE3CEb1vYHcaROZa/HUARz/kORXE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=oZiRt3k+5VLSUnqmGNXWTTO6XAnuzwR740thG6dGPVl3CLpu1FDFmdE11owrSmqHq
	 BPFDoflNNhsytwPaBdJ8JhyV754h7lCpwdE/FDqYxIu2aRBrwKBGgstP8qCG3tzZnz
	 E3LBdofMaNeN4NUv42K00Hcr6EgBj5Puv6/2mIH1CrXXq9A7+t0LbG3IuhNEPt3DCo
	 ZzplRRTlAQtRWpu0Pqn0zelwNIYYb3W3Mgm7T1PuSHTfpZE2WeiRFX9DEdMVAeQ1oO
	 vMXvekvdKbmqQM/lPOjKY8cMYI+n8KFblDFKuxL0R+R7EEao16nZI/CADHTZOpXNAV
	 uVHkLkvs3KyTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3815549191;
	Thu, 12 Nov 2026 05:28:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 05:28:05 +0000
Subject: [PATCH net] net: stmmac: dwmac-sun8i: Fix use-after-free in the
 MDIO mux error path
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6Xs2QU3YIn+inhI44uu0CjZphRK/
 91UjzMws5KhKIwu3UoFs5q+cwM5dBSfIT/Aem9M7uh6EXFsNXtljCHyWBeuIbEMwfuTk3MCqIW
 fgqTLb3qljIluf2l1eCFO+4627QucXK9qewAAAA==
X-Change-ID: 20261112-sun8i-emac-mux-uaf-1ba885219fee
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794461284; l=2672;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NsburT4Rs6TuKeRLvNh9ntKMBycWNUHji+Gwj+018cs=;
 b=KuvZTvy/m2KLD0YOLU883uIqDNTznxKHAhJWD8davNR1BvQqXeosLyiPNYJbDYPG6qKvJDQdR
 LcFJgmVCqFeAlJD1ouD1bdILIdSCBHTVE1tYyniSitGLJ+rn/Vi2tK2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

mdio_mux_init() registers the child MDIO buses one after the other.
Scanning the internal bus makes mdio_mux_syscon_switch_fn() select the
internal PHY and power it, which sets gmac->internal_phy_powered. If
mdio_mux_init() then fails without switching away from the internal
bus, for example because registering the external bus returns
-EPROBE_DEFER before any access to it, or because an allocation for it
fails, sun8i_dwmac_probe() jumps to dwmac_mux with the PHY still
powered.

That error path releases gmac->rst_ephy and gmac->ephy_clk and only
then calls stmmac_pltfr_remove(), which ends in sun8i_dwmac_exit().
Since the PHY is still marked as powered, sun8i_dwmac_exit() calls
sun8i_dwmac_unpower_internal_phy(), which passes the clock and the
reset control that were just freed to clk_disable_unprepare() and
reset_control_assert().

Unpower the internal PHY before releasing its clock and reset control,
as sun8i_dwmac_remove() does. The later call from sun8i_dwmac_exit()
then does nothing because internal_phy_powered is already cleared.

Fixes: 529254216773 ("net: stmmac: dwmac-sun8i: Balance internal PHY resource references")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
The problem was pointed out by the Sashiko AI review of an unrelated
dwmac-sun8i series of mine. It holds against the code: clk_put() and
reset_control_put() free the per-consumer struct clk and the exclusive
reset control, and nothing between the dwmac_mux label and
sun8i_dwmac_exit() clears internal_phy_powered.

This is build-tested only (arm64 and arm, W=1). I have no board with the
internal PHY (H3, H5 or V3s), so the error path was not exercised.

This patch was developed with Claude (Anthropic) as a coding assistant:
it checked the report against the code and wrote the fix and the commit
message. I reviewed it.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 47954537b29e..4436532af2dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1245,6 +1245,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	return 0;
 
 dwmac_mux:
+	sun8i_dwmac_unpower_internal_phy(gmac);
 	reset_control_put(gmac->rst_ephy);
 	clk_put(gmac->ephy_clk);
 dwmac_remove:

---
base-commit: 145480b28ca82e9fae789427cc4569e596515a32
change-id: 20261112-sun8i-emac-mux-uaf-1ba885219fee

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


