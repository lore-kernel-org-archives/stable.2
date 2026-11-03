Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734094;
	b=NmFX806/D1TgPbOIgukduuHnKvawoAnGh4WfnFAsxY6IvSgDknA+AQQ7iBuSK/GCavih
	 ZAGcGnacIUBTIS5fZgh+IYm3d4RBocO9EOfK0FN8DoodtLCZB/5egbX9fhl+qR7p9fGkl
	 bazm8Oid/3ZkcJ6vB5N+mx6PlU93iVvTnL2Cz3anvQwIvBpNv/ygaU77rcKRH9SSKOGw3
	 xMZZM9Ct/iRsxSnDt2/T6Oh2JLhc6BP36Ber0ytTE/XyET6jG5MjfPrk9Ei6dia66/rLp
	 F9ZoZkV8maEvy5KbmiVMQKCzNPQ4/9j3HU5bBE30J7JnXzTs+zyEjpGzN1fW/BCqqYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734094;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=pIO5Ryz18Of2q0V5iO2sOf+bcL5Shl0sK76L+mPdroE=;
	b=luTQ2atG4dvdgyGfVSvoMi1BPu1OuZk0WqqfpBHE/tFWM4UNLLZqCdmFx8ayQrTE5cOH
	 PhaFvABMx6/otDLMVaNhOrmz4A2YgX3ISEURESNBW7Hx9LbnMOyoRfRwOJGpG228ngzD2
	 KPGzAKLeTl3qhg4vECJFwIIuTyh4PcTlh3/qqCsFmnGO+uR98HwTPMz/ZRECujMYK+vUR
	 uqjbvLLahzfAOhpblAnfBnfLXgLx1CoLgFJYeUap6teZei8eEvO0YmzeK1CvMRN4TDd2f
	 G4LwScxp6AKbe+Ei7mhqmsUgoHCh6Qo6RmPxRu3OSU3JQ34PoOEMv/xu9s3ov0pFrcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNHWgQbT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591A606A324;
	Tue,  3 Nov 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNHWgQbT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793734093;
	b=mWHHHVxfpEc8IJldZMaO0ZfA3MA6kswJwrw5ZvDnpmcekETRhbWpneSiWsoSmrYXePNX
	 ArF/WyGyR21RujALkCvw1jJ+MxLVtL32bJIsNuUN6L0LforATI2q0RQKErRbbXEcpke+Z
	 DRANM48BiulBi72TUCXYjXXaln/j/bfl6lc4b6OeCFL5W7rGy2nqKhCv5Un3zudgBtxfZ
	 I8aydCZJ4FY5zPz6EoA5DrrOJ2PaIzzaYnmMjvkg8R5r9zRCdGMRFbzJGldzOcUBa/V4P
	 wY/ZpBbGfr/rpSgl/yDAnok3E9OBOv6HxsBbeeX3Q9v0DW34G33dUtWdnDTdVvcpv1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793734093;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=pIO5Ryz18Of2q0V5iO2sOf+bcL5Shl0sK76L+mPdroE=;
	b=Pg7SU8yliZa5sPZx2ctPwSQ4QxZInFT5pUif6CclV5wIiKMCeKEY4XK9pgHS7KG2eCe6
	 fnsWvW1ameVRbxxonJe7ZW3fHj8kc3CbR/sIzi9RWNvMaKHQE7UX0dAEVsyuXCounBaUu
	 D3rCPYai16G9VcuToFtfl3Y4RoEk4AdlEY/wj6D8Ob5UhQG5RV3GyV8w85XJxKaw5shsF
	 on24FrqNJxY8AeJ44ng3u9PgpPwNMU1GvSD9cHwUf69sioMC9bhxuFyzJEA2RHWGBNH8K
	 A5j6R6q8pjM2Zs1N4KtkIKEiI9DFsQYyIQWUOKF4LlVx/Z+i9cSw5JZKYh/ekSHTIIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4487B1F000C1;
	Tue,  3 Nov 2026 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734093;
	bh=pIO5Ryz18Of2q0V5iO2sOf+bcL5Shl0sK76L+mPdroE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZNHWgQbTkvaJXR/8ZddplQaLmxGXXOliykBhHs0EEXXVSjsUxbg88HsiKg77e6vUx
	 PUSRNF7qBqGyBCFgdgHqlWLZqKIIgs7UdUKwy4vqR/mm5h/mbsE3c0WTzp6m0TWfF/
	 tco02ZkvKF4OOaLHmSZW7V5Q0mY4B36o7rnZViPWwcjIn2FrIQHKNFvqMYrfrzRBLE
	 /ZMPWGqVLzH15FsDiYJH5aPGk/aUEFp+hHC+UFuPjsGEWFFDejnASZeH4h5t4/QD6f
	 fnVpYQHByQBNq/l58CapQoqzj7jr8x6aVIW2GhEbtNt1UxwZgpE6C2RIbO92R7Te/9
	 n9X3fsXOEXs2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5E5B46ABE;
	Tue,  3 Nov 2026 19:28:12 +0000 (UTC)
From: "David R. Hedges via B4 Relay" <devnull+linuxdev844.thelittleman.net@kernel.org>
Subject: [PATCH 0/5] drm/nouveau: GSP DP control call fixes and two KMS
 fixes
Date: Tue, 03 Nov 2026 13:28:00 -0600
Message-Id: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDQBCE4atIr21wxhfJVSQLH2XSLkaZzogg3
 t1Rlx/FXzspvEDpnezksYrK7CJMmlD/a90XLEM02cxWxmQ5uzmsaAMPC4+yQblAWdS2ql+jySl
 mi8c9xKr5PNbQTej/1w8dxwkGce+ddAAAAA==
X-Change-ID: 20261103-nouveau-dp-fixes-4e5472679f13
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 "David R. Hedges" <linuxdev844@thelittleman.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793734092; l=3561;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=kyihAzwfIJ9HHfvSKZq5cUSMRFvsoDqjqldRWUxUoXk=;
 b=mNNgoyfahRS6gsbtCUR7JisVyYP2F/b4pOOLEw4sXzJ0BB6BWnJr/uvT/VkxwT91fZ+tlWr+p
 A+Q2wo1QbZmA1Xg15bSAkL14u9suiUQahTEw8ELHw3rWVwMUjWbSDQP
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Reply-To: linuxdev844@thelittleman.net

These turned up while debugging a DP monitor on a GA102 (GSP-RM
570.144) that stays dark after DPMS off [1].  The fix for that is a
separate series for drm-misc-next, based on this one.  These five
don't depend on it, or on each other:

 - 1: r535_gsp_rpc_rm_ctrl_push() reports success with a NULL reply
   when the reply it was waiting for goes missing.  That only happens
   after a WARN in r535_gsp_msgq_recv(); found by reading the code.
 - 2: r535_dp_aux_xfer() has, since v6.12, passed RM's reply fields up
   as a completed AUX transaction even when RM failed the call.  With
   Ubuntu's 7.3 kernel this machine logs bursts of 40-50 such failures
   each time the monitor fails to come back from DPMS off.
 - 3: r535_dp_train_target() dereferences a NULL reply after a GSP RPC
   timeout.  Seen once, turning a display engine hang into an oops.
 - 4: a modeset racing a probe that lost the EDID drives the output at
   0 bpc and trips the WARN in nv50_sor_dp_watermark_sst().  Seen with
   Ubuntu's 7.3 kernel.
 - 5: since v6.2, a plug or unplug event pending together with an
   IRQ_HPD, including the sink count changes nouveau_dp_irq() reports
   that way, skips connector detection.  Found by reading the code; I
   have nothing that changes its sink count to test it with.

Testing, on the GA102 above with Ubuntu's 7.3.0-9-generic kernel and
nouveau built from v7.3 plus this series and the drm-misc-next one:

 - the DPMS, cable replug, S3 suspend/resume and power button tests
   described in the other series, with drm.debug=0x106, and five days
   of normal use: no WARNs, oopses or display engine hangs.  The only
   GSP errors were AUXCH_CTRL failures (0x65) while the monitor was
   switched off, and those now reach the DP helpers as errors ("Too
   many retries, giving up. First error: -22") rather than as
   completed transfers.
 - 1, 3 and 5 deal with conditions I can't reproduce on demand, and the
   0-bpc race 4 fixes didn't recur.

Both series build with W=1 on drm-misc-fixes (this one) and on
drm-misc-next (both), with no new W=1 or sparse warnings in the
touched files.  checkpatch --strict only points out RM's camel-case
replyType field.

This series was developed with the help of Claude Code (Claude Opus
5.5).  It analysed the kernel logs, read the nouveau, DRM and NVIDIA
open-gpu-kernel-modules sources, drafted the patches and changelogs,
and ran the build and checkpatch checks.  I provided evidence and
direction, reviewed changes, and ran the hardware tests.

[1] https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515

Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
David R. Hedges (5):
      drm/nouveau/gsp: fail control calls whose reply went missing
      drm/nouveau/gsp: don't report failed DP AUX transfers as completed
      drm/nouveau/gsp: don't dereference a failed DP_CTRL reply
      drm/nouveau/kms/nv50-: don't drive outputs at 0 bpc
      drm/nouveau: don't let an IRQ_HPD hide a plug or unplug event

 drivers/gpu/drm/nouveau/dispnv50/disp.c                |  7 +++++--
 drivers/gpu/drm/nouveau/nouveau_display.c              |  7 ++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c |  3 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 11 +++++++----
 4 files changed, 21 insertions(+), 7 deletions(-)
---
base-commit: 54a88d9afcca66221d14f438d0960472984968ec
change-id: 20261103-nouveau-dp-fixes-4e5472679f13

Best regards,
--  
David R. Hedges <linuxdev844@thelittleman.net>


