Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E03BB9F3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040179; cv=none; b=f8gx4wJ4iJTGNpDJTSDaxK1Tul/7Dx2ZL0FUCdkAuCoY/sMAORnUGpTLQbP9UNd7V7niDEIFrslds2Pi1P6pkYlA4Gq5tCFpJp9Q3irw1jxgMLsIe7Ek/VggFcX0dCk4nePSTzcbEpcZMXF4fieZkhQ5b1GEXwX2qLKDFDIfhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040179; c=relaxed/simple;
	bh=Qx1gIKYGrjLRYOyjFJwjIM3SXxKb4xwhvnLxfg97u5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDHLWkXHo6/hFfjOoCsKH3E+RYu/ShxDHJEPxh8aH/83iiomGmC+Q5xGXvHHBF4wx+1imx263LxynBqBjXZy5l61A0JmSP039Dj7nn4QTPEvm4/ecngUqCGzB/Vt1WL8eMCU3Njtp4+bee54LRPzgBixqEYszTOehiClN66uaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSjE751n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSjE751n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EFA1F00898;
	Thu, 10 Sep 2026 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789040177;
	bh=YiEsu/o2PuXsVWMqkumpMC8vWjHqgrAvzZGm5vCu690=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSjE751nnXkoDVVM+mrftB65Ot1OZSz5G29zdoRbicTo3F0n5+/Qp00OC1GJu1W7Q
	 dhUymZ6c8nnDUjfx+OKBavv3SZQXC/lQdEaQ7IMNSbdwI4YTiGJCYXaCVZqDAUJ3ps
	 7DY6Zo+I52kmzHfYPrqaPGpmCSgXIoQsDp1zuJtv7cX1NjlzmL9WaNvx3h8PO+QEm6
	 Puvhi+eNqNqUt2OjzXv5xdVfj7mK4u1EOTykCLv2WvllaK+A7qj7z8gpQrk0L5ckNE
	 fYSzyvt1nKlduObM7pvsZQBDeGBmoLlyKOtt0dVl279+BTXwou5LGtYjyow0Oy3GiF
	 griOKQOYCtYwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:36:14 -0400
Message-ID: <20260910113614.77812-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910113614.77812-1-sashal@kernel.org>
References: <2026090822-rematch-anvil-8a95@gregkh>
 <20260910113614.77812-1-sashal@kernel.org>
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
index 1f97583a6536d..29a83f1e1fbfb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2023,6 +2023,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

