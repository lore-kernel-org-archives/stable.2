Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F819541E70;
	Tue, 22 Sep 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079939; cv=none; b=UC/en+jSxzaOYN88rbqR1wHJH15A4rW+pofMjvxm+ExNRofg+raa8bHwx/4htWWlg7kGXV5c3z/01i4OIzzwP+Voh5grO+ywKg/7Xyu1YxgRuTOz522v87hM6cEHkTktyDznCCRG5U6/i5U7+d82Nxgr6hKXCaJZ3mH/c2Rn3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079939; c=relaxed/simple;
	bh=clE/Z0GgrzUztm52ZjbOdzeW8qM6TbuOhxaLVgLTrBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUjwxjY5liZD7XyTxwvyUBQh/nOR+VUNAr66KpSp0wmrZXh/LNNFUrS3b1Ais+bBafqtzmpYX+mvRusbTVJkgnVpwIrNyJGYNO0JymkkzV+5wZ4m8pgNLoMm1fekcopRXcSJHULak1hiOld48rR48W0vtEMne3AI0JX/5RtBH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4S20sHX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4S20sHX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAEABC2BCFA;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079938;
	bh=clE/Z0GgrzUztm52ZjbOdzeW8qM6TbuOhxaLVgLTrBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z4S20sHXNHL5lvdi79UWNyebtzslKhBgmtsZ7JTDq5qUOaECzSK7b5cd52M+Evi1k
	 YYHgAQE/KnyEvB2CUZpMsZmbN9p8C4EgfQZ+2y9CdDp2RqIKKeg9qruCYpjF5gHc3M
	 RZe6Q88v98ST+m7n6hLjFN2BUSnUvYR1RjaOmpBrdej30P6sXSadYRwejTe0ttSRQu
	 nyUitPKtgyFhTuvfaq1sjsai8BF+hFqZROSHskwq7JlP/u9+3ICBm0VD+/cZ32BNv6
	 G0RJuGFm7M1JRyyXv96jXT+a2i+HR6GO8jWaFl8oWv4m6E7cvEcP5rredmMrk3Re4X
	 3tdU46DetlsAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB8FC982FF;
	Tue, 22 Sep 2026 12:25:38 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Tue, 22 Sep 2026 14:25:29 +0200
Subject: [PATCH v5 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ps883x-disable-usb4-v5-1-02c0414978e6@oldschoolsolutions.biz>
References: <20260922-ps883x-disable-usb4-v5-0-02c0414978e6@oldschoolsolutions.biz>
In-Reply-To: <20260922-ps883x-disable-usb4-v5-0-02c0414978e6@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079937; l=936;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=qrj1s2PpCKclh5EwyG0Vo1P7ZOCUq/0XCQs0f4FZ16Q=;
 b=UsUnJYK41hJDcR8atDqzP2I1B5ohBA6G4f93GKWut/HuRECF/YcpsV+wX3xdtjs/rt7kiwXUh
 hLM0BL1z4TWAnnDJ5mvYBGfUCIws8YGHSemc+CRe/rPhpthKbdcp12Y
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

Group it with TYPEC_DP_STATE_D.

Assisted-by: Grok(xAI):4.6
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/usb/typec/mux/ps883x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 64e0a61b776a1..a5696aef054ee 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -207,6 +207,7 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
 
 			switch (state->mode)  {
 			case TYPEC_DP_STATE_D:
+			case TYPEC_DP_STATE_F:
 				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
 				fallthrough;
 			case TYPEC_DP_STATE_C:

-- 
2.53.0


