Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433924071D6
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538655; cv=none; b=YbQi7H1kvK22pk35hjQoQPAPuQvc9BHBAZeJijS8P9hsxXrU2Y//OIS0KXvs39NYIYgSrSy/rtOMBPclA/QHp40H0MfbxAfib0FUE2/sDjyrg2FyYPI8dGHcZGN3ER34TE+Q96IDNxC1Lb12nilFD9o9zaPzOUfLCqxVP7eX/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538655; c=relaxed/simple;
	bh=d7BfPRwr35FLvH0ybPGxxpZUAEsE/X6NllkFhN1GC0s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TAsyJXY0slw+PMcw9o0MlmRfFy4OjetuYrYXzCOsGsmKKnqpyJ4fWETfUTBweynjzKWGQC+ZAGaRHH+BkbPmQF9dVFIhvIkIRtdOpP/KOP0SyrnOnX0DZFWxPUSbH4fcf6f4XNgtIGiQAysWicE+sYchf86jK/C1bFghqwgzbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UTn1FmzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UTn1FmzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25EE1F000E9;
	Mon, 15 Jun 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538653;
	bh=uF7JCpUX2LyNly3BpZ2hkZoqXVq2Iq6YZMoOPnPtz/E=;
	h=Subject:To:Cc:From:Date;
	b=UTn1FmzCC90EzQNMm12swHaRLbndAopwk762U2+7vbJFFThkDcLozCXftDcYOehdT
	 52V5uk38alV34WchTsGMYHq6qlCFVWDwBYIYxTjxp5Bq7uZPNK6WrxxqSm87QGfWZw
	 fkj1obbQUOd3Hm89JkhdeabxmQn50h8mk7+MtcSA=
Subject: FAILED: patch "[PATCH] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC" failed to apply to 5.10-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,geert+renesas@glider.be,ulfh@kernel.org,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:42:46 +0200
Message-ID: <2026061546-plexiglas-flaky-762c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f48ee49726ee4ab545fd2dc644f169c0809b19b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061546-plexiglas-flaky-762c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f48ee49726ee4ab545fd2dc644f169c0809b19b3 Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Tue, 19 May 2026 14:53:40 +0100
Subject: [PATCH] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC

The RZ/G2H (R8A774E1) SoC was previously handled via the generic
"renesas,rcar-gen3-sdhi" fallback compatible string. However, because
the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
requires the specific quirks and configuration defined in
`of_r8a7795_compatible` rather than the generic Gen3 data.

Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
Note that the DT binding file renesas,sdhi.yaml does not need an update
as the entry for this SoC is already present.

Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f6ebb7bc7ede..838248bf8dd6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -279,6 +279,7 @@ static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r7s9210", .data = &of_rza2_compatible, },
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a774e1", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_r8a7795_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77961", .data = &of_r8a77961_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77965", .data = &of_r8a77965_compatible, },

