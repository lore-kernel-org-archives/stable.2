Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6B439350;
	Wed, 16 Sep 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587414; cv=none; b=YMTW6oVq8Ta69UcMngUwvXn+F6SD+qeOPGmuv5sc5anFVwBwgFwFgsG8WipERc6bipidfNH997nHoN2xXhUif5ITIlExCkwlFNy45c95g9doO5t7xR5JzV1RSEj20JAw9xRbwbVCuR5n7UeT89Ytf/3kgaYSiAJKtopWc2o3Mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587414; c=relaxed/simple;
	bh=4O8ZQghr/b2vo2kcWDO8kn89KdXTM4f5o7tWhR1fOhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgA4C4twtyCIRnuAO7Isl0QBEPc3Ha4SrONepaftPeCgGWxZIRVfpfkmR43Q3zGcbyMp/cfo/L12wgDKZyAERiwiKEiM9Js94BQpx+S9kX4PiohiORm2UEDdaZ6YDgectETTbR2ibLpJpx/RqR+nYZmWdqIh/2GYqTVeN5wVhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q02awxWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q02awxWm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7198C2BCB3;
	Wed, 16 Sep 2026 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789587412;
	bh=4O8ZQghr/b2vo2kcWDO8kn89KdXTM4f5o7tWhR1fOhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q02awxWmAFFVGsHVK6U71zK73Tm2UaLh2VJ6qoB2XSwZJ97HPwwJHH5FqAG09dHhl
	 g0GVKiG2RcGjLXvWxlVmgx995t8Xdoh6lT2xLNP/dZjhOYgLaqq3QTSIWm5+BO1qx4
	 9uYfJcSvjhOFbxDrcRw3ugI4T8xjMxV3va0VZ/tjaQNCqs2xW3tC681GRmWpmtSllh
	 XLjE9QG1mZ8Ve1JLbzZ1+HKYE7i9UOSnI792c8FxdATJUutQU03R1xIKQFDv9P8Hil
	 0Zb4JteWnlWy8W8soV4QZSQwGnBOgGbqk1RCbU24DdqjZtkmSWs5INBxtIxLpkJ1pC
	 zy1ROsZ7iA7Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA45C982C9;
	Wed, 16 Sep 2026 19:36:52 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Wed, 16 Sep 2026 21:36:32 +0200
Subject: [PATCH v3 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ps883x-disable-usb4-v3-1-8f19386456d0@oldschoolsolutions.biz>
References: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
In-Reply-To: <20260916-ps883x-disable-usb4-v3-0-8f19386456d0@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789587411; l=875;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=bPpIDIw9LIDQr0mVlf5HDy4Ak7MRxbqehghQmc4sQjc=;
 b=LHj2y6UFpyTA572+L/o2uijs3EUo/ziZR1xwCz0JVVwZk/Oij1hJUry+VHgMYX1ot941lpRCl
 UTNuQqXro43DJeq3Vt98QbQUQ3Ik58/R/whW4InCspZ5g5knYC598B9
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


