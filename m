Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1446EC8E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038551; cv=none; b=epMvkTJQcXUgF2Y1yEMqspxcgFpEEXdwLeIJySsVjr+2xzSMFh4HYaQMIUmV7x4P4QQ+5wE/M7VHsyXwfvNnENNBAtr1qxiTvpcnlRAXuY+D9tyWCsagoO9vat+FAuMrxkpk1+9rWDbDtyzLm9g9RkaSiQtQVdaVlDjV6Q4sPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038551; c=relaxed/simple;
	bh=NETqUN79xECCuTzR6a9i/futZUApRLN0tOO7AFN1pTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7Gs3iU+luGYx+H1bZl4YrA3xOw8Ru0AdU07BX4c3dMzlDQpNDLGdC4aAoDaHTnKIoZBTd3Gkub0VGPms272YRdSJQx2rBSfMD3Rzv+LsrgSQVo/f8ZhvbWcX1EPatrxAz4HN3Af0Uk+7Q+wer6Cx83BGJZ80XT5uJHLPtfcQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/y+4Tpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/y+4Tpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997AB1F00898;
	Thu, 10 Sep 2026 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038550;
	bh=IxIeb4pdzcXWn9PaQlTsVczVbQJT9gCylWwiJkhR77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/y+4TpeVpSSfSjBeGKoMYvTeV07frvVKIoQHZdo3ruG2zD3Fnqg0IF4h3i30l7EY
	 XtushgC5P9mAxf29YxbeS7rebDTswLvW0d9RUB4ULeYBpZHB5duOFH/Lx0l7CGPtvf
	 juSWcz8cOW9gj6uQ1llvKi9Yqjxv8YQOkNWYIszTKQg/4EaUj3Q4Z7JB8vYLh4/Gzg
	 cdlzkaLhVoxvrR4kEvBSjxGLtxJ/RfyL9o9dYe8ivRMxP3BonLk7Qos6eVrVRjB142
	 glZyBue/ym0iJ1YrvjHBM2OIeOchaQrtV4tKmWdjmakA6tsSpIDhpvRTptMlsJAwwo
	 jD3mWOynb3Ljg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] staging: rtl8723bs: remove commented out DBG_871X logs
Date: Thu, 10 Sep 2026 07:09:05 -0400
Message-ID: <20260910110906.4147966-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910110906.4147966-1-sashal@kernel.org>
References: <2026090853-convent-spill-68e6@gregkh>
 <20260910110906.4147966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 68e79909e1d84251ae1889cbad45672f5ba85d7e ]

remove all commented out DBG_871X logs unmatched by
semantic patch.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/125e216e3bb5bc938e06b15dadfbbf51d9517dde.1617802415.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For this stable backport, retain only the commented DBG_871X deletion in
rtw_get_wps_attr(). It removes the line that prevents the unchanged patch
for 99aa998dec83 ("staging: rtl8723bs: fix OOB read / stack overflow in
rtw_get_wps_attr()") from matching its insertion context.

Drop the unrelated log cleanup in the other 25 files. Those hunks are
unnecessary for the target and overlap older stable code, including
existing bounds checks and debug counters. No executable code or
functions are added or changed by this dependency.

[ sashal: Reduced backport -- upstream 68e79909e1d84 touches 26 file(s), this
  backport carries 1. Not backported here:
  drivers/staging/rtl8723bs/core/rtw_ap.c
  drivers/staging/rtl8723bs/core/rtw_cmd.c
  drivers/staging/rtl8723bs/core/rtw_efuse.c
  drivers/staging/rtl8723bs/core/rtw_io.c
  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
  drivers/staging/rtl8723bs/core/rtw_mlme.c
  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
  ... and 17 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 99aa998dec83 ("staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 3f2ee8b34e254..82bd36f3c1cfe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -798,7 +798,6 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
-		/* DBG_871X("%s attr_ptr:%p, id:%u, length:%u\n", __func__, attr_ptr, attr_id, attr_data_len); */
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 
-- 
2.53.0

