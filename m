Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D73AD506;
	Mon, 21 Sep 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974943; cv=none; b=Wd8RFg3yp4zaiTOFgs1M6v75P6qZqv7Itj2PkQ5uNeWMr0SjK/4ejG98qknDAdggWGqEt8OS4JHIyLTHbzxchm4DmnCGazQNn8aSHxPyEkGWOjsrfRV66Hb5Ru+OUcusiAJG+IQ8rGf/rhuI5kcaaueB8PTml5mgvfuY7obwMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974943; c=relaxed/simple;
	bh=Gw+JQl2NJaaT8WRtJMohAP4it7/gBPXPDcyZzvsaGYw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A16dOI11njZZbpNBlbLC3SYUwLeon7ez16IamgdaJE227NHZDeWv1autkP8mr8pcWWETKCMk5OD0CBw/FN75SW5TscfHnnqk3vaBxYcbvqUTD+VRsMBzfCZUdTmYBZEfLLoVg3LsP4jHqwUF8LfaeTBA0zTmLMFcfMhWCYSCBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [127.0.1.1] (unknown [IPv6:2a02:560:5dd5:4b00:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5506C200291;
	Mon, 21 Sep 2026 09:15:39 +0200 (CEST)
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/3] media: synopsys: hdmirx: pixelclock fix and input
 status reporting
Date: Mon, 21 Sep 2026 09:15:32 +0200
Message-Id: <20260921-hdmirx-fixes-v1-0-495be0beaf93@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJXZsGoC/x3LQQqAIBBA0avIrBNGqdCuEi1Cx5xFFgohSHdPW
 j4+v0GhzFRgEQ0yPVz4Sh1qEODing6S7LtBo57R4iijPzlXGbhSkeQDOlLGBjNBX+5Mf+jHur3
 vB1D6HO1eAAAA
X-Change-ID: 20260904-hdmirx-fixes-edf0ce189f85
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shreeya Patel <shreeya.patel@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Dingxian Wen <shawn.wen@rock-chips.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Lucas Sinn <lucas.sinn@wolfvision.net>, stable@vger.kernel.org, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789974939; l=1539;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Gw+JQl2NJaaT8WRtJMohAP4it7/gBPXPDcyZzvsaGYw=;
 b=ZfnTdRF+HxCgFpzw306csicebQXECA8N7pNULhsiG/Z7LR3sjryBH4ZQ/BmoClX0JpEdAUyJX
 Tfy5+n4cyYKDu1G1np1LA44skOSyqqQvlKqhr6psaLsRz+BG2Gndpyt
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

Three changes to the Synopsys HDMI receiver, all found while bringing the
driver up on an RK3588 board.

The first is a fix. hdmirx_get_detected_timings() divides the TMDS clock
by a colordepth that only the format change worker ever fills in, so a
VIDIOC_QUERY_DV_TIMINGS issued in the window between the hardware
reporting lock and that worker running divides by zero and reports a
pixelclock of zero. It reads the colordepth from the hardware at the
point of use now.

The other two belong together. So far the only way for userspace to learn
the cable and lock state was the error code of VIDIOC_QUERY_DV_TIMINGS,
and both of those paths log at v4l2_err level, so an application polling
for a source fills the kernel log. Patch 2 reports the two states through
VIDIOC_ENUMINPUT, where the V4L2 API puts them, and patch 3 then drops
the prints to debug level.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Gerald Loacker (1):
      media: synopsys: hdmirx: add input status reporting to VIDIOC_ENUMINPUT

Lucas Sinn (1):
      media: synopsys: hdmirx: fetch colordepth before calculating pixelclock

Sascha Hauer (1):
      media: synopsys: hdmirx: stop logging a missing signal at error level

 .../media/platform/synopsys/hdmirx/snps_hdmirx.c   | 84 ++++++++++++----------
 1 file changed, 47 insertions(+), 37 deletions(-)
---
base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
change-id: 20260904-hdmirx-fixes-edf0ce189f85

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

