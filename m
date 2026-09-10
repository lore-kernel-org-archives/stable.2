Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58D3AE707
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038893; cv=none; b=PmJ7rq4UHcmwcPir2+zcYFF62pgiLDow0ccokOwMxRf4swCNNZ4m1QgLm+BcU3gIdo9ThSmNiyv/02pcwXLzlXsHq/eeO2ESMbB4GN7+UFqeqAj2EuTxF2rGATgjjiHJrPmQzXTudaHDWIzUcaK4tB/4M3knohBkVxEW3Td2dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038893; c=relaxed/simple;
	bh=hBf++fQgaIRHMaCLA5DSAEj8jbH2cIH1tfy3tF5D5OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8zovYQbR0DMEPZKYUvbaDqnVM/S6XhrvS8GDEKH8gEzV8FtXEoMT4GR5PXEWe+8AK/1Zx7peKbRTCC0aIQ4EeoiEbwongNL/4gU/8jKmf92kpa/MDueuvpw8oRk1Gw51ZkvXcvsKhzr+pgCzpX/m8ygS4IVYsujq/YG3Ll5Rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asIF02iA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asIF02iA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC21F0089D;
	Thu, 10 Sep 2026 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038890;
	bh=B2cFMnO3IXofZSWGyNxVywjLSiybijSs4JqcpeN/Hsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asIF02iA6q2SaGLj31+WZAYnf0Bq6V6tRtVxGcuXDg9PNpJwuDMwh7tQy4nLSBaLP
	 0Oc5/g6CFkONAnD0JWKINSOMhmq3yshwJM5w5VdX20TjtdH8l3p3RKfZ4Wfiltd67J
	 btx1a+OipRZQ7Qx6XHMJSoCUnTSA52B+wtRU40KTNn8ST1KiKBDjRSf9rhV1vgtDPb
	 N6EkURe4wM/CvsaXTYP8XscBKqY/96eJ3qD3Hd6PA/k4+/WhkWTunbT8FNL8MMd1D7
	 RNZusl3UkVEdjCYdjz4YhCgbRIaf6CQx2aZSAcbH0QpLMUGagsujDM4qaSIwa9oAuL
	 4wbj80Y4lu2/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] staging: rtl8723bs: fix spacing around operators
Date: Thu, 10 Sep 2026 07:14:47 -0400
Message-ID: <20260910111448.4188963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090821-buffer-epidemic-346b@gregkh>
References: <2026090821-buffer-epidemic-346b@gregkh>
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
index 1d44f6a3db183..97618a3636994 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2015,7 +2015,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
-		i += (in_ie[i+1]+2); /*  to the next IE element */
+		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
 	return ielength;
-- 
2.53.0

