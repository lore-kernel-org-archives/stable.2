Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919696;
	b=iZ1kNSuy/vUFZ6GqHJvUU89nXQk/sIn7O1fAjxTbYKGrP2ZeErvPmLUpy5phj2IGebJM
	 rOs0niBCPy01qDT8YWdltBKUn7LoDizRlzz5dj0GgH0IcxwuRHqHwgWlg50IgFJ8eGThY
	 rlyH+69kmkpDi8YfEACsEzQaJTvNMu/L6uclRq51Qwc7z0x6UvKjUeIUJ3vDVt2QdM3uJ
	 GqaxlFxcLWTqIYyp/DyJuo8Jhvl5s/7JOgddYkugqt341jFwjQFQ2mlGY/b2AREvGkPyK
	 WprbM/mKs0cul1By1GJ4Oc3grOJszTFqqx1BbkXf9l/IT0HJJPylMBv9uCV8rxIh2Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4XuDb+qxeFBFnV/6PkoMxQP9RUIi42YNBCqdf2K9N44=;
	b=TtczmREL+pUf+814wDcbWDy8qqmu/Do/SunpvCfH7jw006jf1r5VR8K1a+bcqwIRDusg
	 HdERURObIfKR01r73cFFKyFDSNpmXyFkcN/iGhrlIHGfy/4HapeaKBv6LFC5858eY+9h1
	 F7hY7T3sFLgCea04z5n+J1UsXlqfg+dCvgJSnGrZpgs8OW1FRHAgAZeJNJh0DOoFytGnt
	 CejyaBWNa/uuonluRKtaC5IKGMaOBmQOV2hoIN66WAetxh1kGTSWW7WW3MYBYyoi00lc0
	 1P94kDHGLlEup/4Dkfh9Y+XlebwdOojBz0yA8XT7VBRe9T+rSfzqmfIm1kFEQ7jxsBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=ZFIMG5VK;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB70606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB70606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=ZFIMG5VK
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so20566085e9.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794919694; x=1795524494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4XuDb+qxeFBFnV/6PkoMxQP9RUIi42YNBCqdf2K9N44=;
        b=ZFIMG5VKAvX8kvlqsMe23q2/ewlZ0qSBWjXneLZM7IZXcKpLY1UVzGyyarGWGJ9qRz
         vXYxD4c6dcDZ2lQ6ZzIJmAMyZaRB2oJuT8tM3HQSi6PMGRoYWNEx9vuZfScvXqLFNuvb
         9cdZfBIC2IW6LEV74Yy5WyOKhRL09Jpzss5W0LpDkRcTW3ydCGCv69mg0fsV18txO3sZ
         L3pUl1JVEK9dPe2aTOOfXe49EmM3x4BRfTBM41XWVCvtHwmxhM2QZ0ZPt1BMocBOSGM+
         TJUFNvKioo+gfuu3cI9sNqZk4pGO0//eM2A79ctu35hNPqgQgDO06enT67C19aMuqSHv
         FNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919694; x=1795524494;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4XuDb+qxeFBFnV/6PkoMxQP9RUIi42YNBCqdf2K9N44=;
        b=W+0w27mDs56k6TiUQgYxaddU2Q0HnNCqBuxg9xGEtPcVvAL+PCWS2OHGEVdQWf1upi
         YgNKVNm+uqPyGkpcfOS4PSMam7xdzm40j+wRZN88Rxg3V5ISGrHaTjn2inqDCYzEd1jL
         ++U+dyWRttpnamd/pKknx/vG0ziHTZ157wGCnaT7mnZJv4MbbGdaHVkr1xnKUhd9Vq/o
         hseaCQDkCaC/LYdGwJPgp1u1k2eydGUf65FMcVzwXsDVKcmtwF6SHgLsXDAg/bffBDgo
         E5cG1YnC42eHploW/WADhogX62ZOHrJdDvm7NNhBDqJRk0qOYAfxEc7mSJMUacoH+0xu
         eN2g==
X-Forwarded-Encrypted: i=1; AL+hErEjK6UZJksaGZvG2s+u/t1CeYn/rMI6AakF7tdOQRgF8d3jsqjTbJPIupixyF0R1TiM9LpThOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4lafndQLiQSQyQoMvd5DT9M1nmQUS+pMAIqFxqswvd+pCqyao
	vcyx0lqdyXP8v1AmteoHvUnodv6rnFp2IE78eIewsIhHw1zuZWYbzx1WdtXAk5zu5b0=
X-Gm-Gg: AYBFou2IieAqwE6oGWT6eAmjw81hgu0cjbt7ldf76ddGq88Q5VIwDuLG3UMaoHFcE7Y
	v6fdqWRRs9zuawmmT2UTftfjQWWQQLwsjRNQTr+x7W4F84VA+AySwNbLDDpyI0mlK872W2dt2vh
	X2CeusLUUBufqPyM8cVFtR6P//5ek6a7fO02GsuxrADAhTUfY3TY617jy3MLHvPIBTbnKLY1T+9
	9Rs6B3hIf8zFle/46oKqr5PrySm+h9nKiOrElce/sOsZ34UBpc1w1F5XSPTt3cjvyO/2i756+TZ
	rGGRTq1n9nBl874aE1pfku1AWvInrK/s/Imji4oVbQhG7vrXP7yCMzJ3H2PWjdUFAKOcVzdq8TO
	F/iztC7mrk1YqaJDR9TQE0oTUwttiH+fDl1BnferZUfy3CY3W4OpLMWURHTMln3F+RtFmI7ZfAQ
	rxodX2AfMkCBTxY1H3cWEK/N/baopiuxPUso6hRtEJKjcm6nGtgO8J1LMVHMlFJPwqPGxE0R8ab
	YXLj8o35oFOL9nzylD+nknqmDibtYTB8Ay0caO4rMsAo0pV6KSJhASNO5IURH/XvyjV1d89RIkl
	GUH7s84XUAqvC0cmhpGXFqeIzE3E3aTl2jyS89vq7Xckq3NwNm4frMEOOqjW2Lx4Rfcb3GeQyBz
	6QAZx15qoyQ==
X-Received: by 2002:a05:600c:8b82:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb6814762dmr199356655e9.22.1794919693879;
        Tue, 17 Nov 2026 04:48:13 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5f350d51sm124029135e9.4.2026.11.17.04.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:48:13 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 0/3] usb: gadget: udc: Rework when the gadget connects
Date: Tue, 17 Nov 2026 16:48:06 +0400
Message-Id: <20261117-udc-connect-v3-0-9413b491d213@flipper.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4X07JpuKyCe/A/jwZat1JhCWmg0h
 H+3xYskHid5M29mgbylwE7FzDxFG2zvEshdwXR3c3cC2yZmgosKEQVMrQbdO0d6hAqJG0RtGql
 YMgZPxr7W2uX65TCpR5rmRF50Noy9f693EfPufzkiIHCpaynKpjoIdTZPOwzk945GlttR/Npya
 wvgYEpUiIbXpI5be1mWDwMiee34AAAA
X-Change-ID: 20261112-udc-connect-61e0f11cf93b
To: Neill Kapron <nkapron@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MG7xswnJUFSiE/y0/iIlYT0Eru1GLfTlY0TVAdkhu5I=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT98eV2/8do/2dr192c4wfd/6oI3nCxnf9cm8ktfsqeS
 Stf3tpwtGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpVl/EyNBjzMNcdmnFPM7kecWV7e1ddVG3umfeOy1zIq2zWCs4npvhD/8Wwy/
 vWXbfZTh6fIasvP/ZF97HLh+cr/DUevGG40xW1uwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The UDC core decides whether to enable the gadget's pullup in several
places: bind and unbind, VBUS events, usb_gadget_{de,}activate() and the
soft_connect attribute. Each applies its own rules, and
gadget->connected records both the pullup state and a request to connect
later. Since commit 62911bc82b03 ("usb: gadget: udc: skip pullup() if
already connected"), a VBUS event before bind leaves the gadget
invisible to the host until it is rebound. That happens on every boot
of an RK3576 board whose Type-C port controller sets the device role
before userspace binds a configfs gadget.

Patch 1 is the v1 fix, small enough for stable. Patches 2-3 implement
Alan's scheme: the gadget connects only while a driver is bound, VBUS is
present, the driver hasn't deactivated it and userspace hasn't
disconnected it through soft_connect. One helper records that in
udc->allow_connect under connect_lock and switches the pullup to match.
The UDC starts and stops only at bind and unbind, and the deactivation
and soft-disconnect requests are forgotten at unbind.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Patch 1: collect Alan's Acked-by.
- Squash v2 patch 3 (configfs) into patch 2 and clear the deactivation
  inline rather than through a helper (Alan).
- Patch 3: clear gadget->connected at unbind even if the pullup refuses
  to switch off (Sashiko).
- Patch 3: check the pullup state before the ->pullup operation, so that
  a call which changes nothing succeeds (Alan).
- Patch 3: warn when the pullup fails to switch, unless the UDC reports
  -EOPNOTSUPP (Alan).
- Patch 3: set udc->allow_connect inside the renamed
  usb_udc_update_allow_connect() (Alan).
- Patch 3: keep a soft_connect request even if the pullup fails to follow
  it, so the next update retries it; the warning reports the failure.
- Link to v2: https://patch.msgid.link/20261113-udc-connect-v2-0-f51b11f07eb8@flipper.net

Changes in v2:
- Add patches 2-4, reworking the connection control as Alan suggested.
- Link to v1: https://patch.msgid.link/20261112-udc-connect-v1-1-03c73259642b@flipper.net

---
Alexey Charkov (3):
      usb: gadget: udc: Clear a pending connection when starting the UDC
      usb: gadget: udc: Forget a deactivation when the gadget driver unbinds
      usb: gadget: udc: Decide on connecting in one place

 drivers/usb/gadget/configfs.c |   1 -
 drivers/usb/gadget/udc/core.c | 214 ++++++++++++++++++++++++------------------
 include/linux/usb/gadget.h    |   4 +-
 3 files changed, 123 insertions(+), 96 deletions(-)
---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261112-udc-connect-61e0f11cf93b

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

