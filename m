Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432968;
	b=VQ0rZV9Z/3Y1iE65jINNc8jeuxk9490wUn0s6R2v8THPilvGs7sXfLBpFtHq6oRUJAU8
	 mWfYqVawY+ruki1ibfrqMBZqGdyCHkll35FZdmDhUZ6CarizFSDPd+h2oc+5aMzHiG1R1
	 tzOrEOXyrBn8RlH1Cai/L8vLIZKlwp/Imh/SGtV7nVWozH8A+MJtykKhFBAJWdlY4L295
	 uw6zFPcmFR/h2pbYdCDqbCm7Cemi/JP46WrniCS9fRUX2k+LUuSKsJR5aAPrJ8lmxhzfI
	 S3B4je82zOT9Sge5hAq0Y50t3xU6IQNkiGZCGyGd0M+mHHmd79Ko452j6VJbNWjejiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432968;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=n0IwwoqFU6FYET1+Z3QIMppXO+y0FM/vbWz+JBZFbWE=;
	b=2CcDVDcaQqxrWHlUvtaIwKRQPx1togbVqJz9N5SEoUGbiiAtfNod4+y20HPFLcawPo4x
	 6zJe5pl3Gyi06RvsAoZJLU8UTxs031eNCmvGDGtCivrzQoq0Y+JDjuudDdig3ZR+bi/N4
	 PEnI4UuUdx6kgj1ZGScG5OMxx3fdaLL13rSywto3ZskDboDeOlFzLyjnEudo16m2gPNhe
	 0aaMqlZim9WUwWZlLTB0ZN+UIUDOTGw7YdEw3oyGrUWtFMeHTouZosDHJEMJirf3zdxXi
	 Ay/ceJnNF+d5Sak77L21Mwp1G77P3oluhL6f5hSSZMIolqjY/OdeUaiumTOEU9ltMag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=At6vpgGK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E63606A31E;
	Mon, 23 Nov 2026 11:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=At6vpgGK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC704143D;
	Mon, 23 Nov 2026 03:22:44 -0800 (PST)
Received: from [10.2.213.11] (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10F1F3F882;
	Mon, 23 Nov 2026 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795432967; bh=spxzXW2OAk5CItHqRFUtJkcdrfpendqQ9BF7EJiu/T8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=At6vpgGKMWCyKi6xz7wozWpbTAsICd/JDM8ODxxn+EqAGfINNHT17Fqbj5fYXLnTT
	 BdX/ekTVgY+90zs0uA1XokMynVI0RjL5yRVvbmM3224BaFbCCr9oREppwaSp5wDch2
	 Y7WIJkB0J/gnDA1KBm4UBigSviIq2Mw66oqQJzHo=
Message-ID: <fcd485e2-8d43-4eeb-b686-012f352ce736@arm.com>
Date: Mon, 23 Nov 2026 11:22:38 +0000
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
Subject: Re: [PATCH 1/3] arm64: entry: sdei: always set VBAR_EL1 on SDEI entry
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <maz@kernel.org>,
 Breno Leitao <leitao@debian.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Huth <thuth@redhat.com>,
 Dawei Li <dawei.li@linux.dev>, mrigendrachaubey
 <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-2-ada.coupriediaz@arm.com>
 <av8p2WL4R2tlU1HX@shutemov.name>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <av8p2WL4R2tlU1HX@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kiryl,

On 19/11/2026 16:57, Kiryl Shutsemau (Meta) wrote:
> On Tue, Nov 17, 2026 at 05:48:12PM +0000, Ada Couprie Diaz wrote:
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index beb56891fc4f..cb122163a68d 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -1079,19 +1079,22 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>>   	far = read_sysreg(far_el1);
>> [...]
>> +	 * Switch to the kernel vectors unconditionally and restore
>> +	 * the interrupted VBAR_EL1 before returning.
>>   	 */
>>   	vbar = read_sysreg(vbar_el1);
>> -	if (arm64_kernel_unmapped_at_el0() &&
>> -	    vbar == (unsigned long)raw_cpu_read(this_cpu_vector)) {
>> -		write_sysreg((unsigned long)vectors, vbar_el1);
>> -		isb();
>> -	}
>> +	write_sysreg((unsigned long)vectors, vbar_el1);
>> +	isb();
> This makes the comment I added in do_sdei_event() wrong: it still says
> that an exception taken during a KVM world switch goes to the hyp
> vectors and hyp-panics. Could you drop it in this patch?
Ah absolutely, I missed it, thanks !

Will send a v3 with all the little fixes.

Kind regards,
Ada

