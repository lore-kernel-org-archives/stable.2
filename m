Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183993;
	b=n42EQfYzKVGDmQ+vppHBZ4/n0QIwokMIOAWMdwWsOo23hbIeDoP6sOMWI/uPce7xRA33
	 0IZ3QzkdMoR5NmkPAdYzSltzV3Xcg4C+BvHysMEGPiEtVs7lHCas2HIDdZ5GOas8rcaxe
	 f3nK1qKF0f/FH2qyUfQNg+CCNHQ9x3Mo2+6QgYZPY3zcR9HJ2JxSGJQ/33lzThUnCHnTV
	 KX1sjTd3R00iUJJ1UgmQ4sTF4kdFJvOvZTKRbVs6DmwAopRogpyc/g+8TXd4q5KPQ0p31
	 mLpgyGQ5xyXJAWGdL9QEzWHjD9eSozDb3bLo0n4ok6+6DN9bCGCHFcmSg4hvGAxNihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183993;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0+2EB7LVvgKGU9HWTDek0XJMc28YgT61nFtRwir+t3c=;
	b=nJUY8KikQMNwkj03D6qEj2Jqeu8HmlZlcYIAEjpyk+BlViaQDDmCrMVh6vrjBFLrPTgk
	 Cf7ibjzOGGRQ6ko9GYSE9whBOjzOq9vOH8wautGTAgSYTKxlCbRstEbMLk1qgrXGfHXH7
	 Cmi3V2mSr5cgzhDAjvOBA2nlN1f0BTMS5ycIAU/crxJy8mesTcWG5jbBeSiQcnwaLroJf
	 /laLlSgFdh5izoSxSUjfWgjmXELvSNppKRwo1Pzep0BsqfNo7w6yZrGPlQjkqTVHVmU3D
	 +uIL23Hys1fgevztVfBknZYdCM54INDZNGx4jrUPG7jTpobHcLil7jIMo9mT1Up9rfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.123
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FE606A320;
	Fri, 20 Nov 2026 14:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007FE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2816518|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0276593-0.000439439-0.971901;FP=2843223356043142399|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.k6aLmJH_1795183979;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k6aLmJH_1795183979 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 22:13:00 +0800
Message-ID: <22eb33f3-a6f7-43b6-837b-74c8f5a3428b@open-hieco.net>
Date: Fri, 20 Nov 2026 22:12:59 +0800
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
To: David Laight <david.laight.linux@gmail.com>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, yangzhen@hygon.cn, dengqiming@hygon.cn,
 stable@vger.kernel.org
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
 <20261120094627.513b216e@pumpkin>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20261120094627.513b216e@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,


On 11/20/2026 5:46 PM, David Laight wrote:
> On Thu, 29 Oct 2026 07:57:12 +0800
> Tina Zhang<zhang_wei@open-hieco.net> wrote:
> 
>> The XSAVES malfunction described in AMD Erratum 1386 also affects
>> certain Hygon Family 18h processors. Under specific conditions, XSAVES
>> may fail to save XMM register state, allowing stale register values to
>> reappear after the state is restored.
>>
>> None of the affected processors enumerate supervisor XSAVE state
>> components. XSAVEC is therefore equivalent for their enabled state
>> components and is not affected by the erratum.
> Would it just make sense to use XSAVES unless there are bits set in XSS
> MSR that the kernel might need to request be saved?

Did you mean that the kernel could prefer XSAVEC when no supervisor 
XSAVE state needs to be saved, rather than clearing X86_FEATURE_XSAVES 
on the affected processors?

That sounds reasonable in principle, although IIUC it would require 
changes to the current xstate instruction selection logic.

Thanks,
Tina

