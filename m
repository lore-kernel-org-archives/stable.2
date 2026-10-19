Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46517381EAB
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393617; cv=none; b=fk7dlA/dHQ/bBhiTUQmz7FqPmMB056RzdbaPGjIsag8gZ7PSnDs34xckXaVIe3K4pooDvZYvHdhqWmhtZstp5OOWt52NjqO1my+4ylP3/1jDAUBw6erHv/Ot8OZU9cN2rWyQBzf3waGebxWjVrL/fIwu4LWcphUOqb4Ij0T8DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393617; c=relaxed/simple;
	bh=R8sRVKV2d+v3K80VHraXj2HaX+giPyb6UdNqMy7CE5Q=;
	h=In-Reply-To:References:Cc:Date:Content-Type:Subject:Mime-Version:
	 To:From:Message-Id; b=OqZYyKd2AhVgjyjFfXsHyeZTgWl6Mm9W1m7a9Ii/vDXWFI0eQhz1F46zAavSs3T2XDmSiJtjTo8nNlAfweMWGOdF+DR7wWYciSFR2PLvocqYSW+VBnyoZKTp6d6ZNT/uGnRquRKroBzK3jrWVT9Sxx9WQyrhS5Zm/A7qmjN08K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hXWIrbHh; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hXWIrbHh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792393610; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=96Wm4D57LuIgrDtXs3jtILL79TgZtcHA3nY+j4YAW3Q=;
 b=hXWIrbHh/zoTrGqhiFS5hJfKXv7MRtu9h/fgsAkvpSItQI1ZG3FHO+G9k83wsyWDD4qgki
 PVEpHMONKYA3jenAosXFCEvzbFEqVwqDPSWlw27Ku4IedpYrk/BWxL3jjfTXQkArNftX0r
 wslhnH5fkcuTMGu9tfm5OcnI9J01SIfF9tKV8DfHzJd6+yuvo7/TjFbe1OnHc/3DSyahu8
 yrDImSeKhxMyZhCaJi9Z7uN3VI9xHFiyl6Fd7lXsSiXkTiIwFs/xP8IfpXt5LAwp1YEa9h
 fp6l9kbTv6lZ795Io88mkKpGU949+GbPPfh/1OuG54DekUD3Dg4Mnd6Di6fYwA==
In-Reply-To: <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
User-Agent: Mozilla Thunderbird
References: <20261013093600.54995-1-zhaogongyi@bytedance.com> <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org>
Cc: <dev.jain@arm.com>, <baolin.wang@linux.alibaba.com>, 
	<lance.yang@linux.dev>, <mark.rutland@arm.com>, 
	<akpm@linux-foundation.org>, <ljs@kernel.org>, <liam@infradead.org>, 
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>, 
	<mhocko@suse.com>, <linux-arm-kernel@lists.infradead.org>, 
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Date: Mon, 19 Oct 2026 15:06:26 +0800
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ad5c188+14f43e+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "David Hildenbrand (Arm)" <david@kernel.org>, <catalin.marinas@arm.com>, 
	<will@kernel.org>, "Ryan Roberts" <Ryan.Roberts@arm.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Message-Id: <e0f60526-bb95-4d39-9a7a-72cdf32ca5b6@bytedance.com>

On 10/14/26 5:41 PM, David Hildenbrand (Arm) wrote:
> CCing Ryan:
> 
> https://lore.kernel.org/r/20261013093600.54995-1-zhaogongyi@bytedance.com
> 
> On 10/13/26 11:36, Zhao Gongyi wrote:
>> The transparent contpte layer treats PTE_CONT as software state: when a
>> PTE has PTE_CONT set, the contpte helpers may align the operation to a
>> CONT_PTE_SIZE block and operate on the whole block. That invariant only
>> makes sense for valid mappings. Explicit users such as hugetlb manage
>> their contiguous encodings separately.
>>
>> contpte_set_ptes() currently sets PTE_CONT from alignment alone. Batched
>> set_ptes() users can therefore install present-invalid PTEs with
>> PTE_CONT set, for example mprotect(PROT_NONE), NUMA hinting through
>> modify_prot_commit_ptes(), fork() copying a PROT_NONE large folio, or a
>> PMD split installing PAGE_NONE PTEs.
>>
>> This is not a hardware programming problem: invalid descriptors are not
>> translated, so the hardware ignores descriptor bits such as PTE_CONT. It
>> is a software-state problem. Some arm64 fast paths intentionally test
>> pte_cont() directly instead of pte_valid_cont(), for example commit
>> 9970a9a27ffc ("arm64: mm: implement the architecture-specific
>> test_and_clear_young_ptes()"). Fixing the producer side preserves these
>> fast paths and covers all consumers.
>>
>> In the observed failure, mprotect(PROT_NONE) installed a full
>> CONT_PTE_SIZE range of present-invalid PTEs with PTE_CONT set.
>> MADV_GUARD_INSTALL then zapped one PTE. The nr == 1 clear_full_ptes()
>> path only unfolds pte_valid_cont() entries, so the neighbouring
>> present-invalid entries kept PTE_CONT while the target entry became a
>> guard marker.
> 
> Hm, is there a good reason why we cannot just use the cont-pte bit for all
> *present* PTEs, even if HW would not be prepared to benefit (!pte_valid())?
> 
> I guess we really only have to make sure to shatter properly, right?
> 


Hi David,

Right, there is no architectural restriction preventing PTE_CONT from
being used as software grouping state for present-invalid PTEs. For this
particular failure, making contpte_try_unfold() recognize something like

         pte_present(pte) && pte_cont(pte)

would make clear_full_ptes(nr == 1) unfold the block before replacing one
entry with the guard marker.

My reason for preferring the producer-side fix is that the existing
transparent contpte helpers mostly use pte_valid_cont() as the membership
test, including contpte_try_unfold(), ptep_get[_lockless](),
pte_batch_hint() and contpte_is_consistent(), while some range fast paths
test pte_cont() directly.

If present-invalid PTEs are also considered members of a transparent
contpte block, I think we should audit the single-PTE modification paths,
rather than changing only this clear path. We would likely also need a
pte_present_cont() helper: the pte_present() guard matters because the
PTE_CONT bit position is part of the swap offset for non-present entries.

There is no hardware benefit while the descriptors are invalid, and
set_ptes() can recreate the contiguous encoding when an eligible range is
made valid again. For a stable fix, I therefore preferred to stop
contpte_set_ptes() from creating present-invalid transparent contpte
mappings, which also matches the pte_valid_cont() contract used by most
of the existing helpers.

I agree that saying this invariant "only makes sense" for valid mappings
is too strong. I will reword that to describe the current helper
contract instead.

If preserving the software grouping across PROT_NONE is the intended
semantics, I can rework this as a broader unfold-path audit instead.

Thanks,
Gongyi
