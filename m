Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782D3A3E68
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113656; cv=none; b=MqS+9Hh1VYXOtaDTL8w5XorkGWXt0dkcqFwYqptcLycEoRjxd+Nx3aygjiqBMcKvjuavXCsKteGnYxBNgp2SE3RA03mI8I0eVpQ/02tU4v6j+mIZTNWZKaHEKkjdTXaWbufxOipiMbjceu/3DD/hiMx9em0GfS5jlUCUZWY9NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113656; c=relaxed/simple;
	bh=oI0oe6VrTB67fmNgGEWtYeo5Q1VrP79oiuVCB75VHIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB1ZYVPRmFm7gvTn6ETx/D8teOzZ6tT/zY33Q/D4+w32LdDUQkSUOoIn+C5gJSFKOhc/p75KMJfizrR2COhkLifE+xkrBdS7XgHmbfsf/r7AFd3xS0UOBOpVpyhXuJYp0iRCYgHSWxgUjuCNRd686i4LsOvGO1lX9VqlYhW1xR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7mJkZjd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7mJkZjd"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2969335a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113645; x=1786718445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LShjbJeEqOu9xhr0m6OP6Zlw5WppQjCW7XffJzXc/YM=;
        b=X7mJkZjdQFpfgvNH6bIAxBKFmj4utiRNfINNGRbt3eXpVJeNaN7BhS/CmoVPHD0/qF
         tE6+tRnqN+LA70+t7H/Cq2rFq5dBYENBmJykcFj2sy7jdNAagx3GZ81XS3l+3KFG0ioq
         AFbCJ8y57lYhf7/f5BUFmLlRLmJofZIq3e2MjxmjGjh4uOHv2rmbZqgjB1eXUwiYmal8
         iI1VhK0Kzqh/TLoJqowoRSgyj4cpajxso1+r+1sXdoBpJt8qvH5eS5s9JVkHm4vRefD6
         vY1NJ+A3IOkQShFvzEFzeOrkeEp//QT0KZIWb7ch2AlwpTwvDWdB1RFlhyfJxl92rCx6
         uZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113645; x=1786718445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LShjbJeEqOu9xhr0m6OP6Zlw5WppQjCW7XffJzXc/YM=;
        b=BC8kfxV2rMKa0b7pu+fpx/ioIiSz94fezzn0XgomorehiRmp+djuRCaGdqkXd/1diI
         zq2IsbFVHRXvrn4e0BbqcaG9VOK/Cj6JYFxw5LTkoyGfUteyD8aaS9DHOW3ahUmSUt9T
         IdrAQNOb/YmqABiUzixX3BcgY+bcaBVZHx5R7Rm/zFU2OZWwqRIVDGNfvEp6PjmIgydn
         YGRziRz6W0h0n4bpM/hdINU6QNMHmkZpscvdoyRelCqraeMIn7BHFhZg5HZNhgom6Rjz
         zH0/wWlkQDgEilEUhWX/LsYJYyC6GPaX2rt6gvigCo6SnBESl2HpV6cM/AUilALjsh45
         a/1g==
X-Forwarded-Encrypted: i=1; AHgh+RpI2rB8NRi7Haa0g+hjk6bvF29hs6+p0bMP0ki+5INz0zMAPkeab8iZ+BQXaU4z87/c52KOOCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMq+BgQAoAL0aHPIcN81fLZXLPfV5xGUvj//HbqCEHuFoFyd1p
	HxgSouj8OMl3hbN/67fXxj6+Im9PKdldZnxlDTwnWEnS1e7EeZukbmJbdnjkCNr5
X-Gm-Gg: AR+sD13JZCSoJRxAcjvXC+7hxpPLmCEu+FLXd3tOC6SumndFq5aZ+RTOWHgg/Zs9BFL
	pXtALgr8XFM4597rl/XbRNZkYHeYvmpWrY3lqrELFFiqipQirp9iriIVviCSDfxgHxHtw7rlNTN
	MjDX5mz3UU/h15IjJ2wE16AXLsboXnLrgmlVKWLUTZkOGr1NPHvTX8/h4Yccre5jt34t+rUzN0P
	M/MSQ1d6BcJS7pTla+INMP6ppmr0fzWK1gYcP7+azUigNpBRzJGYPcNu7dmUkX5fbCbX3d+vTA9
	mQglQ/KTb486zAUj/hEm2K2YOx5OM2oZEpbkNCKaw63/pau2EvO3Yj+iQxnrAj/BKILK8ptR22p
	1HV6/agc397QLjKVHvP6cIpqutjnA8mw/lDZcB7IiGfmANXcD0uFZcxcBgM7ZEqiOwdWoeWvXti
	GI2Bn1Qn3I/aBDTHTVVJI3X0nLeNxCGE50uftpFOfS+cwAUOyEEuHEFnpVQYtn6dIemxhxMU+wv
	j1grrYQZDa4Rb8f4NyeMqJV5uzGXbdEy2FXtC/A9P0oyjPTrdYCQA==
X-Received: by 2002:a17:90b:2e42:b0:382:1a6f:ba3b with SMTP id 98e67ed59e1d1-3909d7d2f85mr11461420a91.5.1786113644715;
        Fri, 07 Aug 2026 07:40:44 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24b91sm2917026a91.9.2026.08.07.07.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:40:44 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 2/2] platform/x86: ISST: Validate level in perf mask ioctls
Date: Fri,  7 Aug 2026 23:40:03 +0900
Message-ID: <20260807144003.3498972-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807144003.3498972-1-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isst_if_get_perf_level_mask() and isst_if_get_base_freq_mask() use the
user-provided level as an index into perf_levels[] via
_read_pp_level_info() and _read_bf_level_info(), but neither helper
validates it first.

The adjacent level-info helpers reject levels above max_level before
reading the same per-level register block. Add the same bounds checks to
the mask helpers, and reject disabled SST-PP levels in
isst_if_get_perf_level_mask() to match isst_if_get_perf_level_info().

This prevents out-of-bounds reads from the per-level offset table on
invalid ioctl input.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Fixes: 06a61df83209 ("platform/x86: ISST: Add SST-BF support via TPMI")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 .../platform/x86/intel/speed_select_if/isst_tpmi_core.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index b2965baeaa36..f1b6109521c5 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1263,6 +1263,12 @@ static int isst_if_get_perf_level_mask(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (cpumask.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(cpumask.level)))
+		return -EINVAL;
+
 	_read_pp_level_info("mask", mask, cpumask.level, SST_PP_INFO_2_OFFSET,
 			    SST_PP_RSLVD_CORE_MASK_START, SST_PP_RSLVD_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
@@ -1344,6 +1350,9 @@ static int isst_if_get_base_freq_mask(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (cpumask.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
 			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
 			    SST_MUL_FACTOR_NONE)
-- 
2.43.0

