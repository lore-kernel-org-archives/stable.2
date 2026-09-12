Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA635201F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212876; cv=none; b=dTNZqCYrNLQphg4cLHptcb+X37/zCvrvUFDq/OchoL05gH/s7JIR5ncXZ+q6bi8G5SbesdpPOVxcR3r8sLZKtPLgUHWUeRqkySjOVjOVjJZCYyOurXUcuSWA0KoebIS/ZkjyfTL4pbLfoW1XIyhv5yHgiAfN6Mi4aMlgXaVOSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212876; c=relaxed/simple;
	bh=cC1YOs027YlAqZAqs9J6yM8CSZ469b20i+ByfNS783s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUEsqp3SuOwthpEH7kfOW7CFc8rbz+i0QL3eBomURd+k9aak0wkgKU+p3ZGrX6N4SYV004QtJvloL3NIQLR78x7K/yQ1y432kjcHxX4j0zo5OhCvfQ7+WEGIj1T2ZsDNY230JQpY3HyK+mESI5pZw/PHJ5sQBoPwghegvoAOnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO4U2jF+; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO4U2jF+"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so597141a91.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789212874; x=1789817674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AX3b+/Rd5JBxR9PSq0SxNQZUrSxVi/vmNM1MS2Zuudo=;
        b=dO4U2jF+uWlD0zxfHqXNtLWuweFU8mwlmiEsl4RAgvLMD72o9K25yAm/sUbCEr4JKu
         hG07vrMLF7lnBIb4dMfF+Ba3XHLPKkVZYLKphaOsih+VkEZJGPppu1/sbxoVrsCW9dPe
         uW40yukbc0JrPxBuL6oP8C3DRbTkv7PZs1dF7rqaJqIdBh9VpZq2kjVRzXcKYkgHAiGX
         pvVpajqzP2woWP683xa5j45OSQAhHOCRLNPgeB9bDAa0wpxWTy3FJw5V7oQjzeJfyjZ2
         P1POKPF737kdsKt9LFBzRZLLFOIenJI6lpxhWz0EHzC2czOhkmlcTqv1lVbqOETUyyzd
         lG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789212874; x=1789817674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AX3b+/Rd5JBxR9PSq0SxNQZUrSxVi/vmNM1MS2Zuudo=;
        b=hdPii/n2/BaFQ9wb8tYxvYf3XMWwC8WAAXaDIROSw4FYr3KOx6vjCmGhNsm5ppopbC
         DDIi0rpuQ0RmBRR0YeCT+6Ickw79Sh8hYs7cba+7b7ObjSfx4Y+C1PIUgNvheF9L/7u3
         e7VPaRO1fFZlPR4VcNMl9ld2JS7wSSxGydps/xHCFkWKEBfDRiMcov+osZCgYSlAT3Ai
         4871nhsd2QTfQzsYonTJRM/PmkB2+cx/jRnJVrhbxG2JYmi6DHQFP1L824HDN6R6WXJB
         fhHkj7U6TmgPFTMAlD9siOQ+SD2jm33Nyl/nDEfksxgLZMSmU6aJd7pmuDUvibM22VY1
         s7Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzZp3VGbEx78VyX4edBfg1y3l2pSVQkeuDFWQu/tfrRNvBMWzz3lKjNVWGJGGUb95p0bkFgJDo=@vger.kernel.org
X-Gm-Message-State: AFuF++k3Y5Op9sRfiAkw1X2AMeOivwA8bdLI1lfFzAoOj9uHho55cKyp
	rJ9Ea5eUQAfbMpZPcDew/bDzXLRJb5KOQp/o1D7ds8HodgD4hEZ/P90W
X-Gm-Gg: AYBFou10CKW/Ki8zOuXSqYe2vIAWlUsJ/jHRswLcWpqtlkz/G0PqcwHYeljY44amASm
	k7Pcmh9bEnmSZwBtgbAttcdlQpHBDzK3ycPVtbq/RlIOUtWHAIoG3UhVGEBYC6xECixF2iOwKOJ
	9X78d909bRyLzRVQ4TYRTY+0ZYaajqVrLw7QLhdvDPR2ibBNQKw0G/6Utgtgk5IUq8ruvYNIq5I
	sKaVRtD1LUyGa+A3CdMrdjmgCeuGNwuRLCUBcCuKF2y5Rls8vtW+iASSg8kUM06+fIonmNzFIUv
	5eO8Y4rgH2Dv5EpP7BMcTdqRvzonqWUgGEET1mJ2UnfjlReA52/1comuAelOxpI3dzX4WFJMm/A
	glckngFWm5zIcYeuiG49cjaoT1vCawbemgRakpCc+Q9tNwotfX2tlP6fSBSjrFqeSk9bgPH554k
	4ukBhCxK7q1ZF05m68SQvWO5yKaymbG7ozMXqfIagmPJqszEHW867U3A==
X-Received: by 2002:a17:90b:1dc9:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39d9c0b79efmr15378795a91.13.1789212874173;
        Sat, 12 Sep 2026 04:34:34 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95752809sm10046220a91.13.2026.09.12.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 04:34:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: SBS: Fix NULL pointer dereference on allocation failure
Date: Sat, 12 Sep 2026 19:33:55 +0800
Message-ID: <20260912113355.644238-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_sbs_probe() jumps to the common error path when kzalloc_obj()
fails, but platform_set_drvdata() is only called after the allocation
succeeds.

The error path calls acpi_sbs_remove(), which retrieves the unset
driver data and dereferences the resulting NULL pointer when locking
sbs->lock, causing a NULL pointer dereference.

Return -ENOMEM directly when the allocation fails, since no resources
have been initialized at that point and there is nothing to clean up.

This issue was found by manual code inspection.

Fixes: 9460eaae2ee42 ("ACPI: SBS: Convert the driver to a platform one")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/acpi/sbs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 86b7c7975852..4b84b3cd11e3 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -639,10 +639,8 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	sbs = kzalloc_obj(struct acpi_sbs);
-	if (!sbs) {
-		result = -ENOMEM;
-		goto end;
-	}
+	if (!sbs)
+		return -ENOMEM;
 
 	mutex_init(&sbs->lock);
 
-- 
2.43.0

