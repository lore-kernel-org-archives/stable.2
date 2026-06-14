Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEE26F2AF
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401854; cv=pass; b=VG3OvLZlY+TBf6PmfhGbL4Fm4OL5mop6vcxeLwxsvmYB5s/Q1e5sWm6MsCKBIef1dWy0vomnrKFGO84Tvl7feA7YwVVy7gcESyDFElGiZEHv2Vxp7LS1bKQt1d1PxMn/nFW4svsQswJedzp8/a0O/iJjckY1biaNdEJ2MRizmAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401854; c=relaxed/simple;
	bh=x99akj77/CWPECxf2U1DcO2FzdRREIg1Xo6z2wg93VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiXu7Z68F/3+fhJTv3JFgENY/6ttQ7//7PkriWIMc8oCoFEJl7SUz4q9mJvpLHyBY247W5vqDnkl3LDQrb3j/Rl6KhS+Mo+Kjf7e2SantxxEAZFZF7XqSo0g+OsFbxeu9+mCeQ9r/MTV+wcxHzyqW87gZ5QslYvPRVQmAD6ZE6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIAWdfPJ; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIAWdfPJ"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8ccea53f35cso27555236d6.1
        for <stable@vger.kernel.org>; Sat, 13 Jun 2026 18:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781401851; cv=none;
        d=google.com; s=arc-20240605;
        b=deJCHazJqdyx8r1n8lsFirUzieUrjA53CX5WD2xResyv7LM/YLTVjIBLPkJiKIf76B
         e8kYplYmRUbZQ/M/HoPk0dv1Ccoaduw0j/Ag7Ti+Hx/ug1E9n/aKFqVjYhhX/Or9VViR
         QlAMIf2ACBXmR35GBDksTg7opXzod3LtewePLplPbQz0ZJxXG0fUZDeMZLv/UaK9U9TG
         fnqi3AOBTP1tL80ZFegnanZXN06zkTFaEZj+MKFo4EHL0NKAEGnw/ps6Bjq9hDtiHUpq
         iWiIRhKkhJErEVfrLeDX4JSy+IIP/qEVSdf4CjzOMiJRiwZhHkWktOiRkVZBTIRu161W
         GKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x99akj77/CWPECxf2U1DcO2FzdRREIg1Xo6z2wg93VA=;
        fh=y6Ki+7fyfCPnGtvZuJseB4s1/V3Zc2bdGMfs4OHMO/8=;
        b=TBzdAVb2r4xVV1u7CtraxtFXyl/idD7TOSJvnPc2EvdObtb//GjfaXK9Qx6hI8sLNd
         HdxSFmO3Qky7on7iTzke51Boe7sjB/Z+gVg6GHwvL8UKk9cK//6AoFQfQyZbmO0Hfl+u
         ocjbE+zY0zlli4FezQUvw9kz5tzycc/0S5LkvGw4VKsrLWbAYJtyUxAkZAsnrmvRKiV4
         vYLlIL84r9PpXv8pqaA2UGoipAKE4pRVeyI9HELhZ3Myiozh4xJygb+iXBeRvO42dhdj
         tGktVCtB6WB7z+FFya+x/C8OCm6ii/kqWjsyunQjSr49bflGAuLejLGVUdG2eccI1vmW
         tkMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781401851; x=1782006651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x99akj77/CWPECxf2U1DcO2FzdRREIg1Xo6z2wg93VA=;
        b=cIAWdfPJSEX7wk8mkpXkynMmh5nluAd5cHcBYJ7o2QWydmCIIuQ3gc1104p4pxZCNk
         S5dO/+3IVvMp6CCf9sEGkDmRnnToTQwkESAlthSyVoopwxiwuXDAo43EOU2Fz+4/AFqC
         xJD+egSRMy6NDzLEnxrxMTxgbCRWOu/h+8oJ+vWnnq0RuVOYEAoStpseI9aWY34hsJqh
         E8eOuNVYahz5c8yGN5nsR6UnxAmS6BWFjxdnKfl4rtGj55WtmMkm1f9c6XZfFWAix8Ep
         ixtCET6fXts7Dop8Vae3SDu/iFaCVydF0qBO9LLvbJmz11F7bFr32JG1Q13ufIy0K3io
         GZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781401851; x=1782006651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x99akj77/CWPECxf2U1DcO2FzdRREIg1Xo6z2wg93VA=;
        b=WTrT03ITgMSeuiz56NrZAXYGDI+jYWn1o/gQuO2N4Tyuk2n7wZMxfbWdYo1HyhLAmy
         WuKSjmGjQTyukkEUt0BQTrr+GoS/KzRl+n0ZO6pRIYtxPwcmwc81cI2HyZG+/8hvg9RK
         F7qiD+mnY7IK0A/xlcBerczNbZcTf34FjPMWbYeQDhMv+YhHB73+sZhNXKDcxv5eIybW
         V6w9ZHTTFotAAiyhJ/LdFyM3c8EL4AHMpP5FpUwDlAubME36s2jF8f74t/Vy2w1oAe/A
         aK2MS24u7sbm+RtDm/J3XMlkhUSzNfyji2gQ/mE6S7Smc1hCXjXpQo8t3nLnntOhQbuw
         iZcg==
X-Forwarded-Encrypted: i=1; AFNElJ9YTXPD9EUaJ4LYEguJqnBR63EuLbKqotm8BOwwnM+50Qaj1F5NJpRgfVAjCvIQUM32OYFpZ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJnZU+dDwbjGmyMJ8s1Yvv/NFuh8wvjZBzhaaI0/cI6Sjcuko
	unz/ABgKRRcGIlQUKSdE73G7rk0HAZkXgSrsIWl0ECBfX7ZN/jo32XPEprs2gaV4BJcvunIe88w
	lXOJ1u1OuqLWBMpqL3LVXau4BxdVbuLc=
X-Gm-Gg: Acq92OGiBBY0KrAwbzeel4oN00UGX9tYTbsfeiUDpm6XY24X7B+ZPU+pa21JYzC1koZ
	saeuRsVbv79vz75MNYGWi9fUGSBwL/hZEy+leV3OaqcFjfdnMPdOWjnelUSLFIbQrw6/IXLq6xR
	LCSN3osr2bDtRHKXAz+zXCbNzXUBTc0tD+rGK/hyhuPqEmq9au0lYLcqq9ffztfrzTnIh2P9Edt
	r/gIm1JnDgORwe2KliCByY+4mspo//HAhv0KzTibn/zvvhw1KJDHX/lwfSGZUyQxaQXj82lzivZ
	gtH8ihKpwp94chVHT9kdTBIan8JGiQWmUIGsGvSTaRzRMKNAWwhOcdxFIv9jTcwxu5epSGrOyac
	7dETD
X-Received: by 2002:a0c:f005:0:b0:8cc:2a92:48ec with SMTP id
 6a1803df08f44-8d4500ba517mr92754646d6.34.1781401851289; Sat, 13 Jun 2026
 18:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518014920.135011-1-enelsonmoore@gmail.com> <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
In-Reply-To: <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 13 Jun 2026 18:50:40 -0700
X-Gm-Features: AVVi8Cc5EU0xQMoD1E6CDuHkdl97Fy1CwNREhWgyknBaYGC0dNIVP1zY3JcRrtg
Message-ID: <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
To: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Shubham Bansal <illusionist.neo@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 1:18=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
> Looks correct to me.
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Please put this into Russell's patch tracker!

Done!

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D9477/1
