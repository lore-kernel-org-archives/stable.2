Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3057F74A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965906; cv=none; b=ZKy5LF65NU8/DwbLRHKCl8emquHmzXnaXpBgJCXrNnKC+n0tC1V/r/VVF0lxbAHZ24NdidSKgY8+yTb6gtGa4GC9gk9euatdkg1q/Z5iPwB2OIvEpHGvxgsDnRCHsFjeTpHiYMNc7YJMJCm3aJo2IqWcC7CcYxRaXWWTP4WptVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965906; c=relaxed/simple;
	bh=VPF9UpmfIeVclmsW6NF3Dj1Yj1AmMR7oVJ6gBbVErLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQKOQi63JKMXhExUFY5RRzyp2bTv4yldeD2tM/JpycLb1M96cNj1MjUEj0B8ZfLjuGd84TxXpbvxu2MlsqGxMegj7fJUEjOBQnY6J/YY8jLIn4DtccP4WVUM0/eVtoJKf8s0KUK4wzogwPLANtWYXS8Oh7KT0A/g9NjDOatSuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaqYXZHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaqYXZHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3630B1F00A3A;
	Wed,  9 Sep 2026 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965904;
	bh=mcld7x6CFK/4lM5oLYji/4NI3zByecQf8te4Fzv6ikQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iaqYXZHlqToIL1niYfDsVWzwOtNOQgkB1MhEwgQEEO/8Wyq9Fe1ODBA1D3KLmjfwL
	 7Z48Hh59c/OC7xNpB3ih/kKC7KF7QS6dYCQJkH6stoy7xLlBtaTfPgRnwLLDOg23CB
	 MxMQK7B1tCKHlQIFi0dhoJcgvPZcNUWT0rOFJfT8lkS8Ns9OjxKV3v47ymemsS+4vP
	 CNDem/jKJIrDRHXWMqI9G6fGKyfmDDd+p7EntQ31lMqlem0kh6lZ1A1XTiQ54RqM2N
	 GTgey3B8UdZrEAvsLgwd723+0Gm7zT41Mxy1vn5AbTT6qMmVL6kfKQqAL7cqMh2/IU
	 PNvitEA+kzYpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/7] platform/x86: ISST: Ignore minor version change
Date: Wed,  9 Sep 2026 10:58:16 -0400
Message-ID: <20260909145822.2742457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-boxcar-confused-152e@gregkh>
References: <2026090339-boxcar-confused-152e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 07510a59b316445311775ee53adf10448140607a ]

The hardware definition of every TPMI feature contains a major and minor
version. When there is a change in the MMIO offset or change in the
definition of a field, hardware will change major version. For addition
of new fields without modifying existing MMIO offsets or fields, only the
minor version is changed.

Driver is developed to support SST functionality for a major and minor
version. If the hardware changes major version, since offsets and
definitions are changed, driver cannot continue to provide SST interface
to users. Driver can still function with a minor version change as it will
just miss the new functionality added by the hardware. The current
implementation doesn't ignore any version change.

If there is mismatch with the minor version, continue with an information
log message. If there is mismatch with the major version, log error and
exit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20231003184916.1860084-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: f9a647cb8d90 ("platform/x86: ISST: Return error during profile addition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..292a7cfa55759 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -30,7 +30,8 @@
 #include "isst_if_common.h"
 
 /* Supported SST hardware version by this driver */
-#define ISST_HEADER_VERSION		1
+#define ISST_MAJOR_VERSION	0
+#define ISST_MINOR_VERSION	1
 
 /*
  * Used to indicate if value read from MMIO needs to get multiplied
@@ -352,12 +353,19 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	pd_info->sst_header.cp_offset *= 8;
 	pd_info->sst_header.pp_offset *= 8;
 
-	if (pd_info->sst_header.interface_version != ISST_HEADER_VERSION) {
-		dev_err(&auxdev->dev, "SST: Unsupported version:%x\n",
-			pd_info->sst_header.interface_version);
+	if (pd_info->sst_header.interface_version == TPMI_VERSION_INVALID)
+		return -ENODEV;
+
+	if (TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version) != ISST_MAJOR_VERSION) {
+		dev_err(&auxdev->dev, "SST: Unsupported major version:%lx\n",
+			TPMI_MAJOR_VERSION(pd_info->sst_header.interface_version));
 		return -ENODEV;
 	}
 
+	if (TPMI_MINOR_VERSION(pd_info->sst_header.interface_version) != ISST_MINOR_VERSION)
+		dev_info(&auxdev->dev, "SST: Ignore: Unsupported minor version:%lx\n",
+			 TPMI_MINOR_VERSION(pd_info->sst_header.interface_version));
+
 	/* Read SST CP Header */
 	*((u64 *)&pd_info->cp_header) = readq(pd_info->sst_base + pd_info->sst_header.cp_offset);
 
-- 
2.53.0

