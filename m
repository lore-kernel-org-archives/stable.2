Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B073783C8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187588; cv=none; b=HgDKwS9ItQ8ipfP38fcZhDd6MPj7v5bRp0fZVhsh4P48F+AJpik4BUZtHA0KN1Rc+jzSZM+3A/u85V0bbC5dk2sED6SYmFshOwntecCjkgdkxcVmedsVMJiOdzk/hVV3tCRe+n8agXN9vaUJmFOkjW7dd/1VjWzn1khHT/a5hZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187588; c=relaxed/simple;
	bh=9Y63aKRX3y76aunMzUbPjAdh7Q8w6pc+vPmHObc4iDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VOGyHDi3nushKVkdjln3KmdKlzlg0qp1lw9HvIxuZqGrm6Hx9SbOSrOtVafOjU/5tJPPNKIeHp2BmGgudibTVCo1ZZJeccTDPA2JQzK7dkLvCeZjqadUj8uPa0YiLf/igsQ/gxKc11xEbDvQxvBasCwZrWUbWdAzct9ucJJza3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0LvCRNQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0LvCRNQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5041F000FF;
	Mon,  5 Oct 2026 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187587;
	bh=0vkl497FYp418e8hIbF0xdvcd8WgOg5+R0rlYXUfHZk=;
	h=Subject:To:Cc:From:Date;
	b=0LvCRNQGf04ruil6LVkH7LnMyjtNNmXHRvVhORhdGx8yE30fkl8bjOSg2mXefFKoi
	 80wgtaMoEL4jURRNbVH/qSdQdzvdFlDCVtzj09r9zScuEfNLxRtRhXt9IlZADBPtRc
	 cOO8t2okTg4YiELyNZEudOb4nbqCd6Qep02fCTc8=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix fast updates on DCE 6.x" failed to apply to 6.6-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:06:13 +0200
Message-ID: <2026100513-amid-pungent-23de@gregkh>
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
git cherry-pick -x 88427119e1f039c8cdffd63726c136a986ef519f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100513-amid-pungent-23de@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88427119e1f039c8cdffd63726c136a986ef519f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:20:31 +0200
Subject: [PATCH] drm/amd/display: Fix fast updates on DCE 6.x
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
Set that flag for DCE 6.0, 6.1 and 6.4 (all DCE6 versions).

Technically DCE6 should have been included when the fast update
code was refactored, but it just happened to work until now.

A recent commit "Attach only plane updates that actually changed"
has exposed this issue because with that commit, DC accidentally
took the new fast update code path for DCE6 as well, which caused
it to boot into a black screen with a flip done timeout.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-1-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 698fda6e360625850413a2d1a90b72ae5f03073d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index d2d56a1c4b8b..8612cc66a6ba 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
 		ABM_MASK_SH_LIST_DCE110(_MASK)
 };
 
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 #define CTX  ctx
 #define REG(reg) mm ## reg
 
@@ -937,6 +943,8 @@ static bool dce60_construct(
 	dc->caps.max_cursor_size = 64;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1134,6 +1142,8 @@ static bool dce61_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1332,6 +1342,8 @@ static bool dce64_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *

