Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795251717;
	b=xQnJa8w0YVs5w81JAzuebsQqqH1vRi9QUU7iftW6LFmMkHmp9WiLwvL2jCbgcTSdefwr
	 vr/xwjHXJMRqfoWsjhnOmubEBkJEGdRA3or1JHlDOW4fVCNul2ZE0J4J8xtaTzLUo8oa0
	 GtgJxvfKZ6KPz5alfa76BGZP4fmOa4Z7zgFlUDfMx/aIRMUMnIoMbf8jVnRaBwFoS6CX6
	 X4FYM8/Ak3FdFvzbIV947O0bjl3Jq8k2UdIaWYt69qeJUotT4iYNDp7j5kqJReOFwf3MM
	 pXU/npYLkFSSKXkvZLW4VOv3ALFRGVNsAabo6z//MuTJ8Vn6c4K0NbbXoc6T91z8SPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795251717;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LfWgHm+yVJwo0h5E+Nq+uWV/+0H6oyPCS8OFYHRQwIY=;
	b=T0UbTtkBQKH2cerF7qUWJ9snzC0AFDKZdJ3QBKr7juxmYWOLYvi8w4IjXuhJhbiLW3vB
	 OUY1lBPz8Wk8Z7wQWVP9/9l4zt9Bb+xHz3ZuiX7vbkg2GPxFO5FAYVjay8M4HKHkIXXYS
	 sPkKi8L0+Ty+eaNLZ5AKKg1eLh1xukDjsuZDv/+Dxi9SXRa+/yXIy5zwltoJjqgsmFSp6
	 5Q82V1WGcGnSIDRazDbUvaoS+fVPBjMecPNWAa4pzEwXJpSHaQoV3UfwMj3tfqUrdH21H
	 TB1UP0x6vSy+PytD2t39dnY593BKTpaK6W/+MXYqV+eqcpla6LvMVTURl4lbP5zn4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C6606A325;
	Sat, 21 Nov 2026 09:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED3C6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09535081|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0555111-0.00252878-0.94196;FP=2149251770222117977|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k74fNZl_1795251702;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k74fNZl_1795251702 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 17:01:44 +0800
Message-ID: <ead55973-6234-45c7-848d-fe2f53839f73@open-hieco.net>
Date: Sat, 21 Nov 2026 17:01:42 +0800
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
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@linux.intel.com,
 david.laight.linux@gmail.com, dengqiming@hygon.cn, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, puwen@hygon.cn,
 stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org, yangzhen@hygon.cn
References: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
 <89a5aef2-ea88-43d7-adcc-3f6b7374932f@citrix.com>
 <46d14366-dd1f-45f4-abc3-4d9dd8c32e7b@intel.com>
 <991d9608-fb44-4bcf-8ee8-b0a398899217@open-hieco.net>
 <20261121071442.GDawFE4rWdzLeaqjoH@fat_crate.local>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20261121071442.GDawFE4rWdzLeaqjoH@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/21/2026 3:14 PM, Borislav Petkov wrote:
> On Sat, Nov 21, 2026 at 02:46:31PM +0800, Tina Zhang wrote:
>> I'll extend the existing erratum_1386_microcode[] table with the Hygon
>> entries and make Hygon reuse fix_erratum_1386() instead of duplicating the
>> workaround in hygon.c.
> 
> Sorry that I couldn't jump in here earlier. Those folks are all giving you
> confusing ideas, don't listen to them... :)
> 
> You simply need to copy the amd.c code and adjust it with your numbers.
> 
> The reason why we're copying and not sharing code with AMD is because AMD
> cannot test on Hygon and thus risk breaking Hygon or you vice versa.
> 
> So we have it all separate, that's why there's a cpu/hygon.c.
> 
> Once it all settles and once we absolutely cannot live with the mini code
> duplication this causes, then we can start unifying.
> 
> But that time hasn't come yet. For now we will do all separate.
> 
> Thanks and sorry again that I couldn't jump in in time.
> 

Thanks for clarifying, Boris, and no worries.

I'll keep the implementation and microcode data self-contained in
hygon.c, as you suggested.

Andrew's pointer to the existing AMD workaround was still very helpful.
I'll follow the same established pattern for Hygon, but keep the actual 
implementation separate from AMD.

Dave's suggestion to describe the affected processors with x86_cpu_id
tables also makes the model and stepping selection much cleaner. I'll
retain that data-driven organization in the Hygon-specific
implementation instead of using explicit family/model checks and a 
switch statement.

The next version will therefore keep the workaround entirely in hygon.c, 
while following the AMD implementation pattern and using the CPU ID 
tables for the Hygon-specific processor and microcode data.

Thanks everyone for the review and guidance.

Tina

