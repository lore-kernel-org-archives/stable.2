Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB2486BAB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103519; cv=none; b=jX5B+K/beYrxGtxfK53Ra6h3WZrRPFO68hk1MDLvTh2NA42P3Fhy8FFmpX+j5EqG1aj3IIlq9LXJYkvM48it174XumigH+8kzFQQJoTzV6uKriKObYtE8QjK5wEBZyAaZebp1QJZYcnkgi5v1bQ1g04zKwGiRcyFMN+xx5GUwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103519; c=relaxed/simple;
	bh=cSl9ZSQVdOy+zCZyMWe0dHzLm4DONfM79tk+Zltx6fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpctP2lBUhHQIEmP4sfRDhL7UGxiL0fWIBADHVM4sht5EpYo+RBjRRE2DyCp0MB2cX76jSeE+n958XeUoprHKoI0d9WUCjcgoEcJ2HG8sfgmnOWoaQNwx2FK/ZS2U2SiWu7Bd+hvIJ6KzvokmZsCHaa5D3jCBHq43qbajPqKlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0LRfBJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0LRfBJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF921F000FF;
	Tue, 22 Sep 2026 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103516;
	bh=gVarwaZw7dikcqgoSh9V7T0tqqx5Hz91j8FRc9s+wTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k0LRfBJaVxn4hwmxyU5MuMGJA99Qov/LzpqinVMf4T6zf/Mw1FlRdaoR2JUeQrqhB
	 hs7X6kCK/55VhSbs4+3xsxhTJJqzknkAkIc1EyboXLHnrDJaM2QLJMCPWsh/4aRDh7
	 uzBioWiZD88JkWzRWO3fktlx75WkBG2zE8f/hJrDoixF8/D1DCnsNPD96nx86mQcI5
	 rx5h5x9aR6EsQ2s3Mol8BLZfye4xMPR+SMrC+tScpCQypmOY6mD+b8ecAlXHV84Fn5
	 Pv10foHxaktkEgvgvBAWLREbPxuqkcRazh8VzIRgnt9v2NWCNVxRyC4CVoYUsCVsHX
	 K2FWb2iUdt4tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Saim Shujah <saimzst@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/msm/dpu: clear pending peripheral flush state
Date: Tue, 22 Sep 2026 14:58:34 -0400
Message-ID: <20260922185834.3888516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092219-snout-tubeless-0f8d@gregkh>
References: <2026092219-snout-tubeless-0f8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saim Shujah <saimzst@gmail.com>

[ Upstream commit a5b5cc909931572aec446e129c035b76b3f0c1fa ]

dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
flush transaction, but misses pending_periph_flush_mask.

The peripheral flush updater accumulates interface bits in this mask. A
later transaction which sets the top-level peripheral flush bit can write
stale interface bits to CTL_PERIPH_FLUSH together with the current state.

Peripheral flush support was added after the helper started clearing every
individual pending flush mask. Clear the peripheral mask together with the
other cached child masks.

Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/748968/
Link: https://lore.kernel.org/r/20260828065440.140410-1-saimzst@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
[ Adjusted context due to the missing pending_cwb_flush_mask field in Linux 6.12. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 2e50049f2f850..b07d09171262d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -110,6 +110,7 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
 	ctx->pending_flush_mask = 0x0;
 	ctx->pending_intf_flush_mask = 0;
 	ctx->pending_wb_flush_mask = 0;
+	ctx->pending_periph_flush_mask = 0;
 	ctx->pending_merge_3d_flush_mask = 0;
 	ctx->pending_dsc_flush_mask = 0;
 	ctx->pending_cdm_flush_mask = 0;
-- 
2.53.0

