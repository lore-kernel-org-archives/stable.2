Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.247.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693076;
	b=OrtyPzDX88sAa6MD11feT9gN6kn1LbIM3jYtIyXWqSO07HSB4qk95nT0IpvOSHeGZNt/
	 oj3OtZmmx3ghJuU99sNhVGjaa3rgBiAhWpZJUXgaPGFcrBW1Ay+C43XPyynDWOH6eKQD0
	 vBp3VQqdc3h8/jjQhxqe7CzQt62tcZA0Ro+q/xcUPKvJ/Yv33STAPUo2Hteb+gzjwPyjV
	 W0EB44xssqQ+skgGotfLEDpxOEHMhPHpB1Rsjt6L3t2HhsJyYR9xLnm3w5DtOmyDeIF4U
	 bwbXmH+dnNApmskMXw2ieuowNRaiqCBf/bqOpEeLIrNz7TD3v1tCKWxVMJgAduofRlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693076;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=L4EcRlcPTyEkbIxRjhXJq9ZXvdXvVbjjYlySVR1wKYI=;
	b=2Ode1xzQnZeObJjtfZzdY0gvr8tpMFRKLF65niGemh3HapuddomRf1vV5aP53W5aI1AM
	 qi1wF8hNEQPs9qk2QavDStsgkLNZ6DPQHZuS9bIMZbuHiv9K32Y1wodykMuW916rnr1Kx
	 AnTT9wjs5Nlr/2c/7RRWvf50MJluzSfzNFkiLDT8imIq59zTe1nwcx9gXqcm2ITsHAnuR
	 1CegouVTF3+AAtl/y4Bpf46ggiT6ENhs9tFfasvW+SN0a38JTr76BpJRX8BJE5jSI6+/v
	 cI8NxSo2hL1kNsLAM7gyEfGhw0cDzK+9V6KHH69KY9lNr7C1/WCDYYc9VGuYfgNQaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=aYIqX3pq;
	arc=none smtp.remote-ip=46.38.247.119
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD2606D805;
	Tue,  3 Nov 2026 08:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5CD2606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=aYIqX3pq
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jJh1W0RNxz8RZt;
	Tue,  3 Nov 2026 09:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793693071;
	bh=yDjkuQhj8wqQW7sNON4Yy0/wXIldLBtFl12mMAzBTUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aYIqX3pqZYRHgMXt1cl5PXhWOkl92PXD2HC6hwfkeTj6/5x0BIS58eaWF5pxMqatX
	 TVnSDqeCxgty+xcfflRxnG1ulNDV9QNGlCz226C+cE4OTYTa6w5FTdhjnKiaV0s8vB
	 9qt0yQ9MUlmKrBP3iyKHnGos5cN2NXvHDWS00056tenzilh0S+eC1VDxPrRBaP4ZT9
	 4vch9kdtN0QLp1ainTkmtSOM5Pc9msZAPwhv6ZCLIkdA4P6YpHC3nuwMOV7jlX8tA2
	 Wc3UVSBu6somilMB5IHRejzUz4jbtp0robDXbjk5Nohm8zHx37er5dizXinX/r8D1B
	 9n7yKqY4L8Vaw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jJh1V6qskz4xJ2;
	Tue,  3 Nov 2026 09:04:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jJh1S5T0Mz8tgr;
	Tue,  3 Nov 2026 09:04:28 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 5889D5FA02;
	Tue,  3 Nov 2026 09:04:17 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7a1cb587-7640-4da5-92d8-57553fd00ca4@leemhuis.info>
Date: Tue, 3 Nov 2026 09:04:16 +0100
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
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Fastov <kfastov@gmail.com>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
 <20260804162924.0268f80a@fedora-21.home>
 <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
 <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
 <CAAiTLFXd=LK93e=f3PE1f6y5m15yVknqqVNBei5rLz2AnSJ4pQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAAiTLFXd=LK93e=f3PE1f6y5m15yVknqqVNBei5rLz2AnSJ4pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179369305797.899839.5052632304350013051@mxe9fb.netcup.net>
X-NC-CID: 7sMBmLbKDQp9r384H0I/4YWHJCS0kWyZfxMwgublF8WzQF9lEXo=

On 10/29/26 17:55, Sergio Lopez Pascual wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> [CCing Paolo and Sergio]
>> On 8/4/26 16:57, Konstantin Fastov wrote:
>>> вт, 4 авг. 2026 г. в 17:29, Boris Brezillon <boris.brezillon@collabora.com>:
>>>> On Tue,  4 Aug 2026 17:04:03 +0300
>>>> Konstantin Fastov <kfastov@gmail.com> wrote:
>>>>
>>>>> Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
>>>>> .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
>>>>> so vma_set_page_prot() removes the write bit from vm_page_prot of
>>>>> shared mappings, and the vmf_insert_pfn() call in the fault handler now
>>>>> installs read-only PTEs even when serving a write fault.
>>>> [...]
>>>> The same issue is being discussed here [1].
>>>> [...]
>>>> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@redhat.com/
> [...]>> FWIW, it seems that series takes a while to get polished and
mainlined:
>> https://lore.kernel.org/all/CABgObfYgZ87%3DW%2B6E%3DN%3DWwTuyYkaoKU3hqd84JDTSAvT3_9dh6w@mail.gmail.com/
>>
>> To quote: "It ballooned a bit and getting acks from everyone involved is
>> hard... Either I or Sergio will get back to it."
>>
>> Is that something you/AsahiLinux/the world can live with?
> 
> Asahi still ships their own kernel with downstream patches, and have
> backported Paolo's series. But for the rest of the world this is pretty
> bad, as it means anything that requires virtio-gpu with blob mappings
> (venus, native context, etc..) is broken.

Thx for this assessment, helped a lot!
> Since the proper fix is going to take a while, I think having some form
> of interim solution could be a good idea.

Sounds like it. Is there one that is in reach? Is reverting the culprit
from Thomas and anything that depends on it an option? Boris patch this
thread is about would not do the trick I assume?

Ciao, Thorsten
