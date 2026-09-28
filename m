Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F549DB9B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593760; cv=none; b=H1tXWURCUUYveL8lxLG3A5q2Zc9ChqelQHqrl9MpuWQlxGJ2mjP7IuBw01nYmQG08E3tAJyfubjxdVR7Ywx3HtfFZE92zeYgE1gJfFAzgAkT1KD1Uu8NpdDVpaBX52qKWGKEJGQony+R5JKlL+WNi0gKOy3PxDtW36KX1LUkQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593760; c=relaxed/simple;
	bh=yHJH2/T8bxQU0i27QtjHSnK2maSzNqLK/UbhDNoOjNs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6rAF0DL+9n9ode6n59nNgDhKK7UK8KBW6qtywkfI6jGrqhOfN8UlRhaEtcEgbWLLrgfqW8uxiSiDGs3WwsIBfkT4GcvXton1ZqlnmOgxhLxu+OgVHFLwqoGm90+x0q2gMmRcI9ASzt83jHePYgZPipQR6TI5sqhQbRN6PCXOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShaS44sN; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShaS44sN"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso4801182a12.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790593757; x=1791198557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhEmqCbusXo+nqRRJWT3aL6p0OXcgNvckJxMKD5ctqM=;
        b=ShaS44sN7D+hE9XaB8nXUpLrmFhGr/AdvbKejWpNNt6J+2XRbGbPxpdl8fZBm7osY8
         W4zRbXSlbaGCWo4X+21vhjreXx5CUYQqWEPRD3ja5/jZ3xYLlfe2fEYAP4Ejp5ShWhj5
         gNY8kKTinSg5ucTkp5Kdamsg+6TSBvfprJNwttgRvLVFD99Hs0aOxE9muEVifJTZXhkK
         HZ7873SAAcA58QlJm7V/plUmTDtRD0mXRNSC0/4AJk7JgfYFCU3mW398UdubT6MOnRKJ
         CIOu2JqyPYiwh30pHfaIoiNY/vsTYCFkGIYa/DVRMbGuAhJUbb9c+c3QAdIE8/ycaGMM
         aXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790593757; x=1791198557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AhEmqCbusXo+nqRRJWT3aL6p0OXcgNvckJxMKD5ctqM=;
        b=DKHRhE5fYx5qQwqSVgj4nsmxASnhLl03tei/H6nJBnarlZJ7ihWI0mv8Uggv+ldYt3
         3s9Z/+iNyw8JAEVZ0WU+FUa3J4Bcxz+P4ZAY8kA9LbuomDkWOgT6qp2pv4hhkG2gqmVd
         a2Ll7IuOc+bAP8TUz6yDtFg3iVJWKG01DQiSvofOCjmM2N1VctRPKYVEM+tlAiMMrnjo
         Kh5ISzMWnUPG6EDQCLzEOHtBIHPjz7DDFMKsmKeC3HFgQvF27inag9oUGp/ZSQAFc9qp
         tTCuy/OpNs6O62wUBAfUaMCco6J+59X8MhgzhSj2n6c7MjI5ON6u4j3FW1NfDaJMcO0R
         Njrg==
X-Forwarded-Encrypted: i=1; AKwUvBwVQ2J1rWXsuff0n4y+izYyIZopFXg0QUM/gPn7LfzEiD3FAsrPsnYm5Dk+yZQucsHXm7LyLdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxLfy1/3QfTgYmdrtW4E+vkGiupVlU1BkoSzTmQ4rOcnDHc8FS
	C9X5+mgEJ9RUB31CsIzL5pDXk9oNwG/NQVIArs3RZrFu/6q7FROiPJ0V
X-Gm-Gg: AYBFou0P6/qZUK5n3kE+1E+kxOQ8cBMfYZBSXxnweEUHYrjxEVoApc4bOOOXWmWKzkS
	jhIycOaib9JpcUBGS/3ko7fDaCOzQ2SV3adAkqAGdrsSsHpupv3vyJBolqvo8orPCSf0F25zSn3
	/39FVx26SEse0znX3pXyti3KfE9QsJyqBSeapdQz8EGgUARujO2l508w56csng3QAB3NrAgK3+A
	AacX0IrDzb1iVyBsYxhTGvwoN8J/eQk5HioHHFgEPUYR1FicNYRV97PKuoloIvkpKZgE+Fvu3QE
	F7Jsmo++c749LH3aIv1dJIuFcY1IHUOsXNCCGNPelIdDczFzZPk05rJIpj8qYryFTSvBKOVt7KK
	BK1juzhzocAR5ObENxkT6CHuM28e818Se13bNh6LNH4IsmI90Mf2mvhB+EhfkNPx7Xcy720grZn
	r2CXvNErPVl8ro8ljear/TETdxq7lSENg8qKzm
X-Received: by 2002:a17:907:a2cd:b0:c2d:ca32:2160 with SMTP id a640c23a62f3a-c2dca323569mr320592466b.47.1790593756863;
        Mon, 28 Sep 2026 04:09:16 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7356d1csm458142866b.18.2026.09.28.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:09:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 28 Sep 2026 13:09:13 +0200
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
Message-ID: <arpK2bQrrUMvEvTP@milan>
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
 <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
 <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev>
 <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev>

On Thu, Sep 17, 2026 at 10:32:48AM +0800, Hao Ge wrote:
> Hi Suren、David、Lorenzo
> 
> On 2026/9/17 09:12, Hao Ge wrote:
> > Hi Suren
> > 
> > On 2026/9/17 03:07, Suren Baghdasaryan wrote:
> >> On Wed, Sep 16, 2026 at 9:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >>>
> >>> On Tue, Sep 15, 2026 at 11:00 PM Hao Ge <hao.ge@linux.dev> wrote:
> >>>>
> >>>> Hi Suren
> >>>>
> >>>> Thanks for you review.
> >>>>
> >>>> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> >>>>> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
> >>>>>>
> >>>>>> The reservation is already stored in the maple tree when
> >>>>>> vm_module_tags_populate() fails. A failed load never unloads the
> >>>>>> module, so nothing releases the entry. Release it and roll
> >>>>>> module_tags.size back. Without the rollback a concurrent load that
> >>>>>> already passed needs_section_mem() can reuse the freed gap, skip
> >>>>>> vm_module_tags_populate() and write to unmapped memory.
> >>>>>>
> >>>>>> vmap_pages_range() may have installed some PTEs before failing. A
> >>>>>> retry to populate the same range would BUG on them, so undo them,
> >>>>>> but only if vmap actually ran.
> >>>>>>
> >>>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> >>>>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
> >>>>>
> >>>>> If a patch fixes two other patches, it likely needs to be split so
> >>>>> that each part fixes one patch only. But read on please. I'm not sure
> >>>>> if one of the fixes is correct.
> >>>>>
> >>>>
> >>>> Kept them in one patch because they only make sense together.
> >>>>
> >>>> After a failed populate the reservation is released and the
> >>>> size rolled back, so the next load takes the same gap and calls
> >>>> vm_module_tags_populate() again, and that retry would trip over
> >>>> the PTEs the failed vmap left behind.
> >>>>
> >>>> Without the rollback a load that already passed needs_section_mem()
> >>>> just reuses the gap, skips populate and writes to unmapped memory.
> >>>> So splitting them leaves each half broken.
> >>>
> >>> Yeah, that's why I think vmap_pages_range() cleanup should be a
> >>> completely separate patch with vmap_pages_range() doing cleanup
> >>> itself.
> >>>
> > 
> > I think I get where you're coming from now.
> > Thanks for taking the time to explain.
> > 
> >>>>
> >>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >>>>>> ---
> >>>>>>  mm/alloc_tag.c | 10 ++++++++++
> >>>>>>  1 file changed, 10 insertions(+)
> >>>>>>
> >>>>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >>>>>> index 2070e682fe10..95ddf5b743d0 100644
> >>>>>> --- a/mm/alloc_tag.c
> >>>>>> +++ b/mm/alloc_tag.c
> >>>>>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> >>>>>>                                      next_page, PAGE_SHIFT) < 0) {
> >>>>>>                         release_pages_arg arg = { .pages = next_page };
> >>>>>>
> >>>>>> +                       /*
> >>>>>> +                        * vmap_pages_range() only runs once all pages were
> >>>>>> +                        * allocated, and it may have installed some mappings
> >>>>>> +                        * before failing. Undo them.
> >>>>>
> >>>>> If vmap_pages_range() failed to map the range, why should we need to
> >>>>> undo it? If it indeed leaves some partial mapping when failing then I
> >>>>> would argue that vmap_pages_range() should be undoing these partial
> >>>>> mappings itself before returning the error.
> >>>>>
> >>>> Yeah it does - none of the paths under vmap_pages_range() undo themselves on error.
> >>>
> >>> Hmm. I wonder if this behavior is intentional or requires a fix. The
> >>> only possible reason I can think of is performance but I can't imagine
> >>> a failure to map is a performance-critical case.
> >>>
> >>> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
> >>
> >> Huh, my gmail thinks you are still at your previous companies :)
> >>
> > 
> > I manually fixed it on the mailing list for this thread.
> > 
> >>> guys think? Shouldn't vmap_pages_range() undo its possible partial
> >>> mapping when it fails?
> >>>
> >>>
> >>>> pcpu_map_pages does perform cleanup on its own as well. There may be other similar sites.
> >>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> >>>> so I did the same here.
> >>>>
> >>>> If we really want vmap_pages_range() to handle this cleanup internally, I believe that would
> >>>> be a relatively large change, and we would need to consider many more cases. So I think we keep
> >>>> the current behaviour for now.
> >>>
> >>> Yeah, I understand it would require a deeper cut but if that's the
> >>> right way to handle this we might as well do that. Let's see what MM
> >>> folks think.
> >>>
> > 
> > Sounds good to me. Let's wait and hear what the MM folks say.
> > 
> 
> I just looked into the call sites for __vmap_pages_range.
> And I found there's a bug in one vmalloc caller [1].
> When gfp_mask has __GFP_NOFAIL, the code keeps retrying
> __vmap_pages_range. If there are leftover PTE mappings,
> this can trigger a BUG(); [2]
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L3946 [1]
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L121  [2]
> 
Indeed the below code is incomplete:

<snip>
	/*
	 * page tables allocations ignore external gfp mask, enforce it
	 * by the scope API
	 */
	flags = memalloc_apply_gfp_scope(gfp_mask);
	do {
		ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
				page_shift, nested_gfp);
		if (nofail && (ret < 0))
			schedule_timeout_uninterruptible(1);
	} while (nofail && (ret < 0));
	memalloc_restore_scope(flags);
<snip>

and it should be fixed. As the __vmap_pages_range() can actually fail
and leave some installed mappings, we have to perform some cleanups
on failure or on repeat(if nofail is true).

Below code:

+			/*
+			 * vmap_pages_range() only runs once all pages were
+			 * allocated, and it may have installed some mappings
+			 * before failing. Undo them.
+			 */
+			if (nr == more_pages)
+				vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));

we can use but we need to check if partially mapped space is not an
issue for the vunmap_range(). And it looks like it is not.

<snip>
@@ -3953,8 +3990,15 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
        do {
                ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
                                page_shift, nested_gfp);
-               if (nofail && (ret < 0))
-                       schedule_timeout_uninterruptible(1);
+               if (ret < 0) {
+                       /*
+                        * __vmap_pages_range() may have installed some mappings
+                        * before failing. Undo them before returning or retrying.
+                        */
+                       vunmap_range(addr, addr + size);
+                       if (nofail)
+                               schedule_timeout_uninterruptible(1);
+               }
        } while (nofail && (ret < 0));
        memalloc_restore_scope(flags);
<snip>

--
Uladzislau Rezki
