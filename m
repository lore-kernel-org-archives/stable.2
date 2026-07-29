Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F882471253
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323865; cv=none; b=PTLn8s9N4iZMM34xZ1b4GIcR9yH6wfKyaCtXjutxIFdaaOSwAhHzStBBegKHSVJJWP6aH8ZYg2xa/rhJOwUdTyhZY5ZSsdEQAzTxN0ciKX+gFpImZJeReWWN8Qb66Uwtfdxvuxr8rcipzkwfIAlreKKr4fYwIn6yH+HiWoTRrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323865; c=relaxed/simple;
	bh=wXQanlyXUT8+lLCHDnIeKRuo8ahUmOQp810hlD/OJIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cKoIDjexNtzs9JBfiAWQztzEZkA+TTHIO3FCi3xqxIIaJ6cA4JBIe/rHRza/rYIsDj7i9yrO6q/EXoRTaCE2JoVEBtc+cV6V5n6zF9dpVZ7Q7ZguVbVROB4pFRAcUp6bPCjMpooZXpOpNu5ONEF0LHHS/kvmfNcYwjYWTnJjhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wolueyLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wolueyLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210CA1F000E9;
	Wed, 29 Jul 2026 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323863;
	bh=qZTvOFg2TFf4pZ5s42LR2zgxXThA7+iVXcr41BH9RMo=;
	h=Subject:To:Cc:From:Date;
	b=wolueyLXrXNAHO4QC1ch2/1mO134Vuyl4M5l7FQ48mMtK+k0G9lXIiVS5IiL5CrtH
	 CBq+bJ61Juu1/RSJ9p/KHsDNHsEeSHnUpFGSYD1d/iJiFiAoiVQBSZahE8TFxIQ7ET
	 DKZQBlhzma68ueCJvg/keRQF1GuGMQOD1TeTGVGU=
Subject: FAILED: patch "[PATCH] drm/i915/hdcp: check streams[] bounds before overflow" failed to apply to 5.15-stable tree
To: jani.nikula@intel.com,anshuman.gupta@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:17:17 +0200
Message-ID: <2026072917-tribute-crunchy-bb86@gregkh>
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
git cherry-pick -x bbb15a6b042d02e5508a02b4847e02d2579ee7bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-tribute-crunchy-bb86@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbb15a6b042d02e5508a02b4847e02d2579ee7bc Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 25 Jun 2026 20:03:04 +0300
Subject: [PATCH] drm/i915/hdcp: check streams[] bounds before overflow

The data->streams[] overflow check is done after the buffer overflow has
already happened. Move the overflow check before the write.

Side note, emitting a warning splat with a backtrace might be overkill
here, but prefer not changing the behaviour other than not doing the
overrun.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp port_data")
Cc: stable@vger.kernel.org # v5.12+
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260625170304.1104723-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 9284ab3b6e776c315883ac2611283d263c9460fd)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index e88fec24af49..521786a75c42 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -145,6 +145,9 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(display->drm, data->k >= INTEL_NUM_PIPES(display)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -155,7 +158,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display) || data->k == 0))
+	if (drm_WARN_ON(display->drm, !data->k))
 		return -EINVAL;
 
 	/*

