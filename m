Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577314;
	b=rEgfpe2PieHkKKBXghpfMnmC9SXMxDLOruyhvEWfvC0BYs9LfAIGFXvVSfLcqj4F7k2U
	 v/zo1ZoSUy6C0aqsRLJHLZz4GLFHNnITwpJqy6ee/5m8wvLwarkUAckxgJnEz16HGkagZ
	 FGVgLwWxam8kT5j78sQUKxijv7P8E2k1kMQscoTXG7BUPAQEUASt0DPeVabQC4yxuJjff
	 pex6oUmA5TgNN6qBD0kMjhSPIpXXSEjUCXD8bzD0DmFx6oh70LOziVfx7bHQCA8PuVpMO
	 BsDr66HTcUY/7/YxEcX7ju4vsbKuAEh7Yoovl5zxkh09YLd7eohjobI2i6FetTTxESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577314;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1qdXLDixObaSZ2/WCIJj1BuYdNawvlBmhGgHCHla1gc=;
	b=WG6d9mPCZUuScgMbfaO2dBHpGZUZD0WnIz5u06Miairy1kyMRXOO+gja6y7AAUrLsYfl
	 CiPU9ZJ9HR9UMtmWgdD4ONHmMc+V1RUL40e7jkxqMvd5qH4Y/IH3dH5Pv3dnBH5CSwWMJ
	 LlOG611648hgfAFigC/s1o260AxpcrH45nZLiCm/+Aun2TodDEB5MJ3kiy8mbEwrmczya
	 F5kYT1cdMy7jnR3WaQ2UNupfZ5Bsk05J1NwvQ4hGurFzML10bTxyn3aZ7Eb+DIt6gNlgo
	 6BWpWE9P0il/dNoL84KAmK1ZDOFzk02aFNq0ZG5XLam14SV46w9RRrKXonc/yjvCvrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="jEG/n34B";
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7C60A260D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B7C60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jEG/n34B
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 770264E415A9
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:41:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D8A360015;
	Fri, 13 Nov 2026 13:41:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8BDB11BC1D61;
	Fri, 13 Nov 2026 14:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794577305; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1qdXLDixObaSZ2/WCIJj1BuYdNawvlBmhGgHCHla1gc=;
	b=jEG/n34BWhUxmxizHU+OPKl1Wntaqj+5fVi3wxtaqMXJvjuMbruPg1yD/u6uwZBgHu287A
	3bbAsvU7EB3+1Srp1U1Th0ZJfWiCXNYf5g+btnyi3aHQeFwbmi47WEk2FQ5mYGMlcDhPO3
	nDQvqcq4HCrtPulcIQNAdi3DGmqTyzegkhOiC0heymuY60u0TGH7WaRbgfgtebNcD+uVN9
	v+Mloulp5Dcxoi2lTqsJIrHxynaRPtF2vjgcuYeG0JdoQCLtWETSflGAGf+EJvTm0ydhKZ
	2YO5CTBdAOMkA8RIrD+UiwGnMFrhmpacSmUGCnfGvi1hhn9hIgVKpC082m9blA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Umesh Kumar <ukumar@marvell.com>,
	Shashank Gupta <shashankg@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 1/4] i2c: octeon: Fix infinite loop in clock divisor calculation
Date: Fri, 13 Nov 2026 14:41:25 +0100
Message-ID: <20261113134128.58826-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113134128.58826-1-paul.cercueil@bootlin.com>
References: <20261113134128.58826-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

When mdiv_min is unsigned, the signed mdiv_idx variable is cast to
unsigned as well in the inner loop condition comparison, leading to an
infinite loop.

Fixes: 03240f826b02 ("i2c: thunderx: Support for High speed mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: New patch
---
 drivers/i2c/busses/i2c-octeon-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 93a49e4637ec..85e18ca2410e 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -823,14 +823,14 @@ int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 /* calculate and set clock divisors */
 void octeon_i2c_set_clock(struct octeon_i2c *i2c)
 {
-	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
+	int tclk, thp_base, inc, thp_idx, mdiv_idx, mdiv_min, ndiv_idx, foscl, diff;
 	bool is_plat_otx2;
 	/*
 	 * Find divisors to produce target frequency, start with large delta
 	 * to cover wider range of divisors, note thp = TCLK half period and
 	 * ds is OSCL output frequency divisor.
 	 */
-	unsigned int thp, mdiv_min, mdiv = 2, ndiv = 0, ds = 10;
+	unsigned int thp, mdiv = 2, ndiv = 0, ds = 10;
 	unsigned int delta_hz = INITIAL_DELTA_HZ;
 
 	is_plat_otx2 = octeon_i2c_is_otx2(to_pci_dev(i2c->dev));
-- 
2.47.3

