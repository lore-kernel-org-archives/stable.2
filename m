Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D346D0A8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038650; cv=none; b=AQH9RlSz3/rS/HBx9O9gtWci0yIfj/Ode3LVFH0gF/CggVzPYbt3LIK01t+OpCPct9q7uLV2BxiqK6ERifsW1hiCj269BEaAM82gjpabYLoRLI9nIKFi82ptgU+3CbkX/t7p2bsIkfa47fpo+bzEFtPfXskkMEZOP11OCqWN3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038650; c=relaxed/simple;
	bh=fiSOTK9EppR+y0yw083OhlDV0mioEi3D10YgikJeOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARdCPllO+yw9D+cLW2c8QuE7pT9iy9Tw4/yS/l73a5BvA8RfLAxny8sCfxbbQHosuUnPXrM7Gf0V8MncZC08tnevXhc8qCDG/pcfFydzdANoExUrpvCXOQVF2eJSKRHSWN30MwioIsjuCoCR10E/N/IGKPjJ5qL3WLLRtVE9TIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPTQIgWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPTQIgWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0DC1F00898;
	Thu, 10 Sep 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038648;
	bh=WawHUobtztAQSV9sdAPR8xUpiRq8nQjUMdgc2w1FuIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPTQIgWpCc6QMx+T1+ion5yAEpE/dzuWjRh8vo9aVMX073twBS/bHKTPqXq+ZIdJk
	 KHray9TJcW+shE5so7ErkK548PdI/hFBapatZP82GEM7gVxL0nW62aRkEEmiGy7nn2
	 yVKbaPTH2+TsSsoEGthdSbxBrhv8TLSMIOEBMR3Al+O1/BHvziJ7Xkv4e8521cJSib
	 hbNysUvJ8+HKVmQpmuUvcSAvmi9pFvSk8qkBGedbyQ/RbsU19LjLEZ70Si65PwON3x
	 I3pYRnB8d5XvVHoTK3EoiFbnD8wC+SeN5JMmWrKPnu3eV6aZ5FbqPkmTkUP5wxE9b4
	 S4siCY0KTASvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:10:45 -0400
Message-ID: <20260910111045.4157100-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910111045.4157100-1-sashal@kernel.org>
References: <2026090821-violator-overshoot-41ea@gregkh>
 <20260910111045.4157100-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852 ]

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-4-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 8f91484743a63..506ba55f15b78 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1950,6 +1950,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

