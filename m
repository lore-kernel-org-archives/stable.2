Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6D409280
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662700; cv=none; b=NDGuZlXmuzf9RGbr1+5rvn7S7iKk68X+sAmCiOW/lPwW48vI+hSnJLcGLJXiz9YNETgEHVKXDJlG9haaPMMqrPweDBCvcpH8xEOkITBx8CXWP0JFthXiJwj3VrB9BngGBI1+fjwWAdg+Jtn5dQusSJi0NxvqgBAmTMJSXXkm61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662700; c=relaxed/simple;
	bh=62iKxTMo6T9JSr4mrj8GsqUDDBwG4+Zco1hcyISMAE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qy8KnzPGUsjz7dPeUAFxIsBoxN/t2WMkgh1ZbC43zmTciSrgSIOqwd9zJ71WXI612iovvo1+66hvVKgznl9w45NG48aISBHsMY+U486keJS3nCbn+t5Os4cU6hJWOkdIQV46AMYoupMwgCTioMDW2vmMocASGriZ1Ol4jXXhHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uqx4+YIK; arc=none smtp.client-ip=95.215.58.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uqx4+YIK"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=62iKxTMo6T9JSr4mrj8GsqUDDBwG4+Zco1hcyISMAE0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790662695; v=1; x=1791267495;
 b=Uqx4+YIK8/INqEtytxyTluVU3qF19Zz9wfyGLNZX41t6Oo1d/C9UyIwFrLRTrkwJoqodfLFF
 ehe78PlaHj2bhNG5lKXnOqxv9Rzt0PFizhJG3gYru1hd3FENkzADijF407rwt9NUvBZoNPhgoah
 hAdE5EUuTlE9mMtrn95PFI84=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e294858c3642f305;
	Tue, 29 Sep 2026 06:18:14 +0000
X-Mizu-Trace-ID: e294858c3642f305
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b0a6f1a-d44f-4e7d-9931-4106172d6258@linux.dev>
Date: Tue, 29 Sep 2026 14:18:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/7] net: tls: fix silent data drop under pipe
 back-pressure
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bpf@vger.kernel.org, john.fastabend@gmail.com, sd@queasysnail.net,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-2-kuba@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260429222944.2139041-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 2026/4/30 6:29, Jakub Kicinski wrote:
> tls_sw_splice_read() uses len when advancing rxm->offset / rxm->full_len
> after skb_splice_bits(), rather than copied (the actual number of bytes
> successfully spliced into the pipe). When the destination pipe cannot
> accept all the requested bytes, splice_to_pipe() returns fewer bytes
> than len, and 'len - copied' of data is effectively skipped over.
>
> Fixes: e062fe99cccd ("tls: splice_read: fix accessing pre-processed records")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: john.fastabend@gmail.com
> CC: sd@queasysnail.net
> ---
>   net/tls/tls_sw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

I just hit this bug on v6.18.y. Somehow this was not automatically 
backported to stable?

+Cc: stable

Best regards,
Qingfang
