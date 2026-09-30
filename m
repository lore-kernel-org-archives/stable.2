Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671C4AF9D2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765638; cv=none; b=bxgqChK2kQ0hfb8ok1rS0DEbVY9WPhOt9sk80zP4CMLMo0qRPOUiUt2WXjnXWX7oYk/Nag0B/vYqOSC6+86GtmW/bazD2An9PSug1v/6QyGuLF3JuFzTtOrd0xRH7Y1SHOrNUmhr+t1mY142nGiqpi3dPqY5nmCqCwVRsgiIbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765638; c=relaxed/simple;
	bh=lb6gEf/21kZKV9cz1QriYTYSED2/a97q5K/C9CtoXSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnPVukwGsS++1fuIJEicF+GMXUBDqzXkCZSdV+61LweNrF+1R6gr2JP8n1swMgoHIwVGmJRMh2kTQ/KuDJlmm6p98ompi+lybWgYD3aQ59e9faRK6PUl0SNj1/MR4MiIL/SIkBnV9Iqv7lqB+Uhgs77MuKKCZ97tjy5rTPFHl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4h+mXXp; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4h+mXXp"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d7111700so231077a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790765624; x=1791370424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgJIB0bMoo4nkNRzK+zBMt7lqFO3N9sH9lPeSDZw+pw=;
        b=k4h+mXXpVNYQ/d2DntWMg4GDrZbGsyufzXP3/HTN52WVmM9M3EYRDi8sNgaWFi47G4
         d+gV9v9LTYIb7dmX0jvTEIG+lb5wSgmxzyN0Spa6FfxH6T9X241uZkU+bUtgA1S+vrdC
         UCncZU7ni4DorD6g4MUOzb0JpChYqSghxAMZssgDGJ8s933++Mz/DW15BWqyeklmdAWs
         yTrkh7pIzD0SS2ihAMyzklFriS6ZbxRCul4iBS8m8ygha6NOB4zxZO6robT7bHMMj4vw
         6fml3jF//iif8JaT2n8xKvQnDdna2I11QqBtnwoVoozN1l1Rx83Sj3K49/em5g0ge5Tt
         WA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765624; x=1791370424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgJIB0bMoo4nkNRzK+zBMt7lqFO3N9sH9lPeSDZw+pw=;
        b=CZj1sgfOAQEpeU9CTpgTsEXzeV6+hKXSuHs1KsGkeDspiaGl1MZwvdS0tBpx+2Yman
         VMCzh9Loq5avFwBxwlzFFK0maqfi/ujhXwH3b9mi/3+5Ojc8n6X9XLEFFWsCKl5Cquk/
         X9ahDzu3wHYU8gIBSNUtBitQW47wp0pat8Iejyw58Mu2jIUP7YYwvpKk9mxdt7YQ5GBV
         n2HLiCY42kT1C82X8LKKsBkb3yv6FzKia6L3bSZEL21NcHj+hE/QaOK+mE8ZFGDtzH7C
         +fmYBuY6OOinWDszc/dG9kmFeloSbn35TASKXOXtl23geuTWFrpWCocdSSOjwapsr8Yf
         yR5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpkbdLq6kpwIanyjkOvifPZb2EGFgwE9CAX+oJHX+SXICQHKHJEtneufvzDJbQYN8UZNA8poI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDVGXvR+ks/4rPtSiMWJU1x99v+rGY9ARhqRoV7hcFN9F7g3qg
	B+OjdiTZFrp9Rc4YeCmDRXMUghci/JPrzTOeOwTgHdDkgGZy0aAtqBtW
X-Gm-Gg: AYBFou0GffqKYBZmF4Nn5Hj1iSvVcJIxb3A8zFUBOPngdoDqI5/LDEhhrAJHfH0PpY1
	GwugVYXfvRLRejuZg27efyjX2mCexkaISgWpuwbdN1os6ebaM13rjY54FDdr3FoDUIe0Ooi5rG5
	zmghjvHfhdqjoxg7IqFOLxxI1FBT8Ln/6ghtfGHtK/Daa6kBTLYSybuKkG3kpRkuZVbBagVmYbc
	ayeIULQ+gD1vRI7EdTBKTvSd3Ahfiz2IXwLZAaastCnN3cyLrfM68F2Ue8Je03A2YfN5ajhQQBk
	GmsCCF18R36cxSXfItTyhxLHz7U55CMpywzDMSwZVd5XRAu/KK3+oa+G8AeZKHIvzLDgHzJS9cv
	fK+KH15fLyCvrncAInAy+5qHRPw6lgQOfKIeWzWW47/m02hTL1tZ8P2WUhBlQqRDSIxn5BryXdE
	rb6unFeQZNQAr0uNXWmzC3RvVqST8OPzqE5mCmDV73sndocNduQJdHbVQCdveC9wRkH8AlZdTjc
	SgEOw6oWlGbNSSxrXI=
X-Received: by 2002:a17:90b:2b44:b0:39d:b1bd:b384 with SMTP id 98e67ed59e1d1-3a4d1510453mr765358a91.17.1790765624466;
        Wed, 30 Sep 2026 03:53:44 -0700 (PDT)
Received: from cfarm424.jing.rocks (cfarm424.jing.rocks. [2600:3c18:e002:2e11::c424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c5972sm2799185a91.11.2026.09.30.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:53:44 -0700 (PDT)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>,
	Bhargav Raviprakash <bhargav.r@ltts.com>,
	Lee Jones <lee@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ridham Khurana <khurana.ridham222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4
Date: Wed, 30 Sep 2026 10:53:25 +0000
Message-ID: <20260930105333.3522412-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPS65224 BUCK2, BUCK3 and BUCK4 descriptors pass 4 as
n_linear_ranges, but tps65224_bucks_2_3_4_ranges[] only has two
entries, covering selectors 0x00-0x45.

The linear range helpers loop over n_linear_ranges entries, so any
lookup of a selector above 0x45 reads past the end of the array and
treats whatever follows it as two more ranges. This happens on the
normal registration path when the core checks the voltage constraints
against every selector. TPS652G1 uses the same descriptors and is
affected too.

Use ARRAY_SIZE() so the count always matches the table.

Fixes: 00c826525fba ("regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
---
Build-tested on arm64 with W=1. Not tested on hardware.

 drivers/regulator/tps6594-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index a54d88c58e7b..84974531822e 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -242,21 +242,21 @@ static const struct regulator_desc tps65224_buck_regs[] = {
 			  TPS65224_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_CTRL(1),
 			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
-			  4, 0, 0, NULL, 0, 0),
+			  ARRAY_SIZE(tps65224_bucks_2_3_4_ranges), 0, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK3", "buck3", TPS6594_BUCK_3,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_VOUT_1(2),
 			  TPS65224_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_CTRL(2),
 			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
-			  4, 0, 0, NULL, 0, 0),
+			  ARRAY_SIZE(tps65224_bucks_2_3_4_ranges), 0, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK4", "buck4", TPS6594_BUCK_4,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS65224_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_VOUT_1(3),
 			  TPS65224_MASK_BUCKS_VSET,
 			  TPS6594_REG_BUCKX_CTRL(3),
 			  TPS6594_BIT_BUCK_EN, 0, 0, tps65224_bucks_2_3_4_ranges,
-			  4, 0, 0, NULL, 0, 0),
+			  ARRAY_SIZE(tps65224_bucks_2_3_4_ranges), 0, 0, NULL, 0, 0),
 };
 
 static const struct tps6594_regulator_irq_type tps6594_buck1_irq_types[] = {
-- 
2.47.3

