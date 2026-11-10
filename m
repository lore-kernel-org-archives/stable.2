Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289790;
	b=fPBoQWpD4YHjMhlYxtGenYFkwm/G7QOhlTDjFHK+qDp5ikwm98XTq0RSc8YDjefQMQT2
	 50mg/biddpbdVmux5IfjcoOHNGcs95oeNhDh1pLWuP1lp9C4CRNaiKcagdyK2gA80FgJB
	 JXtIXr9TIIqi8T9JUMxsvxti5DEW4RjAx7pz33DKbhsupfbD6/PtJ8OoZeHsomY/v/II7
	 JXZvxG/iE3zh7qaDfP1L7EmhDuM7LTZUYU3mZIR02KQka5/IfKDX+ioFgqm122whqu2Yx
	 Sjs2NcZCrYeXqjrZd8BJlf1xHYd6d9et3lCV5+OOHb6greZkimgiE//VkJxP9lp5hag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kfk6k/OKWTmyDizyXTpZMX6c2PX7MAMKtKziJ128K1I=;
	b=w2PGY0Yt/5+ZtUC3HH2YrWZzRQNFVe6xvWx+UO5PqTIzDjWuuyJzPw1wXEqepjFqCQ6y
	 QoKMMeFMPwxb0sZzOTs4Dxx0vrxJNzCLkOtQKYAiqAbGgdzSSi+iYy6d+6tV1qdjbni09
	 TM/jsYpKXjNGEP3tYpTRIKv5PphcAMYaJfMv0/eBRQc5LdMn8nQr47FACnsTLgXky+Cr/
	 AAWYB/AUWpbLK/v/VnqL/la3JV3QMW4TtkWryEpXLsOYtTQhJhVS1W/XPNL0VS6shvzWg
	 AvuZcZ6v3wI+tb9zDoQ2xeh43UmUXV23Nco+14O7i9/hRQbKbxtGC4SnLGOvDnJaMuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7i0kQXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D39606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7i0kQXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107EC1F0089F;
	Tue, 10 Nov 2026 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289789;
	bh=Kfk6k/OKWTmyDizyXTpZMX6c2PX7MAMKtKziJ128K1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7i0kQXUjRS/Hwst0A34U+gnEdeoBm7EUHKOTEDES3q+0MbQNbK+vYn8GhmNyC1O7
	 KiTP61Xd7tsv6mpNhGp/iHo27UODHuxXI7+Df+LLvqAnG0SuEkKhexhQ0vmNW+vek0
	 DB5Qarw79hMKndehSYkclyw8yo0j19L7YrLEtlwk4R2E7OceCl/i0OeezjDMmayzrs
	 RCaiEuQq9PoilmesNScN+m4Zthvw3KLppDNtYgiiFjGsa4VPzuMx3xBRWmQDeX/BRN
	 nArkq7ocqZD7IJq+3HYgIXaem00ZJ0IyYQDlSzPNeTsluVYu22meD9816A835snhcH
	 bO2CMfHO4PG6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: microchip-isc: don't sleep in the clk .is_enabled callback
Date: Tue, 10 Nov 2026 00:49:47 -0500
Message-ID: <20261110054930.473989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061511-failed-5.10-61490ff518c7@kernel.org>
References: <20261107061511-failed-5.10-61490ff518c7@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit 61490ff518c7b3ea3ff1cd16bbc012e9e4f1ab74 ]

isc_clk_is_enabled() calls pm_runtime_resume_and_get() and
pm_runtime_put_sync(), which can sleep and are not safe here, as
.is_enabled must run in atomic context. clk_disable_unused() calls it so
at boot, and CONFIG_DEBUG_ATOMIC_SLEEP reports a "sleeping function
called from invalid context" BUG.

Use the atomic-safe pm_runtime_get_if_active() and pm_runtime_put()
instead. A suspended ISC has its clocks gated, so report the clock
disabled when the device is not already active.

Fixes: 01192aa1c5c2 ("media: atmel-isc: Enable the clocks during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adapted the existing ISC_ISPCK-only PM handling to use the older two-argument pm_runtime_get_if_active(dev, true) API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index fe3ec8d0eaee3..18b3517097de9 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -354,13 +354,15 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 	u32 status;
 
-	if (isc_clk->id == ISC_ISPCK)
-		pm_runtime_get_sync(isc_clk->dev);
+	/* Runs in atomic context, so must not sleep to resume the ISC. */
+	if (isc_clk->id == ISC_ISPCK &&
+	    pm_runtime_get_if_active(isc_clk->dev, true) <= 0)
+		return 0;
 
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
 
 	if (isc_clk->id == ISC_ISPCK)
-		pm_runtime_put_sync(isc_clk->dev);
+		pm_runtime_put(isc_clk->dev);
 
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
 }
-- 
2.53.0

