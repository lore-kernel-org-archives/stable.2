Received: from mail-ej2-f15.google.com (mail-ej2-f15.google.com [74.125.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79444E325E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361752; cv=pass; b=rdbJeAlawU5fRwvVZltZXU/k3yVM5fBwUvnochkhXZFqkONxYvu/u9sv6ePOQK1xQype2oS3zruMBQw1bXotZnxvGNN9swFnonZzthGd3gLA6izT/0fz3oIb5pXyPoQswxuGI0DWQYzUoSYuL+4C/rea1HZaETVqzf16LuAVtIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361752; c=relaxed/simple;
	bh=DlEudOypjlT0UT2XU/5WL96WZISmA/ECBN7ByCN7TWo=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRxo58h/HHtGOw2rmuLuT0xkrXOmrCVthXrlnb+nj0qd6PCY+n/NLEzVwQ9kuCHl3i/sKSw6JxMZfjPhE7Hx1xn5K4Qv8ACieYtdxlbGeQSAC7A0cMKfZQhxvkAH6Sf99XIaoTj2PAy70IZffjIqNYV9i/KjON9Jj+IJmS5u5LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOTkTZBP; arc=pass smtp.client-ip=74.125.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOTkTZBP"
Received: by mail-ej2-f15.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso141097366b.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361749; cv=none;
        d=google.com; s=arc-20260327;
        b=fXXXt+wBurphq6+SAeQBRneGoqp1h0dnrBaNMt+5b2ZE9RzMYe5zCdwfP9FfFFL30T
         NiEH0UIzf1DQ4x35WIqKCxrkh4Q+JHtioMXUrmB9Z6hrp7s/+Qy+x8n4SlltfoATLev0
         dAYlTjAonm4YZobyUO1cl4Fl2GqHcfqfCGlEKz0lYLLxZUTGALbMsF8I+3aaxSxVqHgX
         LCyjImj4Wha3JHbuveWm2IC2aAbO/yR+q1TEBKfDGAObl186gG0XG2LQBUAVUZKD0kQ4
         kfbMe+C1SpTTaD/OidWDaY78mQ2OwwumWLIEebvK73iG2Lg3Fe7ijIYpPLgwBOU1aoKn
         Mv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=vaQh9agvQKXu5WYBVA5rNUeh6UbMXv22v7ZPcWcdZXE=;
        fh=ft+Eq49AsA/tAbrsZjdBMZ3Q1rrvVOFGrOChpS4rvrk=;
        b=ou0eKBejkphHhLv3wFKekH1qp0w71qVMPLUDlaZ0IhaAr/w2N6rtaXzIKEAUOIP2Qm
         6kBRjD4bfx5qZnG1YLno8q4pDyyrDSYkb8+3RxIyxBEGL7fvET50tU5bqGDd80KBFYZJ
         P2+QjfMru+ihQFEoHHparyqYODVVW6a47Mcr8nUlmTO9TsVVE2re4rcr7h32h5IJqBnE
         J8tT1RksAwh7ltdNIxT4Dj75vrjau9BH/5A+p2ZpvDQl6KODWPYnpLifJg9Ubz0ddO6U
         ENvSYnV9Qq+aNdE3v0UEPJEVdbGAlNnbdK0WnMm3H/RVPjKf4P6uqJTgQbHjIwK8iL4o
         EIvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361749; x=1790966549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaQh9agvQKXu5WYBVA5rNUeh6UbMXv22v7ZPcWcdZXE=;
        b=iOTkTZBP/Lm7/AH6yWxrX3SzvVDy5ZLkhrQLnMoZBIv1nK4dGfrCAPMwWofw7kDqLk
         00bthYyZ5+B/ATTa0fFrzJDHxzgRbcGyUZ/xsLCy1YHZ9LMx4LDEOVB5YZikAIlBO74B
         7WWltWBTfBNUgICa9vB/ElUGNY+Ftp5q3bmHDiCqfzfUCA4sFs/m0xobtgERqJFsKP6e
         r8cheojJXlT3BC2JhAE78FzKaoxv7x8tLhFvJ+8JQZWNW6pTfF46NnH5VQmyqBcsNz91
         VY4ZGtQOU4ZMZp8RkdmEPLX+mDja/J1fAC0GbmxGhx5mTas0muLBe5s2dc1CEm72G9jk
         jOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361749; x=1790966549;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaQh9agvQKXu5WYBVA5rNUeh6UbMXv22v7ZPcWcdZXE=;
        b=1HL+mFv/WH1ClOqTJFedurFvGtZqRiA2L12tiDzjzSnUOovFPQwjm8wNQ75+BJVR1b
         MuArG3qGOzFU+zOBLriWqOTMZIVnwuETnqkQHvooCXrua6chwZ4hUk6l201Dtm33kDro
         DSIfIeRoSten37qUvJBWg228rw6xHuMtEm9SNL3JddgpJJhw3LftWSIk/jrpK8KEfRY2
         sRrE98KYtUhrDlA85aUr0cURIOP2r8oR3Uf3hznHHWqiucEI7Y7wbiig5ASZu8D9xRKv
         0KaiqaF6WFOAxT71m6ENgbIe3JX+xiL1hpQCZUxINP/lhvjhFbRvQ80+vvjJ3c8f5Yvc
         yGvA==
X-Forwarded-Encrypted: i=1; AKwUvBzCqMjILXIvLyTAw9l278BvmggyMmVAGUBO37Vms2CtBOXN537lI/o7W9QhfgRzI9z7ftb2B5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lpvTmzbAbztS6b5URlIEWS5/KjFtasiDT4cL8h0SSxTt78nHz+
	RrLDsuhPtr1xukic59g683P9APFSFbT6Wjo5JhqkYDGxevuPgiKGeZhEMf7GPAGBJjTp0AigDMI
	Mv3P+rFW5eO2iW6VH3wwuAI4IZEk89Q==
X-Gm-Gg: AYBFou1WCUMNRGSj93ENzCDfCraL3bsL2zLMKDS8Erc76auyj37IIowAAl8BjwFcBtI
	yWOWYmfBmKLrFTMNBj9WwZK/jh0dTAzbinFywLEPQR9P19G9+CweQyS9rDFmsWdZsQEZvULdgkK
	9m5sQIk9Gie5B2NFC+bCiJsLdV8NH7r5zR7Ifa3wto+3lB1AgL6xSMmlHGZyJAA+F1kkleQF/yp
	fx9c7x1Z4A9Q7r0eAvm91VwmHzEFnXIFE53nPwNcI2T3wiNyKeLP/VISghOKTvN97maX8XeNkGJ
	+U6rS7T9BNaieMhHMUuQ+yHiDxaQztXkbl/0FpScwuqHW0G3/oRXN3GcRyymYQgtmIAxnTBQ+4w
	nxK7GSKBY/oSPG7ReBe1WeIz/XKTFrS/Ct2nXqL2OJ1DWr2MB2Cf07QGOEmtRgjO2
X-Received: by 2002:a17:906:dc90:b0:c29:57c4:cb92 with SMTP id
 a640c23a62f3a-c2ac228849fmr621819666b.0.1790361748717; Fri, 25 Sep 2026
 11:42:28 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 11:42:27 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:42:06 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 18:41:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
In-Reply-To: <CAGEsz8HtRE-sAM2YfC0_Vzcq9OeuMiRVc0cMTpWogt0Uwc4-1g@mail.gmail.com>
References: <CAGEsz8HtRE-sAM2YfC0_Vzcq9OeuMiRVc0cMTpWogt0Uwc4-1g@mail.gmail.com>
Date: Fri, 25 Sep 2026 11:42:27 -0700
X-Gm-Features: AclHuK_62Txs1R6aJpFVtyE2f4h_5eO8zVZDoQklxyOE6uOg6AtGXwg5pp6EdGo
Message-ID: <CAGEsz8GWLwXjNKo-9RpR=sGWqoqiaW-bmT9o+fYsTJSkymiqNA@mail.gmail.com>
Subject: [PATCH v2 2/2] media: venus: disable recovery work before HFI teardown
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

venus_remove() cancels core->work before the IRQ is disabled. An IRQ
thread can queue the work again after cancellation. The work can then
access HFI state after venus_hfi_destroy() frees it. The work also
requeues itself when recovery fails, so cancelling an already running
instance alone does not close the race.

Disable and drain the work at the start of remove, before other resources
are dismantled. Do the same in venus_hfi_destroy() for paths that bypass
remove, including probe unwind. Disabling the work prevents both IRQ
handlers and the work itself from requeuing it. Drain the work before
disabling the IRQ so an active recovery can finish any IRQ based
completion waits. Then synchronize the IRQ before freeing HFI state.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and
helper functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/core.c      | 2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c
b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae7..94d4b8688ac2 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -538,7 +538,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;

-	cancel_delayed_work_sync(&core->work);
+	disable_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
b/drivers/media/platform/qcom/venus/hfi_venus.c
index e7e4e78a186a..20b8ba1e62f1 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,6 +1689,7 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);

+	disable_delayed_work_sync(&core->work);
 	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
-- 
2.53.0
