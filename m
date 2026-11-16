Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831987;
	b=eZjlbOwpFMo37DVaKwQzkR63RrBN93RTPPF1qG+pSh075/SpKubVFDCUnptaxB1GlHp7
	 ug60lZURV9SNK7EIb9AOey9mqrHDyJoY/f17oubo8Vzyk3QruddBWr/OrMpBQ5b/xLcpO
	 OOP0Dp8Phyje8zz0cvzfl2+KI18vZ67ntcliQOGtc2qbLfUuZJcfCD/n42IGhLoCrjg47
	 LC/IkwYtzbTZ/IfT1XlRrHgW057XFPZslshjcBko6M875/DqdquzC5n2hGdw6r0QgGd10
	 GvyIjomfWMLc9krGYIS2blR1OPhhLfDsqinf1cKAKFgiFngnoTEj/H9a0BI2whS9gvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831987;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n0Epwbp8Lzi+kI0RuXeSMG9mic2jpFCzQkf5ONSBZoI=;
	b=EcZQwt4hassPBRnFebNE7rdnO1tM3sqBATODrJea14FW5qxl/IiOHqMywm4IUc+s3mtH
	 f77p8mzomslwrNaROBYe9FmvECKOoEHJRJBf2GqFkQbzK3lOGoCM42avNYhRnBVbYqB0/
	 qMtFTtUjdEewzihGgSdqheeIbDH7Wuog8FkPNhObrc6PRvQC654gxW9gcg9ld6N7otfGF
	 2fc0Sqepook/Fmm9nyK/RCCnh4cK9acUqwNqzzqzx9XgvhnhyvORYiSuc++VjWswbrgBW
	 mLJjVl6vf3J8PbNxXoqgV+Fc8Zv+1wNwpdTQ69rb22csa+uYU/DK53ZOzG7+qFuG7mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m183Dq5B;
	arc=none smtp.remote-ip=95.215.58.58
Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1E606A331
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF1E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m183Dq5B
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rMg7ePytN4P08Ni21SDstdH+iA+/lX/CBMDE9CVdeAk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794831984; v=1; x=1795436784;
 b=m183Dq5B40gCsbnSvIUkosvRDp6iNvFEUUsw90GCzmD/I37kr7iQWWMi9+IRDbHQteR0N098
 +x9eoH1deA6cLFgbIXIy/f4oKfAuxo0H60FrjjBWwS8oqosPt8kCGQo7aeCkFYaR51xVDIdYJ/K
 N+I+MVwehH7p5BmFQeUlyrsw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 94ace7446f8399ec;
	Mon, 16 Nov 2026 12:26:24 +0000
X-Mizu-Trace-ID: 94ace7446f8399ec
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so9075e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFh3VYx9qODWjqtSrXsNcPKACZcJRzF0dnNXefN8hCM5T3gRiILlbcJoGFEarSzdj7hzRfgD0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p8bImQdlTh6+fgu0s+7yTkLan1QIjxOxAloE10TB59dlfUkSl
	GqOpngh14hEGpgVogBnq02P3Kw+sVkN81ZS2gpbKK8jM3gsLv1V0azyXQxRsRI+lbbI6DjydwT1
	3m7DZgLs6nrL4NWFGo16Z85553j+ml0nsyOqmX3ns
X-Received: by 2002:a05:6512:3e22:b0:5c1:56f6:2f50 with SMTP id
 2adb3069b0e04-5c17d6151bemr251895e87.1.1794831979748; Mon, 16 Nov 2026
 04:26:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116110549.1863653-1-fuad.tabba@linux.dev> <avro44jUWOARFzul@google.com>
In-Reply-To: <avro44jUWOARFzul@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 12:25:43 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxWuiyjmUc3vH_KxRtS_3oX5w=CE76LdsLcrqC+RzLGfg@mail.gmail.com>
X-Gm-Features: Aa3M54okcmr9MdJAy7XSmuEmAJr7gqz5micdc5fGZdFcC1JtmeOKxVLrP8oEceQ
Message-ID: <CA+EHjTxWuiyjmUc3vH_KxRtS_3oX5w=CE76LdsLcrqC+RzLGfg@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: pkvm: Zero and clean memory before sharing
 it with the host
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 16 Nov 2026 at 11:28, Vincent Donnefort <vdonnefort@google.com> wrote:
[...]
> > +     /*
> > +      * The host can read the pages as soon as they are shared, possibly
> > +      * through a Non-cacheable mapping. No caller relies on their contents.
> > +      */
> > +     memset((void *)addr, 0, size);
>
> Are we sure we want that? The guest may want to setup memory and then share it.
> I am not sure about modifying this API.

Right! I wanted to fix the bug for the ITS property table, which is
shared before it's initialized, and totally forgot that this is the
path all sharing goes through... I'll drop this, and put that fix back
in the ITS series.

> > +     dcache_clean_poc(addr, addr + size);
>
> I believe the hypervisor is already doing the cache maintainance when the page
> is mapped back into the host. (see stage2_map_walker_try_leaf())

I don't think it does on this path. host_mmu.mm_ops doesn't have a
dcache_clean_inval_poc() callback, so stage2_map_walker_try_leaf()
doesn't do the CMO for a host mapping. On the guest's side,
__pkvm_guest_share_host() only changes the software bits of the
existing mapping, and the walker returns before the CMO in that case.

Cheers,
/fuad
