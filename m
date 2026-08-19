Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17633CEA8;
	Wed, 19 Aug 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148231; cv=none; b=s9CdDyfDU8qFffxJB3o2ri95F3pOHKjJIHPydcc8VGcmNEkV40LUe/hPh19z1FneMxzl0qFqBVA+S0ggg5bR/X2/VaSufwP7s6odEtCk+gWI9jq+oJiFa1jxSmYdLYQzOb6Y+OwFqKCE3fD+QJiSIqiok91HvatHozOMGRAHJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148231; c=relaxed/simple;
	bh=O4zVFv0h0AbnejAEIck23ijFfGICiboLN9/IOGuB8OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t98JpTF+gsUICJayThF6+x37h14yfu5tHIpQ2WzXf1hkqe048wEEddO+CQKxNZE9AwkjPOFFKstKh6lAjbNN98BnFIn3RriHgwNWN1hySeu5lX06uw/yLfMheBV2qFeZi2CFep2vamWJ5gANBoFbSMa6CIJ6wd/mwFnljHL94q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gIMQ6qd/; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gIMQ6qd/"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a93dedeb;
	Wed, 19 Aug 2026 22:03:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v4 0/2] mtd: spi-nor: core: Fix RWW wait locking
Date: Wed, 19 Aug 2026 22:03:35 +0800
Message-Id: <20260819140337.36775-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
References: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01a55c2a103a1kunm0db6d2d0140e23
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEhPVk1CGkxMGUkaTEoeT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gIMQ6qd/Ob7wmjOjFLStVHr5f/anG1TNz3ut/EaRzsEslpEX9d87r8wsnIObv4GaTg7zCN0wPYPdwX90qMLAXqpiHGpeNfrPf5DQQvWFa8bGvqbY6gIQOchXYR5ecK5P1njj1LoCKvO/FpqkU4fOvs9vxyKTNR3F5uEnh6fp3gY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=NAFliVJdCx2HCK/wB7WQHg3vR4GfL1qd0xIF3s5+vxE=;
	h=date:mime-version:subject:message-id:from;

The RWW wait helpers must not block while evaluating the wait
condition. In the current code, spi_nor_rww_start_exclusive() can leave
nor->lock held on a false return. Also, if a killable RWW wait is
interrupted after spi_nor_prep(), the controller setup must be undone.

Patch 1 switches the four RWW start helpers to conditional scoped mutex
guards so the wait condition never sleeps and the mutex is always
released before returning.
Patch 2 unprepares the controller on interrupted waits in the three
spi_nor_prep_and_lock() helpers.

Runyu Xiao (2):
  mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
  mtd: spi-nor: core: Unprepare after interrupted RWW wait

 drivers/mtd/spi-nor/core.c | 93 ++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 39 deletions(-)

base-commit: 2b533e775aec580cf60074417f4ca00ac9cf3580
-- 
2.34.1
