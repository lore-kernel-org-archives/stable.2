Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357560;
	b=HLTPDI5YkNeQHWaR+5W0IL9g1LsIPMQv6QxMNi1Q47RFy8m4n+VSYYRrctt9Uq8iYpdP
	 KJknqeL74wZ7L4cX5HE/eYu2JpAkWsMdgBykAR63Ko0IewfATB57gqqyazvj09dF37/GZ
	 PLq+mCw6p/GGOz1m7LPV+lIkinh+xcCoW1eTwJ2jRWE3nA0g0oHtR/FVApt7UaMo8sMaX
	 hkE+5gj8dGaSeiog77OLUc/X4oDxSV5GcZPik8CoZ3rM0s1A1qo5ajpM7upbg9r3q/384
	 I8X6k+300l5M2h3Tdeh1ZU6Vx6KO6hZOAWKh5djNIFkl6Jnk3JgYLZK3dPhJpCYhNXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MAeoLtGMoWZCC2vTYblvujYJrqkujyJ7LqL1O3emB7A=;
	b=vsIOV6OgDVN2IqnFZUbLETjYJqqFc48XRpe/TacalPRuxeC22hdC1eVTU+PpA6wnOUaH
	 a3/k6vk9bHBAmYHbf6B9JzHVP64glMDHhrH5nguq13Axl5JIQ+ygV+ZF32205q0uqGY3g
	 taoJtxzr3oDjpeV5byMlShYV8EmhEXLB5W6fU5kwchr1m51JXHHQM4wsqGqvAlvyFpDQx
	 iFAkl7GLF4UDlJBiAw6uBLZwrhtRTO5whS3TZom4kXyqVZ00V5DE3SkGZorGZ/ZlDgl/5
	 6to+wviYun70XeTUe34pzgszMqqSCKBbUfQlsMg05482AtGA85hyG4pfGnwGDyjq03Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEReuHGb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00D60A3806;
	Fri, 30 Oct 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEReuHGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CE81F00A15;
	Fri, 30 Oct 2026 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357559;
	bh=MAeoLtGMoWZCC2vTYblvujYJrqkujyJ7LqL1O3emB7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEReuHGb28g1HRowYwNmixLazG5eFnamEg+dEdYKT3A1mMODabX0yuNPhf4QiClcm
	 KKVSKXZNaPly26D7TQi3dPbuFjqil/asz3d0RVA1pvHTKNtQsO6vsQ+0KfgO+S4/37
	 SIpM1q3QTEjv40twyUB7NfdyXK68hvOWcjwqwxBkbHNy7lXteANRI5I0EdodYkJKdk
	 L0KZs/OTbVkzlUBJLWq/Ig24VqiPc00z/H5VqHKDXxS4aiRpshND6eZ6qInr907nDl
	 UfV/5xg7IsQzFJF5HdS68H0zg1ArQTFHsi4EVFas68HC42RB4V1tRyw56bZhnzfhLI
	 eBJf0cKvpSGBA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 21/21] soundwire: amd: Disable interrupts if enabling manager fails
Date: Fri, 30 Oct 2026 10:47:00 +0000
Message-ID: <20261030104840.3361217-22-lee@kernel.org>
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

In amd_sdw_manager_start() and amd_resume_runtime(),
amd_enable_sdw_interrupts() is called before amd_enable_sdw_manager().
If amd_enable_sdw_manager() fails, both functions return immediately
with SoundWire interrupts left unmasked.  In addition,
amd_resume_runtime() ignores the return value of
amd_init_sdw_manager().

Check the return value of amd_init_sdw_manager() in
amd_resume_runtime(), and disable interrupts if amd_enable_sdw_manager()
fails in amd_sdw_manager_start() and amd_resume_runtime().

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Closes: https://sashiko.dev/#/bug/linux-309820e5-f754-4d3d-80aa-7f70d59f3e8e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index faff3e9eefad..f64e8fea7e16 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1109,8 +1109,10 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
-		if (ret)
+		if (ret) {
+			amd_disable_sdw_interrupts(amd_manager);
 			return ret;
+		}
 		amd_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
@@ -1503,11 +1505,15 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		ret = amd_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		amd_init_sdw_manager(amd_manager);
+		ret = amd_init_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
-		if (ret)
+		if (ret) {
+			amd_disable_sdw_interrupts(amd_manager);
 			return ret;
+		}
 		amd_sdw_set_frameshape(amd_manager);
 	}
 	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-- 
2.56.0.317.g454f8302e1-goog

