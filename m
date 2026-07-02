Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326F40D590
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984344; cv=none; b=QuW4XZPgnmAdq33WqbMsco3FH+cK+lJ8h/P/4Bc5gUq+uZLotREfs4GA74ErVdMc6mfkgo2REmyG5lYSkGwFCYJabBh9+oH4wAPjQHnBOEH7lun67YZIHybKJD7H3tRsjjdICKfk64+TvC4e33nmKHZR9xGhl4gZYByM6WmNCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984344; c=relaxed/simple;
	bh=bxHfofVftas0nDT0dCU01gYtETbVotYMlAQeU6wjcUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZaVNqwTvbof+Y6lEEHhX9JgRlSxokkOc7g6bX4NbQZ9BoIkFMTj0pc5pryGbXgFFidlk5y+crt2GODxSYdqvHbkhZfd4y/LHrSacgdOdYJzmSKET0yzskqtYHr/Nv6cUuatYyc+g5Pcdu7aORREXSA5mTrCJ/lCExCymBge9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJuk5bHy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJuk5bHy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so10822185e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782984342; x=1783589142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAf0SbLKbze84BZy2kaqNnSUiZel7JKCETRGPOgpKO4=;
        b=bJuk5bHyE5LBKEJ5Ipm2l3dm/5blYLy1+GuT7HWgE2YcKUxIHjHItK2qjvjhuLpxnt
         jgnEGlQLuRINv6OjoKVHkDlCILn6xFkFKu53FKIkCFJeHmjijogbCA2iUeVQxvDlMHMT
         hjCSGNGI1PBiH9drt3QPbCpkkMLgfPL24aVmpuAMNxiz1tUmI22CnB4qnFhAK55xjuTJ
         0cAMDet9SsSwJ6oWTNpFenVrmxDWTnWJGv20ew0RGH6ZQe/yklEqw2/HfGSTg2uljOpt
         ygL5HjW/Eh89BWWnN2zYufZG+xnwEkfKi2dAFq0SW4NQ2EZNbfnrspFyxNLtjX4ahTJx
         oa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984342; x=1783589142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAf0SbLKbze84BZy2kaqNnSUiZel7JKCETRGPOgpKO4=;
        b=rD7OGV3FT/xrvGJaBfh7NNGxCbv2XXO1YMFm6CkRFYDz6g1YvYaAlRj4xNB80K62c6
         tACGwL+luo5Vw3EYjoiypsTmkUK5WS++RhEpc88mg+BJszS1625DgZ8GrE41pIET+Xmk
         JrkS59G/R9xchu3lPTGpMB5kA4tKoPsVE1FB2fYp14zCJUs8+AauIKChoassDQy1WXhw
         lVEIIzjSsoSpvkBpyLelc0Mf/9h0BNnPIdnkr9LMks2PIu5pVtsMy239VPkvldsyHV3l
         aFdhFcngIfWTx5Lqlfgue+7wCC95vkJCpkLySERfUvmYKjBXIxStNTUTLF6/47lQsPm2
         9vHA==
X-Forwarded-Encrypted: i=1; AFNElJ8Niv8ZrzaPxda7I9VG6B5/vCrk5U1Qwbon55j4aCc74YV+MX92Q+5DGSdTc3dswb2vboTeT1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgCPVqdT7m8X9M5UnXkHqUcL+eyCPtPGHFuaaAI+9z2CdmvVo
	BBXDJgD7gVRumXrcW7x0ANlsakjMFzq1eMulwUlDSfixRfg09TQ78PGk
X-Gm-Gg: AfdE7cmyGmhlzZrq7ONT0tYFWUpR00rfC5JwT57RASSroT1PNDjVTXSIwIR0dKHAq1a
	vHra/0E0A4RMXcDZ6pLzyXltmcT/5Zgstr6Ua12NZlLxBmwT2LgAa56btulnB3QqNzgnBf3TN65
	IhSQ0OApUTPKCtq34V4vVw4MmqcC1VcKD/iWYERNWFK9TgPjtz4NwQS0jo+TtIu8vaf/P6ABIFw
	eLCJP9cBG89TtJljP8RNiOGaXyUp+0rJMP6Uk/mRcdLD+jrar4bRumB8YJqAEVOUuLo13GXSsPT
	G8R7ch22rHNW10yKAHzwqxH7PBMM3pKZLyLwb8P54aEekkyE8o1RXYrGon7bAVvRx6RD2meOYtg
	qwvSbyyN7fo1xPg85zbQ+NuAF1rXJLS43UGa8WI9ohxl+P+TnwOQG1SbcjfAYi2dcp2E52Nw8+5
	1Xjbrmne6lO6MWBkz6q3ykvXOpypW66MWf92b6phnft4dO8AgxfmbhWEk/HNuiPfyGILHWZVTGg
	5QJk+8at+k=
X-Received: by 2002:a05:600c:154f:b0:493:bd4f:510 with SMTP id 5b1f17b1804b1-493c3cf45d2mr58466845e9.19.1782984341599;
        Thu, 02 Jul 2026 02:25:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm38312815e9.8.2026.07.02.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:25:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org
Cc: jacopo.mondi@ideasonboard.com,
	dan.scally@ideasonboard.com,
	mauro.chehab@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] media: mali-c55: Fix clock leak on reset deassert failure
Date: Thu,  2 Jul 2026 10:25:38 +0100
Message-ID: <20260702092538.335036-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__mali_c55_power_on() enables the clocks before deasserting the resets,
but bails out on a deassert failure without disabling them again. Both
callers treat a failed power-on as already cleaned up, so the clocks are
left enabled.

Disable them on the error path.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index ee4a42674..fb81141d1 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -699,6 +699,8 @@ static int __mali_c55_power_on(struct mali_c55 *mali_c55)
 					  mali_c55->resets);
 	if (ret) {
 		dev_err(mali_c55->dev, "failed to deassert resets\n");
+		clk_bulk_disable_unprepare(ARRAY_SIZE(mali_c55->clks),
+					   mali_c55->clks);
 		return ret;
 	}
 
-- 
2.53.0

