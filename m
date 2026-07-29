Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BC471CE2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323837; cv=none; b=qALtfRmsJv4iXVbJ9A18yzfPkRC5Bl0oiIEPPVRhOFlxZrBnypSn9VLY24yMB8DyoZPg+H25d92dV6hylnEYUMkCTT7iJYcwH3XnnS5/qRDI1QECT7+ujgA74zlBSOupu1xa9EkX1LLG9smNxDtyzfZhdcTT6aeuSLLIAEvaQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323837; c=relaxed/simple;
	bh=v16mD6YlZwxHjtMIHLYKaEfoBwAqHTaomy9ITxjlyK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ii4CUTJlmcEoa0dAYtGnmgAb1BpoATwPDohpcQRHSv/k/zZzdosmXtGvOoQNuuQAKZOvNn3Mqz9msvwP2f5blXAOx1jiCEtPq/h6PS9fZfSBf3WngOY4FFmxWoPexpuMJEJONPgrmVMbROgwEryZF5BoCDbHixVChVRmOngd7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPjgEHf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPjgEHf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C9F1F000E9;
	Wed, 29 Jul 2026 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323836;
	bh=2YrSy/scPVE2qTIfblQqfAix9qBRxbLnfFlfO7r20Kk=;
	h=Subject:To:Cc:From:Date;
	b=vPjgEHf9U5mA/q9rkPEqiVznoyYYRfI3wbLwltPAxLUiXXy7Iy7+pf0niCZDDcITt
	 L5RNCW1oNec/m0XXsO5PAdzbwgTlQq6Iow17NTglnds8B2Y7z5hY3wVxgsm0EiCxOt
	 dlOMzTKPrY/3Iia8+f2gBrTuEAQsTMeLwV3/XNM8=
Subject: FAILED: patch "[PATCH] drm/i915/vrr: require valid min/max vfreq for VRR" failed to apply to 6.12-stable tree
To: jani.nikula@intel.com,ankit.k.nautiyal@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:16:54 +0200
Message-ID: <2026072954-ditto-footprint-1e46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8a9262c7a6fc2de9802e14b0228114f0333869e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072954-ditto-footprint-1e46@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8a9262c7a6fc2de9802e14b0228114f0333869e Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 25 Jun 2026 16:10:40 +0300
Subject: [PATCH] drm/i915/vrr: require valid min/max vfreq for VRR

Ensure the EDID provided min/max vfreq are valid. Most scenarios are
already covered (by coincidence) through the checks in
intel_vrr_is_capable() and intel_vrr_is_in_range(), but be more explicit
about it. At worst, a zero min_vfreq could lead to a division by zero in
intel_vrr_compute_vmax().

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 117cd09ba528 ("drm/i915/display/dp: Compute VRR state in atomic_check")
Cc: stable@vger.kernel.org # v5.12+
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260625131040.1051272-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 1765cf59f517b02f3b0591fe5120930d08bddeb6)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index e03b5daac5be..aa587be908f1 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -74,6 +74,10 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
 		return false;
 	}
 
+	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
+	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
+		return false;
+
 	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
 }
 

