Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288635;
	b=b3v8nfI+VHrlMJMCKiYQWi4szbkyC1sDAHP4NllMCQ4Zlj5IVlPsvPyVV3UAURAGiRUU
	 o5xO/1ErzgHZQPEUH48TEhEyrxZgrPpMw7HDWC9GDbwDDJh7qjOb68bwYh1iQdoydqe8O
	 lQ3GmBaYtj7t7p61G2a/3y0YqeUFyeWS1hWi1pXQMGEzLhWXuG9kr+/YWwq3PKDXYDf5s
	 0s1BUjEBXgHcuvjZ3NMaA9YMzUNxwrYBeP+VdAsrBThRMlZFO7r3ad5jUTgEQahSmjmFr
	 wOQ1FqrTwPOdu+KHgcPdOggjWh/VAzXfzyc8vGJ201QNcEke9N7Kvgi/ZXvx/hyEJtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dWgR6lOz/XTwUVVxX4Pdzk4k934e6eKpxRu+zRVJnNk=;
	b=YBaVWKxEVClgo8KIpGk1CfZH6nxOBblYaHHpVsX32VDTbE5KYswqcLwwPP27ZHrb53Ry
	 ASrVOIoNoI/BaLxNZ/Qm7CJq/RKajZFY6X1vAjEejgLZErgLlH1fbnKYsN1uxoTct2KEH
	 m2mwbLTtK2S7zFWB2w9QMbrQUQ7DhR+upGcc/vv60Mm4VlSJMWMgu6OuLsSfO7SCFpLth
	 lGZzNZ8X+xqJp2ZpXcQcuwSnJf2aaTTgFrZQIOXah2GTDK9G7Yr4KSL7gK0fUFroPxRZ+
	 nqk0DeOFXbkjOCY4xVxr/cfNpMC0EIstOW+MP35kBGSuISLozynit+pVg7GzhDTHEFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czQmSpMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czQmSpMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E121F0089F;
	Tue, 10 Nov 2026 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288634;
	bh=dWgR6lOz/XTwUVVxX4Pdzk4k934e6eKpxRu+zRVJnNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czQmSpMM//IsX5aC/BEqvRZ6L0Zrw564s6Glm80REoMXBVV4lqvDxXkukoqZlUE65
	 d9KHPIGJtdmhybb/n9eaJDv5Z3Ao/syqHYE8nv0HB9EeYLbVfS/X2PcendUPmf5hBJ
	 1yu1c5NWsdvDdj+1Kvaq/SqAvh3b10f2M0EUtVullwkHIdl5zhkIhm1lOMlVOGVunb
	 XuK3CEa2nWwuigxkS+XoOmOrTkJRXt0yv17A6XKWSVUqEq82xhg7XmR2QRS+3Et1Z+
	 XSiXTjImhJzOaqP1do2yamMpYH9O+pAotGdNst/+HVJTK4QoS4G2lU/+K1BZEQashs
	 9+VFrtHPnDJUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: microchip-isc: don't sleep in the clk .is_enabled callback
Date: Tue, 10 Nov 2026 00:30:32 -0500
Message-ID: <20261110053016.450069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054129-failed-6.1-61490ff518c7@kernel.org>
References: <20261107054129-failed-6.1-61490ff518c7@kernel.org>
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
[ sashal: Added true as the second argument to pm_runtime_get_if_active() to match the older API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-clk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-clk.c b/drivers/media/platform/atmel/atmel-isc-clk.c
index 2059fe376b00e..54065c2cf1817 100644
--- a/drivers/media/platform/atmel/atmel-isc-clk.c
+++ b/drivers/media/platform/atmel/atmel-isc-clk.c
@@ -98,15 +98,14 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
 {
 	struct isc_clk *isc_clk = to_isc_clk(hw);
 	u32 status;
-	int ret;
 
-	ret = pm_runtime_resume_and_get(isc_clk->dev);
-	if (ret < 0)
+	/* Runs in atomic context, so must not sleep to resume the ISC. */
+	if (pm_runtime_get_if_active(isc_clk->dev, true) <= 0)
 		return 0;
 
 	regmap_read(isc_clk->regmap, ISC_CLKSR, &status);
 
-	pm_runtime_put_sync(isc_clk->dev);
+	pm_runtime_put(isc_clk->dev);
 
 	return status & ISC_CLK(isc_clk->id) ? 1 : 0;
 }
-- 
2.53.0

