Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289315;
	b=RxlVhYjGPbe7CNDxqaTL4OGyyeA3vrOpn3Yu3Go6jvQmUY05yM12hHhufo8nswl1+3BN
	 qWCf7UEJb2ADDoOtjLx+2YyVme1jHWFBbwXm856+62pgPYoKdh1EBpUFi1I1sMjrwzPbk
	 rjvikpUvl+5rH01n/4mV1xJYTZsYAENqRdwFEvXOKi8bDemtvtRMoVqq/ye2JoCTfIP4h
	 CXYNgm+J/fMeSN9BDexUI8pUHl3djEYyfsUsOK78WPEQSSREQLMr39qsy5K+XU1m6ZALq
	 QjCvnQFi7RFMyIL+JOvI5MOfKJ/Cv4xtFHBNir0O4Bs6A5gVuv4k3u44p5ysCgD3DkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x/ZP9C5ktqtIZdM83KiQqS72WLRZ5ftSVdr1VNN0LmY=;
	b=Eat9Bxw4MzA6lwVOnoTbVMruPK0n+zPpN0CzP+I4S8LdUAvwGAi8UWF3a7YcKGx3T3AS
	 mxai94CfoBG2lD+6AlJU52LA+OvJp+S5m7kUQBAV4unKPMkGXB99bDogUSyhVSLV5bFfB
	 Ys+vdXyA+FZdW8x5wu5UCmZbUHA5Yu8jQT3POIVqYEb6v1jV/UTataxElaWg/9nIiJnIf
	 hMSbEw9Ia1Y48ZRRtqLhwlZ/3PqaazUW8AxxeeLjoLhhAF4h24J8zCopyGgxDhKs2IHWN
	 tekKlAyRD/jph+8xszHZyms5I/XyQmLsyzKP9YttVm9FrN+T6yt5l703/qIWcd9M1Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzpWuL4J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzpWuL4J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F41F0089F;
	Tue, 10 Nov 2026 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289314;
	bh=x/ZP9C5ktqtIZdM83KiQqS72WLRZ5ftSVdr1VNN0LmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EzpWuL4J6+I/zv5pWeZ7mtPJAmf+BHs6lL6FZSWuTrBPo1dn4d9qDEsdRUiywjZyS
	 CWvgbiyGaqj4UO3LX9HYWz4zPswum2ZMfMwDrIYOGr/ShKuCuXgT/2czgzbZxwXZ1U
	 XYcwC9kFdkyUVuzj8FxAdLNZmKeZGy6m2ak6o66xiQ2a3cQ30nyuZ5bm8T88sjaXHH
	 Ez9k9b7Y/XYIbpxo/b3ijArQ/G5hPFG7eStCQ7S7QlDYLSeljqwlZIPLxuYZ86ht98
	 W2srXNhGqEaG97xhyMR2c6JfBLLWX43yI70XPMbxKTXPCJgpUzBJDKbl2uyElP1CEf
	 qVWDL2xNIjO6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: microchip-isc: don't sleep in the clk .is_enabled callback
Date: Tue, 10 Nov 2026 00:41:52 -0500
Message-ID: <20261110054134.462875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055811-failed-5.15-61490ff518c7@kernel.org>
References: <20261107055811-failed-5.15-61490ff518c7@kernel.org>
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
[ sashal: Adapted the change to the older driver layout using the two-argument pm_runtime_get_if_active(dev, true) API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index eeaf91d80acd7..851f9a1457d17 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -181,15 +181,14 @@ static int isc_clk_is_enabled(struct clk_hw *hw)
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

