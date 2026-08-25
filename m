Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17A3FD132;
	Tue, 25 Aug 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654640; cv=none; b=DkUZygTkLhSjfdwSmWkEg3yp8KrzzL55b/2BZH6OEZ7lHGm4qIVkEUvahc1wUje16JLXityXQjuJXtEAjToaweF8NTwg1wh30HPsjg5tlgVwb0drEQmn4BDtx6/1S3ZFEZ5NCu+lcdG+REM2S4Y3BAJXb8EPL6bpDf5vFuojG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654640; c=relaxed/simple;
	bh=eKcSkrYKQdQa82Qv1iqorastH3wEUAdnt4lpTuWJQng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ6SLMtm2doiwbxxIgO++70CBvXXN01b4xQfyhh2+8fuoN1MEsPKntF75yKQ1SF2+tMp/K/ZXq9TKsP/ZEChbHvS8iZJDM21Y+Y/WxaFt1jMi/FHJqhjlIEIxy78Uvhj0C2XM1FKKPfLpM6rwGI53wiKNW7MFB8jlzEi/7K4lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CihbE8OV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CihbE8OV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kfCTEZvSDJU1EJlGKSVTHNCvxSZkeuCBnvxQlvxKu10=; b=CihbE8OVOJFZrqvsrteKVcO1MW
	LdCpFvY/b2ugHm4CiGNrAk3oAwmUF+SN2gFYAa8TLQJ2Bu/KAeG69+3f3ISqzJfgCU7Hu8Q9tSE/5
	wlWK3iIJ4pUersN+0WooPX6JT9aaYdTe90WstvOw281PJkOMJsIhGXxxuevm2njaUI1Lz6GWBDvwW
	buMR9h7Lq+ZvGjXx2o0qX6OcYmjYnBpr8Kf/bw/1TJPzybQspUJ5wKDXLw5XgEG3t72kMN/Df50Sx
	MSNw97O0dhW38XzCeUbx55bq4QaguP0tSqLiCfXaWMjE9Hs9/eUa/6gLQ655R2hNrj+4EQtYVElfa
	obCkQWHQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyodC-00ENlX-15;
	Tue, 25 Aug 2026 10:43:50 +0000
Date: Tue, 25 Aug 2026 03:43:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: fix spurious TX timeout after dev_activate()
Message-ID: <ao1wnOkX3nUXc9r5@gmail.com>
References: <20260824-trans_start-v1-1-0419cc427ed9@debian.org>
 <4f3857029d855ed4e513ae01a2e8f018@tipi-net.de>
 <7aed7185-d48c-4013-9a85-a8b27cf7eae3@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aed7185-d48c-4013-9a85-a8b27cf7eae3@redhat.com>
X-Debian-User: leitao

On Tue, Aug 25, 2026 at 10:47:13AM +0200, Paolo Abeni wrote:
> On 8/24/26 5:13 PM, Nicolai Buchwitz wrote:
> >> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> >> index ef2b4bf515641..4539dc2c6d380 100644
> >> --- a/net/sched/sch_generic.c
> >> +++ b/net/sched/sch_generic.c
> >> @@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct 
> >> net_device *dev,
> >>
> >>  	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
> >>  	if (need_watchdog_p) {
> >> -		WRITE_ONCE(dev_queue->trans_start, 0);
> >> +		WRITE_ONCE(dev_queue->trans_start, jiffies);
> >>  		*need_watchdog_p = 1;
> >>  	}
> >>  }
> > 
> > Follow up or v2: netif_trans_update() in dev_activate() now seems 
> > redundant?
> 
> IMHO should be a follow-up.

Oops, I replied to the other email too early. I'll respin this one and
send a separate follow-up covering netif_trans_update.

In that follow-up (net-next material0, I can probably simplify
need_watchdog as well.

Thanks for the guidance,
--breno
