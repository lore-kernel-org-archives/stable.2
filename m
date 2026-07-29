Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A647142C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323867; cv=none; b=qeuBqlGR4gVrLmjNdGYRT24iqXg0HaaOIeHpKyATx5zscxqZJhOG26tdtdjGETa6/qfGFFBD73CBteLQsgi55tuYQLd1NJfme80P95MibdrM09JhDRkJnHy3woJ0GqmqMZjcxqlJ57YzpM8nzi8A8xtJYaYEKg6DduPUsnD8I4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323867; c=relaxed/simple;
	bh=3uoZ5s2Qv4BXHJKbSbH4tkWI20xcOPhcvQ2g0JyU/eQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UNFP8/dfNbdgOYvE2BjWANicf09YW3c7RXpIWYTRn88esQN5gQfG6hYsEaM+wuRHDfFKrdV6Klh1YMs022JYFnnI9jEigCiE+dKvY5Nl6IIjVLrsGKjg4I0ZJAK7+xMOLsjCEmKdZoou74dkJ0p+wSvTNa5w0liuBcLP4KVyYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssxExjTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssxExjTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B31F000E9;
	Wed, 29 Jul 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323866;
	bh=r1cgky32kex/6bds5BGbax2hmECeLjellKpU5yUrWFc=;
	h=Subject:To:Cc:From:Date;
	b=ssxExjTbcuE9cCQRI+E65H7MG+Gro7TcMqXFGiRmPAvpmIgcLe6p6acuNAhDCAsvd
	 nDPRw5BoPQQA6n0kze1GXlc6fayzPqMUP22eu6naSq5XbZBrwbk78G583Um+re4nh5
	 9C5OKM9AtQxQheQOW7ZeBH5QnAYbS34cqONfnTmc=
Subject: FAILED: patch "[PATCH] drm/i915/hdcp: check streams[] bounds before overflow" failed to apply to 6.6-stable tree
To: jani.nikula@intel.com,anshuman.gupta@intel.com,joonas.lahtinen@linux.intel.com,martin.hodo@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:17:17 +0200
Message-ID: <2026072917-dugout-sufferer-eb18@gregkh>
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
git cherry-pick -x bbb15a6b042d02e5508a02b4847e02d2579ee7bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-dugout-sufferer-eb18@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

