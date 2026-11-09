Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254745;
	b=m0flV/ovqpAmGROus+8mwctMhPY8g+ctALsS5GG8wOs5jtF1yLW1QJDYokU8ODJrmi6V
	 KQyYMAve/TUKJD5UQQVn7qlp4AdM4f7Yb9zYreBWx1GjXCwTQBKQs81e/++sOiwaYuXnF
	 KkZkj0cob9WOJBHZ5E6ufTKmzeEAmk7ohq4OqEfQ6Cpuh7/DkfeLy1FrrQfM8P0bMN6tR
	 xJj3FG/dJTWc1Z6tWQzK8B4xx+k+VYo6bYEFcWPJX86VZyrzUMnBeKrOrDzmCTV7ccHN5
	 Q80zTuV1RjRLBym2tMjDsJAXmqWnsQQ7MLBEXDjYCBSuMnumJ0YmUPGZq1kk+K6USIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254745;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=4vmyvjoTFDza/4rNuP8XGMaF0SoNMuAA7S3rSuXFKkk=;
	b=0ygct9s9R1frnrhglcNSQS+c94RB2Auq6gCmQ1JttiAKcUfw/soh74Y9p++uP1iYXVxe
	 zipq74TV211akUVBxP/1hI5kbLYkK/d/Iy1s/g6N1irTkBlu4NTysbTwu1LfZYcG7YacN
	 EE0yJx10LMJ7r3kvBr6ESypNrGOAtEmWwPcuMMedRvPXDZ5xbV8lRX+oBRo5KG1Gkiw/v
	 R6D62EwTiOGQh8lMsSMO6rQsubDeB8MTcVIz0xlRSgMNDkLcJqmxJhg8VZSK0VK0rokwj
	 idh7oY3oaDNZ/wbs8zCR+HNoZoT20rVqGvNSGeDc2nPtXKV1NxXQGkWDHC2rp0RAvbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=KICpPmxk;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E90606A333;
	Mon,  9 Nov 2026 20:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E90606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=KICpPmxk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4vmyvjoTFDza/4rNuP8XGMaF0SoNMuAA7S3rSuXFKkk=; b=KICpPmxkG/61LxMV32kPCdqImb
	XbrXB1Zgs8kJUpjKTAlyy6r4xeude2Y/DRcT4uIktaBry0ACw67WKfqldJ01DcOKmb0PT65VEr2dT
	khN900kgAgLfPJRVk1NmKS+DPsBenVH2ijsdWn8gU71BFYPQNzpbkuI8vAUue9kw7jUhC4z+IwEun
	4cotAhvwUXZqU8+Gf6NJ0ASwfyPKh2wRwdUEmbtd6JFY2uvsd1dcH6CW/rzpioN14MM8f3kzzuePj
	46TJOlpxgj8C+hsnlJY7kouN0tlHOdZJ25OV79qFNg64WSvpLmjmadYisdntTSrVTsrCNM2/5qLio
	DkDEBeOg==;
Received: from [::1] (port=46560 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xQVcc-0000000Chxv-24H3;
	Mon, 09 Nov 2026 21:05:42 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 21:05:40 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] evm: fix TOCTOU heap OOB in protected xattr reads
In-Reply-To: <98d6c26c-3dc4-4659-8284-a7ab0629bb40@huaweicloud.com>
References: <20261107230514.1108379-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <98d6c26c-3dc4-4659-8284-a7ab0629bb40@huaweicloud.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <10660aa25fd9d868a391a1c092fe8b33@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-09 10:07, Roberto Sassu wrote:
> On 11/8/2026 12:05 AM, Jérémy Jean wrote:
>> ima_eventinodexattrs_init_common() queries the total size of protected
>> xattrs, allocates that amount, and calls evm_read_protected_xattrs()
>> again to fill the buffer. This creates a TOCTOU window: if the
>> protected xattr changes between the two calls to
>> evm_read_protected_xattrs(), names and lengths are written without
>> checking whether the data still fits in the target buffer. This can
>> yield an OOB heap write that KASAN reports as:
>> 
>>    BUG: KASAN: slab-out-of-bounds in 
>> evm_read_protected_xattrs+0x15e/0x280
>>    Write of size 20 at addr ffff888002c59bcd by task init/62
>> 
>> Reject fields that no longer fit in the target buffer. For xattr
>> values, also check the length returned by the copy before accounting 
>> it.
>> This also handles the case where a size of 0 is treated as a length
>> query.
>> 
>> Fixes: 8314b6732ae4e ("ima: Define new template fields xattrnames, 
>> xattrlengths and xattrvalues")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>> Changes since v1 (after review from Sashiko):
>> - Handle the 0 case.
> 
> Hi Jeremy
> 
> I already sent a patch to the mailing list to fix the same problem (it 
> is similar to yours):
> 
> https://lore.kernel.org/linux-integrity/20261029142707.2602008-1-roberto.sassu@huaweicloud.com/
> 
> Thanks
> 
> Roberto

Hello Roberto,

Argh, I missed it when I prepared my fix, and even wasted time preparing 
a v2.
Thanks for the pointer though, good that this will get fixed.

Regards,
Jérémy
