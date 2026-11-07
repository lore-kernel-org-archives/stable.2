Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046511;
	b=EHR6cpFFPy7Se6YrM9lOa+y1h8/bdaxDaHQnYeMTfChG6idJNHKe73ZaSsPZj4QpPuXU
	 1Q0iDS3eiLJN/eqCQ/N9i0KgLtrOM9qfDyDhCq2ks0vGeXzg+0Il7/+r/Y9nI8SVojByl
	 5n0eoll4sfjW5VBpCyENllvxrDjiFTQdDxPbaOzp89abmO05A4Un8nxdE1g+/HAHaReDd
	 7BXpY9E987CEuVR1WRO242L7uE9LKcWzD1KVUF84L2TSZK4YQjktOazBK+bUS/piqbRJv
	 khtkcsPEiWNTdyS+ds/CL7KBvOIbRBYd2AEJt9jj+OckCGnl3zpYFG0uRZikefvyQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046511;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hmwqsE1UWLrton768BTFebLe6mCm/M+rgGbUe9vqfmY=;
	b=AkF0mE0hJP3CoaVNJIh4EajCNr5IWK1WZK/7W+LL0avoxyAmxbH52zxFoXlgM++C/xSa
	 99tJbiuLq772OMBZ7DN0pD1FGMjCFuRn79RNlUVl0NphA/letTsc4MsCca59d7LdKO8Pz
	 /tcWsv1Sb8UAOGW9IZf9ria8v459hvhtWMK+dmMCyR0Lmo88lRm4juqnLZN91lG07S3ga
	 mxFoB7sD0+jSbWrVy0nIanpKsnw4D8lIWX7Muv7CV0zJUgJk3GuEFOwylij5HlecbE2kS
	 LZjrDZN6BXymRzRIX7G4ym9BVOs2XUrnUBgc3w+0YiP9Ti5DQgkaqxJjRSkkDh5o59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Exq+tH5Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F82606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Exq+tH5Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5621F0089F;
	Sat,  7 Nov 2026 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046510;
	bh=hmwqsE1UWLrton768BTFebLe6mCm/M+rgGbUe9vqfmY=;
	h=From:To:Cc:Subject:Date;
	b=Exq+tH5ZwDQIf5WFnPSFSsXyaIl88mOY9BXeuiZUqVfTdmEnS4z7vZsLS90H4alGk
	 SmUB1M20qLlbbIy4D6Yp6h4gB97a9Nv11rrQMigCWzL5aNcqjKjRwm+N1X/ph2daka
	 JQces/avXMqDcVTNwfmWy6oZ9XL4YsDGEaA/hv+Uf2fBYeXcVGUEN++uf3WgKUbZGE
	 KhGmPZSrqebU7QK7rTlf1M7D1x/45gPz7Yf/zx7zy4lBaOuf+ACdfrgkdWXr9yf3lZ
	 P+04nk+KtEHVwa3yumviIGm/MS4eDQB7JDD62NiqyOiOp5HR5Ddg3RLS0gcnezDfQn
	 QpKJlrZ2FtSEQ==
From: Sasha Levin <sashal@kernel.org>
To: miquel.raynal@bootlin.com,
	ychuang570808@gmail.com,
	jbrunet@baylibre.com,
	bmasney@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:09 -0500
Message-ID: <20261107051509-failed-6.18-1dc3871ce7ec@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1dc3871ce7ec819030c22297f8960c61cc42a990
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051509-failed-6.18-1dc3871ce7ec@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1dc3871ce7ec819030c22297f8960c61cc42a990 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 30 Sep 2026 19:24:51 +0200
Subject: [PATCH] clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks

The WDT and WWDT muxes list PCLK3/4096 and PCLK4/4096 among their
possible parents, but the driver never registers the corresponding
clocks, so these parents could never be used.

Add pclk3_div4096 and pclk4_div4096 as fixed factor children of pclk3
and pclk4 and expose them through the clock provider.

Reported-by: Jacky Huang <ychuang570808@gmail.com>
Closes: https://lore.kernel.org/linux-clk/b8a8a65b-e302-4747-bc90-4920fc48795a@gmail.com/
Suggested-by: Jacky Huang <ychuang570808@gmail.com>
Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-5-48937ee6c9bb@bootlin.com
[jbrunet@baylibre.com: removed stale link trailer]
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 6aa42a3e1be3b..c914079cee2d4 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -17,7 +17,7 @@
 static DEFINE_SPINLOCK(ma35d1_lock);
 
 #define PLL_MAX_NUM		5
-#define	MA35D1_CLK_COUNT	236
+#define	MA35D1_CLK_COUNT	238
 
 /* Clock Control Registers Offset */
 #define REG_CLK_PWRCTL		0x00
@@ -544,6 +544,8 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[HCLK3] = ma35d1_clk_fixed_factor(dev, "hclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK3] = ma35d1_clk_fixed_factor(dev, "pclk3", "sysclk1_mux", 1, 2);
 	hws[PCLK4] = ma35d1_clk_fixed_factor(dev, "pclk4", "sysclk1_mux", 1, 2);
+	hws[PCLK3_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk3_div4096", "pclk3", 1, 4096);
+	hws[PCLK4_DIV4096] = ma35d1_clk_fixed_factor(dev, "pclk4_div4096", "pclk4", 1, 4096);
 
 	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
 	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
-- 
2.53.0




