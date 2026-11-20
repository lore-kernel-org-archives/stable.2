Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163197;
	b=da7D+KfRLpFRF4FrCpzS1aycxrLZfRRyl4cQFCozYmpFQbpUkh+bJJ92Rte2wGdEyGdt
	 hm+Rwn5BtIQ6Oea0hFilYP+gw4qIt6fmxzM6LoaSOEtb8YjkTLMvEwdQdMOroHF6we5Fk
	 5oE1q4yLYp2z31+vyyKn4JiUiqyHbLwEH7Ew2ArQ0Yh9wc3Adqo3fvn54X+VC24QRrPAE
	 4/v334QNHmGtp7I8VWBYtxyL0sVufQSdCe/+++A7/eTzLzvb67X1NHs7SyS+LcMBIhG34
	 x5wpc2T+0BqYyMu34xeceMmhrIznEVB2zyflKefUVWHGXsc8diYwE/0CmOQr8JkA/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
	b=IEfrnvY+MMYdndhKxsD/TIh8Yb9BSflT2dO+n/eqTg3Q1bl1PRCeR7RlBbDwmJh7nsOT
	 kI07fYPe8Qna1asH+oghlUnY6a+To6+Lva4UCfDA35X4qlH6+/N3cMWyTXKVAJPZZSZBj
	 MFeFQqdg9gq+R3CNtJsmk2W4YxGrir5LIUH8fTLUIRLW7NhqT/0Uo/xgxzVjScLRXNWDq
	 GGzfvNbVtRps9xq2YrReKRF+2FtX9eGWMh1Hu6TkEwi/9gqtS0It2ifZZMCyUbY3lvHTX
	 INnm5uVEhi8BMhVJEW2SiJTcUtQXCiggxG0KnfH0ogSggb6Q+p6+jhaQ7+TiMSEK8Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjZAjXLS;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C1606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A58C1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjZAjXLS
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so102809a91.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163196; x=1795767996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
        b=ZjZAjXLSv+F62wiVs+vkIAM2IBJstzIDu3Ch7zjXRc3kkhhEEiLBiNYrjkyyVkNfG0
         Np6iM7l44MMj0h7oO2WKnS4urvSXKhwS93hLZWflt3tcQxi255thH5ykO/dRh652HOmS
         jD8GIWm8O+oFERZxufC+cJA3FWzG/W7Z4HrWwN+hYzEOpoeDbxtXOrYgeuNHCpSeX0DX
         q+X4Ux2nCuzQmq7g/jTsG/BHMLhwEe4qKjmsZ2X/ZCQAQd14MPOxIWEbSEv8mP61XD7n
         B0hEXfWBT6yCLrlD9FiAem2/Xo/bOcTrpk7EP27pbfCFbJFMggS6fNc5gH/ntfL/fylu
         i0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163196; x=1795767996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hW33v1P5sWZKe/5doKaj5iZQgcXqEgcKueyGxfS2b0=;
        b=vjELr7gyW7dNBcuPhptdjf6qrkiKokwzoG7kQpxp+V0dIUXFKUahdA03/Yk4s1IlvY
         xXjbofOOrZtXzqUCqwvJBFyUHLccGRUWPhpSke9Rvk1MBUsbqFYWw8MTlSNYnb7B2zZE
         FY/e9bKJwltS2q8C99Zw4mywizUIHfqqH0fG+kg+SHU2jG0HFlSl3FFpcroisNzZ+xPq
         tSbrA1oSVqSV8NMakEDCqFQl6Z+3ZLOK5uOfE6XUuy3dU3Hp0hsg59FU0yBLFuQTzcyK
         ZvNkT8PT1dpezZxZSV+du71Nnznf62O9ONsag6AEvZVJaoPtbfAn3T0Yv0YXp7s9Jw4m
         oFcA==
X-Gm-Message-State: APuU4Z97IKXP+qrqyVJzVzTHU2UOoRyzTDLv5f77bEYxqxJudHEE7EIB
	vSyoaZ4GRW7xAdbCBuIszuGpXVe6uGPt0zO3o473qXcLMu8Yyr0V8GmVy1XLgQ==
X-Gm-Gg: AZFdTZcove7lzpgYkW+rdYFPO/Aow89ZS7lLbxiG4+s/Da2/z73K0HvWZ5l2XipxrG3
	nnmB2morXl4QdT+N4GD8D5j+PbJX5Wnw4Yte5lXffYGk4JsO+9irEAk18y9gTUprO/5piRsp3GR
	wgxUPWKEGcWdq7NfxYkXM6NimOcBplDf9z4SPlfpQkaM5OS3KBBQRILwzat+7PlvBA7UUFyMykG
	ZdPmiaiLD0Nkdo97tceLrHnneE6MLfydUXNO6dN/Dc4S9U+lCGxhCHXKO+rfS+VhVAWD6K75csX
	ZMxwDX9N4pIzI4GeD9SzthRVRvfKpyQ2cIDgkbmAnHZjC3eO82QXpnM49cnVc5O14/OMtqRLbPu
	VwGINCnmzezXn1bUOEon03FNwffz5PCMdjiaF5figw30KACqz8onzUCNtbg0AVpuIEKrxYHwO6f
	mkLsCAw4zjod7yVpOO1DIgxm3X/apcy2vYXruX1Mup2Vm35jK/Fqxdhb5w3hkgiFE15Me9N2hFC
	4CNh0b5noShXJIQn9FVVf6FEE97ZwbG3YyQaR4vHkTE4hfCgDZ6z8UyX2ka1tBokqQ7AeYBwRzN
	OmEwUaJw/jr2uGtwKXKIlPAJlk7EtV9c2ReM4DxeYSCC4GFGyqfcYfUle4WbdEJzxF/Ydw==
X-Received: by 2002:a17:90b:4a48:b0:3b0:9984:18c6 with SMTP id 98e67ed59e1d1-3b41c907e3bmr3330845a91.3.1795163196016;
        Fri, 20 Nov 2026 00:26:36 -0800 (PST)
Received: from candy.tail8b50b6.ts.net ([49.0.83.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbdd80sm1472985a91.2.2026.11.20.00.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:26:35 -0800 (PST)
From: Krittikun Wongnin <krittikunwongnin@gmail.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [stable request] ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on[]
Date: Fri, 20 Nov 2026 15:26:31 +0700
Message-ID: <20261120082631.110172-1-krittikunwongnin@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Hi,

Please consider backporting this upstream commit to the stable trees:

  8eb2754ef96d ("ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on[]")

It went into mainline in v7.4-rc1.

Why it should be backported: on the Acer Aspire A515-53G, Linux turns off
the unused ACPI power resource 'PCRP' at boot. That removes power from the
NVIDIA MX230 dGPU, which then falls off the bus, so the dGPU can't be used
on any current stable kernel. The fix adds one DMI entry to an existing
quirk table and affects no other machines. I tested it on 6.12, including
checking that the root port still reaches D3cold when idle.

Please apply it to: 6.12.y, 6.18.y and 7.3.y.

It may not cherry-pick cleanly: in mainline, the entry just before it
("NLCC 001") is missing from those trees, so one hunk's context lines
won't match. The change itself still fits at the end of the table. If it
helps, I can send backported versions for each tree.

Thanks,
Krittikun Wongnin
