Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C31F03DE;
	Wed, 29 Jul 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314226; cv=none; b=Lgm/p8dfJmD/kN0aCgQrPwMZkAGGlDXFojlS69TBKxvBYWn4L7gYi3qOp/Y+VjEauJGcTSuGlLeLY2pgRhsTSdHgZSAqPApX4k3UUi1iRy+FENnP+vOMnkJmELQxK2bCBVLDFDstmQ/ZJ89ORJojBd9JT78bxbgqzUCA7+gox9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314226; c=relaxed/simple;
	bh=8oGRyVUmPCo2r4gQWwRMua3RExdtijHjLN48TcXJRME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQowFLjx3XA/TEHrm6rHTmW/agvX+tK1yGhK7wIqdiPVFrxGT+MSpAdh/5iosPtvFD5IAHSJ3b8NQwdDQ+F0e+L0+vihk0nE9A0JCwP3CJf2skpJFBVBWUKJL6VuFOm2em7hTNJznRdAEAS+Fqm3896tK4k3k0gT8TEsxuZUW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVkSrRwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVkSrRwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3C61F00A3A;
	Wed, 29 Jul 2026 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314225;
	bh=PJkCMRBONvliAO18Qzs9kOOpOH/9cGVUppm3Hihn3b8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jVkSrRwJwp3UDNLB8f/m49LRPH3jp67TpaQp7p69ZDdRAiZ4ghyKRnyDbkyS84c0y
	 mU6VCTJYK/a/zIEG5WtuywYqfX+7hByTFpr7863CSmjWBlnf07c/g+z0owis1kEsKI
	 zJ025iC62ZxM980XQgikbguyUbpdoGhZ+V9E0CSFJYwitolQKSoCK7GtBM+fS2ORSV
	 5L9XSplkFz5HqffAei6Tl/QL3dxO4uEjaTAMTqGrsa/2v3Ld6r/xBfzHxuNADYnj4Z
	 ympaRmH8KEeuw4NIdZ0ukGQgR+HLdaH55YnVJirxT3zkqELJ0fXYQHtEVSzS/iZHjY
	 AMXb7GxbtwqQQ==
Message-ID: <8ed53530-ffe6-442f-b386-95b724c22995@kernel.org>
Date: Wed, 29 Jul 2026 10:36:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Patch "selftests: net: test PPPoE packets in gro.sh" has been
 added to the 7.1-stable tree
Content-Language: fr
To: Qingfang Deng <qingfang.deng@linux.dev>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <20260728182402.314002-1-sashal@kernel.org>
 <edf7b946-ca71-4c3f-b942-5e80454d47fe@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <edf7b946-ca71-4c3f-b942-5e80454d47fe@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 29/07/2026 00:58, Qingfang Deng wrote:
> Hi,
> 
> On 7/29/2026 2:24 AM, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>      selftests: net: test PPPoE packets in gro.sh
>>
>> to the 7.1-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
>> queue.git;a=summary
>>
>> The filename of the patch is:
>>       selftests-net-test-pppoe-packets-in-gro.sh.patch
>> and it can be found in the queue-7.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit f9d9bd13a591537a14c39d0221818180960fc0a3
>> Author: Qingfang Deng <qingfang.deng@linux.dev>
>> Date:   Wed May 13 09:33:49 2026 +0800
>>
>>      selftests: net: test PPPoE packets in gro.sh
>>           [ Upstream commit 6160ec9d03d7af5aa345b8b994de80fa8454274b ]
>>           Add PPPoE test-cases to the GRO selftest. Only run a subset of
>>      common_tests to avoid changing the hardcoded L3 offsets everywhere.
>>      Add a new "pppoe_sid" test case to verify that packets with
>> different
>>      PPPoE session IDs are correctly identified as separate flows and not
>>      coalesced.
>>           Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>>      Link: https://patch.msgid.link/20260513013400.7467-2-
>> qingfang.deng@linux.dev
>>      Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>      Stable-dep-of: c25dd7439f84 ("selftests: drv-net: add missing
>> kconfig for psp.py")
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Add: Matthieu
> 
> PPPoE GRO is not supported by kernel version 7.1, so this test will
> always fail. Please instead rebase the dep commit.

I guess without this patch, there is a conflict because these two lines
are not in the config file:

 CONFIG_PPP=y
 CONFIG_PPPOE=y

The conflict should be easy to solve, simply by adding ...

 CONFIG_NET_SCH_INGRESS=y

... after

 CONFIG_NET_SCH_FQ=m

Cheers,
Matt
