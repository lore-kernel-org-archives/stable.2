Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965836D513
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688011; cv=none; b=ONtcf7gkHhGZ0u6T8FmEagS2Cx9cQeczl58JCpbHN2NNQOXZHSYIIlJ0F6xiEbEiEbv/JeRG8bYAi3od7Gy0Mtmfzu+pcT45F82ai/Nid3nsMDVOlg/VIOuz1yj3fszNpREBg6Zojw6A+6XThcacpnNvmL8YuF7JoQi9idDbDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688011; c=relaxed/simple;
	bh=GUDsSnSpwDj2maWrAQsgu4r9TY3KspdS34xPLDZRLOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6AJixwunAtqDKN7nOpeO/U/atz80q/f9at5LXkXCvW5LBEAisN5+9NuejCukdZe/TJUJW44i+C2hJr9j8Z/c9I8ebiWdQ6gB02x/4tB86f/gnY9VdFqUc1c404A3hAfZpZP9aNxai56RIKeqlnCZ99yemsmnvrrBuS+ToevF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6W1Ttq0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6W1Ttq0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1559998f8f.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780688008; x=1781292808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEZDD9TlhQlFNvL79/mxsSDb2Yxob9rJ9xhLRrOMmv4=;
        b=C6W1Ttq05nG+qQnnIcTeTbtZrhKDkeMUXA2Dt9RmJX13SUFGKTA47fwJWTYDAboB1P
         L8TVwJaDcC0qReK2Ov5eY16J/gLVIyjI5zVmrSchsC+EP404R29zEQYGsSfQiod5dz/G
         GLFhcOvEosAUhW6sS8JqUFyH/rtw+qQXS8yrkQxDUDJpWrBgHplDTxF9R0by9wR551+U
         wtIAziGtAUqjUg7BhRvng9LHc3ljFTIxkD7BoZ/iL9ynPpsIC+8Y2V08Iin8Nkbmr3J1
         TOVbTquAsV8HmByCYSU3FyTDWqopecm3re3ASpriuzFz6ZmR0MhpD8JyPR9aRjL5NB6z
         +Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688008; x=1781292808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEZDD9TlhQlFNvL79/mxsSDb2Yxob9rJ9xhLRrOMmv4=;
        b=a/nHlpd+asnqsvL/pIYEKpNGRXEkoo8l+DKUd2VJaidrUqXu/k3FSs7qTGUaa9Vhd3
         HBsrpiNQ+atbIjDsX2okPzUK8WdFJhURoSLCVZMApSgYP99QGxl5E7Y+M6xU6OpZC0jm
         HUHsottQTK5GVOHrQMfpiRYjOnZs03ZWhOGhuH265aFmPduXKQ5MnsOYd4q6el1Bl0w0
         gOCwbDxOD7kFbkqLNBY2ueuBFH1pph9aXjiSmuH7yjgFnOMOtvscCEokC+xolnCP5FXE
         RsvEt/gWsVuy4nfSVW3b0GttcAFdIXDc2pmGDIcJes32BavZksuYUYnY4S5W+uru6JqM
         uIzA==
X-Forwarded-Encrypted: i=1; AFNElJ9nAdtRBaJbFZSaqzvKkygV3pO/vxFGfDw1MEJzirkX48Iy+yFDfr67blsvCOK9xY2zbcCZOGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4nECurj1caEwCzAj1G82ljTJKUvsDZTvNVEsF5H0rB8QFZzb
	9tQzlrGr3LyCN1QFNakDQZyVoZNuFvaJskG8Y9aIYhUlP9+NBFuV1s+y
X-Gm-Gg: Acq92OGzrnb9dYMJpQm+tU0jS3jujxUF2ko1q6qKbgfQFBnE/gOZOl3H9eq8hDN9kwF
	G/hu/LYu0jn6+TnrivaTbuJ4c02K73dK9xkaxkHvCg2LbRKSsri7lI/4cCdLoJi1SxLJma7jJcB
	lKxzlbp7Sc8PNZFBBJfJotvgXjwxWB2xSrojEaQkcfe2YWoYci3eA7fu0JGFn82ersteo9BRGDq
	Du443ihGMw39Y1ImQ82Z743ewK2rsDDNxjXVoY70gtnL7jHBLK8zf4VEFmWyfo/eBD661l5UjYG
	yIVKmtbMioslCfSyUz2fnTskPoarnXuhevpeVLaaooz0otv1datdwZWnpQERv3BK1p2pyiLZ7Nh
	3cKEE+ATULY5BAXn8WEgRh0f4X8xwADDOGKh3Dvi3EftolA21ZoU8DQiZJsqQbPAxJtV29SJJil
	V2t+BymDmkTiKn2AEJNOr7HzG4duRZ7ZiZ0HZecNbKCMz8yzaFzBgjosH7DilqW+BWaaPw/YcnR
	aBkY4SUcx1h
X-Received: by 2002:adf:e68f:0:b0:45f:f142:d55d with SMTP id ffacd0b85a97d-460307761e2mr6539957f8f.39.1780688007512;
        Fri, 05 Jun 2026 12:33:27 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm28025464f8f.17.2026.06.05.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:33:27 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: include secondary weight/scale extents in region_size[] accounting
Date: Sat,  6 Jun 2026 00:33:11 +0500
Message-ID: <20260605193311.48008-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calc_sizes() updates region_size[] with the extent of weight[0] and
scale[0] within their hardware regions, but omits weight[1..3] and
scale[1]. Since no NPU_SET_WEIGHT1_REGION, NPU_SET_WEIGHT2_REGION,
NPU_SET_WEIGHT3_REGION, or NPU_SET_SCALE1_REGION commands exist in the
command set, secondary buffers implicitly share the same hardware region
as weight[0] and scale[0] respectively.

The omission means region_size[] reflects only the primary buffer extent.
If a secondary weight or scale buffer extends beyond the primary one,
region_size[] may underestimate the required GEM buffer size.

Fix by extending the region_size[] update in calc_sizes() to cover
weight[1..3] and scale[1], skipping entries that still hold the
U64_MAX/U32_MAX sentinel values written by cmd_state_init().

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 7994e7073..152733b6a 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -271,6 +271,8 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	if (weight) {
+		int i;
+
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
@@ -280,6 +282,14 @@ static int calc_sizes(struct drm_device *ddev,
 		info->region_size[st->weight[0].region] =
 			max(info->region_size[st->weight[0].region],
 			    st->weight[0].base + st->weight[0].length);
+		for (i = 1; i < ARRAY_SIZE(st->weight); i++) {
+			if (st->weight[i].base == U64_MAX ||
+			    st->weight[i].length == U32_MAX)
+				continue;
+			info->region_size[st->weight[0].region] =
+				max(info->region_size[st->weight[0].region],
+				    st->weight[i].base + st->weight[i].length);
+		}
 	}
 
 	if (scale) {
@@ -292,6 +302,11 @@ static int calc_sizes(struct drm_device *ddev,
 		info->region_size[st->scale[0].region] =
 			max(info->region_size[st->scale[0].region],
 			    st->scale[0].base + st->scale[0].length);
+		if (st->scale[1].base != U64_MAX &&
+		    st->scale[1].length != U32_MAX)
+			info->region_size[st->scale[0].region] =
+				max(info->region_size[st->scale[0].region],
+				    st->scale[1].base + st->scale[1].length);
 	}
 
 	len = feat_matrix_length(info, &st->ofm, st->ofm.width,
-- 
2.54.0

