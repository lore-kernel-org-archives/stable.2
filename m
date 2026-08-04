Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DFA3ED3CA;
	Tue,  4 Aug 2026 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814958; cv=none; b=QsyEBVBpCV6heJ3kwzdH9BCcwkM7iqVcWpCevkJzchciope3ojX3elcTYdybt98k0bDlkDcQfNidZ+2TtTmwXnoP5xueZ0L8BlfPwvqbyjieuqcsAd/c9JeslISrlU13HCZs+NgWtrOdf2gWXLQt2BitfXsRWrUZBxVmWu9aLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814958; c=relaxed/simple;
	bh=LzhjBNRML2rvdGmtYckjNRqZvdFukhnA3bPTncSsrG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbLditCc4g1y9wcggfXrhfMYLM8xUeR/MjKSFivL1oe5i4J0Crwlb89sKuv+6cVRHncbsgz/Vv5V+0MmkRdQ6Za83LW9pjGEfJWCsoE+HtfspIxFOloTIANucuNQycpcOAes65VhJyEUWnMrcO87BSc70CzXJijkRoW4lOeu6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FwWJi1gj; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FwWJi1gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785814917;
	bh=Z4yQEQFXFRJNBAaK94dLNr5B7DXT4Gto84Nxkf0fkCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FwWJi1gjFZ8vZpQb4uzCE2vv+jB+0+/aX1mBxjZSKcCeVILqhSh2stB9JL7feRwSe
	 3AIWbsvfq0wM+YgCEC0XnUi/jvubJ1kA5GEIuaaamGX+ARxfA1bFE24P2o+KPW8dS5
	 oOO3WpZGo7hneXg70W0TmrDDzExWWG2PmSBTJONk=
X-QQ-mid: esmtpsz21t1785814900t47a0c24b
X-QQ-Originating-IP: 9vkOhPgYsB97kQ24m2OnD9TrnPmOI1Of/w7rjYN1nMo=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 11:41:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6654981945826137558
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] Documentation: block: zloop: clarify capacity alignment
Date: Tue,  4 Aug 2026 11:41:21 +0800
Message-ID: <8100621B7A58105B+20260804034121.1036479-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0be2d538-8e18-45ad-9181-f7e3fb7e02ed@kernel.org>
References: <0be2d538-8e18-45ad-9181-f7e3fb7e02ed@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MMwjR1C73eIs7bLdl6V6vVajvobjZOUbIRyVqhkmNC8tYrzwYxCAQryb
	AaZD8kf7WZk+rvlpxdKTJ1JSsVmOSzCKNLOtrzVw6kY8B9IAQixSj0imQg/431a3DSKcd6y
	7Jgh743MKAg4KlOmZVthJEZ83DTeZILErAeehdRlqG5IAk6bceFx4AGWySi6gnSf/ALfvII
	W+gKBMjfTFGu9FzVmYbvIVSRvSMdx+vFJBakCviWRCWXGTO+epFryi8UxI5GBtAqgtZC6Zh
	frjJ+ZDuce2QnOuLXzdBDVB915S+NmE6f5W7wEsOu7beZqICvNYPzNfhExkFha6eUmqSFCZ
	mGfwfVwspKnWBiQq/abaKorKTmeTDrkQpplQz3do8HgnncCQMDJ0XWFe5ThQ1YKlp57WAZ0
	pUoSMsoF0A/TeKu74f8Msb14obuZ2Xfhb+6NJrzAJmAkVEC3BSN07RKGCMl2HpBAbsHfFYP
	Tzr5tEVsNTHfKKfXZwNWJTOZII8XeuvE4ZDyt+BPkEunoSfQqBVybzy9mfzIXnka5F+FGUC
	AGyWQl5wTpAPopMKZbbCzcqDKQiEfZovf1Nkbxz0YEfxaInZR6Ool9FSGHG2wg/lmZ1NjIM
	cxt9OVL6MUnTgxhEA3FaD8dn81IkQaYoHG4IrUfhurto4tAu0PyZlLwgFrACiT7/vbYr73o
	Zr8ExYPZZXQ5UkhL64gq5SClnkmHALs+Xrq6tNFZXiFx65iQdg2eJNE/QH4wzsjx6I6Tqm1
	k9+vkaoQf1NG5czteZL3IomqOneCXvu1reE/dKO8Fgv5OfoYJQx/zH/4ly8gl2Xqn/CjeB/
	wald5HmbcwaYung52vfaDibIyoLkCJzHETCSRc7pbROyqCTAzERWO3GxROVD6Hs6h5Fhb7b
	LmyxwZgvkb9YZw9W1eDL+cxmZ/n2YaIznvDD+sxournSpkr/6mN/kXDOivvxKHzMxgHetfI
	s/cn45veJ1GMPelbPZopFs/t+wgb5eMNRUEv+vzvsa1168GCgRYo9prl5BREiPrDRRg7F2U
	eLFEpVTJYE7DsvMpfEXG6u30eR5hCTOKa0ioma474LR5z+l0kM2qqpjejhccjUlh3Pdls1/
	9b+0QVrZdqMfEENA3+QOZcuR+YjGSaTpg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

zloop divides the requested capacity by the zone size to determine the
number of zones. Since it uses one zone size for all zones, a smaller last
zone is not supported and an unaligned capacity is rounded down.

The capacity_mb description incorrectly states that the capacity is rounded
up. Correct it to document the actual behavior.

Fixes: 9e4f11c1228c ("Documentation: Document the new zoned loop block device driver")
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Replace the code change with a documentation correction.
- State that a smaller last zone is unsupported and that an unaligned
  capacity is rounded down.

 Documentation/admin-guide/blockdev/zoned_loop.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index f4f1f31..fd99e5c 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -71,8 +71,9 @@ follows.
 ===================   =========================================================
 id                    Device number (the X in /dev/zloopX).
                       Default: automatically assigned.
-capacity_mb           Device total capacity in MiB. This is always rounded up
-                      to the nearest higher multiple of the zone size.
+capacity_mb           Device total capacity in MiB. A smaller last zone is not
+                      supported, so an unaligned value is rounded down to a
+                      zone-size multiple.
                       Default: 16384 MiB (16 GiB).
 zone_size_mb          Device zone size in MiB. Default: 256 MiB.
 zone_capacity_mb      Device zone capacity (must always be equal to or lower
--
2.47.3


