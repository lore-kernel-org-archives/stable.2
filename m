Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB03FAE19
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355327; cv=none; b=mADb0Yl2VoIZsDucYkV8QgXjdH8bI5lxykOTu5fKXpJeXCzq0Gpm7MBgr8W7Ch0K1pIrE39U8yOKirQmmV0rY6a7llN74Qrpcd4y8T47OOnswQqOQrUd1lu6N9Z6IfYbXrkmepdAd1cz275EKU3TB+6nTByBwQHHogOnOinzmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355327; c=relaxed/simple;
	bh=v/By3/SQefKJhbmNpD+pYdt+UTZE0DvJkyHNpncPe+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF1LPw2dQ9fpLrj4TGUQMzjmqfDgwp0oCuDv6udSSd53G7lBhAE5e01Lt8dzgTtBmSiU1T/j0pnv9eq3aciUp6F/9HniWI6ZmciyNLwm62sUOjZhY8g7WsHRcpORuWH/WgBMVOUE4U9XD/5l6gaXnkSfHS2LpysS4FZeajgvfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=SOrXdbSk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeEZhqeR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SOrXdbSk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeEZhqeR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A7251400149
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 02:42:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 02:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791355325; x=1791441725; bh=N5Me2MggoT
	sUfEsK9KLrVZMw7dJ1cF4v2wx7Rs9UpJ8=; b=SOrXdbSk0iezmserl0dcswH7y6
	UwKhWImtQi8VDZ5QwEIXek9sEPT6IABKNmM1W6gGCenSmBk5rgghNDWHiH3m2YOm
	qJt3sQAYhtkqP65h2XIT/cjNYn/UfoUbpNZ25D1AMrtEsTD6/W7bHjj6LDpP4hm8
	C6akyiXbJctaMJDEDzEV+QJ6iXhV3wlc59nO5r6cK1OuDC0W0zmYBoSDtW0vmTeK
	2XVb8RSrzoWEc3jSRPv6ALn8cwBlaoJL18C/w4nrh19QqTZjyXxD6SHK6gONHh1T
	X1dyV6+VRdJ2VNAd95wCwQAsHJpIF4Yh/4hLNkW5KwhP5xyQDRimO1gAVccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791355325; x=1791441725; bh=N5Me2MggoTsUfEsK9KLrVZMw7dJ1cF4v2wx
	7Rs9UpJ8=; b=PeEZhqeRneUeVDp/9JqDN+TzZ+wex1rLSqbt3L2Tibfej/cuPeF
	FWZBAhpZ9GBeVOvnVu8w+R73vX21eLxRjh00T01jgVfclmSWkITm0digGSNFpT1H
	Axt9FyE8x0ZdCfjbHu77ZQSxJsOsKkQGU6wUhf03CWyOcuI4cEMmYTuXtUlyCgDN
	fIPqicjlJiepuu3Zvy8L3MkQQJ84lRaEdbbWOa5/ZU0RbdKE71ON7eUORIHrgJ70
	+Wd8JVhIWMctLt4s5n4sp7aa5f+8FbqYfA55cz2ZOXYTwsdIIQSb9BnxboSHSz37
	eb2Kc99NQbGD71+kUIoxYfyy7RxXDpacjyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791355325; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O8UoGIC3RXXnWdnE2I36XZ6BKWYz169EQG7BoBzw4UwhW6X
	l8RhwveAstUpSg/JY8+FKUuW5NePyreB3SJAusBqzXvgzN1WlVQvqdl85AggBLK7
	FYAySN7uACUyKI7K97LFiP+Gs6UzXNrOz3l7QzmkOZUg6d6j18vF3FTpDmS8h/DS
	ACpdWJBVPpmonlh+xKeAhXaZ7x1dYy7NIHml1SiCZwPZi2r+2uA8uI5D2S/qKdty
	BAS2N8WyZK4/auF3Y+XX43jnjVyJNVMA5ws4l5Ieim32CaXf0GkoEZAJk5VIg70h
	VcalWYVPV0ZSb1cVzBtGgNL8hpzaBaHPke5MTEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yeXcqqR99MhKHOXIgKVTPebSGllhpkmLw+ZB/ZfWmKQ=:v/By3/SQefKJhbmNpD+pYdt+UTZE0DvJkyHNpncPe+g=;
X-ME-Sender: <xms:vOnFak_MMEFjsviRenTBAjWMHVyXa0ht229OWKoTGiP2G1dXLfy-1A>
    <xme:vOnFaqHPR9D8irdSL2vJhB3GyhkKiim_YIGCGum1lfVCWb1nOytEaWltNnAmdwDzV
    SbDQr_48XiC3UhL0FWlsPmkVM1gdNx1pQ9Vci-1uZAriqHrpBo>
X-ME-Received: <xmr:vOnFahWFjBLMUISeqn1BDiluOPPsu7mFzU26lrZyikCePPw8B1EHIgk8MGTkOP1Uw2Jg8hw3J7odlA>
X-ME-Proxy-Cause: dmFkZTGhKIakiYU0wkTPQZZSpApCfBhuZ7FEq26An9e3QyOOmw6tSgPmvAMuQIhSklrkbV
    3jTvSHo/pY4oI7wNilvxa+lGuK1VL/Qz9e3GEH/l9d3rbLOPL6WuQk5IPigMyDqx2uB6sj
    ILl4z7xGZPslOKgg/NNipLJIAz7lygRQcHSCAyDosJUhORm7wtiLBnjcUeDLXQIdYQmA+z
    FqV4t4UFof8NR8QTxOlrUJqf2gIfGh7W6TgKjdC+bJ49MgxGgeuFDE3Z2hj0cfTW1gDuYP
    PMeDBKi5+IxIisaO6Z2UtBWLGJYw2bmz7UMhgUbhn6zlXYcQoeixvKJGOvu/4WulFIvCmA
    gSMuwdnrb31CDPEyADW87Vni1f9lLDDLoe7kuVXszQTneAS3yQsw4RbLbg/JH8cBGu2m86
    Yd0Er6FvY1xUuVQw9IFh6B9I9Q1E4CzZab3DuT/xSGFRIRZh9K3wrlA5y/SAEYXuXrgTer
    cAsvX6Zi4j+r2kgPIykTdom0zKbatxmYWk1g3LQoqIqAm/hf4yzO9deLyzIz22VJqI83pf
    EkwebhQzSHmxrs88ZYdQHkf8KlSt6lys0tL1bOM9OOKjR1/jMZ0MzeFibS3HSGTYR4Jheb
    LNlCt3NsDUys2pGE1vMOdxHbnEoHniM0fggu064pI3qs2mhrKFggZ5J40UrA
X-ME-Proxy: <xmx:venFau_wgZ6nzEPeZ0vvuEGOf17TDUj6IVgc9I2TMnNtWp8900b48Q>
    <xmx:venFam5gkFyR1b5V1ZtRNS7oY920lcTC40zIf3nmJjM1M11JC3_r9A>
    <xmx:venFavmk_vL7aeGccl8f8KtzJswlf3xjRqPqp9kb04NChIqtAvr4qg>
    <xmx:venFahF6qKQh86Zo3oF5fip1qIz1kJ0tA1ufpTJRMxjMoqvRjSfXjA>
    <xmx:venFalL1P6H26RzokMk9_SXrDnmac3WlpCV-3bm0fHlCHvQD3OPI-haa>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 02:42:04 -0400 (EDT)
Date: Wed, 7 Oct 2026 08:40:40 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>
Subject: Re: [PATCH 6.18.y 4/4] KVM: x86: Fill kvm_run exit fields in common
 get_nested_state_pages() error paths
Message-ID: <2026100736-rack-shimmy-fe09@gregkh>
References: <2026092938-celibate-sarcastic-e56f@gregkh>
 <20260930153934.2895211-1-sashal@kernel.org>
 <20260930153934.2895211-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930153934.2895211-4-sashal@kernel.org>

On Wed, Sep 30, 2026 at 11:39:34AM -0400, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit c1214f293d77c6e425a379f90d09bdb4815993a8 ]
> 
> Fill kvm_run with "internal error, emulation" in the common error handling
> paths for getting nested state pages, as requiring each check to manually
> fill kvm_run is error prone and requires a non-trivial amount of copy+paste.
> 
> Specifically, both SVM and VMX fail to fill kvm_run if load_pdptrs() fails,
> and SVM fails to fill kvm_run if kvm_hv_verify_vp_assist() fails.  If those
> flows fail, the *best* case scenario is that KVM will exit to userspace
> with KVM_EXIT_UNKNOWN.  The worst case scenario is that KVM exits with a
> stale exit_reason and confuses userspace.
> 
> Note, SVM never exits to userspace if something goes sideways when dealing
> with vmcb12 assets while emulating VMRUN, i.e. lack of SVM-specific code is
> not a bug.
> 
> Fixes: 0f85722341b0 ("KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES")
> Fixes: 232f75d3b4b5 ("KVM: nSVM: call nested_svm_load_cr3 on nested state load")
> Fixes: 3f4a812edf5c ("KVM: nSVM: hyper-v: Enable L2 TLB flush")
> Cc: stable@vger.kernel.org
> Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
> Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
> Reported-by: Stefan Teodorescu <fane@google.com>
> Link: https://patch.msgid.link/20260921211608.1030158-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c |  7 +------
>  arch/x86/kvm/vmx/nested.c | 15 +++++----------
>  arch/x86/kvm/x86.c        |  3 +++
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index c765ea1dff69c..a6b92819318b8 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1953,13 +1953,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
>  			return false;
>  	}
>  
> -	if (!nested_svm_merge_msrpm(vcpu)) {
> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror =
> -			KVM_INTERNAL_ERROR_EMULATION;
> -		vcpu->run->internal.ndata = 0;
> +	if (!nested_svm_merge_msrpm(vcpu))
>  		return false;
> -	}
>  
>  	if (kvm_hv_verify_vp_assist(vcpu))
>  		return false;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cb44ae23728b3..890ee82af35d6 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3492,10 +3492,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  		} else {
>  			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
>  					     __func__);
> -			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -			vcpu->run->internal.suberror =
> -				KVM_INTERNAL_ERROR_EMULATION;
> -			vcpu->run->internal.ndata = 0;
>  			return false;
>  		}
>  	}
> @@ -3566,11 +3562,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
>  	if (!nested_get_evmcs_page(vcpu)) {
>  		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
>  				     __func__);
> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -		vcpu->run->internal.suberror =
> -			KVM_INTERNAL_ERROR_EMULATION;
> -		vcpu->run->internal.ndata = 0;
> -
>  		return false;
>  	}
>  #endif
> @@ -3956,8 +3947,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  
>  vmentry_failed:
>  	vcpu->arch.nested_run_pending = 0;
> -	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
> +	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR) {
> +		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> +		vcpu->run->internal.ndata = 0;
>  		return 0;
> +	}
>  	if (status == NVMX_VMENTRY_VMEXIT)
>  		return 1;
>  	WARN_ON_ONCE(status != NVMX_VMENTRY_VMFAIL);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 69d48df5d1d89..c86b828ca578a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10708,6 +10708,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>  		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
>  			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
> +				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> +				vcpu->run->internal.ndata = 0;
>  				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>  				r = 0;
>  				goto out;
> -- 
> 2.53.0
> 
> 

Did not apply :(
