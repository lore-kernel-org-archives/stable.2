Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794556464;
	b=X715vJzFsT2k2ZyiIkbfS+r9RBb1zMiRv69613x8MgEqbYMy1UaM5Onhi9QU0ec2TXBd
	 E6JZUAxMfxlHV3HqzVYHSjEcr8jPoselgQ3jHVJfPwAWrfF1pfJgMNF2yV6GevGdjcbnj
	 20iRstDeWDzEJAHzGEnpAyInFtdow9LNevKn+sN4Dhv8a+GXaYnUwZL09LrDs1nS3aTD7
	 HSJz66aNt2H5IihjRrlmwlyQcJjPG3id0ihlCwGVe5a4b+x2XZT6enPD/ltszxPXgogfs
	 bqnRXTgutIF6s/MgXIgSqu78v2UgzhVHR7w4JaYtuUoFUPcEeDeBLP6+KYHHA+P5ihA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jLWs2ipoib4sqkrDJNqUZN3ZZXCrx/V1Jn/vcRzhZf0=;
	b=pcE1sDEnAQXCjizntVIZuzA/DFra/nhKqavL+Ctw+qiXebXmu0LN2IV0MSTE6GOIlDlO
	 WzI26SXA+Txqkny5yPS2AGgVkAuXgtMUxc+04C5hMHPEy021OBmTlytYgh5xi4dY/uBpk
	 oBTwiFReX1nVUCQU1OQ9NvdN3w6LojZd0A3M11lWDAn5AoJZ5ewLoSVLOhSLlekdjtuBe
	 Z1hyvPAM/9ekOsT9EwrszQsCgYEfxWFTrVsVbgoRgbzotDzlniu8JWs/2enXdrRDEkVbt
	 +mpWrBFbfmMRppqJ/n8bDRwmDTPDBYiz9q4HtZ7HoxKVdKJ2vvSrM1nlB8bzjg1IJtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWBfalc5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542A606A8AD
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8542A606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWBfalc5
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c00c727a21so63442e87.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794556463; cv=none;
        d=google.com; s=arc-20260327;
        b=YdT0oHn0l7eyKOwrBokvrn7BZaUwK3ou8cm2ERMdq2qML2VkCZ3fg0d86lvd89M1tr
         0MkxFRlqGKfonFjch+QLCz/tjqz3tO47IKjMuplDCh345xX1ReNFuzqAGdb12YdVduHN
         LJbvP4wqiumNtU8yF7nfDlU1uDX/7NLh4RaIUicV4VkrHGXbL0gg4cKp5S0f7BC7WlIX
         J+4Td6vn23E1mLQZmZ/SgrRcRCZ4bV60hC/ca5F6FIv2thFg+j0vxcAoEzd7DMy9LnL3
         hYxi3oTVXTlyt80yxE3E3l9YGdcdM7xky5pVWFDv4jxRoJI6+1dMZZJ9fZIMoqvqcEtD
         tJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLWs2ipoib4sqkrDJNqUZN3ZZXCrx/V1Jn/vcRzhZf0=;
        fh=viJnxuP0X46d26IBETyuCKKKmkzzJRALF3cyLfrtgfU=;
        b=kH7ijtEybEqafpMBYgHQFhhm2gXLGEMXVurmghHDH1dvKq9QdPQ6hLBHbBmgZpzKdL
         9QJQyDQcJQVcFBILxf8sGNOrf+9lxwGpFUmxqKKtVxmvgn6piOzNyOrKH5/ixXrtXzE0
         gKSYPLU5u0zsnKxUW1Pf74b93INUg9lnvOy8/gSPfzZh8JsSaI22hXx0tz+mPXCyUtSO
         R7roTjnxBotJyREFzRo9jhAMGW1+PQxdhb4oFmTDrGVYPoJbEPKLMLJmxiMzqFuwX8Ag
         476vmL6HgZYnP9BSTrbaFhSaCVzaY8owhUsinHfLOYyHg5D8B9j7SNFQLl0bsRT5AHzt
         FvqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794556463; x=1795161263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLWs2ipoib4sqkrDJNqUZN3ZZXCrx/V1Jn/vcRzhZf0=;
        b=lWBfalc5odhHJQWPB0IRkDdkAm39vie6sBqtg8GNvSOoS9CHH/JhdjaTbIhIyVAckk
         GC3OB9V4gEMXN+jAMZPKOjBKUwtvBNfCBZHLMLPWFlZ3YzpBiIHNu7ovHm884isdQsVY
         CqP63Ase+zOCljdTJKMKuS7udyN5XNbtaORQGTZgVgSsPqnjGz+6+nUsQlEJAi0h6UMo
         uIpgGhI1fWB4yZ1mZLyTLJu2gAHkLxAT5Ygda7E7aNNiSzbg8tUH7yXumwmJQMVcoXmb
         cpygLUps/5aVKjZRECROZAlcCSnUSF6i8qCt1tPQgGDud5mnI9ml5bPRVixIOjUqthxr
         KkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556463; x=1795161263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLWs2ipoib4sqkrDJNqUZN3ZZXCrx/V1Jn/vcRzhZf0=;
        b=noIsJjz8BOUvYSaGfZX23asWatXmb/YVMOrv2AMzi7qbRgqsixh29/9uApMk1plsuF
         Xyq+pGrK6y1UCiBPyKNXUyYCVKJiSLM19EJIGWUGwMG8AXLc4nExLIkcF/PT2tqwIOMx
         Lzzn4d5PqTS0KK39CI1LqaMSUI3SathWqgQ+rXtxFF2exK1RSeI5DnQLURvHskAG3RqB
         VBCVQwb9AxLYPG9sbE2qge1KXqw2vjfe4NNhwvjvDyEcgznU5VU3jOJ5C8JoPRrYEEtY
         3ljJkv//nQDoQ4yZVdQ6/MopJBF+y+irQnmHqGhcGIrg2qZXKOWy+5grhRzi9Sn1O5Wg
         WB8Q==
X-Forwarded-Encrypted: i=1; AL+hErG7hQxuGg61+L31+Hr/ot7H4pcJbig2nLhw4zq75wrrG4qasyOmzMjmVFuaIf+R+6wABeJ57wo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TVR8CryqE/xSuuu0Rg4Vy80RMlAZfhlXc+3i/9oimJSSoea1e
	yk+JOsavQw/k4FmwUy0rhrW9nSqGGHrXmyZtUg62v1JN1B7ghK52YQ6RVCHft7m2rpf9isVwcc8
	KCGcrw8aW+1UKafQTXdm+Bt1kI6MBOjtEo55NwlGXig==
X-Gm-Gg: AYBFou1XBTWYl0TJRPLyCiV2tdExkq1UM7OjNkU8XLAStT+3c8ceF7Sa92+YD68Iq69
	JM0v/ojqOeYQZgLHs4LiPH++o2cof86cYxokBWdFBhJQu78E9nlGJi5d++rRmEVU1ATygc6mbLs
	n3mMIejYK6N7GOsCsFUJZiBHBtU261uarXmcGWEqSJy9tkmkdS1hGNV1vx/imiaqZzZQSeK8Bwj
	cVvNOZULaUFHZvQZJWQvM42wHGXgGGPq5pribXHxWpVrL6db5OCSrv+wtRROZh+KtqPqYyZmhRf
	oHiVLkfWaobksZL+9F6Lb7CrMsj0/R/6i4+LGDLZCCp33wAgRFMiuJv8O1/aHF0WRRS5w4c9GOw
	Aj1BOyxlzac6mGXPVmkjxnFJqRf84Ko83/Kjccke1iN5t+99rkiezYHacxavOTfnkKjCuyQ0=
X-Received: by 2002:a05:6512:3da4:b0:5bf:ce1f:cd22 with SMTP id
 2adb3069b0e04-5c170434e66mr787433e87.0.1794556462452; Thu, 12 Nov 2026
 23:54:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
 <20261112-hantro-robust-v2-2-18561fd48838@gmail.com> <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
 <f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com>
In-Reply-To: <f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 23:54:10 -0800
X-Gm-Features: AclHuK-bvo5dDl4JVbgBvuOoQVFelHqw3mvt8zCrdDgOeg2cHm6xn5vl5OrzWyU
Message-ID: <CAEy9hNU2ox76TFKtdisqUHDxZ=3gPVBDBcjz_W8RtCpCpK5d7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
 after remove
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Hans Verkuil <hverkuil@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>, 
	Tharit Tangkijwanichakul <tharitt97@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Le 12/11/2026 =C3=A0 11:19, Philipp Zabel a =C3=A9crit :
>> If vsi-iommu accesses require these bus interface resets to be
>> deasserted at certain points, why doesn't it request its own reset
>> controls?
>>
>> Depending on implicit assumptions like another driver not asserting its
>> exclusively controlled resets seems fragile.

The AV1 node lists these resets for hantro only. vsi-iommu would need
them in its own node and binding, and both drivers would have to move
to shared reset controls. Device trees without them would still hit
the SError. With this patch hantro never asserts the AV1 resets, so
vsi-iommu no longer depends on what hantro does with them.

> There is a side note on IOMMU doc saying that once the IOMMU has been
> enabled it can't be disabled for security reasons.
> That means that writing 0 on VSI_MMU_AHB_CONTROL_BASE register in vsi_iom=
mu_disable()
> could raise an SError so I would suggest to remove this line from IOMMU d=
river.

I only see the SError after hantro_remove() has asserted the BIU
resets. vsi_iommu_suspend() does the same write on every autosuspend in
normal use, and that has not faulted here.

I don't think dropping the write is enough on its own. With the resets
still asserted, the AV1 domain is powered off when the IOMMU suspends,
which is the fault 8e26d4c20ed2 fixed for hantro's own suspend. The
next bind then resumes the IOMMU, and vsi_iommu_enable() writes its
registers, before hantro_probe() deasserts the resets. I have not
tested that.

If you would like the write gone as well, I can send
that as a separate vsi-iommu patch.

Arun
