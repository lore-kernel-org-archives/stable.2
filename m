Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB80472069
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039628; cv=none; b=O7j4I18Ob9YXZFH9dU2KQzQuD0GOllKeYaOU+Q2lML4xi66hK8usWj1fX69OMl0bI9DZbAcOPE1e5UixMsAihTY0y45yuNVcFlD89mGl5jT09rUpcgzD5qtIj0wMoJiKW5gzYh7nC13ABm14eXCmrKphcPmO3ZDoaUMn86LPxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039628; c=relaxed/simple;
	bh=G1TU2Nlb2SBVhGgXhH8XcAibuAuFCMAHbrXRAu4SJMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfwX1PO8xuM67vVyafzC5pGD0ZZ8b2WGIRVPgaLr867+hXy+drdKCqo8BLH6fQqWZq0U3J2oibPVC/WEtWiaJHFrtD4qyT0cPrrvY7ihT5gvOO/yEICGUcah7mT5xkNu+k8SZhX8vHoNmMMSUhw51zkUnwJpVBH569rW1lto4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCe25UVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCe25UVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984B1F000FF;
	Thu, 10 Sep 2026 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039627;
	bh=1IsqbNBQXshkQq1BAvfpajw0lHnkye8FsBmhZxvVcWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cCe25UVC2mlq0fa3C6R8DrlYpx0RSQZbvWbrU3lvVbrfig5oiq1xJZXu++YRdYIrA
	 T0MwwnayHymDeAHDymYgwJ759tA/3fYv3mtDQRkarOlQ/S3HDyLJiSfIPR3O6rx9ek
	 i95JnHXBVRBdfkg+bCHGU/gxl7/Ur9y2xF0szOSIvWWrbOy2dMG2ryMREboZZr0niL
	 Fm0759nd6jcphRzPeZQHQNxPrEZtXTql6+qjv5HZXQl/FtY6p5w9G7sUcgcL1ySkyx
	 v6GSt+oHx6GvD+tDhXI/hzwwRbo6IKcgC5QrECt9CHrnUuThIHLg+LiDexlfBBTsmH
	 97Hf6fUt99SrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:27:03 -0400
Message-ID: <20260910112704.44538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090822-abacus-psychic-5063@gregkh>
References: <2026090822-abacus-psychic-5063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

[ Upstream commit 2038fe84b8bdf894b634f777096685e78e8f3774 ]

Fix several instances where operators lacked spaces around them.
This improves readability and brings the driver closer to kernel
coding-style guidelines. No functional change.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Link: https://patch.msgid.link/20251205021417.2705864-3-vivek.balachandhar@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For this stable dependency, retain only the spacing change to the IE
advance in rtw_restruct_wmm_ie(). This supplies the exact context needed
by target commit 28a289beaf226 ("staging: rtl8723bs: fix OOB read in
rtw_restruct_wmm_ie()"). Drop the unrelated operator-spacing hunks.

Keep the existing bounds-first WMM match condition from stable commit
4dd2d9cf563c5 (upstream a75281626fc8f); applying the older condition
would undo its out-of-bounds-read fix. No functional change.

Stable-dep-of: 28a289beaf22 ("staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d7fdac14e73dc..0c8b1541f243e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2025,7 +2025,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

