Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245C3E9C17
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567074; cv=none; b=rd6/N4QJFBmCtyRWCJwF3cuVejKksLW5vT1r/J0fFce+STWgWejJstxxy6mqMyzOkcDx91QOId11HeMtvviQN42PclPpi7VhnZluqq/ywuntchXS74M9gS46ABoEO7d7cLWpeee4HiddpaG0xPX3BVMYE8VA47vIxWiDaIK1IHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567074; c=relaxed/simple;
	bh=k5W0zjS7CwXnvjPVXGCX/DoYC/ezZOX79HkT4Hgmv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNDQXzwGCMTYAgqDIrJGgRxB9OdkD6gR/zkHeNeUSTxlL/van9qCx/J1Sz0ymYD9/DWe73ZtxtcHvg9ZYxsT7BrChsyWNIgvG7vpKzSjE560nzgvvU+SY0Kf7zeVcc0zOtjNvrqnm6up9npOc92Y15ROWA7rbPzX6G7hcd0VxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mi55x4CB; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mi55x4CB"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0bso8657356d6.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789567067; x=1790171867; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NgUHPiwSi16km0SbObf2vOYCgqHRbxyVwtkEbeNTtkE=;
        b=Mi55x4CBpoqhvTMyVVz5iCrVRj/v9TPyIIjcaIg//Oj9tJgfjrnl/LM1kKOMfYJOSb
         Zoy6pY/D5XNuiJlatJxbEOLVKCP+r2rJeP/nEzI/UR76453FyqGBgejRADtvtRMMq/3I
         hxAQDIKTy9wjI/O0aGYwg1aC1Gk1FesWgj/nGT+4Q+T90Klx6AkYsEI1eEs9rRIzM8dC
         F2ilwcBDBwxxNoz7jwpWE+XCYRAE213GvrbNGPDHDFR6zcS1IgXhZBE3wUwhiQQt5naH
         WJ7qJ9+qFBW2QcJg8QWAfAQJWSLPlxLXaUVepjU1qDEvnk995ZKy+FMwH57fYh2t+YAq
         MYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789567067; x=1790171867;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NgUHPiwSi16km0SbObf2vOYCgqHRbxyVwtkEbeNTtkE=;
        b=IHgtyV9X2M4qmJJmTu7K8m3g9CMlqErOdGBTDdcplX/Ppe8s/UeOikXfEXONIiyK1g
         bE5UjW6AUOqvd8ebxGDo8xcuRZToN3hN1FW9tRxP5N97JEE77TAyYAwkzOLtUCAjb5U3
         JKKY3zqtQdjpdNhUYRYf322t6DWISAuSaIa1h3XBCzXssbqZLBt/1JEJouqx+QgBDqtz
         iDyn0Yi1DMqraz8FtXHfVc/CJVKHTW6CLKiaw7vm8I8cdLeWzyeKdAWO+EIDzKVSKdjx
         03Zm2UNv6ZDQuA1D2pWffKGGVWrbjHYWGU6wYOKzk0YLzPDBay2UDkT8zrLLyLuEuRNB
         Eodw==
X-Forwarded-Encrypted: i=1; AKwUvBzEom8RobnRHhY8mskn5xP4U71RsG3DatM+bjumXJIu5gJrpmPD7ZFwmFxij5PRAbhnOYIigrU=@vger.kernel.org
X-Gm-Message-State: AFuF++mojnNRoYKufPeCUgwhBSTAxsCJhSdn2/7jwb1NYGwcfT8+1SRj
	zG8E/j/IS/EsnGKvOoxx/OEuG2BXxjautvyBJ1lVN1yq+4KVPys1tp73aUAkOZUhBo8=
X-Gm-Gg: AYBFou1U6mOo6uRcRFtzwXwPv24/3KXnbFArB2yA3wjKHpqKIvvJKt2MpI11n3qjT6u
	rLaXgJJkqHNFA5scf1KL10vHt5x4/rECKmcFhvilR6yiZzTeAI7VCXkncRt1+ufYajpa7LfasfY
	pvmPLZZcj8BUQCWwh9KP2lJfCiThVfjOIgsmkuCLxOojTHxFs7Ib8iTZiVS36CXQl2BwlN9VqSY
	dgAxeoOdCzW31UAbSHil2+kuIOaX4ZZTvpkYUgLETIleInzombF8Uyr9exwTtA8L/CQ+8kx27qI
	8Ju6EGatUiwtswnYH13sgmluV7vroOKAXB7jWn3lZxDCgdrVTv4z+T4U5QNiMTZvXIyIku8O19b
	XWYfTa8BkhBa4f0hExVFPYuXfnENs0tLpZL4/T7nM7O73qNdFvDpnxygOGXTOlBw1jqLIuCBQZN
	7XanC3iDiYzbS6FkcuoJGekhPw5Q5UUXStl9CjESKbSwUEquNpkjQca+gx3xrBZKllHNt8SctQY
	5b2sMllyenogMp+YfqpcVgfmBxh5/nGjWqkFCmweTN2SkPddO7/dLY=
X-Received: by 2002:a05:6214:5902:b0:910:3452:d57f with SMTP id 6a1803df08f44-9123d7b5209mr61354706d6.31.1789567067054;
        Wed, 16 Sep 2026 06:57:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123beeec67sm26377736d6.48.2026.09.16.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:57:46 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:57:44 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqbB_nFAOGenDhy@gourry-fedora-PF4VCD3F>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
 <aqqTbGMJL86TzDrf@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqqTbGMJL86TzDrf@gremlin>

On Wed, Sep 16, 2026 at 02:03:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 15, 2026 at 01:12:03PM -0400, Gregory Price wrote:
> > On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Sat, Sep 12, 2026 at 07:08:32AM -0400, Gregory Price wrote:
> > > > MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> > > > them after the PTE walk.  The reschedule path drops the PTE lock and then
> > > > restarts the mapping with pte_offset_map_lock().
> > >
> > > Is this reschedule path even necessary? It's pretty bloody sketchy.
> > >
> > > I thought the modern approach (TM) was to not do cond_resched() and friends so
> > > can we actually look at removing this?
> > >
> >
> > Sorry - meant to reply to this.
> >
> > Honestly there's so much jammed into this function i can't give you a
> > straight answer. I can take a short detour to figure out if we can
> > rework this as a whole.
> 
> s/short detour/long journey through hell/ perhaps? :P ;)
> 

Not as much as you'd think.

I did it yesterday and left an agent to validate it overnight with
existing in-tree tests, LTP tests, and added some new tests.

The naming could use some work (cold_or_pageout -> lru_op, bleh),
but new call graph / pseudo-code:

• walk_page_range_vma()
  └── madvise_lru_op_pmd()              [PMD callback]
      │
      ├── PMD is a huge mapping
      │   └── madvise_lru_op_huge_pmd()
      │       ├── acquire PMD lock
      │       ├── madvise_lru_op_huge_pmd_locked()
      │       │   ├── process whole folio, or
      │       │   └── return locked+referenced split candidate
      │       ├── release PMD lock
      │       └── split folio / reclaim isolated folios
      │
      └── PMD points to a PTE table
          └── madvise_lru_op_ptes()
              ├── map PTE table and acquire PTL
              ├── madvise_lru_op_pte_range_locked()
              │   └── madvise_lru_op_pte_batch_locked()
              │       ├── process one folio/PTE batch, or
              │       └── return locked+referenced split candidate
              ├── leave lazy-MMU mode
              ├── unmap PTE table and release PTL
              ├── split candidate if necessary
              ├── reclaim isolated folios
              └── reschedule and restart from current address if necessary

Looks like a normal table walk now.  Significantly easier to review and
doesn't make my eyes vomit. (there's still an ifdef wart, but it's not
mid-function anymore... so that's nice).

Going to spend a little more time testing and tweaking before I post it.

I've been working on a making more extensive unit tests for certain
parts of mm/ and this might be a good time to look at whether I can
introduce a piece of it.

~Gregory
