Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDC2DA74A
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947123; cv=none; b=o7uLVZVYxy9QLSJ5pIqP8ti3KFjmbKkdbqFpeGQxe04yI9j9HzCV2Qpk/VDvpSCWt/FfwJZhXsoXNKRhWrpKfB7wxHtm11zU7lYhRgO/2Da5px7pLu0VXfruGfPwSRuNknUN7sIpRGVDmiiNyl1LjTRvYmopWLIQkesV3jlgaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947123; c=relaxed/simple;
	bh=sY1EXu6XJriY3tvu/gmi6LhrdEZ8H92YFE4m8GycJTI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YXZ0uHuKl1Y6Ton6PN8Ta0HpB+Lf7Dudqq8rRAb4VrtWh1OCT0QtlcodVHUUPfE3XolAAC9QziZ8qxbdWGWdvkM+5WNcFLiY4VCpJgOanKAk+6nN32EfGFoxC564D0+nAAEIcus10ixD9HBc2D2bFVVu8mixviPKhXxfurvRxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXLYW1hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXLYW1hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CA71F000E9;
	Mon, 13 Jul 2026 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783947122;
	bh=iZd98J5YgAnCLq+Tk3SZTHTaRJTaRDADL04455H4UCs=;
	h=Subject:To:Cc:From:Date;
	b=KXLYW1hIIY4lK2hF2ibaVI7JsMwLC7e5oGwiqheR98XgbGsFDsNCPlfAT1vS0evuq
	 XFdIkOEhSyaBuvZRwKcD8ri9yPtnuOMrxfIadpC60pa1Rvd954mHjbq7uTAWIl+H9/
	 f3iXMWEs35SHdep0Vwui5re+Y86NU7ISKs/SAmYU=
Subject: FAILED: patch "[PATCH] iio: temperature: ltc2983: Fix n_wires default bypassing" failed to apply to 6.6-stable tree
To: liviu.stan@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:51:45 +0200
Message-ID: <2026071345-neutron-revert-03cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 434c150752675f44dc52c384a7fa22e5176bc35a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071345-neutron-revert-03cc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 434c150752675f44dc52c384a7fa22e5176bc35a Mon Sep 17 00:00:00 2001
From: Liviu Stan <liviu.stan@analog.com>
Date: Mon, 25 May 2026 19:39:28 +0300
Subject: [PATCH] iio: temperature: ltc2983: Fix n_wires default bypassing
 rotation check

When adi,number-of-wires is absent, n_wires is left at 0. The binding
documents a default of 2 wires, matching the hardware default. However
the current-rotate validation checks n_wires == 2 || n_wires == 3, so
with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
for a 2-wire RTD.

Initialize n_wires = 2 to match the binding default and ensure the
rotation check fires correctly when the property is absent.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..1f835e326b93 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -741,7 +741,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)

