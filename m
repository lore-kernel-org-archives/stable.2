Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FD46D2CE;
	Tue, 18 Aug 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056842; cv=none; b=cSEYztO1bHMw1vrwpqvztfuO6oSn1dRhB82HHgIaYkIgo0wIA60Q+x7tH/NaJFFjdiikRay6Td8wfsvq9kyyamHTKK0GJOCKIRjH391g9UTTLHKGRPC93Hyrdz4bAoTQRDa/DupRa9chCjql1A2A2UMAfX4P+BxKLHzTDqI9uOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056842; c=relaxed/simple;
	bh=mtrZow1VnKLVFHIgnWe6y2Y6xQFKTwWZPCkJXsA9Av4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guZ499zYq5Z//V2jZiBlC07KjQHBbGCI/RTYjs90noGTlpe4nQ+d2L5304OvmEplyC+mxLy+9Kr8vja8+OzOccqiySYoLe2ZO6pdv1LkNh8s/6EsR86enoXpnLEC2HpWmcuFqdphaEt6/r4lfJ3WSVNnkNlAo3bETfpRhVB7kFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617701F000E9;
	Tue, 18 Aug 2026 12:40:29 +0000 (UTC)
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
Subject: [PATCH 1/5] cpufreq: loongson3: Make this drvier depend on MACH_LOONGSON64
Date: Tue, 18 Aug 2026 20:39:17 +0800
Message-ID: <20260818123921.3600606-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818123921.3600606-1-chenhuacai@loongson.cn>
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

32BIT Loongson machines don't have SMC and FreqCtrl registers, so make
this drvier depend on MACH_LOONGSON64.

Cc: stable@vger.kernel.org
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

