Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6073B6C09;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365931; cv=none; b=TOWX6zZ+2asfCli9Ebqp1wqO+NJ5I/MxoYMDVQ+5E97qiWD2OSZIGGMDvINbHIF47vb3/UF08OgcFCxAI1vyE/ZzIlQ4c84S+q3IYTC8lfw/bXDLQJ7ValicJQWTEbF4w1B4mQCzK+6XW3KEDoQQrYMJ7cetWt93eToTiCyKDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365931; c=relaxed/simple;
	bh=ouUPgqF/p+Lw1hguu8gg64pH9INr44vKVkVheRekLw4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AWGB7nlO0dE6KYUAYfjU/QjRwyr2WN8hn1ut10F2Ci6JymKFHrE9DedX/3AgKFITRaCn2zuS3adj+hpaMwAEX5sNl/vD9n1rJ41IGde/7tMXOJU2GXhABpsnhG6ZatY5+cWSfyIUgMpLFKvDFuuAsUd4ciseYQ/PsBaT4Sve+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ZR2EWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ZR2EWN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C1FC2BCFA;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789365930;
	bh=ouUPgqF/p+Lw1hguu8gg64pH9INr44vKVkVheRekLw4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N/ZR2EWNETZNo0LxEXdefsz0m7IZpNgZ+M7JhL3SdhKDWuWu7jbXnEb5C1lwXSCW1
	 sGN64XuHIMHpEGlvPnAqTxnv1+RDLcAYgAf8SNbJHqcdYl5VgTXK0QYj6JrmeR9xgH
	 WTeqA8Jq48dAxfg9sKSsWJnWplOC7OpJ+zoAmrBhEyCx3j5SHjMOhWz6/eTrlaikkE
	 mHFh0R7FFlncXu/iATG/6E9OnvLV0zmOxgVWOTnv55DbWn1QaZRM7A/vb+2u9xbgYO
	 fY9UhYmX9AiDKL2RQvuKCZqbdB9sDwls4NSq6es0idKP7R3bYDlP9ugcV5BfbfWAWC
	 2HOXWZSJnVyAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E1C88E64;
	Mon, 14 Sep 2026 06:05:29 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Subject: [PATCH v2 0/3] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Date: Mon, 14 Sep 2026 08:05:00 +0200
Message-Id: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0K6dkxbFIsr72FY0HaQSRpKOkBQw
 t2tHMDl+8l//2+CMRGyuBebSLgQUxwy6FMhXN8OLwTymYWWupI3ZWBkY8oVPHFrA8LM9gKqtrJ
 zqrTX1orcHBN2tB7WZ5O5J55ieh8ji/ql/32LAgkOnam8tLWs8RGDZ9fHGDiGecof+WzpI5p93
 7+JaxbiwwAAAA==
X-Change-ID: 20260718-ps883x-disable-usb4-19b0fc13b5ab
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789365928; l=3450;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=ouUPgqF/p+Lw1hguu8gg64pH9INr44vKVkVheRekLw4=;
 b=bJiVGeLwKgpwRhuCVkpTFvzw1nOWIBBI1al0lJc1vw1HYQqfNQU7qPhofiuxQKZmFmQaRjWJb
 wunOo/jSdOUCUjS4S+mInn1+f83PL0ZGIFSihfVhnxKYHMzIojVGVg2
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

On Qualcomm X1E80100 / X1P42100 platforms using the Parade PS883x
retimer, connecting USB4-capable docks such as the Lenovo 40B0 via a
regular Type-C cable (Type-C fallback mode) often results in working
USB but no DisplayPort output.

This series addresses the issue with three driver-only changes:

- Support the legacy TYPEC_DP_STATE_F request (deprecated since DP Alt
  Mode 1.0b) that docks such as the 40B0 and SSK SC220 still send.
  Handle it in the existing DP altmode path in ps883x_set(), using the
  same C/E = DP-only and D/F = USB3+DP mapping as qcom-qmp-combo.

- Add a post-configuration delay after writing the connection-status
  registers so the analog front-end can settle. This makes DP Alt Mode
  hotplug reliable on the 40B0.

- On platforms whose USB4 / DP-tunneling stack is not ready yet, reject
  TYPEC_MODE_USB4 with -EOPNOTSUPP. That forces the Type-C stack to
  fall back to USB3 + DP Alt Mode. The quirk is a machine-compatible
  table inside the driver, not a DT property.

This is a temporary workaround until full USB4 DP tunneling support is
available in the X1E USB4 controller and qmp-combo PHY stack.

As an additional observation, the same dock with a Type-C cable works
well on Thinkpad X13s, Thinkbook 16 G7 QOY and Ideapad 5 14Q8X9, which
do not use this retimer.

To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Assisted-by: Grok(xAI):4.6
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
Changes in v2:
- Drop the parade,disable-usb4 DT property, bindings and board DTS
  changes (Sebastian Reichel, Krzysztof Kozlowski). DT describes
  hardware; incomplete software support is not a board property.
- Disable USB4 from the driver via of_machine_is_compatible() for
  qcom,x1e80100, qcom,x1p42100, qcom,hamoa and qcom,purwa. The quirk
  stays kernel-contained and can be dropped later without ABI.
- Keep DP altmode handling in the existing ps883x_set() path instead
  of extracting a helper (Konrad Dybcio). Treat STATE_F like STATE_D
  and STATE_E like STATE_C, matching qcom-qmp-combo.
- Replace usleep_range(20000, 30000) with fsleep(30000) and document
  why the delay is required (Heikki Krogerus).
- Drop the per-event "USB4 disabled via DT property" log; print once
  at probe when the quirk is active.
- Link to v1: https://lore.kernel.org/r/20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz

---
Jens Glathe (3):
      usb: typec: mux: ps883x: support TYPEC_DP_STATE_F like qmp-combo
      usb: typec: mux: ps883x: add a delay after writing config regs
      usb: typec: mux: ps883x: disable USB4 on incomplete USB4 platforms

 drivers/usb/typec/mux/ps883x.c | 56 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260718-ps883x-disable-usb4-19b0fc13b5ab

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>


