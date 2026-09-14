Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACC3B71C3;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365931; cv=none; b=Ro4LLj5S22ZQEYkpH7APFyi6gWGrdYpxFZtzYxG4dm70Nb1eOag6BzYHlmAn1zal01ktKpJyMK1/n+MukkUw/C+WZYljpKnkuSlmS5ce5solrYNWHMUUsrdHg6WGnETgznNKzFw9x4OIIXG7bO8HDexL4grZkkWxX6mUjnGw3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365931; c=relaxed/simple;
	bh=8kG6KLZ/vXkLHtYqW8vR80+dqHlLUX+fn422OiemX+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjV13FhZwVZVzy1vRVqAlUXEfTeeDVvyuq8P57htK1gIuj5hfE98j1DLZ0YQg8nyGNSIdjT6mpt/8HD78xWIkyjuzRlkIF2wKfgHgmWy2TLiD2ZdgxDvfpy7kOevPABm+hNO2LcSU9/537x9duvZ8J7UvDWHJF95vbVh4F9HDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeR8//aB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeR8//aB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35EA4C2BCB8;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789365930;
	bh=8kG6KLZ/vXkLHtYqW8vR80+dqHlLUX+fn422OiemX+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZeR8//aBvIreKvftWKGc3/J7wRedhUHJi+mtu2fFXh3DtVLvCtOUnG5LP9XSAP3tW
	 EEMKUgCTJYjJL4jXQas9QyLCwObNObQFJQFxsqgEegLrT4IfsCl+35wXEa87/WQWMU
	 14UqlC+6EbqRRTYiW+1BkKKTBk+0o+/SU37g2pkQl2jQO8jRgULai+dDQF8dWwbQ+C
	 4X2EH7mLSqcf/RyqvosopyPv2XdjAGQQWvg+TeQ1sEc5+q5uEgqfZGJb55RVNL2dQN
	 xxYATpB6PMtPSRJiC39S+AuynWyf5cD+PpBr1rTh/VpGGkImB83ggqCVIroPwiqesm
	 dhKP0iuFun1AQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE90C88E67;
	Mon, 14 Sep 2026 06:05:30 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Mon, 14 Sep 2026 08:05:01 +0200
Subject: [PATCH v2 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
 like qmp-combo
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ps883x-disable-usb4-v2-1-523c32b4e4d7@oldschoolsolutions.biz>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
In-Reply-To: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789365928; l=1579;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=F2k80G6jUb5W7CRXkl9CEtWdLPEsEUv204R+yHY6szE=;
 b=YgoeL87oC3PMJdVpB4cGFDkryUSgij3jdjvckuyMrT9R+h7l1ADGu439DHUB47JiQqfMrgcB0
 U6HVv9nIdcBCMgGSor9mCFIkwPoznw5mYd1bnrZ5eK0BQ5kItl9iOZb
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Several docks, including the Lenovo 40B0 and SSK SC220, still send the
legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
Mode spec version 1.0b).

Keep the handling in the existing DP altmode path in ps883x_set() and
mirror qcom-qmp-combo: pin C/E are DP-only, pin D/F are USB3 + DP.
STATE_E is grouped with STATE_C the same way.

Assisted-by: Grok(xAI):4.6
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 64e0a61b776a1..c185d8897e3a4 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -205,21 +205,24 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
 				CONN_STATUS_1_DP_HPD_LEVEL;
 
-			switch (state->mode)  {
+			switch (state->mode) {
+			/* DP + USB3 (pin D, and legacy pin F) */
 			case TYPEC_DP_STATE_D:
+			case TYPEC_DP_STATE_F:
 				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 				fallthrough;
+			/* DP only (pin C, and pin E) */
 			case TYPEC_DP_STATE_C:
+			case TYPEC_DP_STATE_E:
 				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
 					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
 				break;
-			default: /* MODE_E */
+			default:
 				break;
 			}
 			break;
 		case USB_TYPEC_TBT_SID:
 			tb_data = state->data;
-
 			/* Unconditional */
 			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;
 

-- 
2.53.0


