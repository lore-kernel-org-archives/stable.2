Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654E2BEFEE
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013856; cv=none; b=iH1NTq42nxIPAVFQuQMhXaxQSRN9XBrWc2GsDjN1tk65bAjTymnmLzWnEntvNbx0Iv9tNBZZZoMJnGN9/LxN26nBFKm5P6KAKppx/JisZaE334wr1B/MePAmbr2a2GucOL3BfRedF59HMg9lf/xXwVxh2+EXGKpzCzOlG/gsxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013856; c=relaxed/simple;
	bh=Bbrtc7fIRJL9oQJHVUda3GqjeRlSFnsFG4LgeUNF+jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIgROwdqte8NHpSzN3UrUXri1tnbGYZXPXzDhEnW0ur6Z5GvHcUphggVwi+bXW9WFs9cdu7U6KTG5rITOv0BOCn2n98P+n4LNUd0F2gJFTq/CKCDWPYbHzfgpY6p5ZLUzmvE83lHZENZ7Zcnb6Z7gW6fwuHib7KdKd4KLqnD3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lnK3UWrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUZ4SWoV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lnK3UWrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUZ4SWoV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F4317A019E
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 03:50:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 03 Oct 2026 03:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791013853;
	 x=1791100253; bh=CFL2wQfl7ri8ZAK1IuL1z7B5xJUbz9wBZOBMW0z7QDo=; b=
	lnK3UWrLaP0QQGwpqEciakSqe2egCBagX/D1c+70Bgs/RL5reis0XYHPuUa5/3TZ
	wNY67sBpmyegf5PjkhN3P+lDX0xhKVbyqD6a9F0/3iRJ+/EDKxLCjHTp5pH4fG5T
	gV5+mJDPEU6nT7HGk/5baJujPD0zTq+jzH7MXQT22kICPUpebEkGZAxWg7exDyCC
	QX9OLilWGuP9K3sl/fXYjqhlvjq5jEGbeW7IajlXsjnxZil9EEDMygzVUmfTzNjd
	bi/4Jlla2/w9jLABqn0BppwahKsgkChHGpeUM66eckfe/KBWwOFFwRWM/XuW850D
	eC2TrCujLClSfNKyo29/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791013853; x=
	1791100253; bh=CFL2wQfl7ri8ZAK1IuL1z7B5xJUbz9wBZOBMW0z7QDo=; b=J
	UZ4SWoVUiaL6g3gCawWLMa1eVpyBU98l1LFbJ3gQxd6h7frnDCG8LcKWSHIr2J/e
	q+IuU/121+pcIE2ze2LgTkTq3khvZZd5tQFbi1LuKAw+zZKsLo5dCYWM+yfzp5gI
	DYrI2R/lCOnYxMPhLySby/ykOGYhqXMuGWNylOye0XdlgjV05SOx1nQ4H9sXuQkY
	fg1QyOtJLE7wmemXuSyZE5FGgIBHl/IHv0RKzEkSqFs/g94mYLdjwuX65dMpFFii
	rHky+6WCsmiIHJ/h9JMeB2Uy6m8gr291m1RLtcLt35v6SsbqC+vCASMoiNwvjIgO
	ls9icHLR8v2GJZm6OcYsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791013853; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ecnL7tCGcCGCksEo/W2k+G1ih8zKlzYml15xGoX7vqvS4Nl
	8mrmlxk7Ts1mUmG9mys/qWUZIxh0GtrZHU6iNYnvwC+51cug6scLIisCFMudz2iT
	+CqJB5Xss63TIOYAIMdeTtzJSnARySDJhv9crBOjDJ0w3AYJPSmHWPlMrBYbgp0Q
	Pi/7/YVUkfmpRQAIsme04H/rbzg14Fb/y3HOswAGYjl/1qGMa1Wpohx15xEaihpL
	eH+PSooXYbg17bdsL0VHLxzRPko37jrzAW+bf3bv+lqAMQy2A+g/+CrQ3E0lRTyA
	HjE8DriQCElMZ+lP+kHizyJl3UR8CfgFtfNMvWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6PG6rtdArhczy0ta4l+B5lL7SAXFG1XuOajjGkaDouU=:Bbrtc7fIRJL9oQJHVUda3GqjeRlSFnsFG4LgeUNF+jM=;
X-ME-Sender: <xms:3LPAau2YbCppeWYz3usqxBGTivN1mcasJ3_KI9qWenX_SI-muWkmOw>
    <xme:3LPAamRSnlKsND6R53dgGvc92ISQQRPZGit2SxOu8mbSnmLA8oPz6zfsT3qyRFaOd
    JM6FrkK8CI5-7-nW4F4i5mfjvUQGAGJAWQ07z0tw8SASHqgMv4>
X-ME-Received: <xmr:3LPAaqR0CTch1_Qqs_ZLjUzykgcdegyNl6K8EiL5aCYa8MOaZx-WeHRUvkgWu1KfjUDk-xHUwy43ZoEgD2doxaUy8hD99x9_qVuZXqJSh70>
X-ME-Proxy-Cause: dmFkZTEUbMTGU44+APWPrgHDwYGtPQH5SyL1umTwYUpL166Jx3XipxeTg23X0OFadvnLDN
    AerjvWGdc70X17bpUC/T/bk90h432lOdH8FXLvcHGHPr8SV6Nxd2l7b3j5Z2aYl+AOMOLG
    sOcvbG2apyFhdsdwPUrpEvxocI4jKxNp2eAt/tbCqrjRaiQ1IknQJnVM59ZtwmkCZkyK8G
    Hw4UscH04WD5ZhDbQBn0l3AQ4Yhobv3ilH/3haO1kimM648IgBBUZ1ovbkgnbKwOjKeIDT
    CD5Izy70Cv6cI7skY7rYtdRR5lAdbqLSrgyosVP6Of0GROwTi05VRdq5b7bU5WkZ9ekVnr
    Pur7OC8OsvJPdxVsykbfUC7afaWJvgVGtrAniZt3wYEu/svzEZHQ0kZDHT4yKFA2/eAuHG
    59UwSPKFqvHHXroP+WbBlff/JUiTh+CJ9XUaxvkcUQomj/ApQd9SM+jI8il138SXFiz9dQ
    ixZt418tdtP8GguXqSwu9UHkDQMu4Tm8WUVoAfqoNa8a3xyWTy0tJHa7iNQnDzvaZK9Uef
    ZCwqwsGRHr+5ZQ7wu9UM33rdSarpDotBglS9lm7ATg8QosxWTQw2BQxUxz7WrTTDcGw1Zk
    QKHnePQe99lpXZ/Nuun/B5kQkhV2bGoq7xTbND1u5c/zpuloX3T8JrtX3low
X-ME-Proxy: <xmx:3LPAavVAIEslqBmJ_5ICgP7wZTGiScKsbCDNfjUTMf7idHQkGGhneg>
    <xmx:3LPAasJZbzHfnwqQC2LD8mxnesrRlud1olzBJAHX28WRUnX8apwegQ>
    <xmx:3LPAaogDxlIZk7TOC0SBhe8P1J85Y2AEMm97c6PRvz9HcGxYb-WUmw>
    <xmx:3LPAahJCl5k3uPfanrCdO6FLjPoPD7GQvYq7TKBirPv__qbCvx1BrQ>
    <xmx:3bPAakHe3mU8tI-tAS_P2lhTgxfCN73qFlUJWgepMIB8tFgh1AHKYGjb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 03:50:52 -0400 (EDT)
Date: Sat, 3 Oct 2026 09:50:49 +0200
From: Greg KH <greg@kroah.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Deepak Nagaraj <deepak.nagaraj@baseten.com>, stable@vger.kernel.org,
	mfleming@cloudflare.com, Kaz Kato <kazuyoshi.kato@baseten.co>,
	Stephen Day <stephen.day@baseten.co>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
Message-ID: <2026100327-shrine-refusal-0488@gregkh>
References: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
 <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
 <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>

On Fri, Oct 02, 2026 at 03:10:57PM -0400, Zi Yan wrote:
> On 2 Oct 2026, at 14:34, Deepak Nagaraj wrote:
> 
> > Hi Yan,
> >
> > On Fri, Oct 2, 2026 at 10:38 AM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 2 Oct 2026, at 13:25, Deepak Nagaraj wrote:
> >>
> >>> If I am reading v6.12.109 correctly, split_huge_page_to_list_to_order()
> >>> calls xas_split_alloc() at mm/huge_memory.c:3524 with xa_lru unset, and
> >>> now with __GFP_ACCOUNT. My guess at the 6.12 equivalent of the
> >>> dependency is to inline mapping_set_update() before that call.
> >>
> >> Yes, it is probably needed.
> >
> > Thanks for confirming.
> >
> >> Why not just export mapping_set_update() to mm/internal.h like mainline?
> >> split_huge_page_to_list_to_order() then can call it directly.
> >
> > I tried that. On v6.12.111, mapping_set_update() is static in
> > mm/filemap.c, so split_huge_page_to_list_to_order() cannot call it.
> > The patch below moves that helper to mm/internal.h as the macro
> > mainline has, and calls it before xas_split_alloc(). With that, the
> > 6.12 split path lines up with mainline.
> >
> > I have compiled mm/filemap.o and mm/huge_memory.o for x86_64 against
> > 6.12.111 (defconfig, CONFIG_TRANSPARENT_HUGEPAGE=y).
> 
> Have you tried to run the updated kernel to see if the crash goes away?
> 
> >
> > If this looks right for 6.12, could you Ack it so stable can pick it up?
> 
> +Sasha for stable kernel
> 
> Rather than picking your patch below, I think we will need to backport
> commit aca1f2d5de17e ("mm/huge_memory: initialise workingset state before
> folio split”), although the backported version might need to change
> mapping_set_update() like what you did below.

Please send us the properly backported, and tested, commits and we will
be glad to queue them up.

thanks,

greg k-h
