Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFA3AAF64
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669868; cv=none; b=E/G1KogGX0ZozpTszgvreFBlWMwa94wbiC5oHs0CYh6In8EIqjEhToF72ZwZkvYrfvQWWrWvazZe9ixo4ljd4PjEobPKcuXnFM4U6zB73ojAWmmpUu4pqqe2pg5GuhDHpvnJmfQ+F8p0pxcF4dLj3A68EaGYV6dB6EaDJjoXzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669868; c=relaxed/simple;
	bh=cYleVkVJGN2es5JrGGmtdU0f5hHXGm4j9NT5z98SmiM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rt4OddmRbHLSjblZV8yHzLo1N0aZybuQNGHEJpYgLiFPM80bnFxNMH8rfnzNAXTLVu0+fbkEwWP0OCZmoAwgqmsyXbSN+Fn/8Vl+WVFcEOqX99mtdVStI3oelI9PA1VMHY59eNtL/+8nFDKrGXXCRsjkbnGh5YqRm+vgYZVHL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2eOoHxMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2eOoHxMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE501F000FF;
	Tue, 29 Sep 2026 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669866;
	bh=Uif83cVQbi/ZjgH9rBIcK5h5oaLB+M28y+B8GKs/swM=;
	h=Subject:To:Cc:From:Date;
	b=2eOoHxMF4zJD9SQyjSix5b/t9xTR3NVtQTeZg0TdcFQ9CHikuUiGa4m7rn4Ddkjb/
	 NIIgzBC9HGv5QrH+yyz8l5MAuTwlakdRVaTACfGImypicxcnX5Z5EIDp8vNy3iFaa5
	 NILkCel5lO4buq0ziJdfTlo31qGuLBUpPD+SqcEY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix dc stream excess put in" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:17:30 +0200
Message-ID: <2026092930-shrubs-hankering-0ed0@gregkh>
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
git cherry-pick -x c5fd4eaad50d620c7e09ac2082b2fb55ee54170e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092930-shrubs-hankering-0ed0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5fd4eaad50d620c7e09ac2082b2fb55ee54170e Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:49:56 +0000
Subject: [PATCH] drm/amd/display: Fix dc stream excess put in
 dm_update_crtc_state()

In dm_update_crtc_state(), when a modeset is required the newly created
stream is stored in dm_new_crtc_state->stream and an extra reference is
taken with dc_stream_retain().  The reference returned by
create_validate_stream_for_sink() is released as an extra reference at
the skip_modeset label, leaving the stream owned by the new CRTC state.

If amdgpu_dm_check_crtc_color_mgmt() fails afterwards, the code jumps
to the fail label which releases new_stream again.  Since the extra
reference was already released at skip_modeset, this drops the
reference owned by dm_new_crtc_state->stream and the stream is
released while the atomic state still points to it, leading to a
premature free of the dc stream.

Set new_stream to NULL after releasing the extra reference at the
skip_modeset label so that a later goto fail cannot release the
reference owned by the new CRTC state.

Fixes: 7cd4b70091a5 ("drm/amd/display: Rework CRTC color management")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 102a47065a62dc8f6bbbb47cf082a2934282eb08)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 36d2f86f000a..91fdf3de7202 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5583,8 +5583,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 skip_modeset:
 	/* Release extra reference */
-	if (new_stream)
+	if (new_stream) {
 		dc_stream_release(new_stream);
+		new_stream = NULL;
+	}
 	new_stream = NULL;
 
 	/*

