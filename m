Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28C429CD6
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452395; cv=none; b=daSoWYt11LaDSu5GHCM5cwDf4G9PmrK12Mra18oCHsM2zlLhHYo/r54nT6EpDetQmcutpM3kAJ1Ak97QejcOyLBxt8O0CHw3Ezj8pff44CtnuKAQPAweZxEBgf/VePPSOAT74lDb9mXOV4YzmPmBk/F5fiU4Rb40pAJinnRtJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452395; c=relaxed/simple;
	bh=yt1krHFUizCiyHqPICB6u5BfJy6aereXdPVeh3hzHTU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I+IjsgFtu+hv4SQCWNZjKpIpzZg227tAAL3cpjzQx+3gPvzkvdZlfb9m1UwoG0mypuE4v9P8Ol53IeAXLbN7zhFCQFRtLQt05FENO1OQuIOcDbe26/jBv79ssa6Mqy0OvT6c2vQr3mSyGWNUQ2lQD6y6pnmMUPxZtJNpKe07NkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExHxV0Fu; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExHxV0Fu"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35115b52125so3609360eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452392; x=1792057192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DhD2kC+TgI9jVZahgsNkJ3B3BbFkorvXCqZ87mDIfYA=;
        b=ExHxV0FuzTx+rnLcPKq83SE3g3CF+BW0bOisGBafGWIGQLXhynJSLZX0VcR0rMvwiX
         nP5qUsbe05zWJKpJuunhl2RFZ93RSrmW0QocsJqbxwLr2CuRh83PrXuGl3MjBt2irAJx
         QVganH73EshthWxDMRVoMdVtb4pmT1r4iFSfMNF/+ajXYf+sYDpNB4vTL+DGEaQAWrbG
         HHQmSaqe5m+FI/NyrzCWJvqPama46FKVL7ywD2XbT98pVkQJO7ye6gi1YP+jt0xBugCt
         0cyY7m4+yBJy0SpzdSWocMBKlcY39xDV6rlWc/WWmd/gfrho9/PF5oGOi7iIPYSiCCZs
         PeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452392; x=1792057192;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DhD2kC+TgI9jVZahgsNkJ3B3BbFkorvXCqZ87mDIfYA=;
        b=vhdaBe+ERu+tQyzkKzk6d6uDB0sga3OlDPdkQoWZ4IvDLSwDMd1dazbTE6kwPlJH5Z
         +oiBbJNoEbSrMhk5veRxg9/vUFvbAaP9lvPbD9lDkPacSjVsWSQ6BY4X9tLM2gw6tOxu
         fduPQrBm4pTD9UBKhpJTjev20BgMYBea/IMMg9WqAy6TEUoujBW1or6btV94pyclifYf
         qlq+mKtoGHA+TgbEqfHlYu/muo0nF2BfukMs66K6yt9Pv/w0qD/B3Db7A95wT/VPjyeq
         9H934LPIc6yzhbHQziMVpw7w1lrZqRqRzSMvNRYMd0BgL0d1eBWAIpmKcKZc21mfv4Au
         xSKg==
X-Forwarded-Encrypted: i=1; AKwUvBx1HMusqg5JTpINU3CDvLxgg00pJ2aa8Bx0NKRGOxVII4LPO7etrUgQzEabvxcTmCEzyV0Ztu8=@vger.kernel.org
X-Gm-Message-State: AFuF++mk9/jT3JYjXYiP9KcsQ1eKv8m4RHEvE7tV9v0nUGl2kbmUCo7W
	Ng4NUpImgLkvfCAiIZtS1gEFrZ6Cg11g5Mf3H1PZSB9TujtsOhPLrk9r
X-Gm-Gg: AYBFou15GpBSICsmjTcGEOfdkP8XtgwZbq3vAwlrKQS/zvk32a3TnZrrTV2Iew/Lkij
	fQmYHIs9vkUr7DtIUHnaC54FuVgjId8Ql9Wi0xSZXU4tM93azprC4o6seCszMrghqKXCEUc3Yxl
	7vFZyhirCUwn22BAdU7IebLMk2s/hUtuvegmwUJ04jb8255Fgvl8KeeaNkDC4KDKdFVE43GM+CZ
	WaDrqJTgBRUMHCQxAhXknNZX6vRLSgOee1M+NlSu2NSUisfwYS/g+DHLlzQvMpGwHhneD/T+cYc
	bLFBeHnIZyzloDBTWYEEAgAbOqh3xZfq6shFIxr3y7F5KEJPADN5cBEAb/zsaK3E0DJH5B323Ai
	+8y9ULjqSkN7IohvAS/8nXQdkTCCTKEvFetjf73alPZ507l2/uieG8QAaUuK7My3tx+3lqB8rjm
	NOfKTzDbYFlP/QZLD8ZO8uJi5Yy86onakaWyqLJxmN5W8uB4FgcX001a8VpdzlDQFE4aVjd8b6s
	wDVSmae9R0KuWiNL1+Uh9cRdSTcBMB5zn9EmccjhNkpEs9jyBCj2bhmWY4MXdk=
X-Received: by 2002:a05:7300:7314:b0:34d:96cb:d75e with SMTP id 5a478bee46e88-3515de9ff53mr9040330eec.27.1791452392170;
        Thu, 08 Oct 2026 02:39:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm6873252eec.17.2026.10.08.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:39:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/2] wifi: carl9170: revert broken devres conversions
 for input and hwrng
Date: Thu, 08 Oct 2026 02:39:41 -0700
Message-Id: <20261008-carl9170-reverts-v2-0-3ecb12089797@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1kx2oC/32Nyw6CMBBFf4XM2po+eARX/odh0dYRxgAlbW00h
 H+34N7lSc49d4WAnjDApVjBY6JAbs4gTwXYQc89MrpnBsllzVvFmdV+bEXDWbbRx8CMLY0ytRZ
 aVpBni8cHvY/krftxeJkn2rh3dmOgEJ3/HJ9J7N6ffBKMs4YrZapG1FaU137SNJ6tm6Dbtu0Le
 Fk7ecIAAAA=
X-Change-ID: 20260930-carl9170-reverts-bc4b3b6a1a25
To: Christian Lamparter <chunkeey@googlemail.com>, 
 Kalle Valo <kvalo@kernel.org>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e6826

Commits 23de0fa0d2a0 ("carl9170: devres-ing hwrng_register usage") and
87ddb2fc29f1 ("carl9170: devres-ing input_allocate_device") converted
the HWRNG and WPS button input device registrations in carl9170 to
devres attached to the parent struct usb_device (&ar->udev->dev) and
removed explicit unregistration from carl9170_unregister().

In carl9170_usb_disconnect(), the driver calls carl9170_unregister()
followed immediately by carl9170_free(), which frees struct ar9170
inside the interface .disconnect() callback before devres_release_all()
runs. Furthermore, devres on &ar->udev->dev is not released on
interface unbind or registration failure in carl9170_register().
As a result, both the WPS input device (whose input->name and
input->phys point into freed memory) and the embedded struct hwrng
remain registered after struct ar9170 has been freed, leading to
use-after-free bugs.

Revert both commits to restore explicit lifecycle management in
carl9170_unregister().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- Clarify commit messages to focus on the teardown order in
  carl9170_usb_disconnect() and the error path in carl9170_register()
  rather than request_firmware_nowait().
- Link to v1: https://patch.msgid.link/20260930-carl9170-reverts-v1-0-7033b5716c14@gmail.com

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

