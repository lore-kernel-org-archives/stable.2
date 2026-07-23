Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E83D903E;
	Thu, 23 Jul 2026 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789720; cv=none; b=AJyrtwgdw8X5XiH8ioboma012Lq3xiZAvOWCWe/nIyp6EMo9846mv9P8M1dCjbFmTMZxvxw17k2uo1WMgzEL5ul7H0uTV4FuMw7sD0BUKzWaCh3eU5YGAY9wncGEnncFSUkc56zevbT3bBfUB+01VL1CXz7Gv0MIRBHIjEW6hEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789720; c=relaxed/simple;
	bh=ZTyzKpDWjooXPIMH+/kDVH4gODnc1V0RGAFDV9MFbyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OskNtgzLfIzbKXyhXQYCNa+25PgUkF5bia924nUl2QmsEx+hiWNX2vtJuYZbY2QSbt7yMSWh4VWbrxR5rP0bnSXDc/2MemeajUCSaeTH/L2/zJlV2/Pl1SWSOeCWKxwmG4fPzyUSvwUY7EMyil/UPRb1rmkr2y6zsEpkbAEuFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nle1UaRG; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nle1UaRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784789693;
	bh=JJFkdysbB0s1rRifCK+Xrms1xIj7Y5ESqta/6bqZtJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nle1UaRG3O5o7mWStWY1tUM79RGW2bJNs1aIh8V/UJKQ36ds0qYQ0J9ansKAzeK1k
	 xyfUBQgwZ+aLZC72a+0iDaz458NRy2kK7vUL+TvKQP8KVcE8l7knhXS9eWXzgtB+Z6
	 MZXLmu8BPLTwlvgiEoTKQicZKFk2ae1d894Dm7fo=
X-QQ-mid: esmtpgz12t1784789688ta4a6cea0
X-QQ-Originating-IP: v7IhKmgQxHhRSISRqV0OMfHq0etKDpiJ/zM2v4qHTbE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 14:54:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3200143436947129304
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: bq25890: fix the -10 C NTC lookup entry
Date: Thu, 23 Jul 2026 14:54:44 +0800
Message-ID: <0619C8BF15F43B7C+20260723065444.1796002-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OBJ8LfKEepDbxrbkPNEKJj5ejl9XbtZPW5FIVQuIgUSzeW8kFxUitEfA
	N922RbVSqmpEsqA5zyNs6X8GLF9tl6JmU0yaQ9PbTx/RU7ifHrs8i91uBZiKDDyGkTyctoS
	78Ppenrpg90eVbG05TRcbbsRuZieVNnLwjNkyB1BV24op9EAzqBghNfdyB/nDDeuFFPKNou
	eFLqzsNfy0Yg/oQFEqVKB9WITQyXGKOeCQXkziBz8SNXeDDqnVC2zOaGJ+xLQTz04gSLQYx
	4sq8n/uNVIZUM4dX2V75cg6rjwJn9V+zoVtE/lcjF/4OZnx4rtZVfoo3eNiI+RIQIwkk1ly
	WHhOi8Kb1HTV0liRYvrV7z59FNmQqyyp8UgYTpIdEMGGFchAfy9RZlHpJNUPRWHhP1tahXk
	gsm8MRmEybApiUTAG9CqzpaWnlAXUUG0WvWbMLkxN4/7fhaEV772VJHVmLr5uGCm4F/GH9t
	ApD02JUfGseyF6Hy/8zTEmfiQ8l6JcA1l3T/ejCjyq/1p+bUmbqFIq1x8jsBHBZOH2zJsCZ
	daH5uNlSLS6UYq7iK5TLgkfQAjQUSvCdGaGEhm+M1QYzYtKenTwJrI8XLhW7uNavRqtssYx
	0KElWTMawe1tutA06EsAKb3RGvsIKvvuuQRkbcMpIcCmrJ2/T0k5a4IBGd6eKaTWRoN7XTm
	m1izALtP2+jK2y/yRUxYu6z8PwGV56kV7b2IG6a0c9qaDi8TGKLNMNvYJoKB7Xmd8gOimaQ
	fwVvZl2IZekrghKB+bpvtbb3NEhHNL3ZbClyi9y4qq/ZbC5eK2P+jq5SxQvOlgKrbOFho+3
	QRINv6PyMbEt3qHmEw/vUirbdQWO4bDX+mU0mzGysXY1LjqasujARn59J4Wqu182w0MYb4Y
	qlZ1Swg5EVfZG8RE+KDqA1BT9kLNgR3xv6PoKwICMWlA9+NVJebiFDGELo7d7ABxpYJNeXJ
	K1qznlGu5WZoXL9UbPeEw/yYuCtYA1HH/leQYh2ZELBdkOnFmze01+3FHHDrCJSnmdCJAmc
	AxEzMZdKZD4hPfhqftTn23j9rNuW15d++tQLP5ICooDx0iCDaO
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The TSPCT lookup table is monotonically decreasing except for ADC code
121, where the sequence reads -9.0 C, -1.0 C, -12.0 C.  This makes the
reported battery temperature jump upward by eight degrees for one code
and then downward by eleven degrees for the next code.

The entry is a missing zero: use -10.0 C so the sequence remains
monotonic between -9.0 C and -12.0 C.

Fixes: 9652c02428f3 ("power: bq25890: add POWER_SUPPLY_PROP_TEMP")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index c1c12a447178..180bc137a863 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -320,7 +320,7 @@ static const u32 bq25890_tspct_tbl[] = {
 	145, 140, 130, 120, 115, 110, 100, 90,
 	80, 70, 60, 50, 40, 30, 20, 10,
 	0, -10, -20, -30, -40, -60, -70, -80,
-	-90, -10, -120, -140, -150, -170, -190, -210,
+	-90, -100, -120, -140, -150, -170, -190, -210,
 };

 #define BQ25890_TSPCT_TBL_SIZE		ARRAY_SIZE(bq25890_tspct_tbl)
--
2.50.1

