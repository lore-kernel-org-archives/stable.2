Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FA2EBB9E;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394392; cv=none; b=m2+qen8zV70Ei7A1DDcQDa9WtCktPx/kmIbvg6XlswHbq6Sr5ClxGoH53raawDF9fexptu6DbyFPhS2M/mr7C9ZsgAlIUJaNDYU3H7uo0VxjFamjfV4vDwUBvyraYWxg4ucRM8wS6iaHR47uYqkFihICix9hfS6qZIcW20sz4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394392; c=relaxed/simple;
	bh=UW1Qw/MJ0iETpdOiiPZH+qGHzRqJ1PqbxreRC543erk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHXT/C+0ci3g+9l9n0XoYvTxUgsCiLCAq6tq6BSRI3Dn5WTianfBC1GZyfUNC08/Ih+jTXSpd3+Z5Q09oZm1uW/PkSiZRLp3GFuqv0mJJnBBGSpr0w31AjiJWRmbdUv0bibNecP8xedtbpM7cwSlONuFJnmaJdOpLUWsVAqlJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMqnkm0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMqnkm0z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A4CEC2BCB9;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784394392;
	bh=UW1Qw/MJ0iETpdOiiPZH+qGHzRqJ1PqbxreRC543erk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gMqnkm0zrEpb1KpFQ19eI6bmgDCL68IJz5MrmWauNliGW/E4CPfciCTkcCTFNTOg6
	 NOD86YKcdSLXkPugphC28pAafzbj5wXUZwBFpZHNQFe6uXHPxbc9BCHE8Idmtczw/E
	 r47SP3InhDwXwMhgFtZgcdBIuntvKsrbGnnhaTCphASn0lqow9UKrY8acrotlFp+W7
	 foYzeSvrfyECTJmSwYW3Q3hMtROPNPa7bOdY+r0vLLAG9WFpoPHGlPEzUwiw+TTYBd
	 45xNTwJFK0ZKJ2Yi9muE9GjDb0l1sQT5BZCZPF7O+MrTFMsW3AUG5rjfiXFn/BOEPh
	 XnyWMCsBo7YiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14367C44523;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Sat, 18 Jul 2026 19:06:30 +0200
Subject: [PATCH 2/5] usb: typec: ps883x: Return -EOPNOTSUPP for USB4 when
 parade,disable-usb4 is set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ps883x-disable-usb4-v1-2-cec86d0b909e@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784394390; l=2343;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=DJntb/TyC1gmbUdn71tBrUvPiFUv1X0w0aqISPM2PhU=;
 b=CAXvuO4hivIPZPM+OxEeKl1vaYFBvOFTqlCECok9dJRZt5EDOYOVhOwC3WdOYKQmSFHOi91+9
 OuVaiSVy+NeA7TucTUKKHSBns+XXfKouIZoItJxRqiLL8rcGT8nyBP2
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

On Qualcomm X1E80100 platforms using the Parade PS883x retimer (like
Lenovo ThinkPad T14s Gen6), hotplugging USB4-capable docks such as the
Lenovo 40B0 results in working USB but no DisplayPort output on the
dock's HDMI/DP ports.

When the dock negotiates USB4, the retimer receives TYPEC_MODE_USB4
and forwards it via typec_mux_set(). The qmp_combo PHY then selects
QMPPHY_MODE_USB3_ONLY because no classic DP altmode SVID is present in
the state, leaving the DP transmitter and AUX channel disabled.

Add a DT property "parade,disable-usb4" that, when present, makes the
PS883x driver reject USB4 modes as not supported. DP altmode
configuration is still applied if negotiated, so both USB and
DisplayPort continue to work.

This is a temporary workaround until proper USB4 DP tunneling support
is available in the X1E USB4 controller and qmp_combo PHY stack.

Link: https://patch.msgid.link/20260312101431.2375709-1-krishna.kurapati@oss.qualcomm.com
Assisted-by: Grok(xAI):4.3
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 64e0a61b776a1..3fa26ce01a9c9 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -62,6 +62,7 @@ struct ps883x_retimer {
 
 	enum typec_orientation orientation;
 	bool in_reset;
+	bool disable_usb4;
 };
 
 static int ps883x_enable_vregs(struct ps883x_retimer *retimer)
@@ -249,6 +250,13 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 			cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 			break;
 		case TYPEC_MODE_USB4:
+			if (retimer->disable_usb4) {
+				dev_info(&retimer->client->dev,
+					 "USB4 disabled via DT property, rejecting USB4 mode\n");
+				return -EOPNOTSUPP;
+			}
+
+			/* Normal USB4 handling */
 			eudo_data = state->data;
 
 			cfg2 |= CONN_STATUS_2_USB4_CONNECTED;
@@ -378,6 +386,8 @@ static int ps883x_retimer_probe(struct i2c_client *client)
 
 	retimer->client = client;
 
+	retimer->disable_usb4 = device_property_read_bool(dev, "parade,disable-usb4");
+
 	mutex_init(&retimer->lock);
 
 	retimer->regmap = devm_regmap_init_i2c(client, &ps883x_retimer_regmap);

-- 
2.53.0


