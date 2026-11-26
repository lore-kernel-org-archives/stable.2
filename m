Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702987;
	b=YqGF1Z6BUXXvn+QRnHLhyGZWvBY8c2r85NTIBCVEe+cEVngwvEfIRLBXs2+19vWFhjVh
	 weqO17CphzQGuqTqu8Qim3LdqBYu+pX9cbh70TsVcvcEOARcbyNRoxH9c4OWy5H4qYBh/
	 2xpda5tLvA1InFyE7Lh4yZTSY7JpW4B0wb5OSIiElWxNLU1FJOKI2hWl36FWWi9LpjB2P
	 Os4oq/AYR75ieXnETDVohAExRkM7Ev7wodHxPmUWo2yoNUfLTi/rFKGCZkPQaJhjLrPE1
	 3K47o/LoUaEEvSIX7Z+qqFKqGQph4vz+V2VflV5Mm1t4fjzgJ6jqvlEoHug2g+OuMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702987;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=LaiH2rAxdwXugECrjez2tyTxqbFfT8ZS6+Dyrnh0RyM=;
	b=utdsG3t3MD2MbECPhBcKLhtiLXZ5FBweAxlven1+ixAi0KMFQXTJFFAX6oSkfkhiG5ge
	 twjNmd5cW0g03MqisYOYDx+hMWD4C0Hznddq4Cg3mgyyVuPDvfEXk1wXmGzPMf7SsVILC
	 rJomzkY2h1TsyDva9OhkNSnSWq81V0alRdSagmX2Wu6wq3u3TNmOcVpbGC31ehtku+8+i
	 6f/EkZHmrtDBrGmo3FWpHYXY/h3ixdAIVXjQuvt0nzsrfgSgJMrNCPtznipVzCXm7gaEg
	 aAm00392mENrCZp+k7QStVXHwjh5bz1LjREFz/OIjmCRYaHnN3qrWfCzc+NVKkdathA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hUzPqsFX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADF606A321;
	Thu, 26 Nov 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=hUzPqsFX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082D1F000EB;
	Thu, 26 Nov 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795702986;
	bh=LaiH2rAxdwXugECrjez2tyTxqbFfT8ZS6+Dyrnh0RyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hUzPqsFX8Ie8852ccc5kJqJZ8lFXm7o0USCF7ybOfj/etRJMygfMpn/kietGB6D4W
	 DTlzPy4ZaUGxTkM1tEQPnZJiiokHYi8DdkyWVzQY986p7t5chkf/+sE4OqVNPiSVQA
	 5hlHvJwIwrVz9HWI0p2heuceah8853fqFXORk/yM=
Date: Thu, 26 Nov 2026 15:23:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6.y] Backport request: beaf0e96b1da ("bpf, lsm: Remove
 inet_conn_established from sleepable hooks", CVE-2026-63865)
Message-ID: <2026112616-garden-overfeed-1512@gregkh>
References: <CAMcAce8Mq7FLgzAMgnTQF=iB8V+XZ57wCCu7S0-ULTE_UF68ew@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMcAce8Mq7FLgzAMgnTQF=iB8V+XZ57wCCu7S0-ULTE_UF68ew@mail.gmail.com>

On Thu, Nov 19, 2026 at 12:40:36AM -0500, 梓川咲太 wrote:
> Hi Stable Maintainers,
> 
> Please consider backporting upstream commit:
> 
>   beaf0e96b1da ("bpf, lsm: Remove inet_conn_established from sleepable
> hooks")
> 
> (CVE-2026-63865) to linux-6.6.y.
> 
> While v6.12.118 already has this fix, linux-6.6.y (tested on v6.6.162,
> kernel/bpf/bpf_lsm.c:309) still retains BTF_ID(func,
> bpf_lsm_inet_conn_established)
> in sleepable_lsm_hooks. The hook is invoked in TCP established state under
> atomic softirq context, leading to sleeping-in-atomic bugs when attached BPF
> programs sleep.
> 
> The backport is a clean single-line removal of line 309 in
> kernel/bpf/bpf_lsm.c.
> 
> Fixes: 9e1026079c65 ("bpf: Add bpf_lsm_inet_conn_established")
> Signed-off-by: BoBppy <inkxiao12@gmail.com>

Please provide a backported and tested version.

thanks,

greg k-h
