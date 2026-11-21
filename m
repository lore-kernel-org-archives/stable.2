Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795243600;
	b=DJrIxjFoQP8fIDW9toeKZmnrI9yu+0FGyr33cHaCNpmYJKFmvlrA5tBj2d10lGXJj1Yj
	 fNQjtpTqdHExo0aN+bG8FTl2XtIEFWvc+xVgdF6Y8IgVMOXSpqFHkrf6iJOFxKUPHxacs
	 D4ZQO7v0ia2NH/XFf6QE8ja+Q8XMeBrQd2rQVWnP1vN5qJNw5GrVCWenidiyKMtMTLHao
	 ibJ+8pN6vIvc2CUxcTdt3V95cNfPIrcC+VIDuv/5czdk9580Dgbx1d5mFDMrqwMGjJCSH
	 0VqXWhnaRUQ9rSMJDNp+ShwuE+XUnv+I3an5EDhFairqT0hNlYq18nqaGrhEilmN11g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243600;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Phti2orQm6ETEd6254mx75ZAUQhUCNBLuFsfh3Mq9LY=;
	b=2Tg/iQ7Tco2D/SLcRkpiOvKtrDw/EOiHeugpkFH6Bt5JpKn8tZ6um0G00aPoz4Xn73e1
	 KK54FA/+z6sPb8fxbZGpXZmJeDC/zHbgm3TclDxO4IIItgFdQC13DccCS4BO1ZPDfhWXe
	 QsFz7OgC0B/LkVoUEPuF1P7B2iYRUxzdDYCfHRp8uyZAfm9880aEb6Ny/TQL07WW2fVU1
	 2bfDrlDtIveA+fjEmWc05OU/EHABjiWo6dXAT+n2DKY6/g01kWaYfQTY8p3rkr8MR0TjS
	 sd5guO7wTf+Wf47rx24lFsrVWAxCpVboCHZxBC4czbZSl9BswDwjrCivh8P3F7WJSFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=open-hieco.net;
	spf=pass smtp.mailfrom=open-hieco.net;
	arc=none smtp.remote-ip=115.124.28.146
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B9606A332;
	Sat, 21 Nov 2026 06:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16B9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3954308|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.127277-0.000772149-0.87195;FP=849964566244551515|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032112;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k7.42Nz_1795243591;
Received: from 192.168.1.4(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.k7.42Nz_1795243591 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 14:46:32 +0800
Message-ID: <991d9608-fb44-4bcf-8ee8-b0a398899217@open-hieco.net>
Date: Sat, 21 Nov 2026 14:46:31 +0800
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
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, david.laight.linux@gmail.com,
 dengqiming@hygon.cn, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, puwen@hygon.cn, stable@vger.kernel.org,
 tglx@linutronix.de, x86@kernel.org, yangzhen@hygon.cn
References: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
 <89a5aef2-ea88-43d7-adcc-3f6b7374932f@citrix.com>
 <46d14366-dd1f-45f4-abc3-4d9dd8c32e7b@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <46d14366-dd1f-45f4-abc3-4d9dd8c32e7b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/20/2026 11:54 PM, Dave Hansen wrote:
> On 11/20/26 07:29, Andrew Cooper wrote:
>>> Third, even if we could move to XSAVEC, I'm not sure it buys us much. I
>>> certainly don't want to add the complexity to our already horrid XSAVE
>>> mess. The right fix is in the microcode. Let's not give our dear
>>> hardware vendors to mitigate even fewer issues than they do already.
>> Linux already has a mitigation for #1386.  The mitigation *is* to
>> pretend that XSAVES doesn't exist, which causes Linux to fall back to
>> using XSAVEC.
>>
>> See fix_erratum_1386() in amd.c.
>>
>> Hygon should extend the microcode list and call that function, rather
>> than opencoding it differently.
> 
> Hah, silly me. Sounds good to me.

Thanks Andrew and Dave.

I'll extend the existing erratum_1386_microcode[] table with the Hygon 
entries and make Hygon reuse fix_erratum_1386() instead of duplicating 
the workaround in hygon.c.

Thanks,
Tina.
