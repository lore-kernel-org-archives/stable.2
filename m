Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833544;
	b=wG+fb3op8UVjPWnudCK+LFvU/CFh6cmkrH06zEmhagHY0EQV4/sJp804r5ml8Il+ZHbO
	 lP2YOabpdbA22pV0hzbZ4F/MyG2x9rJaGtg/Vl0Iy4/knsnbwCzJddRycHFp50jFrDPN1
	 +lOv2NAxrbby2ccMKm/oQUFqFkS/VPOL5EhaYbJrTK9jzGXdk62KXYfYmQLlkEmxxVWDM
	 WYUCO/LriBmGn9hiCzJYSWYhn0m9/xqumOoEuwuDAWp2yjhCXFEJ9fSf7R77HXAJLLcyg
	 EH878L5AbUf7fX/AV8mj5Pn2/eulU/69EXaiTL7FEnCHEviqmS2G6RWXjFWRDeLCaCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
	b=X3NWhAPQnZ07MHy45PVc7vGtwjDaqjRDuafqkxF6Y/ucK01300Bth5gk7srYdKxtD/oa
	 QlHt41xj5UW0W5snnQmoXxBNauVbLqohKrA32nFqdJGe2OmrkQ1qU/bzjPdnc0nJSDwbe
	 lBk/zon1+g7Y1913Fl2T1Lp1WZH/CqBx58V6lNMysUKC8sQUIvX5cPckqXRl+Xap00zLm
	 ZFkzBkw0oGAgdkDIHZLMXVSi3A7UJX/xJJDJZAJjtjlCrVrqIJ96j5+lY2/Jr+QXzIuN1
	 rTYft3+NpnEtHOKEi3QquBrMTL2I8OzodMK8wbXjfG/JL65h4XbcrNmg9PtSP+/i1uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCwcKa7X;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170C606A332
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A170C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCwcKa7X
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so9421035e9.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833542; x=1794438342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=sCwcKa7XbJktqL3hxABBeqm06+tWavHjtuY13tBflSMCRtQb+wZIupMviVt6gaX6aY
         Gb9TJwBPCahNivxGH/4ZBVweXRACmfAUBmS5eRN1ZkDU69Anp6MagJP+cxNGL7+tJgXz
         p+Kcz18jfYceosvOUAwRmqY2+5tFQcQ5tQ2GQkpZ9xudcmbmi/Qn0s1Cd1Xza7qUK+NZ
         /vH11hu6YvBS6n6hCopNr6WXk9fwzMrVX5v74pOHwKCe8+0dkjS1vNPQjdXhvQTlu3Ac
         HJI8b6gp5lEsT/akwfpznC57AQHWn+lgT1UC70Yr97MslML0Ty938MRMwLso/ME8upGI
         bZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833542; x=1794438342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
        b=h1qmlXcfiKnACZG9aklo8dS645HbRHIR3zuQGpMsgbAI9K01/jTZxbqicQ9bjfzFU8
         Ii2SFSwv22AqaXw42Oa9r5s+7DXZetzFgSsRIBTGfHqJ4qyJiwx5qDUEHp5BSAqo1b9u
         cdt2iTRumi64KyPeQ9ggQprr4BTFHfekgsu0b7z5cx4jhA6uR8ri+9b2TdsN0vqKw0hD
         x8CHCSAuY8XhbnsyUgJWt4pMo3O8pTXtf8upQz5Wz2dT6nel49ZJsleEHJx0PBE5bBrp
         haBxDg+KpFm63HNtfEijAtXFCaNxQ4uUcmS8g+95mYz13x93mU6H6Bjm6wFFinN0MHFF
         gJwA==
X-Forwarded-Encrypted: i=1; AKwUvBwfobj9qp3Z4KEwjX40RQKJtmcYGVChPuXR8kEIClMl6MD72J/JY6zL07RN/bDYUrrPK+pNPiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OkzlAhIYXkISLKiM3Ku8VgDpyAO6OK6heCnL/XpjLVR556NEE
	nu/OzhND44OQVWXqG/41PoWeuMbM0leFxNDFsx7EU7PhoFSMINVh+oQR
X-Gm-Gg: AYBFou1WUEgnEJS/XWo8HHOysgOyj2K+UgTpDthDHnWZxWD1mwCQYHidKLA0ARHp3EF
	iJRT85TE6o8TF74zgveK64awo4nGsSA3bzoBeBIrrkQ4Hpi4dNnw9wG+2Q/iw52MAOxL/138bvb
	Wk/vDfuk1ZWIIxOPU8gw7ZcE4v64yr4KnitloQvcNZ4gc2Elv8yBeEK1Ye1of+J8DeqU9Ff2RFG
	fmf3dxADiKIyL5wn44ctbJzf+8HughUU45/5mVIeap8PBEhloQbefS2QlMv6bizz4K/uo1nmQYz
	g5mAv9kD3Lst4ekVCS7vjwaDbL2kDBncIxjl1eduxRyhxJrH6eoFknUgdgw0SuxiMczD9Zzjrht
	VTPpvriBwW02S2M8L/xrrvNpjKmhapQpLfxQ9u+rUIJjqZWL64AaWuBtheQSxfre3qsxLVjh2fV
	QbyWXOA+NXahqEq1Uqp/G1XUc1fOB+jIdTfITxPbPYKMIRjTh+vqnk3pjfOy9jXWEOYDT3fV5Or
	3MBERQvrm3S6Xgk0ccZNa8wZoj5q4WER2UD78rwL+no6oLhpv39p9DN3KrGQFozbTjFWG3G9/Gk
	7CZuF27bC/hQGukXhBklyRI=
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr379985715e9.34.1793833541916;
        Wed, 04 Nov 2026 15:05:41 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5538basm5998977f8f.44.2026.11.04.15.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:05:40 -0800 (PST)
Message-ID: <853a133d-f332-47dc-b7f3-eb57f34d9344@gmail.com>
Date: Thu, 5 Nov 2026 00:05:38 +0100
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
Subject: Re: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
> 
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
> 
> That covers the VMAs vma_needs_copy() sends here:
> 
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
>   VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
>   guard region.
> 
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping. A device
> private entry gets the same CoW check, as in copy_nonpresent_pte().
> 
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
> 
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
> 
> Cc: stable@vger.kernel.org # needed by the next patch
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
