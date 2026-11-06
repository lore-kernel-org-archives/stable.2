Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997892;
	b=CJyC6H0zSJACVU0r/J1o3NpAs+Ulok55g1i11kWDtrAGQyMSP2IhUPVe4QQvwz0GAcA5
	 B7SJwdT9LVBQfve5MGarq4zJQlUcSmANnl2AzaCy6dAB2xdMinTHUB4EdvVcgy7BJ5dAA
	 Pf0SA96jttkHaxi0ndk/oUjVPDnhZuLel6LlayOyxww0SxhRp3TFRtQFOjmdiiOs5Iic4
	 /GpOfow0X6sTxPckdgmwsSJapNR7Uoxcjx+LGi+AI90PgpBEviDQuQQEx+DyX27RngwaL
	 1GHQWzCTYyOvQce5X2k73MoqStoaeox8Adb9vqAneEG5kpG0Mvr3CjF3F/esW1zwyOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997892;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=TUX6youhnFPrGvYeU+pJ1avCVsOlphuFIqYLTiOl4y0=;
	b=oFWHfHfigiRS4HpinIWAl6XyoGZrom//SpFwrhtXVyplgEk1oMMHqs7oyszmsx6Y2h7v
	 DeNxP/vwFToS9WWKJEiI1fYcYfS3X/oCh2ac2tPLWkYsRXKbj/Tqrg87NE2a7y4mt9ru1
	 Lw3L9SP0tPXXUFUoPy8xTrVrkOWp58p3++rAPHPPytPxGJAxU2pm/6s1xz8NHJG7YOWzt
	 1NqxaQnJxQ0DfZe6eHNZ4xtHAk/2bo8BzjvYQhLJaWqD711MRASE9ROZCA7UJnw+HfaDQ
	 xTq2X2JwjOeD5xsM0M8+hAs74ILLD2R5frCQVfQqztlnaOZBeFzb6EHwPCOkWMviInw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZSWYg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C4606A326;
	Fri,  6 Nov 2026 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoZSWYg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D8C1F0089F;
	Fri,  6 Nov 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997892;
	bh=TUX6youhnFPrGvYeU+pJ1avCVsOlphuFIqYLTiOl4y0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RoZSWYg8QitL0GYcOrie8WCPNu7m0hXKq/ot0GX77lPOskVbUTIosB3gUSEX0bfs1
	 nyCG+d63mv2gPixZ4MDnJSPfdssODbCLHKAMvxOXegpzjQVpdDilAWLMFDOCVV2T5W
	 mTGLJmqTWI6PvZSlzelPkUZpWr8tZqAx1STnZbUvLDQzXbPA9MFhVE+Gnz/GVTvAae
	 Y66COZnizRE5m3Rvcru5Uyg4aBAdRHrHBZUL/IyWOcW4kX21stIlp5m3w4N9ECi/K4
	 uUzTIg5UwTss4Us/M9f8HAEXoRMZbFbjcSKtYdkuHsGjeraZjO0DUdafwXei8u88LR
	 van6A/Ja2bq7Q==
Message-ID: <f85dbae0-e7a1-4441-901b-e1efd0fd4a65@kernel.org>
Date: Fri, 6 Nov 2026 21:44:44 +0100
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
Subject: Re: [PATCH 2/2] mm/memfd: handle GUP references reliably when
 write-sealing
To: David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>
References: <20261103-fixes_core_2-v1-0-f332954f1df4@kernel.org>
 <20261103-fixes_core_2-v1-2-f332954f1df4@kernel.org>
 <2c95ecf1-058e-4d81-9de5-622e32dc57df@app.fastmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2c95ecf1-058e-4d81-9de5-622e32dc57df@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 20:46, David Rheinsberg wrote:
> Hi David

Hi!

> 
> On Tue, Nov 3, 2026, at 7:31 PM, David Hildenbrand (Arm) wrote:
>> We made a big mistake when introducing write-sealing: we should have
>> disallowed *any* file mappings while we are write-sealing. Write-sealing is
>> usually done by a producer that wants to hand-off some data to a consumer.
>> Having the producer have a read-only mapping (private or read-only shared)
>> of the memfd while sealing is rather odd: it couldn't have been used to
>> fill the memfd in the first place.
>>
>> Most identified public users don't do anything like that: they either never
>> map the memfd before write-sealing (using write() instead), or munmap()
>> before write-sealing:
>>
>>  - systemd's journal writes, fwupd, Flatpak, runc, crun and
>>    containers/storage write to the memfd without mmap'ing it, before
>>    sealing it [1,2,3,4,5,6]. The FD consumer will not access the memfd
>>    before sealing.
>>
>>  - dbus-broker, Mutter, Chromium's Android linker, KWin, Weston and glycin
>>    map the memfd file, but unmap it before sealing [7,8,9,10,11,12].
>>    glycin retries sealing while waiting for the loader to unmap.
>>
>>  - go-memfd exposes a shared writable mapping before F_SEAL_WRITE and a
>>    private read-only mapping afterwards. Its API explicitly requires
>>    unmapping the writable mapping before sealing [13].
> 
> When I wrote memfd-sealing, we had this use-case where an application writes a buffer and then shares it both with in-process and out-of-process tasks. Only if out-of-process tasks are actually involved, the buffer is sealed. Otherwise, it is kept unsealed and can be recycled. Hand-off to other processes was optional, rare and asynchronous, so sealing could happen at any time. Yet, we wanted to keep the buffers mapped to avoid costly TLB flushes. Mappings were readonly, but writes were done through syscalls.
> 
> We still do this, but I don't think any of the open-source users picked this up.

Ok. So internally you would have to accept the additional insecurity and enable
the kernel workaround through the parameter. How much of a problem would such a
workaround be in your fleet once you upgrade the kernel?

Not nice, but there is simply not proper way to fix this mess right now in a
better way.

> I did not follow the folio changes, so I am quite unsure whether the implementation was racy from the beginning, or whether new infrastructure introduced the races.
> 
> Can you elaborate why folio ref-counts are unreliable / unstable?

I'll have to point you at the doc of folio_expected_ref_count() where this is
properly documented.

Back when you used page_count() vs. page_mapcount() you probably had no idea
that this is completely racy as we didn't have any such helper to spell it out.

-- 
Cheers,

David
