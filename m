Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000536;
	b=3I3gWp4WrRih+OOzi+k/pno3KqClElzWzWUK6XotDjHRBedRigG1toNGS1vq+lOp0tB1
	 /zCXweOUb3VU4+KbzUCq6fUYc7cQlZ8dS2zKORO8l8EDvotToD4oeuvtcFn0hUJJ9Lfsw
	 7hTXi2zgSnuccCtAD3rZ/py9UOG3Pc82yFMqWYixQQ6nUotEnJufGew4CVre0KUHgeEKH
	 b0GIEt46pA++J6htbBwepOryBkRtBmij4UNPJ3pyZzaqY9aTO8B2sVXyVanhMCgk8bmVE
	 Yun0L7C7fGSuJePWeAWveFQjdycEuJLldEi9vBkaTz5JV5EMPzhsaOL75+u0oDQO+rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
	b=kk7PRDrtQMISc9kwTZLXUk91pNjWspiLfMkDrvoP73CmfqnzvilsV7u0aRJcgHDAUzZE
	 0kjqEaLPe8Gu14xgioQKW3YMMPhrLv7PQ49AjlqXLsnzqCVSInYbkvqhMRIHZkeArhhKB
	 WoJmLt+E+z6pIJR7Muw76Y+QDVaQgg00GQKlRbTg0zluSNxpaTV2ANZmw9068P0jdmGFN
	 5HO1g13xRmfscfWw4jXWvV8YUNuVW8iOrRpZ51H0mAIusOuvDw6pc6xpcLTRGLUUS1FRQ
	 7lH2Qlr2RhOUu4HZgSrgNzeYBwvWtX9tIM6Z1Y6jk6rdGayRCtkRrFnjoJ+1boj5m9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bHdFKU/4";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228660A260D
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E228660A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bHdFKU/4
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso407359a91.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000535; x=1795605335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
        b=bHdFKU/4t+asVDt9njDBPNmVxH74MFAD4wsINbAc3XgW5M2Fv7OJDVzO3vtyztUnoQ
         mcxDv7NtU3WYasfNf4dk0z5bnPThVh+BfKP/wO6jgOyndTDeqNKdFhVtubTrRWN4pkqb
         J4vteOADSYMAGg11dr3R0zuaHd723iRHYSCI1YpBi3Fz+Y11hzi4HWc0LjB1MOHkbOMA
         zoWrtzVqfwlMnv4lYQRDjUlFN+XFBp2vUyodeKo/IZC0Qr6dT/2gP9C7UnPJ/o9YSBq4
         isvbbwrs4K/WEN5Rk+roENzMi0YS1j5GDXnLThkMUOLP0Eh9ZL2fUpDmHyHilCkDn/Gq
         mxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000535; x=1795605335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXeroM2jCfcBKXV1NOSG1sFarrMqehRN66QskO8HWNg=;
        b=PzSMRu8CHBdMWVpQevhfgH9MZQx8nMiK8nLfYAIXtvJIwcudI6XFMhUf/qttMQmvre
         WoFtlx4bjcnh+1ByFzfNsF7fN/oMBulPh+lBhQ+2yjQDEjP3/xt18WwDT4R3K3bFVNWW
         5PE65rQgWMmg1o0+oHZiYjRILjpLKL2S50wJTz9Kvu7BJ+dITvSBE36zngMAxs0APSE5
         vu9rmRCDJZxOX0fsI9ZJTMqBb6UhSBxglLmH03wzcCOP1UVr89xRod+rtMKbCBEK1uzm
         kWA4cuG2Nq9009dx9VevBz3Mqb45bg1MRgjKDa0EW3ZH4uV5PoScn7f322U0rX40D9l1
         lS8A==
X-Forwarded-Encrypted: i=1; AL+hErGJJNt3pMfiJSBRXuflf83X81p2cLZ9DlT2+iw4jl27VkEiEdDMD3nwkSuyrjW6dFE2MMj1A8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aZszU1H8Xd5h1ktHqokLTRyJj6FOSuMVqoc2ypWHRIOVXJQsN
	oJLucieM+Oh89smwEZbxp+oBYRbkATdg+b5fxPMFsXiqKOBTNcNcn1gJ
X-Gm-Gg: AZFdTZf2UO+Ck9SpUAL3A5k3EJ0dihPX15WkA5FCwKe24kZnJXnICPAAJNNoxMkbWrv
	S5yASZeK1pEnxtnmb/Zg0kAF4SroffRMXR67ZwAGuu5JeeFh30Dqq0Zzjr5XaBnMx2gsS7251SU
	f+jgCA88P2itHFIyEYLuPvc/XX5K19ac/fV7IXEAPF+ZT8Dn1EU3W8vtknFEAX65Q/G+Jpm8Ge0
	F2V8RwDnjpOmqVZDA4Zc162LrR6DyuF6zTmUm9luEBSyeWnYT9Z8rmLd43zYp5HrVdnRBiF4Dhl
	ypkHtbjwH31Xdnq4rR91zas0g91ZjlOgThEO5os89lvZo2ZquzXv8O58Ogu5a0o4Kyt94RN7E09
	1Fj+nZJkQJExzhMdZslJohh7fTDTMpAC5QxUW5LYOaVMW/vME5l3ulAGfknZGoy11gQ4MGmdk+a
	fId9PpGbMRIPvh6fo4/OxpjycrGqr8zdeUyAYrQ0r5elj/VW0ZBizeYEpNzM8zbf6tLCBvuIZUK
	7Ra34HQVPzXMU208LZO/eDPRLhpNbaxR9B85PXbswYICM+1kbEZ8ppQR89k1xDuoU35PkDN+now
	B45M+QV9bUhMdpapoWih2l3jrCQCixUHfo/TdgrVXPLG0drr
X-Received: by 2002:a17:90b:3c05:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3b3d07b8f81mr2204159a91.23.1795000535203;
        Wed, 18 Nov 2026 03:15:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm8796941a91.5.2026.11.18.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:15:34 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] serial: pic32_uart: don't enable clock with interrupts disabled
Date: Wed, 18 Nov 2026 20:15:21 +0900
Message-ID: <20261118111521.1003717-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pic32_uart_startup() calls clk_prepare_enable() with interrupts disabled
via local_irq_save(). clk_prepare() calls might_sleep() unconditionally,
so this can sleep in atomic context.

Interrupts are only disabled to serialize the UART register
initialization that follows; the clock must be enabled before those
registers can be accessed anyway. Enable the clock before disabling
interrupts.

Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/tty/serial/pic32_uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 8407f85776c0..a8010d6b65ba 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -455,13 +455,11 @@ static int pic32_uart_startup(struct uart_port *port)
 	unsigned long flags;
 	int ret;
 
-	local_irq_save(flags);
-
 	ret = clk_prepare_enable(sport->clk);
-	if (ret) {
-		local_irq_restore(flags);
+	if (ret)
 		goto out_done;
-	}
+
+	local_irq_save(flags);
 
 	/* clear status and mode registers */
 	pic32_uart_writel(sport, PIC32_UART_MODE, 0);
-- 
2.43.0

