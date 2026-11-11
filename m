Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439844;
	b=h2pxqv3oyZki6EWrYNIDm9VTBvhePuK6NRap0PejlYt/oOTrFT2yOVxH9FW3B9mBNmI4
	 bJiyVwS1z/bSeGGqXR/3y4BWQAYe7N5+mlqDNIw5jvJAnn3jeZ5pLf8Dp+oWfQmXWI3C9
	 A0sEszZ2ALQaCu7gUsYPPrmos2gLposHT8/HzbvIKM0TuShZWw8Xjnha3wCpA2bYRdPD/
	 xDElhyBAPDa8H+QfLHUyHa2NPB07VqSdOQ13RLPCAI75gdvYu2+f/c0FahCChN7c92Fn7
	 2oOyHar8r3TV5FJCByEk6xDHzv1gl2wmnKWGcwXDfXDmrz+asn0WRwxaRYz9Lp7QqtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ju1AwsKnsOCS2ejLrmvPaaB+BlxjV9fnAuRbW1WmjvU=;
	b=cdJ03BHq5pWMkZm1QYMpo7nNbGjepo/JhE0JnZcefpz1uZXaDWuVeHUsp5IxpVKdiiOX
	 YULuCrGQ0ehE9jxhV2FD9kDilb6jqpsc/6wTP5qydeT56yFu793AcaEIN5ptEWEXk2fl4
	 NrRe4ZA3tbcctowLfBfAoiS6Aq2DX+EWRtR8i1IOxcAuulJcc5CKk110pcXW+a9SUtWnC
	 PzdJ2rxLkh/Px1EiHuxr8DwnvlYbJEWRNGk4LOh0evMn78W18sxJVBPKvw9gmCE/0l/MP
	 9kg9Sm4Hx+ncwYigoVQdwyOeEjRo8zzLhVwuBzHaQ/iiQhymRk2C9tLez5Uc4ETa7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KV97HwuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC7606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KV97HwuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03111F00A0B;
	Wed, 11 Nov 2026 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439844;
	bh=ju1AwsKnsOCS2ejLrmvPaaB+BlxjV9fnAuRbW1WmjvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KV97HwuYo61op2dBvlT6SkXT+whY9i807aCjyqCYyzUnLBhLqQ1c/C1i+hSv7RIZF
	 zFCE+rqQUvoG40QX0lvzUsIhoiyAgKPPtEvlwCpSZfKReWSKpBQmiM5tYgVdDWq2Nm
	 xRzX2Y3p8Hdse+WJoFhhbZEyPsnTIF6sXkPSjXKWLwgk1VywThV8Hz7h6DI9xHzEOl
	 nJkY50RLwULn3GhHY6fTw366La+S92MFPiJ7h2/pfWEciWst/4PoFf+rduATtddgi0
	 DX+NWeBNB7C0lPyWeJm+zGun4PIo8CT+mFoaK3Ce6qZn5Hzv9FI5ZY8ZeH8IKPLUSl
	 48NgYU7l3v2Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Calvin Owens <calvin@wbinvd.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"
Date: Wed, 11 Nov 2026 18:30:41 -0500
Message-ID: <20261111233031.397897-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111233031.397897-1-sashal@kernel.org>
References: <20261109200203-failed-7.3-5b3717a14ef6@kernel.org>
 <20261111233031.397897-1-sashal@kernel.org>
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

From: Calvin Owens <calvin@wbinvd.org>

[ Upstream commit 5b3717a14ef602c961a4abeb2ce8039f0394bebb ]

After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
the screen. It reproduces sporadically, but at times it is so bad the
machine is more or less unusable.

The garbage is always horizontal bars extending across the entire
screen, always approximately 200 pixels tall on a 3840x2160 screen,
for what looks like a single frame. The bars are mostly black, but will
sometimes exhibit striping and periodic artifacts which smell like
non-framebuffer data is being rendered to the screen.

It took some patience on the "good" side, but I was able to nail it down
to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:

  bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
  good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
  good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
  bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
  bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
  good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include amdgpu_video_codecs.h only where needed
  bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix aperture mapping leak"
  bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test plane colorop helper walkers
  good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test helper_check_state rejects
  bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP block NULL check during soft reset
  bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
  bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit LS for ISHARP before coefficient write
  bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KUnit test for wb jobs
  bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove unused dcn42 socbb values
  good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix VABC Init and OLED Support
  bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
  first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT

Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
of v7.3 completely and totally eliminates the problem for me.

Mikhail has separately reported this regression:

  https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/

...but it seems to be much more consistent for me than for Mikhail, it's
never taken more than 30 minutes even when the machine is completely
idle. I've also never been able to reproduce any artifact one single
time without commit a637a140, despite a lot of effort.

I'm not sure reverting this is the right way forward, since presumably
this would re-regress the timing issue Fangzhi alluded to in the
original commit. But nobody has proposed anything concrete yet... so
let's start the discussion here.

I'm happy to help test other better ideas as well :)

Fixes: a637a140ab86 ("drm/amd/display: Allocate DCN32/1 dmub memory to GTT")
Closes: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 899489d2e2aa854cf5e933677d6561dfcbb94529)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 440759cd456e6..47c20eaa31a1b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -513,7 +513,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
-	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -650,19 +649,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	/* Limit to allocate dmub to GTT on DCN32/1
-	 * TODO: Other asics with GDDR7 may have worse latency
-	 */
-	if (dmub_asic != DMUB_ASIC_DCN32 &&
-	    dmub_asic != DMUB_ASIC_DCN321)
-		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
-
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = dmub_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				  mem_domain,
+				  AMDGPU_GEM_DOMAIN_VRAM |
+				  AMDGPU_GEM_DOMAIN_GTT,
 				  &adev->dm.dmub_bo,
 				  &adev->dm.dmub_bo_gpu_addr,
 				  &adev->dm.dmub_bo_cpu_addr);
-- 
2.53.0

