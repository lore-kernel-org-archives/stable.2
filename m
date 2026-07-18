Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9522EDD69;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394392; cv=none; b=rd6amjY+qqg+aYkqBovvvcyeWL1W25INR1tTlGyoL5SKHFOALk/TAX/o2xpLab+JGv97e6Or+jMVtlUuGaVL5+IHABgbE5uTCaUe5UPhvpbKILzL/kaTpNY7anSUPkMyHC2bwoudMhewunDRistWd4LouTKtDhAzJSL3oer6038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394392; c=relaxed/simple;
	bh=FggoJ5m4+e7v5r0GqXFrxTaRokbqwJW1xzchfVGyfP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSBbzfTKVWATWDTivudz71YndkfB2g6fXrr/fwk8QgXRVuEisdbQ3GrbcwyuEnF83fyLyd8oWUOzFTXSTNKUFb0FCiUmUn8PDc/OXaoO+DVB+GPBpszBkr7eEh3ycnf0WxjqxX7ptwWbInYuxPp0lEhDFdef7ra8sX6KS0iV+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/7wDCbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/7wDCbx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B1B1C2BCF7;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784394392;
	bh=FggoJ5m4+e7v5r0GqXFrxTaRokbqwJW1xzchfVGyfP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d/7wDCbxV7z3qmkuNq6bk7SPHjc+Fuidck9hqAZ1AIaCcaeUd3IH+Da5kZxMDX7uQ
	 bxX0riKtIBcqXigt6U5m5x8p6einm1nO3v/yLIzWnl2aN3/rwo1PYarYzjq0JtuMzq
	 FGgh9ex42ndQCs7OU4+dHSbC7IEEqESVey/nHAZauxt3eRQJtDM/8OMkSZICZmnuwc
	 r+pkmD9XiNIi88fvyj/5GCNjKm+qeRdBVqEHswGVlO5rX3DUKsxMkU3NpOSEsz3X6J
	 lKuBDnK89MAREfsnnl2YwiaZv87heUPUzlN6koVWXCBodeYKDF94JtxnCL/ihrsxQJ
	 FM2fuV84/JQgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0EC44525;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Sat, 18 Jul 2026 19:06:32 +0200
Subject: [PATCH 4/5] usb: typec: mux: ps883x: add a delay after writing
 config regs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
In-Reply-To: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784394390; l=814;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=JDRGNjZHwnE8crn2jnrOx4xrh9oKU1+eD++DjGnFB3U=;
 b=QJEqwTQRsu4EBX8jlmibp7oFM3RI5NyBNmyHadhxpVuBJWWiMVvO4fW2QRJ0jU9pI8Ec4y+lU
 PLZT5COM/mECJXCIXTIEVWVoL/6GW0dreW6Bu1HPrxvRCvu6mxcIe+E
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

The config regs seem to need a few ms to propagate the changes through the
system (like, PLLs). This improves the hotplug dp altmode success rate
on the Lenovo 40B0 dock to 100%.

Tested with T14s G6 and 40B0 dock on the HDMI port with a type-c host cable.

Assisted-by: Gemini:3
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 3533d4f363286..3ca2952e6a0a3 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -185,6 +185,8 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 		return ret;
 	}
 
+	usleep_range(20000, 30000);
+
 	return 0;
 }
 

-- 
2.53.0


