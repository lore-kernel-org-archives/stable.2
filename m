Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D62D595B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786326659; cv=none; b=D0zchAKPCX6BULv9R2LEa3tyiyVXHdLKSPo+GSAbYI7TjFkJwhHoyGgmvaWxlqQKO9bmVfD1n3m4/kgjy7Yjt0nQZftQTM6E/rKqDZNIbFYcBTPwtrnECS8DqOJ26e3ZxzowGC3150YhJ9W8dt3Q05+gFQW87xGslMg/KnMv5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786326659; c=relaxed/simple;
	bh=BfCQeWYA1xkTH9Tt5s2NJ9DYnKOIaeysk2TVzRIBel0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUmAo0KK+2uFgsS1Vr9BT8L+p4p7ApBNqHYgqd80OgEIUS0LKc4A1nKRDupce5c+MDOwXo/xRCkTJJVLNeNeqHojbNBgv7nZ4XWg10qu90UumoPxtSd4K18dUZGCuPl8OmOUdd+EyscKGIwjHyyhe0dOaRekHOU3/B2bPqYvpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozYQOl/c; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozYQOl/c"
Message-ID: <e70aca6d-2dc4-4b68-bd1f-c73e9631d870@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786326655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3hRPUeM2lF5GrxyCFRc3dRVrNLUuj7iyXDzukORHik=;
	b=ozYQOl/cELI1nyeMcA4FuAFrPbW2XI8AKj3YDxVBcL/8GFyzqQyL9ap7M4ff9SHrusKCvt
	Aa71sicWylrXVkP2RlfP6UUB0CqH+7awDbSTpuYlsDYMznuSGcdBBar2E1EZRobO9v1/3a
	vCOPskbBC/o9yltNyMFRZnc+20cpQeM=
Date: Mon, 10 Aug 2026 09:50:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "edumazet@google.com" <edumazet@google.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 aws-binance-tam <aws-binance-tam@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
 <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
 <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <0A7EC161-4EE6-42D4-A10B-7B4C609C7B32@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/26 11:42 AM, Ahmed, Aaron wrote:
> Hi,
>
> Following up since it's been a while. I've tested on 6.18.39 (latest
> 6.18.y LTS) and the issue is still present.
>
> Baseline (55,542 connections, one client SIGSTOP'd):
>    TCP: inuse 55542 orphan 0 tw 1 alloc 55543 mem 8236

You may be misreading "inuse", it counts sockets in the TCP hash tables, 
not all sockets on the host

Sockets can still exist in host even inuse is zero.


