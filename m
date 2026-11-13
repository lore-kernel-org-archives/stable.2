Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601133;
	b=SM0CwUrruMrEyfcNV2qpfA6HefPjsoUikBdnVRAVpK8EhDKN3yu/py2E5yl8td6Gh+Hr
	 zDP5PHBtoJJJpmipEYovq/EcphmtuP2gXKrq88+lRgZ35K/B8+weAfZF6pPvwZdspyFXK
	 OGierj3fcp3oAvJGr2oQNnKMOui/tDwlK8Bo2bmiGad4Q58KrVPCKaLfPNZW+6DIMl1ge
	 hvv+beKd0CaQzcW8On+0TMPEDl7w1kyk0nG3OiX7fZtq8bItj3KHtm8JdpEmYmQ/8HEU6
	 Q3pfWcrhTPSskYKTp0333Krgdrzz3P6/nd34bYyLh7e/x06qMbnLRlJzSqMCRIRwXXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601133;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RR3Y/NZUPFI501cKXclm/UeWrDA7HHS1VJgbIHKj7OI=;
	b=xz4kGYcoi71H3AqPjKn2zUTMBut72Ba7w3QZpqsSMB8SfaEUt6izq0WQ871wtejYX3vR
	 sHlggx2zu/VOm7PtnL7C9ZZQ78gXn/ECtVChezLnkB86htje+9vf++Q2JwY3HJgmxR1Ti
	 25SfCpDw1rbLpPhOTuSpFZtMmJoOIfOtIlsAs6NyNxxJk0RYUjnNsDpwjnlur0WK57R2Y
	 +bI1i5LUockhkmd6RqzKRAQKW+ysfT4JE0+uH8+7LlEnciTnwXVOwL8atIYqZPw8GWL1M
	 ftn+k+HMzds8nCnDZxLuKgcpVq8lu6hgbjYR5EHiLNXbhJqktO4m3i0dwRYgR9jjzQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIeOsCGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BF606A323;
	Fri, 13 Nov 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIeOsCGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB0F1F000C4;
	Fri, 13 Nov 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601133;
	bh=RR3Y/NZUPFI501cKXclm/UeWrDA7HHS1VJgbIHKj7OI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fIeOsCGdnxwvFJMUPt1Xo/qhLodE1HQwNmuXbr31ALXJuAgdwOFGvA1kIxYMRvCXm
	 iQYJ7uI8+01PbMxvv1/N+VJ2f/Ij34JTgImZrOPreMn7rFxr7up6YhexXClvbrXFzc
	 ZBh9VpDIPrhnfN+Z/szMfhUI6Uxv8s773oYU5PJ3a4Sm8ojgXZASMPWrfJmYdBmNM4
	 1agCsYuBHrOFItJBWni7s9sup8AV7IGF5rKr7MghgPF4lDQI0aP1eknDAP4pZdn4BP
	 Z663i7PhxEMDA0xwRpaM8gJDgGwUZmUF8NZ9mM1uX/Rofjw0eyjbekqJohTFAeGemN
	 E+h4vdmz0tOFA==
Message-ID: <cc480b1f-6b90-44c8-9306-83d1c125a9cf@kernel.org>
Date: Fri, 13 Nov 2026 21:18:46 +0100
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
Subject: Re: [PATCH] mm: use PFN_PHYS() in phys_mem_access_prot()
To: Ivan Ezequiel Rodriguez <ivanrwcm25@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261113193812.1239880-1-ivanrwcm25@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261113193812.1239880-1-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/13/26 20:38, Ivan Ezequiel Rodriguez wrote:
> From: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
> 
> phys_mem_access_prot() stores "pfn << PAGE_SHIFT" in a phys_addr_t.
> The shift is evaluated as unsigned long, so on a 32-bit kernel with
> CONFIG_PHYS_ADDR_T_64BIT an address above 4 GiB is truncated before
> uncached_access() compares it with __pa(high_memory).
> 
> mmap_mem_prepare() already shifts in phys_addr_t, so the mapping is
> accepted and then left cacheable. PFN_PHYS() casts before the shift.
> 
> On a MIPS32 XPA Malta guest, mmap of /dev/mem at 0xf00000000 without
> O_DSYNC used the boot CCA. The same mapping with O_DSYNC was uncached.
> With PFN_PHYS() both are uncached.
> 
> Fixes: 7e6735c3578e ("/dev/mem: use phys_addr_t for physical addresses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
> ---
>  mm/char-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/char-mem.c b/mm/char-mem.c
> index c5761ddedbd7..53ce0034a4c1 100644
> --- a/mm/char-mem.c
> +++ b/mm/char-mem.c
> @@ -272,7 +272,7 @@ static pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				     unsigned long size, pgprot_t vma_prot)
>  {
>  #ifdef pgprot_noncached
> -	phys_addr_t offset = pfn << PAGE_SHIFT;
> +	phys_addr_t offset = PFN_PHYS(pfn);
>  
>  	if (uncached_access(file, offset))
>  		return pgprot_noncached(vma_prot);


Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

I'm relying on Andrew to pick this up.

-- 
Cheers,

David
