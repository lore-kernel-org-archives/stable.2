Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539081DFFD;
	Wed, 29 Jul 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295262; cv=none; b=fUBrme3iBrmfF3UySmaS0ifryL7MHlxLmD4s0rdDfQwRMxSkW8A7gcVO6AUBY8AnGxlsm75ExMU3bgAmltZMHjRSaaBQPX24ukMv3lfhUgv8gSffN/BK0gLADr5ftcpeBCJW7dfYN50Ge54fpIP57O4jYfphLOGRw0Ftk1/pEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295262; c=relaxed/simple;
	bh=A3+DG3ywRoXICALWmx2YBGqmrJbvjizvTjbui7+w63U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/vaD/gkbJHf9pzv5rgKHGXTwEd3DFR2IbHG6WPJANeGlqdk9VJKi6E8CICEHvSNpcZL8CNb8u0gmK0PZytORkKuSvso8+cN/3xZHFKPNtYllgjTznTO9C2pEVnsaxaKxR1eGQem0U51oKT1bwpWv4bXl7JI883j4fRVfkLLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=KPPKDT8j; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="KPPKDT8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1785295251; bh=QZsHMYluW4mQpxycGUlkM/bOPER79ocyMi0DK7FJgOg=;
	h=From:Message-ID:From;
	b=KPPKDT8j0Knz+RMvMhDwckOHhVVYfgeDabq/BW4ZdxuWhyZ5yVhqlQhnQNd9ADSMD
	 9fw7kJjj+19IaJzFlfF8VDEpGNFWf0ojm0UqbehQxrd6RUJq2N7NN0LK8CE2/+fExk
	 FQiQE4SPacZfPHOuzTisoSZCEyoAjEDmrdXAA7jo=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 31287C09A6;
	Wed, 29 Jul 2026 05:20:51 +0200 (CEST)
Date: Wed, 29 Jul 2026 05:20:50 +0200
From: Willy Tarreau <w@1wt.eu>
To: Santosh Kalluri <santosh.kalluri129@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
        jiri@resnulli.us, zdi-disclosures@trendmicro.com, victor@mojatatu.com,
        security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
Message-ID: <amlxkn3Mn55Ohar1@1wt.eu>
References: <20260723105210.817079-1-jhs@mojatatu.com>
 <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
 <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
 <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
 <CAM0EoMntwBbw7ADoaX+KibvPHqmsPgt2yQpQpNzSMR4JzA7D-g@mail.gmail.com>
 <CAFUOXOmP_bF+JL6gKsz5usmT+K=O4zFtw0MrCwi5CMxbmKRDxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFUOXOmP_bF+JL6gKsz5usmT+K=O4zFtw0MrCwi5CMxbmKRDxw@mail.gmail.com>

On Tue, Jul 28, 2026 at 07:30:32PM -0700, Santosh Kalluri wrote:
> Hi Jamal,
> 
> I tested the patch-paolo-mod after correcting the hunk count locally,
> and did not find any issues.
> 
> The attached patch does not apply as sent: hunk 5's declared line
> count does not match its body (16 vs 11). Could you resend a
> regenerated patch?

Just change this :
@@ -307,6 +319,16 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,

with this in the patch (11 instead of 16):
@@ -307,6 +319,11 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,

then it applies fine for me.

> Thanks,
> Santosh Kalluri

thanks,
Willy
