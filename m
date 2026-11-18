Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038464;
	b=KylHa3DOIAdq5yQQ/nt/26WEcekW/oG0NBMwjohwOrHW1X7b2BQBI9Gr2hye55cq9Nay
	 Crcu5NRTC0yJdbvivHSOrjHfiVi8KQe+MNfrHQJ61BnVu7/aUlGCG+pPp1lk8gbV0Bhvy
	 UuKzVlBxg0ivhcifWy+7Y+0GeUpD5cWlT5bhgH75S1QjnPzkvApFtS/yXPPw3pxfbrfBQ
	 xTIOnUvgSi3oWXChO0GJT3BCA5iXniitv9sX9BU2nVHhvtXgDgh7KUqWWp3fcj+I4Y/vH
	 TK2+qhjZmmPRD164qlM59DLC3OINHE/KM9OlEbqop7qFXv81RPvEkboI00eVctqemNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038464;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PmtX8OEiu2am7jf19lIwIhekAk6or208P1DOjACUs3U=;
	b=E6zYtfA/s7aTCUEFFCqXhgbL9NuX9j2LYQECd3anZ7nLZQVBSd9zcQNYR0TXpKIoprV6
	 z8c6j1FFT2weuyeExw6F5+6ALMHApoyZCaAMfyHY6kSaTrU7s03dNV0rXCAMpXV44RkLK
	 07h0Az+bCF74KZ6uZtoG0BGqWXc6zf5Ly2TmbH2lyrvTEnZ0rcgXqHjBo10CS5AafD2Kz
	 IK9nyV/C3RvRxbnolByORw1OjzP+TgcDVNUt2TqyCqDzq0MdELX2PdUp6WTL8iaqxVj8D
	 QYWgJbCfboUs0Zd31+UIW3OyoENg4i/Ziw6SzmcGV/6dB1IBM72+QI4651Q8rrVfyKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WfvNyqAj;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BD606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WfvNyqAj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Reply-To;
	bh=PmtX8OEiu2am7jf19lIwIhekAk6or208P1DOjACUs3U=; t=1795038462; x=2110398462; 
	b=WfvNyqAjpfC68YRRC+RIVvZulQNYR1ZYb+tAQLhgVrsKHyNVWt6VPjZyzwr340YBAgBTvrKE+Qc
	oF+uV5Powp1yONWtRV7PPS3deDu5S3cmJLjd33qnOFd7zgltB/3YLzh2eugdO5nzsCPKoONmicaTJ
	6OqR6yzETnblBDPwVUhHCglGN4laFKwpe34FyudxWM+TbBQddEx/6S26kuFQq5JTBBWCvj8pZIvx7
	jnxb3Sf3rVeBYG2jBiDpgNf7iDyGJSIUhzRBF4OVliYLLEVk5FTEpCo29f1MqzbYnSoF8twNueq36
	dJexspOHZgq8EdLZxevomHaNAbRNsGc8JYjQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTnVC-00000001DOD-1tDD;
	Wed, 18 Nov 2026 22:47:38 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache
 livelock
Date: Wed, 18 Nov 2026 18:47:27 -0300
Message-Id: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAyA4VeRnBcwpbjhq4wdaho1CK2kTAfSd
 1/x+B3+/4IiplJg7C4wObRoTg306IDXkBZBjc3gejcQkcODPSoHXgXPbFuw/E0RI9HkvZ/4KS9
 o7W4y6+/+vj+1/gGnz3KXZwAAAA==
X-Change-ID: 20261112-vc4-icache-workaround-d11b444bc7e8
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=cC8YMa0gkUQDhsp+cF6LKK3gm6xRtniDVoy3KOGeOYI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz2tZ0ROUyjMeAr0u6UKU9PWPnHJupq6sVyC
 ljta72AexeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qkSoCADLDeIDD3BwywH70IITWb89C+gQ20xaDL8n/eEcMJGiC2xzQUEL2Ka2DNBv17ufC/gAEyF
 KczwxVuWAVUjCDpN7pSDluvel2Qcv3fMKfg9gaAzkQHhc/Du4XkyMpMCl5sep90zktbLgR1dZCq
 p0K2W8t8E/sQ2xrDaIQG5kBV/5IekQXlqmUzlX+Vc1kaeUtTav9ejq5wQPHbWmdDYobEJLX9RRk
 rIgtBfhqm4aVpo6lHja3Fhou+0Uucv5UqWImn1m6x1itjjcJfaFat4XMFhHIrN7LeKRy+2Ymer4
 6RgfUGL3hRSqV2OHBvCPtzYKyg+k/pZ8GjLRvj1G6I+Ewjzu
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

Mesa issue #16652 [1] reports GPU resets every few minutes on the
Raspberry Pi 3. They happen when text labels are drawn over their shadows:
two different threaded fragment shaders, plus untextured single-threaded
ones, in the same tiles.

During a hang, the performance counters show four QPUs fetching
instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
instructions executed. This matches HW erratum GFXH-16: the QPUs of a
slice share one instruction cache and can livelock, evicting each other's
fills. Since shader code always starts at offset 0 of a page-aligned BO,
every shader competes for the same cache sets.

This series works around it:

  - Patch 3 starts each shader's code at one of four offsets in its BO,
    spreading shaders across cache sets.

  - Patch 4 clears the slice instruction and uniforms caches when the
    hangcheck finds no progress, and resets the GPU only if the stall
    persists. It is meant to recover from livelocks the offsets don't
    prevent.

Patches 1 and 2 fix an off-by-one in the shader BO handle check and a
NULL pointer dereference in validate_gl_shader_rec(), found while working
on patch 3.

Tested on a Raspberry Pi 3B+ with the issue's reproducer, 4 x 15 min runs:

  without the series:  29 GPU resets
  with patches 1-3:     0 GPU resets

[1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652

Best regards,
- Maíra

---
Maíra Canal (4):
      drm/vc4: Fix off-by-one in the shader record BO handle check
      drm/vc4: Check for a validated shader before reading its thread mode
      drm/vc4: Start shader code at varying offsets in its BO
      drm/vc4: Clear the slice caches before resetting a stalled GPU

 drivers/gpu/drm/vc4/vc4_bo.c               | 43 +++++++++++++++++++++++-------
 drivers/gpu/drm/vc4/vc4_drv.h              | 15 ++++++++++-
 drivers/gpu/drm/vc4/vc4_gem.c              | 20 ++++++++++++--
 drivers/gpu/drm/vc4/vc4_validate.c         | 17 +++++++-----
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |  7 ++---
 5 files changed, 79 insertions(+), 23 deletions(-)
---
base-commit: 80ac6d197218c3399d66674167a4d7c9051a25e2
change-id: 20261112-vc4-icache-workaround-d11b444bc7e8

