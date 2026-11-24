Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795545912;
	b=LlObpDvJdO7z5uTkPNo86Y6ASfWaEbOFMeah6dP1tIvEU2dKg4Lj5Vz+8cwScowPSm7R
	 kqfEFqyrJVt9TRqcxSuYTN4t0Gr+yi0RcvhTBjGfthhfqgwiHzSwyjfSu5ctlJoN1ATAF
	 VTDiCOho2RWoF945UK43u/Izq6DhiuIEL18Z8h3srGBRw9hMCEJoZrfgFDc33PYzYlUyv
	 Nk3lwpU4A8lokfpXHAcM9Cn8c/tM5yfoN0DCwDiGGgoLnPj/w3vVWXpGbz878LdGegpCC
	 gkn5/tA9zRJ5oLUa2LMlv2CRtdaADHAvq5WN2SeI9G0nyEW5QSZuYaXJSlXO1YO1c7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eVt63sFAXFALqIi2TYrbUsERABkXRLEjuN5CXIXLcg8=;
	b=vIS1bRTtGMzWvxSjJoSne8whEMkJFVPwLAfys3uBr9zNwCikdNdiEjubu93XfYljsDZ+
	 /zD4vslZmss2MZvInZTLGX0/ujtoZRMKARpPs2bCibIkBVPKTbKXmC6Ih1rRQdYJOS6E6
	 Vv0LfSkx5TMs+v/L6I7GohGw0d9KZlLngnuU6vGae9d+R+/vTr/uVHvLlHTzDFMfIHzlT
	 dkoQrPOi3lPJNKfummOhRvVwhSTYX6+UUWMF4WYr2/9lxH26oM4smZNBM25AcF5EAdKXC
	 Svdv+xQoxuHRYN4pa3fOwF85bzPkotJQC8HQlzNbYxTkJKKF26qMk+7fnCy5qW0uF7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EX5Ip8Vy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21864606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21864606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EX5Ip8Vy
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a018493d57so193905e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:45:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795545910; cv=none;
        d=google.com; s=arc-20260327;
        b=OGaOP8nMPZ2FjZEnP7IO3nDfprOjGiJOyN33IV+Fop7rSmus1I1+jemWu0M0beOnv7
         2/HhtxptJXFbPTqqp2+qgEGzxuLGFt/Cw+IAy4QOTm+SRBy4NJQAPlMel//Ahp5Nl7Uy
         qfaorgLi7wW0MwVipmL+u1Rwt9tOntDV46VnbSbNYEXA5c4OqdIG87Zax4VjzxxGNUI/
         HCCzBwZQoTxr/w8HIOhqbQtOapG8uIaJbC48XXk/yNjCAtw7l65So5ji4n+qG4PT16/q
         NtraMXDKprcG5aW83/npWVtAqLpRxVuR0YkNtw+TEvZubOPyCpu/yaZAijXaluNFih0e
         skVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVt63sFAXFALqIi2TYrbUsERABkXRLEjuN5CXIXLcg8=;
        fh=2J+GZFK6gc7p+ddHuLI/nSrRpquGNmjsoabR3egNwjY=;
        b=c7yP+4QdcLGP1fXb/mKVj/ZvtFg0mlE+dW8PjkhlsGboZ5QOJT67E2vrm9sPkna3bS
         DpSRE1UWQiia7qYYd+qps/GJzO8TwBMf2p3KDuttNt1Z11Ts6XJueDonUDPVftRwbdXW
         mD/vj7NRoXqkKTjrchsJe6KSJohshXZZ5ZSHDa5dENS8pl/powfPyQaEs7OTAU5/nMIj
         +DZoMN8/OCbNGp2zRE4ULrEipHv0mUHFnlcuz3VyV6vIUK29pJEyXwKOqBlYByfqrAp5
         R5lfG0yyuwLtF+1BYqik6nv77cvKNw1Kw06SU/cy+M1NKSAuk2iEzZOBdFn8HC5kuv8H
         QOFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795545910; x=1796150710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVt63sFAXFALqIi2TYrbUsERABkXRLEjuN5CXIXLcg8=;
        b=EX5Ip8Vy8G2bSo/ueWGnhESIlAs0mrbqdtxZuoA9LwMy/GlKMShQ1UAI4/cv+GFurL
         +I0ZkpTeWfSYy6CugwTvmvx82ZOqEt2YK6jHg503nlno9cTCNMqoon8un66aypMAtIpY
         Je7VBF1+Bk1ABJ9z+SAkTdSy6ezf5Gi3LSIMWvaj6MPTyhZXFdF3jOFaaGUxSwKp8wVB
         4oBAZcisTHpzOeoHX195Wfv8XGFRIXx6fkUHieNJRuiiUhXl+Kl/RSF/R7bQar3C2amW
         PgGYsAMlXhlLSR6w4RbKQxbXRp2Nsuv0otkolUSSmje/nt4dJdwI/XYhLX2PleA6wFXk
         AKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795545910; x=1796150710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVt63sFAXFALqIi2TYrbUsERABkXRLEjuN5CXIXLcg8=;
        b=Pveh8czGiKtCtHDYiQiP/ZvbL6AHQlCyaI/dmXG3hUy8ToJI+hdAk/63m9cTF6cZgu
         GRzgZHOYkWIGE6a3Z4V4FKA8NdcACt/FS9MQoQOooA7fgTF/zCiMUbGHHoxLLNlaea7/
         cTyX0qzolFfpX3S4IcvSUUHJcD18VmZ6+oXB4bfdrvAQCxiWGu4r5t3OI67c3xzdbawV
         /EgsZnuCbLwSCg1V4yrs6Le/BcJuGgHhxNCuPflHuKVTh4DeXzhp+u3PtwjjkXU2CTEW
         yCDx9bJHsO2XIr9Mk5VPVKjbs5mt+ZPct10V5chRneIyCfyAr9eAjcoFrSOojrN5X1F5
         /8DQ==
X-Forwarded-Encrypted: i=1; AL+hErHhyipEOP+OlIzz/Ek5pUvO5aeW+LQjJkaw+hRy1e8un0zKiIW4MYDDb+qIwGRNmzdTjHVSeKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/joiM/Np1azirnTDfYmpBZH90Ff9+O0H4oIIRLiXW8d69NRYyp
	Elz6CGX2jQg7tJYu7bgoeWOBEk83JMNYWcOHNSKRI8dZzs6LLmpgGeHQ+kedNPkYfNkD7FHKgVW
	OivoNTKeCmN1sI0uUz2RAMi9wsAT9IyunrUIul7va
X-Gm-Gg: AZFdTZeEzJYc2gnBTaL8/Q+Tb5VbAfIcBHz+bffFrnRxw8tODFlVetgX/tAvcs4euHM
	KQ1XSCmjuni3bNMf6GNmk6/2hnccCswcGGfAFTXoUYbHmd2ZN89AR1frfcWluUJXPrqLVb2ToAY
	L/EKQ8MWVve7ntgTa8CmUSPnwxBHUiAeHJAm5YmJ2inYBA9TqJa4OriuEW5Azu0nwWWd5xM8Q3C
	tFsfIxMgdvOlpQ9U/UBic+2RkA6L4yCfNIq0vWIP4y5xFOhQfNpo+LXTaFSSFyxXiad9c4mMILz
	mZ5Ly9uGrwgo3DtNtJGWIjD0EE52z9SnAnq55eAKJpPUUmBBa0UO/KJoV0TXDYvqdVvAOdUYjnt
	3NXAm0RCLd+xtp3G0oZqfvLd5Uv3MOWpXguJlEtjN+tRUksylyXsN8XyTpncbPUbNNCVDfv2k9i
	3hNvzf/1ivBLohnBt4pUWpnqY=
X-Received: by 2002:a05:600c:5346:b0:4b6:7744:f4d with SMTP id
 5b1f17b1804b1-4bb916bdf08mr2257135e9.15.1795545910040; Tue, 24 Nov 2026
 10:45:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org> <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-1-276007e73bcb@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 10:44:58 -0800
X-Gm-Features: Aa3M54p26FbeOYUnrfBkiQh43qYkPRTQzVHFI8sjfXLSBe0jiLLjZbk3gYWYOKo
Message-ID: <CABdmKX2PQu7VvJ_Xs9NpkFo-wD8LWxO+FNqmdTEZBt0iAd=w4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: update walk_to_pmd() to explicitly return an error
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
	Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> Rather than callers inferring an error from a NULL pmd return, explicitly
> return error codes.
>
> This allows different error codes to be returned for different failure
> conditions.
>
> No functional change intended.
>
> This is a prerequisite for the fix to insert_pfn() which follows, as that
> needs to be able to tell a failure to allocate a page table apart from a
> race with a huge fault, so mark it for stable alongside that fix.
>
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
