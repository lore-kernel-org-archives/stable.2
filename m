Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94333D8131
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075191; cv=none; b=oOOiRexNgAIy5ne6xuZFttMK/vg24Z7iCjDyejGSPBjYsL/9GZVVCrXBfRc6tCJj9FLp3N3brMZ/ADxeb6Y3fxaDhge+lVrFE9h6kwO4vchfM8qOyRR7mas24slGyxajsv2UDsU272lWnGAMyfB4e5x/KqI9uW744inQmkgdLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075191; c=relaxed/simple;
	bh=gBd1lQQ0YlH34GDEWrMLQObGGp6KHUI2WPq/24ZdM08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdR6cZt5csXZxqXD9Sn++KQO/MLtTk9wUwUj0BU37JMfniNyZhbwESA0ncrwBvLeMQVTUM7RZiRaomM7yipRhjlpkZsjPSIENDSxXI8dh8IeoecLihFvIgPpDm+kKxSnjqASCzw5Ju+B+ng3OknWqKR9dG//hNkjsPt4BcfYDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehxEHhNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehxEHhNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81CE1F000C4;
	Thu, 15 Oct 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075190;
	bh=mmiUyqmsfSRg6ClwR6Q6JMr/UJ3nE7Qv5AHeR45H+eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ehxEHhNMPvEzprsuKPf0KyV72AqmkoT0cFkugddWqDR1jW16KcjT4sO/ySSxEfGWT
	 DIlBxD4Y3HvPqj7a4dnfqU+9/yusDtBRALtYlZ6ZcU+KYo9SE6SCsXrezt0eLqlFmL
	 zHSGOIl3ezj7Y7sJzdbmtAKWHo0ylKdS2ihWXtbD12TecBWekas7wDvGVsybx3q7hF
	 CDEK611Eh9ePcP90Uo37gH6RHHEd2RsIfFuEJOrqJhMXTcKw7ljsXYYVR7VuV2983j
	 gvSQOJ0Ujn2HLOmoXOdlbU5rgRmZZmg3JNA5Oaq4h9Ly6f3xUUsg+CXrpr/vlP2q+O
	 ZD+UwhvY4/X9Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id E8C531980047;
	Thu, 15 Oct 2026 10:39:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 10:39:48 -0400
X-ME-Sender: <xms:seXQatj6yK-vAkGfz3nmtzKfQEFz5k8BX2NImvxWqUbYpsHkFTQ01g>
    <xme:seXQakYEg9wygmgO8qd9seG4qnI9uV1FznHgR73T2LqaINe9lH9e9JGyjRIcvPgjN
    5-UyZOH9z1AE_w28SJ8XhztMPG7VFPG3N8OvnMXYuxZwrCPNLPl8Wtm>
X-ME-Received: <xmr:seXQamW3ujf5cRPatCqmaVHg7mAYJNu8yUpSsSsDY4CYvzzTGX5vBv0WB3A>
X-ME-Proxy-Cause: dmFkZTErd8TIAjJGupJmPa7o/yBWPPRT5ZQiaOhRc5EH22t7peU7D1eeODEsp8i629tNhO
    r4mHy21KV0D6RvfIOkH3orkwlPlVaAN6jAj64nPwE5LJH03cLu0deasjjvmPESP5FrRnyw
    jePRXgR+deIN9SCGY3LKnpTMhEl80DUyZsvo/zt9GQ4FZXq0CZ278f5cLt9/f6ZRqhOO0z
    MW3niMw169KWxeTjSDwTUJBvQbp6c2o9+777eazijSZpKAhWCsSh1+j1yQFNgkZxgW+JEC
    QKT4R1QjCQZxBw+xy0ZP+qQNv2hi8RFl5iAbv4eFLhMdaBxtKPy3D7BBsuG5AGTzp6ocfO
    gW9/rTewo5ZjF/I7btK8pdenXh4Pai1Tp+eppPQBJmhh3h7qPtwjCu46ta7YXgDVbSS8Vl
    Xy1vFOQa3hVQkaD8aDr9nO2Ru8V8jtY1ADsw+jwmfKujikDA1gymEpH8JSR9zF2Tk6Mq+y
    0GHFZ7J9Fy+MbjhVfRFODtQDDx8VwCvZoWDuk7YUY4YDiZbLhZeOkPECpmVW0meovVfYBn
    LxrVGtlOuAgpbe2FWut7pkilEntTgIphkhOEz28RSG8XGZXjvH721/OJrwz1gxUriBmlpx
    kglVxqDks+d8Lgi2rTjnr2fXqEkKG0pk69Anuc0vT+mD8dIqRl+/rUEDT3HQ
X-ME-Proxy: <xmx:seXQalZ_Ia4dtdBh7Y0MNSkyV_tmDrSX11oLZzx7oE4qV226opti-w>
    <xmx:seXQatKEZXVI8WusdGaszIdpzIltlRXDnHaqnVKMgn-ZBWuxeYomNQ>
    <xmx:seXQag1p6-xpzk_G1Uh6kjlQ1B1pIFbQs_lyg4K2NR9OivETPJTidQ>
    <xmx:seXQarj-N8TiYs_mhj8M4epjZVN4_2UGXOyOyXn9eH-y7_7aVVs8UA>
    <xmx:seXQavwGIxfp-zTAD4JRC20qfXYX_ZVHXgCfdyXS2sTR8wDiK9Y_eUPY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 10:39:44 -0400 (EDT)
Date: Thu, 15 Oct 2026 15:39:43 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <atDlYr_RM4WRlMqG@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <a809956b-9775-4667-be60-f635b9a72ee6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a809956b-9775-4667-be60-f635b9a72ee6@kernel.org>

On Thu, Oct 15, 2026 at 03:53:30PM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/15/26 14:55, Kiryl Shutsemau wrote:
> > On Thu, Oct 15, 2026 at 09:16:36AM +0200, Vlastimil Babka (SUSE) wrote:
> >> > And agree 7.4-rc1 with CC stable is fine. Sadly, not sure if anyone
> >> > but Meta is using the feature right now.
> >> 
> >> I thought it was there for a long time but it was only added in 2025 :) At
> >> least the enterprise world is slow to adopt things, AFAICS.
> > 
> > I was thinking to propose a patch after merge window to make defrag_mode
> > default. Do you think it is too early? I don't think it is ever going
> > to be truly stabilized without wider exposure.
> 
> We can try it, but preferably with arguments (and best, numbers).

Will do.

> > We also discussed with Johannes to make a stricter (defrag_mode=2?) mode
> > that will not give up on fragmentation ever, but OOM instead.
> 
> Would you use that mode at Meta? That however most likely wouldn't be
> general purpose enough to become default.

Yes, we consider it to be preferable to fragmentation. But it requires
experimentation.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
