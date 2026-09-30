Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE393E410D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770574; cv=none; b=f7G9LBCkN+loOZEtruoxZdyZpbUBd5syvCzXg7rRc83TR6OSdM7UDViR7hWVkipIRTU+4UZoWx2rW3W5t+O+dg+0gZpmcgrsqjzXILqRbz8zJyR6dv7L4PeOsrJLgeZltUPp2eKlivJLkmoOAYJ3Lkhiiokj707ueplkP0+5VNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770574; c=relaxed/simple;
	bh=evpMRTLjHStSr0r+igJRjIdHZ6IXkukufgTebdFF0ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ/2RwH6yRo/vWtbf+JDTcOuwSnlrHPOSiCT9J5KcxbLnpa4x+mPkn4A7uhDQUPpiU8omKhiuFaaLUu88XYf/8I2/uvw6AmW/SkxddbV76e7zQeErVdKrzmKf3L2E/6+L8b+1/RgnZc6hlOGsR5m0KJC2NFfNQT9Mqf20hL+is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Q/c1x3ZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bdm/yuPf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Q/c1x3ZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bdm/yuPf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FA257A079B;
	Wed, 30 Sep 2026 08:16:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 08:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790770568; x=1790856968; bh=ZmHZEXDUZF
	KM/VaHVhVkQO2leXhRRiedRkNoW0jWPwc=; b=Q/c1x3ZLzb9eiLxFbY8TYUIlpC
	VTO/pA+Ogae/vM8U6SjWfJgMm0+E19/PS4SJ6roWJhY69YnVkB1ELhpIH/70mgWN
	+bpJ5QeQ53N/6yq9R/vUkdk72XnH+maaOjAjeDICC2Jxmy8CfHmSpoK42pPFCy4X
	eX3IoMIumqfyCiLBzSXwvjvXo/61P2Hi0IPOMyVhmoXzPEKFu6RJe5NvadXQv0Cu
	1v5TScQGv+IAz/SOm7M4gh1YrKq4tJKErVl/pTNxVTRQOwCBILMWyOtjovRBXOMs
	Os2B4Ul+73LmRzDcbeVaK2+8rb79LZZbLgSP6TYW+0eMWnGze79dKJ6VUHMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790770568; x=1790856968; bh=ZmHZEXDUZFKM/VaHVhVkQO2leXhRRiedRkN
	oW0jWPwc=; b=Bdm/yuPf/jawGKjOYBo/qcSDmZa/gk01OQebP7zd0hwyeTibl4E
	MJzJvSZO/CSkfN6we3Xcdr7wrDVXY57/sDnamQa+F55YpKtWiHulB2+mwK3D8UFQ
	ngUgVwqMvefo3Vcvm6+WXdauuW83DjAYUUychvCVTckPiFbYSCSGSc8toYuRrikP
	zRrMz2rB0XtOEMPG/WyCaIMl9To92Ey3wN4EbP4dQ/M4pVCSg0LQkykcBWFpllYp
	XYb+V6EUx++89mMvRlcx3eLW//cq3hxNfOyA9vhP2aO3VRSAKhxljSkMCywfD2IR
	qVSyzJ2hmczpSlLJVYRLlH868Zuah0tlnng==
X-ME-Sender: <xms:iP28asxoZbQGgWWnbAKrcY6np_0QjhRv-UP8X6QkR1oXMMvsnMl1Ug>
    <xme:iP28alcu5Z_Rhj2-X6mxLIG3rb6RB3vCT3rKxYIKnF7REbuqDtoFBcdS9nYj6PC5Q
    s2x5VPcv4X5UTmZFOdM1EgB3lwsT9n4uBOsjjzn2kYitLkTNVs>
X-ME-Received: <xmr:iP28ahtt1UX6MiFFr2MjBsT-4Jj7MRD8xq5PPhouR9kY1yMVmtcnieUBTqY53mC6dZWjBoJCakZvJ0l6Cjw9Cg047iaThP3MBQGY9kH7Ips>
X-ME-Proxy-Cause: dmFkZTELsU0zMqGT9imUbC7bonO6sSeLa5HcevSU2Es/G+IEtlPY+Jz6EV0UMgKrbiaAJ0
    1KAOXRfEiFBjo1d9ywieXA/DOeJWTNGanxG4330/8tXq02qTNYsLTkvrGCFpcKD9zvbN7Y
    7iSe+3hIHVQNbtt9HClKPlikYmQEJ183+hOZUiXofEsldN0qLn7KBd7F4EzNL5ojd0PYkG
    voYLew14f7Q7gHtZYCsavB2b2YRrnfN1WztIq0TGq1DZVHA9KeMcZ43ogS1/neCq4WR8oi
    K7mKav9Lmc/ls/cl8HJ8KyGqzcq3tvAfGLKW0uo2lmSc2Hdsps1gmrSuDGLRUna9kdSvJq
    gYyu9ukh3qEIUgG8sif9WwhBsVSV8U3gg6m5aWJ1qzm2GFWEUAyy81rN8pNmQVH6/xoAsE
    OAapdddLUlyuzB1cY7DSrNKdTuHSnCe5JZ+FFuWgnx1WjHiVDIUaSLlXZCUyYIzVvpArSf
    1yUFmlczURhJrFzKGXPRiJ9gKECU/XeZ/qTKfevLq4knOYRJqajM4Gqx3Jlhu01Cas/2Ss
    mVqc/TLT5xmg0fRoJBfW9pHOIgsojqvt3PE5ysWP7OT+MlDeuus+wxKywEN+peAeojN3of
    muYc2KYzbwgAfrzYcvhjP7DaubNMQE/sAjGItGQ/IDp689OqH/197ihj7tAw
X-ME-Proxy: <xmx:iP28aqD15xghvLVU2vvFFw_EbB4ZGe-y3Qrc0EdfiMGUflYlG5dEjA>
    <xmx:iP28apHobBPvJQaZJDkj2pyoC_o-7lPDtp8r2WNrc0If3WwuKjNdmg>
    <xmx:iP28aqvL3YKH1u_jE-7Rf9ed7e0tS8Z-Z3hNIGmA7LYhhSmgFPFlnw>
    <xmx:iP28avnqykt9cX1RfkTeU9mA2SHxG-5J1E5kGZ1NHd8yAVZvDLu30Q>
    <xmx:iP28apjjj6ngPqfFUKH2FJ6tM46gXV0PrjoGlJqLpl_1CihZdHrLTRf2>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:16:07 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:16:01 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>, Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y 2/2] net/sched: act_ct: remove 'add_helper' dead
 code
Message-ID: <2026093052-late-daisy-1cf1@gregkh>
References: <2026092956-avalanche-oversized-b625@gregkh>
 <20260930002024.2934218-1-sashal@kernel.org>
 <20260930002024.2934218-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930002024.2934218-2-sashal@kernel.org>

On Tue, Sep 29, 2026 at 08:20:24PM -0400, Sasha Levin wrote:
> From: Ilya Maximets <i.maximets@ovn.org>
> 
> [ Upstream commit 00df72e39f306e2f7adb68528a5c92109da6a0a9 ]
> 
> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
> 
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> Reviewed-by: Aaron Conole <aconole@redhat.com>
> Reviewed-by: Xin Long <lucien.xin@gmail.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Link: https://patch.msgid.link/20260921145655.3167436-6-i.maximets@ovn.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Retained `p->ct_action & TCA_CT_ACT_NAT` in place of the unavailable `nat` variable. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/sched/act_ct.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index cbac27ba76afc..a9ed504a9d020 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -985,7 +985,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  	bool cached, commit, clear;
>  	int nh_ofs, err, retval;
>  	struct tcf_ct_params *p;
> -	bool add_helper = false;
>  	bool skb_is_ours = false;
>  	bool skip_add = false;
>  	bool defrag = false;
> @@ -1081,14 +1080,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
>  		if (err)
>  			goto drop;
> -		add_helper = true;
> +
>  		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
>  			if (!nfct_seqadj_ext_add(ct))
>  				goto drop;
>  		}
>  	}
>  
> -	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
> +	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
>  		err = nf_ct_helper(skb, ct, ctinfo, family);
>  		if (err != NF_ACCEPT)
>  			goto nf_error;
> -- 
> 2.53.0
> 
> 

Does not apply :(

Same for 7.2.y

thanks,

greg k-h
