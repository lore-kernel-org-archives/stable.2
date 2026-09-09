Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B93DB645
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948133; cv=none; b=A1ocDPmiMOr1qClvgmIq5RZWPQlBn87c7weyP2aBXj4JFtUgIJiWV9C6U2EkORwJXjeLYK70UuuENWNYCGto0rsnvf4Xm3vv2gLpboThE1CjM77hYpJDnENJhP19kK1A2DTbSyxO91RvRKz8Tc5Nr8fQu+0ooJ8y+NsEyeCh8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948133; c=relaxed/simple;
	bh=Qs55mwAivDFMaJdmr08g8lScsh7dWiFsCIyddXYYj8E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o9Hof0XZSLTutz0g5vmVutd68XyJEKlPFqPw0fiYyA37rAywKWy+aGi3sc2vCV8p8qcwSw9eWoaouoBA+wiXcmTmVkdQa6C4xj0pEjx7RINTyu86TQL+AxBf0T4ouZa191afFYSs1qup2PJi5m3oKKUO8z5rA7V4/od90G0Gz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZ5np//G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZ5np//G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8557D1F00A3A;
	Wed,  9 Sep 2026 10:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948132;
	bh=i5Lgz8aj+qd3clGQuE1HdZEornpwWNPS62d039A3vUw=;
	h=Subject:To:Cc:From:Date;
	b=HZ5np//GdxpkMVZaX5MEfCku0XIaVcaRKvWg+CLUitKSmxj2jE9zUpmZ0DVP0c61e
	 GAihDlJ86z/389UGOGLMDCKdgWTMJme0jbZ67eASQiQeTbAQ4ofrhBt5uJGkr0IYm0
	 uQfmHfKY7ykaVzJXMV0AS+bbumyC5DIpwOAr7X8c=
Subject: FAILED: patch "[PATCH] clk: meson: align gxbb_32k_clk_sel number of parents with" failed to apply to 5.15-stable tree
To: martin.blumenstingl@googlemail.com,christianshewitt@gmail.com,jbrunet@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:58:30 +0200
Message-ID: <2026090930-unguided-jam-8517@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 628b6fee9fca292f12d07f0f1bcf1edefa949d81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-unguided-jam-8517@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 628b6fee9fca292f12d07f0f1bcf1edefa949d81 Mon Sep 17 00:00:00 2001
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 23 Jun 2026 22:19:56 +0200
Subject: [PATCH] clk: meson: align gxbb_32k_clk_sel number of parents with
 actual count

The following out-of-bounds read has been observed by Christian on a
GXBB WeTek Hub:
==================================================================
BUG: KASAN: global-out-of-bounds in __clk_register+0x1b70/0x2418
Read of size 8 at addr ffffd66320cf88e0 by task swapper/0/1

CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc5 #1 PREEMPT
Hardware name: WeTek Hub (DT)
Call trace:
 show_stack+0x14/0x20 (C)
 dump_stack_lvl+0x74/0x94
 print_report+0x164/0x4b0
 kasan_report+0x98/0xd8
 __asan_report_load8_noabort+0x1c/0x24
 __clk_register+0x1b70/0x2418
 devm_clk_hw_register+0x74/0x15c
 meson_clkc_init+0xd4/0x20c
 meson_clkc_syscon_probe+0x5c/0x94
 platform_probe+0xbc/0x17c
 really_probe+0x184/0x844
 __driver_probe_device+0x154/0x35c
 driver_probe_device+0x60/0x188
 __driver_attach+0x168/0x4a0
 bus_for_each_dev+0xec/0x180
 driver_attach+0x38/0x58
 bus_add_driver+0x238/0x4c0
 driver_register+0x150/0x388
 __platform_driver_register+0x54/0x7c
 gxbb_clkc_driver_init+0x18/0x20
 do_one_initcall+0xb8/0x340
 kernel_init_freeable+0x49c/0x52c
 kernel_init+0x24/0x148
 ret_from_fork+0x10/0x20

The buggy address belongs to the variable:
 gxbb_32k_clk_parents+0x60/0x400

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:

Memory state around the buggy address:
 ffffd66320cf8780: 00 00 00 00 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffd66320cf8800: 00 04 f9 f9 f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9
>ffffd66320cf8880: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
                                                       ^
 ffffd66320cf8900: 00 01 f9 f9 f9 f9 f9 f9 00 06 f9 f9 f9 f9 f9 f9
 ffffd66320cf8980: 00 00 02 f9 f9 f9 f9 f9 00 00 02 f9 f9 f9 f9 f9
==================================================================

Commit 7915d7d5407c ("clk: amlogic: gxbb: drop non existing 32k clock
parent") dropped a non-existing clock parent from the gxbb_32k_clk_sel
mux but didn't adjust the hard-coded num_parents field. Fix the actual
number of parents of that mux by using ARRAY_SIZE instead (avoiding
similar problems in future).

Fixes: 7915d7d5407c ("clk: amlogic: gxbb: drop non existing 32k clock parent")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://patch.msgid.link/20260623201956.1324992-1-martin.blumenstingl@googlemail.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index f9131d014ef4..d432e08d1777 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1394,7 +1394,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.name = "32k_clk_sel",
 		.ops = &clk_regmap_mux_ops,
 		.parent_data = gxbb_32k_clk_parents,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gxbb_32k_clk_parents),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };

