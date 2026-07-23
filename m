Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CE1925BC;
	Thu, 23 Jul 2026 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816290; cv=none; b=bA+78drZEz+bdN5LczLln3QfOGgoe6blqQAtdAdHYczF9JrrrvnoJqzme1/eAHtT96Ajf0Fq35Uz93X5x8VH5sqhkU902rKBNiUA7+jVY4I7cbH+Ttnec8oW0tCRGDolNJIjLck2gH28+iLobXNVMBkUAb0UnU+YQOmupz7L/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816290; c=relaxed/simple;
	bh=SVeXGHDcMIPyIm+WxUXUEuyGtUszPvWD8ynLs8FvTHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nO22fOXC0tjGrtVCIhRmBwHeWVeC+Dr6a3j82Fwy7lRosYcMl9bmph/kPUnMNLbEkyKE06IZu7iVPu50ERcs81qPGu4uG4f0Yd85ndH5RS5lZBseYxRmbp4Rq2jh3FwcwHRzV+QXUrNy75CIb4KhbCqeU+6lwRWvgvvNImNZ7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0131F000E9;
	Thu, 23 Jul 2026 14:18:05 +0000 (UTC)
Message-ID: <00bb7fd0-998b-49f0-9941-cc4d796a8751@kernel.org>
Date: Thu, 23 Jul 2026 16:17:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
 <20260722162207.31a2c491ffaf36d1e8948c14@linux-foundation.org>
 <67e1219e-9d47-4a30-a8dd-fdcf03229f58@kernel.org>
 <amIgT-l7PExKVJlW@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <amIgT-l7PExKVJlW@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 16:08, Johannes Weiner wrote:
> On Thu, Jul 23, 2026 at 12:22:58PM +0200, Vlastimil Babka (SUSE) wrote:
>> + Greg and Sasha
>> 
>> On 7/23/26 01:22, Andrew Morton wrote:
>> > On Wed, 22 Jul 2026 10:56:47 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
>> > 
>> >> 
>> >> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
>> >> Cc: <stable@vger.kernel.org>
>> >> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> > 
>> > This cc:stable fix doesn't apply to current mainline because the
>> > preceding non-cc:stable patches get in the way.
>> > 
>> > This means that the -stable maintainers will have to ask you to redo
>> > the fix to make it backportable.  And you'll then be preparing a patch
>> > which hasn't had standalone testing in mainline.  All very cumbersome.
>> 
>> Or they backport the whole series, even if only 4/4 has a Fixes: tag.
>> 
>> > So is it practical to make the fix come first, as a cc:stable hotfix so
>> > we can upstream the other patches in the next merge window?
>> 
>> I think it can't come first, it's simply a complex fix that can't be done in
>> a single patch that would be reviewable. 3/4 is certainly a strict
>> dependency. I'm not sure if 2/4 as well. Perhaps 2/4 does deserve a Fixes:
>> tag and Cc: stable on its own, as it also fixes a defrag_mode deficiency.
> 
> Yes. Only 1/4 could be argued away.
> 
> 2/4 actually came after 4/4 during development. Without it, compaction
> cannot make sufficient forward progress on the promoted non-movable
> requests. So it is a hard functional requirement.

So that's the tricky part then. If it's a hard functional requirement for
4/4 and yet leaving it out results in no conflicts when applying 3/4 and 4/4
(as it indeed seems so, based on my local test), then it's quite possible
stable folks will figure out themselves they need 3/4 as a stable-dep-off:
4/4 but won't backport 2/4, unless you act quickly enough on their mails.

> Whether it deserves an independent Fixes: depends on how many
> GFP_KERNEL pageblock_order requests we have :-) I'm guessing not many.

I don't know how else to indicate it though. It's kind of a co-fix with 4/4?

>> > (An alternative would be to put cc:stable on all four patches.  That's
>> > a bit abusive but we do it rarely).
>> 
>> I don't think it's necessary, the stable team are quite capable of figuring
>> out the deps and backporting them with a Stable-dep-off: tag. IIRC the
>> "fake" tagging is discouraged? Maybe they can clarify.
> 
> Yes, I *think* it should work with tagging just 4/4.
> 
> It won't apply cleanly or build without 3/4. So I'd assume if that
> dependency is lost, the automated backport will bounce and I can send
> a backport series by hand.

The way I see if often happen is that Greg sends a mail that it bounced and
soon after Sasha replies with fixed up version/series. Which could very
easily be 3/4 + 4/4 without 2/4.
