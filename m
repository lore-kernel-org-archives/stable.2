Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFD348C65
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224004; cv=none; b=GLUWLNaZonyc/ljQyxKwMasncu34YbQFKnJzj9EvyzsRF/oXU9XY9eIbtKMZN4DEdV3pFJVm6OSySOOZZSn64+BA3EzL27N+CSZGyX2MRItFsbMEl5rh4jyVapPizgNnIAIPFixmfZLCq7NU33FyX6PhhpXv/Xw+1XcHJ7d6Rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224004; c=relaxed/simple;
	bh=eisQEfeJ/HvnvTVrOBqfBqNdFBq6+q8S0tv4cbashcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiLTiN/PI7MiUili1xIKdX6B0GRuEEj52z/cWCMoXL/hxnd4r4yURZn53qfkAz2nivVv8PTrhi0vmGHBwoe6QXib5mxZhAXo9AkRIhVGVr71iAeYo5+31tdY+HTWdpYQem/I6MYFrqSi8DYxZURRictV5xQidh+Gv5k7pwx6EW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBT9DX3E; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBT9DX3E"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso5064869b3a.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224003; x=1782828803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5n9YuoKYEGmeCkNQpgVyz/eUHDik0ZRvpSPE9Gq8/4=;
        b=SBT9DX3E8nFknL5se4Y/OYnfoLiDJCpeGlgGmSxaph4iH5SpViD+x1inHH4ALu+qq9
         V22XZWBdrDoKfAOFDOuMDJ7H10QUNXk0u3MNrMHs5jxvUuxY5n6zyxGfA9ZgGoOd1oFw
         h1yNjSRctgwaeU6El1My1od94J8ZyjV2gkChYGGgrItQUE1qXlW2RET8sLiFq+pw+Fxl
         EzaB0PDDejHCnfvoLokSW+ezpq/xfmEPTXhvsAGlVFA++ijQ6S2TFhR6l5jOY5+n+sRN
         PV6N0z6FJcaxvRuHZNn6AsqWFE90EslTbxk92JvFKgY3X3bB38GvT/7C9EnmujkrRRl2
         MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224003; x=1782828803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5n9YuoKYEGmeCkNQpgVyz/eUHDik0ZRvpSPE9Gq8/4=;
        b=UbVLGmfJE7D6WrQYIxkAhW8xmQzLfRw35MFdwF0xYWncdhVAxNeeT9omj0KnMUUGEy
         8GoWudpbW5moetiJw8t2B8lOjmNHTyUR+A8SsNDefO1XEYPvqEYG51J60c3RwE89PFF5
         uV8+OftcECYWL2YeoFRL+8iHs84W18ofh9lccp1iZTA+M8GXU0xekSn4n7uTNMp9B5mH
         3LTpFZNVVbx0FvTobRzw9EDnYjteAp+dDrl+WULwUgjbtpGsEISpc/whdWnhJhMs9U3J
         KxZvL4ho1i8higaGN9jZyD+Lt/kVJEn2od3rrAqspq4l/BvgbI1QlkoX+U7GGzfPW4Hg
         JoAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtwRmtu95QtEmjM8ufg7BpclwZB5Fc/LCfd/03ExctuATuagbChKFtUmsJ5lz4BYnQyXtuGeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+DCaF7r6Ay859e/bbzHwASBTrqkyPL8LiTUQoDtVYduSk0FY
	jsQLO5D240I2Bm1N1b5D2yZ1HjeYwd9jmz7Bk3UkkWaMhrfXa0/XnT4J
X-Gm-Gg: AfdE7ckl/dUzIQiIZZZLmzkwJU+FK3pyYO7KryJatbC4cDH9C06AvA6ycPx6uAU8Xa7
	A579ot/NI0MaTNuqKCauObAcoCXFHT6ja7BJCvV3u26zRPzVbFoVrkTkbi/u2K4X28hCkgyMNiN
	+Ati77Hk5X0EbA0wNL/RXgaI00RB1gfk420oeYbmwU2q5Nxtk8c9oDtOgtZSftJIt5/tqUVQATB
	eja1/K0yUeErJ5WPutOhvEjJs5oJXkz4nj3acb+TMFJ5OwAUXMELfm292Lv+RFBFNVJvVHf+uvz
	78eOUoIP36pp1qutqPqmTX/jD9epDROjWUdh/npRXMSiwUK/Ct+aK5eJKhtF3QrdaK4ys7/qRof
	LcZyZbrt5JPH2tWHiw8P4WkXaYHg0NBfvw59sTVgLr1Bex0gLngHKbH5wBRDIycmAnXNchvJn1f
	U/domUmFgBIowey99ey/1TFs8Wa/8SmbPUt/EcStRcKJRFbpB4PSZ1eg4t/KpnC2+bI+uwLW6D9
	khXggeN4IvymXXoJvQXxUV2WNKG1C+pMfCLcYnhQkib
X-Received: by 2002:a05:6a00:3cc4:b0:842:46a6:e2db with SMTP id d2e1a72fcca58-84597044cf1mr3420277b3a.19.1782224002884;
        Tue, 23 Jun 2026 07:13:22 -0700 (PDT)
Received: from archlinux.tailec59cb.ts.net ([2405:201:1b:20ef:268a:fa82:9f05:61a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm10704480b3a.43.2026.06.23.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:13:21 -0700 (PDT)
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chomal <krishna.chomal108@gmail.com>,
	Yahia Ahmed <yahmedd043@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)
Date: Tue, 23 Jun 2026 19:43:14 +0530
Message-ID: <20260623141314.33947-1-krishna.chomal108@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP OMEN MAX 16-ak0xxx (board ID: 8DD6) has the same WMI interface
as other Victus S boards, but requires quirks for correctly switching
thermal profile.

After testing we know that (similar to another HP Omen Max 16 device,
board ID 8D87), the embedded controller on this board does not expose
thermal profile which means we have to intentionally disable EC readback.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_no_ec_thermal_params.

Testing on board 8DD6 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Yahia Ahmed <yahmedd043@gmail.com>
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
---
Based on review-ilpo-next branch.
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8ba286ed8721..94147102cca4 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -265,6 +265,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D87") },
 		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
+		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
 		.driver_data = (void *)&omen_v1_legacy_thermal_params,
-- 
2.54.0

