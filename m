Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313234;
	b=Jzh6UnzC3uWGPVqiBV4hILsE2NfqS5PwHbJ0SpOyRWL10x1l4apKpsFAC28Mi2tsXybp
	 YWC3oc3f0mKTXJ3UnK98Z9zk3UPoLllEPr7LntCo/IAasFDHyKHTU9LbcafJynBvSRLaD
	 6X30UvUSDINMtz8owuXsM7mDJC9YQfZFfH/jAxg2N8cla3a/yqlWo6NQ3v+W/yV50DdG6
	 fblNvrTG6LjcWImuLsEB9TK9VjyaeE+39HuDyxGP56KsKdQP/eaUUy2UqwduWIE8YRacU
	 cypqXKxW0nJ5OVsvbBx0YJNEBPf0l6BfJzKAAZp30WLUy7ofhEoUYVsQsbYPdmyQuhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313234;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WD0+ncX6K5jU/k1S3mzgCerlWlMiUUJMqxldm3QUDVM=;
	b=PwnWhBuae1+JwMI162PPCxp1qE+gdJAE2XnZb3Sg3PJEWnFn9DzlqnV4Yr9+iiYGjHNt
	 ShAa04T8Hb9bK1f8ghsVt67xLYuaM6YiRKURJN3XIf3usLN46H15VIipNZ0C+spaP5q9k
	 yNZvkWUY3noINhAiCQ2womdbyMBEotYlqdzVsnmmmJ/upR12DYS/8utWQBjPqDKQ6fHZA
	 d0qpO9amjBBT/mLtCC+Y+SToPpXrLF1hd7LcJVcIAosah3oG312MZpPNl9u+VHO+ZN3uX
	 l0/hkvTMrGLbyXleYOOhddVQ2LuQSHMp380BCUyeyvjhI5uHVvgT1UX3bfMVGgSgifw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn2gjMj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bn2gjMj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC341F008A1;
	Tue, 10 Nov 2026 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313234;
	bh=WD0+ncX6K5jU/k1S3mzgCerlWlMiUUJMqxldm3QUDVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bn2gjMj5oGwQmNWS2sLTgYtQxZ6fU1AqNv0KXWdJsd0awFwB+6YKR0G0zlA1KtoA7
	 RNnbFIKWpwwBBGnnqi0FKDIkVeZINqJVJEdfY4YijXaGFGzdrc78/bJ6zl8/y8D30q
	 1wVNDfLOP/OUIqzMMWKqw+1U2VJpPcZgKcISZ2XBJ+PGRUlROxVw6eN/aOX+qk3aTP
	 orxH6m24mlf5/FtY6XPhGeqb+zXNc7CF2CE47P85fbedFFTXurtczLNCm5iQFFykzn
	 KY3oYx49EXM2BjPxYdZ+gwzniawI1dDtA08RnkiwTAHxphKC8HyQTz5VKHdEby3ByW
	 ZlCILPjgPF/TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Dipen Patel <dipenp@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hte: tegra194-test: shut down timer before GPIO release
Date: Tue, 10 Nov 2026 07:20:32 -0500
Message-ID: <20261110122011.1092204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051646-failed-6.12-30167fadbf87@kernel.org>
References: <20261107051646-failed-6.12-30167fadbf87@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 30167fadbf87fa901a2fee49c30a5c5a506a43e8 ]

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
[ sashal: Adjusted the deleted call from timer_delete_sync() to del_timer_sync() to match the existing API name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index df631b5100d23..0bec696774c17 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -218,10 +218,10 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	del_timer_sync(&hte.timer);
 }
 
 static struct platform_driver tegra_hte_test_driver = {
-- 
2.53.0

