Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537D40099C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141169; cv=none; b=dAA+BWSvPX19R6GiaIL28LZdKh2cVshAUXqflubONXF6ZdQK9aa+jNEPVYCHp3G4bRhcw622DdvvkHdjwEb2+ZRegsFZrJrCejrcA4/4ORCajlTV3dHzxOK2KosDzwNLSkhE+MfqileS8DZc+/oQuCqDBJBPa+KSJ7Q1BjAaf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141169; c=relaxed/simple;
	bh=p8DS9Lkfl+bVR+9wrEG/5fYveO8iAKu9dFhFTTtcoac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WmUun9gow661eE3KVN7QAVRSjOXldIKeFaEjzsTKJeeFO3nZLUkLyi3NqkuroQCCWHAJ/zmTjkXXboLD33ofNx9Ym/JpBx0IIctCYEy/MVMdeuq/YhVucXUTUcZVeDH/JWmObCvZiAxDjwwdMub3t744pJ5aLWyso1yN8gqU5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nT4A4ZZo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nT4A4ZZo"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so4305238f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784141163; x=1784745963; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NZ1koe0FoGKZWlSKLYl/usYRXo5FiitnJD7Hzawo0JA=;
        b=nT4A4ZZoFBVhnqD+4YsVsUh/vZzwf1iJBHfaqjSWyTneWel/ly9JicJ7vyqH1IX8eO
         r7aZNR03fCQ7D0kWoeQ1n+bZwglXI/IjbwRa3xcq0qd9/6Ld71Q/BzSH5fd21Vjt7weH
         D486QQN4TGemEZWOZ0yAF9dxuI1f0Acg5u36RFgL8pudNurEmr56WO3n1VLlwy9hqG/K
         apsgDSxYuM+tohF9bpqeAVHut5V5iAPEyVyAc5SeUzPM0RzXsV/j70hNg8WZa+MS6jJf
         G3z95b1dw1Vt3cBTNVhcbRMmFJX3Hr0D4TbUx4zUYRXtPP4sEHmjDlRPkq5Os0MMe0yO
         KDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141163; x=1784745963;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZ1koe0FoGKZWlSKLYl/usYRXo5FiitnJD7Hzawo0JA=;
        b=Hd04LX2UtKhu0tjjOBulvXGx4IzUIKP2G8M/VdgBtnfApEIVGJqWjh8IG4DO7ltWPM
         PMRIfvftsFGI377zj0kbLsnBm1Y2C34QFSE+foqGAuCsToSRMPqyvUdDGhzAZ5vQ2isK
         RSv6PIeRoV8lgxhRzPCLIGtW4RB2HZUAv4oQwb8GtRuBqXynP3gDYm+1T2cPa1iTnWbX
         +uXv/qq43ISq9ZhWworzBh3I5sSI9Fi+Rlhrt25Ep2xT7uOzC73lfseL91E774TsE/DN
         1Xnj6tOEfLp88DHtnSh29KOE6GOeRsYc2gysWnlqBZIDb/Lad6oBHC38isTSWLpla9pM
         vhRg==
X-Forwarded-Encrypted: i=1; AHgh+RrAhMBAbXBgGuo6Vmt7nfnduQiwRn/eCeOoCA88MVXPY/wKLZ1Uz/fFUszVPc9PhY1eCBP/NJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWBRWybXod7/kZPwszY7JccB48GwyyEV6IN0mGxB5rsBfRb9d
	1yYONQWMoJ+oITdFY5P8yTMGUQElPp/4UaUY/pnXw5hRfQI6dDnizKEOHQH4PWLs9W1Pjn1ghKe
	7VR9Ob/M=
X-Gm-Gg: AfdE7cnu/qjSHZvyReyVIxWoWzkd8q1GuMdzT+dniK//PsjlPw98x2/EikRdbuObYm0
	hAA0w9tYEZ6kaCawoBaWZMOZFWhxxsbF4husiXDxN5paNl1ziqNl/QGlSf/gJohToLJHN65WG7A
	tzTbCWfUwc+3Q5NfOQ9TCJmGPfl41w198Va2LmD4et79MwQ9m50df9AevE790e+uKxFhCqUur/q
	pTqa0/+m34+AZJP/L2FgVfFgxQ0FTI8gVCYmMNUDPAOpcvdnQvY5W3Hmte5HmVKsmXXLjvGu3Qo
	ZrA1ZCzhT42dL3U0EC9dUzprfIqLqawoAGTrL9ftCC5aQd0aE2m8PMoclQsLZfcJvooWRtQQ2Up
	/6Ekz2RpgVH3UcGdYeKgBB2h7Q9weIDRGhC5oxbIJrGjokarcaW35Z2Lo7IqdV8rXe2pRPjQj9/
	KsiF+DAmfdKgzD179NtUiJVNXAzUSddED88Lzgkd3AGCE1lnfsM+50LK9PYneimkttKrSteoqYX
	A==
X-Received: by 2002:a5d:5f09:0:b0:47f:4e46:e9e8 with SMTP id ffacd0b85a97d-47f4fcc846emr4872875f8f.6.1784141162784;
        Wed, 15 Jul 2026 11:46:02 -0700 (PDT)
Received: from localhost ([2.122.8.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c25b2sm18639255f8f.30.2026.07.15.11.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 11:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 19:46:01 +0100
Message-Id: <DJZD9AJO482G.30HLO88FPQ7UZ@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/3] soc: samsung: exynos-pmu: fix use-after-free of
 interrupt generator node
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Peter Griffin" <peter.griffin@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org> <20260605-exynos-pmu-cpuhp-idle-fixes-v1-2-0cd05c81a82d@linaro.org> <CADrjBPoHhiNTfBsEam+=AWVc03mbQt+E6gm5Dw0fo=pH-w4Uuw@mail.gmail.com>
In-Reply-To: <CADrjBPoHhiNTfBsEam+=AWVc03mbQt+E6gm5Dw0fo=pH-w4Uuw@mail.gmail.com>

On Wed Jun 10, 2026 at 11:58 AM BST, Peter Griffin wrote:
> Hi Alexey,

Hi Peter,

> Thanks for your patch.
>
> On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wro=
te:
>>
>> The setup_cpuhp_and_cpuidle() parses the device tree node for the
>> interrupt generation block via of_parse_phandle() and decrements its
>> reference count using of_node_put() immediately after fetching the resou=
rce
>> address. However, later the intr_gen_node pointer is passed into
>> of_syscon_register_regmap().
>>
>> Fix this by moving the of_node_put() invocation to after the
>> of_syscon_register_regmap() call, and adding it to correct error paths.
>
> I think  using
> __free(device_node) =3D of_parse_phandle
>
> would be a cleaner/simpler fix.

Yep, thanks. Around time of sending this Krzysztof also adviced to use
_free() in another commit on maillist.

https://lore.kernel.org/linux-samsung-soc/c866dbcd-c211-48df-84e3-f66785ba8=
538@kernel.org/

I'll update it.

Best regards,
Alexey
