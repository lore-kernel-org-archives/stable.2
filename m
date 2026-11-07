Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050779;
	b=2VfkjycmwPVElBaqCqb3nB3op268rwR6QBE0I/0b9UlCNswaIG817VEK1XgevXqwXiwp
	 X8ArsR0Q688/3jff9MGudxbgZcAVxSkEYQg0yZBS/kr01kmyJY0Ig391udtiK9gekDfZ2
	 FbibZ9CBwYg9JtXxjw36qwr4CqhvndEJYLuuGmHaOEwGM/U7Og2QWrXZK/7RmKe3XgvPG
	 pZribNBYFBSokRE8OaByIn2U+xeAaKVJj/YO6R15hxSKTToBnKKdcrUfLeIrhGzg8psII
	 QSUm8jcjp3IsSJfc87WOPEj41uZ5/4w+qHnuFBxDlDxIHSRZumj6eemDpt5LHxtRPeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050779;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tV2mhpbg7Q/ffacRVX0Funjqt5qzccJ+s+dF5AxjMBA=;
	b=KLVGxH2eupfwr7uQsOKBysSsNObat34rSLWDjhPsiFloQX5SbUsj4Zb7d23pSc9+Xk3M
	 1BKlf8ojxp8eXEYSsD58U4Atj73MKkZtjcMhayRQUPue53OV3nQiS/0QxuS2I4VA5l9g8
	 KgpyAPk/E8A7dFLv0U/opNrRJmGcoWv+sj0Rk5+fW69Gad5P5Ck3uxWyORUsv68Xun2/0
	 c/+MGKeHU1p3RHYKEq5Pm7weaY7EYSuLpiAc+RfTTI6n16kA+YLUtFouc8vgL+ewxvU1m
	 qbeYdc8YpEQ7ab0tX5wCOGHM3Ene0Rcpe/ywZoELFLyRYXvWbhO1cqdludRtgpyMXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDbzOY1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB43606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDbzOY1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2811F0089F;
	Sat,  7 Nov 2026 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050779;
	bh=tV2mhpbg7Q/ffacRVX0Funjqt5qzccJ+s+dF5AxjMBA=;
	h=From:To:Cc:Subject:Date;
	b=MDbzOY1BKlVx2MkvbCc2G8fBR5DUEgJZkB8dZ/qxy0u+n9ambap/8bCSskvP/jIcK
	 fvzhbEKpCTwlB66G8bspUToWjysIu6VSubfR0MTmGmRWVd2IC+eMbsS2ugqLVDdjs0
	 ee5rN6QQCCvpHzpYdas5Wep5GABbgAa+FFDvgHmeYSUjjFVhABEGHuwpyv1JW1sFCS
	 punqpBEZXEr3NIvI1IV7blZlgnfKxNV1yBGu5SmcbR8PaESisC1tdw8NPHaTLrYmX9
	 +HvwJKEnXufu4KZBTsTDDc4FzYV8mIzGTXvV/8GSTveghzrc3hibHrFNEkkOldIHdb
	 LDE8FRHKV0x4g==
From: Sasha Levin <sashal@kernel.org>
To: luigi.lauro@gmail.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: require _PR3 for BOCO" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:17 -0500
Message-ID: <20261107062617-failed-5.10-28f3d169f162@kernel.org>
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
git cherry-pick -x 28f3d169f162ca7e803c5a1f7e1bb55bdc915d1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062617-failed-5.10-28f3d169f162@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 28f3d169f162ca7e803c5a1f7e1bb55bdc915d1c Mon Sep 17 00:00:00 2001
From: Luigi Lauro <luigi.lauro@gmail.com>
Date: Wed, 14 Oct 2026 15:33:56 +0200
Subject: [PATCH] drm/amdgpu: require _PR3 for BOCO

amdgpu_device_supports_boco() returns true for an AMD_IS_PX device on a
system with a hybrid ATPX method even when the device has no ACPI power
resource (_PR3). On an APU mini PC with a discrete GPU attached over
OCuLink, the iGPU's ATPX method reports hybrid graphics, the dGPU is
flagged AMD_IS_PX, and runtime PM in auto mode picks BOCO:

  amdgpu: ATPX Hybrid Graphics
  amdgpu 0000:c6:00.0: Using BOCO for runtime pm

In BOCO mode the driver leaves powering the device off to the PCI core,
which can only do it through _PR3 on the upstream bridge. No device on
this dGPU's path has _PR3, so when it runtime suspends the card stays
powered, with its fans at about 700 rpm.

Require has_pr3 for BOCO, as the function's description ("dGPU with ACPI
power resources") says. The same card then picks BACO, which powers it
down:

  amdgpu 0000:c6:00.0: Using BACO for runtime pm

This only changes systems with a hybrid ATPX method and no _PR3 on the
dGPU's upstream bridge, where BOCO cannot cut the power today. Tested on
one such system only, an RX 9070 XT (Navi 48) over OCuLink with a Ryzen
AI 9 HX 470, with the change backported to 7.2.9: the stock module logs
"Using BOCO", the patched one "Using BACO"; BACO runtime suspend powers
the card off and it resumes cleanly. Not tested on a hybrid laptop or a
Thunderbolt eGPU.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5980
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1a039805354a44aab7abb2a6e685212d48b17a5e)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 48279392d385a..866e83de950d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -593,10 +593,8 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	if (adev->has_pr3 ||
-	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
-		return true;
-	return false;
+	/* BOCO needs a platform power resource (_PR3) to cut the power */
+	return adev->has_pr3;
 }
 
 /**
-- 
2.53.0




