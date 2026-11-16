Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825322;
	b=pMRCgOK5Qy3Xf26murS46pawIqPXFn/sHeW8lC9qjXAX3wbPTh3ZOS0fNQZj6ZrpOvKm
	 jKRkeDObQM2Up9S2WtoiH3PLJhj0HHZC0/nBkJp18wJZz5lojb6O2vpub4HFzLrv01axv
	 secQoyeSRsZB90eIjcy9sSl89xeu+Pb4cCaW2n46qMjLrTgtyCTmFkCv+x9ByqeWJm/8B
	 g9sMxLsMDZBKDl91yJTSw1w0o++spWWrp6sx/N5Mjf4UXHbOYx01fx/uk1en84AIB7wdv
	 JcOGbjanwbakOeLRrsevxZH1PCM6gS1LwvYHitAl5N0zdfhvVTTV3dbAnJCfOpnYttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iyaQZx4YaB2JOzxstluIUEtBMcc33AW6Ym2vysf33mM=;
	b=iI1ohg1xVkf0P5chk8RFeyzr1F7BhHSUxAVXrCGryonJ767rnRDBr7qpHD1o+5EKmWcu
	 Roo5psuQIQBkIg6ZIkRZkgXtgVKGY5o+wkrdOV4sczN9vhyJOGVqPcM4PiOF0ajsXjRf0
	 wVdzyLwrVYONVPes1darjPQ3FMIlnTmuoJQ1gj22GOQ537z2whZnx2jHwyuaM5/F8NEAr
	 O3hTIp+RKWWQ7PB5OPDkH9ka9dx7y1apQ70u6yfsG/JKdB8sTpR4AAkVgYQDKDy4Sgvo4
	 NyT8pgUUZmR/2xXdabuYDFcFvpoYTRgp7SkxyCGRG/eFXwzt3+/53/YzVbzjrVgJBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPBhVP3o;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A7606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 633A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPBhVP3o
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4910b863b84so2365453f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825321; x=1795430121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyaQZx4YaB2JOzxstluIUEtBMcc33AW6Ym2vysf33mM=;
        b=HPBhVP3opbkndZbX/Njn+mhPHqIItUqxsBMit4KhMA7OxLH9lvreIW6onmS0+qbsFZ
         qo6ic04s2pX1PpDsHyk8Ryzhsl09JF5tbU7BvwHPN6X7RNbmE+sydbvmFCazqA3wizZ5
         8MlrMaFC00CNNoJY8Zf9QY7fG+zrAnQeopEJrL7vLiKU05gOadWRDbkR80JvwPQHKXD1
         vvnPbRiFagghTyBYC5VFRim1WBxUGE2YXmlDACBgNm9+BQsBHLfxLCGcK887RJNgGWt1
         Xi/v06icK3D/0RvVfndeM5GgGfU3sEeM6PdHMWuVMviXpmW0Y7p2DjayIvrtg6NP9TxF
         C4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825321; x=1795430121;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyaQZx4YaB2JOzxstluIUEtBMcc33AW6Ym2vysf33mM=;
        b=1KqBb5En3H6swwnwzvxtBjLiQlDS4DrEsErzmQqz7yBN82nR521o5sGwJHa/0ZS34L
         nO04KHFEzeGqPAkYO0Chc/F8UP7Xf5OnEzvEmJ49N2xAxpItFNQ4Yp/c7/i9Rw0MUFsY
         PkNweAUl4xLF2bHpn+0RPe38u17CJW0QAZ72O1364bTZYrQN3mG6khX+yqAH8zrTQIX8
         42alO/ZYx70z7Pl872WR/Sb6j4iCwpY2agFZOsfkHCvDlGoFvxbBShrWHiFIH1VcD2/5
         LsV1uyd2Jmuw8cm+xY6beiwRkpNz6ZvPuFfQnVEFTe8Pp83vBi2bqdt4Wj2f910dDpRx
         zfHw==
X-Forwarded-Encrypted: i=1; AL+hErHHqLlseGgCazWA1JO7SMthIWoy/+VSJ/VjXt/N3wCGlrrbp58vrCab7TFMndi5nybynPd3+B4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CfIAlpjFUCkXPnosY42vssXG5cDnrudmi4UezLxhy9fhp1YAm
	PnbeSiioEQTYhGRoSY5xDP7wJ937M7lFeF5gVfotdHuowltsGxMR5f+w
X-Gm-Gg: AYBFou1JUsHUqw5NnzYK6+8TRd8+xim2RDHyI3QXsmf2g49idfe5bnGoKCw37C/K90N
	I06QJ4RiaCoc0KS/Kd/Re+RNVQeIvwxIPau1AIeNsFwOTPl73yDck47omHW074gg/LjWTm5iSyg
	qp11qzKqwwrHEGYQtnu3Qo0t+hI6WkWyiQ+6GBb8JAZ9C7T6k9D3QIUnMWK2Q5NMkLiPf/VrsTR
	OLBE069Z9ziojz4eU76hojSx7Goquv/IFOjGSEH9YwBSqF99sXkF94cswh1FG0fEXOB5WGeunY2
	xHTbGawKtiBcXeKofkMVj0g34HzG5G89AnhfcnmgB3Bj8kVjdTXZAA3Yiz+xL+pMN4S8F3AHQRx
	o5VEcau2vi3TIuGOfDzQmU6bHEFe1kdkHXw6fVdGbFn7nwsvadNPl/yInm0yGb7fBSTYWl9mFhW
	PCVj3csfMXdbEYMSLOTMcGfMTf3nt6ppb2+uauveCSEcYIYKYerCtlLWK5CGJNcRrpDXmYXes8u
	Y3b9VD36KJPrAUBHFzn74YtKD3k0FZZ6frUCs+IS0M/h4TlIy+bFE6FoVhUyxD+p5u5EwPBbPl5
	J+dXhDwKufVkYZmMTLOkFnLDAQ==
X-Received: by 2002:a05:600c:4f86:b0:4bb:5fd1:92aa with SMTP id 5b1f17b1804b1-4bb5fd19428mr160740475e9.15.1794825320590;
        Mon, 16 Nov 2026 02:35:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb675200e4sm118113715e9.0.2026.11.16.02.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:35:20 -0800 (PST)
Message-ID: <b3183fe8-5e7f-40c2-a534-c643d0fd2bed@gmail.com>
Date: Mon, 16 Nov 2026 11:35:18 +0100
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
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 9:58 PM, Lorenzo Stoakes (ARM) wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> so without holding the PMD lock, so the assertion is only valid if nothing
> can concurrently install a huge PMD entry in the range.
> 
> This is not the case for a VMA whose driver implements both ->fault and
> ->huge_fault and which invokes vmf_insert_pfn() from the former.
> 
> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
> takes the mmap write lock and faults taken under the VMA lock are
> unaffected by this.
> 
> This can result in two concurrent threads faulting the same thing
> disagreeing as to whether to attempt a huge fault and thus ->fault and
> ->huge_fault running at the same time and triggering this assertion.
> 
> So just remove the assert.
> 
> Target the commit which introduced the first driver able to do this for the
> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> them using its own mapping entry lock.
> 
> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
