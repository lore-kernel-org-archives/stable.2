Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075773C4B60;
	Fri, 25 Sep 2026 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311694; cv=none; b=j8E7sd9IdYakfh0QDmN688PXj9rF4GFx7EKfvgg6zD52eWFOGK7WHylfeWHmxjEv5EsttOjt+VAcHvYYjAhbE2nhvLjLzgMe/nwiI40QIs6FxWOVtrzFlnpR5KtQKHFEn/PI5dd8vI/vLjm7w6GnEx1+o4wUm67HQRmMjw3LxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311694; c=relaxed/simple;
	bh=bTF8N5VU6A0M5Bd+3CI/WxYoOH8Yw+XwOhBN1h0/Bpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sci5mVx82zOrx6FpzOmG/V+1HF+LTU3uFhV8Lt/4Lg/Z799eTLQG8w9qoQ4CAUPKWa8vHuAuAVjaLGASK0wNGWLNFuDxcgkw7w6eztB3iC+nuc3VQviuTJ5vP2orqdBECPn7bDuXuZvglK9kn5A4rtq2bSQNXDHwL9utdOE3I0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mBbJ0AG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mBbJ0AG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139BB1F000FF;
	Fri, 25 Sep 2026 04:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790311692;
	bh=EAbfPfUo1z2sF6AlMVME2ig0vFfsexu9oO7eGK/q4T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mBbJ0AG85Go83iWFJVKJrU87L9CaAbCtMGm6NjiNKpqM7xtTKxKZvef54DAST8hdY
	 +qge4H+e+pCaCp35Z1lQNebvY2P1qqK32vopKcRR0ex2koXo/Ox5iw650cODpaRjLs
	 Dx4kTv+n0Xgy11j7vQIgkcBlXm0McLH6kDK8NYwc=
Date: Thu, 24 Sep 2026 21:48:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: rppt@kernel.org, peterx@redhat.com, surenb@google.com,
 aarcange@redhat.com, david@kernel.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, mhocko@suse.com, shuah@kernel.org, kirill@shutemov.name,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-Id: <20260924214811.19ef8af417d37071ed8338c4@linux-foundation.org>
In-Reply-To: <20260925042907.2330519-2-donggeunyoo.kernel@gmail.com>
References: <20260925042907.2330519-1-donggeunyoo.kernel@gmail.com>
	<20260925042907.2330519-2-donggeunyoo.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 13:29:06 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> destination unchanged, so a uffd bit set on the source lands in a
> destination VMA that was never registered for write protection.  It
> can't be unset there, and THP collapse can't happen either, because a
> swap entry with the uffd bit set makes the scan bail.
> 
> I don't think it's intentional because for an unswapped page the bit
> doesn't come along, and I don't see why being swapped out should change
> that.
> 
> Clear the uffd bit on the moved swap entry unless the destination is
> RWP-registered.

Thanks, but...

When fixing a bug, please always fully describe the userspace-visible
effects of that bug.

> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: <stable@vger.kernel.org>

Especially when proposing a backport.

Please review the first half-page of
Documentation/process/stable-kernel-rules.rst

I don't mean "be reluctant to backport".  I mean "when proposing a
backport, explain *why*".

> Assisted-by: LLM

Great!  Please add a prompt to LLM's .md ensuring that future
changelogs always provide this information.  Please also share that
update with the rest of your organization.

