Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107548;
	b=3rRTUiMqhQHHRoyy5tSWGqUPIGb5luxhrZz/Q3aC+XFJojZcj66lQqrjA3TYGAtDV5il
	 FWR2khwmTq6vjxCV/vNPhIzyo/buiiHf7T+81yFJviyXgaPGy+ge82Msd7rxar6kAAb9U
	 t0azZvLdOl3eAXxZAetxJn5JFLF4A9DDODingOR88yqgqL95WUygFLeTiyy4+QL4P2N2u
	 EBxyl0Yafb1B2vBJXjqPU6qgCYIgRWYzO312/7DQgsVP/a9raD/C1zCDJhaa9h8ZRgxmR
	 lWbQH3LJe/I7kaz/veoNB+Etiyc8Rf6ViIMe6FPVgJ5MZjlPMf+5SyVCA3UrBNhfs2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107548;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LlI0HnHoMCCLXfPSHdDu0xtCDvO48aQt+TBZk1KY3bE=;
	b=PXbycalbe26LYb9aCbML3RyXjzkjNl0YlQeLfpt7rkVu2Y7WBUuQH3hBw7cU6raZPmRP
	 FIJHwVfBe/sS7dM5xGG11xluDdYLfPOuONWfjI5zkGWHPdwIwgi1xpddjDzb6rexgvTIT
	 pKObCtPxYGO1Cq3zSprg5K3cOYsry0/7hSg1ElEhVdBuEeFkHlGvJeX6SMo1RN/d7+IHH
	 3t82f2YQgN4QADKBUHLWU7T/o8vQrpev3MiBh3jaYVqhNdfnw5PpYH756Zf7nx47SUlBr
	 qDG5o9m6zRO2Mc+JPxS2QbsYRuYvHwVz4gkhhkHQTyAM82euutDK+we7/S+efZBrh3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojtk3uV5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8C606A31A;
	Tue, 27 Oct 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojtk3uV5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793107547;
	b=sbmqxK7xZYycNaCwOVG3mrLPZylx0RBE/48muUOnToYI/f7jvtHoEJrvu/mUuyAA7bXa
	 L13kOhMA+qa1Gfe+AzfTxzJLeiQ8cUyJnkh6xK5ud4IxciLI9oETUXHNOdaEwJnqv7AaR
	 MMHBVDo+jgoYEXASdXa2zxHUL8c+uctTahKwnStHUEzbme9jMbfvDzwAQpjHzMgsBLSEv
	 HK4RKfH2GcCb+04uqTCsw0NlEE/H8GHHuFpQHGy3xABQOIRG08NnuIXzOzNOEzKcqy3ji
	 eAxI7atRtmDzimPL193IcNj62sIYpfsimiyfwau7GFU4N7LezDWpZZZEg7fkYMpyf7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793107547;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LlI0HnHoMCCLXfPSHdDu0xtCDvO48aQt+TBZk1KY3bE=;
	b=FagrTQWiv/+3ubd0wLqOq9/XgylJEg5L3eqv8j5ZbwDrWVMjKo/BLNEKMH9PxWdjm6DE
	 MRWLV+FL8XXINTQZitx7q9Kc1j4homBhlFfNgXmbw4T2vf+dGQxbfs6COViDikfzwlX4R
	 L5otlBGbAk9Up8cGaGoidB40d6n3I2c7XSnHb689E3zYFI7WEnLEuv9+xX5OpQb7ZWeyK
	 NlRoiwM//1C44u+nBH3Wkq9RlYPdmvmUhyZdWa44EXQesWaqrdha0R+njo3SKSVTkHPgu
	 5M1vf+e9aHSAf40EnJle1bRFV22ozQOSIRNDh2RU1SZgZZHJWSc3N+HvbSxnHN4+Erg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFD3C1F01828;
	Tue, 27 Oct 2026 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107547;
	bh=LlI0HnHoMCCLXfPSHdDu0xtCDvO48aQt+TBZk1KY3bE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ojtk3uV515X5U7Z+WPHYUPouTp+ShVFjQu5kza+hfNaeC3pMQ8q/WgZ5UbSVR9N/V
	 jcM96QAlw7A7sl2lKILeSAUPKQOxhQM7OE4bq3kbsTNA84sKNVfIxzczRQ0Gt7pvRF
	 1y9U9yI+ZUR09MLpOV5B3laK638gjusG1lVnhu1FvaKjGV6NYbCEahPKVR6JRj/thc
	 cBi3AHRnwJKSwzgYlewAQd0sDnlGN0lLBjuzZ84jxSJkYB1NsyWyzA0lbXPr2Kxzp9
	 9AQ+mWjCvHv2A8FK9yMpvkXxTiW77uXYeYbeF2jWaa+xjCIkmsaxggdXVYW+PjML9D
	 M1MmitNMtgbDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 67B37450F1;
	Tue, 27 Oct 2026 13:25:46 +0000 (UTC)
From: Davey Hughes via B4 Relay <devnull+davidralphhughes.gmail.com@kernel.org>
Subject: [PATCH 0/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
Date: Tue, 27 Oct 2026 06:25:41 -0700
Message-Id: <20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSwqDQBAFryKzToMKKuQqIYv5PLVD7Ej3GAzi3
 aPJsh6vanMGZZi7FptTvNn4JQdUl8LF0csA4nSwq8u6rcq6o14B+0ik+ekFpDBkyjyBmhTapgN
 Cn+AOf1b0vP7at/ufbQkPxHwGz0fwBgrqJY7n5KdElv3AMlDSiQRrdvv+BdtdqgKkAAAA
X-Change-ID: 20261027-freesync-plane-reset-time-5db657eebfde
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Davey Hughes <davidralphhughes@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793107546; l=2402;
 i=davidralphhughes@gmail.com; s=20261027; h=from:subject:message-id;
 bh=M+DZ/4MREFoDeqfd5AyQ7NWyYn34LU0wEP8MyQ0a5GQ=;
 b=woN098BUqPny0RXZKqbrSrIFeSVa4OTgkH7fgZG3uzRKIV8zDOAzHV49KeHKIGUnRvNtUibD1
 IBDxJt/w+y3C2WkZEZc90k+5hae0yScGDGDF/J9Ond3OVnJ5Bq44Txk
X-Developer-Key: i=davidralphhughes@gmail.com; a=ed25519;
 pk=y45yWVxpjjxFE2cXy96fGlXLfDlt6UKHFHS5szhrFAs=
X-Endpoint-Received: by B4 Relay for davidralphhughes@gmail.com/20261027
 with auth_id=1335
X-Original-From: Davey Hughes <davidralphhughes@gmail.com>
Reply-To: davidralphhughes@gmail.com

On a 48-165 Hz FreeSync panel, fullscreen clients under KWin with HDR
enabled and color accuracy set to "Prefer efficiency" run at about 51
fps instead of 60, with flips locked to the 13.45 ms BTR mid-point
grid. That grid drifts upward at the rate expected if FreeSync takes
the 32-bit microsecond timestamp itself as the last render time (3.46
us/s measured, 3.45 predicted).

KWin replaces the CRTC GAMMA_LUT blob on every commit in that mode, so
every flip resets the plane and the new DC plane starts with zeroed
flip timing. Patch 1 carries the timing over from the old DC plane, as
DM already does for flip_addr
(amdgpu_dm_plane_drm_plane_duplicate_state()) and for the BTR state
itself (dm_irq_params.vrr_params). Patch 2 adds KUnit tests, kept
separate so patch 1 backports to stable trees without the KUnit
infrastructure.

Tested with KUnit (UML, all AMD display suites pass; the new timing
tests fail without the fix) and on 7.2.11 with a Navi 31, an AW3423DWF
over DP, KWin 6.8.1 and Mesa 26.2.5: 60 fps content now flips at a
steady 16.65 ms instead of on the 13.45 ms grid, 30 fps content still
gets BTR (steady 33.2 ms), and debugfs shows color_mgmt_changed=1 on
the CRTC in every sampled commit. Not tested: DCE, overlay planes,
other compositors.

Open question: the copy happens in atomic check, so a blocking commit
that resets the plane while a flip is still in flight can copy timing
that is one flip old (at most one BTR frame). Copying in
amdgpu_dm_commit_planes() before the preflip would avoid that; I can
send it as v2 if you prefer.

I am not sure of the current AI disclosure policy, but I will freely
mention that I used Claude Opus 5.5 to help debug and write this patch +
tests. I have tried to do my best to match existing style/procedures.

---
Davey Hughes (2):
      drm/amd/display: Keep FreeSync flip timing across plane resets
      drm/amd/display: Test FreeSync flip timing across plane resets

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   3 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 190 +++++++++++++++++++++
 3 files changed, 210 insertions(+)
---
base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
change-id: 20261027-freesync-plane-reset-time-5db657eebfde

Best regards,
--  
Davey Hughes <davidralphhughes@gmail.com>


