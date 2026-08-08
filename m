Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE13C37AF
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786184471; cv=none; b=Y+Mss0RXqH/BYW7UOT19uF1+ompa4kDj6HLX7txrb77MIV6UVHVB/X8Hwxv08rm8wdixTwIA+gTZS5AruwxwUTlozMCkaKZjYZSWUiTBSJiTepLx2SNlYK6PAiUL3/bkUkj5LWsQvya5MnmstAA3mMEG3lgM8OpZxBOjAdamJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786184471; c=relaxed/simple;
	bh=RXpVzpt7di1+nGOPxTbhDa4AoMa4uRQ9RAyXrUYqYH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKR1yF/liIBYCr4z/ive/7KZ2K7eisJpNPocEFpZfugLdvjLb6VWRLO8fEzjW39EfjWpPQnU82FpI8XZBLq2oVrHSugcs3wS3zUa3BhB27Psf9UZyQZCrrebUcxDn976izqeeVhxpV5pJyc4PqQ81Vmb6C+5j57n4sobOUeVMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quFBL+oQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quFBL+oQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955de8797cso2255885e9.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786184468; x=1786789268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQRg1mejXL46bQBa0p78UFbpH6Ut5RwhVRoCIO1su08=;
        b=quFBL+oQvWu8pzBnRtRQEKaW4d/OVtub9aNNuJ0wiEJT7nJ3d5B6i072GUnY5muwZT
         90yZIybX+v/zMJyK0ci92DEUPp5/PflLc+cmDhS5ztxH0Oo8RNmsrqaAYJkIXNpQGaqn
         KWwFuz7rv++8A4YW4EjT6XQiGFC7/+3W7TVGOogoBPwRPc/RJ8vOWIU5MuwNUNR6IJJ1
         Je+oifvhzVdJplKJ8Arnucj4pFkAQCLxmCZQd7tUt9Keiy7NPAEYvm2zWsKPgkdOnKdP
         JVoFpt1h6R50Ys6XTLfLstTB4kC11r1wYyUhUN9+/Avga/Efkl9cof3N+wHUcitXzVvN
         1dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786184468; x=1786789268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQRg1mejXL46bQBa0p78UFbpH6Ut5RwhVRoCIO1su08=;
        b=WrSWe/bA6R/Y0eJNsBYiOszpIG8Ibo8RpguM5crulWVxAIzFXSuF5Unk1kujCj9757
         gd15bCOl7gw9nExGuRXe+3facqi9/QggQI8s3wni0N15UXBMcTNCqzJhyvF6+vXnDlZQ
         YxA37OJv8YosGGGPz0YdY+i/OC798nEW4PkYdLWoCAQMHkWfQniu9MUAtb7ZXTRrDdYW
         e+ptOJZ6KQI6uWqfZQz+g/zHez+VvD0IB35RGhEemZInlOHn7pmfqAoS1qTkZEFABLxB
         AmeeCsh/NTHWyoay/QsUWojkjwWKq5d+0BydbBec8/2deokmOO+1YzUrK4Wq1uq9JMq1
         72Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7d5+oFD+0TsiWU7snuVfQsWhB9xtm8vaSXnLcn08rPf58FaA6ccobEAf8YcT1BbNguA2Bufg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPeqjPRi5rufVWVmszPjrtXD9mlFE6mczHGrMmtnY04YMkGen
	osKzLo05V1QVMztoleXAJGbxZsF705gH7PeVdEqxnhPBr6bPMdhPa03b
X-Gm-Gg: AR+sD10gwS+BrrU0BCwYKvpP+RewI38ZgzWGL1Qw1KtWCXJX/IlLAPyFg2iw6aE3PCG
	OY2LQ7/0cfbrAaKFAOO1Q6GKEf7Jw4sQhqR3/4arrGJRHl/jdalaaP7AzTkVgSfOnS4A7Qf9onG
	IncV2JDXA15U3BvGNYAv8EWqvkGNH6emzF9bE4WAV1JLo9S6Y0i4JSSPTgCwrLDXsNRcp4iGkty
	chkv4d16pHdS1ZwPmumgVYqjExTafcZGhvxud0qXCmZIKczeWzCMqqcfYTPM8E5NaeHpV1UITFA
	QoZhgZ4VPvE0FkVQXppVS6dH74zyzVrt2bSB8OHnfnBr16jDu5aZgTWKNbbcv1a6EhiaqFJkHXc
	9100VjQVdX3u1qL3uG/li62Jl4O+CBC+W51zA5UMSgTkBgn2gK5iXC2lCrz6fq4YYYQo6bcUekP
	suqEvkP92PUtg1ssUM/rkoMTlu04FIEZDO+G/Fc5WmmSgAmYyo2QOAxBSiB3Zf1bUvkSyZX4t2J
	Z5kk+WVW8Oakzlq2RHeKnugRdUDr3JhqfkEtS3J48nfvkdKvyo+Dfu8UMgQn+WTqUOGkyfuYuhI
	KFHkcsTadJodzarmIn6n
X-Received: by 2002:a05:600c:1987:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4995e0dfb2emr138243805e9.16.1786184468167;
        Sat, 08 Aug 2026 03:21:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm15256604f8f.18.2026.08.08.03.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 03:21:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Javen Xu <javen_xu@realsil.com.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] r8169: give RTL_GIGA_MAC_VER_EXTENDED a distinct value
Date: Sat,  8 Aug 2026 12:19:41 +0200
Message-Id: <20260808101941.57666-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL_GIGA_MAC_VER_EXTENDED implicitly follows
RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1, so it has the same value
as RTL_GIGA_MAC_NONE.

rtl_init_one() therefore sends unknown chips through extended detection.
If TX_CONFIG_V2 reads as zero, they are misidentified as RTL9151AS
instead of being rejected.

Give RTL_GIGA_MAC_VER_EXTENDED a distinct value. It is only a detection
marker and is never stored in tp->mac_version.

Found by Clang's -Wduplicate-enum and verified with a QEMU stub.

Fixes: 5e3c5a2b85da9 ("r8169: add support for extended chip version id and RTL9151AS")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 0b9c1d4eb48ba..fb772cc043105 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -74,7 +74,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_80,
 	RTL_GIGA_MAC_NONE,
 	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1,
-	RTL_GIGA_MAC_VER_EXTENDED
+	RTL_GIGA_MAC_VER_EXTENDED = RTL_GIGA_MAC_NONE + 1
 };
 
 struct rtl8169_private;
-- 
2.53.0

