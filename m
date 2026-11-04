Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778199;
	b=VYsdnluGeoUfv/Sm08/VjmAso9EixEWRa50/fGXRgjLOopHiKcFAWkpA/D9iikvMGuwr
	 LbK9lb8axhH1Sz6Ajy/HRgMBZEhkLTT3mt0RL9qjvlTry3QI7oRuhFJ6bXMkfK4YIUgRK
	 C2TKktvF6r/9YIsg/ibM6I//VWw7D+wmcBHLWkXCXFmiuic6bqdNRndEDjO/S6Z9HJUMR
	 +ONGlTIOtOTLvRXEFACOWKCT/mP0awyRan+HWSuBBP1Mr70L6IKdZetNUPXdA8fy3fzYc
	 y4IS1IadzDGQvFIcIdzvFFGVqlqfM2Pz6mHupXBhU5jxUYfXBuwSebmvgneQn4ePBtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778199;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5hKduYDZmO0ZyDw+yuFcDnroE1QUbUuaD9pBPMc9eNA=;
	b=ChwGEX4ks6dIfVsXZwfEp4K+l6BWB4AJMckKQHIWUCT3a58s9CzwwV0PBXqQ4tNXV7sk
	 3K0CcJIkM28e44T5UIhH83lb6+C5zkVtggKKtIvKK+qGObuS1SItOlQj1ZLoeuH0EnjyA
	 8n7VpSNA15LiqlVRIGp5qaD3lWB3dIte+ioOx40vgahA4iV7ENWbzxF+L/sOs1t3/bPns
	 TrarJRKHBWdZHG3uNdyu6dRUW6YM263aEFaNfdmZHwF2rb3WKPFRi07Gz0KQsku5538dE
	 /aSGKQln22Rc1L5MtwKPClFpW2ITWH7pBSRfumfwjW0QvKLOrnNpDX0YhHgmDmqKxmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gufJ0ed+;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F81606A31B;
	Wed,  4 Nov 2026 07:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gufJ0ed+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793778195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5hKduYDZmO0ZyDw+yuFcDnroE1QUbUuaD9pBPMc9eNA=;
	b=gufJ0ed+6izILNwH+wOjcNVDEBEenS+oR4oCOjInVkz6mmEG1umJElBQMXXLaomIEkG11dCWMteoSqZX4sjochw42lggftJUgmnsiz8023K7w3h6wYfHRkeYiaMfqPcoaGA6a2a1mZPs4a8oDcvfjRcHhoHbJNp+nkiiy4FYsr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XE56Yqe_1793778193;
Received: from 30.221.129.178(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE56Yqe_1793778193 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 15:43:14 +0800
Message-ID: <f6f848f6-9fc5-4847-95f9-77efc215a61c@linux.alibaba.com>
Date: Wed, 4 Nov 2026 15:43:13 +0800
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
Subject: Re: [PATCH] ocfs2: validate xattr bucket count against extent size
To: Jiale Yao <yaojiale02@163.com>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261028050229.124718-1-yaojiale02@163.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261028050229.124718-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 1:02 PM, Jiale Yao wrote:
> The first xattr bucket stores the number of valid buckets in its extent.
> Lookup and iteration trust this on-disk value even when it exceeds the
> number of buckets covered by the extent record. A corrupted value can
> therefore make them read blocks beyond the extent.
> 
> Validate the count against the extent cluster count before using it.
> Reject zero as well because every xattr extent contains at least its first
> bucket.
> 

Please describe the user effect of this issue.

Thanks,
Joseph
