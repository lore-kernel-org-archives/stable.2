Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370609;
	b=ivmFqRS3zYBmfag12xKJYPFRfKgz7vMqqerhSRz5A7JuL7GoH2QjQ3D+RykktjHdfonv
	 nVuhZ7uSM7hE0coVSejK6IhIq9cJSNu/Pv6OoJ60qfUlmlnlc88Mh4Jb9Xu6fSZN/u0Jp
	 LLHR4TVotMR3lXxaSPqXQfY5e0D7iaIrsNQphVMahII85sJNzMkUI4vmhPUZAKlX5PDn7
	 HZ3FSLTSY9/y7iA6TO8la/cSPZNHfnbDvSZZfcTZ3MOpI/g0+0+3LpDzUGSOCeAFgIRZA
	 305bvpaiamd6xZF5DyOFjtTfz4gonCCyxc8OPLaVHRTC2aY/QnaNLTNXEA8DPnt5lzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=KcdVkOlTNRHI7ZDEV4KijIDaD+lWmFTKZp3nDfya9kE=;
	b=TbyKFbA/IPx8ORwW/QOIxx5d6fTj2MiylJL5yfBt25DTEsXVx5OY3ks9neqpvaYRBSjf
	 p9NPEXV95E4MqzcNkR1YsmH3OQQRNImleckoEhDrPvoQSL1A5xvZdvusDXOpu/tbQLNge
	 7MgKYUyBlUcpSG3sb18lCHYubCZFHDEtNfTgKmeON+2iTZ4mDTLR1NTea8IKnmNDPr1ht
	 SFanqlmAD/nkfc54wNxzbHA5++ukNw2thwAl1esPZP38Haj9nny8uMYgJetYuSR+syo7E
	 dIfn4iTvgmJzBJnI9h2N5g4GTeg33nhlk23vW3yIzfxRgRFu0cUOTVDt8TZPK9RETGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGAFG4uO;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F40606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F40606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGAFG4uO
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so24172775e9.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370607; x=1795975407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcdVkOlTNRHI7ZDEV4KijIDaD+lWmFTKZp3nDfya9kE=;
        b=IGAFG4uO6KYlm3NNR+wWIW+NGitpyoc080cpk9QW7Cj2cgkrjqfK915uq4Hd7s9ExD
         9ZI4MxqDg/a0Hv5CN/j80bkO+m/VzM7u4/5X621eBCg8dcAtaG40DejrWj+NnLG6Siey
         R4Vms7EI8hg2HaF+nVKpK0ayLmCfgFTN0ceSbbgJ8iwM9vBgzTROjJCL7NcVjxdBwD7a
         OKLhJj49CfpNt+NIvMajwUkEpek7prMSGXGcncaNAcqke8S1ZyoIZVXMVmeItyPFsVuS
         9Ir2rMttMGKk+bnPeYimguo8mcGHxNUEB7G3OIRfyd2zvXDSYBuGdzXG1Wu6O6tOkct7
         XdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370607; x=1795975407;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcdVkOlTNRHI7ZDEV4KijIDaD+lWmFTKZp3nDfya9kE=;
        b=aA1R0JtkbRxPQeVHxJlVw2RISuSPX2SdT7bC1qXmhqRVoumr9jsz7SsBfWPzVsIHZA
         DQhDxW3/k2ops1pTwXzpEQY3AhmM5TjEFqnETsDYtyjgvEEwAlJ4q9EownvcIAIjp5OJ
         K0gLYHtLLjUcWSueIlRUrb3U2GXDgtZmy9m7mSmL78/FG2MKZQblQaIt8UbjXWurgFGF
         jv3e+1JJsjylWXQfQNuOjJLXxeif6J2x1aT+OQAUnoetQcPY2VQR3dh4TnqFibN5AZ/P
         UYl0KVJjIX4aVLGgQkcsK2LjTmaiH4B9vnLIRtQwPTjy3PynF0yEhUdg/7oauSVuGqFO
         XiGw==
X-Forwarded-Encrypted: i=1; AL+hErGQFvwAAuvkiW58VOAUdEPQUbYgsosH0SGou62vgjVPNymTJe6iesUmHa0/fZJdriL2WJa6W5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cMFVFPH7yYDq7e6LQ/JrEIFCco6R4GhLuG+sg6/e4TwzX3XhA
	1pFHObUgRiMQ5DlXec+6XC1nMf6DNzzJjVVHIqe1oimAGnsC8d2IJOki
X-Gm-Gg: AZFdTZdfJt5VFaUu4HctY2GcqzL9WFmqTVeYpvh3A9hE+d4UJfSm4A0EslxSUj4ZqjF
	fYU8GFAS3x9m8RuFRSs6mwG3UDY8nmzuLvn8bcWTPU/hXxgyLaM26x6J227DJNIkQgWdEDxphjw
	6PNvzc0LxrhuhuFF2AwDpOdkwfGXwDuZQxHTU4ve5d8B++JxQHgYja3PnRvN8IJQ8Cp4ysZH2DY
	AtHwXYfVtTqZbBb5hBKluH1dDVTXTA1/mvB2B7CpzlBmynkOLCZ4symmS+RywmFdJsKTPuGjSav
	5eZutdMli8z1n23VFdA5ZRyZqmiyZ9k8JnUnb3eier+BV0yzoVtU9taGADw/u7hSDH/UuXQoVv1
	VzScyUXsnoEzh2fZC5LL1PX5r+4cZit/YKCvkRauG8WfCfFFZkZBiTrTQt4d1DhZl3JpehnUh5F
	TDuLbcKjYJWmqb10IauyBIOPR6MW2MLxXB3PQfKgZGH281Y7EAqeeYPHWoVwrj5lAbeOEPH/AlU
	CM/0+AJA5fxW8KwxPWLP+rQPTsfoRu8aYVq7zIvc3BVdHOFAupFcjArQ2nEdVtK0eRxVF/G4uyH
	ry3KFmWft4SG9cXRe9ZnVoc1
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr202961535e9.3.1795370606966;
        Sun, 22 Nov 2026 10:03:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm373065305e9.0.2026.11.22.10.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:03:26 -0800 (PST)
Message-ID: <2a0814ae-801b-4f5e-a2fc-e287de15394b@gmail.com>
Date: Sun, 22 Nov 2026 19:03:24 +0100
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
Subject: Re: [PATCH 5/7] mm/mremap: apply the mmap() offset limits on
 expansion
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Kees Cook
 <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 5:02 PM, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Commit be83bbf80682 ("mmap: introduce sane default mmap limits") made
> do_mmap() reject file mappings which extend beyond the maximum offset the
> file can support, via file_mmap_ok().
> 
> However mremap() can expand a file mapping and only checks that the page
> offset does not wrap, so a mapping can be grown past the limit that mmap()
> would have enforced.
> 
> Fault handlers rely on that limit. For instance dax_iomap_pte_fault()
> converts vmf->pgoff into a loff_t, which overflows for such an offset and
> defeats its i_size check.
> 
> Fix the issue by applying file_mmap_ok() to the expanded range in
> check_prep_vma(), failing the mremap() with -EINVAL if it exceeds the
> limit.
> 
> This means that mremap() now refuses expansions it previously permitted,
> however no file can have data at these offsets, and mmap() already refuses
> the equivalent mapping.
> 
> Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: fixed up commit msg ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
