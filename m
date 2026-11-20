Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215584;
	b=W2cnd0kiX1RAi6KcutScRDFXwIPvUfnLyYHQ4y0dCVof9gCqfJC/SzkvZzc/grF/oygd
	 JXfbetfQzmyW4vf8Y75GLDfnbDyggn3qXwALIbjl6jdwLt2u1/NoF+BDUJ67+U5nmz+dF
	 skf1e80jsmOLo0XpXoEquJVn6sFldcd1Zw7gavYWFeUckpZrtOq+xteS3KZWmfTUlmoxO
	 YQkzJkQNhFh57dzrRmFoszs060aQJaMsJ/OAlo58vDwqQl9qmN2mHNnTmFL8R3PMAqoq0
	 qrn/dc8bKI8Uopb39c7E9Lvw4RhET37oIb+1Quio2e1QX2z8zaTB/yMt2biJzHmu1MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ee5wISoYwOc7Y9upCk7+nEDeErsMErXue2GBxhmncOo=;
	b=z7QLDmzX56v+v0jP3VQ1knLUogsL6G4nXxE3BCrB4j0s90m34h2LfiTM79FF9rQugo1P
	 YFBbn8uW4zYL880Uh1cde5WvFEHygSRgrzy6CfdZGTyXyCauKRjbtb26Zt9Qa37xKPKTh
	 OQ7WEmr4+CIejRPT0xIJrTBsZIcV57PoEsLar13rGFzF3dMJDKKWEDVmryKfCCocLl+eP
	 EbW9sNXYfJ5yon/wuU2poPLTsHcUTtc3KhNdDE76kUuYZN/FVe4z1TfhZY3bNsMX0f8Rv
	 jpAceWDfzbkAhDjtIGs51cA17U+gNLSuOK0C1I4kij0oA5e1Fn0NBCjyRSzvln4uVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wgyag7Vl;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403AB606A694
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403AB606A694
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wgyag7Vl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so11316745e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795215582; x=1795820382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ee5wISoYwOc7Y9upCk7+nEDeErsMErXue2GBxhmncOo=;
        b=Wgyag7VlNwEQyOFpTOPV7cGFr5SQm+kr70UOqJjN5aYRoX6r/PCzOFGv5cESe327gK
         +W6dZgscQvFe9M3WhckhMG6WZNEU4iza1FaocSIOe33JTTw67qAnnOOnJF/oZLKKoDdo
         M2awmXP+e8XVDStJ1XV8RP0onDcqmMRhoF51e05MXzRjIBVd/IVWXMoH54GHzfnE0L+i
         ofbLJBQoTbyiZsnPscN2u/TjIFpYLnublajx8wekYTyFe3YDQHWcRIlZp4pcKLq/ELbi
         fQ/6t9cikUnBTVBqEZSleZQFKop1/niMwHYpOzM7Ixg407hdQy6bfsLkFNX8nW3paP3J
         e+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795215582; x=1795820382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ee5wISoYwOc7Y9upCk7+nEDeErsMErXue2GBxhmncOo=;
        b=1VaQj7UBMCteRBPKvYQFT8rv1c+gc4Gk8fxkIl/3zuz96bU4zF96uZhWYh2dmWv9/s
         uRc2DblVcbuZdc5ctx5EA2I36n4dpAOIn2hpYcZUUzpbh2JoyjJ2iXJ0hz22mD1z9azH
         yNq6B6rh3TQ+nEGGT4pe1Vrg8E0VJRA1BZPEitOweIicsBX5bPlj4dOR+m3qpVozlHXk
         fDFMgMOsMdXvxF3IPm6kd4838tn1Ya0Hmfq7kXVPhQJTYF8pbRkIu9gJ6KgfUFamwwkq
         O+W0kTEO/cSgdfR8jQsCsjLIAjrMWU8ioX4MzmyqYn8THdAg1TZ2bw9MmkMSfR3rnzHF
         yDKA==
X-Forwarded-Encrypted: i=1; AL+hErFhbVQhnNIrCMEPRd6Pj4RHutp0wQjOQh+nVHimjzaZCfBWCsJmMpCm+GlUHfj78M07l5bEjbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FHgjg+lvPH61DyJL3AjdcD9ZpxZyaY4sQS/p0EiZgRZSSADry
	mT4M2zHQnSBVtf/FHAYtNRCmA9qGV2HnxCf45oTyWb34btfgW7oQw/k=
X-Gm-Gg: AYBFou1CJVmFu+Us4SduL9zgTw9cf8loSYMe33XhrGyybhhYvhYlmvh08MqqizuGpzp
	Hj226YgDtemoQsnLjd/chMPGzr85AyawtIiuVaxC1hmMwFJcgXEVNBHuDqwieOvPMbb+bBrKk4B
	ZKnSvICcpjBx7pkrVBe/RATTGKZW5afM2Id2Jv3fYb2SQgGDyTAmTj1+nKihOrF9ZVJ51dWBTwS
	CHo7DY/weUCdZRxajP475Tk5wi4AZpjmmDulfJxDCMW2xTLrIN5OF5hsF1UOXV2IVD+UDq5DGkt
	kmXd8kdKo8pGXbJd792IsH4qxIZ1jNQvgb/AxPIAjDrlu5e/T3UMljf7IDPPaxshJZja2cwv560
	a3kDw9V9UPuxARtY9csYl9W/S5/u+HFoH64gm5O+PnX9vnxDBBf4JV25cVUM4vH9e2tO0/lTd2Y
	+7tsY5eXbmgZ2GZJWP69nwBF2b2C/+dNHorwb4CMM15EP7ExF6erHOC8W/CpMDMptM6juTCIRB2
	p24QFZ1smKp2YUSJfUTXYO36GFcZV7D2HDPf9PhfeR8sKE3bPeimEubat+9Jc8H8udCxR1W1e1B
	pxUguure1pDoI8Vzssw/3sMJlwdB
X-Received: by 2002:a05:600c:a08b:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4bb88922c52mr96824465e9.13.1795215582473;
        Fri, 20 Nov 2026 14:59:42 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm128863475e9.2.2026.11.20.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:59:42 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 0/2] wifi: nxpwifi: firmware response validation fixes
Date: Fri, 20 Nov 2026 22:59:31 +0000
Message-ID: <20261120225933.1148680-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

The nxpwifi driver trusts several size fields from firmware responses
without validating them against actual buffer lengths. This series
adds bounds checks to prevent reads past the buffer when firmware
provides inflated sizes.

Changes in v2:
- Dropped the HE capability TLV length patch (was 1/3), superseded by
  commit f17e2eda1630a ("wifi: nxpwifi: bound the TLV lengths in the
  11AX_CFG response")
- Patch 2/2: moved the response size check after timer_delete_sync()
  so the command timer is properly cancelled before the early return,
  as pointed out by Jeff Chen

Tristan Madani (2):
  wifi: nxpwifi: validate ext_scan buf_size against event buffer length
  wifi: nxpwifi: validate command response size against buffer length

 drivers/net/wireless/nxp/nxpwifi/cmdevt.c | 14 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c   |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.47.3
