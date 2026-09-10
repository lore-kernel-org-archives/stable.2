Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832B4749E9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040178; cv=none; b=eRePTaX9eMauz+All+wlccHCdB9dXjD0ZFm2uyhoWY5KkvSGgHX5XMmxAGpMafDL7DQ5b7LxcpOuja0AwJiwfDs5S+5h2jE7IOZi3XJgcPatDJ+JVEa/sc8q0HnyW7C988zyn8JIxvihS3KzibjmgFNm6ZlnveoZHkjiMGLxgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040178; c=relaxed/simple;
	bh=VsuSgk4kVDGlaO6mKAvXI8tGgJ1Gd6YF85/rQ2LL8iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhBgPA7RTEuqXM3n6gwR53nqIrCQkP+jyacr6FfSMvH78hZlHNmIwX0fxP9akICiRDr9OvY86TRIHSa/8C2QSf5zaK0pQnZ+4qRFpesbzt2MWEkhQIkcVxElp9VszY+bfQjTlp/cW2e8Xut7l58YR8G1ytlZXu1+MSyQNi/eLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Gm/6qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Gm/6qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBF21F000FF;
	Thu, 10 Sep 2026 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040176;
	bh=t+fzk0u7wr8JV5opaF/iT13y+74VPFI65nTaRgX8y2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+Gm/6qhvUm0cR8Xfo1h0OPDMP+OysE4K3TIso4vQJOFXxDi/IZ3CC51osXoaBfIu
	 LlBi/lzUXCFbJLdnN3lQvBgr8gM7GWDCcoz1uaYrSlTjebVLAneFCtlEzRMEUPXjBi
	 5Xtp73yAroR1GC0Sd1Q2Y4tvCyDxYjrzHwBK3RliChVdLJylAzNK/D1Z6k5Atro40Y
	 v/NvJORZIVE34yBFrplyozlcrbvM9+N/ZVw6hhF5XIfJRwXicSAEGfF3EMUH51zTXH
	 EQUVsxllHUeiuoxhnzZKH95lay7TrihpHI7wI+Vpk5rfmMcR2GOBja8Kkc8bCo4OzI
	 tsAtcZGyVcI1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:36:13 -0400
Message-ID: <20260910113614.77812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090822-rematch-anvil-8a95@gregkh>
References: <2026090822-rematch-anvil-8a95@gregkh>
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
index 6604fe7b378af..1f97583a6536d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2023,7 +2023,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

