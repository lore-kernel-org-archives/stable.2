Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA94519B8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931249; cv=none; b=tKM7qJmDms6jSRrXmBcqZuABdE8mnlq5S3Pd+yb+jmqYho3xiMW3ZH2RZyQyEDrtlHrj1G51EuT7sf9EvYSfX8cjNZJFcqPR+0dhgPy0Tpy8IZs/UCxuQ/N3pHx9XfWGlpTk9uDIUQ1/XnFYdSc5a4YC0w5CFcSi1AubEy64pwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931249; c=relaxed/simple;
	bh=Th9fssSi0XhIWF1xLvfxZrYv5dLGWb6eFOPT8CtGx9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CWcum5jSHJyUVLBYfT7blo736RkIlpjkTpQfSkRuwJ9T6ZBOIUiX9WsHtw1iNYrDzHizK5cFnQIEeydPZoEDtZbsBvfEVepqfXF8ci7J2zt/b1kv9Q1cVrJoiExD20pXuKmqcCi0iE2jKAiPFUdl6XRQB1gxBK7rirS8jhpQxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWzW4h7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWzW4h7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BF71F000E9;
	Wed,  5 Aug 2026 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931247;
	bh=CcYcMsvcUzZhe8i//uDqj1HQ8us4HHU4z/g0AAvpBt8=;
	h=Subject:To:Cc:From:Date;
	b=GWzW4h7UnL5HdmuUGUIcuEoMsDQXAiMtZ/JlfkKVqt495LyrBt2THG2zCFmORv7dO
	 f5I5n1QG5uBUshtpxHz+E7sjGKTw20e8p9eNNg2t8Icf50bmc1UdK6tOgWnAqwA9+9
	 L1xZCnknMww9waPMQ70pwtS8u3SvhVTk5HTQzbtQ=
Subject: FAILED: patch "[PATCH] drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs" failed to apply to 5.15-stable tree
To: alexander.kaplan@sms-medipool.de,ankit.k.nautiyal@intel.com,jani.nikula@intel.com,maarten.lankhorst@linux.intel.com,stable@vger.kernel.org,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:56:43 +0200
Message-ID: <2026080543-come-antihero-dac2@gregkh>
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
git cherry-pick -x e40e20ac089e32f1d910636155dc82e61e61dcf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080543-come-antihero-dac2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e40e20ac089e32f1d910636155dc82e61e61dcf3 Mon Sep 17 00:00:00 2001
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Date: Wed, 10 Jun 2026 21:38:25 +0200
Subject: [PATCH] drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

The PCON max FRL bandwidth field lives in byte 2 of the DFP Detailed
Capability Info (DPCD 0x82 for the first DFP).
The DP standard defines the meaning of descriptor bytes 1-3 strictly
per DFP type, and for a DisplayPort type DFP all of them are
reserved, with "read all 0s" semantics (DP v2.0, section 2.12.3,
Table 2-183).
The FRL bandwidth field is an HDMI DFP extension added by the VESA
DP-to-HDMI PCON specification.
drm_dp_get_pcon_max_frl_bw() however parses the byte without checking
the DFP type, the branch presence or DETAILED_CAP_INFO_AVAILABLE.
Without the latter the port descriptors are one byte wide and
port_cap[2] is not even the right register.

All neighbouring helpers parsing the same descriptor are scoped by
the DFP type already, see for instance drm_dp_downstream_max_bpc()
reading the same byte and returning 0 for a DP type DFP.
amdgpu's DC parses the field only for HDMI(/DP++) detailed types as
well.

This is not theoretical.
A Synaptics VMM7100 based USB-C to HDMI adapter with a macOS targeted
firmware advertises a DisplayPort type DFP with the type byte
replicated across the whole descriptor (08 08 08 08).
i915 decodes that as "PCON limited to 18 Gbps FRL" and prunes every
mode above ~750 MHz dotclock, including all the 4k@100/120 modes the
sink EDID offers, while macOS drives 4k@120 through the same adapter
just fine via DP DSC (and amdgpu's type-scoped parser would ignore
the bogus field as well).

Only parse the field for an HDMI DFP behind a DPCD 1.1+ branch
device that reports detailed cap info, matching the type-scoped
field layout of the spec and the rest of the helpers.

Fixes: ce32a6239de6 ("drm/dp_helper: Add Helpers for FRL Link Training support for DP-HDMI2.1 PCON")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com> (v2)
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.12+
Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260610193825.2933-1-alexander.kaplan@sms-medipool.de

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9c31e14cc413..e623ccb4c1d8 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3686,6 +3686,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 	int bw;
 	u8 buf;
 
+	if (!drm_dp_is_branch(dpcd))
+		return 0;
+
+	if (dpcd[DP_DPCD_REV] < 0x11)
+		return 0;
+
+	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
+		return 0;
+
+	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) != DP_DS_PORT_TYPE_HDMI)
+		return 0;
+
 	buf = port_cap[2];
 	bw = buf & DP_PCON_MAX_FRL_BW;
 

