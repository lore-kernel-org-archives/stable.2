Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110A4749DA
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279533; cv=none; b=pGlTgiV/shPPsihVsxP9pAynONIrDA8UTrJjuHs6jmfBiZDt0ylgdKynZNBQu8z9TMIi57mGUVJcFbBp3WOSkXLBX0Chc5Z6eihHjVMy3/3R4wvRJp7l/ZmTdORGI+nLXGpiyFWhScAeptBtHpRUmv0j0Ob3ygD5LcCQ9oSEYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279533; c=relaxed/simple;
	bh=tvEN2Zqehq6zh1C/JhkoibEquw0IV4KRiQPkUi/+3NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAM0cv1REnxS+S4yQNwAjYrrurMuvrV0aNPnlKB3wwzjX5t9mZZKIN+Tm67WzBLNVW+Iczr3wab8ijObKZ2Tb/gbiD923DyhGhxKLFkla7xm27VVtqSrClgU04gEeHHdGGhnrGYWowoxu2HOqUCU0epLp7b35AXn0IrOYaBG6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jexfo+BW; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jexfo+BW"
Message-ID: <edf7b946-ca71-4c3f-b942-5e80454d47fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785279528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5kRRgr/F2MwecPOOitA16JGwiQaRD0ZU98t2FYzRIM=;
	b=Jexfo+BWM7EV6X//Q6imKMdLF8qPyed9F7ZIPsq2j6DvrC2ovEP4E+pMz9fGTu1WZF8ZKf
	w6NAUH6Zr5WtqECbngsgKDaHH7Er3iGM5CiPOg+Snuu/D9O0HCDk4gywXCFRgwcL3zdq5W
	petLDlqvHEWeFM6fO4b4okYAXgleb10=
Date: Wed, 29 Jul 2026 06:58:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "selftests: net: test PPPoE packets in gro.sh" has been
 added to the 7.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>
References: <20260728182402.314002-1-sashal@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260728182402.314002-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 7/29/2026 2:24 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      selftests: net: test PPPoE packets in gro.sh
> 
> to the 7.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       selftests-net-test-pppoe-packets-in-gro.sh.patch
> and it can be found in the queue-7.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit f9d9bd13a591537a14c39d0221818180960fc0a3
> Author: Qingfang Deng <qingfang.deng@linux.dev>
> Date:   Wed May 13 09:33:49 2026 +0800
> 
>      selftests: net: test PPPoE packets in gro.sh
>      
>      [ Upstream commit 6160ec9d03d7af5aa345b8b994de80fa8454274b ]
>      
>      Add PPPoE test-cases to the GRO selftest. Only run a subset of
>      common_tests to avoid changing the hardcoded L3 offsets everywhere.
>      Add a new "pppoe_sid" test case to verify that packets with different
>      PPPoE session IDs are correctly identified as separate flows and not
>      coalesced.
>      
>      Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>      Link: https://patch.msgid.link/20260513013400.7467-2-qingfang.deng@linux.dev
>      Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>      Stable-dep-of: c25dd7439f84 ("selftests: drv-net: add missing kconfig for psp.py")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>

Add: Matthieu

PPPoE GRO is not supported by kernel version 7.1, so this test will 
always fail. Please instead rebase the dep commit.

Best regards,

Qingfang

