Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4691DCB24;
	Thu,  3 Sep 2026 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404861; cv=none; b=bxRfhD4i9dJf1dSsi7P/SPt67vBMk+iScXQymmesME8hMMtMFlLM35oi1kRdmAlNyVc61TpE56SY3r1zGjiRU8cH55i80r7fSzBdAAq/JesKKz17kX0/ew6UCM9RLzj0mwckSZLp4f2sZ6Upx1nqrruBbeTXQwP3OrBjE9BsBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404861; c=relaxed/simple;
	bh=AYVuTRo93DbErgNAym134QGDBTmnOER6GCL1ZICH6RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mTgr2i2KOFIca2wbJ5Syinq/AtJcJfmRvLyzGPFv2UDl7kdFWzMNSOYMACaPu0dbXh9hUtOprE1zxFGo4Cio3aRb4iZcaq9xiB/FUgngO6jlQ6M4H9URQxPkdwRTLyBKafrpPbHW0DUNG/9tkgnWhKZJQO1X/Kgc+HdH9ZLh6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=TVvsUY97; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="TVvsUY97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1788404801;
	bh=iBShIJ2d+BzB2SF86DEbL9Cr3jsm4doMaMu+2XL052I=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=TVvsUY97/dYnghNseodXeQUgWjNY1u7bYpxFDQI6t9w9XVyzE6rc8mqLtaoH4GKBy
	 snpMjm2yUAcI8lao0oaUfahI4GKWSqEsp+iCWzBV2L3si0wWKXEfFoJMuZ/lmGPccA
	 sYoCvelo4v2DIVlzOP6B6TFWCJwfurzUnHA2pXwk=
X-QQ-mid: zesmtpgz4t1788404798tc132e466
X-QQ-Originating-IP: K8Ail5GM7w1X5jisPHX0MXDA+essN8k4gh/zW3TFcFo=
Received: from = ( [58.254.69.95])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 11:06:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7870038824526874509
EX-QQ-RecipientCnt: 19
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 03 Sep 2026 11:06:24 +0800
Subject: [PATCH v4] clk: spacemit: k3: add CPU PLL rate tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-k3-pll5-pll8-1800mhz-v4-1-afafd9cb47d9@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTW7CMBAF4Ksgrxk0Y8exw4p7IBaDcRqX/CkOE
 RTl7o2pKrEgm5Ge9OZ7TxH9EHwU+81TDH4KMXTtErLtRriK2y8P4bJkIVHmaFHCVUFf1zodC2Q
 Rm+oHnCVrNCMXWSaW137wZbi/2OPpL8fb+du7MVmpUYU4dsPjtTtR6v1PZJ8nJgIEVmy0zXPnl
 TzUob3dd7Fn55sw7lzXiLQ1yTeNcEWTQMB8LktNyKYwq5p60xStaGrRtEJ/wcLYnPRHbZ7nX16
 AbwBvAQAA
X-Change-ID: 20260802-k3-pll5-pll8-1800mhz-c81875a0a944
To: Michael Turquette <mturquette@baylibre.com>, 
 Inochi Amaoto <inochiama@outlook.com>, Alex Elder <elder@riscstar.com>, 
 Haylen Chu <heylenay@4d2.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, stable@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10027;
 i=troy.mitchell@linux.spacemit.com; h=from:subject:message-id;
 bh=AYVuTRo93DbErgNAym134QGDBTmnOER6GCL1ZICH6RQ=;
 b=owGbwMvMwCU2g/N9w09jE33G02pJDFkznljN2CP2d4Pjs1QhvQgJkSA+8Q72hg8ireEKFaFnf
 zQuDMvuKGVhEONikBVTZOl+wLOtwCfKtkCg0BdmDisTyBAGLk4BmIh5BSPD076p2ZYRnRYMAWUn
 Sz0vNb4xXlF3YaKQXOqZjbvy2pl/M/zPnMiSV7lmV8SkCrcK3ssW4mdr5uad5Po92e6A5rON3gl
 sAA==
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=openpgp;
 fpr=3FE5535CF1B0E658E57DB59BAE1C2FBEA7DB42E1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Msr5cRGAMwRoKoBTG7dioCq6sNLlmj73S25UsNL48iaFCZa5/0y/eIPr
	W7dzJCOhoro7VMmp+4hbVq7JBeOptRaCNwNZbHOuXNPlvn3TN1hKuBnVlZbJUEE8bDwpjVb
	ucE1s2CvdlGJOdxdxb9cTrIJP9+KkWMxorLfE7swjUyJfqTS5ACEbOhwLdQaNsmMEfdJP+L
	ETfVnIehOP1S8iLkSv984YmZ1ytKZkCXv9WYelduq9GS9KUZQDI7gqQ35NZxZoOQbUCZeCz
	vpwrZT6AV32Y0nDuc6SdkZ1MTvjzDcBAlF19IUKl9+NOf7RTVDzcD4uePFVECZO3U6EQztg
	3Jo1nyUDMYBIsekZMmWQlymjp4CXTyYn3rv9H/bK+zzRynpHVeRHFrKLg6i/KFYUskFbq2j
	Bu89czRqNU7MVSezrouY+48Sl0nvi6rC/A0b9ZSyjqewpCTsuPhOGdmupr/2QWRLCH0YrPY
	n/4xSGS9mlAaEKGlY+uoSe6lWXLV8j0+i+8SfhFqPmhsraTYCbbt4zdFVCp1l8ypwwoKq0X
	uhZdu1jyAiTjfnFmJzszBqlyZDEgAVhpboKlVHoQ2tpQCKP19w6ZuqFJwbAze4OvGV1zsZD
	SQQ6mvAXkVEr2kKm3xcV1gvVCqyxyvFVLcSwa/bM8Xu634rvFNgj10YOd+LQXiPgr/MVXlJ
	j5Dvk0hhc/9eBhY2XUCum0ZvuH5MPgk923bIrKYZ2LE7DuxHy7WFoLuCkQEbrYkyqikLhAB
	ihx9eXMjOfRcRGyKui/HcmNCkSxLhICBtHDbfAqKB4hUBcJ5U1+ajmWELeI5y+JmceeWd2N
	4rglvK5RiI6a+yr94tGwg/SKxICFlkbsbpi2ARceug1srVROwRwe2t36cuOG3mlwfJbZ6Zo
	4JbCmN2Ph6IVsFXYWhOKZM7zkoDFgmOEgv5o0/pD18CjzES68U6aU2DD/JcloJY+Hd/dWYX
	zdajdtxtVDbvR5gFvh4B7q2908KcbO3s5FOrBDJd/8Uh9r/cOMDInNCdbfbe2c4Lg/6OW0T
	OjmNQAeSqjelkOnNCRQkz/VBdX5zpHh5EFMkiu0rhJAvpvP3/JNyxwubdXYXcdRjynmC6pv
	/aZChh6gCDN9EJovyzRtgtaAoTa6YzswGdkvKH49E/3CA6UFtXbsta097L8p9P799YjNrdl
	MPLJ+XG93042hcub4R0v/3qJXL8fDxaQ3ZEj
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The K3 CPU PLL rate tables currently describe only one rate per PLL,
although the hardware supports a wider range.

PLL3 and PLL4 support rates from 1.05 to 2.4 GHz, while PLL5 and PLL8
support rates from 1.05 to 2 GHz. Populate the tables with every
supported rate in 50 MHz steps.

Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
The corresponding U-Boot changes are available at:

- Add the CPU PLL rate tables:
  https://github.com/spacemit-com/uboot-2022.10/commit/787b5cf44c8dbc99db886d5522c0c9cd5a96ffd6
- Correct the 1.10 GHz and 2.15 GHz table entries:
  https://github.com/spacemit-com/uboot-2022.10/commit/16a775c20e9efb54ca55352215e76eb3f12e6cf0
---
Changes in v4:
- Expand the update to every supported PLL3, PLL4, PLL5 and PLL8 rate.
- Drop Aurelien Jarno's Reviewed-by and Tested-by trailers because the
  patch scope has expanded.
- Add U-Boot references for the complete tables and corrected entries.
- Link to v3: https://patch.msgid.link/20260831-k3-pll5-pll8-1800mhz-v3-1-530ed0978615@linux.spacemit.com

Changes in v3:
- Mark the change for stable kernels starting with v7.0.
- Add Aurelien Jarno's Reviewed-by and Tested-by trailers.
- Rebase onto v7.3-rc1.
- Link to v2: https://patch.msgid.link/20260810-k3-pll5-pll8-1800mhz-v2-1-aabff510a797@linux.spacemit.com

Changes in v2:
- Drop "clk: spacemit: re-enable PLLs after init"; the PLL init issue
  will be handled in a separate series.
- Send the K3 PLL5 and PLL8 1.8 GHz rate-table update as a standalone
  patch.
- Clarify that 1.8 GHz is nominal and 2 GHz is an overclocking rate.
- Link to v1: https://patch.msgid.link/20260804-k3-pll5-pll8-1800mhz-v1-0-a3a75866ce32@linux.spacemit.com

To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney+clk@redhat.com>
To: Jerome Brunet <jbrunet+clk@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: spacemit@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/clk/spacemit/ccu-k3.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
index 92b930d5ff30..950bf531c734 100644
--- a/drivers/clk/spacemit/ccu-k3.c
+++ b/drivers/clk/spacemit/ccu-k3.c
@@ -29,15 +29,91 @@ static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
 	CCU_PLLA_RATE(3000000000UL, 0x0b3e2000, 0x00000000, 0xa0558c8c),
 };
 
+/* Keep the firmware default as the first entry. */
 static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
+	CCU_PLLA_RATE(2050000000UL, 0x0b2a2d55, 0x00005500, 0xa0558686),
+	CCU_PLLA_RATE(2100000000UL, 0x0b2b3000, 0x00000000, 0xa0558787),
+	CCU_PLLA_RATE(2150000000UL, 0x0b2c32aa, 0x0000ab00, 0xa0558787),
 	CCU_PLLA_RATE(2200000000UL, 0x0b2d3555, 0x00005500, 0xa0558787),
+	CCU_PLLA_RATE(2250000000UL, 0x0b2e3800, 0x00000000, 0xa0558888),
+	CCU_PLLA_RATE(2300000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0558888),
+	CCU_PLLA_RATE(2350000000UL, 0x0b303d55, 0x00005500, 0xa0558888),
+	CCU_PLLA_RATE(2400000000UL, 0x0b320000, 0x00000000, 0xa0558989),
 };
 
+/* Keep the firmware default as the first entry. */
 static const struct ccu_pll_rate_tbl pll4_rate_tbl[] = {
+	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
+	CCU_PLLA_RATE(2050000000UL, 0x0b2a2d55, 0x00005500, 0xa0558686),
+	CCU_PLLA_RATE(2100000000UL, 0x0b2b3000, 0x00000000, 0xa0558787),
+	CCU_PLLA_RATE(2150000000UL, 0x0b2c32aa, 0x0000ab00, 0xa0558787),
 	CCU_PLLA_RATE(2200000000UL, 0x0b2d3555, 0x00005500, 0xa0558787),
+	CCU_PLLA_RATE(2250000000UL, 0x0b2e3800, 0x00000000, 0xa0558888),
+	CCU_PLLA_RATE(2300000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0558888),
+	CCU_PLLA_RATE(2350000000UL, 0x0b303d55, 0x00005500, 0xa0558888),
+	CCU_PLLA_RATE(2400000000UL, 0x0b320000, 0x00000000, 0xa0558989),
 };
 
+/* Keep the firmware default as the first entry. */
 static const struct ccu_pll_rate_tbl pll5_rate_tbl[] = {
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 
@@ -49,7 +125,27 @@ static const struct ccu_pll_rate_tbl pll7_rate_tbl[] = {
 	CCU_PLLA_RATE(2800000000UL, 0x0b3a1555, 0x00005500, 0xa0558b8b),
 };
 
+/* Keep the firmware default as the first entry. */
 static const struct ccu_pll_rate_tbl pll8_rate_tbl[] = {
+	CCU_PLLA_RATE(1800000000UL, 0x0b4b0000, 0x00000000, 0xa0458585),
+	CCU_PLLA_RATE(1050000000UL, 0x0b2b3000, 0x00000000, 0xa0458080),
+	CCU_PLLA_RATE(1100000000UL, 0x0b2d3555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1150000000UL, 0x0b2f3aaa, 0x0000ab00, 0xa0458181),
+	CCU_PLLA_RATE(1200000000UL, 0x0b320000, 0x00000000, 0xa0458181),
+	CCU_PLLA_RATE(1250000000UL, 0x0b340555, 0x00005500, 0xa0458181),
+	CCU_PLLA_RATE(1300000000UL, 0x0b360aaa, 0x0000ab00, 0xa0458282),
+	CCU_PLLA_RATE(1350000000UL, 0x0b381000, 0x00000000, 0xa0458282),
+	CCU_PLLA_RATE(1400000000UL, 0x0b3a1555, 0x00005500, 0xa0458282),
+	CCU_PLLA_RATE(1450000000UL, 0x0b3c1aaa, 0x0000ab00, 0xa0458383),
+	CCU_PLLA_RATE(1500000000UL, 0x0b3e2000, 0x00000000, 0xa0458383),
+	CCU_PLLA_RATE(1550000000UL, 0x0b402555, 0x00005500, 0xa0458383),
+	CCU_PLLA_RATE(1600000000UL, 0x0b422aaa, 0x0000ab00, 0xa0458484),
+	CCU_PLLA_RATE(1650000000UL, 0x0b443000, 0x00000000, 0xa0458484),
+	CCU_PLLA_RATE(1700000000UL, 0x0b463555, 0x00005500, 0xa0458484),
+	CCU_PLLA_RATE(1750000000UL, 0x0b483aaa, 0x0000ab00, 0xa0458585),
+	CCU_PLLA_RATE(1850000000UL, 0x0b4d0555, 0x00005500, 0xa0458585),
+	CCU_PLLA_RATE(1900000000UL, 0x0b4f0aaa, 0x0000ab00, 0xa0458686),
+	CCU_PLLA_RATE(1950000000UL, 0x0b511000, 0x00000000, 0xa0458686),
 	CCU_PLLA_RATE(2000000000UL, 0x0b292aaa, 0x0000ab00, 0xa0558686),
 };
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260802-k3-pll5-pll8-1800mhz-c81875a0a944

Best regards,
--  
Troy Mitchell <troy.mitchell@linux.spacemit.com>

