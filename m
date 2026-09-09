Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147CC4F30EB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954647; cv=none; b=eV/ubceWPA65emeuAsyTLphTtTkKS8Tn5DVqb+tTG2KYmxh3llGhM3onF6HJuIrNNHYHMrXk4wqmNsfqDQkn+a5HFgcRCIh55wIFRovWh6yF/sfe0UK+BAJFnhwOSyirOkYbgkzxkDIc/rBs1jkD4GxnpG6tzjTf12Mz0swQPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954647; c=relaxed/simple;
	bh=R6xviM/Wahnhi6PhHRm0N+gi8rPxdGlx77FM2iFJieg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OcNwI71wMQn+MG3p0GM7YW0yFzFOakqatMqRJ9UsvZO4IIJ9jdsTHTtvvWrNcJTTuPdJ2Ou8B8AmuwIkalK29i3cKxwbd6fKKf56BsCM+CfRYdDXpoS3WqviK9pSehar4isdL6MPD8hHMFEyCWcIvyJWCABZ9IheJZvY8T44BbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5zA9EHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5zA9EHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D091F00A3A;
	Wed,  9 Sep 2026 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954645;
	bh=vQ6jkWUXd6mli1BBhw+x2xX3z1tEZL26+vnxnGERZNg=;
	h=Subject:To:Cc:From:Date;
	b=y5zA9EHxTk3sG6v6REHf0ZWpH+E/a1bZV5UL3ET3GfZLXiQn57hc0IS8Z4yxrQcef
	 VySxYYPX5nb9axnvjt3+0XOiyxzanA1jtI8eGvAfa7NBFJqTaWr4czq/ofpaJw/9Tx
	 WfjcQnqGx1mwBSbcOFYDp1sJGJ0hIKTsTHrEfXKM=
Subject: FAILED: patch "[PATCH] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+" failed to apply to 7.2-stable tree
To: ville.syrjala@linux.intel.com,jani.nikula@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:40:42 +0200
Message-ID: <2026090942-slot-trapeze-8273@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x aad969968824e97ba8d70dd7a95691f750438ebd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090942-slot-trapeze-8273@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aad969968824e97ba8d70dd7a95691f750438ebd Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Fri, 17 Jul 2026 18:51:06 +0300
Subject: [PATCH] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apparently PTL+ no longer has the cd2x pipe select field in
CDCLK_CTL. Take that into account during CDCLK sanitization.

This currently triggers a spurious CDCLK sanitization during
driver load on PTL+ which will causes a visible glitch on all
active displays.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260717155107.17801-1-ville.syrjala@linux.intel.com
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
(cherry picked from commit 1786d26887817a779641d3a093c66ac91382113b)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index a53d88727177..9e5e15b0c4d1 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2381,8 +2381,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}
 
 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {

