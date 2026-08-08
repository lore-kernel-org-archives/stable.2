Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7435CB8C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176153; cv=none; b=YW0MI4l6AKmCg0FNlys50ecndQWmxJ9hh6E5YZ1FV5f9qKTMnMSJzzOUZYdPvF3JaroxRNJnWcmZ0sD++Iijkwf37cgO+HlhtZWWJHPaNvXsV/K3ex5i2Lg7v/3WbVmSPqOSTfQFa8Sr+85zwkSGmOKEXJovJR4DHGxXKOA45YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176153; c=relaxed/simple;
	bh=Qtiy299hgXH9miMRATmDtFVX36AP62Lyow4p85Fjtoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUcI6Gf88H8cN3Zi6wKruOORe89LlZgsMP8wEtuJc2o8wYaF3eGM+F9K3AoCziXx3DS8QudeWdowFsHF4QYMuEpboaZOt4HJLi7Slb95/KqGz3mB7BvYEC2NV/jK7QCwIxzmawKtj8JRHyz4haLNVxdlX6dK/am/UCyo1HNoxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNPg3EaY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNPg3EaY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39266382df6so313525a91.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176152; x=1786780952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLmbCLzuywYLsOVyyYkrBNI0Jw0ZVFv5psG5aDAHyEg=;
        b=JNPg3EaYpemhj5aP4kfgqpmVEISAlaurH7WdqXRKhxVvFnqDGkKzu0yK1gGEpRU0Qj
         wh0UkCLyDpBgdYs0qhnSIes7fNAZg5yJ2XeEc3aNgg3GdhpHvnwsSokZB9w1YSXPFwdU
         o4+JYc97JZ0w10ekv8zjZ8q4EEO/Jpx4QvrHwE2UChjl8SMfzyiKlMNkQTAtlXZZU7DV
         naE2yQkAlLVDDFqUf0OIIqTzMrCZFOTV5zH7/hSR4fZh+8OYbJls4dUAUti/iwrRNiGD
         FPB1dxq3IoFzDvhKo35+Rh0FVHAJRqbRLi0pJlW5pm3AEwvBY/eLJp/VhZZENxprywOF
         jdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176152; x=1786780952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLmbCLzuywYLsOVyyYkrBNI0Jw0ZVFv5psG5aDAHyEg=;
        b=lAaHMXwVOTrXnL/QPBt/AQEWHixITwm2co8mhgPtFdrkvbcTZlx1DEA6RX4lM/4XPn
         syY6IBuqAp3gLJo3YC14bAdVezxo+xZC7M4p5XJcNvWT1C78rmVzGwzL367U3op2R8G/
         2CzBjW9is/vAYR+ifOZ3/AITfYB176dUcFeRbcQIrP1QTs3z+c8s0XRn9kIC3MYeeHSQ
         +X+lrDj8qI7buFSBwxknNUSdLVEk5XHE++a8KqZTaVn0pz4KgoIjBKxlTxE3D8N7WoZx
         fROctAA6bu5V/oYVhDfIVmbVbSkTBqzRhdRkRvink6QcpAKcQzgKFzvQTqbo5pM1OfR1
         jFsw==
X-Forwarded-Encrypted: i=1; AHgh+RpgnSgxTyA7YVCJKSDMUMamS4wnTHAkJMmhzfsjZemc+xWpMA99P8d5F2tZclkj5s4UHWFV5bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWGrt/Uprp5ZgdmQPd5yRKgQM5tR2M4UAWLTUsVK/BOa069Ng
	FTJv0lVnq3fzy9uSThobpbavQSblZAuebKknvGIESW6E39+XwGyw2DUm
X-Gm-Gg: AR+sD11tTP0+wjqWAEmH2WRGNTmXZer3aUdXylg5sn74ctHUJR5foKru9X+7bV0Kd51
	uCCfGLsro+fWok6mgHiJ0YcMD4owwkXiSOsWoqsNPQC95xL9uinDAw1cYwkU8JjD3E953kD5v1c
	8ZPYwWMgAkWwRNmE9pPCde4PmAXFksVvFi9E+5hTQCZdhLUhVXVax0Ah9M/o81Bg0Qvk5FX+OwQ
	BIWb9ZZQeQLUBnoBZdsYq01MypJw3doNO/F5GEbRI6GIHksHBvIn2cDxtgoyA6SPSncCJvY5Dks
	S6ESeJqZ5qaFlO+GhiXYfeqFeP7LdQTl4tcxJr+FODmBRyOsCZyZcyuv7IolndkmIa/60J2XGda
	P0RFQvc4M44+i1WiX+BKrQMQjalQO+JO7Bvx1T+gCKEi1YdyRC4XOUS9WomeY7EO/iCYpjGBglh
	vzVruPuKlz7tKQGUPKfBDtQJ2fK3kiRFqvtzqZjwPq8PmP/fCNpi8DkeI5oArsrWfGWFumXxqYS
	bdBOK93
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3903c599356mr29221904a91.2.1786176151990;
        Sat, 08 Aug 2026 01:02:31 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm7774143a91.6.2026.08.08.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:02:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: imx: imx8qxp-lpcg: fix runtime PM cleanup on error path
Date: Sat,  8 Aug 2026 16:02:15 +0800
Message-ID: <20260808080215.2669452-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_lpcg_parse_clks_from_dt() takes a runtime PM usage reference with
pm_runtime_get_noresume() and enables autosuspend with
pm_runtime_use_autosuspend(). The success path drops the usage
reference with pm_runtime_put_autosuspend(), but the error path only
disables runtime PM.

As a result, the reference taken by pm_runtime_get_noresume() remains
unbalanced on registration failure. The autosuspend setting is also
left enabled instead of being undone with
pm_runtime_dont_use_autosuspend().

Add pm_runtime_dont_use_autosuspend() to undo the autosuspend setting
and pm_runtime_put_noidle() to drop the usage reference on the error
path.

This issue was found by manual code inspection.

Fixes: 18cdbad40c6c ("clk: imx: clk-imx8qxp-lpcg: add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 1dae3410ee99..262645bef62d 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -277,8 +277,9 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 		if (clk_hws[idx])
 			imx_clk_lpcg_scu_unregister(clk_hws[idx]);
 	}
-
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return ret;
 }
-- 
2.43.0

