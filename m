Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986740;
	b=xxxohD7h+Zn2eZFmaqw/IezEqo8c4VOSU4DSZevOFbpi2kNyzQdNG3o7jA2+b8IOpxZ8
	 nUM0HrODGw283zb7ZxhW6X5KDOrUoTKzPqCICqRITf8dTG4ErLzK4qhxnvIBRPjl2Jsr2
	 Ey/x9V7XDmXKhMgh/If4QCtc/UUmfMWBhNskSdEHf/s5GJH+xEw3ogvjQMwglhiGH/KMm
	 I6iPVyODt+0/YWRiDLmIN4VTTrJwLWc0qydHbi3+iCFvXJ1aGcCXczrkUJrZZGjEqccfO
	 x1dmrMIg59mTjq+xo7SHK/6b4jrU51tw0ueILKbAcWGExgOVd8inholZoxiTPUS1kow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986740;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=V/Ki9KYCk1/u/T9+TLPXVuBQHKR32la5lHVotRJ9M9s=;
	b=DQxwYnlVWHY4ocTPsCDQ97qlRIGclI36XpECKlpJBV1WetjqYxXY9Hth7GwDLULGFzgJ
	 nzw2PbTXL9dwB2g6vFN3h005AivU5bNJL6PKZXRV1g+zoltki1zSeEv5vaMRbL8z5gaoy
	 c0vza1P012Ku0w+zW3aip282HISw6pbVSMjyM+fN6xv4Xb9QowCVfePMXC1KuYK7KHPfV
	 nLjrakZhPC/X70G75UmM81MJ6FlX126XFvoDLRYHKvQ9rJ3MUwFPqlc/HJrKnWpp7htdd
	 3B5MtZoUu8PDjEivmmfSsWOFWj/naOPW5uH24jhWSO/6qOf3/xgJlKdzhZbf4BAa1iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b46Iw0Is;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF4606EE86;
	Fri,  6 Nov 2026 17:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BF4606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b46Iw0Is
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C51153B;
	Fri,  6 Nov 2026 09:38:55 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E311E3F632;
	Fri,  6 Nov 2026 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793986738; bh=Au11w2LcZqWcY7AEya/LgeSWkZUdT+Gf4txaRTnYGZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b46Iw0Iszy98SNd2Ysmjz5/eWk+qZHyrwWByFkmfYCpUNGC07OVTzMcnxF6B1tl5u
	 dZTZWdyX3pVaWzbzKvqFf9udxyzvhmX7DaqTMaxgvh4Yv2OTOSjVj8jg7gV6rC2rGe
	 vY5mjfipkuqKnqSBvbDhhZiwbQO82z5CZBo8whm8=
Date: Fri, 6 Nov 2026 17:38:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
Message-ID: <au4QrUV_l6QDeArN@arm.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-2-kirill@shutemov.name>
 <auzM-l40BLsT3clg@arm.com>
 <au2-GegBg8kRmBs0@thinkstation>
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
In-Reply-To: <au2-GegBg8kRmBs0@thinkstation>

On Fri, Nov 06, 2026 at 11:48:00AM +0000, Kiryl Shutsemau wrote:
> On Thu, Nov 05, 2026 at 06:37:46PM +0000, Catalin Marinas wrote:
> > Worth a separate patch to fix SDEI handling with pseudo-NMI on and no
> > changes to __this_cpu_read() above needed. So, for this patch:
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks!
> 
> Would it still make sense to switch to raw_cpu_read() in this patch for
> stable@? The splat is new with this patch, so without it stable trees
> would also need the PMR fix.
> 
> Let me know if you want a re-spin with raw_cpu_read().

No need to respin, I can fix it locally.

-- 
Catalin
