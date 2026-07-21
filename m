Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1E2D7393;
	Tue, 21 Jul 2026 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611247; cv=pass; b=nmGxE0nM40w9ix06kIRCCTQPrd9OtIlQh38UwoOy07Z8yAgYTmC3FDRj2ZllcFKX/vj0rj+G5B11hMHIAg5Tzv3mgtGGrXhj4Ad55tCA34jMDVthE23iuho4vfTzH3RpHMqueHwpGyVPUR3TU/xi69iRaqi0i23zChdN4ZZBhXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611247; c=relaxed/simple;
	bh=Sqyd2iI5fkWmHnSlSSQrdsfjb/NYarTLfaWlS+hcGYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaEk2ZPa+7EdJq0CJRdWA+ojZ8NitCGEfS9M4VDkiraby/Fw9oyoXEGaT1AkqfmI5o6XZ4On3/VzkZ+r8i4SWNedCSzsl+asDHPf6hLHNSXGHYaivAjVj9K8pQqtkA7JZUM3Huy9UrS59wvYxF+Cz00Wo+kG02IoHqbnBufLjZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com; spf=pass smtp.mailfrom=yoavmoshe.com; dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b=ClKTDFa1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoavmoshe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yoavmoshe.com header.i=linux@yoavmoshe.com header.b="ClKTDFa1"
ARC-Seal: i=1; a=rsa-sha256; t=1784611218; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YXldcrMVRv9AwB2SCKvjY5ah80LK7PLbegwI5zE7S33lG/zc8ZuXYp2ztLQFu3okbgIWEjZ8C2gu7RdVwU4ouOXmT8yjzVQbbASBSbVoJ+3DqzhT+gTuLdSACs+kWCU1SunSKB1qK/J7qwE6V50VdCEJ0Kp/0xd8X42UWk+ffPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784611218; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MeAIg/nFoLV4HPdy7uK9Th+eYhFPpG/Q07Hu7di9WW4=; 
	b=f538/rQMV8XuRF0T0jIM11UM/z50ftLwDvASkGvmQFRmJQu3cwvby3BwzD9xCAa86dPEFvIvg3/NK3Hg1/Nqk7+e1g74CsiWPm1kP1t5takI1wYzUDsn31MRyar80CZ7FaNiPm0QQcysVyR5fqFKCHHOJlSmKnz5Bk8fY48ttjY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yoavmoshe.com;
	spf=pass  smtp.mailfrom=linux@yoavmoshe.com;
	dmarc=pass header.from=<linux@yoavmoshe.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784611218;
	s=zoho; d=yoavmoshe.com; i=linux@yoavmoshe.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MeAIg/nFoLV4HPdy7uK9Th+eYhFPpG/Q07Hu7di9WW4=;
	b=ClKTDFa1P9nJhbRjKKoB9/a6FYZyD47U4yY7+fn5Ub2/dgBWFIa+EI02zvx4/U+I
	4JkT+KJA5zRFF9gRqRPPobS/1eBtGpiW/qtuVc4+1roCziNf+cdGN1iBwVRVo62efW/
	3/aUJGqVIsGXJy4hPnl15PvXXXHOTVg1h+6MnYT4=
Received: by mx.zohomail.com with SMTPS id 1784611216000751.5066369487145;
	Mon, 20 Jul 2026 22:20:16 -0700 (PDT)
Message-ID: <38fd4fc1-7aad-464d-9d8c-5667ebcff89f@yoavmoshe.com>
Date: Tue, 21 Jul 2026 07:20:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Nick Desaulniers <ndesaulniers@google.com>,
 Yo'av Moshe <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718111340.159896-1-linux@yoavmoshe.com>
 <CAKwvOd=eAC-Mz0kZhbHQMFOY=ba=WXDH6X_Zzh6KGfuq5PmJ4A@mail.gmail.com>
Content-Language: en-GB, sv-SE
From: Yo'av Moshe <linux@yoavmoshe.com>
In-Reply-To: <CAKwvOd=eAC-Mz0kZhbHQMFOY=ba=WXDH6X_Zzh6KGfuq5PmJ4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2026-07-20 6:53 PM, Nick Desaulniers wrote:
> 
> Are we able to just put __nocfi on the declaration of
> `imx6_suspend_in_ocram_fn`, rather than bother with a wrapper
> (imx6_suspend_in_ocram)? I don't know if that works, but surely you
> can test that quickly?
Thanks for the suggestion! I tested placing __nocfi directly on the
imx6_suspend_in_ocram_fn variable declaration:

    static void (* __nocfi imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);

Unfortunately, Clang ignores no_sanitize("cfi") on variable declarations and
emits a compiler warning:

    warning: 'no_sanitize' attribute argument 'cfi' not supported on a
    global variable [-Wignored-attributes]

Because Clang ignores it, it still injects the CFI check at the call site.
I tested this on physical hardware (Kobo Clara HD), and it crashes on suspend.

Best regards,
Yo'av
