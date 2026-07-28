Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EF47127D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268326; cv=none; b=GCtbE4YWskga9Y4fIdFrjE/TmJFwcEOLAHi4ipWTaODDM2Vz03fTWNZUmNXGe3O6NffXYcVohN8iA0/HkZ4htgONbJYqCDVMpskNacAxvuSeaQXH1l5pepBHAxXFXip3s85zpSOs/yJ3Yvn0+0C3iM4bNGMbxeQ/jSrEV7TvJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268326; c=relaxed/simple;
	bh=SFt5E9GYZueOjVBG9UTzsLKlJFq03wyncP/bQf0SmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DdNXw9nF1QYs3xFn+X9diw+AxNcxFHg8jE4C3frRSkqSWr5tadR+BkQBQsgYJGtWmrWTL7qr0A+W9ekg2+OEcs7yjO/gZRO/zA6WccNci6DRSupArN0mkykUq821b3A0FWv/7hh7m59ScayGoojNJ7YdqWhIDic10lx4EnsOV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYqct8Lv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYqct8Lv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848479c9bd5so191399b3a.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785268325; x=1785873125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8h2awYrl/UTrjaNT3VD/E+4YhtMvmOlxPVKjv3wgHvI=;
        b=HYqct8LvdLJlv0HhQzAQsokQmMoge13YB9kX51JsQhbqJo3yq8PqfDQT8JBmhTUQw2
         wQyhZP+76EMbISaerUu4iUeEvhN+VBCy90g6sH+fmztxuEtfzvE/xasWgp7ffHm7bbLn
         gdqteMBqilXc3H5E8hrEmeX7okFHzEcoaPZnxjuAoyKDqAIbz1Z/pkOK8ocG3bWzlo7Q
         JxMAN8IdHFF0Jj51p64i8XWpzBUHgbEDiZ+/MwZTiSBkH31rpyJfI8ih3PV9aDOXbmGY
         2AVKTFr1QoZFOvdRt2v1mstZWqctME41+rTeajxKnAh7uJ/lfGGRmdXpSqjZB953cRht
         S1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268325; x=1785873125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8h2awYrl/UTrjaNT3VD/E+4YhtMvmOlxPVKjv3wgHvI=;
        b=Tnp3HC7dX8txeV3b86fCQZR3x6uWDl5PdWGeBl3YwRiqLISyTweCoWpX1qKLMRVMUw
         0Q+t1S+5+Q+oDjnAgtaPJELNuKwyJN1DS/qzQpw5alnNuC7XkMY3BDlUv5qSU9kkh6qE
         pO4UQGkHTNr8QJWsBQGmkO+cTzqU4h7ZgSFCyhS6IJmnoV/cV3NIXlf78FJVJ1W004jX
         WBGYFGpKCm9j4847fC36W5Bl2WPMGyTGYXRv3UczS6KV0//gaoplGZlyHp/07rLokt++
         LMmD3Pxj8sGSGYTPOd9/Drsut7wSzIRwZCAqtgHjsDT6kD23gig5XjVQjPG+fq70vu9n
         OSrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8oi6VUI6HU5RCRJQLry7+HbWvh5QEVQb2VG1vZ0GcbEznIavV85j1APd1HRyV6qczyGvINxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqKsS0nbzOIHbkTkXDcbM5b1YDOltVL1PWMNTy9+PgEx/Lttd
	IsH3IyU21QExqVzktcJN4rYLGXfLKzQHBUvVwbi90ReoDpbdAD6ggmu9
X-Gm-Gg: AR+sD13Lw945p/K2lEfcZnacaCaK3xvqmKPA0AYRJucWgW6KarTfHcZfhthE8h1M/hA
	A160Eddu/xE36d9K0mqQbmOBPClIeAu9qk4KYONNXHW+xiqWVDBcCqX+jbU4mY83CnXC7bfE2Hq
	RDVAhlTjmiaKnu44x8oeZ4W7399nuo6SGHludefkU7/vs6bHs2hOuy3T1MJj47OnaOL5zE1hOZd
	w6fvNi2QQrQRIEL0NQPM0qH6YxE1HpQ7ibMYRYpJb+zBKeXorsOzTQ3W9bC49Zn5iT5Pd90oqpF
	6AwyrhnRWzMMme9Hn/UDFzV6/33sAX9XtXRb2n+QEHLH1vHwWSMLFn73Jl96cCVEPX6+mndiKrC
	bOJrrYU+ih0aew0CO2pm68+7K2vUW/xkLq1o2W1937HTizl6o7burPUHwkvCK6iNpQGCCYEbC6G
	SCCUuJ68pPeJduoJNqQJ/XY1F4Y5sET1eE6W9nDMaOLsMmZsUUphiaUWlKQFLh3Bibsg==
X-Received: by 2002:a05:6a21:398d:b0:3bf:c07b:a9ab with SMTP id adf61e73a8af0-3c8ba618024mr4552080637.55.1785268324823;
        Tue, 28 Jul 2026 12:52:04 -0700 (PDT)
Received: from localhost ([103.170.252.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504bb29b2sm1613295eec.13.2026.07.28.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:52:04 -0700 (PDT)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ishaan.dandekar@gmail.com,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH v5 0/2] usb: core: Add quirk for 255-byte initial config read
Date: Wed, 29 Jul 2026 01:21:56 +0530
Message-ID: <20260728195158.65162-1-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a quirk for USB devices that fail enumeration when
the initial GET_DESCRIPTOR(CONFIGURATION) request uses wLength=9.

Patch 1 adds USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
usb_get_configuration() to use wLength=255 for the initial config
descriptor request, mirroring long-standing Windows behavior.

Patch 2 splits announce_device() to log device identity before
enumeration, improving failure diagnosis.

Nikhil Solanke (2):
  usb: core: Add quirk for 255-bytes initial config read
  usb: hub: Split announce_device() to log device identity before
    enumeration

Changes in v5:
- Updated Patch description

 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/usb/core/config.c                     | 32 ++++++++++++++-----
 drivers/usb/core/hub.c                        | 16 +++++++---
 drivers/usb/core/quirks.c                     |  4 +++
 include/linux/usb/quirks.h                    |  3 ++
 5 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.54.0

