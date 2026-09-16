Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11F5237B8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572561; cv=none; b=MUo8B0Ch/sOkOLfF/j5J3gKjxYmL+1x0jdGTDlpGsiluDSWL1lj4+7egV/e+6ePa85QHpEb1lI8+iNnvMX+wfyRqGhf1Rxtw3hApfNimBzntMp6Ym4nDnBioIDfrGiSyhKBBXQBKXGkTexUDzhHWdvGIFm4vFb4T6MH9bxersMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572561; c=relaxed/simple;
	bh=3B/QEllsPo0NHJSq0aVhccBnV97t2qqpfaosF3yEads=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BqyMJ4MkC1rAHV/siDj/zdaMe+JYwVjo46fC29vVz3fXEDwzHXUD0BRH5AZhxUeMhYeIwmxE1BHSCugPTmGNGb2wni82tFbhZIHJ4cVTi2E8AGBpQQ/kf7ffRD+P02+fwMTNcH7hsV/FQWoPKoUH70EIgo9/SL8W6pXxwW+3ER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REqB/tQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REqB/tQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423341F00898;
	Wed, 16 Sep 2026 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572555;
	bh=sI7N3xvItk4Npcn9tcIecNhgVCPwC/5mF503ds1nG3E=;
	h=Subject:To:Cc:From:Date;
	b=REqB/tQ5duBwEPgzxMKdeTKJyxgvx29F90vPJVmBgevwuEQnSC+obz0IkrVTjPLrp
	 WwNOAG7G2U58xjq8fUfkKE2pb2su/nkID90er0QhukUP6Udrlih2SDkL3Zas3F4SS9
	 sssv8tShCOfYBeHAU2xl8obD8xo5d5nqTobVKTKE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Propagate HDMI RGB quantization" failed to apply to 6.18-stable tree
To: sroy14@alum.utk.edu,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:19:44 +0100
Message-ID: <2026091644-upheld-bride-0921@gregkh>
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
git cherry-pick -x bdcd0411d7d186225a52458fd42bb70d54ca917a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091644-upheld-bride-0921@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bdcd0411d7d186225a52458fd42bb70d54ca917a Mon Sep 17 00:00:00 2001
From: Satyajit Roy <sroy14@alum.utk.edu>
Date: Sun, 30 Aug 2026 03:51:58 +0000
Subject: [PATCH] drm/amd/display: Propagate HDMI RGB quantization
 selectability

DC uses dc_edid_caps.qs_bit when constructing the HDMI AVI InfoFrame
quantization-range field. Although DRM parses the sink capability into
drm_display_info, DM never copies it into the DC EDID capabilities. The
field therefore remains zero and the AVI quantization range stays at its
default value.

Copy rgb_quant_range_selectable for HDMI sinks and extend the existing
EDID-capability KUnit test to cover it.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 892659399f64642e33072562a11ec1b2e7bd2263)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 249e0cd995c6..298de7b75ca8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -200,6 +200,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
 	if (edid_caps->edid_hdmi) {
+		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
 		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
 		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
 		if (edid_caps->frl_dsc_support)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 0c4517fb9d75..82e0c984693c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -358,12 +358,14 @@ static void dm_test_parse_edid_caps_hdmi_frl(struct kunit *test)
 
 	/* Drive the HDMI/FRL branch */
 	connector->display_info.is_hdmi = true;
+	connector->display_info.rgb_quant_range_selectable = true;
 	connector->display_info.hdmi.scdc.supported = true;
 	connector->display_info.hdmi.max_lanes = 4;
 	connector->display_info.hdmi.max_frl_rate_per_lane = 12;
 
 	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
 	KUNIT_EXPECT_TRUE(test, edid_caps->edid_hdmi);
+	KUNIT_EXPECT_EQ(test, edid_caps->qs_bit, 1);
 	KUNIT_EXPECT_TRUE(test, edid_caps->scdc_present);
 	/* max_lanes 4 + max_frl_rate_per_lane 12 -> rate index 6 */
 	KUNIT_EXPECT_EQ(test, edid_caps->max_frl_rate, 6);

