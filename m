Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82736074F;
	Mon,  3 Aug 2026 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751146; cv=none; b=RDeUw0f+24+zEqiGhbZXrOm1rRL0dOfILA4h1Wwch5S8z3M3vyF3KhnwRQMx/Ci3JuitwKrsLtmK51fR7f7CVtZYUQyEawwQ3qhxMf4eFKpgFttAHAdCv0TbuwXQVP3dzSO7q102Jf0GsIRMF+Fd3U53X8jINOfIyoODmBz7+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751146; c=relaxed/simple;
	bh=ij8qwM6falBiMraCi7v/dNAvK4O5CauB/ZyL8bwjjkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njjHpfYrOjORZjEYDWL7l+v+HFhVfYlfAcZnRY3fIT0jELuTHzChi9DFJ3t5pxmGwDhrGW2+sP/E1dRp80oDceZvj7SB5YlcTCBwlMWyKrVszQHfou+V5yOCFHwNdPwPCrmyyz4YGECCnzO4VvlsGy8eRRC9HB2NrqXHflXyzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EEqZvqv+; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EEqZvqv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785751115;
	bh=OLEVm8TO/1Scx1yAbnYVnfztcxCCRe2wZb3acAYk6Cs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EEqZvqv+KvXS1jomgmxl13HZawVIIQ89QuSJL2J/dah7IrMQ8l3wiyPntcQnNQZgt
	 kfGjpg7R9Urri/z1x/d8nwnLO+vzz9NMGISEYIBTnqAjgA+9xUoqmL7Ss1etWTGcRX
	 FayRdq/U2KkrSBlB2xlUsJjptMD0hO0o77wXskoU=
X-QQ-mid: esmtpgz12t1785751098t9c2b8f08
X-QQ-Originating-IP: 42Ut8n/sSo9F8XCAJB8UfWtryBHL2WLrAtIe3PcXGos=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 17:58:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11125041212163992465
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] zloop: round capacity up to a zone-size multiple
Date: Mon,  3 Aug 2026 17:58:10 +0800
Message-ID: <906CDA1B6AAAD5B8+20260803095810.3453016-1-raoxu@uniontech.com>
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
X-QQ-XMAILINFO: NxzhVD/1TxpMeUIaCeN7uDyfyaPNfcETCzhcOVE54SWV1JrIN6k2cpSZ
	1zUHZLhm6ub1/S3kFXXZt+Cg5Rulv796Jdkoqh8LOwPUSppoA21WaJONaBpNLXiDBONijpy
	pyVh09jS0Fl0IKEetwjGdf/BidfRRh08qz6GHDHAesxvu6h1cX+9tf3QSSC7kzCphDyG3Do
	y5cHMqhvf0jKu9VaxjNij20KmqMcNorMBTfBC/WIO47zRxoP0fsvbCmbJ5vys/ACScn0xEv
	y4Kky6LCzXlH3ZMIBk7R8Zv9tyVEbD6cp1QIIA8IwlQ2YfiKfMYy6i99A8C2L7KFyucHi30
	+NH/aVO9MA9C33eSNE0mgWACc9ZZHudim1PLbs+t2SJub8ZRaYoMcRb9lS6CEWWtumu4FOt
	gZMl1rrLPDs2pEvONDAxRZycLM909jNEZqMABXWvwSOyGsokBpyPXX/dkwcxVFHLhIqPJS8
	RSaC6eSP9+REqGPzCtTqLXzKrMXknWqY43f9dNZ+hug0jU4pMcnEipPY4FQxTLpkWm2dLhJ
	lBrfVI0viA3OvkJ9l+JEueOvt/Dh/1QnDcapPB0gsZlB1pd3/s1OeAWLT6Z69vc+jG0Lkm1
	Ung2cIX0Uvbiye4QzU8ZVp6y0JHweoy2BMtKq2jiucml8myOb45FkbhjzDfe4cM71GsnZ4X
	7K1g/WgqQTgml9Aut2P9ql9WCSI31nOt7CYkPU4oH8FrxhO3tANLIxAUW1pgwGVoHyHZOh5
	F6J2lmvVGpKZeafGbEXHYu5tkizuUptX9NTI05bk8DQ+F+VbLbmMeDucgU6Nmn6JeWW/OgP
	06cp767NXdAmZl6FwETsxRElzQQT9x1Euk8zkSYqhnjWF3uVzIhMPjyTnl+6zsHiS89R+M8
	UPvZDGHPUxVuSc3mCkwDv0dXmoANtL3U64GSqDBHGWak+Dvu/pF/03CiervmKCtV6SjSOSj
	0GUuAehXsFxKeYRuedE0RdXqYrdUkBU1t0FPG0U+u0cCAgxzwiObs+yQYzkadoQC87fEEqt
	D+3v7dYuEBqWZ8PvJxBbNRVE0RQCftQLWfTXaoXA8hwZBpI2K+vpMfwjFM2sx35wg7OkOWa
	FrD2a1vX5F9WrONguE7m5tHFYdYUEeUNw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

zloop_ctl_add() derives the number of zones by shifting the requested
capacity by ilog2(zone_size). Since zone_size is validated as a power of
two, this is equivalent to integer division and discards any remainder.
However, Documentation/admin-guide/blockdev/zoned_loop.rst specifies that
capacity_mb is always rounded up to the nearest higher multiple of the
zone size.

Only configurations whose requested capacity is not aligned to the zone
size are affected. Aligned configurations, including the defaults of
16384 MiB capacity and 256 MiB zones, keep the same geometry. An affected
device is also internally consistent and remains usable, but it is
smaller than requested. For example, capacity_mb=130 with
zone_size_mb=64 currently creates two zones and exposes 128 MiB instead
of the documented three zones and 192 MiB. Since this does not cause an
error or an I/O failure, and normal test configurations generally use an
integral number of zones, the discrepancy can remain unnoticed.

Calculate the number of zones with DIV_ROUND_UP_SECTOR_T() so a partial
final zone request is represented by one additional full zone. This
matches the documented control interface while preserving the existing
sector_t handling on both 32-bit and 64-bit architectures.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/block/zloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index b69d798f203c..e29d82ff52ae 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1187,7 +1187,7 @@ static int zloop_ctl_add(struct zloop_options *opts)

 	__module_get(THIS_MODULE);

-	nr_zones = opts->capacity >> ilog2(opts->zone_size);
+	nr_zones = DIV_ROUND_UP_SECTOR_T(opts->capacity, opts->zone_size);
 	if (opts->nr_conv_zones >= nr_zones) {
 		pr_err("Invalid number of conventional zones %u\n",
 		       opts->nr_conv_zones);
--
2.50.1

