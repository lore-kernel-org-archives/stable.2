Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB614BD0E8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447345; cv=none; b=Alo3WGC0++IrQerCKSD91iMXuFn9UkocVkBSJxvG3mYZxIr74qZzqOZs/R93SHC+13420nCGLzA3iPXTzik3xPItpnjwNwUYRHlATeQGwuM9mht1TqTgmflBMhN0i6DVyx+TwkefyVYFkDIo/5E5msJPeRNJgDI5G3t84YTxv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447345; c=relaxed/simple;
	bh=eBa3COJ9Hw9qxExESddLl1KpbEiUmDb5Z1eLrFis/bk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KXESCklum3jkWWBwQ8ujjnSImLrdI/D/iiICrH/HFqyeBy/+79pXd6oeV+ztdA+g+cJEPm33e5cHgvT7dDuTP3eyINg5/D/h7HbIc4JEwaM/U7JwswM0yWkY5Uh76qbbJ3Gj4PRkGfVpR+QZdSerkVmoBE0bZaXQseSUHp/7k7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpKCk8/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpKCk8/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDF51F00A3D;
	Thu,  3 Sep 2026 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447343;
	bh=+XOvBzEnpRPEVKcytyBN7LFVmxzUf7AC30gIkqvqilY=;
	h=Subject:To:Cc:From:Date;
	b=xpKCk8/TZDAdVCVFbJtP+duyp9nmiqqJaUL2rT2HCE2tx+h1c4TP0GVRmWC59YqAh
	 9MLsy649Dujp85ZNQ8rPd0vVygDywm1WVSU34Z8b/qux91/2Hl/DLYfasMy1T1B/+j
	 KkXg280ysHEFh5kid/6Ll8u4lsnj0Y+3ER1+0u/k=
Subject: FAILED: patch "[PATCH] ASoC: codecs: aw88261: only check PLL and clock state at" failed to apply to 6.18-stable tree
To: jorijnvdgraaf@catcrafts.net,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:31:47 +0200
Message-ID: <2026090347-devalue-briar-8e69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 06b6f1245567a4be862c3e1cc74577922ceb05fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090347-devalue-briar-8e69@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

