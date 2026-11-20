Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165010;
	b=EyvMg7cXTbxjEbMFfNnbEK6/E8BRNsC9A9ZFGHIlDEsS33w+76T6PDHXrXAa60yVomK9
	 hmpSI7nH9fhgXEySsi+ctb7sp1BaD7ijgkwC7YNzEzy0PF3938vwDxMkK8X8nMENMDyjg
	 AKB/nPX1IXsFm/PnpXzlea6Ct7xZCJ6GPqcbsgx/m6A8EeqyuPBue2rWo1ftJFHQsrjjt
	 48mOqRDpWCKz4DMvTBl0HfBCKYbkKMfZOjduR6n1WIzfVWCkusnLC73f25vg8KHzXDyaE
	 Pp9gzOQru8eQyD0XkrVvEEcIztINs9aU66dTowSawgQHtNnnWJC1pVTgTnDAV7/H5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165010;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 DKIM-Signature;
	bh=rK1R8ZHwVo1Re3JLTYlyIHvSg8L7skYpgklaW3rtQyc=;
	b=nEU/K8yE/0db+rmMC5AS9mVO4zI8v9zMW74AUAg1YkJ8Jkhmq7PSKM9y7Nu2uAPnVdJ7
	 IIJ9ikbljiafik9KDgS5vaUsjdGY64qNNrONA9OVHdLuhA0whPAmuyuLHjeJCq0IljndE
	 N+fw3WqA4f3Bqk/2OQuFvTXYUOfJrQfd9gK1t4K6+VwWtQ8afVsqHalctHkw72VE6Kf/5
	 DFTy6ilRbxXsrELvNiY9WmGKQv+bDyWxsbCUUxTNamFIcKm6YwsG7ns5gs3CzBGDwR+OD
	 ir7WBIiDVG3yKAWX84YRg9WTnr1bZd6VZu79VEwJZ65wfiFu6hIQDuR84xXroodAr3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=J6yO8HMf;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33279606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33279606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=J6yO8HMf
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 20 Nov 2026 09:56:44 +0100 (CET)
Date: Fri, 20 Nov 2026 09:56:42 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
	netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
	tavip@google.com, toke@redhat.com, aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org, lorenzo@kernel.org,
	magnus.karlsson@intel.com, ihor.solodrai@linux.dev,
	edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, memxor@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v7 bpf 3/5] veth: use the frame mem type when running XDP
 on an xdp_frame
Message-ID: <awALSrKSY3GSVY0e@nr200>
References: <20261119133032.2015656-4-sst@poczta.fm>
 <9a5a1487a4676381f4c3d98cb5a22f50e2f54d9d4ec7947891c889b64ac12693@mail.kernel.org>
 <CAG4wq-favnH37jS2=a-aJwBgQOuW=KTsM-vJWp73PNDfFq4=ZA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG4wq-favnH37jS2=a-aJwBgQOuW=KTsM-vJWp73PNDfFq4=ZA@mail.gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795165007; bh=rK1R8ZHwVo1Re3JLTYlyIHvSg8L7skYpgklaW3rtQyc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=J6yO8HMfdTGMVDA94Am0LW+K4wYF4g+JzZfg9naHj1EuT3mypc0dr4qGcyY+s81tw
	 IdunbB8uJpsuRN2gGmx9lbm9vVD4z2s6w+NyAviXMnOfYQU0kqNa94d3O4GBHnF7Fc
	 OvDmp5U9GNIdXLFn8sL0D92Yi2tkFDSWUvBM6QMY=

On lis 19, 2026 14:24, Tianyi Gao wrote:
> On Thu, 19 Nov 2026 13:54:58 +0000, bot+bpf-ci@kernel.org wrote:
> > Is this Fixes: tag pointing at the right commit?
> >
> > 718a18a0c8a6 only reworks the skb path (veth_xdp_rcv_skb() and
> > veth_convert_skb_to_xdp_buff()), and does not touch veth_xdp_rcv_one(),
> > which is the only function this patch changes.
> 
> I think the AI is wrong here. Before 718a18a0c8a6, veth copied a
> non-linear skb into one linear page, so no frame with frags could reach
> veth_xdp_rcv_one(). Either way, 718a18a0c8a6 and bf25146a5595 are both
> in v5.18-rc1, so the choice makes no difference for stable.

Thanks! I will keep 718a18a0c8a6.

-- 
Slawomir Stepien
