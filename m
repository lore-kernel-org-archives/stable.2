Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586313;
	b=H9fOTy/iCEvywXWKPo1bV8e2L0MgLY13AyxbvyCBca5TFLOwlW0/p0Q5vO3heQ6pSVEF
	 X7ylseUjIZeg+JmPw+H9y6989oqDZ+4MyYrscGQGt87QKihdAgfm2D3VVX2meD20mTcIC
	 1mS9Q2hdYPFaB4mv1RjMnkrSbe/y1DJNMr3kIrZef7e2P/+jYPHz1H9E7eTyPMRdNUwor
	 C7GXIg08rASeEk0AnJghwN7z0KkeAZ/w4VR2HIvmJBvp00yU1wbshz/K/YVq/qCSDt3wB
	 GNS8MXeKymJUEm3udLk/YAmqg4L6a2VhKprX00cmmNC6pUDmIVRfTuzcw1f8QvjfvwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
	b=jhOuXsR+65wlzSmrR+XIDEySvWr/MCUy5ceTZvUTkSDUCavhqO/z9DWvIIls1SIk6Rjm
	 2293ZW3DOr53JH/8uV1lr9qo+93C5+/jKbg0x9Q2zS+h2sAdtPdbLrX0RkEPdxqQDEm6q
	 MHs+cHSBhRhUYDNkkBISOepKC1mP52IGKZb1vNbEBpVjdfD4YM6jcyvRSJIOJgdS/xRNI
	 zRj/tbr3RknEuY40wutZOxMvhAgXtjRVrVNIYQya/AtN7Zr+35HclkER3NYAg5oWiFW/T
	 /d4BMb3euLq2y4y0DisSsJ5EI/CsSA6RF34NEsYKaWKJOJnT3odhKMC86T7CAJbR98g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rOd1aXUB;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D39606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D39606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rOd1aXUB
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso2144681a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586312; x=1796191112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
        b=rOd1aXUBZU1T2we1TSD1gMFrYvw84I4NgnIVgnPjgI6ToFrPmCcGvY+wbLifcAt+L2
         C2bFeCLYJopHDrOZgWP6+fKsHCT08PKfroIX+E1sCjl2scMS10jbWqM4dOlIDfhZ+6DD
         uIgt7imTPy9cMT42Mr68S2in82+QG4XSAaes9wJx5GyqqAJROcKVBdokUy24gYo5Glgm
         JpqfBKAK2uwB//jl3IGJdQ79xsighQpfjsxVOqHxGPyd1J/ZFsRYTgX8p2CKuaM+kqCE
         qfluF6oW+jwLmuxnULOgetV1QlI2M+hK+9kfLbHckyJ8vqA9OoSNnJPN+9O/VgRE15bv
         Wc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586312; x=1796191112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFMuh8nwFoEFZnPvdlHZ2jAd51FcFwkpbhkwnf+oNII=;
        b=gLsbiZdEBWpVOlakQKuyFon3hdKkzrpl9rbzEMss5yfv6bQS4IsRmmZTRVKVMc0f+B
         5EsE8QJwYMc37hHFJVnQBgcteiWGzlPz9FZGgQmFjGUtClq5HVfdpscPgl+qoELwSG8c
         tSquhQS5e35JISev/vvAbA4fBPgFj+EtIkqczDVhLz5QB47RFOolKCjjhlprQnvBna1q
         uFeouF5MXodaSH9jD74jLEJ0AkR3UiQa1Gl3mikQ22jAWJF15T/c5y/2jketXx519qcX
         h8aOlELxUPETSGWS58yiyTc1JdvQyAqZiHU7RlO09r3RgL+z0UuCAZRrjHnrGF6Gv7d9
         8VYA==
X-Forwarded-Encrypted: i=1; AL+hErGFjXOqCvg+rlYDUje+Ij/DsdixZ5gFsnP2tx/kLaNwteq+h3yEaERhWMJBsVYUN/JLQL3vcs8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pXNaj8g6ue8f/8cH19rJDmW/aGqXWe1aRvhq5OeMES9WZNmQ5
	V+FXg6EaqcyKWRQrBf2g9k/d96TI2Y4Y1aRpqPDvdKnLJO/K9Ajczsxu
X-Gm-Gg: AZFdTZelTWEnYsw48Ql7uhrid2ZVX1nfxEEgxk0DFaejSAuJx4huxtWNwyQ1m37ZF+A
	sN2Hk/LbBUfPV+BSDTBz3+o1eum1SuLVqdKQcTl/p1yAFEivHXAwFKUJaJdR4HrQW0Sg/44RePV
	ZdhiR4X4CmbHEQ8AZaFyqPVWb36wXglu3TEl/HldezOPxq4ng4e4gKAWtILvMzasON7ilUp0BcI
	nhsndQ5N4hZHa8/Dky1FVF+ZiPyc4XKoBiaIdgiyIfnz9xXeIEkX7S6wVkdaaMyTmAt1HE1KzkF
	reoz5IKiF3yGVtajQYogs0hXju2vcD6aGwghiYFAv9F1J45mZfcPqLgf2h8K0I66HpBsmmsQzN9
	NIS2RYhK+1UP250WN3nVdHdfB/48xtSo4aBSubsaxm6d8Uf+fzHpZzMAUdg2IR22z5zBqlzhu7Q
	Bg7Gmwgx4wX1PaN+cQj+527wbp6O4DODp6IVNan9FsOGoPWa6vAL3k4/C/SY0/C7wK3Flx5xXJ0
	3IThkLQ/NC3BUfHcySHWqYGSyVdp5MiJl6XoqKn4RTTopeZRS37yGDGBlsqcTwEx/ylCSoQsIAr
	109POUAJPS2XrNVx13zXHByOH0RRLgQIf6s3vRJ6FH/AaFVcRXprOTUZBa8Jf/4lWOHC1/LLzYj
	FhnisHHR3UAbw8KL/2qSbFg==
X-Received: by 2002:a17:902:da8e:b0:2f0:3647:6224 with SMTP id d9443c01a7336-2f03f261825mr147681875ad.61.1795586312275;
        Tue, 24 Nov 2026 21:58:32 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm78212685ad.9.2026.11.24.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:58:31 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:26 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if
 perf_pmu_register() fails
Message-ID: <awZ4ZhK1GFHKi9Tr@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>

On Mon, Nov 23, 2026 at 07:21:53PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
> gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
> perf_pmu_register() fails we return without freeing them.
> 
> Call kvmppc_cleanup_hostwide() on that error path.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index a58634f656e9..ec05b4855736 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)
> 
>  		/* Register the pmu */
>  		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
> -		if (rc)
> +		if (rc) {
> +			kvmppc_cleanup_hostwide();
Just a question.
Inside this function, should we also take lock just to set the pointers
NULL rather than putting the whole logic(free also) inside the lock like
we did in previous patch?

Apart from this, all looks good.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>  			goto out;
> +		}
> 
>  		pr_info("Registered kvm-hv pmu");
>  	}
> --
> 2.39.5
> 

