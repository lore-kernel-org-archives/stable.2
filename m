Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679465;
	b=CbCHLpwOb4of7qOvO1giWkM9+4NOBm9jsLT9CwghkznHkuEi60junQ1/MIVWaOpPzfrc
	 e38VR3HMAktMjLP7qCTG40Acu9/wK1+OVyfsRBV8QmjqoHKlqpE3sU75qYAeB7Z4RcHEE
	 KLhbbtdy+1DqFA4qJ97j+mCcwA711ZEo55O4o+/sxjr07Rw2nma488Ab3wraGhD5MCEjy
	 LkHnvBXDSvCIUEjxQSCF+K4cEk6ByXvOOEEkiOtrNFqpeH+w9/XHmoAv36oADtOCjWM2v
	 I4LRrNyZ6JVHb8MIn5nqJajjKG3vByzWY5VLpl0+jv9VdXoo0oJMOPLcC1qqRSNeY0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679465;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=/W2SmjXDUfQnBoR4GHTbzcmAOn9anuGpPCq5JIyL8kQ=;
	b=Z4umCeA3jkS3dIYuwr5QIlWm2rDfyMAGosm2VPksUo7Xm4BWH6D2Uu9xK3RiEE/Y7JQL
	 tAvZ1e+B+HVVBq0OmYKPP0ybTDpb7PM4XIM0LiAX6IKeuDdJziPxhNTTgJA9o66XXaLia
	 zTkUMk/78nCEwO1ysScQfWiQk1saiPPxH1MYhIJcs1waYZlC1Bot1DJSuJAInWC0zvZ3p
	 5a/BZVj2Xu1ySJblHzfvj0y6GAZGRJbiCMpom8IepPzFOyd9KkGUPEsqzkELSEzoKtNbD
	 QeAbXgzx040UpGLFpeQijbV0O0Yy2PNxUgJVlPQzA6L3+Tk70FiXiPTp2wznBl9B9BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Dz1eziMK;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D235606A327;
	Sat, 14 Nov 2026 18:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D235606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Dz1eziMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679457;
	bh=Bdw/P3XwNAY7KUN0u18LUcxRuBp8xOdgIFMph11iTNU=;
	h=From:Subject:Date:To:Cc:From;
	b=Dz1eziMKSwPxChZAZfImrlaGTGfhKZW0dLpCyYHAIJ51Wy97nU0OSqjkDlqGx3XF8
	 7p8iY1fgOHw4Bsu6P+G+8TQNGJ4HGE0OpmQiAeXTPl5dhCkUJPRTR0LFLOqNZwr8Fx
	 li+0269P4s56+2zA9DdH2i9+BY4NfTCmoWZokcr9XG/UZesMOTCRlXa3NauKwckiU3
	 +qPbW336Yu4zZ56mninm21lGLVWk+SWJSYJkjWXqBfBWa3XqAsKfj3KJMErTMfPzkf
	 c3B+m3fzInaosvSX5XFDfZzvFgoSWhWtAxndya492Qzi8F4T30oz7ln4XkegANamDM
	 U55pMByBU5wdA==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A32517E0564;
	Sat, 14 Nov 2026 19:04:17 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 00/25] drm: HDMI connector API cleanup and HDMI 2.0 test
 coverage
Date: Sat, 14 Nov 2026 20:03:24 +0200
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g00IqX2KqULTVJNqVFmHBHEu
 zuty7f4f4OowTTCo9gg6GLRRs+gSwHcN94pmmRDeS1vRFShhAF5dMdeBkP+auNpQqmlrvhOwtp
 Cbqegb1v/3+frdEztR3n+zWDfD+LqEm55AAAA
X-Change-ID: 20261114-drm-conn-hdmi-cleanup-d9d94c81dceb
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>, 
 =?utf-8?q?Robin_R=C3=A4ber?= <robin.raebi@gmail.com>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2

This is the remaining part of "[PATCH v11 00/74] Add HDMI 2.0 support to
DW HDMI QP TX" [1], to clean up the DRM HDMI connector infrastructure
and extend the KUnit coverage of the HDMI connector, bridge and
probe-helper code.

Patch series structure
======================

Patches 1-2 fix the SPD InfoFrame vendor/product copies by using
strtomem_pad(), so that non-NUL-terminated data is no longer read past
its end, and define the related field lengths.

Patches 3-4 drop drm_atomic_helper_connector_hdmi_force(), which has no
users left now that drivers use .force_ctx(), and make the state helper
reject connectors that lack HDMI funcs instead of dereferencing them.

Patches 5-7 convert the connector and HDMI tests to
drmm_connector_hdmi_init() and remove the transitional
drmm_connector_hdmi_ini2().

Patches 8-12 drop the redundant HDMI vendor/product, supported_formats
and max_bpc fields from the connector, use the SPD InfoFrame field
length defines, and fix a comment in drmm_connector_hdmi_init().

Patches 13-15 fix the conformity of two existing EDID test blobs and add
a 4K@60Hz EDID with a 600MHz TMDS limit.

Patches 16-22 add connector and HDMI state helper tests:
max_tmds_char_rate initialization and limits, the source-side scrambling
decision, SPD InfoFrame vendor/product generation, HDMI 2.0 scrambling
helpers and SCDC resync on hotplug.

Patches 23-24 set the supported HDMI version in the bridge tests and add
HDMI 2.0 bridge connector coverage.

Patch 25 adds .force_ctx() connector callback coverage to the probe
helper tests.

Changes since [1]
=================

- Added new patch 'drm/display: hdmi-state-helper: Reject connectors
  lacking HDMI funcs'
- Split 'video/hdmi: Define SPD InfoFrame field lengths and use
  strtomem_pad()' into
  * Copy SPD vendor/product with strtomem_pad()
  * Define SPD InfoFrame vendor/product field lengths
- Fixed comment block in drmm_connector_hdmi_init()
- Dropped the now redundant !connector->hdmi.funcs check in
  'drm/connector: Drop redundant hdmi supported_formats field'
- Updated some of the existing test cases
  * connector: test NULL hdmi_funcs rejection, max_tmds_char_rate
    inference for all HDMI versions, HDMI 2.0 rate capping, and
    scrambler callbacks being ignored below HDMI 2.0
  * hdmi_state_helper: verify the scrambling decision accounts for
    output format and bpc, and gets cleared when switching to a low TMDS
    rate mode
  * SPD InfoFrame: also check the packed buffer handed over to
    .write_infoframe(), and drop the redundant atomic check that
    triggered drm_WARN_ON(state->checked)
- New patch adding HDMI 2.0 scrambling helpers coverage, using a fake
  SCDC sink on the DDC bus: drm_hdmi_mode_needs_scrambling(),
  drm_connector_hdmi_{enable,disable}_scrambling() including error paths
  and rollback, and the SCDC status monitoring work
- New patch adding SCDC resync on hotplug coverage, i.e.
  drm_connector_hdmi_sync_scdc() via the hotplug and .force_ctx()
  helpers
- New patch adding probe helper .force_ctx() coverage, including the
  -EDEADLK backoff and retry path
- New patch adding HDMI 2.0 bridge connector coverage: scrambler
  callback forwarding, missing ops rejection, and version and max TMDS
  character rate propagation

KUnit runtime dependency
========================

Please note that a few unit tests are expected to fail until the
following commits from drm-misc-fixes land in drm-misc-next:

- 59d532e39ea7 ("drm/display: hdmi: Use committed state to decide on SCDC resync")
- b4146c6155b1 ("drm/display: hdmi: Reset sink scrambling on non-scrambled modesets")

[1] https://lore.kernel.org/all/20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (25):
      video/hdmi: Copy SPD vendor/product with strtomem_pad()
      video/hdmi: Define SPD InfoFrame vendor/product field lengths
      drm/display: hdmi-state-helper: Drop drm_atomic_helper_connector_hdmi_force()
      drm/display: hdmi-state-helper: Reject connectors lacking HDMI funcs
      drm/tests: connector: Convert to drmm_connector_hdmi_init()
      drm/tests: hdmi: Convert to drmm_connector_hdmi_init()
      drm/connector: Remove drmm_connector_hdmi_ini2()
      drm/connector: Drop redundant hdmi vendor/product fields
      drm/connector: Drop redundant hdmi supported_formats field
      drm/connector: Drop redundant max_bpc field
      drm/connector: Use the SPD InfoFrame field length defines
      drm/connector: Fix comment in drmm_connector_hdmi_init()
      drm/tests: edid: Fix conformity for 1080p+4K YUV420 200MHz EDID
      drm/tests: edid: Fix conformity for 4K RGB/YUV 340MHz EDID
      drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
      drm/tests: connector: Add HDMI max_tmds_char_rate init coverage
      drm/tests: connector: Add HDMI source-side scrambler coverage
      drm/tests: hdmi: Cover mode validation against connector max_tmds_char_rate
      drm/tests: hdmi: Verify scrambler_needed computation
      drm/tests: hdmi: Add SPD InfoFrame vendor/product coverage
      drm/tests: hdmi: Add HDMI 2.0 scrambling helpers coverage
      drm/tests: hdmi: Verify SCDC resync on hotplug
      drm/tests: bridge: Set supported HDMI version
      drm/tests: bridge: Add HDMI 2.0 bridge connector coverage
      drm/tests: probe-helper: Add .force_ctx() callback coverage

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   30 +-
 drivers/gpu/drm/drm_connector.c                    |  123 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |  185 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |  643 +++++--
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 2015 ++++++++++++++++++--
 drivers/gpu/drm/tests/drm_kunit_edid.c             |  251 ++-
 drivers/gpu/drm/tests/drm_kunit_edid.h             |    1 +
 drivers/gpu/drm/tests/drm_probe_helper_test.c      |  296 +++
 drivers/video/hdmi.c                               |   31 +-
 include/drm/display/drm_hdmi_state_helper.h        |    1 -
 include/drm/drm_connector.h                        |   38 +-
 include/linux/hdmi.h                               |    7 +-
 12 files changed, 3047 insertions(+), 574 deletions(-)
---
base-commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
change-id: 20261114-drm-conn-hdmi-cleanup-d9d94c81dceb

