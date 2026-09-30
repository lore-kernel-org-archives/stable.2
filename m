Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2564F30EA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774209; cv=none; b=ME2VqE9H9+JeX1lI8OftkxTGZvoYLa+1kII0Z1UrkNOK55TvXvO6edFS3j5cTEkZeMKKxZy+KY7pOq7ynY3Lz9SpoyxiJtMpxpvAioHwZK8/7xtrRO+Mbe8q5VAMOj0wuPolvbcUtshoWnpy846ILqOFueI05yM2qCm5No/guBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774209; c=relaxed/simple;
	bh=voCbI5wKXXF1sLaz3SUAvDICjzy+5K3oZ8U0YjRVdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWB2exX10bByDQFNCcVxjArOFoyZvmBcLjr9QbbmhwqqT47jWgLY62M0olW3tZ+qh2mEhq2AY+nJkyR0YzSWXUI3NZn1WNjFZ07KqXd20/5QzzBI0IiBUdS1AYKYs5TMU0neeOKFoHmb4wpDu4n2CZ4JbczAI5RwwKG5x1MxiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Xc3fNMJ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNL/+TnK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Xc3fNMJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNL/+TnK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F3197A070E;
	Wed, 30 Sep 2026 09:16:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 09:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790774189; x=1790860589; bh=mnhDsELCKz
	BhWhQx4oAuF78EZ5APJytvgeEXdYeEiNQ=; b=Xc3fNMJ6ywD/LBAXDY8dAGiTlT
	53SP31iAQ3vE6TyJsCNdZPgJCqFrRazLfjJo7wvxkqv/fuxMnyLD1myeeI7ly4IO
	pWJ301P2bEhQQUIwOptlLrnGqpmBk2jaWlAjWyff/74GvfQnXe0lQse5K0XI7YvZ
	DuONbO6PxJJLdnXsJOfuDlk5/PagLa7kdS8f0qsLCvXy+P566Wc4ZLUh+yMc+taZ
	qc9AjMWmtLMAVzobIxjbSELEKA2ENSYUTHKEnWvetNsEM6SemwBQsPbzRhmLzWnD
	XmWJzfuzlVttOQ0DA2GOkdd7b7XD1KweZfK+sLT5ytaWwUwMcfU2uqf5BxoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790774189; x=1790860589; bh=mnhDsELCKzBhWhQx4oAuF78EZ5APJytvgeE
	XdYeEiNQ=; b=bNL/+TnKcTLi0mELRWkvmzJ75gS0pRSDEqw6hO32udOaWE0B3f9
	lGlHid6P6yGHCQ/+0ihd5zyDoCOWTM+Y0VINMuFBlRdWA/pU07NVU2tXV7D/0SoP
	JcHQV69iIjNzKPiikKhKbcY1+S8iD+l1j951hVFVVnxllfs1wNk6lv4hB5bk2SAj
	G8hrV9zNu253Za3ynefehWngCZIRj0UjOogOJFOmHxjtqhT+4lYqWSY0CcPJW7XO
	/Ze+w4KAc6XejDXh3khVutVUv0jKW6LUqTmXFqV5ED3aUMwZFlodv/rI2KmrjtuW
	ElbzyOFR1Vcqo12rW6N8BmvV/1amVSX33cw==
X-ME-Sender: <xms:rQu9apsKMXklSxs2hBVfAkc48snlnfZm_zIAS3CDBYIkkew40UUgwA>
    <xme:rQu9anoNzQqLlo-7NJMGTWH5fN5qvyK_S7i95U7eTeYsuSUoBir0P010_A1013D2E
    cOarRrACBrOaq9Hvcoa99oZzXU4voEEPF_2OaxL11Bcd3g1JQ>
X-ME-Received: <xmr:rQu9agLhTCuVipJ1bcnC_rI3sh6OtS_jFO1MsLlYYjmfnZx9NPIb4UHcRbfHY4ES1b9zasrUd5vTyVQEPEdut9uHSIj39Iv2HyhNbFjAiNU>
X-ME-Proxy-Cause: dmFkZTG2F0ywl02x45prMRdeZnxza9poDQVTqyy4pBCmz9satG+pYG8YYIlGj9elImgZac
    yXNSG/duNheMJ4x3QFjmU47mubwY7Mvti/1E+jlrsxQPHOtFtWgWIQyY89F6rudX2tfScH
    vTRfhCs+ovOVEv9ZWHJ8dwInyDBEfcvk9+vvSWUohMyVoZb5maJ3vl09lCu4fDCVIa8mmu
    4+pqZWTzsCI2UrZsdkUnuV+aApNXcAKjbPwCYe5NT86LV63p69Bx5qVURzShnqwkl1LD+7
    fnc+3Djf/UVKWxSER6tzbUWfEL/3slFQ6VqnykudjeyInxEJSP1zRxVQJAgikvk2R8T5ne
    QK+xAfnOokZKDAvztNjaZjy7ZVC0DmRE/CjgJp3j2zkirAstuGnoKYiGa4Hq7tOPDKFmw5
    AdBPEsqBlqnq8bPE+8GyH8/LuNSuvBmP+UDjQKMe5q9TTNJh4NCtf3r9HmzbCxVc7f7sAz
    B2NMyVd6a90VDR405lqq3N9jKMrDaqGfNyauKzqrEX8cka7l0LSb9d5AM8BgPVO5uv9TKd
    R3QC9DzUNmlJ3RScn5w1Rd1Ws4u2v8SVxMLaM+9Be8ZnFxx2us8egRx/rZXgcr1DICJsY/
    Fdfa9PIhW9I8K/acrNjj5wCTyzsuxZrkJTlZU1mwFzJmIPM7czczPt6b8msQ
X-ME-Proxy: <xmx:rQu9avvY2UnCiYRZNfsqvfkQZgljHux99BOTyMNOkuLgsmN3XNvwew>
    <xmx:rQu9alB4kr4kHFFKWkfZWS2P1LN1ECzLcXt0W24nngY7YkGPTUd5sA>
    <xmx:rQu9av6ZFUdeHiLD2ULHiB1roI2uAhxVlRn86MmKofqZ75Q20eTSCQ>
    <xmx:rQu9alBWcClWN8GmMP6wQPYbHJRRNgAFVzvJ4aswjq0NHEyNKOlhhA>
    <xmx:rQu9ak_IOOzb7fPeLCznkFyRZfmzcYR087WoT-1nkp6FoQK9nUA9Vay0>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:16:28 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:16:23 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>, Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] net/sched: act_ct: remove 'add_helper' dead
 code
Message-ID: <2026093010-sauciness-lego-14ff@gregkh>
References: <2026092956-canine-emblem-38a5@gregkh>
 <20260930003021.2941963-1-sashal@kernel.org>
 <20260930003021.2941963-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930003021.2941963-2-sashal@kernel.org>

On Tue, Sep 29, 2026 at 08:30:21PM -0400, Sasha Levin wrote:
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
> index 8aed25cad9eef..e1e4f18d3c461 100644
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

Did not apply :(
