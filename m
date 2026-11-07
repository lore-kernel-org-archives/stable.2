Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047338;
	b=Go6NjyVjd/FRbJ6yP7wqrSgWl7LCjKEf9IZNBJJ8Y5EXkOoY3bbq6iHrZaGoa6Z26CeN
	 d7QqGqGpGcVf0HvR/oJI4AU1nz+MGzr4WHr2+3V4a0AM8WZOl2ewIsuhsr1XJ0tt1Iz7C
	 UX0ZpRlRY+1mP9s60EGtZw7jl50iYQLCwGK6wa4+iyEtpVZP1Lv9A3i9B3EURZVp262Lo
	 i7mfIFVbuyk5orGhiR+a3BrJWBK/4V1sPJGro6ABuKx9PjwPdr+QESWphFq9tixHv7uI8
	 6EpE/w8sK6z6DPtPPumbENXm/a4KuYFJ7dobOzMPgATKn99mGxyTdGUKqeUdkZX3smA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z4mVCKbz8mYKQe0Dd9/VVvAnOL6GfYwSj6FuvJHtMn8=;
	b=qIg+v+QSh6U+PJjDtGcN1ZS/XBHhKPejs8IlM7MCUiFc02eC3HgNJlTap1CShz1FU0mc
	 Bws9eIcXzTGTYRljzWUf/jVv0iFw5RqbtGXZNC3OD4cKa5PCjy3JGYoPggWBAc+fwbIpM
	 Y1MZ71YZMf/NwfB8skT1NnZNcZFt91UCGIegh8YWp9yrEDGWyKZPO1zVYphlzX9/mapUe
	 NZAXnTVu+NbiHXTI8bhjoHMoLyb7/6qH6Sr2Zd2xR3XraFRDoxzc4CTaasLvlVt7vEeLd
	 tFwyURncuUZ2a858MYet+Y7DWUZXIzbuqEeT5G7idGQjkeGDnasWfdXrm5+vslgH5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccSfy4Zv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccSfy4Zv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1A41F0089F;
	Sat,  7 Nov 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047337;
	bh=Z4mVCKbz8mYKQe0Dd9/VVvAnOL6GfYwSj6FuvJHtMn8=;
	h=From:To:Cc:Subject:Date;
	b=ccSfy4ZvW8DYJP6VO14K3WSMiCd7JVuYmfWP5W1r2zDxFbTGQFL+iewfx+9MpKSDf
	 TGLg9mgHnyklCcVBjej73iQVAiOa0pyC9VK2BYlokte3oIQ+/u+305Tx9qZejCjIeR
	 ifHJOsNhU64jvx8LlsVX90ltgwRLMuhYSpsY0Sp/NwtXUtB0luxp6+vUTwvYOdNknV
	 fiVS1/nlX9Ke6mZMJVuXdqKYnC9Qva1VznzOPEsVzMyldJya729zWT+Dxa4BKfXKEL
	 n/NC0h/82JkVvZq//FsMjRqnlmWYvDKUsyUY+Nx9uANR19dEKNuwqKCRJMFUh1WntI
	 ceOLLK9PHAAwQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	dipenp@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hte: tegra194-test: shut down timer before GPIO release" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:56 -0500
Message-ID: <20261107052856-failed-6.6-30167fadbf87@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 30167fadbf87fa901a2fee49c30a5c5a506a43e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052856-failed-6.6-30167fadbf87@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




