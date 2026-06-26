Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159501A9FBD;
	Fri, 26 Jun 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442117; cv=none; b=eHAcTuyq0y2f4Yfi66gGaS5+C0GnyewB5bGVJveIUX2YNJ6iXcVuyXJoSIoWvM+nJp1fsgYvPtAKrXfdqhlCtOpIwMFjKmG05ZHiyKuqolXnKDlO8PuGxIUS9warzxTGYc1QToZO0V1lIgskU4K2y30fmw5fAuaoA1Nsk3p2xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442117; c=relaxed/simple;
	bh=wvskUSEmn3eqb2Q7GWIrAzIS4bqD5byfetLgL6eN7yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNr0azM506S4LJbZeoi69Ksw7vPDFlJFZOHxbjX3NQDwLc15uAcCNIODKuzrxjR+LtH5jWEIswNWBF8IDiteQjc1fye8KXtXtcnl4nCt/E6tFxlJdXVHqf5ZAz5ZXw1D1nHfitnXc+Ohpa1vTTlLZgbM+5foZWZDy25qwZ7pGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OA4tOhhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6nxl5kg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OA4tOhhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6nxl5kg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B9847A00E2;
	Thu, 25 Jun 2026 22:48:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 22:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1782442115; x=1782528515; bh=vKxjbEXFAfyWL7XswsMlE
	3bPTcJ1B7Lf7VkFWORwfQI=; b=OA4tOhhxAZuuPBqYSRMyTdEMBQ6rYPKJLyzk0
	xnXBhLrE7qt7hfpYrBQGbMgBIROPDso2i3OvfZm6fZbITCi1RGhwBdt0vQU2DDKM
	I+CE+rXW2eKb7F3ancV/M7tAyQh8YoLS5xmfrNk+5krXB0jkXF6Spf+aeAuzKDfN
	Cg60+naMpyC9A1QidylsHwQnreLXT/hQFinXFQYms6+WRiIfF1hg3DSfjmbBmags
	vHJwNeiJzU/ogEtiGnfVZ8DiS5YRkFaXCOCDVAdXjeN8Aaq0PPY2z6bYIxqYCXgY
	nNUFZEOO2kPIVxKc0VBQ/2mI1V2NmtDPqIQwtctw64rx8L+Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782442115; x=1782528515; bh=vKxjbEXFAfyWL7XswsMlE3bPTcJ1B7Lf7Vk
	FWORwfQI=; b=E6nxl5kge8Jm442ya7SA15FrwGlfCXIaOgzBnn0AwUwDHX3eX3+
	LkonPENS1Jw+Y6MPjQvx1oVWgLJ7emC7KyM8BzbHALGS9UnEr20Z6FMw+LmmNSyO
	znnlTEWmnovF13Eo+2BKAdHAOQ6pyYB1f4SHpLzMLr4oRXLxCe3bqvS6tcSBSiId
	FgyDpOtX0OPVGii8QdhByUQMM3YpiSEH8ihvqOhfkOwmRaHWKolGssvZXSeHMIh/
	nzk83eSGqOMTsLavGNMrR+Nvb1KYjB7rZDJkPd/1LR5lS74s6psID0Uw17aatGSt
	duGycDp8G0qmBsAySzPcLpHO2DzWCjuCCEQ==
X-ME-Sender: <xms:gug9avsbtIZK1qvjJ6UNeajSv19fSgX4p0E1u7gHPtIdt52Udx4TMQ>
    <xme:gug9ajBM69Pv-goUixH3rfx5zJ1d1WLbE5vf7v1UTL-CtT0Ir0i1-4srT2kVjNLd6
    wPei9Wqxlvja7JnjixC0OS2V-uBdK00_TWcNnomqZ0aQVW6bvKgTLQ>
X-ME-Received: <xmr:gug9amZlAAUCOI525gZoYryhXLBHYLn7S3JQ0LYLj_Ey1yBmeoLgSEPlvimNiYO17-npVktkEv4YQPRKuXhNAMoFHRIGFnXfzHSe_-P0uEjqPBU>
X-ME-Proxy-Cause: dmFkZTESxluzVC2KcRUFSvlDgfOqBYmKh2Au24yxyLSGlr5/+JwEZlzAbWiDcZRIrouDmi
    lGm/wtfeYG0YAcqJYKLNQLKIiLBMWBWMMaqaB4QhEQ4HnzgA81OGyBxWVI7qUj9srvgB1F
    nk1xIZD7GG60w+DIk5dxQzi0tKZQSRMZqLh8vxto5Htsa2ILyaL/4WJgEcIwv/mNoR28Bw
    vaDwVYiA1ehM14Ox3oIl9ZG0IViCYxO2pB1gZqQXRvdL2fZSoCwGnVPxg8aFgRP+7obe1d
    7VjsW6EN6vh+EgZgCfpit/XCHvVbbF7coWc/miHeWkg8JZw+eUAQWYDuNiRHla1HY0UjpQ
    qq2ZGVJXznd/B2xYskQ1SIwq8yJDIZQgjGF86zpXF/AqK415hu4zpYAkSrcUoBmEy9BeF9
    P/Ziza211KlAxY601d18K/M5dMbb6JtL28HGiCnNqQbN40oG4rO9K+81J9MA3yr86j2tZo
    Zk85PUA2l/JTSRVfOldBax6EyvmclfDYwCMIL7nS7wrmQ5OTSUpbmS/XGbX0lclFufyccd
    HKTcG0l4WrN4f6/Q13q/pEgyFmYrnp0jwlhsqyvwQ6+oeibLk/PG75fvPJFhsSHmhUKsCx
    VjtUx3HByooGUX39CzxlyTCTbXSajIclJDReSjjik2h3WKsekCLLlQKHaucw
X-ME-Proxy: <xmx:gug9auWF2Xd_RNRBLAGd-SIAH4hbqByjKUZWDh3d8EFL_r1FMfDfww>
    <xmx:gug9alPwhfxpluRCE8CbOB2XeJU4rFLMnA_LekVvV1lSNp06Qn_nKQ>
    <xmx:gug9aoabF3PAlDIPJhJb3fbRwOS4JMtekpPL33miRmHff1MQbrJX0g>
    <xmx:gug9ak-YVpMe-G9Q1s75Uu5y9bW5nlEvXZzmR4-bkFHMqFKm_FeA4Q>
    <xmx:g-g9apbvwexXdyLoFVmDoWXmvcEjifA7rFwdhOZfznDoEf-unmZl9k6D>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 22:48:34 -0400 (EDT)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E222D169F00A;
	Thu, 25 Jun 2026 22:48:33 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kbd@lists.linux.dev
Subject: [PATCH] vt: fix spurious modifier in CSI/cursor key sequences
Date: Thu, 25 Jun 2026 22:48:33 -0400
Message-ID: <20260626024833.3419086-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

csi_modifier_param() builds the xterm modifier parameter from
shift_state, counting KG_SHIFTL/KG_SHIFTR as Shift, KG_ALTGR as Alt
and KG_CTRLL/KG_CTRLR as Ctrl in addition to the canonical KG_SHIFT,
KG_ALT and KG_CTRL.

That is wrong when those weights are not plain modifiers. Keymaps
derived from XKB layouts (by kbd's xkbsupport, and by the
console-setup used in Debian, Ubuntu and others) encode the active
layout group using KG_SHIFTL/KG_SHIFTR:

	group 1: -
	group 2: shiftl
	group 3: shiftr
	group 4: shiftl | shiftr

So while a non-default layout group is selected, KG_SHIFTL and/or
KG_SHIFTR are set in shift_state with no Shift key held.
csi_modifier_param() then adds a spurious Shift to every cursor and
CSI key: pressing Up while group 2 is active emits ESC[1;2A (Shift+Up)
instead of ESC[A. KG_ALTGR has the same problem since it is the
standard third-level selector.

Normal keymaps bind the physical Shift/Ctrl/Alt keys to KG_SHIFT,
KG_CTRL and KG_ALT, leaving the left/right and AltGr weights free for
layout and level selection. Count only those canonical weights, so
genuine modifiers are still encoded while layout/level selectors are
not.

Fixes: 4af70f151671 ("vt: add modifier support to cursor keys")
Reported-by: Alexey Gladkov <legion@kernel.org>
Closes: https://lore.kernel.org/kbd/aj2gR0Y7sM6i9s2G@example.org/
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/keyboard.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfdea0842149..763a3f1b7be0 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -765,16 +765,22 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
 /*
  * Compute xterm-style modifier parameter for CSI sequences.
  * Returns 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)
+ *
+ * Only the canonical modifier weights are counted. The left/right variants
+ * (KG_SHIFTL, KG_SHIFTR, KG_CTRLL, KG_CTRLR) and KG_ALTGR are commonly
+ * repurposed as keymap layout-group or level selectors rather than as plain
+ * modifiers (for instance XKB-derived keymaps select the layout group with
+ * KG_SHIFTL/KG_SHIFTR), so counting them would encode a spurious modifier.
  */
 static int csi_modifier_param(void)
 {
 	int mod = 1;
 
-	if (shift_state & (BIT(KG_SHIFT) | BIT(KG_SHIFTL) | BIT(KG_SHIFTR)))
+	if (shift_state & BIT(KG_SHIFT))
 		mod += 1;
-	if (shift_state & (BIT(KG_ALT) | BIT(KG_ALTGR)))
+	if (shift_state & BIT(KG_ALT))
 		mod += 2;
-	if (shift_state & (BIT(KG_CTRL) | BIT(KG_CTRLL) | BIT(KG_CTRLR)))
+	if (shift_state & BIT(KG_CTRL))
 		mod += 4;
 	return mod;
 }
-- 
2.54.0

