Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2103AA9D4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038649; cv=none; b=pFVogU6xHc3y1EQ//1BsrT/GKRrjvpBd4LvkUx6YobneuqqJZhwhSW//7Y2LvrDvwd+qpJQ/RZmwwdZCBPaiSYy6gQuaeUF9DRCBm8ErfT8zxz1CN0y/MyUrgxtg8An0G3DW9oEtwJVIiuVqahNn2J4hzCvrc95uyjko1KT3MYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038649; c=relaxed/simple;
	bh=LZaL120q0p95igHX8z8i0hUCrRkSBDp9mdyz/gUx3dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRfmEDRdpdPavf/7RHK5bczCqVKCt6xLJkQXpvoK7lnPuFln/cOF6OvRDPb9gevPWcYUC169d3d5DGfOc+W+WmK7WD+4RLDsOKgI24YJjsh6iX/JFVsMge9edUQQ5e3rKnGptXc4dEBHx6DioTkpGBwH2oqUx/rI39lQ7kIa/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkWrEQh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkWrEQh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196FC1F000FF;
	Thu, 10 Sep 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038647;
	bh=gZ+kdoJRAtoU3y+4uSovekm2B8DafZYPOuFVoB6Qq1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lkWrEQh+s0Jmy1ptaG0Xn1DMWsw5htAnGqvGOFW1x16fLR++mUEjVryBtJDzcpv8Z
	 R7VTwqwHP6pKi2hfgbNLQhzV+OuU+wu96eLQRHzH6wUlNr5l3ZHF2jeewwF2VFHfPJ
	 Hww7Xx1hSgvwNP8gTi72is9KADvkjgdjePMe1WfPJxoE1ShGqPgcMTeiajau45zw0u
	 lSPEuHM1C2+isHhusfnZv21XyANsfEiIsAZWdieC1m1uFfYUGdqn0xDnM4dNr53PGm
	 3bcQCyIwn4135yycg+lMcL5t0yD5Wzm+j7T6Dl64GeNidbTGvh2If0Ed81D7JWnUa9
	 JnGZFfWOXKoOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:10:44 -0400
Message-ID: <20260910111045.4157100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090821-violator-overshoot-41ea@gregkh>
References: <2026090821-violator-overshoot-41ea@gregkh>
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
index d4b6e748f11fc..8f91484743a63 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1950,7 +1950,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

