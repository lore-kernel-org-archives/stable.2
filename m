Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357514;
	b=M0RBr7aFD7iPt2iggLQuRjryXN+Cqk0EiNMlA1afWoWlHI7YGZDS+TbCj3ZzRt+J7MP3
	 gn/XOQKiPWvQq8UyN6QPSzVltTMfzzmI+zApNvcfEi521ILZDBZttMOyq8dcs6yMUFUGO
	 sKrIZUQORUDgleKRomUZoKQ0G68gJyiSPSOJgJIwSWsyfx7n684efHMMAHaKpq6D7ru7r
	 gqkQCsLx00NN7Bf7mv5cWIUUzv0pYWHMUgdPh9AQASH8z26XNs7mhVD+QkE4PdyWRe3+s
	 AEIvqRQO2NaDB5+aWR6DSYB58JvWO8X1oRf1wiIZx+mOkACyc+rlrMNVk0ZHP2JwELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RF8jPCy0VnhgHHq6X8fcPFQFUc2dxhuBXoGGaN11AvA=;
	b=OlDbFn9D1cRoqWEFSE2LjsKhL3j8e9AHvDqz1bUkxzPxzD3oRXvtTKnEJE3DPlRqBi1X
	 Ck/W9P/daB3zs9aKYi2QfBbxx+JeQwE9THkRyLLe1nVyA2aXCRwEtNXKt2lwVU2EfXl11
	 b7BW8/tiQ6DYgTuvuN13WxpPtM5yWcguIZ0DvYHZ8HwiBfbbmdyM8hxsaRUPIc1dDVWVp
	 Kg0BqHMhM7/kl5FrG8yz91FrXLhMUF4uK7IRpzSfonN7xneOw+kSP9cIZjDTpLE7OyEGu
	 culHg47MXg/tj9HCC84w+1NEXKLRYpWtnWDQQ4wlxkrbnLNxiAJeX8NJ2qaiRMLMPXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=be+UgP0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44163606A337;
	Fri, 30 Oct 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=be+UgP0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D81F00A16;
	Fri, 30 Oct 2026 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357513;
	bh=RF8jPCy0VnhgHHq6X8fcPFQFUc2dxhuBXoGGaN11AvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=be+UgP0s6lSVHZ1ctKM9NbDZrrazJ6mImp6oLCrs20OF24JJxtM+Q6mMn1asoGH/n
	 2fxn+4V4Z8uBhGHnOU1pSdx7ICu25Ag0RvFieDXEshSw26rAGhJ5KEg5TdlSbusqYt
	 41Y9fwUxs2EIkwXp5udDToJn8CgCgMeZJU9BM7lJbf3kXdGCCt+ETH/LfViKnfG/qe
	 5yd9X2xgBPrr1UZ2hahxO8zrNmIEluEbFPMjwnyN0j9PnC6Ai//Hv7t+pvkKDQ+LKx
	 9Ms/JhdnnrOFt2Kxr0ByKuAk5LDNARPv+tN+kStzFOLMdLKBBRI86brkC/Wc3MpPoH
	 Wd+B8iSTzWB7A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 14/21] soundwire: amd: Preserve lane control bits in amd_sdw_port_enable()
Date: Fri, 30 Oct 2026 10:46:53 +0000
Message-ID: <20261030104840.3361217-15-lee@kernel.org>
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

lane_ctrl_ch_en_reg holds both the channel enable mask
(AMD_DPN_CH_EN_CHMASK) and the lane control field
(AMD_DPN_CH_EN_LCTRL) programmed by amd_sdw_transport_params().  When
enable_ch->enable is false, amd_sdw_port_enable() writes 0 to the entire
register instead of clearing only AMD_DPN_CH_EN_CHMASK, wiping out the
configured lane control bits.

Clear only the AMD_DPN_CH_EN_CHMASK field when disabling port channels.

Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
Closes: https://sashiko.dev/#/bug/linux-9a1be49a-7c40-47d3-9260-b933e590c90b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index a8220235a2ae..9dfcdde3f2f0 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -706,11 +706,11 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
 	 * parameters.
 	 */
 	dpn_ch_enable = readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
-	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
 	if (enable_ch->enable)
-		writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
+		u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
 	else
-		writel(0, amd_manager->mmio + lane_ctrl_ch_en_reg);
+		u32p_replace_bits(&dpn_ch_enable, 0, AMD_DPN_CH_EN_CHMASK);
+	writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
 	return 0;
 }
 
-- 
2.56.0.317.g454f8302e1-goog

