Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5C47DFAA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328708; cv=none; b=JI12QvIks1cXoxd88C3eEM6275WsUrvaUOMAZ4JEBrFsIYoc1L/qvskwNWiKK7ZHB7qzQl26gdERGCQfRiybTm+VqM5pAvBZ6lllU6vwJKSoA5ZA5MEQiRzpOrOqfmpBEdWjYWkcrb6iycJW2SDhlGmCkZ7Zuh7ZAIk1KtRMxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328708; c=relaxed/simple;
	bh=sdPVmF/QWy6smeo2w+loLp8LY0IaKd6ot0Y4gUGjnpY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pdzldZIcTZRG0v0MV9ErTnVxeDWj4Argz+m8GwTNSae3y9SbJrJKbISaHi25ERCswz1SJnayiTPmUQCqgkK6bQmfYqxOcJtBZ8exabj03GxtyJNIKHBf0OpWAegT/HlL0Gbuxs4qUGNEilVBWzuQwTPEhrrk8xBnW6/15rkI1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4ABfQ1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4ABfQ1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8351F000E9;
	Wed, 29 Jul 2026 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328702;
	bh=AuNMPL59EYUucpI9gIj6nAWLxImkESAUsc5mMTbFkkg=;
	h=Subject:To:Cc:From:Date;
	b=r4ABfQ1a3eRHIvOUdlbSh+xS31WLEringseR6zzp5xE0FFjJxE2nUXEbzGYZe2nvh
	 rsrX7bNBP1Pu2J/+q8Jw9uKHFrS9/3unLqCwGBKfP52yx5tV9Mq8qx3bV372lIgCGb
	 43ZOrChG3PmSEI+RNTd3OToCQ9j4oPZyB/r+xb8E=
Subject: FAILED: patch "[PATCH] drm/i915/mst: limit DP MST ESI service loop" failed to apply to 6.6-stable tree
To: jani.nikula@intel.com,imre.deak@intel.com,martin.hodo@intel.com,rodrigo.vivi@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:38:01 +0200
Message-ID: <2026072901-lizard-seclusion-c95a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 005771c18c5b2c98cb4e7517661aea460990fd3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072901-lizard-seclusion-c95a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 005771c18c5b2c98cb4e7517661aea460990fd3f Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 25 Jun 2026 17:22:04 +0300
Subject: [PATCH] drm/i915/mst: limit DP MST ESI service loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The loop in intel_dp_check_mst_status() keeps servicing interrupts
originating from the sink without bound. Add an upper bound to the new
interrupts occurring during interrupt processing to not get stuck on
potentially stuck sink devices. Use arbitrary 32 tries to clear incoming
interrupts in one go.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Note: The condition likely pre-dates the commit in the Fixes: tag, but
this is about as far back as a backport has any chance of
succeeding. Before that, the retry had a goto.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 3c0ec2c2d594 ("drm/i915: Flatten intel_dp_check_mst_status() a bit")
Cc: stable@vger.kernel.org # v5.8+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260625142204.1078287-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit b4ea5272133059acb493cc36599071a9e852ec2e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 85d3aa3b9894..7ff5712f8b19 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5737,8 +5737,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	bool force_retrain = intel_dp->link.force_retrain;
 	bool reprobe_needed = false;
+	int tries = 33;
 
-	for (;;) {
+	while (--tries) {
 		u8 esi[4] = {};
 		u8 ack[4] = {};
 		bool new_irqs;
@@ -5781,6 +5782,11 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 			break;
 	}
 
+	if (!tries) {
+		drm_dbg_kms(display->drm, "DPRX ESI not clearing, device may be stuck\n");
+		reprobe_needed = true;
+	}
+
 	return !reprobe_needed;
 }
 

