Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125750;
	b=JLOgLgjv/gu/c8brMedD+sGwiXjCg+BQPlQddEv3BmtZx7Z0BmN7IXLGvm6sR++yGgza
	 dT8yR4lMtKn7qNRrQGL2fhzkEEb1smjRuvRXHjgncwnyeJf1v5oRu3Pls0RjviomA7Zzk
	 2JbNq00SwGfZt92TwrjcQ82v0rZZr/ccNTscr/KIb8GTowOt6B3veBpOMcwNPAY49Yg2K
	 PU2tFsgbgnx5q7M87fGkFUrEU4NVQufs5VbNXDDG4MaDOkFcNQFambnuOSjiqwNrQGxXf
	 2VSR4sn7BBEnlMLczGogC+2syW0sQ4XRs+XAK9uEq+1mrrv16EF4geKm7rJkcpNWJFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZxjDDdM++Kkw6JCvHNXPyjiPuEQgMFfb5Qo6Qadb+zM=;
	b=CKH4GxIdq0GokkFqU7uG2CQQMWhgJG5HuI9J+EHmtF7onnsevUWmR2EFZYhsIaACPFfX
	 hKwe0unXl8ynMBOSRfVoi1EttAdXo4O+QJryBcG+1nVmZ0qvG2BoWnJcN3KS+rXtiGIoe
	 9ZKxe+C+WNZn3y674Dml0bcjAoZojP4+hUS3JNffpmprDYIGlHU1iQdyfQMa7chEVneJC
	 yUgGJVjrIMtJdPxV6yYr9Ll+uHVB5ssbzvz0Cu2et4y3HS/qpnrbGBH5FkPeHViV2bJkO
	 KnYem16GNH7Y08GkS8B9Ba9qUwBvFa0/n22pQqFUtdVBD5vBWMOcMHBgsIVVlKJj5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+uIorIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE5606A31A;
	Tue, 27 Oct 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+uIorIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECEA1F01825;
	Tue, 27 Oct 2026 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125750;
	bh=ZxjDDdM++Kkw6JCvHNXPyjiPuEQgMFfb5Qo6Qadb+zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+uIorIcfjEhsv/8UYp6PsiSK58u7Tn0z+9sgNq/Sz69RnwAZcifJn3i26m+O5mhU
	 0URGlNesFA5eapqpSLjY6KVa5dyZfV4APektvdCbDvb85f99FOYS88189XGRPbifD1
	 W0omzQEcnYGsuQ1TKsJLtvcBnEwSBkscnG0MsIaUat+dGNEQpiRWUnRdAbxl20JC1Q
	 lgxkcDWozq+SkyuNKIfOn+8hD9NqKy6lLG0XRsAe3vr7/As3YyxP8HV8uXoMyRTBhc
	 c5yMwVYWzPRxfMqI2owFIgAFPHrBIH+nlek0Toj42LBf9JpIsFVmW4NVOjbmYD68rk
	 WJd2VV+fyPpuw==
Date: Tue, 27 Oct 2026 18:29:05 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	victor@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
Message-ID: <20261027182905.GQ257209@horms.kernel.org>
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org>
 <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org>
 <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
 <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>
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
In-Reply-To: <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>

On Tue, Oct 27, 2026 at 04:04:34AM -0400, Jamal Hadi Salim wrote:
> On Tue, Oct 27, 2026 at 3:44 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 3:25 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > >
> > > On Mon, Oct 26, 2026 at 8:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > > This is an AI-generated review of your patch. The human sending this
> > > > > > email says "Hi Jamal, passing this on for your consideration as it
> > > > > > seems to have got stuck somewhere."
> > > > >
> > > > > There was nothing wrong with the headers this time - so not sure what
> > > > > is going on. A bit frustrating.
> > > >
> > > > It is frustrating, you are the only one with these issues.
> > > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > > >
> > >
> > > Let me send a repost3 - will take the opportunity to pedantically fix
> > > the commit message (no code change).
> >
> > BTW, checking i see the threading was:
> >      0/2 cover  (root)
> >        1/2      (reply to 0/2)
> >          2/2    (reply to 1/2)
> >
> > I checked other postings that didnt have issues and it was fine. I
> > also found the approach
> >    0/2 cover  (root)
> >        1/2      (reply to 0/2)
> >         2/2    (reply to 0/2)
> >
> 
> And for repost3:
> - 0/2 (root)
>      1/2  In-Reply-To/References: 0/2
>      2/2  In-Reply-To: 1/2; References: 0/2 + 1/2
> 
> I am sticking to this approach going forward.

Hi Jamal,

It's unclear to me if the threading relates to why the NIPA-Sashiko review
of this patch-set didn't propagate to the ML.  But I would suggest that
however b4 handles threading would be a good approach top copy.
