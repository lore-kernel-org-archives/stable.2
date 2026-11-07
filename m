Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051011;
	b=IhdXGlgUcB0klHjW/1gu6k8nPgBnmqJwIg50rGCJ+5PLbLnvxNaKRPJp6n0KICion/Kw
	 rkQe7Fqow6E9yzkthHVkzS3XyPfjshrJkXr7HAlcLaXbhiy5kQh9KVkFykGMepKbj44Zz
	 uKkuREFwBjaWQrDFFgfPzqoLQDGz5DNKGr4KJXHTsBFTdXYuJibHnwXd8RpwwZ5eKzbjE
	 87mMITd1neB+6XCGd3SUgOYKin+0CguujKBPf71BYXxhKop4GVJQNesxtenoUyCeBZjKx
	 NQ6DCVuFr0sOT3bnmxi1xUx4+hHsgPZx6sSzag9pCEc+GnAzhwudZD4Vy5Nvyk41p+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8KZF/qUdi1a8ven1qwoWQCbEUPa1vM4lmtQp3bhtUbs=;
	b=r3lPCuwNQW5V1xj7cjjzBGEkGVixurYwQqLYQFIR5g/w9YpaR26qoG2WpJpeCDZ2ovQq
	 si43OG0IA5K5ej7W+FJ41/iyM8Lvls+8FdfNqLxvArhEoprUEgo42Q9CbjpHLXNby/pL2
	 0KdgnbOUqSDjEj9nxVDIpk7vtaygtyxFt19chuHqlnxp3DW20DbZiiB0csOlTK1FGVgDK
	 GS1K5uaQhN9fLmztYuEssesrxkFtjallWvDE0XScU6uBaNY0nf1SW4DWXTvhJHd6hysD9
	 OA7/uiFYYG03YdwzpESn0LSk5C7ep75NLqdCCXUjGp5Vd0LFRvFc1Nt8qUK8+xC4R2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nA6f1J+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nA6f1J+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53E51F0089F;
	Sat,  7 Nov 2026 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051011;
	bh=8KZF/qUdi1a8ven1qwoWQCbEUPa1vM4lmtQp3bhtUbs=;
	h=From:To:Cc:Subject:Date;
	b=nA6f1J+WLM1zrHMJiC2+tL8jMlABv8UjOQxuLwsql09Ci85GME989AASykLlGQLLn
	 XgOTPOCxj5v8zrbESM1PFhKTYnzQTV7/9LmroIoZrRaOeL/rfuDb5lJkwG2DsjOlV+
	 LDg5kaTAkiSNwJK1JdD/tMpnnn1MGnf4AEc3u+8BvwLlWXSR4pmw6wtq282oeSzbjt
	 C5GrFxTebz9fi+cUr+2zTF5FFjaGJ4HvXziyfVJfI8PUGXWn/AEkfZX4k2uWqMwCjx
	 AKInsgv/pj/jpVGV+ArG0Kmmw7SgkTvtH3YMtlFmcs2pfE3/wdSh4hcksZF0QorclB
	 IND6PFnsw9kNw==
From: Sasha Levin <sashal@kernel.org>
To: luigi.lauro@gmail.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: take a runtime PM reference only when a CRTC turns on" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:09 -0500
Message-ID: <20261107063009-failed-5.10-b456f591f925@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b456f591f925fbd6b33770d0eec1b51c2f9d41c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063009-failed-5.10-b456f591f925@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b456f591f925fbd6b33770d0eec1b51c2f9d41c1 Mon Sep 17 00:00:00 2001
From: Luigi Lauro <luigi.lauro@gmail.com>
Date: Fri, 16 Oct 2026 05:16:36 +0200
Subject: [PATCH] drm/amd/display: take a runtime PM reference only when a CRTC
 turns on

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
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b634ae07c0d2..caa5edcf1bc31 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4709,8 +4709,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
 
-			pm_runtime_get_noresume(dev->dev);
-
 			acrtc->enabled = true;
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
@@ -5294,8 +5292,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 #ifdef CONFIG_DEBUG_FS
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
 #endif
-		/* Count number of newly disabled CRTCs for dropping PM refs later. */
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




