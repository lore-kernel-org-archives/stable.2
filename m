Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469714;
	b=js1sk3+Gr8QoaMFW8jNn4SoKtjmKPpNrlW3DL//u2WI8E9i9IG27/TBR9P6e5m0IxTYR
	 lP5GK90tbAsqcSeDjLpUPF/E/b/ePVWE5y1I2LeLMcNy7i3dWMHJ44oRGtvKHE8UwEyGO
	 QVyvH3fxcMPcf865NdoxtFOtpevacG/tJ9ZUMFFf3h+VjGMhQShjlZhsxN5eWKb3v87Yd
	 uGeIwP+tbqdAuDwnetTT+oqlesvG8Gy8lvze8SX7C7qHXEadiSm180PKtOwlP9yTUEbBb
	 ed/gK60aCxXxfs8W/N9vCfsl4dhgn0LgjMBkpgKe7RZrXXKhP+kr/iHt5wCK0y0J2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Pen3Zlr7aIaQk09axMhhSnVK2DNRhje2dWtlxBkoclU=;
	b=muOycxR0U2E8AjvdKms2Ut1EMpIdA8rCU87JAV9vTmES0skAHE3DB64MdnTZVUc5n3a8
	 SVQQA3SacGMsbPLrGN7kbrq7saE12YpPeRZcmxgbxk7QTKTx/9w6QEIo9AQj6dgDlbQDn
	 o/2lhP4LVlGgN0mahRpyA8VUavceGy2m8qfoam/5+fTEiZB0mH54c3EksYkVKSylo3IGl
	 i2Xz/iRiaMhRiQKLdiLhhyxBiRVI76FOCZf4xXRt4IyCEh7sIgSxCnEXm9JANJp/MT1LT
	 WeMdTOxR5FHMSMoQAgXJP6K1Fq9DM2w+G/eX15bN7T/IIsbFx96ZbFkVMScwwleYtUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqzJwBgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23760606A31A;
	Sat, 31 Oct 2026 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqzJwBgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAF41F000C1;
	Sat, 31 Oct 2026 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469713;
	bh=Pen3Zlr7aIaQk09axMhhSnVK2DNRhje2dWtlxBkoclU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aqzJwBgkF1qLEYqE0ZLRwIBBFs3pEkU7NJH06n0MPcdtbginECtkK+WP4Dn9uFl1C
	 SnpaBAILOwozbDB69Rw33lTvGDConn/zbCojejRYWi3n2SJotJpCnJ4m5cyNcH/80H
	 MgCW14kpp9Eh6v1L72BPJHIsrg+hgFmLZgQuKB9zOM7UmKY3QfTN1lVCxD28mD8Oh0
	 s/tb8WCTJH0u1mSdL/4LTljfV/O9kKSNOx9J7MElwmKUWXeZIGm8kC6OEAadSGVCTN
	 1o+SoLxItBMm74Bf0XG0BgmvJijpduYROUSLCP2jIgaALA0HlVs5Pl496VJl/+JYs3
	 Fph8e+hZ4VlUw==
Date: Sat, 31 Oct 2026 18:01:49 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace
 boundaries
Message-ID: <20261031180149.GU257209@horms.kernel.org>
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com>
 <20261029165943.41fc74c0@kernel.org>
 <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com>
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
In-Reply-To: <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com>

On Thu, Oct 29, 2026 at 08:07:18PM -0400, Jamal Hadi Salim wrote:
> On Thu, Oct 29, 2026 at 7:59 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> > > Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
> >
> > Please fix your setup, Jamal, all your recent postings have patches
> > posted in reply to the previous patch:
> >
> > Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
> > They should all be in-reply-to the cover letter.
> 
> I know this is what you asked for before - but then Sashiko started
> getting weird and i went backwards and saw it accepted this format. I
> will resend this in 24 hours and stick to having it reply to patch 0.
> Maybe the sashiko issue is not even related to this but it was getting
> a little frustrating. In any case , sorry ;->

Hi Jamal,

Please also be sure to rebase.
It looks like this series does not apply cleanly to current net.

-- 
pw-bot: cr
