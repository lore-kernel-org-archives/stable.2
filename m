Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC83D7D8D;
	Sun, 18 Oct 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348174; cv=none; b=tmaXIjybN3w8dhVPWSJY0DHJaUok9nWwF98RiHLo7Obpu7Tvr8GOAak9FY3vr/xE8LvlZIXIEg8v7GG9sN9hesTu83c2EFX6NGlc3jVPz8m3wOpkyPWKcaev5/Z6Wjf3MlzwrIr6QXPhDPSm1w45/uf+2hTJdweh+r7/Xe5+e98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348174; c=relaxed/simple;
	bh=Vl3tdMyMwe/I+x3N6QbrwknBSVKJP09DniWkB0JmIq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q/8O0m4fmIKfn1t/bP5PtXr5kDeEgxgFdU8hpAOJMU1PGDDHrUZpn0YqJ1LR+97gs2nmcsKHqDRFX2FAjQFsfyaiXhxUgcr9wqWCtkcsZ8JjodUeBKugIHWyRws15+NcLi1v3eD9ixGulcHivkfPlwhMhh9ihNSEDpk/V8S5Hiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB4MSuel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB4MSuel"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3403C2BCC7;
	Sun, 18 Oct 2026 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792348174;
	bh=Vl3tdMyMwe/I+x3N6QbrwknBSVKJP09DniWkB0JmIq8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qB4MSuelJMTHPzi+7eRtiMUD969zk4mODI2azEO0T4FN3oCPLKBowk+seeKSujpUp
	 7CkaOg5s/zLvSsYKgosGMO2U/TesOTboTcBRZ5ldHpfJaH2yEcdCuZ3Gzh+MGCcUVi
	 7cjEwOaqUdvhW6Eb08bTz20weszYlTZe8gM9fHLrbpOVHneZDxq3hR8d0LzWEg5Vco
	 BbzNthOmrFIUZGlxosesGmo7WsLWobkbkIO4igGEl3rJPY/7HU/tlKB2jBYXZQZXp0
	 4MiLUw6XccPPb+yPhxQDQ5uV7JzOoLtcHBPs+44PDWQJb6Q6xCcmL/k+CNVI2vWTYQ
	 A9SOgZNndSWyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE54CCF2C9;
	Sun, 18 Oct 2026 18:29:33 +0000 (UTC)
From: Mohammed AlHashim via B4 Relay <devnull+eng.m7mdhashim.1.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 21:29:32 +0300
Subject: [PATCH] drm/msm/a6xx: Don't set GPU freq before the GMU freq table
 is built
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgLJHQq5QuYpzEEWJ1pikF8
 e5N6/It/t9BSZgUbs0OQm9Wfi4V5tJAmPySCHmshq7tetMah1kzplwwCm2YipcRyfrgrtaZOFi
 o4SoU+fOf3h+ntQwzhdfvBMfxBbuZL5F2AAAA
X-Change-ID: 20261018-msm-gmu-freq-guard-e5ac83581fb5
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792348172; l=4160;
 i=eng.m7mdhashim.1@gmail.com; s=20261018; h=from:subject:message-id;
 bh=4u668IecDd1UekaSTwsKFOC3XIkk1vPT8fcmnCTf8Hk=;
 b=uJCnknCpmYyjxARyh20Jf9ipZVqQKQNP+stUYUqzspq+FIqGyzszrghTb9KDeTefvvSRYScFW
 VXemMVvY6b6DlN7D6aTi9gM9Fk9gPikey3/VkBcBwpEeO/37UyQtp+U
X-Developer-Key: i=eng.m7mdhashim.1@gmail.com; a=ed25519;
 pk=nadicxm5lJrpr6u2tkxbYV+wi8bWOYqheGU3HolXoXA=
X-Endpoint-Received: by B4 Relay for eng.m7mdhashim.1@gmail.com/20261018
 with auth_id=1228
X-Original-From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
Reply-To: eng.m7mdhashim.1@gmail.com

From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>

a6xx_gpu_init() registers devfreq through adreno_gpu_init() ->
msm_gpu_init() -> msm_devfreq_init(), and only afterwards calls
a6xx_gmu_init(), which fills gmu->gpu_freqs[] and sets
gmu->nr_gpu_freqs. The devfreq sysfs node is visible in that window,
so a write to min_freq or max_freq can reach a6xx_gmu_set_freq() while
nr_gpu_freqs is still 0.

The lookup loop then compares a u32 perf_index against
gmu->nr_gpu_freqs - 1. With a count of 0 the bound converts to
UINT_MAX, so the loop reads past the end of gpu_freqs[] until it hits
unmapped memory. It faults with devfreq's lock held, so every later
GPU user blocks and the machine hangs.

This was hit at boot on an X1P42100 (Adreno X1-45) laptop, where a udev
rule wrote min_freq as soon as the devfreq device appeared:

  Unable to handle kernel paging request at virtual address ffff000b80000000
  Internal error: Oops: 0000000096000005 [#1]  SMP
  CPU: 0 UID: 0 PID: 487 Comm: (udev-worker) Tainted: G        W  O
  Hardware name: SAMSUNG ELECTRONICS CO., LTD. Galaxy Book4 Edge/NP750XQA-KB2US
  pc : a6xx_gmu_set_freq+0x74/0x2a0 [msm]
  lr : a6xx_gmu_set_freq+0x3c/0x2a0 [msm]
  ...
  x4 : 00000000ffffffff ...

x4 holds the wrapped loop bound. The faulting address is 1 GiB
aligned, which matches a linear read running off the end of the
linear map.

Return early while the table is empty. The request is not lost: the
limit is kept as a PM QoS request, and devfreq applies it the next time
it re-evaluates its target, for example when the GPU resumes. The root
cause is the init ordering, and registering devfreq after
a6xx_gmu_init() would also close the window. This guard is the smaller
change and is easy to backport.

Fixes: a2c3c0a54d4c ("drm/msm/a6xx: Add devfreq support for a6xx")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
---
How this was found and tested:

- Seen twice at boot (2026-10-03 and 2026-10-05) on a Samsung Galaxy
  Book4 Edge 15" (NP750XQA, X1P42100 / Adreno X1-45) running a
  downstream 7.2.7 tree with an out-of-tree device tree. Both oopses
  were at a6xx_gmu_set_freq+0x74, about 9 s after power-on, from a udev
  rule writing min_freq when the devfreq device appeared. The log ends
  at "Call trace:" because the machine hung.
- With this guard applied to the same downstream tree, the laptop has
  booted 20 times since 2026-10-14 with no oops. That shows the guard
  does no harm. It does not prove it closes the race, because the udev
  rule was moved to a delayed systemd unit on 2026-10-06 and the window
  is narrow.
- On v7.3-rc7 the change is only build-tested (arm64 defconfig, W=1).
  It has not been run on mainline or msm-next. The function is
  identical in v7.3-rc7, msm-next and msm-fixes, so it should apply to
  any of them.

If you'd rather fix the ordering, so devfreq is registered after
a6xx_gmu_init(), I'm happy to rework it that way.

AI disclosure: an LLM coding assistant helped read the oops, trace the
init ordering and draft this commit message. I reviewed the result,
tested it as described above, and take responsibility for it.
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6d49c51df..b1cbe5d34 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -164,6 +164,14 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 	unsigned long gpu_freq;
 	int ret = 0;
 
+	/*
+	 * devfreq is registered before a6xx_gmu_init() builds the freq table,
+	 * so a min_freq write can land here with nr_gpu_freqs == 0. The u32
+	 * bound below would then wrap to UINT_MAX and walk off gpu_freqs[].
+	 */
+	if (!gmu->nr_gpu_freqs)
+		return;
+
 	gpu_freq = dev_pm_opp_get_freq(opp);
 
 	if (gpu_freq == gmu->freq)

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261018-msm-gmu-freq-guard-e5ac83581fb5

Best regards,
--  
Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>


