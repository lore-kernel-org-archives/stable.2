Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235D53F699;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079633; cv=none; b=MDekBaIPqy7EcV7jWOY9q7xButd7Yj1P4tK+bROWc8gf/hni02Xi6DG0Uuh3CeTCiZqMH4C3wx/wLMIyaYkQEOv5iZd+MoG3LBgNFAau0tlcSQsN3jGdo3/A4s1qEBeIoD5jXJwHEGQiliZ2u9H8y+TbOu0lIS27bj6zCUO3v2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079633; c=relaxed/simple;
	bh=4O8ZQghr/b2vo2kcWDO8kn89KdXTM4f5o7tWhR1fOhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pA8fIk+HyfWuQEIyAKLRPp2Iaf43rhU6PxSIIfTf506+tiynXphzcW8Mj6esgXP0NTFmDgH7MtwpeKUi4MQcy8G1zka5JfwHbCuZ3d7w7UqpDFDZ/d8MQAVL+GDMZdH89rjBjBXQdS4DsULv+U709EEtjmDM3RoFiYGwVdGv8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn70OdqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn70OdqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EFA9C2BCFA;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790079632;
	bh=4O8ZQghr/b2vo2kcWDO8kn89KdXTM4f5o7tWhR1fOhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wn70OdqZwZ1wFYRIT+PxEVfgNktkLt0tPtc+7uQbvr2+WdF7BeMmyUwc/geALR26+
	 sL2LFP2pU7VxatZ3U8s+jl/mZFcTslcCYpIi2AEQFIyTRHeqbF0l0Qa7liB2ZjVHIe
	 zUprqBQwZJF9QrnMunwLCiN/IATSfip+RO5rCKDVGuRUWRQSH+0wyyhfLHbN9HO/92
	 ohy7pm3PflafAjxO4n2ySpQPnhbT76H3WmzM+97ElPq+BNaQ3rsZvdSH2bUkbmdyPb
	 dBXNV93yVnGZdUiLez7bsDFxxYm0JH+nqydxyejUZWpT+7pcSo3dDTf0nl5HJhPy+l
	 eXFMnhbiGg1ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CAEC982FF;
	Tue, 22 Sep 2026 12:20:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Tue, 22 Sep 2026 14:20:19 +0200
Subject: [PATCH v4 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ps883x-disable-usb4-v4-1-0a7b5b70cba3@oldschoolsolutions.biz>
References: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
In-Reply-To: <20260922-ps883x-disable-usb4-v4-0-0a7b5b70cba3@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790079631; l=875;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=bPpIDIw9LIDQr0mVlf5HDy4Ak7MRxbqehghQmc4sQjc=;
 b=LYutUwrX2NhEe/07FRonVp2SR3z0wNds+7OPGUhDO9gCbp5nS8VTeUNYJt4pVMzHfseNlg5iV
 Db7WH4FZV3EDfYpjCdUuoqIVJ2UhV6XHPiXs+HhZ8+NoLyZdiiE3NfK
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


