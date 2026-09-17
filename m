Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC951FCD5;
	Thu, 17 Sep 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653708; cv=none; b=CDVKmpkv1lAHzN4nXYUp4+W4KwMBtZ5A/3kUfyJmbn/86ybmcri1tk4RI5ugZllFOvFWP8W74Shdt+c7xrmGsGNgPMggvO14OodB7wMSiS+WGljShomj9rFkxTOle8E5oKisXP1mQTqhMZS2R7z0yHSK6+/lEUKt97Y1rW5W84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653708; c=relaxed/simple;
	bh=v6+x40zMq95VSAnlvbv/3gE7FC6GwK92Tt/b2Un7SW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zou6AQjU2Bj9GlDwchywg1ETM7ha9nlhMTEryrSBdeKLp8jn2dUErmDNmXwyuiYgcri0ozqmslzRkt1YrKVhjZ6Ibs9bc6kky15uS3MSckPaiGZBPzBVVxARAG1dO4/6sdVMCYV7n1W7x/6JvCImTxb7eoDmIeQ4Lj5qIf20Z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oz3E8qtqIv2BCA--.4222S2;
	Thu, 17 Sep 2026 22:01:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Shyam-sundar.S-k@amd.com
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: Fix power supply leak in amd_pmf_get_battery_prop()
Date: Thu, 17 Sep 2026 14:01:40 +0000
Message-Id: <20260917140140.2154244-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oz3E8qtqIv2BCA--.4222S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr17JF4kJrWkJr1xWF4xCrg_yoWDtFg_Gr
	y8Cas7Jry0qF4qyr1DtrsIkF97ta4DWrWvqFsrtFZxtFy5Aw1kXr90yrZ8XwnrC3yUCFyD
	Wa1DC3y7ua4fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1mLvtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qrq3bazwAAsD

power_supply_get_by_name() takes a reference that is only dropped on
the error path of power_supply_get_property(). Drop it as soon as the
property has been read and stop searching, so that a successful lookup
does not leak the reference.

Fixes: f4627dfd0e19 ("platform/x86/amd/pmf: Add support to get inputs from other subsystems")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/x86/amd/pmf/spc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index f48678a23cc7..cd957d7a4e48 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -249,10 +249,11 @@ static int amd_pmf_get_battery_prop(enum power_supply_property prop)
 			continue;
 
 		ret = power_supply_get_property(psy, prop, &value);
-		if (ret) {
-			power_supply_put(psy);
+		power_supply_put(psy);
+		if (ret)
 			return ret;
-		}
+
+		break;
 	}
 
 	return value.intval;
-- 
2.34.1

