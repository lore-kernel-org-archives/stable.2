Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62625499F3B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786055693; cv=none; b=qWv9fzXz/63EknOoexRdTsUzGj9J/9B5Bmxi0O/9YKsN5t/9DzMMTwzvsVrAaKBnwH050oilqrmKLPW7kN8YNMQ490aoHVzo4bKO8+rliMdlNPs3yBZa5w8vOyCQnIbgTonivDZbIQDGg2oJ01SiMiQQD7kkfdqGdjEsZVDJ6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786055693; c=relaxed/simple;
	bh=epcEbLSaBihKKb5cz0M8hdhr+ScKrzadPnLxeb8ZJaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjWUhrYEpZkXfF0zFuNf8iVkUAXZzT+ge1tJSbfs767SDyJd1WMvaZVrpwxXx0XYBtDAjLTePmSynuOAc6AmlkJp6xu6ceZetfw6vTiAh8a87te7nUmpdHNdwO5d96t2l6a77DbHFRk/r78jvPuGN2D7C6b3Eq16pnEsBcL21uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RIbcSfGV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RIbcSfGV"
Message-ID: <cdc07462-5997-44f5-8659-5e7862f418ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786055685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIkgpJ6Hjjg0HhVdJPiDETikGObwkMPvScfiWimMD3M=;
	b=RIbcSfGVx8MvYhYKDo0QeYO9RrTh5QKyNwI50RgCApfkbf2rwm7wD0p3HFKc+TkaQ3SAvE
	/4Cft7UYkgGtyBASEoIogpNl3u9wzclJSa4iZCUQ9JLCKtlUnm84zsEcUdbPL20SmkJa4B
	U+C73le8GQ7/+Vs0PXLq17bpntadcJk=
Date: Thu, 6 Aug 2026 23:34:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 2/2] net: ravb: serialize PTP clock teardown
To: xuanqiang.luo@linux.dev, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, niklas.soderlund@ragnatech.se, kuba@kernel.org
Cc: paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 masaru.nagai.vx@renesas.com, sergei.shtylyov@cogentembedded.com,
 luoxuanqiang@kylinos.cn, stable@vger.kernel.org
References: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
 <20260806095126.57803-3-xuanqiang.luo@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260806095126.57803-3-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/08/2026 10:51, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ravb_get_ts_info() can run without RTNL while ravb_ptp_stop() unregisters
> the PHC. The PTP interrupt handler can race with the same teardown, so both
> paths may access the clock while it is being freed.
> 
> Protect the clock pointer with priv->lock, clear it before unregistering
> the PHC, and unregister the detached clock outside the lock.

I think adding spinlock here is a bit of overkill. For
ravb_get_ts_info() you can simply extend struct ravb_ptp to store clock
index on init and reset it to -1 on ptp stop.

For interrupt race I think ravb_ptp_stop() can be split into disable
interrupt function (like ravb_ptp_disable()) and actual clock free. In
this case ravb_ptp_disable() can be run before synchronize_irq() with
ptp_clock_unregister() afterwards in teardown callbacks, like it's
already done for ring allocations.

