Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823483B19AC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669856; cv=none; b=Vg4Q9xKFbB4wWmh+CbX9kCUcSCnTDVkftiBf7nmMJP20kropHG+NpS/ZMQFjRkGmFWhULRTs9gv+hd/CL+VnoJMd4MjilG7cagzQiko4Xy2PQ7oB6ccjnd7/xfIK9QsJgrF7jqS/f/3sWDP0Vlr/ZJSafBVL2HdaNXx0fDBdwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669856; c=relaxed/simple;
	bh=kexfarjzejzZFUHIPhJpsYiNO/LSGFHIH2aNlAnn114=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=em9OeeIyiprFRwueGt1BezPWoh+V13l/7dGOCv3jQ3vS4tesYI45XxTLlBQjcmBqBjp6j0QogMnfocnchC+XyOlDuyyj+52Ol4qQl/xlA+bRyRfB9XctV9/u6PVOU+/ygxDYIxReu+TAXwPyaPWylgEp/uJG0ilT7qo0uV8XKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUdDmjLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUdDmjLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFF1F00899;
	Tue, 29 Sep 2026 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669855;
	bh=dduiStRJ9velt9zhEc0zRfvY4vXTeL28uVPYW3/nBAQ=;
	h=Subject:To:Cc:From:Date;
	b=PUdDmjLzjLXxsuFX/Kj7ljbHqxx2WLbb9ebRX++L4GDyGwZo3T10LLklbLAiMtTxc
	 aTSCQxEp3xi8wXtq4J1VrjDBEMCX+PYYB2TAiQQ+cNd9l/xF2/cAz2/Wzxew7gtEyW
	 ZFptR5Ps33q+L3JvhnupoZ0tr3aM/BXqH2Brqp24=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix dc stream excess put in" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:17:29 +0200
Message-ID: <2026092929-evade-cling-0497@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c5fd4eaad50d620c7e09ac2082b2fb55ee54170e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092929-evade-cling-0497@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

