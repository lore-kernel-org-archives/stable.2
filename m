Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545347;
	b=a3aLj67VyhZLvueCrCJFVeQMFKnAzo5iTQVWYgqhFMQ87jqmxdzkAmwmwfOxgvSDnnvV
	 2F655kIEtnyvyaeYvq/dDsYac7iK7xGT6ZgKkNkTqO2PWKo3wbMH+NER5EjSGwhvphk1+
	 9ET0u0bc1xgSjK0aaixFU+ybQmnT99/Y/lrlxyW50XtIffI9iY6WmhpwKQ3iupM1BCvtl
	 fCXAl/MUS78J59WO2zUFMD4yzNpoFJKVzgOy3XJC+gC4mYEyqfea1aNnbkZK/asrEgyMK
	 O6HDrouTdaFciEv5a93w08Ggz7NCnhfQGfltXxy47psyFRbqLZ/j7qcDD4VmTmdogUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545347;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AKrIa0DcMNjfh21UT4XypKvXywHSQ8okdo6wgugy/pw=;
	b=FxL+iiKomBiR9zmfJEWuYHnvkBM71Oxz8JH3/gAggqfEmBT4qpfOMI/bP81vAvZHFuQ7
	 VPJ0CB8qdmhH9mk211TYLpi1cfZu0QbsYPtx3OkZ6EFh4f9jWB4U6PIOy3UTxa8Cq1vG8
	 00CvfIlYChv/o7vAoWRlkvV8MtfpkJvT2S74lMP2WkrMIq/4E2+Grnu1XnP5V1JIPqdEP
	 32+5D2ho8gz3ubBP4NbJERiUSIQralKIWICRW9IHRJ5cn4XtkgdENuNNYhEStb1L14IQA
	 aSrY0ApLis+BUEU1R6h37sI7t0xAUyNVpIKybV1ksdyP+Fh44Z2ZWYnCt79V13e30bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAp7n2bW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249B606A323;
	Tue, 24 Nov 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAp7n2bW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5BC1F000C4;
	Tue, 24 Nov 2026 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545347;
	bh=AKrIa0DcMNjfh21UT4XypKvXywHSQ8okdo6wgugy/pw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RAp7n2bW0wpzGNW7Ui2V2k+V9GEl4idrfP1qC2x1iSrh+5xHXbdyy0CJ1wfaoC+Te
	 txOnY9OxeabOYdbKiIA/7LqfM+X1YqOhn78nH6CeCW5v5IT/3p0k4XKT/A5iatNZPs
	 W5+i3LLZ6T7eUzNi7mRtEjDb4PP/wZ3B1WKIS202LxyIZwDnwBx25hJIDsDL/UutmS
	 W/cqup74eq7M+6UP1UVZudi13ylv+WROjXpKegblCYYHoVEBqo7Iv3GjPdvBgVdwuN
	 67ns6lvHHraDemZFXGte0ZKTYNPsz+O2Ak0t9QB6KDs5NQ95iTFoYVc6WI3yKaZNDo
	 9IVFAC/iSNvxA==
Message-ID: <498284d2-70e4-4b6e-978b-98a2b9e1e74d@kernel.org>
Date: Tue, 24 Nov 2026 19:35:39 +0100
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
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net>
 <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin>
 <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
 <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
 <awXHR007d8MlhJUC@gremlin>
 <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
 <CAJuCfpEmFEX5iqLw_c94a97rVrC+xBWpKnO4rVpeDgkUfAPq7Q@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CAJuCfpEmFEX5iqLw_c94a97rVrC+xBWpKnO4rVpeDgkUfAPq7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/26 18:49, Suren Baghdasaryan wrote:
> On Tue, Nov 24, 2026 at 9:33 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 24 Nov 2026 17:23:35 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>>
>> > On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
>> > > On Tue, Nov 24, 2026 at 8:06 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>> > > >
>> > > > On Tue, Nov 24, 2026 at 9:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>> > > > >
>> > > > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrote:
>> > > > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. With
>> > > > > > that RCU unlocking move you don't need other_mm copy and the comment
>> > > > > > that comes with it. VMA won't be freed until RCU lock is dropped.
>> > > > >
>> > > > > Yeah but they can be reassigned? They won't be _freed_ until a grace period but
>> > > > > they can go back to the slab and then allocated elsewhere  right?
>> > > > >
>> > > >
>> > > > Yes, they can go back to the slab and become a different VMA.
>> > >
>> > > Yeah, you are right about that. So, we either have to keep the RCU
>> > > unlock in place to keep other_mm comment valid (my personal
>> > > preference) or update the comment next to other_mm to explain the new
>> > > reason it is needed. Either way is fine with me.
>> >
>> > I think let's just change the comment?
>> >
>> > Andrew could you change:
>> >
>> >        * stable and can be freed in the narrow window after vma->vm_refcnt
>> >
>> > ->
>> >
>> >        * stable and can be reused in the narrow window after vma->vm_refcnt
>> >                            ^
>> >                            |
>> >                            just this freed -> reused :)
>> >
>>
>> np.
>>
>> --- a/mm/mmap_lock.c~mm-vma-drop-mm-asynchronously-in-vma_start_read-fix
>> +++ a/mm/mmap_lock.c
>> @@ -300,7 +300,7 @@ err:
>>  err_unstable:
>>         /*
>>          * If vma got attached to another mm from under us, that mm is not
>> -        * stable and can be freed in the narrow window after vma->vm_refcnt
>> +        * stable and can be reused in the narrow window after vma->vm_refcnt

But this is talking about the mm, not the vma, so the motivation to change
that was wrong? (it's not a typesafe cache). Moreover...

>>          * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
>>          * releasing vma->vm_refcnt.
>>          */
> 
> Sorry for being pedantic :)
> There is also this comment later on:
> 
>         other_mm = vma->vm_mm; /* use a copy as vma can be freed after
> we drop vm_refcnt */
> 
> That should be replaced too with:
> 
>         other_mm = vma->vm_mm; /* use a copy as vma can be reused
> after we drop vm_refcnt */
> 
> Again, just replacing "freed" to "reused".

Nah let's not overthink this. It's freed back to the allocator first. Which
naturally allows it to be reused, yes. It doesn't matter if the underlying
page can be freed or not. UAF is a UAF.

> Thanks!
> 
>> _
>>

