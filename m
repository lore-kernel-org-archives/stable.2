Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43218A6DB;
	Fri, 28 Aug 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886755; cv=none; b=XPXHDHxPAWsddr0eDIPdT3NL3Pv60ZxbyHIPZyoKqBTj2scy3jra3JGS/lnhDHw61Giah0qgnWt7wr7C04qfGY7ooFTRvmjVkUHMZL+/DB8sCAIaL+AlUmfcLmve0GaTA0stcb6tSJ5SdrHeE8ghvh87TFNK9gTjKAm55btVCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886755; c=relaxed/simple;
	bh=F6J6hOMqJ02khF6DLq0baIBkwyZyXoOa8H3w+2q4oKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTn9bXDgySAFomETuU99fRBB6OLPFgNAuGVAfwJCQZIGU4SH8bhOxPPsSTJhSMCm5pvpFx0TCBIUidyIdxMwygr2aXqTiyHWRFsFIWBgW9uX5LPI89AXnKi5s0Q5pEOKV3C0KOaxIRzfl7qADfcgS+RgfYpZidtUhiI6shSHF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F99E1F000E9;
	Fri, 28 Aug 2026 03:12:31 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH V2 1/5] cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
Date: Fri, 28 Aug 2026 11:11:57 +0800
Message-ID: <20260828031201.1500767-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828031201.1500767-1-chenhuacai@loongson.cn>
References: <20260828031201.1500767-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

32BIT Loongson machines don't have SMC and FreqCtrl registers, so make
this driver depend on MACH_LOONGSON64 (only for LoongArch based 64bit
machines currently).

Cc: stable@vger.kernel.org
Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index db83f3365698..edc1299098d4 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -288,6 +288,7 @@ endif
 if LOONGARCH
 config LOONGSON3_CPUFREQ
 	tristate "Loongson3 CPUFreq Driver"
+	depends on MACH_LOONGSON64
 	help
 	  This option adds a CPUFreq driver for Loongson processors which
 	  support software configurable cpu frequency.
-- 
2.52.0

