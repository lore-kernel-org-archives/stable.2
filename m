Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535948;
	b=FW9llKhA9PvIapEUivDhW3gdgkkrJBEjijyEjpWHC9Bib/Smmyc6PydNgLFLe8HNwtBE
	 ytAguUDkoPCr+BUxR1EScPNxFyKwxHK3CwWyaEJaZUmHgNVpCgi0BbQz69ZPSN7YBsZWV
	 XAon+4TPT8LnyBq9oWrd+lpxeLSaHpthxNzoYweZqDixnX+J8TvqM2XCpfVloVDSgqyG2
	 bMMs7Ad6b6J4oY0JcNJZhE7VFzuM05WHpT/IjekLKdZOQpd6F6Y0qWzhAVYf9hKKG2xJH
	 5RvM9Q4JEbcz1Js1bD7kOU//Nv/XxjJvGhU0nK1jOkQ8HiJewn+dqVAeF7qt+mnkPIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
	b=XnjP/KnCrWikk8gug4agZLRcfcSddUcqgGaanBqyjmbObZkN8iSYTlo1TsTkJoIyZ+7n
	 2hXzyQjK/6Pm/Hj9Kwm+w6xb6fpZYO3eBavHe2XJnyx4e5NtgjR/wt6ZS+Nn59wKpKVl7
	 JFLx2iuQywScHCLAE7lbLM0EwUzaaZc0pZ9M7l4xXXSOPaPdTjUFB1ynL40JeKREpmtpE
	 hpT9WdozoBF2BnhPX3x45tP9jOXNwVX62ZT0PUkPVvgdLPGtpArU0cc9lldVk/6UMSFGh
	 kFhbwWIuObWekCPnKdLswXrEXAxi6WwfKGPDIp4V8trsaHWcyb3p7vh/t5Ho3++tzDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe6FmElH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A42606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe6FmElH
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a357b1c649so2773046f8f.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535946; cv=none;
        d=google.com; s=arc-20260327;
        b=ezi5fIEJZRTx+yxiOPKLzpOdU5qdD2iV8NT4iWv0MyBmng+vsyHPH+MeM89cHATG6O
         Af7q5uSPp8T+xQM+02GpUjuthbGaZID2RP/GBBvN9s4PPc/5dMFiQJriUO+iHsJ7Er1T
         tSrllIWJmbUEK4U+bahRjFqz1HSFRnbANPrpb7M65+CmHespgp6UZmGEkMvCpUVvh3WG
         LsVD4lElXS04zkwLnYrVIWzDNoBIU82Mbbhgw8xWOR2aDzO0cDzncOFw4662PVLHZvEu
         ZhsepaHws6RPDqITq3vLtl9r4sW9ee8gfrfUWvtfeG9mnItKIqkytAja9K9ydNeEagOY
         5EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        fh=e0FMLcMIS/NqyU1RYlkUJDtzVbcl46LOffr2UVz38a4=;
        b=e8+ciLcB1PKdm+IEkgoP6uBXVxE0aE59Rbr5y5F4dnZFBDtDOXXBMdFxH6fP94b73K
         mJ+58ANCfefxXcngICEJA63eGBmGdBl0y+QDG/T3ZdxL25Ws+KskeQPgK7trtzr3gBk7
         l/XgsrGwB/ioYleanJDCVh/un5FAiDf+SIY0oZap8y/aOR5MIJ3rVYfx5j9wRgkuYE/6
         j0Z3crZniQSY1sr6dF2KQUlPmv1LQnD/3WkgUCJyWkZXW72rFVRvE58do1vVQgbp6DEx
         eS5c4705vJkkXFVtUKpXrlGKmcX02rel/I8Nhp88U6JyrZylzyo18gwa2FvGZmnx6DHM
         Evtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535946; x=1796140746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        b=Xe6FmElHRDHd8Mzt+qaORfLww3jW7bzp9w3MVasJYUJ2bJZdnE1Aw1mgy2NKI2sena
         dDG8JEAhbJYTTlbinXSZDegIk7R+F17Ou0v5XWKXNH5HlC58k8XA+UB8E75ye6x1hAxJ
         ga8Yx/qOWO+gSNY7Vkwg0B2Tu2ULmqkuiyfiTbxDBeLSnB8sybLjyPIk02kpUmWq/QQW
         a+gkQYsudrPJpFuZ7BZ/19Nccy2+fGjptuK6LRS0+5Tu0+jYay3+7DhvzbdQE9Wo/1A8
         xdns5t2s1hz6kYA3WVfIgT/6MY445hPydsnhJ/ULT4FlMJPvGlHi5HjWjed9/+gZZTCn
         d0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535946; x=1796140746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        b=JZF0o0V68ko9zOkRIhy92D+808a6WY1zte0YSYv4YrTYBEIPRPjhxLGzC3srtl+z54
         iQSphkegfMD4SmSJNLaCb0UqVk/JBTPZ/ACCiqlvb85mGVh2B9ye94oH+2qbXVMSP/Zp
         lNmnbuZ7ydcBWi/v6zUWZ7SNL+n6KMGRM/i67m/Sb+PGDFUUzovWP/0RlUTf0NwLP4AQ
         1UaXBZktxoZK6xHTjiqR/xoEUL0jZkOcDevsHEnqJt2hAg3JH0Rq4/rxTshXkKmpSFnz
         2j5Ad/QIItfsnome5Y+9t54+Gl1UONeK6jUSksEVpHG+Hhi1YaXXTJzrG7W/YjrGC/hI
         zoKg==
X-Forwarded-Encrypted: i=1; AL+hErE7t2AzunM4w92ZHx5eMfIDq0c63kMTY404hy1RW5pv+5gcJhThFHCCFSgVsNUDY+Lsyug8H7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DRT4W5n6hos5Cfdi4FDzl5glgu732ajzVAsS5uoYkpmf/3Vgm
	+oDkmDVAYRKfnqNXrSXYnqzQlbxdSe5psCUi9e7/MvKzUBD8UAp/HYt7cd7OVC7fK+Vjx0eg9ce
	eRN+9Um0ENUIO4O3ebPGdQcyWWf5kdwY=
X-Gm-Gg: AZFdTZdq9P+b0m4wVjTKP1fFfJmxXRlpLTYQKKD0eiyypwukBV+5ah3Mla2AjF+r2Jd
	OSAp/p561xTitcP7El71VK5T1nX4483qSe6F4iIbZZrj1GQfBzkaUgEkAjt7SyfmM3IXEGhE+tU
	leYDNcnud7NworY0UvgyRJlPSAwH4Cveh2mFsE4E8++ZOEcQiNhdvqmeffXKKeBD6dVL7/AWTb2
	3PGYeGfF1ECBjxSudC4qzb8iwQYNPTu0ANu4OwObAte8MfpFtjOSIT05hQ/Zf97Pt/7GDB7o7N0
	CmGEx44ZFOCGbDmnqNFkm3asODBLpf86A4MYtDrGu0d0E6BO+WLpcmEBLFEZDbSrnqkYRizAAIf
	oTLNcNKmed2kC3QHLcWvm/K0Swy5o6b232UekX9M+8R8M8GKUMmglWzsdXM95sQjo3IHTjODOp8
	5bhYuLgnlP4VRkJ7jKdW7lOg76OHK/0yxXybtQFuSgD7CetcT3ChX5
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb8880ad68mr297552635e9.5.1795535946309; Tue, 24 Nov 2026
 07:59:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123030014.3116755-1-bsdhenrymartin@gmail.com> <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m>
In-Reply-To: <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Nov 2026 08:58:55 -0700
X-Gm-Features: Aa3M54pAoXL7yvOyF5JJv7RxaB2ypj1vzahwa9xON4kuYDyLqPQLjNR71spFULE
Message-ID: <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
Subject: Re: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
To: Jan Kara <jack@suse.cz>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-11-26 11:00:14, Henry Martin wrote:
> > filemap_cachestat() treats every xarray value entry as a workingset
> > shadow.  On DAX mappings, value entries are DAX exceptional entries:
> > same value bit, different bit layout (flags in the low bits, pfn
> > above).  Decoded as a shadow, a DAX entry yields a bogus node id;
> > NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
> > dereferences it:
> >
> >   Oops: general protection fault
> >   RIP: 0010:lru_gen_test_recent+0xde/0x300
> >   Call Trace:
> >    workingset_test_recent
> >    filemap_cachestat
> >    __x64_sys_cachestat
> >
> > Any writable file on a DAX mount triggers this once an mmap write
> > fault has populated entries.
> >
> > DAX entries track present pages, not evicted folios.  Count them as
> > cached and skip the workingset decode, mirroring the dax_mapping()
> > split in the invalidation paths in mm/truncate.c.  PMD-order entries
> > are counted as one page, as value entries carry no order information.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> > Cc: stable@vger.kernel.org
> > Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>
> I think that for DAX mappings, cachestat should just return all zeros
> because none of the fields really make sense there. There's simply no pag=
e
> cache for DAX mappings.
>
>                                                                 Honza

+1. This sounds good to me.

Henry, would you mind sending v2 along this line?

(and maybe add some documentation).
