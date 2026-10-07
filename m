Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9D370ADF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.202
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394189; cv=pass; b=eHEXoNAk9ehFwuHvMc0deiZoINX+f9AweG9B8eWLXw4pp5k9zAC+XxwJvIh/DX8Lp6d+01kyBZeTiwg6iAYN3qsIUE018TpniuI9tA2ofOsBkqh31jBOrKB9ChYo7gwDXs5ERV1e6VhL/HF5CkWmnyFOOcVlCs46ezoB2KLEegU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394189; c=relaxed/simple;
	bh=zTRKIT0s2tS4ywlRW4Caixv+Mc/Gnk/vX5KSCXqaq5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOpG9a+te0bjnQmjngbTPExP1N+TrZimWCjpiyYgplaLb/F+OvjQLlD9W9fozforyPY737Ot5+SE0+6jIjFpb32mtAL5bIdAjwlbSYNMcQ3eQuXzZCqSdeWMLh1eCs8SKpw/1xsnpnntOpJ+gL3FkIaoH8QfSnV4iZ2bzoRXro0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGaUx81Q; arc=pass smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGaUx81Q"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4b94bb43008so618220b6e.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791394186; cv=none;
        d=google.com; s=arc-20260327;
        b=DSItFZormDk7ldgOgEuz9/ESgXX4GFy9qWbmBINSehv1wBls5tE1KLD6WfsODmd3GP
         RGc1SxQiYpBY/+eFKLO5g5LaYRt3IUog9t/GfTo6Cn88Dmg0eSM1eOcXP6adPEF10l8Y
         Qi0C348rQE2l5oRwVa97ADCrx9JWWPpHnmYriQlWhjDVbRnXw+e5/Ka1ax16FygiLDPN
         FdDaS/LRtKedhOwq2VVRHoRIJhTYZCnwXL4L/zrtC1y/KAu/bNtAKFD2rouK0YazyMRU
         oyPm0yWdD7d1N8ckrnTpf4Rj8x2F5t3bCXxU00tM4c7NoXT7rP+9WysbOjq94oxuB8Ku
         s8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YnViTh6p04B6V5Rf/libt8dMfoBMvVqz2GPx2ijVnM0=;
        fh=+upvEx/OOxhRd2wxrJGjUVh6Ogu/xYnokCfXo1nVKhw=;
        b=eKKDiEL1CBULg/DZRpvCTiw7iixLVBUg8wY/P0j5nELMdJylVuFKAsIHzC2eeJ6Emo
         dLyNvKTd4rhgvkgNOg0Ee7j4LxNytSio061lYAAoIHR7snG1jw7vIjrxC2PeOYhJ7w93
         926F128X9TWa3OhgxfsJ665Lw9/PKK/9GROuqaPq9tq/OkIVl7R3xoYPK/r2YbrhC4T8
         DWXoM5iS2FYHuibKBQmFv/RmCgV1NJr9yvvJbeC8Gtl0HD5kSIVA8pkyhSYL5V9qi0fJ
         scZzxZ7tSbBH0emqprSTl/HBtyA7RyoaZYY7hcrL1ZW/QGIHXc8nBVF9f+b2TK3Lv36b
         +ePQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394186; x=1791998986; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnViTh6p04B6V5Rf/libt8dMfoBMvVqz2GPx2ijVnM0=;
        b=PGaUx81QKnvLqC7bDwSMY/z8Nqbmf6a+1L5WRxFb1rx2cSujFAT/MEQJMI/RJL3y07
         gvUq4QLJn72zWMVgplmXC/SPFxlPh907Oz7qJrTimqwdp6Zxj2fPwpi7kq8vH7WuMPw0
         r8tmDJ5o5pFgd9+E3AsxKHZ+Xulw4mkDKh5YoiL2geX4CdCL7Un8D5AXDM57+gRU/nSx
         B/fIoHCxu35V2tXPPG6N4suOCYAOqmI/fZSjkyVrEcFIL4doJgxXJbi/xFrlMOwiXkW3
         N/RokhItCo7NiV3XPbeFqO1Jfzz83A1bxBiO8783IXO1GI522ttLAjnPycIXu8AmIwx7
         kjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394186; x=1791998986;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YnViTh6p04B6V5Rf/libt8dMfoBMvVqz2GPx2ijVnM0=;
        b=mHs0x6sEOE1N7ULVOtk/TlgdjgXp0igrzkyl5kppFCWwwTFvBFwhVqZ2WE0gMXe2B5
         6pFztGZWajF9G17YWLF3YfWXfcO5BatESkxPRgKvh1+qz5KQJ9HNEi1mnlPFi8ip2ogr
         vzkkNh5ggr8Rg7zHkyA6d7vWvc/IsYc13GtCUyYN551ZAQHqnkVJhX0KBDHnpF/nCtiR
         9PN9SXyoOySzvFI8ZBOHRxO8beTSxA1/ftOtZxaRYYj3eXWv7AOld5BLZ5C0+qIIm7lN
         lNWo+srBQPTOKC9dQK3NbdJ0aS7lZ/tPjjHh7TpyQihNXLutzre9bMCRdmD1mpXu7I2p
         aJiA==
X-Forwarded-Encrypted: i=1; AKwUvBxDQcZVoAvmeOuaomwIyXl2Z/4gJIJFIjXPtKSWJZXOujGhMJWS5Ud3t//bK752dnRTdId3O6I=@vger.kernel.org
X-Gm-Message-State: AFuF++kwnR0Rzn/QFcGlg6RtFGdvMoRI5zP4lgulGiGmkE40U5FOc6Gl
	9FqB9fVm2un85h1F8lYj7DXlO99vgwbmcpgL/XjV/jGyKEhpHzcG+nLan/Us32xhxOfiyJOo4dI
	ZjnyC73st1EOin/cdDMGdLWjW8xHmm/U=
X-Gm-Gg: AYBFou2F/wOVEPhiGAu9fsikMJK620kVfgVHT4j6HFev6vARW62qE2KBVDKl5DUs8I2
	dfUydVd55T/7hI+oH7CJZOhmUOeOPw1TwSTWg3Y8qDqpxqUgdFLXxw982uT6QcaQgzQnqpbrd0d
	xB3IyjfZKClPkWHm/A3mQqoDRXuq7Z7S3pQh5K1hvLMVDkjuoB13hHbhzeD7EY6CWAneehGHQxq
	8sNsxK/b09obpoMYr/7sleppS/IvS/i0FFwNhxT0/BooCo08u8pnVyrjQTi2p+n3nzO18g3hSUT
	bIMfLxzzQiy3iNbi+CVnkrLrFQOaFPk/qtTxUlsXXpNVyprW3kn+B1JxvOoWGb7Vr+QBOZe0bUz
	uWgDj/dQ+i5Y2og==
X-Received: by 2002:a05:6808:4f69:b0:4ec:ba7c:1dbe with SMTP id
 5614622812f47-4fc4729811bmr3186518b6e.66.1791394186597; Wed, 07 Oct 2026
 10:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-fix-disable-irq-safely-v1-0-45746f9a92de@oss.qualcomm.com>
 <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
In-Reply-To: <20261007-fix-disable-irq-safely-v1-2-45746f9a92de@oss.qualcomm.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 7 Oct 2026 10:29:35 -0700
X-Gm-Features: AclHuK9vHOpqv4f2YdIvTFbohefG3iRaIeqgIeMjJY_8igy6Stps8jGud7-4xKQ
Message-ID: <CAGEkeHd_KRRUZ8Kqvmf2BWF8stVg=_FSbx701ibS=KdoAy4FZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: qcom: iris: Wait for threaded IRQ completion
 during power-off
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	"Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil <hverkuil@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       if (!iris_vpu_watchdog(core, core->intr_status))
> +               iris_vpu_disable_irq(core);

If the IRQ thread records a watchdog after this check, while
disable_irq() is waiting, it skips enable_irq(). The hard handler and
helper would then have disabled the IRQ twice, but the next power-on
only enables it once.

Could the helper recheck the watchdog after disable_irq() returns and
core->lock is reacquired, then call enable_irq() once to balance its
extra disable in that case?

If you use this approach for the watchdog fix, could you also add:

Suggested-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks,
Hungyu
