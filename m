Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA142E413;
	Mon,  7 Sep 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796456; cv=none; b=Hssj5uF34ocTkTP4X+evyH8MchP1CrdZ8390gm515Jg4Es8TLJv5mRbpzxiypnCLxDBzCqYlMN9VHBG+mfJ9Gyie3g21BTvp6gTWjHE4JaYreP5Cfkh8LijHHxST0JNwtJIuI87wkIt666WuCPv5GJ5cugAvIqo4gDWh7qLF2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796456; c=relaxed/simple;
	bh=7DAkVuwaidRKILEW8df4p8sJNNgVBr5msRytFD+Y8kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1QtCLruOoEgvkKJljVxp2KFnJupgiQY/+OSeZJKBJvCYONSg3znyFFjFS2rutQzY4hjRBmGSSIP6ac7SwpIbKI/clLwVUg57LvrBLI/Gv6R5+wFWKnMVZ5GpKFh0lycCMpAJW8Io6gmoFmWNJ+nIJ1mCC3j3ORA65VSy+4siwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RBRpsKGh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EneXJojm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RBRpsKGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EneXJojm"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79B8E7A0134;
	Mon,  7 Sep 2026 11:54:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 07 Sep 2026 11:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788796452; x=1788882852; bh=vmcGIo6Tl1
	RcZJbVOwce0WI7+vR6QGOBP3ns+dsw7RA=; b=RBRpsKGhr3iVKD/4XRcSvSMQIX
	c6Wmq11KagSv2cTxBaS8sTux0LfAekJm1vwV1x+Nl7GIcrGogLYyYZpmFCN+hgYp
	Vr5c3zirdavuLuctXlenzlOOqZ64WOQgHghFsAawBIGxo6l2WDcChbI1sUZZdCai
	j4S+yVcJwZ5RtX3YbfNRZ+j6XNl8RSn4lRrdlmpHZyKSNdbDfdDpR2Ei7bncUqcL
	aVee5IartYjazvovvHqNlYsUr/UES9f6y1rWWL22/HobyfDV0/+oVIASji66JBdD
	rPJXbmI+dpBCYyrZBOwIl+yu9d8QJnFOG/FDio17j59uvZbBu5j/naNpzX/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788796452; x=1788882852; bh=vmcGIo6Tl1RcZJbVOwce0WI7+vR6QGOBP3n
	s+dsw7RA=; b=EneXJojmKobprvmKmHAmSE2YqioDVwiQBTNO+OgPTkDUUaoD8JH
	4SUKFv4A+MJqG5Ng+JFDqiV77Hp8sP/pbzWBC2ih+RDf0WddRXWbCl0u5m9eHLD6
	CpL33FWE3MfKzUh3mLCdhguI+Mevv+wRztO5vdMdvNcIyTq4xgCO3eZRI184Dvz3
	+14qlOEb1vd8YXBPJ9capb93FVn68oS8ogvd68zbbmozkLvT32EXwZe/wBftWgQM
	6mpj/CMbfnVDtNSju3jgt9r1qMkSYdDU3ejggFVH/PtKAVp6pmAy/iSh1EwlkhGb
	jDqIy+AdlFDEJwAsLWTa1jy8S28sVhjkwlA==
X-ME-Sender: <xms:I96ear5yfNHAdjSBT3MhjRFTDzMuzikzTIiqbyd-soH4s1DODhbVEQ>
    <xme:I96easD3rtDPl8KCFrUwtZ7epfQ6cxcWZcpwPot64enVT2KpHO10alpKjX2SEDwGW
    0-rUPs01jE5jXzOSCM15LKvaDcE6uRlOmPQn94Wtvav-JX3yw>
X-ME-Received: <xmr:I96eao2jw4TVKe8C2d67c6IA18pkpk7_28FU8EQ5sdNNfMHjIIcZPus-fvnZWw>
X-ME-Proxy-Cause: dmFkZTGFhKjfemZgkL0XlIifGOFrkZeBE+xq/rfP4Fl+LXvjMd7PQ5LXrQ4oDSNls84ZQS
    whb+IcnI3qMyXyp1sqiOPAFp7Qd6BcjKLCiA4c2AYY56lOSMEfNtALIXOsU1z3b0aB5ynH
    bqHHggXXb9CiRuLqLWoKd6NPChd5NOL1wMVsV2TvKPwBxp5RjKlfTl+RZSgDdN4RD4vmc1
    +B+DVJ50wrF+QSsrrLlVVn+BzitzC50Yy7nua+OsUiEKKOtDAkpYYJwTiuosO1vx693207
    UDoVv6uYD9IM7pcTQciblNBrLmLSNwKh43tqveeXctGjXgzwRNaFyZU8u3iikqnLME93PX
    GHY12OuASo1ZNEQ7E38DQn87wOYR86Lfs8sRsm+SDOrSZaJpLvmRJWM8j9sjJ8QIHJQ+vE
    06rQTm6GK6rtErwaIzFAbz74aEalc72ky/iiY7ogAnXRALPV13752QQUvefxusUCxA5MZ/
    +8gJLlEpwTCdYHbgCagJwZiEhjEknAXIRbe4nryXp0RXb4wtBSZlVOjo07Cno2MtVNJmh+
    OPZTISdi6ISYgNtkvdQ+irCn3p76mg23rgpjzSQzOWi1uGU9qqNzuJeStn/b2NkN73oE5O
    +CyB6XUemKiPQr5vklzwmhB2LKh9OhABhnBHrA0Oa+bWtD8lsv5V9kTjjydw
X-ME-Proxy: <xmx:I96eanFBzJq0zv6ywdxWdWVOrwYVQ-Y1UT85sK64JvgvmpZbvIqQjw>
    <xmx:JN6eahiYn5Ez7rWl-nh158i5MnhUuyBlwGkEImbudRHxJ1gTYjUA5A>
    <xmx:JN6eahugvP7IPJq7Ju8QWZ18irDVf9QxA9BSPWmnTdtogDTd5UJrZg>
    <xmx:JN6eaksLSKtoiijqZBURXosemi2yDK0Y6AEsIxurztkIv9ty00taUQ>
    <xmx:JN6eapRmon52uqJur9PH5RxDUobu6E7B0QAwpGa9M_UXEbvlVRSMTmBB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 11:54:11 -0400 (EDT)
Date: Mon, 7 Sep 2026 17:52:23 +0200
From: Greg KH <greg@kroah.com>
To: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com" <syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"Atul Joshi (Nokia)" <atul.joshi@nokia.com>
Subject: Re: [PATCH stable 6.12 v2] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
Message-ID: <2026090706-dehydrate-hence-4fe8@gregkh>
References: <20260904183500.3841094-4-florian.fainelli@broadcom.com>
 <2026-09-05-daily-reply-0047-tcp-syn-recv-race-v2-6-12@kernel.org>
 <22b7bae35253cebe11b515d11b245d7c551c0f29.camel@nokia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b7bae35253cebe11b515d11b245d7c551c0f29.camel@nokia.com>

On Mon, Sep 07, 2026 at 03:34:45PM +0000, Joakim Tjernlund (Nokia) wrote:
> On Sun, 2026-09-06 at 09:33 -0400, Sasha Levin wrote:
> > 
> > 
> > > This fixes CVE-2026-43198 (v2 -- v1 broke the DCCP build by not updating
> > > every icsk_af_ops.syn_recv_sock implementer for the new argument).
> > 
> > Queued for 6.12, thanks.
> > 
> > --
> > Thanks,
> > Sasha
> 
> Hi
> 
> I do not see this one in the just released 6.12.109, maybe I am blind?

Nope, "next one".

thanks,

greg k-h
