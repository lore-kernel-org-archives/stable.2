Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043836;
	b=OwlnquKyklSL4CITpFa7sIFx9ngUWlgOQELpua1pmmEKpmyLVPOD0s6fB6HvuPx+kuuY
	 Du2f7agR1QwyFyazgaV9aDBottH7gBnZm+7+BWNXi1op7ZepuoEycTihGrmEQXum6Z75S
	 DlCPtwe8ch7TT/WO3T70NwfaKEwVGnz2vEmr16r65Y8r/wM9f4Bk2qpbwKZZuXEdTvYKQ
	 1Fi7Kgkyxm0//SwBiLbHXlpV0y4Mw8UYOwFWulwBEKi5tbETC/iP/8hje5XyUNm+j/gby
	 KsWMuesEMM4H1febORUxpZ/RREdV3XTPC1zwi0hJ5qVbI8s1loI+rMvb1fg/ckDhbdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043836;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=aIHaNivNnDKPL6lEv3NGXavFI3CYp1me/OAnTqDsNPw=;
	b=49H5pk6K2kzOBQd06M9lmwXf9OAYz7cmfmexjRU7uYnIgJJeq9VqdcAmJTJc3NFAmedc
	 jI5J5KQqtwWeMLbR2x0DOU5DqWfAnV5mSUieIyur6YTlz+Ae8K2zlCN+IE3SRZRDkA8B/
	 XDCpIpP+/GbXyllTaZUVv+OMsm4ZI+86mhSByaygdCBjm7QN+f0z0P54+hC0K8BvZHagY
	 fn3k82Yczg/I4cUEIJKoW6CrCuvAeNCPP4KXo8wcQJAIhL9ED30JwiZ/Bc/HoBNsCz0ll
	 WWGu3I57jDx0Pnh0iHL+447A+54CwBPFnFmoFgDmO9NJ0xTB07fugmp5M2yW/A/cVtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQWyWRaD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F3606A31C;
	Wed, 18 Nov 2026 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQWyWRaD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795043836;
	b=lQaKZXYqyOjDkyxhbfaOlFZwNwz6/tUq/Gfm+iQTGFIaHuUVzN2p13n63lJ0BTmrjLPm
	 LjY1XDzgkyPo83O4NSf+mylAe7F9c9GfJLVffrZ9W6YfE+rLfq7SMeNr1QneBpeKb6hvg
	 T4Ayvb24+jhdHYU4eB/WcUT1ehNnBCXSNNgTIge2hhCfrG72V7ZeZcJZDQmBa8Hgji8Ll
	 iRMDHfqi6hAwlFmL8oGhm6jpHjNcxG4i9sUI6hdjiWTg/1Q2M2tWwWZPpIwn5VXdYXGXA
	 DuXdtwiz3DOuIyImbFUgKUlFcXxC354BF1KrT58GqfERrQIrhk0R1h2R4GxZV9LaQEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795043836;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=aIHaNivNnDKPL6lEv3NGXavFI3CYp1me/OAnTqDsNPw=;
	b=GnvYySc/B5MUJX5jdMrSFkOpu1cMinvKX722hngbQAti4P37S9nkJAR/MgndgOdqyXmX
	 X/R13kJb1OZsqHSLhORb3tjsNkNhcd5sq+r2eUvmN3Vf3Dlzkx/EgVLbRGIucJ343C/lI
	 xaBU3CBTjoedVCduaFCcNIThN+SxFq4ic6ElaBUNS2NNA5Col/4lQY77Az03yaKvdCKA5
	 gl67W8A6LLYqMucyAoTwOi9/v8e1AKIRsbqCgEIfz12IoQ5pk9OY1EIz8b2JH5TfckSuc
	 koBVVDEF+qFPJYgJNc6v09o1pScSU6N7PesmD1NCmuTPNYZr5OAbG6JpublRf5buJJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1D2D1F000C8;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043836;
	bh=aIHaNivNnDKPL6lEv3NGXavFI3CYp1me/OAnTqDsNPw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HQWyWRaD+sS/qfX2VnxS7nu80ZVwfcGhedPtSG0odgF8pk2Edmbwi+k05J2TWSgZH
	 xhAs7fCXU/zmNXvw0OD1Ouqeq2BZV6w6J9GAGqV//j9lCRJQI9zn/R1l65gN1M2KyW
	 7FzYKwDFwKCrA5zPdmej1jxgZGDDpz/tGEs5lEHohHhA/XRr2NszmeQcx30AE/NaJ8
	 p5ADJNEEmu0EjulFHUgxlmyBO08z+Yp0N9RGj3oEJyehXsHkyD0n4PmBTMZeGuitSD
	 zppVemq2hADQe6lVXG2gpGzG+vP1b8+IM4OSPMixFukfkxhtwSC1bmToCvLU6QlDB/
	 +s82ZPhc/neog==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 165ED4B017;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
From: =?utf-8?q?Alexandru_Andrie=C8=99_via_B4_Relay?= <devnull+alex.andries.aa.gmail.com@kernel.org>
Subject: [PATCH 0/3] power: supply: qcom_battmgr: fix SM8350/SM8550 units,
 acks, and negative temp
Date: Thu, 19 Nov 2026 00:16:49 +0100
Message-Id: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQrDMAxA0asErSuwXHe8SunCcZTUBWeQnFAIu
 Xvcdvn48FdQlsgK92oF4SVqHPoCOlQQXr7vGGNTDNbYMxHdcB41C/uEUxgS1j7n1Am28cOKC6E
 xrj260/USnIUyGYV/rTwez791rt8c8vcK27YD2U51/IIAAAA=
X-Change-ID: 20261119-upstream-qcom-battmgr-fixes-v1-004f34587c42
To: Sebastian Reichel <sre@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795043834; l=1715;
 i=alex.andries.aa@gmail.com; s=20261118; h=from:subject:message-id;
 bh=m10mZSU/1Zs9cTC5pq8aFlYb+YKIJMjUiK5nOQ8Ic5U=;
 b=14Lq8wuWQuoQc3cNz9//dLqgr1JXctqOo4kFuKLkJS5coL8EnvrYoqD4Hmn/Xuy24mz+804oV
 Ot47XW7aOgGDN+Xcx13lP93bzbL+7qiM343UtygdiLY50P/9tSM4AHS
X-Developer-Key: i=alex.andries.aa@gmail.com; a=ed25519;
 pk=kNAqgavfB7uUd1mA8o8TszhGxzyqBwY71PGO/oK4v84=
X-Endpoint-Received: by B4 Relay for alex.andries.aa@gmail.com/20261118
 with auth_id=1564
X-Original-From: =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
Reply-To: alex.andries.aa@gmail.com

Fix three issues in qcom_battmgr encountered while bringing up PMIC GLINK
battery reporting on a Xiaomi MIX 4 (xiaomi-odin, SM8350):

1. Set battmgr->unit to QCOM_BATTMGR_UNIT_mAh on SM8350 and SM8550 so
   charge_full and charge_full_design stop returning -ENODATA.
2. Complete &battmgr->ack on invalid payload length errors in both
   callbacks so callers receive -ENODATA immediately instead of stalling
   for 1s with -ETIMEDOUT and aborting power_supply_uevent().
3. Change status.temperature and qcom_battmgr_sc8280xp_convert_temp() to
   int and cast SM8350 BATT_TEMP values to s32 before dividing by 10 so
   sub-zero temperatures do not wrap into large positive values.

Testing:
- Built warning-free (W=1) on arm64 against commit 97d73c825122.
- Tested on a Xiaomi MIX 4 (xiaomi-odin, SM8350) with UPower 1.91.0.
- The SM8550 variant in patch 1, the SC8280XP paths in patches 2 and 3,
  and sub-zero battery temperatures (< 0 C) in patch 3 were not
  hardware-tested.

AI disclosure:
- Debugged and drafted with assistance from Gemini 4 Carbon
  (Antigravity), and reviewed and tested on hardware by the submitter.

---
Alexandru Andrieș (3):
      power: supply: qcom_battmgr: set mAh unit for SM8350 and SM8550
      power: supply: qcom_battmgr: complete ack on callback payload errors
      power: supply: qcom_battmgr: fix negative temperature values

 drivers/power/supply/qcom_battmgr.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261119-upstream-qcom-battmgr-fixes-v1-004f34587c42

Best regards,
--  
Alexandru Andrieș <alex.andries.aa@gmail.com>


