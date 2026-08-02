Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98922ACFA
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662541; cv=none; b=mlwPgfU6TCKAkriGTmHiTPhGkdmsoZGEzglZevJuJfRdaRKku/evrejFOKTrrhaAyI2mxdLhCTbnVBcDo6RacW3lExnhx1PaB3G/tauKyC9wwivO07dpB3eY9JVkLGUyKkdMKLI3jTc0vl7TI/Mzb2f4bbCjq3+5Mwcr6zPIVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662541; c=relaxed/simple;
	bh=JPht6IbmqdGhMwsg4LE43O7ZpEPPU4Ew82HaEdhclO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqnKCVqMKc+Z1GgJt1T1dXWi8LR/JcAP9tVvcX6cVQVPpaTT+k3U55ZVcWrUJeemaBJE4AkCIlNFpUqsqeXpT9HHJ36x6pn5mUdDDosBSgli+JsivuWuptQdt75Cy1mCcWlS7vn8mxavFX88fZ43Y8aOwCZXcmQhQU9vh6TIdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BtOK0mvl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BtOK0mvl"
Message-ID: <ea65462f-deb1-4088-bec6-ec52a18996a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785662528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPht6IbmqdGhMwsg4LE43O7ZpEPPU4Ew82HaEdhclO4=;
	b=BtOK0mvlQntcu34tc0DDqy6DFCuP7iE1ZTaeu+BFLDocJJL3KX/H1AupmOm2yvyjeWvjnS
	1tSDrlNShOckL/M89XY8pE0ahwRkXlHuXQ3FWzj2hljBR0aw6hbqwmHmzQev6oTsPPa7dL
	geZfnppG7thKdLAxE0WwJ2Ec6HyKzm0=
Date: Sun, 2 Aug 2026 17:21:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: ravb: fix use-after-free in ravb_get_ts_info
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
 sergei.shtylyov@cogentembedded.com, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260731063254.71260-1-xuanqiang.luo@linux.dev>
 <20260731182550.GA3091634@ragnatech.se>
 <4f8e09bb-b6b0-4036-af0c-89306b48493d@linux.dev>
 <20260801093532.GC3091634@ragnatech.se>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260801093532.GC3091634@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/1 17:35, Niklas Söderlund 写道:
> Ahh, yes you are correct. Clearing priv->ptp.clock after the clock have
> been unregistered, and checking it before use, is not introduced in that
> series. And as you do here that should be fixed.
>
> I have no strong opinion if this is done before or after the PTP rework
> series. If you want to send a v2 and have it go in before I will rebase
> on top of your work. Else adding this on-top of the rework is trivial as
> the locations where it needs to be checked are abstracted out to
> callbacks.
>
Hello Niklas,

Thanks for confirming. I have sent v2 separately.

Best regards,
Xuanqiang

