Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E33AE6EB
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669761; cv=none; b=M87ZMNZ+krDUaTrjeFCYcmorzBwnrkgoiKVVd9PZ0QnWyNqStfU14gAIxBuyR4yAgtieyM0UK78cJG9zkR/gm7NRBVXoJCIWuZ9rya5miDQS3xM1FL0PQZgSxm/yvbOUURD5h1Vup8vk0dr1JS2sfsSmlVdFLemd8iX++eTNNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669761; c=relaxed/simple;
	bh=5+anLP49U/Us6iRhleMNmvTDQoSD1yOU4k8nyiqTlr8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KmJP4rRaou1nc/osd7xLHv/0RXvm0ad6i5K3IK9/hgU//vXaUQfQ8buvmpCOwkzdPqkvDADD/mtinZvd0qCwi9oaNUZL10c1sqq679gI4pB/vTKHSHH4lrrfbfPniex0Lvw37lKXFAlnSbTyTZEjL6gIHaZ03FeXxYAfFAXxyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJXU7WCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJXU7WCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC37A1F000FF;
	Tue, 29 Sep 2026 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669760;
	bh=uxnFzSrmXREHnNOcV4819TJTAUQbRGKHzbhAQNNGbps=;
	h=Subject:To:Cc:From:Date;
	b=SJXU7WCGdrSb24/Xu9KeLlenOjRYIdzz6uGAsUEle6ofepzqoor6op3v2VxdO9iUV
	 wvDEYeFaAg3Qj2HDM6bjAXy1eDXCZGXzx78o/4JtFFSNCTOizT+31TFJwkOTlRHOit
	 LLsthq+6WrRNFZnkfTqj7a6CuIixY3WQib9w6b2Y=
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,luciano.coelho@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:15:54 +0200
Message-ID: <2026092954-aliens-penalty-0786@gregkh>
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
git cherry-pick -x acbe9a3b60b9a6ace8ef11fe898f586251c84592
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-aliens-penalty-0786@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acbe9a3b60b9a6ace8ef11fe898f586251c84592 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 7 Sep 2026 20:44:12 +0300
Subject: [PATCH] drm/i915/dp_mst: Fix configuring FEC for a disconnected
 stream

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the FEC is configured the same way (enabled or
disabled) for all the streams on a given MST topology's link.
drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
downstream of an MST port will return false if the whole topology is
disconnected, since in that case it can't verify that the port/
parent_port passed to it is in the given MST topology. This is a problem
during the above FEC configuration check, since
intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
will not return all the stream CRTCs/pipes for the topology as expected.
Since passing parent_port==NULL to get_pipes_downstream_of_mst_port()
is meant to return all the streams for the given topology (i.e. mst_mgr)
skip checking if an MST port is downstream of a parent port in this
case.

This fixes a problem where the FEC configuration check explained above
failed to ensure that all streams' FEC is configured the same way if the
topology was disconnected, leading to a FEC state mismatch error.

Cc: stable@vger.kernel.org # v6.10+
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260907174413.741851-1-imre.deak@intel.com
(cherry picked from commit 270681fbffbba2b6ccf5b7e3c34b8b563b36167f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 57daed0b0b36..9e65b4a1c71d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -852,7 +852,8 @@ static u8 get_pipes_downstream_of_mst_port(struct intel_atomic_state *state,
 		if (&connector->mst.dp->mst.mgr != mst_mgr)
 			continue;
 
-		if (connector->mst.port != parent_port &&
+		if (parent_port &&
+		    connector->mst.port != parent_port &&
 		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
 							  connector->mst.port,
 							  parent_port))

