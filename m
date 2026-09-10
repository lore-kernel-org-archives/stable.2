Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E1470137
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038893; cv=none; b=d1a/QQdGi8FlgyDjL8OaIuIwWXHTFFybQXgs8bNny82LR08lFNb8+BNQXZ1h7qhUqQjbKlt614dyoN4Qdq8XNgbACKRLurhSqmtQteOro97Yukki7kfLy740gc9pPLvfgdGZL48G8EmZ8C5NsicfWWPZ9bQIxJR1U1lZLLdqaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038893; c=relaxed/simple;
	bh=aGw7Q5oUsnPmPkjDQOcDjCbD3SwcO9Sc4RbNuC5+hk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBa53lO1Hcg88YkuknZ/EmHS8PiPiTkbgoZXLeqTssg0/5r+bnjcSS4DF6vpsAu7R3zZV+MXmaTcJ+/vqA8l26+C4lpwPEeG8k2fNbGJ7Nb8H/wYzGeQDS69UdMKfzaRwWl/h3UbZ4J39zqjcdmLR+s+b3R2WLUbr/fGWY7Nns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtab38OQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtab38OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210061F00899;
	Thu, 10 Sep 2026 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038891;
	bh=o7JcwRYsf8HECCr/VMqPOAJITjqHoOJzLrtvke2GOeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rtab38OQ0/RE3qElkOdxm9rxRmqwjNBnV454Edq9l5OTvwrAAAeDyKeXjSQR18fF7
	 etp58qZTBjE8kVH/iRmBqXjOS2aIQaukIonLMRomsMXhda68eM/iYJnIIHWzRvo6Y4
	 3jA5pFU35xbR8lpODYxvOum5htT5ZW+BAU4AGxfUsqUfGA/OhkwuFyeH2nK8vCd6WY
	 /odr8d19Q2UGJYw1oaHfmBhr5hLTzTCKgUk/1+2A0wkfIai05PXIJXNn+NUoFGQWuM
	 oqc3UYFDxdDSCEWb25sRk8Ua1WH2UqfqRUUWNuW7/nsPenBQi7zrewjguKXUepHO8x
	 tHv3LfKNS/gvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:14:48 -0400
Message-ID: <20260910111448.4188963-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910111448.4188963-1-sashal@kernel.org>
References: <2026090821-buffer-epidemic-346b@gregkh>
 <20260910111448.4188963-1-sashal@kernel.org>
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
index 97618a3636994..6994c7081476c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2015,6 +2015,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

