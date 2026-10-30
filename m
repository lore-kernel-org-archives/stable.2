Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357502;
	b=m4G6HEYNJSXmntLR23dAjWUq8pq6FBM6weVkNk3wJ/wwO2eH+oQQiEJVdsvrxta3h+jq
	 KZpcp9M0MQm6/XtVr6r3Xj8aDq6MEsITB0bo7Lj0A87yKrCe6T1FR1OVeaYXoR7JMLR8E
	 RF8NI4BAvRZSGgQkfZBWPafs/sVaqyf7L5KO/jB0rmBSHufJb2QeohpGOzGUsAZYck2aj
	 P5berJTtZLzp8cbURLLazOl/pG+OPdWd9dJ6LxFAXcKlx79xjYlAxwJM1T0rxqk2zu8SJ
	 hXQ7oPO2SsF10zBR+r4jESmYE1mYYsOM4/2nmy3jzgj6mLMO7pnPI3udJFFlZIlhWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y1e+PgcW52HJA5LghhJEMGx2SKGvaUslgdry5hdV+d4=;
	b=Wt8PnVDdWp9OriCasMGI+kPuZYU+T53zH1Pk85XEUltdLtZnJ0nNlsKmKTV6/O71cezk
	 ovoSN9KbSLHTZZ+jbgGGL3qKalRBhnFPkK1Qvs4DxJhYOtx8gGoli6jsEgNbdTIkvvMIW
	 fp3JNw7PeGnC1CnieS0BjKIKMWl3bQcX/QAlBp/W+FmQ+JVcP0xgMxZyAQHIQ7sGa06Db
	 NHaeTDbHG95swogC1EEQhDT9vOdutG2s/9woNd7CiavB6naSC+VvG7cgVhl8XdLV4CInW
	 qeWbP2cF6sPakM/2vdy+WivmYanFwDQGByfF67u6NBR/AF1dR+M6VJTERnyh2CKAPHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0pTAdMS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0581606A8C4;
	Fri, 30 Oct 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0pTAdMS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26CD1F00A02;
	Fri, 30 Oct 2026 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357501;
	bh=Y1e+PgcW52HJA5LghhJEMGx2SKGvaUslgdry5hdV+d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0pTAdMSNwLbWRxM+moZ1E9/Q7xHm1NfHv0KM1Kxj+XSphSfJhZH3C02Itx58q8sm
	 Tm1anfEsF+E1oThzdnVcHXaYlBjV0IYz5SLww+NGejQ2q6vhC9q2N1L7St+42/dqwt
	 uT9C7D2Ti5JS9iyk+VatAIDxgr1bZYPpx0Qrte2ounv/aBGbyO2VtoBB+qWEUcdG2a
	 buPJH1mhOmCPDJJHHjMk2JoDMdHR2jdgfLL8aoEJQvbcs6Br8/P86cLGrTxcnmQW/Z
	 HUG+wolsUJ4BYEy4iKFV7J2ya+FHDVe0D10/Jv/6MtTpVNmstHfJZBm1DNq5Iw1SPi
	 smsPGdKdoQ0ZQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar.Mukunda@amd.com,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 12/21] soundwire: amd: Check for NULL manager drvdata in sdw_amd_startup()
Date: Fri, 30 Oct 2026 10:46:51 +0000
Message-ID: <20261030104840.3361217-13-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

If amd_sdw_manager_probe() fails or defers when registering a SoundWire
manager platform device, dev_get_drvdata(&ctx->pdev[i]->dev) returns
NULL.  sdw_amd_startup() passes this pointer directly to
amd_sdw_manager_start(), which dereferences it unconditionally.

Return -ENODEV in sdw_amd_startup() if dev_get_drvdata() returns NULL,
matching sdw_amd_get_slave_info(), and clean up the allocated context
and platform devices via sdw_amd_exit() if sdw_amd_startup() fails in
sdw_amd_probe().

Fixes: ed5e8741b8db ("soundwire: amd: refactor amd soundwire manager device node creation")
Closes: https://sashiko.dev/#/bug/linux-6834a8a0-632f-4c73-9174-0fe7e06b5303
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 8e419ddfa516..adf410fafb7e 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -156,6 +156,8 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
 		if (!(ctx->link_mask & BIT(i)))
 			continue;
 		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
+		if (!amd_manager)
+			return -ENODEV;
 		ret = amd_sdw_manager_start(amd_manager);
 		if (ret)
 			return ret;
@@ -166,11 +168,20 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
 
 int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
 {
+	int ret;
+
 	*sdw_ctx = sdw_amd_probe_controller(res);
 	if (!*sdw_ctx)
 		return -ENODEV;
 
-	return sdw_amd_startup(*sdw_ctx);
+	ret = sdw_amd_startup(*sdw_ctx);
+	if (ret) {
+		sdw_amd_exit(*sdw_ctx);
+		*sdw_ctx = NULL;
+		return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS(sdw_amd_probe, "SOUNDWIRE_AMD_INIT");
 
-- 
2.56.0.317.g454f8302e1-goog

