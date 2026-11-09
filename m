Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221848;
	b=erOdhUVhRMVCYreee0r+jlqDH2GbeksVnrB0MzAVrWXPHMfPa6tjPHBQ5t64edi5ea09
	 DP4yL3lr9pdSabtsYwFbwMEXdmSQEIY1eXtqXePlpovJ+KF+jrqcb6BsAQNWgRPb8hwmx
	 NyAbTOVviIiJuOfNIO+7wSmznuje6Eyq04ZtyYDFtdg4xitkiFeLctVfDpdRPoYeiEUPC
	 p5nLAQ8MtBJTR0YVX6KnTxUYpnEJeVnqzCoEAcjGOhW2U7GHU7Cz3oQFP1oGHiE/okREX
	 d8JrrA4N/WSM3+DmQPnefizUJUYO6su6R4UB/ZutcSjEiTQB8Zn995B+wJCjxgEY/9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221848;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z9c1zFsWXDHo689mQwpOhi6Fn3DBrnj+Q9G41hJhu+E=;
	b=iuI1O2+fHzpqZv+MJ5oyoPkmtW2BJrhZ63/7UFh2OCtDiS7QZi8BXyTJwXu0PiDgLffy
	 6+qgmdbj1OBkcwcYJxppPXMWWr57BCLAhiZPlivYCILNUYDJtod1QWhWsVNx5mWAf2zHG
	 Q/TGaJGY0TKX5nxJaOiaUbPIIXROIWuYDEVIwBBSdx0/JE6f7UZyzxWIsuoF/NZ8NV0+k
	 RIDYV0wbiEYOQwNQAMPKEBXqa++k4NzFsXzw5LW50imic9iEc3FM2Gu9aM88CJw/WLn3r
	 pLFx6ACT+Gjvt8WWsPyHfAm7UZ0wXYNUhm65X78pwTfucCwMVaHWUMr5BN9O4hcOU3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Tera4tdh;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1570606A322;
	Mon,  9 Nov 2026 10:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1570606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Tera4tdh
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E48D81576;
	Mon,  9 Nov 2026 02:57:23 -0800 (PST)
Received: from [10.2.213.24] (unknown [10.2.213.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5D3F3F632;
	Mon,  9 Nov 2026 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794221846; bh=Z9c1zFsWXDHo689mQwpOhi6Fn3DBrnj+Q9G41hJhu+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tera4tdhCJ9uhUnrCN+O/Y3S9ujYF/Brro2cvC/AyUHVJJlATHBn7msiUYxjnFMqN
	 BiiCudGO471/42SyaiaC7pCz0Cq3tOeVe0mfnmYgyv+913It9DxXWGkYjk80YuzxWV
	 wY+/Va4fZbToqzB5GjMpjr9WoSXO6RjSwH9FFYQc=
Message-ID: <4f143547-0e12-4dd5-9a20-32ad27642834@arm.com>
Date: Mon, 9 Nov 2026 10:57:08 +0000
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
Subject: Re: [PATCH v2 1/2] arm64: sdei: Run the event handler on the kernel
 vectors
To: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Usama Arif <usama.arif@linux.dev>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Doug Anderson <dianders@chromium.org>, Breno Leitao <leitao@debian.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Linus Walleij
 <linusw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-2-kirill@shutemov.name>
 <1bae50ad-a65e-4ccb-b247-8d9544e4c5ee@arm.com> <au4eDdjGkb9tn_T_@arm.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <au4eDdjGkb9tn_T_@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Catalin,

On 06/11/2026 18:35, Catalin Marinas wrote:
> Hi Ada,
>
> On Fri, Nov 06, 2026 at 04:14:56PM +0000, Ada Couprie Diaz wrote:
>> What are your thoughts ?
>> I understand that this is a completely different approach, but I feel it
>> would be more in line with what we already do for other entry paths.
> I agree moving this closer to the normal entry path makes sense and the
> PMR handling probably belongs there as well. However, I think there are
> implications for VHE (the handler runs at EL2 with VBAR_EL2) and for an
> event that interrupts a KVM world switch on the hyp vectors. I need to
> dig some more into this.
Ah, I was unsure about KVM, but that makes sense...
> In the meantime, I queued Kiryl's two patches, they're small enough for
> stable. Any entry.S rework can come on top of them for future kernels.

That sounds good, given handling KVM properly otherwise would
require more digging. I would be happy to have a look at such a rework
at some point ; I will bring it up with Mark R.

> Thanks.
Thanks,
Ada
