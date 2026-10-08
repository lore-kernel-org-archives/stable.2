Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063F3C552B
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445279; cv=none; b=Ktf+P7dnW4TLXuvf9TW3MoNAQ4r7TR/iWN2fGwqhjIj2mCD4wlASGsHffp/skkm7Aji4OjGXZLv1eomN9LVGwFd5kYk15Eu36oX3GSHlq0gmNMjFtvtaGRs6hCoGBLNdhlCQQ4QSJIX8lwYb0nxuvSWlLA4Xo8KB9gTP9q4Eglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445279; c=relaxed/simple;
	bh=ef8bxyvnltQ6HrGLLZ1t6ISbnufdn0qldifIe1FBtxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS6cNBuyNfShydsDS45Zox+etdL7+ia5kUzftFJH1oiF8XXMuD8mzThlaode+LDnLgHs77i9UgaOz8jVUupDs2a8W81aBhm8DUiV4aIRBey0nFRScoqGJiBIw730lb7tOBljcYc7KbqPztIP7AYbcuTqtPKsFRoqSpZg82T/kvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjERULn2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjERULn2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd333d4b44so1164825ad.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791445276; x=1792050076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awqJUJaCqrMD3ZNJk51KVYqwLY/lICB+bok90TEZ8y0=;
        b=LjERULn2PuOIE9PRbeK5JfN3eYqVRAlHRT6tNPcQIZ9fP8D7w4Ng3P3hc7Z11IzphE
         rao4c7BCuBsCtBDbvdjktk44Tk49Ha8TBDUipMt/IjP72kdv5qgWt64r9uk+3OBVEvS9
         kFvMA3OeXwt26RUXWvInQ5oK8b90rg4Dg1TnfME0qfAQcgiCDQz0ROgirr6A9DohDFEO
         qfDNT+SP7UBwBUuW4R2MPKYhHrPFe2CWodrj8+6cbsFEgVQw5kobEVkqQprqfttCLJgR
         +FGbgSxD/gn+qXTCK1pmB2PF/n4PiyCBBLOXCw3/7xXOlXitAS9GAvRPjDg9iyWVNj4X
         onbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445276; x=1792050076;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awqJUJaCqrMD3ZNJk51KVYqwLY/lICB+bok90TEZ8y0=;
        b=eQz3nanWtHZT40BKR6c49r4qgYHSZbDmm4CD4yUM28TdPapPEQO0SxdFs8sor7eosR
         O54l6e4Vw9+QZ/Zw+oRW0us40XoSVVfj4TsDhNBvQdZ74lUdiX9C0UcvVvrUIbtoZN8j
         8ipzo0zrl40vC7t8k8DHXFwo1LRuNm+JoYk1XkQc4PpeF4nDQa/WbdoQb9fcpFV4oabr
         a3SYX4YXgoLgPJfjdLvANAu+Gsd0H1fx6Kvfcw6fhlsokAwvMehwDkzjbXoJYw4pFVqW
         zKgmGGfMJggQB8eWlxOrtcS8T9gCET1Ij5J1A1Q4vIlRCmEBqC1MRcgLIyiulmf6yPjy
         wddw==
X-Forwarded-Encrypted: i=1; AKwUvBxK2gWtjDjLAy+z0ahOwU48Pcwac9SgkCjqEM7SyMil78pGGuZUSAzW1ZJLuCq98LPb77aknRQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjoNWG+KotsIuDgZ8SSXm2vUpavDm1TFJUVveTDhDiwENekCBu
	Cy8lbjDiR95YzKQy1RRCDzpB61iyEjnDkwP9/Lfls+Yl2pkbvQxL+eRw
X-Gm-Gg: AYBFou0LEcq9ImFWlufZ9bTNJU+4vb+3nqbFaSvfi8n0mET81/64bg1Ny3fvXsMb04Y
	J8HRy9I5i7I+tIQ5ujgpwVGYlN2jGAtvTE5Xo7pDaL6AShiQ6Np3kOXBBfL6d0Xa8Xt+vlngHoM
	WcZeYdK2vH6AJXGMu1FnkOwT/cmUHA+DbECuccKeqJXl+KM9umpyWcDLvPfyKbIr8r2h5kOecAV
	4oGZBi71hUBUrHg/FBJmjymBOOH34ixiP2i50kfQXapDvFJ2hDumwQjv+y/iIusPLcNB75xjWu8
	5aWQZ9lI5CNIW3g5YOA047eu333+zq7xrwje6R0UVJ7EF+QdeErLzR1s2pN/0l46QnO7cJHxPI4
	fiPj3rczUZs2fAJA6cv0rUIljdiMx3whh9HQ017A+rhLu+7tpzzcBy/729WWG6TwSpET1Bw5sJa
	R00A6MawwA/H1f9LaX2tO+NArM0A0mpmTqA/YIz8qMS0lUfHxrKgEUDc9Bbqne21ZdkImkQYPU
X-Received: by 2002:a17:903:244f:b0:2e2:d09f:d772 with SMTP id d9443c01a7336-2e7f4b3054amr24019215ad.0.1791445276129;
        Thu, 08 Oct 2026 00:41:16 -0700 (PDT)
Received: from [10.141.37.220] ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046feacdsm20589545ad.18.2026.10.08.00.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 00:41:15 -0700 (PDT)
Message-ID: <5048a2c0-8e55-429f-bb1e-4b888a728579@gmail.com>
Date: Thu, 8 Oct 2026 15:41:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Free any excess xarray nodes in clear_inode()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Dave Jones <davej@codemonkey.org.uk>,
 stable@vger.kernel.org
References: <20260623192850.1595958-1-willy@infradead.org>
Content-Language: en-US
From: shinka <shinnkka1@gmail.com>
In-Reply-To: <20260623192850.1595958-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> For many years we've had a hard to hit leak of xarray nodes.  Hugh
> documented it well in commit 786b31121a2c.  Recently people and
> syzbot have found ways to force it to happen with madvise.  Rather
> than fix the leaks where they happen, just call xa_destroy() which
> has the side-effect of cycling the i_pages lock.

Could this commit be considered for backporting to the supported stable
kernels?

Commit: ee3f01125010 ("fs: Free any excess xarray nodes in clear_inode()")

The xarray node leak fixed by this commit is present in older stable
kernels, and this fix should address the issue there as well.

Thanks,

Chen

