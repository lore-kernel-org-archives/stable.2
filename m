Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F7466B01
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129614; cv=none; b=khp/UEzC9djdUj5dQSTuX/PD3Ryxm7m6CVWE9ghQwHNMjENKDD6iNdgoW8kog1qfYEosiLM0mVFOo8lvEl29wVGQrqkpXyniGp9pVOj8oyrGkMu4mtpikuqf2tbv/JLSfPj+AClg6HhnSLQTLulylt/u/QRL0gIByr20DyKupN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129614; c=relaxed/simple;
	bh=9a99g//rZLGauD7d1zjdCirWlnbLtcQgWDCVx5HoJ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBsk1ZkTS8xBBsAwxUJdGuo+aApfNTvgnyP0uJGSnpyb3Z9D/BvJg1pj+9mfTewETCtAGbnqOXsc8diGLRRUolzkX7WT59QAj3Vx2BkmeHNTHrcbP9uoUSjSTVKADNxnVi2frTexqtr1ySsNy8ih/QM94BcgQNtnfWrnm9E8jBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=TlLcpLsA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=veB3d9fb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TlLcpLsA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="veB3d9fb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E43B67A0082;
	Fri, 11 Sep 2026 08:26:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129611; x=1789216011; bh=zKqgBlH8l0
	GR9ctCy8N7OWR4yaLGp0i6POry3hgVShI=; b=TlLcpLsAC4xOGwiLpI4EdmJuKS
	Ud3EazrHPeDrLtgBVfRvm/V2S8DeJ/n7G9/gFfJiubSuOhsuvJCETi7OgH1i9YPg
	O7NUlquFAZIzCuH1xZVI9N+KwiFxGCxWki4LNwY509VkGEX5r8bjPlfDpA9wB2fQ
	SsF/L4sP2uSVahq0Pc22Rr6odpYLtidreR5Zgl2YJK+WxNCQnT3bEwaRO3/Q6QHw
	/zzRBFC8uj3xZpNScU97toIkR5ncFGnRB3cB97T5J/Ge34hyyh4NWM06SDC1KRkM
	QCwQHo0N94DTG5bCkP6OJKiVjy05rKyTX8jPKvYJRTXHWSx6/YH+Xo+6rKMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129611; x=1789216011; bh=zKqgBlH8l0GR9ctCy8N7OWR4yaLGp0i6POr
	y3hgVShI=; b=veB3d9fbooK5qu6nhgsjCBVgrrznc7AbkDTua08WbL6Z5QwHt//
	SiMHNQTX99UTOsQ52iaQkZJhKXksVlVQchnGz7oBQptbgmjVzSxpaj0smqCLIFJR
	XyS7JPPq4TwhULa+9PMBpfy+Tk38cI23xlN+50/x/ShQ9gmj1SLIt5K22Hlophtb
	AhC1qvPnY1tD/tOW1AOFj40tzE4VsQOgbO6vC2D4exFheMbWxzVRsftvw5X5gct6
	RXgmi3GfNIDXVFr/qaulVCkYquG4aLCC1U8NpS/DKuyjaDCVCCQ4QnftrFZPx9rh
	xhhl2bQuOJgGw5CzJoT6UI/Y2FKtAwbU3VA==
X-ME-Sender: <xms:i_Ojajrkzur3DZ_YqbiImzgRrMY7I7odohbSj_rY8ewQaSQl5oDi5w>
    <xme:i_OjajLfJdPJ4JPmqrFEOipNNL04c2CrU_HJiWwoDTZl-WeGt9afkuubsbGyhhE5o
    A95shBSBezNI2ZXdsqOrHcX7tXE0nWxOWkLdVAXp4KfW7nPNQ>
X-ME-Received: <xmr:i_OjavTFvTZY2PTrVVSEF8RrRwBiZAvRrU66iE5bnJOycHVkMYWWcCAFVOtiyopwqvPWnKzHInRrvDt7LJuOTMLIiW-R4gyIwBpP-RbM5QY>
X-ME-Proxy-Cause: dmFkZTFrUphpIp6FBFh3He3o0SU/PnnLbdCPfC+D3KMFZmbicDXQ2h9jtgLMiHMf44cs6y
    Q8XpOXyYEYtNIK7lR/ucfXtwHJ+btrhBWGblF+ILgLusK3szk1HqbrYg2zukN0zZ/jPb85
    hXUZ+Tk0EwmCtv9qAABo54NdMrpPjWpFdNQdK4945iELUjt8GJk8EPiDn0OE8J6vSmKICo
    2PD+CZGD1OgWzshVw+DxvYRK9wXvifSLi8FYIyD0rIzVYA833K3+KwYMcg4UG03lCIi6uH
    kIs7u9Qq7j+M5mLiRxhYy9jxzz6Vh8pmnTp/SIEtZyODFg3lNcC/J+l38FU6rwVH1t81tB
    xsd/PT+c6ZBo66c7Q5nWRruwOzjj4sFLZGnrILFeb3WY1a8h+NcUdioQFMsEHhIAN8ilAU
    ZQPYmwvusBIx9Tzm4YQiK+03HD2KZ6+82JzVn98d4Yln3uzD2RYuer/LQjnRUxGYYQ+jKz
    YlJwUS5KlkjNIkJ/20QzXX2ozRaJleDE6mgZ4RUdsIapR5tX6sl2TGq6Q4jULXIszWGiMR
    ZIwhMBBt7o2Er1Gm0p3YjOmvEKeCNcUyOmqujh+UNZCpLf0BBC6MpQBtHOiMm8HJR6mC+y
    7j7bsKE+yZDYhOkMu4Qa/I45tprOhgxlPWpSg1UkXHX0tM6htM4z4D4ru3KA
X-ME-Proxy: <xmx:i_OjarOOL62ydMW4WuD8GajmWtnmisj5Z2JiK7JD_UJsAjnxUmNHLg>
    <xmx:i_OjasUS45AACBQdnQSLA4DcVIxCAI954vbD1MgKK_Ds9MGHmzncng>
    <xmx:i_OjamgdGFScnvkGE2OE7_Ox5DNjFWWASheiv76SeUsmxPgyvJwF3w>
    <xmx:i_OjatiU_Sn9kRYVIeAa2PXRiC8-2RFd2DQhJb20tHdu6ER7t0lFVg>
    <xmx:i_OjajHQXSLknlnT0L-Cd47XR0tlQD8JrP5FmerlIqZVVGMOLiBP1NJR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:26:50 -0400 (EDT)
Date: Fri, 11 Sep 2026 14:26:41 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.2.y 1/9] KVM: x86: Rename __{g,s}et_sregs2() =>
 kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
Message-ID: <2026091135-relive-rebate-7282@gregkh>
References: <2026090914-waviness-supermom-9b84@gregkh>
 <20260911104123.189614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911104123.189614-1-sashal@kernel.org>

On Fri, Sep 11, 2026 at 06:41:15AM -0400, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit bd130c8d72a1c7dde5523b3f3fae9867eafaa1dc ]
> 
> Rename the KVM_{G,S}ET_SREGS2 helpers in anticipation of moving them out of
> x86.c (while leaving the ioctl dispatch behind).  Having globally visible
> APIs named __{g,s}et_sregs2() would be "fine", but ugly, given that
> __{g,s}et_sregs() will NOT be globally visible.  As a bonus, this makes it
> a bit more obvious that the helpers implement newer versions of
> kvm_arch_vcpu_ioctl_set_sregs().
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Message-ID: <20260613000329.732085-4-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: e62392bf39eb ("KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/x86.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 47cb9eba113b1..55d064c89c148 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -133,8 +133,10 @@ static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
>  static void store_regs(struct kvm_vcpu *vcpu);
>  static int sync_regs(struct kvm_vcpu *vcpu);
>  
> -static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> -static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
> +static int kvm_vcpu_ioctl_x86_set_sregs2(struct kvm_vcpu *vcpu,
> +					 struct kvm_sregs2 *sregs2);
> +static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
> +					  struct kvm_sregs2 *sregs2);
>  
>  static DEFINE_MUTEX(vendor_module_lock);
>  static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> @@ -6623,7 +6625,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = -ENOMEM;
>  		if (!u.sregs2)
>  			goto out;
> -		__get_sregs2(vcpu, u.sregs2);
> +		kvm_vcpu_ioctl_x86_get_sregs2(vcpu, u.sregs2);
>  		r = -EFAULT;
>  		if (copy_to_user(argp, u.sregs2, sizeof(struct kvm_sregs2)))
>  			goto out;
> @@ -6642,7 +6644,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			u.sregs2 = NULL;
>  			goto out;
>  		}
> -		r = __set_sregs2(vcpu, u.sregs2);
> +		r = kvm_vcpu_ioctl_x86_set_sregs2(vcpu, u.sregs2);
>  		break;
>  	}
>  	case KVM_HAS_DEVICE_ATTR:
> @@ -12215,7 +12217,8 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  			(unsigned long *)sregs->interrupt_bitmap);
>  }
>  
> -static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
> +static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
> +					  struct kvm_sregs2 *sregs2)
>  {
>  	int i;
>  
> @@ -12483,7 +12486,8 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
>  	return 0;
>  }
>  
> -static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
> +static int kvm_vcpu_ioctl_x86_set_sregs2(struct kvm_vcpu *vcpu,
> +					 struct kvm_sregs2 *sregs2)
>  {
>  	int mmu_reset_needed = 0;
>  	bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
> -- 
> 2.53.0
> 
> 

Series does not apply :(
