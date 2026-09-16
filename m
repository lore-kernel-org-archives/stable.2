Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640E4BD34F;
	Wed, 16 Sep 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578471; cv=none; b=sC5gVehYpX2+ZsOR5YxNx1212wtzZjt7YSYxBaE3EyXgX7KaCuGxx0Cxv6kX3cOu7QO5mdWDn2w4drgZf/SKodd5NR0I1KZWFvFIkIZUjmxcyS83/gqh8IpuEhmmZDjhINTL0YZm2UyZMZM6a1e6fO1qfog66kG+kgSZqH2Khe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578471; c=relaxed/simple;
	bh=Al1K8wxz/zn0mqT1JKDJOTh/j2mNf/sitfv1OCJjQ5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=So77xQzlxeZJWbexQPbjSNg+3O7WqaYKx2Jlv8Mc+nM8OMOCJDYqI02eszZ/IL9KqsEx3wS83W/6XuDxW+M+PZDKM4uQZMWir3/zwX95kHZsR5NmnbIP3ELR84dDJwKGAApV+z+vc7lsiEgNQVEZaijxxuMityI0fbp3KfGtly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAz7UzKpqnENuCA--.22370S2;
	Thu, 17 Sep 2026 01:07:32 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: emil.renner.berthing@canonical.com
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	xingyu.wu@starfivetech.com,
	ziv.xu@starfivetech.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: starfive-wdt: Fix runtime PM leak in starfive_wdt_pm_start()
Date: Wed, 16 Sep 2026 17:07:04 +0000
Message-Id: <20260916170704.2086331-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAz7UzKpqnENuCA--.22370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr1DGFy3Ww17uFW7Xr15twb_yoW8JrWrpr
	4YvF1FyrW5Jw4xAwsxJ3ZrZFyrC397JrW7GFW8Kw1fZFn8K3Z8Xw4rCryYgFnrAFZ3J3Wj
	vFsFy3y8Ga1Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UgXocUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqpVhZ+gAAsR

starfive_wdt_pm_start() takes a runtime PM reference with
pm_runtime_get_sync(), which increments the usage counter even when it
fails, and returns the error without dropping it again.  The watchdog
core does not invoke the stop callback when start fails, so the
reference taken on the error path is leaked.

Use pm_runtime_resume_and_get() instead, which keeps the usage counter
balanced when the resume fails.

Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/watchdog/starfive-wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index af55adc4a3c6..5a3254c83d3b 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -371,7 +371,7 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
 static int starfive_wdt_pm_start(struct watchdog_device *wdd)
 {
 	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
-	int ret = pm_runtime_get_sync(wdd->parent);
+	int ret = pm_runtime_resume_and_get(wdd->parent);
 
 	if (ret < 0)
 		return ret;
-- 
2.34.1

