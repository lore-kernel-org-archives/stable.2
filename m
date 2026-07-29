Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44147DD6A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328720; cv=none; b=GECqR3iHe+pJ+sIPS9Xsa6W7Pes9+Y/QJ7Wyhb5aXSlcIHszhwltP9KcP7Af2uwDT/Tkv1p8WOgK9WYxtUdwf9pAijWmPnIpwiWXcgqf7fylbkc4bM7JqmzIwLVPGNoJHA1DMIgRS9Zr3YEml7N3eNKfmIDeWVCTgHQGzzAXLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328720; c=relaxed/simple;
	bh=edOrbQqlS14RfCoG/O9AhBuRNRzg2zsjHt/5Vk0qTjc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Si9EJcXMXMoISZbLmVA81FBuJd2TpzsJN0vozUxAfMhSb1+Y/JdEBQUBdnS4sn+oYFz2oLP4Z94wVnoBU+Mdwyktwh5TkmfQf/vmUoRqiAud7nQcwcqlmqwgCPwNJqn8btQMtJE+NXU/TWGD3+fJ/1eIPeVEeU7HCsL2Spjpq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WLyyGOsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLyyGOsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BF41F000E9;
	Wed, 29 Jul 2026 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328710;
	bh=6lX7nTvkPe5gX5JztFpT8D3QBSpRl635JBAN7YZyJkU=;
	h=Subject:To:Cc:From:Date;
	b=WLyyGOsFLeeEHl8vFteaLMFZE74RcDGit3tHx1ZnHc7pH8VNLCIaSmr50wwaeCWts
	 FHX/cC8/kDjH6bVeWLzxePAsSyV6a1UNs/OrWusSAw5vmTfTHlJOHMpj6z85DhXgrE
	 g/+pvGjx8dsOcXlcPCn0AWEbHXFV6CLfKXNKcmLI=
Subject: FAILED: patch "[PATCH] drm/i915/mst: limit DP MST ESI service loop" failed to apply to 5.10-stable tree
To: jani.nikula@intel.com,imre.deak@intel.com,martin.hodo@intel.com,rodrigo.vivi@intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:38:02 +0200
Message-ID: <2026072902-surfer-snowcap-8d68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 005771c18c5b2c98cb4e7517661aea460990fd3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072902-surfer-snowcap-8d68@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

