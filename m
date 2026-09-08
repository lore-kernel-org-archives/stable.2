Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432455294D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880073; cv=none; b=aZdw+0deN6Slua/61cqfY4KxX7SF61mFNTFw2sSr7hLzNYo4rAG/XVgdItvjBenj56hs7iFmguZ6Vs4GkqXgBpEFf1+aRqTzMdixJe/hEZ/BY6uxlGe1gZz4dvWvcQqVt3fB91TFL7VY37I3XhNfnqrT5zOwiDB2FMXV4zmxIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880073; c=relaxed/simple;
	bh=F61H69mF3VruYwfQfBXakM+FEgay4xnK235Alpe4aoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+PI4lcihL+vfsb6/O+g/btACoekPhiZGIBTB2FdKCZCAYKNPS8bDgAEp6Vw1k8Q3vqSZyPfgn5Btua6BPvZ306A1R6fAR9FaVRdTAXaBUo2ylz1TIL+XZ5pdXw6vgvBcgAgZw5UNaPUwv4p4oRQsB5/Js/DsywJIQHFPFcItM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QoWVPHf3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QoWVPHf3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523681476;
	Tue,  8 Sep 2026 08:07:41 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8CB3F7B4;
	Tue,  8 Sep 2026 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788880065; bh=F61H69mF3VruYwfQfBXakM+FEgay4xnK235Alpe4aoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoWVPHf3TavwxFTtgnVEyELJjRbP3NinnNCLDdKrB4tTPfhhSaiI9Dv5m+cuqbs5c
	 6A4UZVT4jCFT5UoqOYgw5HqhFx+QATcMzDM7TeYSbbVUYO0rTxiCgImQ7mpKT44N0p
	 OSWoWaZXcddyG//soN84UEUHOWhs9eahQeJsU8Os=
Date: Tue, 8 Sep 2026 16:07:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
	james.morse@arm.com, maz@kernel.org, peterz@infradead.org,
	ruanjinjie@huawei.com, stable@vger.kernel.org, usama.anjum@arm.com,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [PATCH v3 16/21] arm64: percpu: Implement preemptible void RMW
 ops
Message-ID: <aqAkvK6zylxwq5J2@J2N7QTR9R3>
References: <20260904161758.376504-1-mark.rutland@arm.com>
 <20260904161758.376504-17-mark.rutland@arm.com>
 <20260905100319.0a50c17f@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905100319.0a50c17f@pumpkin>

On Sat, Sep 05, 2026 at 10:03:19AM +0100, David Laight wrote:
> On Fri,  4 Sep 2026 17:17:53 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Use the PCPU GPR infrastructure to implement all of the RMW ops which do
> > not return a value.
> ...
> >  #define __PERCPU_OP_CASE(w, sfx, name, sz, op_llsc, op_lse)		\
> 
> Isn't this definition exactly the same as __PERCPU_RET_OP_CASE() except
> for s/tmp/ret/ and the 'return ret'?

Not exactly the same; the __PERCPU_RET_OP_CASE() assembly also performs
an additional instruction at the end in order to generate the RETURN
value.

> Since the compiler will just ignore the unwanted return value
> there is not point replicating the definition.

We could consider sharing the assembly, but it's not quite that simple,
so I'm going to leave this as-is for now.

Mark.
