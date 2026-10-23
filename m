Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792794709;
	b=Od135mr7yqlqRTuBQJd3PVT5Sx/f1FhVEfqCOibREQBMWLBPFTCQs1/TSvjUwVmepgiA
	 DcKPjPjBglOy5qc4Q6QmHlfqrYFAbFU1zO3pu5YM/fDzVQNUXOUKnBAo4YsuzXrT5D33N
	 33pLVHngPe8KluHPVPrtLW+AX2w5nMn9QpmDt+Ht1ItP6abECrVDKwUdIQYmk6XAPy5JM
	 neNfvcmzb8PUtfOXfDLFpjKv2JhY4IPB0x7vXBzsMy13+ToJNZ8o7CK71F0RGoDQJrruK
	 dlOWWQjqV9kN5zcmhrmwTLhp83I+Fh8OvLinsMC2fQ4curfM5abyZlcJ8LxkoOqQOmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794709;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=40mHdQ1dXbS6kbZAKgswJtsHrX0WSyC5+8CucT7Tl0w=;
	b=u/E8P8GqjFTnKGY48qYndK2syQMu0/oBq2rmD+73Y/LfhTUDIK5u+wCP7nJEs9Y4K/jo
	 ISx12Xf/GORtWX8PcmqtZwQUaeYMS1zi3lyQM1cixlAbz6EBWSAl2ulQ0glDtBMkxKCGw
	 bUhx/0p87TFR73C1PGMC2APnKdW1pAru1YuyaDvfJIR3Uv4iFpUCRh/inkkWy9v7fW407
	 +NSLngVQZQ3YEdjl0BjvBzBtGmaz9kXISpaW117L4XITFRLraIV11LF6vBks2vmZnzLTe
	 kq8stWthF85DqODdAz5BYYR4pBKRD8L1LVTPaEIdFvLiBoJ1LcsnsTORpZYXVYC07wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m20vVpbN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C798606A326;
	Fri, 23 Oct 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m20vVpbN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792794709;
	b=3i8z07tX3w4rqIG7MfvdyYVZIQzc9orI6YsWGUnWK2gQPdzoWtaFzOiH8yc/2KIJQfqp
	 DaNIzL75Kz3KYbp0GTOS6wRmO6SdOqWQl84o9H+xqTUJXCTU7ct/qY8WvyFliKGQ8+CXF
	 ljrmsUHPSJfjvp9C0IzbPNQVxr9SSmJAl3D2XrjW78ZGctKYoeI67EIP5NM0xixhWlJTX
	 TBR/puTefwVsctXo35UWpcxeWfH6zzmSVdbKseiOD8OeDwyq51EudNsN5mVnp2RtA/3c+
	 AO6w+AyK61CsMch1p4l9zwUPS6/oqVaIyi+A7qfA+VGKR88dggkPoIcFf2T9mxrCx9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794709;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=40mHdQ1dXbS6kbZAKgswJtsHrX0WSyC5+8CucT7Tl0w=;
	b=x7LqylqnKuY2AY8MiUHGFqbBCl5TzEzn33SsjxNDmJ5aqDWL5uDqLLk+h4hyY0JrIzEU
	 fKFbLN7Xo5HxzdPkOUQlIUkzJDidGmYEx18m+e43yy7X1efuTuWh8wvPNq31V1kjMSE1L
	 WwGQhgaf1fwfXVWad57X0x2bSIBdLGjZt+GXibsD1BzcOwefm5/EaAsz4dw435cvMuy10
	 w6d3tf1p9CFFppZmBhSxEdcEF7rGM08eOWe0jelSxvEiCF1ppmVYUVW4zhB45V8m7qlBZ
	 VHEKYttrba01MQNsd87La0XqIzl/G/OdsoPpOvctAmrjbjYtQOkYgaG9at75QuVVbhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 82F8A1F031E1;
	Fri, 23 Oct 2026 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792794709;
	bh=40mHdQ1dXbS6kbZAKgswJtsHrX0WSyC5+8CucT7Tl0w=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=m20vVpbNTh6JqtqkB5c9zoIzU0QCDUVrnNBREQa/O7vtNTh78KCgPpytRYSJnQUGh
	 7kh+J24dW/ViruCCWc+SusSxZk1NWgBizEerDK4lsxAqEb+d3pFyXPxvXjDn1EkOAj
	 t5/rQoLakmtSaPpihnelckAKqNHRg2O6SYapjT2PyLOQC3vo4YoxIlh9loAJV/KGmi
	 HFNvmpJboiG4QjLvLCR+N8qcTNBkcxg4EqDF0PS9cYzGiUTR26MXUeLyyfgwLMmHOb
	 7zB2+k3AcJdmx3yLAr4Q8KP3QyRvOs2jcn0RHxbMc+KzLF1jjP1m5/V2QhR8g3FVGU
	 nWZFMZQAMguiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D619844655;
	Fri, 23 Oct 2026 22:31:46 +0000 (UTC)
From: Max Bretschneider via B4 Relay <devnull+max.bretschneider.leica-geosystems.com@kernel.org>
Subject: [PATCH v2 0/4] media: i2c: ov08d10: use the subdev active state
 and add get_selection
Date: Sat, 24 Oct 2026 00:28:50 +0200
Message-Id: <20261024-ov08d10-get-selection-v2-0-f8c49972ca18@leica-geosystems.com>
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
X-B4-Tracking: v=1; b=H4sIAKLf22oC/3WNyw6CMBREf4V0bU1vlQKu/A/Doo8LNAFqeptGQ
 vh3K3uXZzJzZmeE0SOxR7WziNmTD2sBeamYnfQ6IveuMJNCKtHJjocsWgeCj5g44Yw2lQW3Wjd
 GWdO6AVnZviMO/nN6X33hyVMKcTtvMvzS0wgC4I8xAwdeOzSo7jfVqPo5o7e6tAJtlHChqw0L6
 4/j+AKed3y/xQAAAA==
To: Jimmy Su <jimmy.su@intel.com>, Matthias Fend <matthias.fend@emfend.at>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Max Bretschneider <max.bretschneider@leica-geosystems.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792794706; l=3275;
 i=max.bretschneider@leica-geosystems.com; s=20260501;
 h=from:subject:message-id;
 bh=oNEbJ88MKt/pgzyIkNizvj1+LJU8OCz+hHF/MohQvGk=;
 b=0MAkuKBXNsy0Ea2kZjoRsfeij9FPgEPcXr5McPCGJBUnVNFE67b/kNZigLsDt3YIHB81Ge8sE
 8mRrr8iu4C0Ce8PfQFkTJo3PJfK+uBKu/X0AzGxPIaKflPYS/e5W0p1
X-Developer-Key: i=max.bretschneider@leica-geosystems.com; a=ed25519;
 pk=jf4ba33jrWlsOdGemi2InMtJAngoJVZU8Moetp0ixik=
X-Endpoint-Received: by B4 Relay for
 max.bretschneider@leica-geosystems.com/20260501 with auth_id=1161
X-Original-From: Max Bretschneider <max.bretschneider@leica-geosystems.com>
Reply-To: max.bretschneider@leica-geosystems.com

v1 of this was a single patch adding get_selection. After review this grew
into four, three of which address points raised in the review.

Patch 1 fixes a NULL pointer dereference in ov08d10_get_hwcfg() and is
marked for stable.

Patches 2 and 3 port the driver to the subdev active state and drop the
cached current mode, both requested in review of v1. Dropping cur_mode
means the mode is now derived from the active state instead, for which a
small ov08d10_get_mode() helper was added.

Patch 4 then adds get_selection, the original change from v1. Without this
the driver never reports the analogue crop, so userspace cannot tell which
region of the pixel array each mode reads out.

Tested on a Hexagon/Leica CS50 (i.MX8MP, rkisp1) running 6.16.12 with the
equivalent of this series applied. Further tests on a more recent kernel
will be done in the coming weeks.

- Compile-tested against media/next, built with W=1, and checked with
  sparse and checkpatch --strict.
- The NULL dereference was first reproduced before the fix. With the fix
  applied, and dynamic debug enabled for that statement so that its
  arguments are actually evaluated, rebinding the driver prints
  "Using N data lanes" instead of oopsing.
- libcamera no longer reports "Unable to get rectangle" errors and no
  longer defaults PixelArraySize, PixelArrayActiveAreas or the analogue
  crop rectangle, all of which it did before.
- The crop rectangle is correct for all tested modes.
- Toggling HFLIP changes the media bus code reported on the source pad
  between SBGGR10 and SGBRG10, as expected.
- Streaming works in both the 3280x2460 and the 2x2 binned 1632x1224
  modes.
- v4l2-compliance 1.26.1 (SHA 4aee01a02792, 2023-12-12), run against the
  media device: 52 of 52 pass on the sensor subdev, no failures.
- With CONFIG_PROVE_LOCKING=y there were no lockdep reports across format
  and selection changes, both flips, exposure, gain and vblank writes,
  streaming in both modes, control writes while streaming, and a driver
  unbind/rebind cycle.

Mainly modelled on imx335, imx214, imx355.

---
Changes in v2:
- Fix the NULL pointer dereference in ov08d10_get_hwcfg(), Cc stable
- Port the driver to the subdev active state, drop the driver's
  own mutex in favor of the state lock shared with the control handler
- Drop the cached current mode and derive it from the active state
- Moved ov08d10_get_selection() out of the control handling section and
  appended it to the pad ops, keeping the driver's ordering
- Link to v1: https://lore.kernel.org/r/20261011-ov08d10-get-selection-v1-1-5debe6436765@leica-geosystems.com

---
Max Bretschneider (4):
      media: i2c: ov08d10: fix NULL pointer dereference in ov08d10_get_hwcfg()
      media: i2c: ov08d10: use the subdev active state
      media: i2c: ov08d10: drop the cached current mode
      media: i2c: ov08d10: add get_selection support

 drivers/media/i2c/ov08d10.c | 172 +++++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 66 deletions(-)
---
base-commit: 2dcdfb625c3b8fe87454e19dfbc54b3e3f0ad70e
change-id: 20260929-ov08d10-get-selection-caa7b6cb8dfe

Best regards,
-- 
Max Bretschneider <max.bretschneider@leica-geosystems.com>


