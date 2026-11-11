Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361065;
	b=FIBB/BJPYnTy/VSbaQ3DOtfXM+kRqY18uGe16dbIiEh3Yho/4ZV4IoQPS7hx0a23BSFM
	 Ny8IuX37PKGceQUgdVsddpW0y6iX9vzxp3SpWGUtFT+BqiAZ36kKHhTHkYw/np6Qy1HBh
	 Z15exZvskecWHn4mJguNwoDqjJjB4I9G2bz/iVzA7GnEIWEA1YJaJoFFVj9Sz/QPdoH2n
	 Z3dWP7uyg3Q/VCweer/2BX4smm0ZCmjsqBsoOJqhQ4vKVQxP7dWVPTEzcrrA3FKQEuvs3
	 bNJn4X7RCCljHmcf8JZruFp+uvMHtIMU764DfaY9LbqmOvU4Azhr5rTPiN1WWCu/Qsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=92U1ObWkaGVpc+cOjyrtLLDbna3r7gbnqMIKO/5ousM=;
	b=YVSN3+fXdlmVUXgXnq8E5lXfo3zJ98K3FknlDft8Bxl16iXwzM0OQY5rtaJBXqQnux7c
	 Tfj80odMQ9WkzGUTxjQIHmvndpxvMpUfrnRMMYVmRzJGGh48798AzIOc6ro7Uw/ym7NTn
	 5sgE6FZbh13uNbQJE9uO1MJv+el6lzIkO/33MSbwhHWwcRDHVfvdTTlBnVqilJuNArRLQ
	 T1NTF/E0bZRNldssuX8ybZ317kTPJfyk9xivec2DHFpmYzE6PyhVo1AqSjMk/hsZNssdX
	 pXyhriKFPRP3z5wl/O262JF5Q8NA6KNtMQvWWn0XJ/xNfPC7nZbIiP8KtgIlrCaZSRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYPqKbnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19502606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYPqKbnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3227C1F0089F;
	Wed, 11 Nov 2026 01:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361064;
	bh=92U1ObWkaGVpc+cOjyrtLLDbna3r7gbnqMIKO/5ousM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYPqKbnSKUCVqbTID6tFuiIHdnRWoA3Bn3wKGP6wU8JfVmLw/MqEXmvbLUVf73SvT
	 YJQsa2TJwebme4aE0ACkbsOuxVxnH7/vKeTGBrJTvYj3rC4nYfVONZ8dYTVC1lHoJV
	 EaYdJjfbLvNp3ZLxjPcwhj6o7txLVF3LyHw5S8qeYxI5JFW1gdNCDDQs68OrpxDgq/
	 lBK7magIYIBk2gT2l7A6Vl2t/WvnF8pRtDWqj97B+eIXWFk96NV/I9Gj1D5vvOf8BW
	 14qWOFk+O5EzDK5a1QR+CkpOOmrahe6lLAyt3VkfGNtYkOHMmLP8lOsnrssiRImDAU
	 x02U+GF1TLnlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luigi Lauro <luigi.lauro@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: take a runtime PM reference only when a CRTC turns on
Date: Tue, 10 Nov 2026 20:37:43 -0500
Message-ID: <20261111013634.93006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063009-failed-5.10-b456f591f925@kernel.org>
References: <20261107063009-failed-5.10-b456f591f925@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luigi Lauro <luigi.lauro@gmail.com>

[ Upstream commit b456f591f925fbd6b33770d0eec1b51c2f9d41c1 ]

amdgpu_dm_commit_streams() takes a runtime PM reference for every
active CRTC that needs a modeset and has a new stream, but
amdgpu_dm_atomic_commit_tail() drops one only for each CRTC that goes
from active to inactive. A modeset of a CRTC that is already active (a
mode change, or anything else that needs a full modeset) therefore
leaks one reference. Once that has happened, the usage count no longer
returns to zero with every CRTC off, and the device cannot runtime
suspend again until reboot. The two also disagree the other way when a
CRTC turns on without a stream ("Failed to create new stream"): no
reference is taken, but one is dropped when it turns off.

Take the reference in the loop that counts the disabled CRTCs, on the
mirror condition: when the CRTC goes from inactive to active, which is
what the commit that added it intended ("every time we enable a
previously disabled CRTC"). Each active CRTC then holds exactly one
reference.

Tested on an RX 9070 XT (Navi 48) over OCuLink, with the change
backported to 7.2.9: an unplugged connector forced on, then mode A on a
CRTC, mode B on the same active CRTC, and the CRTC off, three rounds in
a row. The usage count rose by 3 with the stock module, by 0 with this
patch, and by 3 again after reloading the stock module.

Fixes: 97028037a38a ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5951
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 59ef9a435499777b8e1c4e0eff52f813c64fb920)
Cc: stable@vger.kernel.org
[ sashal: adapted the patch to the separate PM-accounting loop in amdgpu_dm_atomic_commit_tail() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3b37aca3781e4..43ad2fa2bafdb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7825,8 +7825,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
 
-			pm_runtime_get_noresume(dev->dev);
-
 			acrtc->enabled = true;
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
@@ -7979,10 +7977,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
-	/* Count number of newly disabled CRTCs for dropping PM refs later. */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
-		if (old_crtc_state->active && !new_crtc_state->active)
+		/*
+		 * One runtime PM reference per active CRTC: take it when the
+		 * CRTC turns on, count it when it turns off for dropping later.
+		 */
+		if (!old_crtc_state->active && new_crtc_state->active)
+			pm_runtime_get_noresume(dev->dev);
+		else if (old_crtc_state->active && !new_crtc_state->active)
 			crtc_disable_count++;
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-- 
2.53.0

