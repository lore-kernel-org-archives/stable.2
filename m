Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990164;
	b=WIJW2KnSPTzm4zR1Zow05ADFyG1B7fEu8gt4E30I2rACOX7yqAwfaORH8S5dS7iy+HZf
	 EjKw3dlYbd8UkGK2GWaOPBai7A5CNt+Ebq1J5Th2cOTCsTqix7fk8Sy6yiUI8avl0EJJy
	 fN4TIh4bECqvyge2R9PRGDig+b2eMh9uJzIrtY9ojf/rHu1GzIjQ16DRdvRO9JCDAj4cm
	 hJyECIgIhVN95awy9pKXSNv6uxLupMZOWp0YAHfYCZ5Rx51mPTo0bzUoAJax16nANrZ8a
	 dLPAYTogXxGHpjL4XCMgBV49I86uUSpQDi/Qvx8wx6ZafbbOaPX30nIy35QiltrMyng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990164;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BrgRaYrX/RlgPy+GPq7MQFpr0fqcLrZ1d+Pm22+zM0Q=;
	b=n3YOC8hNbaqB+ulC6qZbxHYgTz/l4cOCX5hInHwLdzl2/tK2XlO/G+YoYAcy2gJyYIra
	 /dyjHWXrGAmH6xH8qJc5FGHC8sgMrdY6RC0pNt8BFVbFCpmW4tjxBu6wm9IQmlPM/1vIT
	 OeomD0yNaMhMiw09+EtdomFrh8Netk6r0eRkK8aQscrkBnnw24PJEusMebN6tqyZ07lOj
	 zRnvdgH/1/hZdL1lgUA6WQc6fODbBPbDNGq5sHclB3E4clHdQWnWwEvjo5xKVFYM6Y00Y
	 MCVFi7jomxJkS6ZbO/UzB9iAjvpcIfbHhp2iEy+6XRtDNkVgZPqlEpY92CLRzTRkjtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pos13iHp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED9606A326;
	Fri,  6 Nov 2026 18:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4ED9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pos13iHp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6B61650;
	Fri,  6 Nov 2026 10:36:00 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844AD3F673;
	Fri,  6 Nov 2026 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793990163; bh=HS/iYnoDJ5zOgunxlgOe0o75m1+F+bzNPDULmR3Cnzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pos13iHpBNz7BxF+JBDu4325Y4XtfDsV4xAB0j5rLon6hdQdlL4eu0bskzBnwJmDA
	 7JQmN+KOApzEGWM4baaaNxLbgYrQDVrlwnaz4dHp+jKbp+wrat/DdLnLF2b93kX15A
	 ekZ0tvNkYEFiYyzuGM5WQHy68DprNLYmEKG3y/M4=
Date: Fri, 6 Nov 2026 18:35:57 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Usama Arif <usama.arif@linux.dev>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Breno Leitao <leitao@debian.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
Message-ID: <au4eDdjGkb9tn_T_@arm.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-2-kirill@shutemov.name>
 <1bae50ad-a65e-4ccb-b247-8d9544e4c5ee@arm.com>
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
In-Reply-To: <1bae50ad-a65e-4ccb-b247-8d9544e4c5ee@arm.com>

Hi Ada,

On Fri, Nov 06, 2026 at 04:14:56PM +0000, Ada Couprie Diaz wrote:
> What are your thoughts ?
> I understand that this is a completely different approach, but I feel it
> would be more in line with what we already do for other entry paths.

I agree moving this closer to the normal entry path makes sense and the
PMR handling probably belongs there as well. However, I think there are
implications for VHE (the handler runs at EL2 with VBAR_EL2) and for an
event that interrupts a KVM world switch on the hyp vectors. I need to
dig some more into this.

In the meantime, I queued Kiryl's two patches, they're small enough for
stable. Any entry.S rework can come on top of them for future kernels.

Thanks.

-- 
Catalin
