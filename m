Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9A4E1C7E;
	Mon, 12 Oct 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835260; cv=none; b=d9OzbUxnM/b7pGVk0kLQmvuEje75enMgp1phPso4HRNzgffMKcBdoMNqgZsUabyufMqZtBKV+iiRcz9qobQUB3C6TJeIuWWVSJWOss8y4/zVvWGyxxAU8aKpAhIxHexj/DIUORwkqb3g6bar9vehQX3/DfdlVnGQQoPi6egEgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835260; c=relaxed/simple;
	bh=K11kw6sxAxVo7MdG1IcddqCM6rMQ01SADHyb+upAIqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPP5PB5YSTlo7RPkZCMj88WlJasv4qDg92+e458ok2s0ueFdvmbD63BOefKtAg7leAcx/Hw3NPLGpezXOiYiuwKH4T8KJl5nDdFsaE5mHn3MpEAe414/RdvfqAaFZcFz8EJNEOoXArOIB3g4th0SgQzpCa5S+nmIFA/0q/5Ohog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7uSih0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7uSih0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA81F0089B;
	Mon, 12 Oct 2026 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791835257;
	bh=K11kw6sxAxVo7MdG1IcddqCM6rMQ01SADHyb+upAIqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a7uSih0+PNDDade+F/+WyATs5BK/TSjcW4FQOY9UK/vuZ4NWQUmtB5ehgD5Ij3KVK
	 XC0zI/Nl5bpFeJCPGMGoqUirRerSskjkP/EfgY3ps+M10bN+PipSe76x0rq0Iam+r4
	 rNQIvEJWrYGwNKzO8Sd0A7Tjdj7l8Doi6feY9mUosNQvPuBuowq2jI9TqhlBkPXHgS
	 I4CLH6Z/2AnTa2JmVFh3Mnu2rOVgr1ekKFquDJDv1XSc3n5NmDXn0BhhBxtL1lSZjh
	 xUlfam7H6AoHLtDouxCOOQgTuszzhohzz/Qb8JVJOP4uvp8qOCVTttOZ+Zt0eoegie
	 xTA7ai32Y2rTw==
Date: Mon, 12 Oct 2026 21:00:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Message-ID: <as08NnPG1AF2cG1Z@gremlin>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
 <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>
 <CAAbz3fTZyeDL1Sy5FOxuJ8e0zgM5SJa1UKa7sk2apkaJFeeBaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAbz3fTZyeDL1Sy5FOxuJ8e0zgM5SJa1UKa7sk2apkaJFeeBaA@mail.gmail.com>

On Mon, Oct 12, 2026 at 02:25:38PM -0400, Samarth Narang wrote:
> Thanks both for your review into this; I was building a structural detector
> tool over page-table bit paths, and came across this.
> I got agents to reproduce it on x86 where we mark a 2MiB anon THP
> MADV_FREE, race a store from a second CPU against MADV_COLD, then force
> reclaim with MADV_PAGEOUT. The race pass loses stores while the control
> pass does not.
>
> Based on your suggestion, can we clear the accessed bit in place with
> pmdp_test_and_clear_young(), as the PTE path does via
> ptep_test_and_clear_young(), instead of rebuilding the entry from
> pmdb_invalidate()'s return value. I tried this patch on the bug, and the
> fix holds. Let me know what you think.

As I already told you, this is being handled by a member of the core team,
thanks.

--
Cheers, Lorenzo
