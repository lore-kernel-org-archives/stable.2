Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52679541E73;
	Tue, 22 Sep 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079939; cv=none; b=dC5s5vusD2s3HaR2G72/vZ3KQVwFle+lgVfpwPt61AOXvbL/vHmgLCrnReozcbBZJZ2SrfOE0S4Y+bZimw2AhtEoiVPn3Hlo3Em3gEWZYohWpu8owO8Z4mcL8RJ0Q+9CYrjGzGbo9VKzQNdW3Aq/w8WbOSmfc/R6/EvcpwM2PL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079939; c=relaxed/simple;
	bh=vdk2TN5YpN4vvPM7gYUgZOVeY63gdyrUQXLWIQe0P2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vp1jgchpMROX8/7XMjEHJPVpidTucL0XAiswuDl6Dz64tXzSk+i565+OtJqHe3kS96sb9OsBTMAUqvyNG+QgSMS8a8bxgEoE11gma9eba53PageCjbF7DDR+lTAxZTGjdzlfey5dF0ZrCHTkfA+4jw24K3XAkcREDHiJ6t7gJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lefOWI+I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lefOWI+I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95DC1C2BCB8;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079938;
	bh=vdk2TN5YpN4vvPM7gYUgZOVeY63gdyrUQXLWIQe0P2Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lefOWI+IKyxxYUoMLBy/say5T2/itrl+sf/80z8dmiAO3v+/igQWyC6K0kxmvKvuG
	 xGU+r0hkb2GiJ/ZtnlMRsFOjaat/UZaqj+P1yhIIOzvpWRaABzd/873S2N6MEg7BhM
	 VYOMTUHHq1EIdYqK2Pi3pyaiSDc0btsxmMRIrIx3V6WuVx7YDwiOV1spWQq3MZI6P/
	 uKgB6BXtuGbD2OBpoOyCVYA3QyeWOJ9bGC6wjAFNxAaJeLPHmMMe9kbg1jX2e9Z6je
	 ATLUkKIfzFG7AwuVCYyzOVM8cG6RkUWQmo4MNzP+WzI6jy5WxBNbRa5Z3yGrThC0nj
	 Q6PmFaxnHX2uA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D2C98302;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Subject: [PATCH v5 0/3] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Date: Tue, 22 Sep 2026 14:25:28 +0200
Message-Id: <20260922-ps883x-disable-usb4-v5-0-02c0414978e6@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OPW7DMAwF4KsEmqtCv7bUqfcoOogSXQswosBMj
 LSB714mSzO4Hh8Bfu/dBOFckcTb4SZmXCrVduTgXw4ij+n4hbIWzsIo06leB3miEOxVlkoJJpQ
 XAid1BDVkbcEnEPx5mnGo14f68cl5rHRu8/ejZNH36763aKlkxhy6oiCqiO9tKpTH1iZq0+XMG
 +kV6o+444v5A6N226Bh0BubrQGHrvS7oH0Gu23QMhgGHW3onOeZu6B7Ao3ZBh2DKvXgoVcZkv0
 XXNf1FwUqwQC2AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079937; l=4078;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=vdk2TN5YpN4vvPM7gYUgZOVeY63gdyrUQXLWIQe0P2Y=;
 b=ywXCm0G+CkYyYcLt8Gx+wK7L16zhqLETf97ju0T5wwpFVWO8aeW2ATK4mLMXVCN9ZWD2N3etB
 frhvCS7TAQRB/THGs0Ktegr/48NLCk3I+J+zixdv9SR1jN6xlLdwkQ5
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
  Handle it in the existing DP altmode path in ps883x_set(). F is 
  programmed like D; E is unchanged.

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
Changes in v5:
- picket up Acked-by tags from Heikki (thanks!)
- Link to v4: https://lore.kernel.org/r/20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz

Changes in v4:
- remove ambiguous link in patch 3, pointing to a semi-related issue.
- Link to v3: https://lore.kernel.org/r/20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz

Changes in v3:
- reduced the dp logic changein ps883x_set() to only adding 
  TYPEC_DP_STATE_F handling grouped with TYPEC_DP_STATE_D.
- picked up Tested-by tag from David, thanks for the re-test.
- Link to v2: https://lore.kernel.org/r/20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz

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
      usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
      usb: typec: mux: ps883x: add a delay after writing config regs
      usb: typec: mux: ps883x: disable USB4 on incomplete USB4 platforms

 drivers/usb/typec/mux/ps883x.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
---
base-commit: 601057b3eec13d1f37e5b45dd1410facd7b1bdeb
change-id: 20260718-ps883x-disable-usb4-19b0fc13b5ab

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>


