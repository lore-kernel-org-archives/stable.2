Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EE39A066
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039628; cv=none; b=dsZhUyaYUX9A9FvuALZSvBZx4VOIVDLZErTYiVZVYauivocAWJqt4gvCTs1WtB+k1uc9ZUFXGFHUAnt12tGfa6FpfU3W1KDHx/zYwc1N90DcijuJ/dykCjLJoWfyUwd2XqC1IeCdPAEDIRQvxC5ePUko6bQE8/LO2l2nti2pAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039628; c=relaxed/simple;
	bh=Ped+zqLUslVgbPE3HWrgAyfVG8YB0HCdirTQPRX8HA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVxCXAt3IuFimAq/AhZlQtldxC2UhSxE81SG9aX+2iJvaj5uHpHhIeMafEorbYUbca08XO37zI71ewHWjqmQTi91jHg4DtyvdD9XUXIufsnA5UM+07xMW3DENRZD2Bo9MIrHNQPpDCODv0obNPLkk7HVPlbuxk+heAnr2F7vDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2o+QE98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2o+QE98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822C1F00893;
	Thu, 10 Sep 2026 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039627;
	bh=ezgAWAY8D1yRejQtcVRU2yZdlBAoozV+6uThOlbRd6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2o+QE98X+PBQNIKI+wrHXxVMTxvxbZdU8c4hqfwGQVwoaWTC7BiEfNaSD/JNK7P3
	 eecoRDa3RHwrnyg31h2NwdhvvxTHHdzap2Wfn8htzDnOApOW9XF66bJhE2ZtRbnbOr
	 TP+RUE2ifFCwNAtEbyR2ECntVzpLf1yS6UGPXNxVF7rBdPWGkLLlHozSrOLz/nUdYa
	 XNtkcatRkbZo1unx3xJzsR4BErKYkOesZqvn5a7WA5Wk14ue1Jz8SbqyyIgHcEAI1a
	 TMRBpR3LQ4K3vIZCAqfaInZAKSMkvZvKTu8Lf+Zkx5zMDnyo7V2s0YSYzndVDakrf1
	 HX2lrdzhbgQeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Thu, 10 Sep 2026 07:27:04 -0400
Message-ID: <20260910112704.44538-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910112704.44538-1-sashal@kernel.org>
References: <2026090822-abacus-psychic-5063@gregkh>
 <20260910112704.44538-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Bilal <meatuni001@gmail.com>

[ Upstream commit 28a289beaf226b30b1e6e7d7b1a2946fe2d6e852 ]

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260728125456.32359-4-meatuni001@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 0c8b1541f243e..258972f6de3fa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2025,6 +2025,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.53.0

