Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4A4A21
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447348; cv=none; b=kz+srMqD/F4LaIm6KTjrRjOiqCKbkiJbbKbEio4OK0RWLWFKmeotMTLzbTJqpRz6q/aGTdazzZgt5c5qRymHHej+ZH/Sv4DFqCEct1lWaM2YbshpKJKz4TT8l3iQnAfdVVV1Y4PL1sEvZLOdSDy3Quw/MxWaPaJGP6KsYtAYXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447348; c=relaxed/simple;
	bh=sK8BjF4NnFxHpDOfl7DZMeNMu8c787BEr4rOuS2iqw0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AHoOsappcgYYUAJ1Pi1D5gdVZm0pYxGY82f6kcVk0J2fDxuD1/rxKahdKsNKq+ay5E9V8cb2TyARkEhiDFjADA9qTm7Ki/tUvf+wCkiuBk0lpr9lQTDRX3p/WNP3RJXH5EorCkmZLeMxJl5tMdQe4K8Es+4dk/8yipYiyB9fjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7mc6fm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7mc6fm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFC51F000E9;
	Thu,  3 Sep 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447346;
	bh=t79/UExu6DGyO4EjE/u4k71PiJRhdepAaN+dMazfyoU=;
	h=Subject:To:Cc:From:Date;
	b=P7mc6fm09eqYQBgKLVcNEvBDirGi/S+Er+IoUed1AdLFo+cadAzSJBnt8rnoGc0xe
	 bnZHys1DhtWHNbpYAvWP+zfl4Jan2BOPcUQrQ3OFysce/bWH8qRzpNcev+8RKkRfNN
	 opiaBlb0TJejD+1anyK3e5my9tTGpbNXoQnYTek4=
Subject: FAILED: patch "[PATCH] ASoC: codecs: aw88261: only check PLL and clock state at" failed to apply to 6.6-stable tree
To: jorijnvdgraaf@catcrafts.net,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:31:48 +0200
Message-ID: <2026090348-garment-snowdrift-7618@gregkh>
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
git cherry-pick -x 06b6f1245567a4be862c3e1cc74577922ceb05fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090348-garment-snowdrift-7618@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06b6f1245567a4be862c3e1cc74577922ceb05fb Mon Sep 17 00:00:00 2001
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Date: Sat, 4 Jul 2026 21:28:57 +0200
Subject: [PATCH] ASoC: codecs: aw88261: only check PLL and clock state at
 power-up

The SYSST check performed during device start requires SWS (amplifier
switching, bit 8) and BSTS (boost finished, bit 9) on top of PLL lock
and clock stability. Those bits cannot be asserted at this point in the
sequence: the check runs after amppd release but before the
hmute/ULS-hmute release, and the amplifier neither switches nor
finishes ramping its boost converter while it is still muted. With the
Fairphone (Gen. 6) firmware profile, aw88261_dev_start() therefore
always fails with

  check sysst fail, reg_val=0x0011, check:0x311

and playback aborts, even though the amplifier is fine and PLL lock
and stable clocks are present.

Check only PLL lock and clock stability, for which a definition
already exists; this still re-validates the clocks after amppd release
(aw88261_dev_check_syspll() checked them before it). This matches the
vendor aw882xx driver, which only validates PLL lock and clock
stability at this stage, and the in-tree aw88399 driver, which skips
the SWS check whenever the amplifier may legitimately not be switching
(AW88399_BIT_SYSST_NOSWS_CHECK).

Fixes: 028a2ae25691 ("ASoC: codecs: Add aw88261 amplifier driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Link: https://patch.msgid.link/20260704192857.88366-1-jorijnvdgraaf@catcrafts.net
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 549783d3e75e..dbdf51188cf5 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -206,10 +206,10 @@ static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
 			return ret;
 
 		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
-							& AW88261_BIT_SYSST_CHECK;
-		if (check_val != AW88261_BIT_SYSST_CHECK) {
+							& AW88261_BIT_PLL_CHECK;
+		if (check_val != AW88261_BIT_PLL_CHECK) {
 			dev_dbg(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
-				reg_val, AW88261_BIT_SYSST_CHECK);
+				reg_val, AW88261_BIT_PLL_CHECK);
 			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
 		} else {
 			return 0;
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
index 270ccf375f36..f16f9f8c40a2 100644
--- a/sound/soc/codecs/aw88261.h
+++ b/sound/soc/codecs/aw88261.h
@@ -194,12 +194,6 @@
 		AW88261_OTHS_OT_VALUE | \
 		AW88261_PLLS_LOCKED_VALUE))
 
-#define AW88261_BIT_SYSST_CHECK \
-		(AW88261_BSTS_FINISHED_VALUE | \
-		AW88261_SWS_SWITCHING_VALUE | \
-		AW88261_CLKS_STABLE_VALUE | \
-		AW88261_PLLS_LOCKED_VALUE)
-
 #define AW88261_ULS_HMUTE_START_BIT	(14)
 #define AW88261_ULS_HMUTE_BITS_LEN	(1)
 #define AW88261_ULS_HMUTE_MASK		\

