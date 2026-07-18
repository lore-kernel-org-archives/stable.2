Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73A2EE611;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394392; cv=none; b=tcbtb8z6aCL82EwP7qbrIWcCRKXYl03z4x2mgQYaUW24zpKPPshipNn0d8nlWeZVf+2wyssoQEqqaai95q4ZDH7RRxkl6wMiQbO29zdi9glYaC4U0S9M2gM2vbWxSYm55fUoZJ0TRnwhHLDoW8EJ0WNo7d0gEqbeT+yg1shW3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394392; c=relaxed/simple;
	bh=ayOZZgpJFuME/7GYyqcXWQwVViNcJBu8CAoLVrcYsnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGHS3jlAhZykP4CU5swX/u4sF2p2VO+WyZDVxPKGfdJU0fl588+ogWOSij65Q8iCJxxp7Ds6ncPAkBg/MCWhAmw2ufWBgaVmENpNmSIjuTGUaxgdT1+pFagP04aHejGWIZCAcau2FAV7n9ksH5E0rfkFaP8R4ASM7pMMkXrUATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNQyUo9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNQyUo9g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 457F6C2BCF6;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784394392;
	bh=ayOZZgpJFuME/7GYyqcXWQwVViNcJBu8CAoLVrcYsnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BNQyUo9gmpIVm/c1F5Eij7YdR5ifSgPynl4ThOPR/rLgT67PklGK28A3eYn9YSuT4
	 5t9u2fqSWB+cp1WPl7w8drfThTMYVUE3xzxzdAFOA/TJYQKa8SYf+EoJNyANt9L+Vx
	 ELoXJs5pkGPB6imLxoSArhQT/fV4t3o9090ka3lHf7EP9lXSigRcXhPuF00kpDAZQ1
	 KjWaEECoyYTOy1dZjKg/2b3+b7PqUmv8zSlp0J7IlmDQi+d1OyqmHzAVAVYhuwqWFb
	 vbJeg4G02X6CFPmEz15swpHmcM/LHjp9mPeACzoxiBNEeOd6DKWL+Vm4xKHZhC5tf3
	 MsVEspy+5KtTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8FC4451C;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Sat, 18 Jul 2026 19:06:31 +0200
Subject: [PATCH 3/5] usb: typec: mux: ps883x: refactor DP altmode handling
 and support TYPEC_DP_STATE_F
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784394390; l=2353;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=dFU1K6ePVlFZEJrflk6Gm0o53XRE02GqhkNK5EzXxw8=;
 b=ELkTs//0vo60nxPca3TX0u3tNw4wPNwFcDRhMjHrQa28cjpRi2VZ96oRD+Gy78p2oCTdYciKI
 5J9bHHx4H+NBY9gidSa36g1TK0PqaDXXksRCkibCwgAHChLgvkxFGOw
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Several docks, including the Lenovo 40B0 and SSK SC220, still send the
legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
Mode spec version 1.0b). Treat it as USB3 + DP altmode (same as
TYPEC_DP_STATE_D) so that DP altmode works correctly, especially on
the 40B0 in Type-C fallback mode.

Extract the state handling into ps883x_apply_dp_altmode() (modelled
after qmp-combo-phy) for consistency.

Assisted-by: Grok(xAI):4.3
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 3fa26ce01a9c9..3533d4f363286 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -188,6 +188,25 @@ static int ps883x_configure(struct ps883x_retimer *retimer, int cfg0,
 	return 0;
 }
 
+static void ps883x_apply_dp_altmode(int *cfg0, int *cfg1, int dp_state)
+{
+	*cfg1 |= CONN_STATUS_1_DP_CONNECTED | CONN_STATUS_1_DP_HPD_LEVEL;
+
+	switch (dp_state) {
+	case TYPEC_DP_STATE_D:
+	case TYPEC_DP_STATE_F:
+		*cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
+		fallthrough;
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
+		*cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
+			 CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
+		break;
+	default:
+		break;
+	}
+}
+
 static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state *state)
 {
 	struct typec_thunderbolt_data *tb_data;
@@ -203,24 +222,10 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 	if (state->alt) {
 		switch (state->alt->svid) {
 		case USB_TYPEC_DP_SID:
-			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
-				CONN_STATUS_1_DP_HPD_LEVEL;
-
-			switch (state->mode)  {
-			case TYPEC_DP_STATE_D:
-				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
-				fallthrough;
-			case TYPEC_DP_STATE_C:
-				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
-					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
-				break;
-			default: /* MODE_E */
-				break;
-			}
+			ps883x_apply_dp_altmode(&cfg0, &cfg1, state->mode);
 			break;
 		case USB_TYPEC_TBT_SID:
 			tb_data = state->data;
-
 			/* Unconditional */
 			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;
 

-- 
2.53.0


