Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D76475326
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040547; cv=none; b=M0qtqcC4efjUe3yEnlbfesBDBGA9uiWThQoT8wJHMjt8IOyvjv8nAV2xcItDw+B1Pz4AszcXRIGoeGkQKKhkZRX631kOuaohpgOAN2+73BbSoJxOZsuYWARIIIUbrCa+0R7Vy/2jz4U8ZCq7FrXOJxGbWt2kZYRuJqIeB8Np3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040547; c=relaxed/simple;
	bh=E1o2kHhXK/r/Fg43KkMpXI49b7Nw32UZHxgn6XMxGL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIycxlsRQ4Uq9wsUT0uAycPmlmxGPNDZ5xvcI95kyhxF3IJXHfy0TJ9XMZxPRztpUW+SydHaFr1hyLWfCUxK7HogQn551dfg8E7EKC2lHY7+ET922OZhBcJZRwnER22yJqycPi6ZVKXbbM0fDEzxPjLR2qQxwA89bzLf2wDBclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvYBQOax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvYBQOax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107481F000FF;
	Thu, 10 Sep 2026 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040545;
	bh=0Z7wDjbyeezqZAnPLDcMhZwf3RpbRWxhzfXDBJm4WIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvYBQOaxcQ/K0jzR49v3j1MiVHQnEtRdo2e/sBShTOU5aqTIFnM36pn8oPXyy6K1V
	 CQZpSDQnlKLGr50+r6ZSBfNtdQxVj+ig/7N5C74/gonk6g+HkwfJ4kf7kG1Imdh0/M
	 kTf5pHwHEqPJ6m8eg2vEFrUfGfezrXfvS+7bqUnxjzrqdC91Ukb95cM6iJLgg97Ii1
	 KIAPbN6jxlMuCUm3ZG6SPSI65SbxYg4YE6fiWAccjJ94P5a+dKQBm4Gsh5qC0STypy
	 cqGBPC6g0EX754ZeZPlG7SlcmXSzigOXGY8cSoURFIXaTj5AojFBswn9H0gSPcLOQt
	 eMedlCYRZy8Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:42:22 -0400
Message-ID: <20260910114223.89615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090823-contour-casket-b871@gregkh>
References: <2026090823-contour-casket-b871@gregkh>
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
index 3517a5a4c492f..b08186a2af5fa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2274,7 +2274,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

