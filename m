Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A503A1A56
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144899; cv=pass; b=ZtrpUlqRUZt70O1FemEgX6tgDRXgXU4a420ni3Z5rUp4M97WhkKwMyKpyd67+7FSUcd9kNFKK9r+i/ZnHVGk3X2h9tBHGPRpob5MgtSIbPVX1e4D/u7jTdSgkxoLSAGP2aD4eHGHJQe295zhlWaaWyuCM91/KHoshhOYUpUz+Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144899; c=relaxed/simple;
	bh=epJUB5gTvpGGdpSohqeoBRjyUtDyaQ2iclsISq4UJxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1p97V4ByXFAf+7jeA81CyXpyWWTU+qGr7bsOKUA9t4u9y4cM4V1Y8bTn2vCF0Wx7kuLcDtBN5bSDU727vvYPIxpghXTf4sHITYXlve8WkVr2eyWmXG1kKMsvYl8g214OOatf/+Y1LA8DW05iuZ40AfI5EDsfbfa6bJDXxlm20s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar9J/uKh; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar9J/uKh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84eb072307dso12163b3a.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 16:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786144897; cv=none;
        d=google.com; s=arc-20260327;
        b=ORIyl5sGhNzAiXnh+Zx2KLF75ZA5xbq8MQnC6cuahVUCzKvN7ZLpvcRoePkUvbzDGE
         BERY1moXhMnKOS8qkrPG3QH0Tw4H3ESRf/QcAnFMWL4fW5+dcC0czhOmEW8+yAzIQAtm
         8gdY1cSYjsWMRE2//B1GjWpgOdAxPDxxP/np5cbEHPP0zZkRTCouhwK/5IVLwLTGGfx6
         CBEdunh371gMBm7+QHzSFqukjcPyx0VrDJviZEHHpLmHnWqKlZ3RZMlp+DQLQZ+mZ+ui
         vLX97Xabio3YMV3pUrh3GFbGtBq9O0wE2X54HF5MB2SOTh5lkZUZ5Vw3vqUnz7MAj1vh
         6zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=epJUB5gTvpGGdpSohqeoBRjyUtDyaQ2iclsISq4UJxw=;
        fh=yy5VASQSIlflQMno1nKbEUUIaAWb5oNDbN3osMCdOLY=;
        b=mkzJGa4ndZTe/GrJPuaal82R7I4BO1bavLWEyTCGw96ajTtqwmrNtrpSM/FvOYR6Sc
         y12gy47eS6Yxz1xcXzsmLfskBSv/viGlJ1ppqknze9aQjEWhHpVonEArrls+/nRBYA67
         WHWDgDKmBCE2frHf8WFBTDOe6QukkNyPRhW1/JPxwSLfHfPYmA8MBmZm1uzin/mUZSYE
         TP74WmE6f/+OOsmJkHEojojwPahtzRzP37aeUB7ey25ctwBRx4KBP9GANavydy+O0gbB
         0CYLpWtKpzGSG+AA6gpRSwQWnT+qhAx+g4hexWk5SysrgmnKhB+IC2CymzptQYW2tcm8
         YX4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786144897; x=1786749697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=epJUB5gTvpGGdpSohqeoBRjyUtDyaQ2iclsISq4UJxw=;
        b=ar9J/uKha0HSgnK2oyruntrN6tWTxD6OJrKBMce5w48lnZ65jWtXunbsN5eLRPfFFo
         wMi2hULLgH0kl14pce00253MbMgu4MO1m1BycVMZi7INJAEwlJ/2GQg59t2n13PudNbA
         lU2QLtlqQbJY91oeKZDGkkjSurd4uOtHd1VKBTwvjHtUmkZcL4WYu3tZuhZ5cHOoKJrw
         GZH4zrxdAZ3BuR9/VK8XSvfd3vmbvPcC+FyIqxVaxG40rqYdqIsMEO7OLIN8FmwLEsHF
         v64dPsKWNb5tebXdpAHivAq8iYH4v8cuIp4RhYsdO3juCYfV7nkF+QbCsNHQNWExkZdW
         aBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786144897; x=1786749697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epJUB5gTvpGGdpSohqeoBRjyUtDyaQ2iclsISq4UJxw=;
        b=K1RzQtzNmxldO1frVAeHixYlYhTr7QBEAivnDerb1o0X5wfoxI4SLg1NB4mT1fGy4O
         77f0RODZevJuWBAf/GXP1DMsluXXzhVdpqSvF05zjtdcqve+AgMllnlChHMpyrkg8xz/
         eIsiAYJIsK1PGT4xSK2ky0SPul8htxZDSZbvxdnMk5cwWC718N4hb3WXpTPBWCZHjS5/
         ZNWffMC4iW6n/AajmRZ0tMPaT20AKMPTdnEfm9BdoT5/TnWpvIj4K2qm9eGrOCFDJFN/
         fFSWgoB3ZsAAN1INTbGUq/S6q25xHAm05/FserlsNFzqrVKDRuB0N4oijyKp/2hA0Wpc
         /uNw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Jo5FdlfBIy0rJdWGdzsOwk1k1qblgepAfthwAhDmjoLPadY2W/YGAhhz0xvYOUl0h/jpRaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1Z1HqLH9/s6HjYnIMZvQXHnJB6vvUt8/+dAf679quntwm36H
	sA6uBJ83WWxKldCQzZqfmsdqhsnV+XfdyUCxW1swc9cfSy7YUEGmFnNJ2NyvCmalQ7oX+0sBXiI
	GQYzkMZWfyZoI8dmBotEhWLAT5kZamA4=
X-Gm-Gg: AR+sD107BijAL3fH8IIPiI8M5pMs+BnWQefuNrq7L3jZJxiRAkjjvvWXYGJLEQxpWlp
	QsBn3XvHi2w/EiZGsVU06DND2hspgczL4JU3ErhnM0G6IkECGurPw0L+0SulEEdQNTfNH968dTe
	vDMtnJMAb6/fjWZBZgE5lmWEXkAkq8A6re02XwW58+yKGEXT7OR14d/aMz1asJWLFXiBeXhcd2h
	TGy+mn13W9fifk70rPk2BoGk3d4BTZD0lB2BoRgdr48ruamfmCO1UXBTFQlJh7SGwWn3RqUSF1C
	VML0KnePspgRW4VgdUO2GkAtyfrnJFVZEKPjmMExkKVoTfH1GyCNGCd0pWeJj8oG/KtXrdo+9nE
	GxhKgVk6S0sDaOka3HG42anIwf18iMf7LR735QvgAoEEiKn+u/CJbbIiXn9hW
X-Received: by 2002:a05:6a20:2589:b0:3bf:99ea:aeb2 with SMTP id
 adf61e73a8af0-3cb8646fe2bmr20610739637.4.1786144897090; Fri, 07 Aug 2026
 16:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807221429.155946-1-ojeda@kernel.org> <20260808.074341.1056015191905819805.tomo@flapping.org>
In-Reply-To: <20260808.074341.1056015191905819805.tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Aug 2026 01:21:23 +0200
X-Gm-Features: AUfX_mzt6ITrqPgmG06xYNP1noGEoKAQULArIyU1uaz5hrUcXcfHz6eFuH5RVl8
Message-ID: <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, arnd@arndb.de, krzk@kernel.org, 
	alexandre.belloni@bootlin.com, linusw@kernel.org, chenhuacai@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
	tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, fustini@kernel.org, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, kernel@xen0n.name, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:43=E2=80=AFAM FUJITA Tomonori <tomo@flapping.org>=
 wrote:
>
> I sent a fix for this bug a few days ago:
>
> https://lore.kernel.org/all/20260801024841.786664-1-tomo@flapping.org/

Ah, right, sorry! I also saw another one with `rusttest` for arm64 and
riscv64. Did you see that one? We probably need a `cfg(testlib)`
split.

Cheers,
Miguel
