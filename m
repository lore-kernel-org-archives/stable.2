Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82C3F1AA2;
	Tue, 13 Oct 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886936; cv=none; b=LoYbO/BLw49mTupL4jzEnU8PWBRQ4T7Hydi9Y0XApTcxaPzIc385ggUuqtSFJNq+4hMmpKov6y7EEKsK6UQCaSYzhcAWCqZViH15BhPwCeOJen3VqjggnGdx+aDxu3au6nusOWYLIdaXja5v1Uwtn8D3YhBXIjxZ0Tomy1jmIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886936; c=relaxed/simple;
	bh=Ky2kP2DA8ziFQIL3J+M3fYzbtzZbJk7dd6k94SmjF74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoD5OeJzdD4InQ0byOBLvIMZg6jKca8+K+NXVEZALscThPVS628+VIcUXP84RriI42tpRO5uQQ/lwNgMBQWDaFjDeir4h8YCOgvMFsnsynR7nnw6Mr8XZcZwFH+fVmnFkfMxQ6/HN1b+gXJXiW0in4LIr4UMD743ZnLPJDJoer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=W5dWHjLu; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="W5dWHjLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1791886899;
	bh=Mpnm4shc9l55wyY0RkbVmcJWu/Kz9qUJN5O9Z9s8Dwc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=W5dWHjLuHD5gSOPOYBh5eMO6z8zVv1vhigE1wDarP6h484aq7KWblJDOkB22/jFFM
	 5zbFAlVuR2RhfIZg2egHeyG4y3SywLgexPNl3Qodl6WwM6t6MkuAh40Gi8LnHQg86L
	 u9z2AFRGXfbJxP23iFxt7R3emCh9LMbts9EBrYOw=
X-QQ-mid: zesmtpip4t1791886881tb0d17ebf
X-QQ-Originating-IP: JbO1foC1vY62mHg/GJOFGqGB8AHZYn+9hldLstOAHQg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 18:21:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9581138749140494298
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2 6.1.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Tue, 13 Oct 2026 18:20:41 +0800
Message-Id: <20261013102041.2113948-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013102041.2113948-1-guanwentao@uniontech.com>
References: <20261013102041.2113948-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Ofd1RXcZI4OE9GZlWWKOKO2UptiAzXF9bwpuR1BRj6PgzKgrhVKxt7F/
	jCLL7pbFgMKXeHOQRizi0TvSXsTDSP9OfTavZ7wj48kUXFWSRoeywkclfyXcNXSSKgQ9xKb
	fNf5RLC6mcrovNNrFY7qtsnOT+vYOE6o+8+cjAr38iAZ/wj5/SMe94eiPblGDl/9R01xOxi
	1LqDitsvdsToTdnEMf2vVoKTHTdQtCiejFPgtkoYtJMd6DwcYJETOqqjXZyiv+g2ox+ifmp
	KhlNvwilGqIWNNEWfQzdNNS8e+tC4HncPjeqrqfW6b7UtCHueHRRryokw+CVYs9USZQyjUd
	Od+vLbmRRtImUQG8SYVJlBD9EvLajIkJFr2SYytSi1uMCIWMTMeyOsebZO6kd+VP1kqnXDd
	k8iEvCpZGfNbMPPZk64Kl1sesB252JfywZ66fkKnpJFk1xUXBQMbyvDR0zDnAmQJhZsKrK4
	MRyTcMttcYjdGqvJRZsVrQ/gOTxXW2M9PUY47dszd0ecRBt77NOw1zPFiZhuWwgM/NPIz3D
	VOi4F2gNl2mMshbXcfUCkEhzU/FSXi9FRYRRl7JVklcje8eCBOWxwa3OwZVprvLtnn3E+a2
	JjLEeFnS/yEWnDJFO6jnVziE4Y/otFS0E7s4G9sCW1bC5RZwJj6N74kJ0lPihzRHyn4j6iq
	5qfcNHppu0gJB6HvlArp81Rydit+XOdrYNzRt1tz0TObPSp5vqp1eUms7xpAz6O1xRXqkx8
	FvzlvOI0ypy1s/0vbj/u6uujnr6qlTQALFFrMdAtWquxRKXBGfE8BWmj511jmwhBCuIJ/MT
	3yC2NGIk2C8A24ESJ49fvlBV0Wn/E82JIVATsAtWromkSIUjrC9sKUGAxHdmn6qzK73z+Cg
	1z31PmJRwIg62FXxvq5vH/yE0aUcoAb4OzY01W/zB0O98K5UlBfzKBSqKxesYLBvZWJFWK7
	Q0Yrx1YJKJTH/vOBBrksqSCl/xG+9EkUIbq+1bgGQzylgFLw+YjWjUqmLsGfeHhv2E+YPXA
	mqsgTEpFKHu1raRcXuy7PwDG/sztuYe1P4M9k5cCOrA24tOAr7Z8DrHmd0H1+7KWdMamGJ7
	uKfu0MuHDlS7SZTAKXJ/RS7M78QrYZbPWYca4slXfijd7Kzb69LbXEbP3ozZ2+d7qTU/r9p
	JHGD1qmaRGDukUsnAdezbtxfLNzIr6vAWqmc
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

This error path returns while wdev_lock() is still held, so one
malformed IE request can permanently block later operations on this
wiphy. Route the error through out to release the lock.

This bug is stable-specific: it was introduced by the stable backport
commit 8b921a899346 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()") of upstream
commit a2f5286ca4f3 ("wifi: cfg80211: validate IEs in
cfg80211_wext_siwgenie()").  Upstream is safe because that function
runs under guard(wiphy)(), added by
commit f42d22d3f7963 ("wifi: cfg80211: define and use wiphy guard"),
while this tree still uses explicit locking and the separate wdev
mutex that upstream removed in
commit 076fc8775dafe ("wifi: cfg80211: remove wdev mutex").  Backporting
those locking reworks is not appropriate as a minimal stable fix.

This is a fix for stable v6.1.189 backport commit, so no upstream commit.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
Fixes: 8b921a899346 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
update commit message as gregkh suggested.
---
---
 net/wireless/wext-sme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index be121fa36c514..ba6d8827f64b3 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -352,8 +352,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 			/* nothing */
 		}
 
-		if (!for_each_element_completed(elem, extra, ie_len))
-			return -EINVAL;
+		if (!for_each_element_completed(elem, extra, ie_len)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie) {
-- 
2.39.5

