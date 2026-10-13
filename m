Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A6357CFA
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869532; cv=none; b=q2zV1GX9lD1zPsPj7CBJfV7uMoyDuCtcbeGqSCU+g87OxlaYGvGS1NTYt3zaxqI0RMugzL1unstw3/JIKgleCc6Jy5HzR9vPWQKySn7X+twbpHlhEyCPWs4Tg+7YZEH/7HET9pdwkOD4SQS6VrHzUABEghm/g0pYBwFxkcfBJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869532; c=relaxed/simple;
	bh=WgQOnPTi1tnL6fDuSFpQKEm9yu58dR/NyozQFaFmFNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHPAzandJpEwDHB59QGPGZGF8SQ7sv0Mbn/KuCoBH9v8brssIQdwOAJ/B9KhqcnzvT+g6fc4knmFE6wRMtgcA5ngRDebfU1U22gagOhZrThnt3fj+OuFLZKSw6LRXuB1FLETJ/qUU3pTKZUqAk+EI2M/cVhdoGfVJGlxdtvrqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pIxbmAku; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pIxbmAku"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 091BE3F2D4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791869521;
	bh=HdTkQACAxffrwnQrFwY6e5kcuV8v0fcWW79SSqTdU9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=pIxbmAkuqA+4pOzYDiKGOBgI+vHOEY/eiLWosrnvJskHsJwUr6fYLx2D0W78k+Sdd
	 rgeKl/SY6smaTLnRgkpE5eCNlWiE0HWd/AMg46qwTTzQKL5TGJHL3wXGhqGODgc3aw
	 Hb/II4pPdENKtr3SlEVcMt9yWbbAvObXkab1n/jPSe7nV8m5yN3EoV5ZTqLj7tYgeP
	 DTQJHuW6aRFnZetyxMAvlfth+aILxMwO7nPXiYmreEglhf4ViFJz/oC+D85r/O3eCR
	 DqBp/zDyckOrMIDfbcKlGZXpZbLenIRy9qDoX4F2xXG29pAq3kXlVlZHbf9CZdTsCK
	 F6LqMxQjZcE/CB+XmPXprYrPyBV/VNiUxSVb+l6dbgTDDUfyco3knXdTiA3Gd7Dnxa
	 6lkubTh5S01jmGgucc8y0+NN7iqhMhrx51ig1slm47JNxPBbsgtUqMHZ21l8zxIX/r
	 ED9UnzgE8khCdwfO8wv7BIa0JNv3H0rZR65k2VjfY9bw8Fom8GtkCFWs2bMwx3XZgN
	 L5MPnLsSqn8OnHQMVRlWGRRGhRqWDKzrASBN5ODrYARK6+OyrQ+mAPTss/dT4Ylyvq
	 tWs8juGP6crXaGcx7UuZpjjsWcdjxaEkXVbih/faFZXrzNq/wFOh4YrdePW7vvt3vN
	 TWLFO33DWnBQzXnFEPzUFxb8=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e605c92e3eso6008595ad.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869519; x=1792474319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdTkQACAxffrwnQrFwY6e5kcuV8v0fcWW79SSqTdU9M=;
        b=zJCNe0mkA3fJTpXa2G6rt4sUBzB/4vdbHxwgvZLHhOchqvs31r/+wvSdKADMFcvg8c
         sY8JXfURllNjaltZ/0KsCQEzZvsw4KFSMu/66Nvsy/fKbnCF+MKULoZRvzDZmI3oCL3h
         rNoSYlyeDe7XCxO7jOXDgJboIT4/kaQS5ik2CceP0VcrbgOe+ZOdeN/DszbGV+yDJI5G
         wHT2xG2n1wTlHGrgmKp/tLW3TmxAkQpb046vdYrLZ25DoXRkmJp5y9ECgV2W9zJuMtL2
         lxBRMkRaj3/BCQaAdlbNBfO5X4aApLeKzsvRmhcgLSk1c+ErPbQ+LGHeLlGaEbIKrz+s
         hpug==
X-Forwarded-Encrypted: i=1; AKwUvBzpPrpYAyknHd8bp8eeSIpCVkMmnknNK25Sp6HeKZhT6xRjdVRzxZ0GgkDv5AqW3vuhVv/4aAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUm+kUHkWWrwUUd6rzDEeB9+ytu1WlMfG83Tbb+OLYVv6E2xD4
	5Dw67kw5BVYbzm16CKQRy5mcH4Yi4hLYcTqEY5ORTgmuXtU6kEb6a0lnTDxolbJSnDnEopGcA7o
	voiIKUS6ulzQIFdYNZWzsGfGPfLDjiy4X/LO9NzmZKk6pYVXlyRmCf5Iwmrf+cVajfmRXO+7QIa
	C75L/gOg==
X-Gm-Gg: AYBFou0Kc2+6oYI5VI5qhR/YUNdo3yLeQrpNLnw+nbmwraJ1aJDBHUQERz/Lus+0XQc
	EhhGkPQD0GQHwzFncg5btpYse1Ur5EMOzc8RnUhJpkt7WOy2xqJmhneWV6pXU8ww8l28zgkpKus
	7i4p01dxBrGGkH0lfco53dvclE+LI5aeZivct/avwAu3PrtYCEsHGeRBBansMeck+iwR306PIJ7
	2wN6V6XR3anPoLoYrGmZkRNN3KvRbTuUeipoUTX+/brirfaM4dA2d6at7u8NrIV72Y9EB+gb3Ps
	ObPk2Z3EgyUhF7lRy5l7I+jwW9K8B4yPnYgzU2N4Zbm0hUX/eRoB2a+vFuXyxyhDp9lrXVlU+lu
	scifH0/JOqg9nEB7FYf7fLEHWAYFfixR1Bt6NvXF9+hBLIfv8dCQP8b4PaEA96gDeuTukmUcZhd
	C9An+ldPSQLHD+C97ChB4R1QAdvtjZ+N6riIW7J9LilMefZFnWPs1uLCNzj9EBmxM33GY4j4b0V
	8jFMONj/fN8/VmYPJBruJe6JqqA4KVtVHXmixJ0/ho=
X-Received: by 2002:a17:903:19e8:b0:2df:8909:f719 with SMTP id d9443c01a7336-2e842aa4aaamr159737415ad.3.1791869519252;
        Mon, 12 Oct 2026 22:31:59 -0700 (PDT)
X-Received: by 2002:a17:903:19e8:b0:2df:8909:f719 with SMTP id d9443c01a7336-2e842aa4aaamr159737065ad.3.1791869518908;
        Mon, 12 Oct 2026 22:31:58 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-f0c9-fe5f-a459-fd93.dynamic-ip6.hinet.net. [2001:b011:2008:445c:f0c9:fe5f:a459:fd93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8483c3dfcsm48724735ad.24.2026.10.12.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:31:58 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: guard debug dump before hdev setup
Date: Tue, 13 Oct 2026 13:31:18 +0800
Message-Id: <20261013053118.1201636-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An MSI-X interrupt can reach the debug-dump helper before
btintel_pcie_setup_hdev() initializes data->hdev. The helper then
passes NULL to hci_get_drvdata() and crashes the interrupt thread.

Return early when hdev is not available. This covers the GP1 and GP0
error paths while leaving interrupt handling unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/bluetooth/btintel_pcie.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index ac7193400769..8d7927bd75b6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -297,12 +297,17 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
 
 static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 {
-	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	struct btintel_pcie_data *data;
 	u16 cr_hia, cr_tia;
 	u32 reg, mbox_reg;
 	struct sk_buff *skb;
 	u8 buf[80];
 
+	if (!hdev)
+		return;
+
+	data = hci_get_drvdata(hdev);
+
 	skb = alloc_skb(1024, GFP_ATOMIC);
 	if (!skb)
 		return;

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.34.1

