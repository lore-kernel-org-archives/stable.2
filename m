Received: from mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7264AD4B4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189915; cv=none; b=T7Ruwe/TwQ5qdPMwd8pA6TzWp5/TvRmxa2J6ayvMxaynP132HPcEvkDUhDlyGa3YjgER07A2W/Lmcvkz1d91aParVOC/cyutw66OX0IkrfhTr4I3XZ5TP002GrlIb0fj0s0ixG2jYj/7V5noKxIyCwvaRiGRAb5Jl2p1hoecpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189915; c=relaxed/simple;
	bh=3H0iTty6+uTA7hGVte9Hw38VpJ2zVqDDcPHb0rPTBHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYqzoX498K8zxUXjZosiYkBl2ZwA2+y6dTNDPPWDx92gF4bABBexHfHq7sxUtSc07l0uuCQC566VPqv8ucrS99aGgWKpH/LOu7+g9qnLvtpdjt+9XT0DswVIHlMBdkBnc7e8/DyKrrJTCLmBjTolzu94nayLywFu7XED6sDtjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D8lVs7Kx; arc=none smtp.client-ip=91.218.175.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8lVs7Kx"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3H0iTty6+uTA7hGVte9Hw38VpJ2zVqDDcPHb0rPTBHk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788189910; v=1; x=1788794710;
 b=D8lVs7KxmziACm/IKkCgmh5EHBfuoB6LIKOF5tZdeCe0EMY9L98Usnuv+HTYTMyUM3quxP+p
 x+AbJpxxxiAbJEBJaD3Ev62tp5mLo2j8trzOapPf+WK33lsOYRJ4PADohtA1lvj1bwB5d0Rx5os
 ryVebwu6Aeermt3sTtTSLbcY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 94ffe132527dc845;
	Mon, 31 Aug 2026 15:25:00 +0000
X-Mizu-Trace-ID: 94ffe132527dc845
X-Migadu-Flow: FLOW_OUT
Message-ID: <129e286f-8301-4ea7-bc12-a069df2f2ce3@linux.dev>
Date: Mon, 31 Aug 2026 16:24:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: macb: initialize PTP lock before registering
 clock
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, nicolas.ferre@microchip.com
Cc: claudiu.beznea@microchip.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
References: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260830153520.2710520-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2026 16:35, Runyu Xiao wrote:
> gem_ptp_init() registers the PTP clock before initializing
> bp->tsu_clk_lock. ptp_clock_register() publishes the PTP character
> device, so a userspace operation can enter a PTP callback as soon as
> registration completes. Those callbacks use tsu_clk_lock and can therefore
> observe the lock before it has been initialized.
> 
> Initialize the lock before registering the PTP clock so all published
> callbacks see valid synchronization state.
> 
> Fixes: ab91f0a9b5f4 ("net: macb: Add hardware PTP support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/cadence/macb_ptp.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
