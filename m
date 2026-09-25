Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016261A0BF3
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294968; cv=pass; b=PLyq7JYwtQEGOCMjiy6JL/BX7EeWLZybQu9K14b3s6nKgyB0pbaiAMCt0FGLwYJgoTZ4u4Ps7m2aY9d3soZFWBsI83lO16Byge28c6MhrRC1NkLOdfmrimTQuwGo9AGNgBZqhsvYMzFirhQrc37bxljVI4cPJiOBSCz5khj1RuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294968; c=relaxed/simple;
	bh=YSMX5FLA+2PLf6XOskP8bd0x+m6bdSeEocRmUK+dICY=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajR/SaFnKfF4ZwDMoMNgA25vDzMM2BVHKVksOdCNsb5Rco6vkTNjaqyaFUw0P35bS6YqFbCdtPBLVTrMnkcOL0S55Kk/TdstX9sBqx0RdslbHYg6LwuLXwBzky+1B6vUAcSuWar6swAOz8JeDcNC0NA4xO8Mt8Aqtcs4Rzyxe4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMGt7b+R; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMGt7b+R"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso55482366b.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790294965; cv=none;
        d=google.com; s=arc-20260327;
        b=YCuBsB4qoCvw3jWqVix4OPqzntHwxoEhH3xo74HOdAdKJB4/ouaGNGOXaPOccqdvMr
         xf5Zb4+z/xMzUGyBkk8ZHN1728IEI5IAhXermNXwKJrb15Deeou8zz2qio7PFfUafHZ3
         DHrc62pXAUIa2S/tedaZDa7CgTwZWlBfCbOcD9VsBIwWMpUn+FuVmsG8bPB+LYEnCQtN
         URMYmIwPATZenShf+REt91HMDNtBZG+kGPQflbZlxHmtC8a+wcq3NYXV/GP7VVq0/F6Z
         lGu+UEg/Dt41Gm5AXICsdorLfvXjT/qq9j9UomHHM2Z14jNQXbdTyCJlN5YA85vZRnRZ
         3mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=CyX0bYFSyTy1F08pLyuTwWBLmwqeeaIpLJGH7n6wEgI=;
        fh=UrvBgZw158yyYk1mMzMX7Z1ngX+Y5p+JEzzyUKWYrNg=;
        b=jB/rIkzFD4gou3iOvwZqW0wWcmd5eZSi+H6GDNR3X+x52sPTSaRSz05vhgW93/Nhk+
         QzULHq6SOV/SJXROGUyCaI2XdlKDP62RQYnwIaKVHfUwmFLCCuzigpwkHg0ybGmWrdH5
         IA0QcnVq3KScSjAFQ/CYGNkq6RV0K0p5feM4J8mwy3oODwbsH04oypAHc2MKKTtZ4pEV
         ubjZl8Cezhiu0dc02PlDblxQdiqV8Q2cYHaPcujUJDpS8kd8c57lvvlkEJDcHBhaTrYx
         SkFKjx3PiUAcO5BExNQ9YefcfhKHsRoD/6XUGZw9GJxTNJkDJDAZ15/5qw8iC2BN6btJ
         I39A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790294965; x=1790899765; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyX0bYFSyTy1F08pLyuTwWBLmwqeeaIpLJGH7n6wEgI=;
        b=TMGt7b+R43WhQbmZL3n4NTNVIVlbBAiInjTRsUgiqqWIhBK08HMW2yahUbHtQDizHO
         CnaLr0xp8ExNwvlSqhUl4z6967ScxsPMITLAltzxBzggwyA+a/nHjuYkmSdxjwTpf9CQ
         2TAcIMUrnVWTncZGW2r/l+KllcbVSS/E0ggvy+Q5GLoLpIXDzh4jV38RvZ2+11H29IVd
         ei2eAXEO2V6e1KwXNTNfoo3Q4sVAESBmHY05Bv4M2KB0z7rKXN0mm92XPFYa4gjdNzXY
         gRJjh/zr8l4k2Ea48LrbKtMYB2mNvJGHdZFmh+xtaS6LexFejeCGiKxrO521KTYk+fig
         QtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294965; x=1790899765;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CyX0bYFSyTy1F08pLyuTwWBLmwqeeaIpLJGH7n6wEgI=;
        b=bjJqhLTr42pG+lGVLcpyM2DqXx+Gjx12yBl1jJxiF5xlbn8q9WiE5EreARIr5CbQzP
         NaDxw0SowF7EsAnEP0koRQEKa4RigAAvGpxy78VlX672Eh3ld031pbjWtfpulqEM/TIM
         OZQ6kb5KVm+cL1dxcrIwZJOV5xe46n/P5ETVSgDlzFS8OqJzGzUpE7egX+0QwSv8zXEJ
         BFPiGKhEeQQ526CFYYp6dgNlLmMqibVLnQVJAH6AbwRs77TTCTUrCDZQVwSu+9tv8OJ2
         tKE4dZpT4d+oHjJojMAudbQuViTE2riaxEaMinesNZh6EyXkFxEpEtGNqXBtk+SMOr7m
         JEUQ==
X-Forwarded-Encrypted: i=1; AKwUvByVfgLzRl33w60YNzbHj0vVvEybNK/wmoeu63rIbuDYj7IbHHXnZZ1GWt1o3lhmjsT3cTBhwKk=@vger.kernel.org
X-Gm-Message-State: AFuF++lrISIOseFtVAcVYpiTNbP7lHnkk2cJFgmgAO/UG7uddrJOmByy
	sD5zZV0qQfwc/3CwOn4e8+Dw2gdWYaMqjtgsYaJimjRRkFtmGBPPWO/3tQ+UVaiE+O/i72fv2rI
	pmI8DVrMo35Be22m4qSkC0GTefRRlVQ==
X-Gm-Gg: AYBFou2Xo2wZao4rKyNVb1SsFKcVxEZ/SdevmeJQiFKCyFGg4Bi6dz8z8x9FPkwj43k
	IVZgDD0Xj4/lM3Hiw3jRZG4YmLckwIGkvjxz4hIZJPYiIGFUoBd/oFZ2p9RJF8BqW8iY8119m5h
	qmKeIdT3jurvddmm3iOD38IFyCVx+48e42LnKZXLijhAMG3zXWwVTmAg8U0YmKWpksdNNcUMN4Z
	lhL58vIMlSJWcdng7bXxjd1MDeByelBMPzYWStVjfWpV6a7XBXNduKvGfO4XFw/AFvXNJiwL7u4
	sdTOGX1BWweXYHBd4Ckkuhyzxp19WgQ+4C0SgMQjENvhdFKZZlR1a3Lk9bA0mWu343PdCvL8LLy
	eCq64Fm1dfiEOZzfWJr48hZqyNhtHKcCtoYGHd8LvKAreZYNpjZvI6KpwHb3PonI3
X-Received: by 2002:a17:907:728a:b0:c29:62d8:68af with SMTP id
 a640c23a62f3a-c2ac257861bmr361270666b.47.1790294965192; Thu, 24 Sep 2026
 17:09:25 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 19:09:24 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 19:09:24 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
In-Reply-To: <CAGEsz8GkK7ZZoweuoR0DwA=CaDzJtQnmTWasEW=wPRv-yBeKew@mail.gmail.com>
References: <CAGEsz8GkK7ZZoweuoR0DwA=CaDzJtQnmTWasEW=wPRv-yBeKew@mail.gmail.com>
Date: Thu, 24 Sep 2026 19:09:24 -0500
X-Gm-Features: AclHuK8SQKUaayfiqW3eGLbdulCVU75I0EuHaaMSyB3qG3Aqki_rJZf295CwA-U
Message-ID: <CAGEsz8H02F9SQ70UmnqMz3wWO5oc6=v5YTnAobBPW2a0reWeJw@mail.gmail.com>
Subject: [PATCH 1/2] media: venus: hfi: disable IRQ before freeing HFI device
To: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com
Cc: bod@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhun512@gmail.com, sashiko-bot@kernel.org, stable@vger.kernel.org, 
	ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"

venus_hfi_destroy() releases the interface queues and frees hdev before
calling disable_irq(). An IRQ handler that has already read core->priv
can continue to access hdev and its queues after they are freed. Clearing
core->priv does not revoke the handler's local pointer.

Commit 640803003cd9 ("media: venus: hfi: explicitly release IRQ during
teardown") added disable_irq(), but placed it after kfree(hdev), too late
to protect a handler already using hdev.

Disable the IRQ first so that both the hard IRQ and threaded handler have
completed before clearing core->priv or releasing hdev.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260612103333.5585D1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
b/drivers/media/platform/qcom/venus/hfi_venus.c
index bd82066bb6e7..e7e4e78a186a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,11 +1689,11 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);

+	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
-	disable_irq(core->irq);
 	core->ops = NULL;
 }

-- 
2.53.0


On Fri, 25 Sep 2026 00:09:06 +0000, mhun512@gmail.com wrote:
> As part of our ongoing static-analysis research, we reviewed the Venus
> teardown path and confirmed the race reported by Sashiko.
>
> This series fixes two HFI lifetime races during teardown. The first patch
> waits for the hard and threaded IRQ handlers before releasing HFI state.
> The second disables and drains recovery work so it cannot be requeued
> while HFI state is being torn down.
>
> The later Sashiko report also identifies a separate resource leak when IRQ
> registration fails during probe. That issue is outside this series.
>
> Myeonghun Pak (2):
>   media: venus: hfi: disable IRQ before freeing HFI device
>   media: venus: disable recovery work before HFI teardown
>
>  drivers/media/platform/qcom/venus/core.c      | 2 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.53.0
