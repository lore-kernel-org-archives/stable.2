Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728646;
	b=3ZMYN4ggIo+Khma6JcS13FUGg8pD6YlFBqCHP0VS8gRSQkO6mk003PJgFNlmPgrE2s7m
	 ZuLtspFsm8qG+e99ezv0Bvn9HD+GFpGjZQxLtttD8MdAo/X9KPsmFv7O2oPuAvptT/MK7
	 vpg4dJDZECdsu84DnMzo/am4j3E78t1EO0H7blWHyx+pE2kEAPbw7n4DA9ygyDGeOm+1K
	 WdeN5TTJVL5QC2KfNr9j4bF0H7gwICP9d+DIAE4Dha9iJYVI3nRpXEcGHhgR9vUgmYY+j
	 Jhzhw+M+veEnc/5GtJOR9Ye/aRCBiMCNdjiHebFne6kLYU8khxvP4NbbetRBP8N1k8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728646;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IGmL+ZljixARqtR0vy4WmzIc1Mkr9YWBmXAFCIeNys4=;
	b=E90vc0tpTZVeIWG4OTvjwc1QbcES5gjU7gYpcxXPhyI1Oxy4jEr7c/9IAcqNmgjqi4nl
	 MtDynew1QrbfpRVG72FphNozo8cuaYTPnfwa0tFl69Ednn8HFFh2PeSRtkq+Noap0TqpX
	 2xWNxODZDKA3KsOOZipJgtmyQIbn8P/DmeKMufdL1t6yMF0ZxXKusXekkAEl4oo6Rctmj
	 F/z3/UP5fMRSxKI5U0oa9wWDGSmxT5Ldvhln+SzEHHiEGxMkocBiUNNO8d9nx+O+2lPqz
	 s6SMhCFbH5vh5iryi6WwaXgXqos/xkq9s6gg0sixJKAN41DwCy5lnlrQ71pIemXHSag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=waFuifm7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A1606A31B;
	Tue,  3 Nov 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=waFuifm7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBC71F00A02;
	Tue,  3 Nov 2026 17:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793728645;
	bh=IGmL+ZljixARqtR0vy4WmzIc1Mkr9YWBmXAFCIeNys4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=waFuifm7N4OvFbskcsoefmRTTV8x8v4OheEyzLyc5+6fzDH8tPZ4p80fqJvi6rdjl
	 NsE741KnL22ypektEwLwemg9xPYUgk7lqmWkN7l5xULzODgMX3eiL85/iIXTdvzLc9
	 gNkyiApQR5T9feyHMFsaOuW8/IBXsa8slAMJk5nI=
Date: Tue, 3 Nov 2026 09:57:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, ziy@nvidia.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com,
 harry@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/mempolicy: recompute automatic interleave weights
 on memory hotplug
Message-Id: <20261103095724.0d7e127da59bf864cb10c156@linux-foundation.org>
In-Reply-To: <bf910739-a85e-44aa-9f13-481e5b6c3336@kernel.org>
References: <20261030161234.1505367-1-gourry@gourry.net>
	<bf910739-a85e-44aa-9f13-481e5b6c3336@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Nov 2026 17:50:48 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > 
> > Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > ---
> 
> It's a good idea to spell out what changed (and why) to make review easier ;)
> 
> @Andrew I can pick this for the next merge window, or do you want to merge this
> through your tree?

Go for it.

I'll drop the mm.git copy now.
