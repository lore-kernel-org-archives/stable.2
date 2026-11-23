Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433269;
	b=4DzS9Be2m41MKINAWVPwdEyEcQAPvP5J8LkRNtT2qGE9FxA6CDHcHwd1jQxtg/Tng17y
	 E8TCHPAAemS2iQCAF3S9Xl4mRgCJ/TURphx5PZn2CLvoP6bc97G3km/odzULcXSZX96AM
	 q0AosCOylH3Uldphmbg9Y3f+129CXo2DBpOKTmspr4BCha84f6kkXALqKxGDm+Mdi04qg
	 JTGt54QdvV4nvQj6zdUVxRf91HiB+uaRJ9j4KCJ2SlFscwV0UezuD2E5i8B/vouXUwayx
	 IAA5vDcA8GKwM/56o3deCs0P8q5m0xZGgPx7SAP0AsRcgQ/NoiI9ZRhvcoBdK7ge48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433269;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ssgL7DxzXbUZ7tJgWltGij1VtPlNzWyPW+YycDs+SSQ=;
	b=2F5HbKFkbJ0kG9Q3cczpE41F1EJewK1O1/YkGsj5c28OkZI9xkf3KTvtPCMCjVSJug6U
	 CM1FKy/4pt6rUHIFOYakwgWbY7h03zpksZsDUIPvd5GDuC33844T/jDN69/+wqcp0O3Qy
	 cxohKmqnBuRm3pzZeMFIksFSbtvs+Jq22rl5MG6jonlvv7FP8c9UPOtFrWAUarpFQ0KWQ
	 CI4Thf90Tc7lC2ntGfl8Ftt0QcOLfeuAIUY651vpLbwYYd4g5R8Mekb/pshcn5jgh0WR4
	 Hju7zvNcQLE1OEWICWMKynkN+I8m4pAwQ72eBMZTCEe15VBJ9jzgNzT8kelSBcQsJyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BlDbpH9G;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1673606A31A;
	Mon, 23 Nov 2026 11:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1673606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BlDbpH9G
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45116143D;
	Mon, 23 Nov 2026 03:27:45 -0800 (PST)
Received: from [10.2.213.11] (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D7323F882;
	Mon, 23 Nov 2026 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795433268; bh=ssgL7DxzXbUZ7tJgWltGij1VtPlNzWyPW+YycDs+SSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlDbpH9GOBYSN/1fZzJq1X8wn0398nEuLJMN7Lftbd1i1Z+673bgMeFgBM73EZ+fD
	 TMCWiWL0SrE0T/ocQVq5iEnYFkaa7E9tkSksb8AWEWegoyBO6JmnO4ZNj+OyTh4ymr
	 R0cO5BUY8o0g9BEdQeTg7Xi2MY6QF7ixE36FCq/E=
Message-ID: <9b0461dd-0616-4c7e-9c03-6eca1e452a3d@arm.com>
Date: Mon, 23 Nov 2026 11:27:43 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: head: set __entry_task along with task setup
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Breno Leitao <leitao@debian.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Huth <thuth@redhat.com>,
 Dawei Li <dawei.li@linux.dev>, mrigendrachaubey
 <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-4-ada.coupriediaz@arm.com>
 <f232d0ff-3286-4d85-b9e3-cad8c6bc7178@arm.com>
 <2ce350f9-4dc4-480f-8a53-07ef9586d49b@arm.com>
 <av8sxUCg4m492Tx6@shutemov.name>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <av8sxUCg4m492Tx6@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kyril,

On 19/11/2026 17:09, Kiryl Shutsemau (Meta) wrote:
> On Wed, Nov 18, 2026 at 03:30:06PM +0000, Ada Couprie Diaz wrote:
>> However, as far as I can tell this is not the case for secondaries :
>> their first task on boot is set to the idle task, which they go to
>> without switching until (and unless) something gets scheduled on the core.
>> This would be the same path taken for CPU hotplug.
> Secondaries brought up at boot have run their cpuhp thread before SDEI
> probes: smp_init() comes before the initcalls. A CPU that was online
> before still has its idle task in __entry_task. So only a CPU onlined
> for the first time after SDEI probed can see NULL there.
That makes sense, thanks for clarifying.
So there is a very small window, only on first booting secondaries,
where we could see this issue, but it does exist.

Kind regards,
Ada

