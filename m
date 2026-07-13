Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14564
	for <Stable@vger.kernel.org>; Mon, 13 Jul 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947153; cv=none; b=msCxZe92XmC58S4ZSSeHRPmwvAVtaSMbO0x20M8oYRqozOUP/DqMNNbA4ZA6USYObran4hU5I286EJojsmdTANYVe0BlabhzstIqwc3XnNvkhPSVvjOG4/S6Y+9H/0BzzM7QxpMGa2HpcCS4RfvFKBrMZbVOp/sb+gS0lXlCHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947153; c=relaxed/simple;
	bh=ddPom8UqDQ01xEZWnfVeAwwfxH2kMgPjALY0Uu0mqtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ijYblKT1OMVsw5Pql/myypbtIBXiuJe8cNn/W5IOwtOQlSo6TAYlEzv1ppjFGXENPbCXZKm3efyWrM2emTrXkfCbmk7fyj3prRi9B9eq9Qrazvq298DSjLj0nef3/Y9VJqcDqWHgZ7Sxg81qGO84esHQC9HB23VqzDZ3EJbHzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/LGfpN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/LGfpN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E341F000E9;
	Mon, 13 Jul 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783947152;
	bh=9AL5ZcWz33Erbc5BnjtKYQMrDdvEmij5LxlHuVLA/WI=;
	h=Subject:To:Cc:From:Date;
	b=n/LGfpN85tR7b+vt4pSIW7I5zaa7p4YXzYWUXPx3MlgX4tIjzIK/rvkzH/jl6dbZW
	 FgYQbje+/3419/sTIlTbLreCzCxDDzidH2ZdFFsNL4s/8zNusi0iMEBZV/4Gu/JDsa
	 TOvE0/6G7fgvRmm2KCs+mI9f0oKgP3uxZWXRLWV8=
Subject: FAILED: patch "[PATCH] iio: temperature: ltc2983: Fix n_wires default bypassing" failed to apply to 5.15-stable tree
To: liviu.stan@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:52:14 +0200
Message-ID: <2026071314-ruckus-bacterium-2228@gregkh>
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
git cherry-pick -x 434c150752675f44dc52c384a7fa22e5176bc35a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071314-ruckus-bacterium-2228@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

