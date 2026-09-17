Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964254B1A6;
	Thu, 17 Sep 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653542; cv=none; b=jiGEVnuvS8LvhhfyQlJkXXciHQafUYcfa1H05Rld4hYB5XbRoDwKeIzRjiVBdQki5K1R+V7lL4EEdO/q+iMcJGTS6NqEt8VjTtptSpqGYVL4xlaLZCDvkSp+5a2kpLiiferMLSpf+tqqxEkJv9DqhseeO/XuU1xm11MoVcRT8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653542; c=relaxed/simple;
	bh=lt19VDx6OjWlVsDiVS9Nq1y04nPILBk/11beoOyItJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IXNgHeWAR3y4cLDpb4OqRLoqQ+MY49/JEW5Yo/Z9rGEepxi4wusBvPzHtJgrLJ8kyacBq6u13WC67IJVrEzmwQxt9pYpEf8rTPlEqM38YQJxYlpOUsXf2fl2KaEGln6UMvC/w4zjGtSqau5dzmabT5EzZ55S4e5mf/GR5o1utXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAz4e8qtqTPGBCA--.4133S2;
	Thu, 17 Sep 2026 21:58:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Shyam-sundar.S-k@amd.com
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Fix RTC device leak in amd_pmc_verify_czn_rtc()
Date: Thu, 17 Sep 2026 13:58:54 +0000
Message-Id: <20260917135854.2154187-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAz4e8qtqTPGBCA--.4133S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW3AF48Ary3KF48JF1xGrg_yoW8Aw1Upa
	yUXFyfCrn8CrW7tFy7t3Wku3W5ZF1IyFWUCw45Aw1xZ3Z8XFn8JFyFyw4YqF48ArW8Gr1a
	qFs5tFs8WFZ8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UMq2NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qrq03ZpQAAsJ

rtc_class_open() takes a reference to the RTC device, but all paths
that return after it succeeded, apart from the final one where the
alarm is programmed, leave the function without dropping it. Route
them through a common exit that calls rtc_class_close().

Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/x86/amd/pmc/pmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index cae3fcafd4d7..f40e8d9b124a 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -569,32 +569,39 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 		return 0;
 	rc = rtc_read_alarm(rtc_device, &alarm);
 	if (rc)
-		return rc;
+		goto out;
 	if (!alarm.enabled) {
 		dev_dbg(pdev->dev, "alarm not enabled\n");
-		return 0;
+		rc = 0;
+		goto out;
 	}
 	rc = rtc_read_time(rtc_device, &tm);
 	if (rc)
-		return rc;
+		goto out;
 	then = rtc_tm_to_time64(&alarm.time);
 	now = rtc_tm_to_time64(&tm);
 	duration = then-now;
 
 	/* in the past */
-	if (then < now)
-		return 0;
+	if (then < now) {
+		rc = 0;
+		goto out;
+	}
 
 	/* will be stored in upper 16 bits of s0i3 hint argument,
 	 * so timer wakeup from s0i3 is limited to ~18 hours or less
 	 */
-	if (duration <= 4 || duration > U16_MAX)
-		return -EINVAL;
+	if (duration <= 4 || duration > U16_MAX) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	*arg |= (duration << 16);
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
 	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
 
+out:
+	rtc_class_close(rtc_device);
 	return rc;
 }
 
-- 
2.34.1

