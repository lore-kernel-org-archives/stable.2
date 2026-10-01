Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CC3F104F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829945; cv=none; b=ThJd2FPlxqfQ/7FOU4nuLqYUWvbAIlwO+BP3NRz9yaE5tldxssXsOVLmmInBLhIBszkMbfgp9Uc9jlQurmams5yCCkKLEUe/dXByW7bl8Ui0X8MHxxz0yy3CW3zBV6WdjhEreTC2ASQVxjlylxV+nALFHWzSLManG+ysCdcs4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829945; c=relaxed/simple;
	bh=eEl8QR+rB9IOMQDWRHcUt7vIZSR3LbsxWeksxBhbqT4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RWK+Es3kV1DIaLNwONoVLF8CnYFhb0RrP8A3HF1YChkRcjY3MiBsltU5jLGLUEO/ewNpn0J+rsRhF1tb34MM33PyNq7S3Sqt7TrApBZAwqlBHsdqTz21aikepsp9bL/cvYOo6Fru7xLyQSvnyBrNI3v10Pp7gIEH5n+aVcd7Ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKwdPYAl; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKwdPYAl"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f56c44b0so2552211eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829940; x=1791434740; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dXeIZLOIAX5LEZkoUbZIMdBzX/lThU3KbCUVJA49llg=;
        b=PKwdPYAlXPiSlFk20xReaHE3QR43JnVDuiftO1UPVb39LbVHRXKPuQpT4rA1RLzVrb
         v/1DyKyheNKvN8rKIXiwmp0XgcoM2rR3QxFWBk8vgxkoD32iSAzfIQUu625kpZZl8JI5
         Som3Na6DFFQ0QdooXQwvqy8wCoWLvOU3v0RZyhBDFnPKGgglkQ/k2AtUERgDE3Ph8q+h
         YqZb9Upon88FeNvw1Va+EutyYjIahjd5QqukSvTETYDWR4NNDtv10V7V9lVVtFqlJ9hs
         jgpSEMLtx7NWwFaCdHhO5IfdiTsiHM5+rdRX5Y6vmkggwCNzjHC2AJXZce2wQE0mPxvO
         8mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829940; x=1791434740;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dXeIZLOIAX5LEZkoUbZIMdBzX/lThU3KbCUVJA49llg=;
        b=R4IqvFQsO6Mj5ZIwrCYXNaEzwix0eGy/nE8MGaPT9mtKhit2qZ1p/Iq37M/ZWsYuH2
         LYz8jyVDCKSwRCvghQbcWiXVpyrNaP3A06mzIHzGa25Sz3pycTql+TnJBouHONo1Iugm
         9VH/q7nNXzQndH766kmj2o5knBUgBWZA+ZonFpF7r2EdUcNIbRr0u3E94+a5ynf5pWgs
         igcK4ba5Z7QTIenbjgheAPPcEVScYlw9kGCRanNWJ9i2equhlGClwBxKtRxvZKIybcbl
         VP3nWUxh7k1evEACmHhhO24jWzfu2JMX3vhTjos4iuoBJO71WN8V9S34LOw7vcl+AfSZ
         TEYw==
X-Forwarded-Encrypted: i=1; AKwUvBy/LRVxmuqAYeMJ3hOmgCY5dh7SgUpBKREitQzL7tnCI4wwswEy5BXuurN1RtKTURMrfqbURPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8agkVPOSrZyBHG1dfsOxDcTOy4nBKZ91IYdjThl6HF62fRhUO
	Q5jKMIkl3tpoUQqboqgVi1ixgursNstBHQLi3Um95n2+VWct3bH7chls
X-Gm-Gg: AYBFou0uKq6Gmd5RmeNkizanWMd5XkS2DTTmQ17c0l7K0vePAAPzmuRlxhDQNoqD8Xi
	kt0ZUKFhDBga1BuHAqbOIFD2MMh07n2olfGaasynLA1kyFoRM46NksFoF6ynuLOYb/64aa36MtB
	4zB6Cnclu/VdHAaoS+BdCHilTqfkuGziKOnQIzBLmQ31o3Y1W9WSiZ7Gi9lwihcxNTfzoKek7Vy
	KNW8OZ0vG3kahaXOQMC3m3Qr6eE6foIAZO6MgxDwQNyOOgVejIHNtBWYCs6w4JPMQxNde7LLEvQ
	5is0X7RMeBLlH/4FZ/1exJ7msOdtO60KU/Veala35Cwe+wBI1WRLV/u0MbTQ9IajrXleHnka5Ol
	IyCwctOGBDRcwdeS0P51acTXBcthCZpQakK5z/PCV339AiODt1DBME9//fTRIdDikxvXRnyDRjo
	kxbdYAgwxf5Ci2uSKYfApteolYKgeXt04SjXpA6x1MOHjDKXbI3jQ4Q1mlUuiRU8nONqaAXg0JB
	Uv1kJQziOptNZwZhD3jXcoFdjr8ylVxxOgbCOdOEtCtdsVdfQlkQpG0BP2Kxhc=
X-Received: by 2002:a05:7300:5552:b0:33b:e3c8:aef4 with SMTP id 5a478bee46e88-34cd6100ce9mr3727853eec.0.1790829939700;
        Wed, 30 Sep 2026 21:45:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:9835:e0ad:476f:74a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db3e3414asm3891332eec.19.2026.09.30.21.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:45:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] wifi: carl9170: revert broken devres conversions for
 input and hwrng
Date: Wed, 30 Sep 2026 21:45:29 -0700
Message-Id: <20260930-carl9170-reverts-v1-0-7033b5716c14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnlvWoC/yXMQQqDMBCF4avIrA0ksY2kVxEXSZzqSLEyoyKId
 2+qyw/e+w8QZEKBV3EA40ZC3ynDlAWkIUw9KuqywWrrtK+0SoE/3tRa5TXyIiqmR6yiCybYJ+T
 bzPim/Uo27W1Z44hp+XfgPH/Mq+UMdAAAAA==
X-Change-ID: 20260930-carl9170-reverts-bc4b3b6a1a25
To: Christian Lamparter <chunkeey@googlemail.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6c14f

Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
the HWRNG and WPS button input device registrations in carl9170 to
devres attached to the parent struct usb_device (&ar->udev->dev) and
removed the explicit unregistration calls from carl9170_unregister().

Because carl9170_register() runs asynchronously from the
request_firmware_nowait() callback after probe has returned, and
carl9170_usb_disconnect() frees struct ar9170 immediately in the
interface disconnect callback before devres_release_all() runs, both the
WPS input device (along with its ar->wps.name and ar->wps.phys strings)
and the embedded struct hwrng remain registered after struct ar9170 has
been freed, leading to use-after-free bugs.

Revert both commits to restore explicit lifecycle management in
carl9170_unregister().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (2):
      wifi: carl9170: Revert "carl9170: devres-ing input_allocate_device"
      wifi: carl9170: Revert "carl9170: devres-ing hwrng_register usage"

 drivers/net/wireless/ath/carl9170/carl9170.h |  1 +
 drivers/net/wireless/ath/carl9170/main.c     | 42 ++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)
---
base-commit: 6474fa070f2b8013b4b87350b775b8c3be6e8aac
change-id: 20260930-carl9170-reverts-bc4b3b6a1a25

Thanks.

-- 
Dmitry

