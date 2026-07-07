Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3143DC850
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455721; cv=none; b=B8WOUtWD7pM6kntRpKmBqw6vAt8J9nkzfuiIINKUqTD8cfRgBT/jAZUfeq6B6dCzRdUXcJGQ/EDjS75jDvI9TfigM8aYPWX5DnMvXrEFpl9CLpVTKxstHkywaPMRp1SwwEhxsBR9K7oTyNjyu5UEdJ+1KF0tErBT4q87ZZ3GO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455721; c=relaxed/simple;
	bh=4NG8zneOYe7p0UrTp9P9R7HnMyKE7GyM9DN8ppk6JVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdZvYLegXZfLWr4bC99d2MV+WbWv2NpqlQdwAfWcLZmBIfNBLfec36wSIr5O4V3kfTeaSwlg6Oje2CfX7SxaFNEYTjmK7kZAVRL4OjDCpD6F7lYIfe/fK1TaN77vNqVVaiaXWEtP20VPJ4YNfP48BF1kRdH5y0hv9zQZEm2UoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3tSpu/d; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3tSpu/d"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so8395491a12.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455717; x=1784060517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=O3tSpu/dmCaGYJzcRxizKfmzqm1qgD4qnzUV+LvLMVUrblgcvmpVwU8Y4yhU21+qoG
         R0JKauEfvnPUItA8t2v8pSMr9q9mthuk+bSnFBoLjSRNKmDtva3btAT6Sw7VtHRUypI6
         da4yJ6RWwbSj8PcYjpO02c5WtjUAOFwgp8P0RJLlOrEWcQMrwQ3wjZTcUCFTQiYVEjEa
         eQacrUVGVVS6JfjEnMOUhZ7krHQtMlyGpFSei11dM/w7SEUBctFuMKt8eACFVQkdGl3K
         HYFq2OONlwpsCu+hPYanKPWoECXVEdnUYqWjpih86yoRxVGrcNx2Z9l7urp21eFWFG2/
         WsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455717; x=1784060517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=Kh8Hil3NllaqF2MLzdvV3T8obUtg4A+yOwaOQ+1xbjg7eRQNcDJZW3vPt9G0tIRrim
         GinWRet63np6BII+lofy/ku3dzxbnsAtsVc+j8Pl/4bmRjPXQwhg42p/QlRmfJGj9Uhz
         SpAQ5/qVS/mb217+eIzd3oQ0RARibvOLkZiwwCYKkHhn/0T1YFY6y3M1/ZafeD2IMaqw
         ct/XBhxS49iMr045wrApeJrFq+YzvMxoUTCzj3uvoIwsdOPGuCsLXsZOPgwloe5akXla
         5ytBu/+i013kBWG+SdPwhLKCH5XvRk1QlprIPq0InKUO5kj8fAjbHoqdhuTXiq6KwrrV
         DiXg==
X-Forwarded-Encrypted: i=1; AHgh+RpNaeiTes93eqsScd6Q6Qx81nToyKeCIAX44UR3QncQXt5Xok9v9WK3zbDix/Hx73AEnZCQQvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZL4ITQn6JVGcF4qN1O4FL+r5E3xHvhlrh4tgDUXSlyhsO2u22
	mZcGapH8K67sb70suQ9O1cvFgcx3wT+LNDNETOOfzbLYa0eaudeqZRcU
X-Gm-Gg: AfdE7cnMaCTRjxHrmQmmefJsGW+9qBKyZND8gL04JvucChUZe/ScsWIPa3cMiNpT4v7
	ZQ7H6IBYMwtDYgBIA0ryPKn9edcDn0yfx/pprT9k9Uj4hg0MiKj4XDlC+fLT1d3lspqd91Chv70
	kl+GMRN9YKKteBYNktUKwfMRLcE6wCbj6p/oEre0U+fwEN6dwigxs44C/VREsVZTyTYJFa3Xu7k
	lT8CCDSyD2PF3IWcUcBGkOumnJ8KJqBL5E+svUnezSydMdKWJI3PFVmgUw7leW2wiJsVOd2U5RJ
	jgnPdtGhzkNXnwYFvvynIsnynNmHDVskvpuRFKXeW+UCyztZ5L+ASm3jXSv+hB/jAe2dblT5gqR
	wyDmoeJtVxk2OduVlCUMrYGwJWLLMsVjrgq24Wbmx6oha/AwywRJ6g5IBeplhRWJpUhj9gELY0X
	n9MPib35Zn3JLH2p2Avkc/U2yV2W9WjXWj3MoNrgjQDVlowbev84R43aKgNPdjMGY=
X-Received: by 2002:a05:6402:5514:b0:698:b25b:8df with SMTP id 4fb4d7f45d1cf-69a85bf392fmr3470762a12.21.1783455716979;
        Tue, 07 Jul 2026 13:21:56 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm637930a12.0.2026.07.07.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:21:56 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	superm1@kernel.org,
	W_Armin@gmx.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 3/4] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
Date: Wed,  8 Jul 2026 01:21:10 +0500
Message-ID: <20260707202111.35414-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707202111.35414-1-meatuni001@gmail.com>
References: <20260707202111.35414-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
contains fewer elements than the type-specific expected count (e.g. 11
elements instead of 13 for INTEGER or ENUMERATION attributes). This
causes the entire hp_bioscfg driver to skip attribute enumeration on
older HP hardware whose BIOS returns shortened packages when optional
fields like prerequisites or possible values are absent.

Observed on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31):

  hp_bioscfg: ACPI-package does not have enough elements: 11 < 13

The element layout has two tiers:
  - Elements 0-9 (SECURITY_LEVEL+1 = 10): common to all attribute types
  - Elements 10-N: type-specific (bounds, values, encodings, ...)

The per-type populate functions (hp_populate_*_elements_from_package)
already handle sparse packages correctly via their own elem < count
loop guards and inner-loop bounds checks. The only unsafe case is when
we lack even the common elements needed to register the attribute.

Fix by introducing COMMON_ELEM_CNT to mark the hard minimum (10), and
splitting the check into two tiers:
  - Fewer than COMMON_ELEM_CNT elements: hard fail, can't proceed.
  - Fewer than expected type-specific elements: warn, but let the
    populate function parse what is available.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 11 ++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 768330d291da8..78019644ec358 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -661,12 +661,17 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
 	int ret = 0;
 
 	/* Take action appropriate to each ACPI TYPE */
-	if (obj->package.count < min_elements) {
-		pr_err("ACPI-package does not have enough elements: %d < %d\n",
-		       obj->package.count, min_elements);
+	if (obj->package.count < COMMON_ELEM_CNT) {
+		pr_err("ACPI-package is missing common elements: %d < %d\n",
+		       obj->package.count, COMMON_ELEM_CNT);
 		goto pack_attr_exit;
 	}
 
+	if (obj->package.count < min_elements) {
+		pr_warn("ACPI-package has fewer elements than expected: %d < %d, parsing available elements\n",
+			obj->package.count, min_elements);
+	}
+
 	elements = obj->package.elements;
 
 	/* sanity checking */
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 416d7e7aaaae3..ac57d6eab4c35 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -279,6 +279,9 @@ enum hp_wmi_data_elements {
 	PSWD_ENCODINGS = 13,
 	PSWD_IS_SET = 14,
 	PSWD_ELEM_CNT = 15,
+
+	/* Minimum elements shared by all attribute types (NAME..SECURITY_LEVEL) */
+	COMMON_ELEM_CNT = SECURITY_LEVEL + 1,
 };
 
 #define GET_INSTANCE_ID(type)						\
-- 
2.55.0

