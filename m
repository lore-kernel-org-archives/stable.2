Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291954499AA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636722; cv=none; b=S86E9e/Tbwl1YUVYKjTzN3rSfg5GisBEsIdHCFiT22PrzFCckiGdA67MK6czlSzfORZJMYNnhPm3D5yRYY9VHhoRrc5c90sDMBe7McDA9fBbm9kBL1wMnO3aWEI282nqG2ijAtjaEIt/SGW52h7Jr8HllyPeNYjCfpsJUgRV/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636722; c=relaxed/simple;
	bh=9K9JujrK9HAyG94mvUhqDG5Rrds1+3YjxLHFNlzeWJg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=k9Fim5rCpAA0xdYkj8FXdxnLCKPEPtRdK7gAeVpSsZP1Abu5x+PoHCCPK0tdDfC1o5IoRJBzGqQjYfUsNKfC8ly6m2JOJGLrPlUz2XAzLQs+Qf39WWZDpcUKITBtdNq/ZYdpgBZXwOe4xTwsjQ1oEYWa3D7vVkjlcQKGHU9GBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obeSck2O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obeSck2O"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso2191755e9.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783636719; x=1784241519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:reply-to:from:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9K9JujrK9HAyG94mvUhqDG5Rrds1+3YjxLHFNlzeWJg=;
        b=obeSck2OAmLxE2n8h6X8BuN9sXOFy1DGec7+xCzGJoqy5cRJNcc4q/hKc4mPgUV9x4
         TnYickKT1+Q8UA0H5pkDLJdk/tCoerfVgX5Cs3ls9ngF3sBtZrg5V1lxdN2BNRtheXhB
         GYskANRGqYzGB5APAonfNZq33Zwb20nHCchUm/FAj/RN9vhhmF6rApeZAMwMfew64cOg
         Jp5FZmARsUhLtuGq30TXMinSEZ7yzUeBbFqiFgDvGkEEv2/vNPUV/bh1J5NWy/3eYdRw
         kH/PAhm2tuc46kP6mxg9HFUh63zDHFrv+l0FiVVaGmdjafwB+gTkq+VePhervatjhaRy
         ckPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636719; x=1784241519;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:reply-to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9K9JujrK9HAyG94mvUhqDG5Rrds1+3YjxLHFNlzeWJg=;
        b=gj/2X+hzISqMd8K8xYNYTocdcJd0hGiBApbPWMSIzsdJ+UwWkCBfgH59VF12kxoAEY
         VyqkIa9c7jlJzfhIAYVvtdG9Q+vDw2YOMBjdNaNjAzc17hBHN46Pnzf28MrbqdONAwVM
         LkITz/lv7NLtcZdTw2pfuvCrCarnNM6z3OTkyGm9j92vZFX+elWIiBcF2xwjcbDg/xI/
         vbKMlaxigimNm0M/JpCanyY5bZg980u3ZIHAvtouMGpe4nZsajcoGPTYu0/ulIArHZn4
         p8jvg/CzMutw3xglyHM6Z36PCEY1QfemvEtG8OuGE5B2sFxmiHwYFZAT6RdPeHarJN5M
         rfiQ==
X-Gm-Message-State: AOJu0YwWSoy+9XlvDLUZ4VAka25UeNEeOSoU6yvPf/dP3am/aLeVxz0P
	JPo8PFo/WTF6OYB/51fzBLP1fbhg+nwThfZpdcAWYANEqwCuStUdL0rQpbdltlqB+gI=
X-Gm-Gg: AfdE7cnDtNmhFTfUXQxUprov7q+5m0ZpEacMfmRjtaFNC2Vi72L682nxLGJHMZ+E2/p
	sSQbUxHq6VJ1QnJaueBSk8dvORzsJgMf5f94jOVjvbahXSefqdDVkkNKwb+y9pfBTjs/DB6AJoY
	cEhtYSxGptm/1U1gN89Q3DORAHI3fR3gPmBVv0bmAIEiWR6wJm1cIYUax4A32oU8u+FiWiVPtMF
	ohgF5L5Fb3fc0/lCuGpQaLfClkTU0XrZZlzLUg9GMFiM0IVvNfoRZ4GisqelMYy8mXWAHRQ4phh
	NM3NWQFYbPH5L/KmsulMra+OVHLvxaKGghZpuXIWnp/TVHpFJZvjYjfem/RLl5awfS3iCbHI0md
	Xydw+oQ3VkIu7gZ5MauAt6ovA0a11GJfF5q0oXYeTRmgLCuKy05mtn0U/bIgJIDARsi8pwcmxex
	b0e+RMwt7NBEGAIPDuptuVjnKilWXSXejvTA==
X-Received: by 2002:a05:600d:8445:20b0:493:cd3f:d097 with SMTP id 5b1f17b1804b1-493e68a0f7bmr70813135e9.12.1783636719443;
        Thu, 09 Jul 2026 15:38:39 -0700 (PDT)
Received: from [87.192.104.194] ([87.192.104.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm54885432f8f.5.2026.07.09.15.38.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:38:39 -0700 (PDT)
Date: Thu, 09 Jul 2026 15:38:39 -0700 (PDT)
X-Google-Original-Date: 9 Jul 2026 23:38:36 +0100
From: Harry Erick Hanns <migginor99@gmail.com>
X-Google-Original-From: Harry Erick Hanns <sweetmikan@384.jp>
Reply-To: hanns.schofield@lexcapitalgrowth.com
To: stable@vger.kernel.org
Subject: Re:Interested
Message-ID: <20260709233835.F93A0AFDF245FD34@384.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

RE:Hello,
=20
Can I provide you with more information through this email?.
=20
Warm Regards,
=20
Harry Erick Hanns
