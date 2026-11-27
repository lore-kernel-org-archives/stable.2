Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810162;
	b=zH0OviVbQPVcWlpodDW2STUACc+93aZg6Nwhs6dgqy8peYLq8G5QPuGm3bWnAVE9Txyb
	 QyQqPKj4rIU2R03ULvRZ09FZgkbWpjXXdv4fMXYZlARqRx1jv1aHTE13IVtyygAbwVwY+
	 zUiZ4kGHnHszjom6tlmlylWDFzEe/+9fl2Y97PSz+aqzloacaXvanfoVFGW6aQTnmVrzw
	 ktAwJwFm3Hs3bBNKXxFE0lbw9n13Bus25311+rU/wc2gz1pMngYXDDwYZGBZ9cYXWEXV6
	 MJ6u+53bJULhLsbZOzX4G1kMhWIxZUAw866NVJLxJy3cieazNyuK6zkGlhnUrsdBlPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=Y38Q04n1Lg42IacHDv9k1WiLdqgHkNmu1tUwxnY3Jao=;
	b=3i9OmQx3KgiRoKFNNILyPfBa2Fg7v02He5iU+cPAcj415N7YacNIp2vSAda85LRJwWzB
	 5wlRMScAyxUQUgK5G+DS/0C2Nj//ETdLv982/p0S30PtOsRY6EgqM1qUtORDOYSsmJBOs
	 NYU4PFxxwRkIrBFMKoP6k97MeSPq2HSeoRRo8fBpmisDWBt71qC2INYNE3cyaxOk5OZXS
	 8HFrSuAzgQZfH8E17w6Fmtb+WGbEHhDJZen++SoJlBtyy8392ebKpZT544s2kJ5oVA+nj
	 ttor/F++lO0hT8WF+Oqs6hB/1sHJB0oNE7e6TXveBamDXSxWlURsVt0IADtm30iPCkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h9fPcADU;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF8606A331
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFF8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h9fPcADU
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71b0d330acfso6173576eaf.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795810160; x=1796414960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y38Q04n1Lg42IacHDv9k1WiLdqgHkNmu1tUwxnY3Jao=;
        b=h9fPcADU4GZ5pW3JYwai9NK9vzuNpmzEjJhNICf2zBr12Z6HemYOwt1mXoMQ29Iz5O
         bwpdJ30b0dqIEKoLIM8u85sqZBZtUWOOw/ydYRNFxK6jRWWCjz4l9MEZ7B4h4QAMJkxV
         NmjUOppSxa9bnvLyxvJaT+40EKwsfJV9Wr0/E1ZfMlJKiTeQQ8ST3vh9/S/2XBMR0LUu
         g12dpB4+4gv2uPRH6BPsEhmdYr+pZyieZOAb4j1KXo+4w/GhRRj5ouL6QS+WKD8SuamO
         yNva87j4YMOMe8lU07nUKiUQAmxS7YnY+mhFIe67TpRlGp9Z3L2awVYvbMHvS0X27ncN
         qhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795810160; x=1796414960;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y38Q04n1Lg42IacHDv9k1WiLdqgHkNmu1tUwxnY3Jao=;
        b=UBxXiHKFHeaY6pYAD//Lbn/UenFZHR0f7bfLd8UdkZF9F5j83FQl01ifF+NBsAa/fp
         D3k6WkT5QqsLKE6k5xD893q6DyJ79HnfcPeZmny3cYQjrj0oVu2c01hnRBb3NhWJfFD9
         +999kIJhOm39dTsdULIm7ovZyNM4p8eglliU9u6r5f7xCtm52uaN1UF5tmLSj35Nmiip
         Ot6V1UPQf7oMbtjv6gs7lsLpuGUBaotFW2kQ+f1w2q2U44Ri+gNJv61ErNs+yCWr05vu
         mGqFuNt7HY9NtNEexmAR809jeOZ/LQDZWedckHQ0F/h8j3+RCKD7x8edtPb9e21zhx0E
         8BnA==
X-Forwarded-Encrypted: i=1; AL+hErE62zn4L7tWKiDqNlbyvxjnjKxrP/jQDGW27HtCiqtFlLtLT30ZS1s579h57wvlZH6ZZHgHksc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VQiqBy6pMVfGgZ96P8TUb9VDW9sLWbahuvsd89AvVfvCb58zD
	RekgBInUt+oL3g4OwF6qNrit1jPzh6oid8P4i3rIKkeNCPsN1buGAWiC
X-Gm-Gg: AZFdTZc1iJCBua6K2fOJZpUJc9tx1ypPrt5wRneht5YyLxucb9L9Co7McjL7sGU33v0
	/5g6f8a8QO6os7pgtc4NqSBwkgO6DjfjSkCMgDh9n2bfauzHBFY+shfZUapLiSWIFIq4tVgjlXQ
	L7dnqskqw6kvrkiyut4Ozhci5/0qR9N5Rka7iVFCqCpM6g+kDqytvKG5+uGHYSkEpopMbXj7qZW
	zyeGBHdHsoa0KftIG3X1zXABfGOV93lbMmlg3hNJMl30pfC6Po8Zho1Nkn/3xI80dBQaO6IWIaz
	k1WWHfZU5xy/W0gxc51knwfgP8oqEEcllf8nNyZUnrUGR9ED0Gx/59XzHf1jsmHui9KhKVR/HNY
	70RQec971IU2c0hT2UO/M8nXORO6f8YvFRJDkMxnL6TWrO3hfbzFOvqmtXp1f/FIBqCYd1VxvH9
	jmXsi5by6Wsy/LdASBNXTHK+3EEV/AKJxoSumXxD69TA+VLJlPDjJ5JCQEDDiaKjbKvd2qOOH9K
	CkLZXclnI1afnynFHH0z4929d1w2BlF3deNdq8GxzAyuBce4RB+/WMtfHgVJ2UgO3H8fB2BSqN5
	4yv/kAbiFPUsR5IRWduiZOwW2GDnYrWmjOmswweUJ9tpo6lYfMs=
X-Received: by 2002:a05:6820:80e:b0:71a:e27e:cfc5 with SMTP id 006d021491bc7-71b394f3c04mr14876291eaf.18.1795810160517;
        Fri, 27 Nov 2026 12:09:20 -0800 (PST)
Received: from [127.0.1.1] ([150.117.174.129])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b8590ba0fsm4834662eaf.2.2026.11.27.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:09:19 -0800 (PST)
From: Gary Wang <is0124@gmail.com>
Subject: [PATCH v4 0/5] upboard pinctrl support for device id INTC1055 &
 INTC1057 & INTC105E
Date: Sat, 28 Nov 2026 04:08:29 +0800
Message-Id: <20261128-upboard-pinctrl-add-intc1057-intc105e-support-v4-0-029071f417d5@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7jCWsC/5XNzYrCMBSG4VuRrD1DcvLT1JX3MbhI86MBbUJSy
 4j03icKQnHX3fnO4nmfpPoSfSWH3ZMUP8ca09iG2O+IvZjx7CG6tglSVIyhgHsekikOchztVK5
 gnIM4TpZR2X0OD/WecyoTeN0NgnrGlRSkmbn4EP/evd9T25dYp1Qe7/zMXt9PiW8szQwQAnJE0
 zOllTuebyZef2y6kVdpxrUut+oIFKymXR90kKoP3zpf62qrzpuumePS9oNBodb6siz/yIAi0KY
 BAAA=
To: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniele Cleri <danielecleri@aaeon.eu>, 
 JunYingLai <junyinglai@aaeon.com.tw>, Louis Chen <louischen@aaeon.com.tw>, 
 BillyChou <BillyChou@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gary Wang <is0124@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Add support for "UP Xtreme ARL","UP Xtreme i14","UP Squared Pro 7000",
"UP Squared i12","UP 7000" and missing groups and functions data for 
INTC1055 & INTC1057 & INTC105E.

Fix pinmux-select set CPLD GPIO OUT not function mode for I2C pins
on the AANT0F04.

There are no compile-time dependencies for each file, all pin groups 
functions data will forward to set default when pinctrl upboard probe.
It shows an error when run-time dependencies are not mapping to right
groups and functions.

The pinctrl-upboard is provide additional driving power and pin mux 
function through native SOC pins->FPGA/CPLD->hat pins for flexible board
level applications. it's probe from ACPI device id AANT0F01 & AANT0F04.

Signed-off-by: Gary Wang <is0124@gmail.com>
---
Changes in v4:
- Add an index for ish_uart.
- Update the fix patch using a better approach.
- Link to v3: https://lore.kernel.org/r/20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com

Changes in v3:
- Update detailed description in the cover letter.
- Update fixes patch detailed commit messgae.
- Correct the I2C group mapping names for the UP Squared Pro 7000.
- Link to v2: https://lore.kernel.org/r/20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com

Changes in v2:
- Add missing SoB.
- Fix CPLD I2C pinmux-select by good method and update commit message.
- Link to v1: https://lore.kernel.org/r/20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-2-f2322a91686d@gmail.com

---
Gary Wang (5):
      pinctrl: tigerlake: add ish_uart0 groups and functions for INTC1055
      pinctrl: alderlake: add some groups and functions for INTC1057
      pinctrl: meteorlake: add some groups and functions for INTC105E
      pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO OUT not function mode
      pinctrl: upboard: add device id INTC1055 & INTC1057 & INTC105E based UP boards support

 drivers/pinctrl/intel/pinctrl-alderlake.c  |  40 +++++++++++
 drivers/pinctrl/intel/pinctrl-meteorlake.c |  32 +++++++++
 drivers/pinctrl/intel/pinctrl-tigerlake.c  |   4 ++
 drivers/pinctrl/pinctrl-upboard.c          | 109 ++++++++++++++++++++++++++---
 4 files changed, 177 insertions(+), 8 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261124-upboard-pinctrl-add-intc1057-intc105e-support-e87b40e13654

Best regards,
-- 
Gary Wang <is0124@gmail.com>

