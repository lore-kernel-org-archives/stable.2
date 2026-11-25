Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619225;
	b=nz2ftH32Wc9cDXacjEx+n8KaYj998Q593RSOpeb3Nu074kiE2ERQiOBbXng6ceG0SUtr
	 qrwYEUaxjKu7UPMgq8juCFW+bGJ/t3GN6SFEUBK7iTwnpwqAKQHTPnWYZW+90hdUhadmm
	 och0tITcsvz1dTPwOE6LMLjYv0tOinHbHdpV+uLxdSi+UvwJgnH0CZrLfo5ZyhklBAt6w
	 dTAuDx3G+xt2KFHJuLy/jZloXMZllIR2wRRRAgGxMABVo1ICFGl1GO4Vdtm9VQjBCluMg
	 HpjjWBZvFJtKrjBaH8GtIB+G2XPvu1RBD2bxBUgK6N09+nechHnkafi98vlZnZLsKng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619225;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7TV8CEC+IGmk7QtdtCiAfWjmfVuptrIsaCGHkVYntwg=;
	b=oLjemZy6TJx0HZTONWX5mVW3en/LTASLuLiGIEeRMOAqCU4BqiBytF44R0UKVYposg5n
	 /Zb+1ob78mqizRWGARYJ0qVHWNU+FILDZ/kBPmkqbaHYSvfh5kQ/YX7WMRy9p34UIBtwA
	 nW7u/LwCFUE7egU++PS1CI/+SjhHd2PzlEseNca/nAojpmBWun6qo31HEWOVBZ3j8/AmY
	 jifGO2ANcgg0ccx3YzfrP4ggFmupPhCKZPM/B+NPZUrBX4HeRfwbGPL49882t3KUVK8LJ
	 XUV9GIwx035BhvJkurwS/Og43TFPgxs19jFcov8UGt3xrfEMjg18VP9QmOmykJUkPTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPimXdCI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=m6mRDQMA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4061606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4061606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPimXdCI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=m6mRDQMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795619223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TV8CEC+IGmk7QtdtCiAfWjmfVuptrIsaCGHkVYntwg=;
	b=RPimXdCICGBpZYl5HiOc6d2wrNa3qCsBkKan7B58i390hbdB/jr+0PNqyHB8fm2hG77ifJ
	vMXkz9ZIT1DRZE5anMmyXyJhVOvohpz9QWS/7HqZB+9qTQLwWkHCiyn46droF5hjF2xNwZ
	vRvzjImq65Dp0jCyC2J5UnNwlaDwwBE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-3J_TUPztMUOmRffOYM3Kwg-1; Wed, 25 Nov 2026 15:06:58 +0000
X-MC-Unique: 3J_TUPztMUOmRffOYM3Kwg-1
X-Mimecast-MFC-AGG-ID: 3J_TUPztMUOmRffOYM3Kwg_1795619217
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ace21839cfso20411841fa.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795619216; x=1796224016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TV8CEC+IGmk7QtdtCiAfWjmfVuptrIsaCGHkVYntwg=;
        b=m6mRDQMAoj7XXRJELzvNjxPbuy36kFTBDCkMmSV3F/MlvgnsuvMjBph+/qF0X8qUpW
         iofjAdyexvNfq1VBkp4CGvMMdFFrhs30I9/52NlPJ/28IWImRDAFFJPx5Hls6GPZZGMo
         iGzjuZo4QBi5mrGHXCfkwrSgQvX/3waIntPcoDwvYVF+cv501zSOEzaESc/rNH+0nlfQ
         jPgjCWi2M4Cp7atlyONY4jwZXQm1WWrHcb/0YfF4R/4lm9I2JwrRyot0/kc0CzJTvSD7
         LSBlhfhKJvNhCxbx2khKZwumupKx1pt2mRq0qT/ULZc8Ol6dlgnv+NtJny+RjF9x0ByC
         RWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619216; x=1796224016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7TV8CEC+IGmk7QtdtCiAfWjmfVuptrIsaCGHkVYntwg=;
        b=SDtiziN0Kc25XNjPDKN3tMCmybHCQ7qZPY3IYzGdetgfvo+MOinb9njtwoC+TntOoC
         X1y55vljP1UN39mzhG6kktkPxCgRX4+DeTtQRwb/qblmeiNG+ddBSOtPaTHE2JmWRwTr
         YDEVsWt4x2nhIsUfSxiGPECTZC9aD36KhSRLtmplKPck74X7nLqnAPmzST+GXz9Y+cvF
         L8JVvc6ue719oYWHPYj2AWeQg/+7y878hTPU/CIVrFK4G1q3u7y+IfeSzmJcQjo8GkDX
         f5qxbq6SHy7Sbzd2oVUpUl64ikaVpk96zlmYuAYdek7oHaQUJK4xVKDGc1O70yNuzo2e
         MVEA==
X-Forwarded-Encrypted: i=1; AL+hErGPY7ifHGBnyYMm4CivuSvTindmz1FGrFVxupRr5iwabr7cjltvTiV7RYxnpW78qBOqLrGV+r8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hG2aNaWFTdykcHS1uHX4wo1UtKohuJl7fD6XyB4IQ8IGiQT+z
	rR7Mv4p2c7xj7asZWc4rUpZK/iWaCTFezkWtqrDM3ylWeXwTjrPX2jPdaeOLGHrprN43vMYI7yb
	bixWbOCFVcHDMlM/sUmh+9VF4aasiNGgBNIOTQ5fkbYjgu/dNdPYASWDdnJZU3DTn
X-Gm-Gg: AZFdTZfwW/JmSd+IEP647Z4JeiT/UqcYBRog4Q55mwDTE6vhNrVevPnql6D1pKxWzku
	DPsePFd5mH7FTTdxE4noZ4qcxXni3//iuMGNgBUbzChgkSit1PQJTaJW5GL0lElO1oO355AFEI9
	dtAZOyMlAbZseN+gjT+08Jj1X5yJ6Cva4rSNBiIr206PeP5Ce9UymtgQEWdV1kQn+Rxa/O6QHZZ
	aFBIWht2MWp3tu0R4ZoL+qv7CWh+G0MZHzljBqwDSDjVKfMpTnCva6Y3jWO2om6uGgiaPWTu1wh
	DaW8Pr1Yy1+yzBWFTwtiUPbx3alCEmWUIU+KxCo6iZdSdZHL6hgYcJ83TXXY+vGXKVv1U2jWoPB
	YdT2Mu+UTlI2xcXGriSMyX41EcjzZ+sNYwg4x9+ybbZ1YxT/F/8YF6tNSOUgt3boMYlg/SQXOuz
	Gyatqa
X-Received: by 2002:a2e:bc02:0:b0:3ab:751:6ba8 with SMTP id 38308e7fff4ca-3ae7fab444amr50263411fa.28.1795619216530;
        Wed, 25 Nov 2026 07:06:56 -0800 (PST)
X-Received: by 2002:a2e:bc02:0:b0:3ab:751:6ba8 with SMTP id 38308e7fff4ca-3ae7fab444amr50263231fa.28.1795619216125;
        Wed, 25 Nov 2026 07:06:56 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8053568esm50270861fa.25.2026.11.25.07.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 07:06:55 -0800 (PST)
Message-ID: <4a3f734d-bd8d-468c-bfd3-15431ec22ad7@redhat.com>
Date: Wed, 25 Nov 2026 17:06:54 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private
 migration
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Aveline Noir <jm5905938@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 stable@vger.kernel.org
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
 <awbtZjtII9h1oJ5R@raptor>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <awbtZjtII9h1oJ5R@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 11/25/26 16:15, Alexandru Elisei wrote:
> Hi,
> 
> I tried to test this patch, applied on top of v7.4-rc4.

FYI, I am doing changes to test_hmm.c invalidation handling and will fix the two fd invalidation as a follow up also.


> 
> With the changes to the migrate_anon_huge_fault test, but with no changes to
> lib/test_hmm.c, to see if the test fails without the fix to the kernel, I get a
> kernel fault:
> 
> [   95.571212] Unable to handle kernel paging request at virtual address ffff7fffdfe00000
> [   95.571221] Mem abort info:
> [   95.571223]   ESR = 0x0000000096000004
> [   95.571225]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   95.571228]   SET = 0, FnV = 0
> [   95.571230]   EA = 0, S1PTW = 0
> [   95.571231]   FSC = 0x04: level 0 translation fault
> [   95.571234] Data abort info:
> [   95.571235]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [   95.571237]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   95.571239]   GCS = 0, Overlay = 0, DirtyBit = 0
> [   95.571242] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001cc71d000
> [   95.571245] [ffff7fffdfe00000] pgd=0000000000000000, p4d=0000000000000000
> [..]
> [   95.692002] pc : __pi_memcpy_generic+0x110/0x230
> [   95.696623] lr : dmirror_do_read+0x7c/0xf0
> [..]
> 
> decode_stacktrace.sh says that happens in lib/test_hmm.c:503.
> 
> This looks more serious that the use-after-free that KASAN reported.
> 
> With the changes to the test and to the kernel, I get this error when running
> the test:
> 
> $ sudo tools/testing/selftests/mm/hmm-tests -r hmm.hmm_device_private.migrate_anon_huge_fault
> # [INFO] detected hugetlb page size: 2048 KiB
> # [INFO] detected hugetlb page size: 32768 KiB
> # [INFO] detected hugetlb page size: 64 KiB
> # [INFO] detected hugetlb page size: 1048576 KiB
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           hmm.hmm_device_private.migrate_anon_huge_fault ...
> # hmm-tests.c:2156:migrate_anon_huge_fault:Expected *(int *)buffer->mirror (0) == (npages - 1) * self->page_size / sizeof(int) (523264)
> # migrate_anon_huge_fault: Test terminated by assertion
> #          FAIL  hmm.hmm_device_private.migrate_anon_huge_fault
> not ok 1 hmm.hmm_device_private.migrate_anon_huge_fault
> # FAILED: 0 / 1 tests passed.
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Might be something on my side? I'll investigate further, but I'm not very
> familiar with the code.
> 
> Thanks,
> Alex
--Mika

