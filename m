Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963D37F315
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805606; cv=none; b=dq2Hx713Tl4evDVcfRkmK48lpcg4cRSXpC6s4YrBDfG05rsprr6OQ98w3gtNTQ5szWShaU/jKKhn5qH6Ve2AspJf4YZn4hgvxvWTQv6IB2YAUtiNpirZYddaJOv1066di56wRzf3+0+lvZm0XZL4tMJfZe8m9GNF+RiXIZBjPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805606; c=relaxed/simple;
	bh=c6GU2dTc3WLIB2Kc8VATdRD0HXiQQMuAuzStxZSIb0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY8jk0106W22B2APQDtmbHJHpoxspJEF7zRacaYKZuT0nT3kwbO+NsjnoG+m5H13AxkP50R8Nyst7TfgPfzfMEzXuQw0hZ6JdhW9rCmfkeaNUP//lvQP7lN8dpTk2C9k13EJxjeux6pNhhJ/6JP9rv4XYAk5rJoexXRcxuJqHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZRxYeXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZRxYeXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE5B1F00A3A;
	Tue,  4 Aug 2026 01:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805605;
	bh=P2l/wqc50vHsLYMkEy1O75/d0H6vkQvOpN9cYi+quAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZRxYeXLJgv8kQWI4atZnkiUDQwsWyS9dm/Hvi/FTx4nOo+cx6pduPrVb58k7E7IZ
	 6k9md6hJdgBwRFUdXPlabt4ctefltXuG1r7CbmU/LdWPJmgS1ekWgrR/KH3stCg3Yk
	 BUJ3TtcSdkHXgPvRBnDhIQOn+Mh9+fvHkkQ5j2lz51D4sqkEWZdT9x7pTeGJ5+ZKXk
	 fuhy58/v+vybI2nChWJ7Jx+Y9kj4lVS1M/ufvHZ6nTVVy8P9eXTa9P6+V3wAw2aWl7
	 2yQ2PdLoRoCgpGXqLtYvZIiXd8KVYdf2fnl68UGw7He64hrpIjHtlJWZ1u5AMFOBds
	 PPPmiLx2Y4jgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: imx219: Fix maximum frame length in lines
Date: Mon,  3 Aug 2026 21:06:42 -0400
Message-ID: <20260804010642.2350939-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804010642.2350939-1-sashal@kernel.org>
References: <2026072955-secret-automaker-f113@gregkh>
 <20260804010642.2350939-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c4f1ba7354312ad2d6e34e70a518a51a9344715 ]

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index bc4d8ecb60d19..169040479c234 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -72,7 +72,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		CCI_REG16(0x0160)
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 
 /* HBLANK control - read only */
-- 
2.53.0

