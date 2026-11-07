Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048099;
	b=R6cUMf0k6YqRq1Pjo/eey38n2yYVvJK10olEoyjNR6EZn0JwyeB4oFckMDlM6g1/qMQU
	 BqHalW7MpzYrCZFI8p5Qc0IwXDskrGA+vBZfqmN2FNMHcUq/l7q88F/jwH652yZHYFhSr
	 Mk5iJ5bGj9av7ixa0FF+rfCsAQa/jXEtlDIJY90TpqI2VHjzinDXTMPpW7rmOWLTj2VAD
	 797vydUnylkYg6wWfP343uWQKr4iOmRxQEZPtmxA0/Rok60Lx5I75e5iKybgH6odtOTvx
	 iofHJ7pJdH2+ezDpujwtMU24quugcx4MQBP81uIhV2Y/22opdc6IBUuo105eQNq5oGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JkhtGw5FfYV77fSJilj6ECLYDiDEqRrskzSBvrUxZWY=;
	b=OiVduDMMcU9uNtxWT/OtwPQDHr/UBUiz7L+mEijMHAaEKril8HdKX6he06/gCax228PA
	 1iEhSl624h+nalIruxOg7Vj9Ub00w5ZqcVO8Db9CUBfRrraFPqBoFhzexTBCx238jGhYi
	 kWFANeFXaXGVa1uCgI4HkmNZcfTynxESpLDf5UyxDc5eZtB9JM8Hte3y8hDDWEiY8+mWM
	 dcvgKuDSNEh781m4QaiUT466Q3cqcJqzS9FpeqaI6IadAukepKEFUnSELZaZjuu3rKMFn
	 L1nPTk58XpgCOyt3DEFiHsCSGFXEU5S4ijGtFTHsKwWobFoNlm8P+ULKNA4oy/u7Etw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7x6j6UP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADB606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7x6j6UP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCDD1F0089F;
	Sat,  7 Nov 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048099;
	bh=JkhtGw5FfYV77fSJilj6ECLYDiDEqRrskzSBvrUxZWY=;
	h=From:To:Cc:Subject:Date;
	b=B7x6j6UPUZ3oiRadpoAyQibcdpYJpRTD2/YppzR+pztP1jJMlOHS/m9uZRgPOApX6
	 YKBZheLGdFpKlaY26LIVP0gJlKMZZYBaEvNzhVCs4CVMP8dyWCqA6Lk/rFiSIUbrQc
	 88lcrU3FUOIZQ2oV7EdbEy9feM/HffUAGDzY1AxzKYPJQ/fUL94MXyPWonYU4Je65A
	 I/GRuBnGJp3cmBekMJNwn4bvxA42ooq3+LLMd0Hu4IBsjOIK3AepUJy1+JI9gIYEK5
	 hi0ni8Ngel9Yw/bvQ9/MQwOuZbKzomAfGrRbzPzrgKRftY3vHEexubWpsLqnztk8fe
	 1rLiNtDxZtAJg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	dipenp@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hte: tegra194-test: shut down timer before GPIO release" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:37 -0500
Message-ID: <20261107054137-failed-6.1-30167fadbf87@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 30167fadbf87fa901a2fee49c30a5c5a506a43e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054137-failed-6.1-30167fadbf87@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30167fadbf87fa901a2fee49c30a5c5a506a43e8 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 4 Sep 2026 14:11:37 +0800
Subject: [PATCH] hte: tegra194-test: shut down timer before GPIO release

tegra_hte_test_remove() releases GPIO descriptors before stopping
hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
a callback concurrent with remove can use a released descriptor and rearm
after teardown.

Shut down the timer before releasing the GPIO descriptors.
timer_shutdown_sync() waits for a running callback and prevents it from
being rearmed.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 32907d951ec9a..cca33868fb03d 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -217,10 +217,10 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	timer_delete_sync(&hte.timer);
 }
 
 static struct platform_driver tegra_hte_test_driver = {
-- 
2.53.0




