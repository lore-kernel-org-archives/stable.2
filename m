Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775946;
	b=1IH04IdyyzcowDt5FGk92QNrc2xVvwzbpEa32Y+IEMXDeNlR67wt9UUGv04zsFXiQNBm
	 Vvk7y+YmyaJVpIKvCO7jRMSP/ADHB4d11bt61YmxAUrS9UFJsLQoZG/gxD/cvbGGPTe68
	 8vamc8cD1LGF/LvJHrht63/i8+knrwmIW5peLKV9GGjdU+HBbMebzttf1q6lx7mtYWmNl
	 J79gn7H60S39/H60La+rq4RZFDTSDCcsriHc9MzGsinkS3hitOJk+1Qos7M7Ad6tcDxjf
	 srS1Bzm1aEkpHk23UWwUEVlceVt/ETGe/uDq2TXbCOhXjR7AXXSY8IeGbTVLcn5A1Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775946;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sGoHO6+WZv1Y3Mj64Fxg0aYsbXLZSCm2JTjxec2U8qc=;
	b=IbxNkdQIrmLXPha8bYzmnkBEzu3+YyAJEWbUjLiJ+e9QHMkUpXa9JOeL+Fx2Rkcbbhag
	 tCnc/sA1mDR7mAlEKdrVxmvX1417GqnIpgkCtFfRSgQ9qroEnNhC1dr/ZvMNplDIk2Izl
	 nTLPQkUWMsq7dyjpv2U21Lls7jTN9YlVNQmduvApWT7ioWEGq2qnWCBrsOTKySU6Au1jI
	 ZDFox+U4rSPIMM0mFW1RBp07ZFCp5n461Ka+Y5qmBPMbMQBqqbPrH0/9mVc3ptebtQuso
	 z0LJ6STYiUeHPt9CRLP70tHdTjUZTdHNpJ1Ayn5BI3QaMBFAAxvTt8tPADMPeTMsJMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ODuL6UlK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8D4606A31A;
	Fri, 23 Oct 2026 17:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ODuL6UlK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883851C00;
	Fri, 23 Oct 2026 10:19:00 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7433F7B4;
	Fri, 23 Oct 2026 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792775943; bh=v55FvSs1OHKfdpQ+oZdfmiL9/hYV5Vq1FpbIIBPd7SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODuL6UlKlfJlubv67QVAqeKqStyI1X7SUkxBl27uqz3xXOkzVkNYi4LyGza47vSsK
	 kWfemk5Uunb3534NHzk8x5S8Iw6zoIZtPKmkUqAg8ZhD6VWOmbNPV1/dHt/ozHk8LJ
	 ziGm7spesywrh2U7JlcVPY4vbGZ9Wh/RjCzfJbgg=
Date: Fri, 23 Oct 2026 18:18:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] futex: Canonicalize arm64 tagged user addresses
Message-ID: <atuXA9WPEnwG0PCh@arm.com>
References: <20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org>
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
In-Reply-To: <20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org>

On Thu, Oct 22, 2026 at 07:06:02PM -0700, Shubhang Kaushik (Ampere) wrote:
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
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

The patch is fairly generic but I guess at the moment it only affects
arm64 (on x86, access_ok() on tagged pointers still fails).

Thomas, do you have any preference for this patch? Happy for it to go
via tip.

Thanks.

-- 
Catalin
