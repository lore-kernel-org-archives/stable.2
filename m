Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876027;
	b=qHZJQ6rInju1DLcw9kyOQ8hVtyTVYwYxtkMqkbA5uUpEo1EXEPooud5RSVmURQxdGCLW
	 5vHHFNP3QWS0kzN84aq2zxRr81UQm8qR7x8tuscrjhAAwHI4Zly+cU0BJos/9Jr/Sa8O5
	 rLDAXg8uFr0J2Ja4qDuWRTob+LrYsl9L9P9CY6CiAoHcux00pyrHZPKu64QiYKcrABGYk
	 q3jOrBJp8TcLP2Qa2kbKYiu4eLcYqt/4HSni8+ja6+rB2AGJR66Y1ojs/m64BgL+D68TC
	 XmCqm4TWOdG+mjN2SA8yx3AFgqOjXm8ZQndpy1Zj2FovuDhkZIcXkARMy/qxna5J5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876027;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xXR60u8P/JzdVcE1JiWVcB2i68AunH9ExxgZ3/2aEs0=;
	b=PApdgSlxxuHfPV+dX48/xzseC1irzjVdHaqpAjP9lVWa78iEz7NengN/7hK6pPLSS+y4
	 45K/mwz5aEHVv4S7ZX9REF50COe6vxCQgLBCnq2oFhUWFjdhvSTIWhW4nkbeXho7RrxZj
	 PhlCTSk5q/HV++O0wSduYmYZsbx7i0kIwkHO4/UFQLoE8zDth69g7JbhFbNc6iS9n7K/K
	 rAfZwhwTPhVzkrdkHanF8ne0KNrL+ivbqfG/gBeGHhUIYDiIjXSFT+io6KZahACzWures
	 Gb5Q1HFCJzS6Zu0U/owjtYuZlFuVyEbRf2p9SIxQ6OFMSvmuU4tKVSBcXrEAdMEk+Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IOiyvv+V;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A55606A31B;
	Thu,  5 Nov 2026 10:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A55606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IOiyvv+V
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE2F1516;
	Thu,  5 Nov 2026 02:53:42 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A76103F673;
	Thu,  5 Nov 2026 02:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793876025; bh=KkBPEsNue1fKQaofoCh3LGcr31D++n/sVcyzCD79kGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOiyvv+VwnwkNBeglnvXW8PD3DxxS8OCvAWDO/fSx3kfzgqFdExu2S4/VOltTziDS
	 1MRx+WopdQ4wRgjQJbYP6a8SAAtMfKBr4N65RbXV2dgm5SEycwbtmhdpnY2IiMyT+E
	 CZwSgeW6BrA5nRSZUdmHZdiSScpU86JzRlbnx7Vg=
Date: Thu, 5 Nov 2026 10:53:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] futex: Canonicalize arm64 tagged user addresses
Message-ID: <auxgNACRQVqTuqd3@arm.com>
References: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org>

On Fri, Oct 30, 2026 at 03:39:59PM -0700, Shubhang Kaushik (Ampere) wrote:
> On arm64, a thread that enables the tagged address ABI can pass valid
> top-byte-tagged user pointers to futex syscalls. Such a pointer must
> have the same syscall behaviour as its untagged form.
> 
> get_futex_key() validates the user address with access_ok(), but uses
> the raw address when constructing private and shared-anonymous futex
> keys. A waiter using a tagged address and a waker using the untagged
> form can therefore access the same futex word while hashing to distinct
> keys, causing FUTEX_WAKE to miss the waiter.
> 
> Keep access_ok() on the original pointer so that arm64 retains its
> per-thread tagged-address ABI enforcement. Canonicalize the address
> afterwards, before it is used for futex key construction and shared
> mapping lookup.
> 
> Add an arm64 64-bit selftest for a tagged private waiter woken through
> the corresponding untagged address.
> 
> Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
> Cc: stable@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
> Changes in v2:
> - Add the generated tagged-address test binary to .gitignore.
> - Compile the arm64-specific test implementation only for arm64 64-bit
>   builds.
> - Avoid relying on /proc/<tid>/wchan to detect that the waiter has
>   queued; retry the untagged wake for a bounded interval instead.
> 
> Link to v1: https://lore.kernel.org/r/20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org
> ---
>  kernel/futex/core.c                                |  2 +
>  .../testing/selftests/futex/functional/.gitignore  |  1 +
>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>  .../selftests/futex/functional/futex_tagged_addr.c | 61 ++++++++++++++++++++++
>  tools/testing/selftests/futex/functional/run.sh    |  3 ++
>  5 files changed, 68 insertions(+)

Since this is a cc stable, I'd separate the actual fix from the
kselftest with the latter not cc'ed to stable.

Thanks.

-- 
Catalin
