Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8342F1FE4;
	Sat, 19 Sep 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835482; cv=none; b=lmnwXbBZgSlM5XyvIZ4xSttu55bIpMkGe7PFA1Jelln7OVngpl4JKRX/Jb3CcVWbHN0v8n65C+ZgLkm0nSFTnWrLt1shJGLdIz8cHqByn0RUJICS/aOZ+UI96ta1CCBhTbLS/hP2stRzzE4NdV7A4WrUeXqy2UlJP2J7VqA8uoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835482; c=relaxed/simple;
	bh=QEydRVe7szFnjbjMs68m3tM6OpM7LpIPSA3ouOsDKNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGeuVSqfq5JeIkfFnKRd39IW1i5GqZxe6nw6t8y0SgJVPdXRHFW0+mTBTIdWW0Ou3+XWGu2tr65Am2OlleXhcq57rMJam1ETjQqpuB7VS0mIfYIFhwflccd7oJLEdh6WOlZ7U51PXZ1p3nG41kM5nFNN8QL1b3MiGnCiHMWQ46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=H6nHROhR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="H6nHROhR"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e612fa0e;
	Sun, 20 Sep 2026 00:31:09 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] clk: rockchip: Unregister notifier on multi-PLL registration failure
Date: Sun, 20 Sep 2026 00:31:06 +0800
Message-Id: <20260919163106.1833104-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ba81e1be03a1kunm005bdd813f1226
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUJIVkwYSR5DSx4ZHkMeSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=H6nHROhRofFAqw6rSvIplm54SpLReIPjjZj3lPrj21YcJeIITjbW9yxWmgHWlFTnMvPaVnVM9228CCZp8gR5vRqSYIO0dCQty1I8FwdZcEj9TX8t9ZrH2g5iE1mW/mry9q9XXdMYVkON3lMgZrRx0U0MHiTVjO3zu5F7CrRNXAc=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=JMEurOe9ZHBP9Lzs52oCdL3QD0lTBynnDeFDQ6wWGQc=;
	h=date:mime-version:subject:message-id:from;

rockchip_clk_register_cpuclk_multi_pll() registers an embedded notifier
block before duplicating the rate table. If that allocation fails, the
error path frees the notifier owner and unregisters the watched composite
clock without removing the notifier.

The common clock framework retains both pointers in its global notifier
state. A later rate change walks that state in __clk_notify() and reads the
freed watched struct clk before it can compare the clock core. The notifier
chain also retains the notifier block embedded in the freed cpuclk.

Unregister the notifier before freeing either object. This mirrors the
rollback already used by the adjacent rockchip_clk_register_cpuclk()
helper for its equivalent post-registration rate-table allocation failure.

With controlled allocation failure injection, a later rate change produced
two KASAN use-after-free reports in __clk_notify() in each of three runs.
The same three runs completed without a kernel diagnostic with this change.

Fixes: 826eaa8f5bac ("clk: rockchip: Implement rockchip_clk_register_armclk_multi_pll()")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/clk/rockchip/clk-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index eb6b8b878..2de7f2b4f 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -544,6 +544,7 @@ struct clk *rockchip_clk_register_cpuclk_multi_pll(const char *name,
 					     GFP_KERNEL);
 		if (!cpuclk->rate_table) {
 			ret = -ENOMEM;
+			clk_notifier_unregister(hw->clk, &cpuclk->clk_nb);
 			goto free_cpuclk;
 		}
 	}

base-commit: 04721208427536c0f70db0efc5362c7f5a4997c9
-- 
2.39.5

