Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9132B125
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179980; cv=none; b=oaEtxNJE34H9IQg/MZe87P7asOLwJW+Qjz3o8X7PhrTuDkhGNKzYn1b5AxcqaX29ZvVCJQEoLb3NG+nk93MO0GfjO3fzzaacYzEN8mcwVQNhgyitU3sGdIIeZtVl5Ep/eH7M1f4jSe7UQVPhp+o5Z0KPwcneIgrMiE3Tvx+efgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179980; c=relaxed/simple;
	bh=PaRaVv+Z9tIc8Sg76WdgsFP5rdDIoba5Wi4snLM2ebo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLlfe69oYSrq4uemcjoNdZSYZzcf/pHo5u/YMMDLjleFyr4gZJ85BNLKDtaUI/i9zRPIe+LlqObYtgvfLEYpdtNRZUtvZF3/2rWGtdW1EgkgmChj5qht5uikRxGYpIpkwa8PxY+qRpMjaTJntxghczqX8KVVQsLoeLNxtPSC/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBTy/bvs; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBTy/bvs"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cc46c7so112777885a.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790179976; x=1790784776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ptp1S6PEvwhlOiXeXKp9TFp5hhbpIwPkATNA+GKV8f0=;
        b=HBTy/bvsN6EDcuPKpkqkLnWOi7Kdc9ZZjhdyTBAwyWFzkKQcwe4c3YsMSdeu3L8FY4
         qCWeTjvzYemOdZk5EQQFTngHy9m9tYu5lrlpk+sjFGnZ9eM08YUyVuZrJmWOIu7rrDJe
         Xl7wRzQrKYUqmPM7hzYKRocV93AuZ4Kqp8poQJW4Mecem5tKxpkA00qGX6ayTOLZ+gjd
         0nz6vEJ+cD7jNKjQLEaxBo5kfEyCmqFiKF2Rs+zgnrqHY114htvauPokzzHx7n/ty1bI
         VF0Nfmig/6f7JQBkv2QEkJOuRTwMs22dLt81vm4NVIPquAydTZfzYWjB6jWL4RGzA29t
         q+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179976; x=1790784776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ptp1S6PEvwhlOiXeXKp9TFp5hhbpIwPkATNA+GKV8f0=;
        b=wCHJDbFDDMegh/f/VYOtpYL7DQgsZ8H5o1F2tir1qZSWdYEhOZCKHPzAzI3UANNs7S
         bhVhQUIaYk+OU5Fw16mXCP0l4ATPhgdbemh80SZWp0uNBMeg1y1elja0q5n0bNSPX9CJ
         ok3XRcpvTPOS+TM+d59sQoLaU2ysnKJxAol84rpHfG+OHh7iOYgHNAxCkkHMscAWLdrG
         uYH5aqQQG1ptbdQxM1TCWzAbVj1bj+UxvwwNQLefbsIx3zwoErLhFeiXW4HBZia5k8ts
         ZVtlOSE+bicMdB6u47n6M8A/82Ihr9cSRzNJjAzOk5ngcl88wfiXv4EGb5p6FFNMoDr1
         4NFQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9hFxhxN2z/P6EkNFPlo287qy3vc1ojY7zIXbYjnh7mxzwhcJD9notIEI1Cfg8B/in6Wufkzs=@vger.kernel.org
X-Gm-Message-State: AFuF++km00aSpLY7/FmZ41lnWQ835R69ckv1rStCTM+o6A+MuQBFu0Ak
	K0X9mxp6gjnOjXt79yD4bVAD4IFX7biyZ2WGrFKrWeFIMndDVL2kNr5M
X-Gm-Gg: AYBFou0hUH4WAbT7oBR/xbLInvONKHDzkPBnwOvRvLY3J81APVp6fJk5bmEJCeyKLe/
	Oevi9m7u/De4/3MhgfhVjTpb1MkwWNUecfv/oWG9VDsWHhnUPNJpxg8ERNDJlj7Tt5Q/zbxWfVk
	s+INkjgsE+jL00pBybF4oVo5JLT6I+UfxySQKsg4P6gzXa1pog5rurS2r8hGlEw9nzdJCn3sPxg
	FgfslOuPnG+ZXCV3YK1WgYMnJJ/gOHfSaCMba8qyH6PtpHmMeFM/j4GS1LIvR5ottR0Wk+Asrya
	YAHP3VnPUqslAsz8IyI/aBrM9b1LXLdmYCzp49dz2tOMXlF7W5ZrPkf5pKlRi+cH/UShv2ckm5X
	TKBvswSN0t02pqHzArVGRKlK+usRA+cdKCvf4ZXgMTgX8oYgifEJWcH/CgxbbAffBDNzPCqGALx
	tzBiaiJAi3x+kkhA/gLi5o8OA2x7v8/CIe6tnqoNGA9gpuN7W3GZcWqxmOyaYk9eE9V+Y9Dmbtd
	CrzdWkPzswoiUq0x05tDzqn2m3MDn9zPA==
X-Received: by 2002:a05:620a:370d:b0:93b:d7a0:d9db with SMTP id af79cd13be357-93c2520e6a4mr500584785a.53.1790179975757;
        Wed, 23 Sep 2026 09:12:55 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248223dbsm259134385a.10.2026.09.23.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:12:55 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] ARM: socfpga: Fix OF node refcount leaks in sysmgr init
Date: Wed, 23 Sep 2026 12:12:37 -0400
Message-ID: <20260923161248.586695-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

socfpga_sysmgr_init() looks up the sys manager, reset manager, and
SDR controller nodes with of_find_compatible_node(). The returned node
references are used to read properties and map registers, but none of
them are released before np is reused or the function returns.

Drop each reference after the corresponding mapping attempt. The MMIO
mappings do not depend on keeping the device node references held.

Fixes: 9c4566a117a6 ("ARM: socfpga: Enable SMP for socfpga")
Fixes: 44fd8c7d4005 ("ARM: socfpga: support suspend to ram")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 arch/arm/mach-socfpga/socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 4332af2d8b862..663765280d0c9 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -34,12 +34,15 @@ static void __init socfpga_sysmgr_init(void)
 	sync_cache_w(&socfpga_cpu1start_addr);
 
 	sys_manager_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
 	rst_manager_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
 	sdr_ctl_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 }
 
 static void __init socfpga_init_irq(void)

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

