Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82A18A6DB;
	Fri, 28 Aug 2026 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886765; cv=none; b=Wo9OYpx8GJHG+M9YtMkxLbKfIXc5tlyPRx+PniZF/8g4HHYF1OsZM43lpp/FsU4X3j4MqWA5TZ2nVBq1kbmMvft2lTFJkmH5VDP80redNyLv2nB/T1x61ibkD3OPIm63+BFB+Ka9z0ZTKP+pwENnhC2MsS1VfGAl99JFugiBeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886765; c=relaxed/simple;
	bh=5WCAVng/l3b8WfWSj9bo6v9ee58+XeTdQWmGB/nWk8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lsf1j6Wk/k6BxuAPuxKuO6YXUWCOqBNKMqqlGp4Oka1IaVDNg/gp3FGqJKiy7G6EgJJU2flYLI8M062qH//6sEaZYtDuMqHhUdZwxVkhYxsCPn1Va3Ek/bBxs3zYCbkHwS5+IsfvgvLd/gLg6kRAOu8XnEiKSFgF6/JoVGi7kME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E4E1F000E9;
	Fri, 28 Aug 2026 03:12:41 +0000 (UTC)
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
	stable@vger.kernel.org,
	Hongliang Wang <wanghongliang@loongson.cn>
Subject: [PATCH V2 2/5] cpufreq: loongson3: Adjust the width of id and val in smc_message
Date: Fri, 28 Aug 2026 11:11:58 +0800
Message-ID: <20260828031201.1500767-3-chenhuacai@loongson.cn>
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

The id field of smc_message is usually stand for the CPU ID. In the past
this driver was only tested for desktop and laptop productions so 4-bits
are enough. But now we have servers that can have as many as 256 cores,
so we need 8-bits CPU ID.

On the other hand, the val field is usually stand for CPU frequency so
12-bits are enough to represent 4GHz, and for higher frequencies there
is an extra bit to extend (enough for 8GHz).

In theory, this is a incompatible change, but fortunately the old SMC
firmwares are not widely shipped and can be updated on the air, thus we
can safely adjust the widths.

Cc: stable@vger.kernel.org
Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/cpufreq/loongson3_cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 1e8715ea1b77..630f679aa739 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -21,9 +21,9 @@
 union smc_message {
 	u32 value;
 	struct {
-		u32 id		: 4;
+		u32 id		: 8;
 		u32 info	: 4;
-		u32 val		: 16;
+		u32 val		: 12;
 		u32 cmd		: 6;
 		u32 extra	: 1;
 		u32 complete	: 1;
-- 
2.52.0

