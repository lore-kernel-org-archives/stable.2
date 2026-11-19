Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071997;
	b=IqgD2eq20ho1A5W490mwhGlXKf418tuPVsCJKbbrS3KI0IB3p+v25cad0HppDzapDso8
	 FyjAzvaD3ZcFIJgdQY5v6F0llXzc3BGvKgSCubOj5OhyaeHXGLMYAyzT/eAisa6OylUMC
	 QjkDcko4KQuJQ+gw0wfXRQ6381H174+9EC2kyziVi6eFQsgNub9GFhnAnaffehfXnXpHj
	 XbA2Fzz5eAXnADDr6PAdqT8ZFLvfTbbxZ5WJLKJIccYfidFApg7bJx2Ua9oCgKb6BovGo
	 0yuCQqr6JQGCTaouymn7+S5owr8mLyp7fa4lCAgLY3qvbVJm5V1YOaOtf2UZ/SILDoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071997;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=roEfV9nY1STcRzCu+/cxIrjvr9SwHPE6ZUbDalowc6w=;
	b=xJZwYdBV1wHWl8uQ0FEDS9Q64nIT3szE+gDHW0iVFBBrdNMtD5jSyuDUG/TxC3YMJo6f
	 IIxxZ3pSgaHRRkeILak2i7ksulvnezlo+vKhE+Y61YDNzjeojvdxFohANl69zoh+qWrXe
	 lRgc9oe8XaFRTeQQH6w6Yr9MS9V7jEQwC5ZKNj1pFYpduHvp17h88VsMVTRIEEy35iKVJ
	 5+8ms00bVulfdP80Ii6mOZqoVB3XP9UJ7B4gqE7RRLesUb73b98mP/kFt2SvaceSVYgEN
	 rpK1ewybzm5DgJoVLsNVR7geC1mhdA7smeY850XgHlD3zDT2xBV8NYyBFd82eo/AKlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OAjUxK8X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE60606A320;
	Thu, 19 Nov 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=OAjUxK8X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDBE1F000C4;
	Thu, 19 Nov 2026 07:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795071997;
	bh=roEfV9nY1STcRzCu+/cxIrjvr9SwHPE6ZUbDalowc6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OAjUxK8X+5SbFM85ImCRyQabs+kyB4NucK13vPznRyvkhsQEJ0+Ll4GgCm+vVJ/Sz
	 kllNKyZVh6573ApXTytCRJRAlFzfWBvb0iELX0gwmeIZVhxEkztv9BLsqji6dfeca3
	 195WOF7oM0Tmi+zYi9lOloiQvTuLb/jqRoagQEwc=
Date: Wed, 18 Nov 2026 23:06:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, Zi Yan
 <ziy@nvidia.com>, Kaitao Cheng <kaitao.cheng@linux.dev>, Mike Rapoport
 <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>, Yu Zhao
 <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mm/hugetlb: clear the hugetlb flag before
 leaking a hwpoisoned folio
Message-Id: <20261118230636.493784ad9653075ab69f2252@linux-foundation.org>
In-Reply-To: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
References: <20261103-hugetlb-hwpoison-leak-v2-0-98085750c145@columbia.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Nov 2026 16:00:48 -0500 Mani Tofigh <mt4022@columbia.edu> wrote:

> If memory_failure() can't save the raw error page of a hugetlb folio,
> the folio is marked raw_hwp_unreliable and leaked once it's freed.  With
> hugetlb_free_vmemmap=on it's leaked while it's still a hugetlb folio,
> and dissolving it then loops forever, e.g., when offlining its memory
> block.  Patch 2 leaks it only after the hugetlb flag is cleared, as
> without vmemmap optimization.
> 
> Miaohe pointed out that unpoison_memory() then doesn't see a hugetlb
> folio anymore and unpoisons it.  That already happens without vmemmap
> optimization, so patch 1 fixes it on its own and goes first.
> 
> Patch 2 lets a raw_hwp_unreliable folio reach the add_hugetlb_folio()
> rollback when restoring its vmemmap fails, as
> dissolve_free_hugetlb_folio() already does.  It relies on Kaitao's
> "mm/hugetlb: preserve persistent flags when returning folios to the
> pool" [1] (in mm-new) to keep the flag there.

Problem.  [1] doesn't have cc:stable whereas your patches do.  So we're
sending -stable people something which won't work.

I don't know if there's a way of expressing such a dependency for the
-stable machinery but fortunately [1] is still in development mode (ie,
in mm-unstable), so I can add a cc:stable to that along with an
explanatory note.

And I agree that these two patches are -stable material, especially
[2/2].  Having an offlining attempt lock up until reboot is not our
preferred user experience ;)

