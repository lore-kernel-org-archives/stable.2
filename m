Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F33B5307
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125754; cv=none; b=uw1g/jBBh6ivS3PopYWuO9HKR9D2wmmZe9wrwziMvEw2hTnzojOX4WdjO0+6FcPl0BxEpKr1n4fPad4tVJOe5zbWFK4UXk63NX9sPIornV1WWrsqd/J5rICmWhY70dADniw1zHlUEYLk/k9/zLHNdiuHZIwjbK4kc6ZOVzyOwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125754; c=relaxed/simple;
	bh=wKXhUOb8QJv18JYDD4lQ0zn76L+2Ebxocy9z9I2NsF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5PbgN5jrum0b6q5fbVRsVOfzcbbD3zz/H2p79k2R9iJTt+MvgrwT6gohTBgh09HclOjr3J3nBgqWI+Gu03xDuHKxQdT5vOfjXaz0nwAw6pIND6mhyKnyI1na3jRLgR176wQTjwwTUoA/IkJVAfzOFzW3XnA6oO7dAPIMObJKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jeOcNFUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rOQcGMDg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jeOcNFUY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rOQcGMDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jeOcNFUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOQcGMDg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jeOcNFUY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOQcGMDg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25ABE6ADA1;
	Wed, 10 Jun 2026 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781125749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oUisWKduESdoTOz8Qt4RfHWc07Vz5ChYp1HSUJ9Xg=;
	b=jeOcNFUY+tkK+hdtjOOgnJ3Y4Nnz9ZfxIQ+WLWiV0y0GeO4cnxzF8fkpaMC/RtDbW2xzRU
	Gsxdrqxb7oBMArhg6U2LfCvmtluOQQG38Zvgbf3zBrGNURVnMbFRQsmwtLTlZOLHc4oR0v
	ct5q9NTPTqbIR+byK10NMMfPLvcztkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781125749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oUisWKduESdoTOz8Qt4RfHWc07Vz5ChYp1HSUJ9Xg=;
	b=rOQcGMDgcZldiOKjvVt5vxSBnpW58qDy4gNNEM9Ce8BQmOYknnsnj7CC7Zj+FoeXGU5J/S
	ZGW0XjZmIh3qKcBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jeOcNFUY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rOQcGMDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781125749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oUisWKduESdoTOz8Qt4RfHWc07Vz5ChYp1HSUJ9Xg=;
	b=jeOcNFUY+tkK+hdtjOOgnJ3Y4Nnz9ZfxIQ+WLWiV0y0GeO4cnxzF8fkpaMC/RtDbW2xzRU
	Gsxdrqxb7oBMArhg6U2LfCvmtluOQQG38Zvgbf3zBrGNURVnMbFRQsmwtLTlZOLHc4oR0v
	ct5q9NTPTqbIR+byK10NMMfPLvcztkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781125749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/oUisWKduESdoTOz8Qt4RfHWc07Vz5ChYp1HSUJ9Xg=;
	b=rOQcGMDgcZldiOKjvVt5vxSBnpW58qDy4gNNEM9Ce8BQmOYknnsnj7CC7Zj+FoeXGU5J/S
	ZGW0XjZmIh3qKcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C6D5779A7;
	Wed, 10 Jun 2026 21:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8RCTE3TSKWr4YwAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 10 Jun 2026 21:09:08 +0000
Message-ID: <2258e3b4-3718-4142-9627-8b5451a5eb54@suse.de>
Date: Wed, 10 Jun 2026 23:09:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Raise KVM_REQ_EVENT on TPR below threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, osteffen@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <20260610185042.2810880-2-clopez@suse.de>
 <aim2_s0loBcb3fav@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <aim2_s0loBcb3fav@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 25ABE6ADA1
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/10/26 9:11 PM, Sean Christopherson wrote:
> On Wed, Jun 10, 2026, Carlos López wrote:
>> The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
>> when the guest's virtual TPR falls under the specified threshold,
>> allowing KVM to inject previously masked interrupts.
>>
>> KVM handles these VM exits in handle_tpr_below_threshold().
>> Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
>> optimized this function by calling apic_update_ppr() instead of raising
>> KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
>> a pending, deliverable interrupt.
>>
>> However, if there are no new interrupts pending, apic_update_ppr()
>> does not issue the request. This skips calling update_cr8_intercept(),
>> and thus vmx_update_cr8_intercept() before VM entry, which results in
>> a high, stale TPR_THRESHOLD. This is problematic due to the following
>> sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:
>>
>>   The following check is performed if the “use TPR shadow” VM-execution
>>   control is 1 and the “virtualize APIC accesses” and “virtual-interrupt
>>   delivery” VM-execution controls are both 0: the value of bits 3:0 of
>>   the TPR threshold VM-execution control field should not be greater
>>   than the value of bits 7:4 of VTPR.
>>
>> This error condition is typically not observed when KVM runs on a bare
>> metal system because modern processors support APICv, which enables
>> virtual-interrupt delivery, and which KVM uses when possible. This
>> causes the processor to no longer generate TPR-below threshold exits
>> and to no longer check TPR_THRESHOLD on entry. However, when running
>> on older platforms, or under nested virtualization on a hypervisor that
>> does not support virtual-interrupt delivery and enforces this check
>> (like Hyper-V) this can cause a VM entry failure with hardware error
>> 0x7, as seen in [1].
>>
>> Fix this by re-introducing an unconditional KVM_REQ_EVENT when reacting
>> to a TPR-below-threshold exit, ensuring that vmx_update_cr8_intercept()
>> is called to re-evaluate TPR_THRESHOLD before entering the guest.
>>
>> Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
>> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Cc: stable@vger.kernel.org
>> Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
>> Signed-off-by: Carlos López <clopez@suse.de>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index c548f22375ad..21a469d3ba21 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -5824,6 +5824,7 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>>  {
>>  	kvm_apic_update_ppr(vcpu);
>> +	kvm_make_request(KVM_REQ_EVENT, vcpu);
>>  	return 1;
>>  }
> 
> Don't all the other flows that update PPR have the same bug, at least in theory?
> Forcing KVM_REQ_EVENT is a bit of a hack, it seems like we should instead be able
> to do something like this (probably not this aggressively for stable@):

Right, I guess an EOI could lower PPR with no interrupts pending, so we
would need to update TPR_THRESHOLD as well, or figure out whether CR8
should be intercepted at all on SVM.

> ---
>  arch/x86/kvm/lapic.c | 31 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c   | 37 ++-----------------------------------
>  2 files changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca66..1b66c878bb67 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -939,6 +939,32 @@ static bool pv_eoi_test_and_clr_pending(struct kvm_vcpu *vcpu)
>  	return val;
>  }
>  
> +static void update_cr8_intercept(struct kvm_vcpu *vcpu)
> +{
> +	int max_irr, tpr;
> +
> +	if (!kvm_x86_ops.update_cr8_intercept)
> +		return;
> +
> +	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)))
> +		return;
> +
> +	if (vcpu->arch.apic->apicv_active)
> +		return;
> +
> +	if (!vcpu->arch.apic->vapic_addr)
> +		max_irr = kvm_lapic_find_highest_irr(vcpu);
> +	else
> +		max_irr = -1;
> +
> +	if (max_irr != -1)
> +		max_irr >>= 4;
> +
> +	tpr = kvm_lapic_get_cr8(vcpu);
> +
> +	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
> +}
> +

AFAICT you already moved this function in c7722e5e1dae ("KVM: x86: Move
update_cr8_intercept() to lapic.c"), which is only in kvm-x86/next. So
the diff on that tree is smaller really.

>  static int apic_has_interrupt_for_ppr(struct kvm_lapic *apic, u32 ppr)
>  {
>  	int highest_irr;
> @@ -980,6 +1006,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
>  	if (__apic_update_ppr(apic, &ppr) &&
>  	    apic_has_interrupt_for_ppr(apic, ppr) != -1)
>  		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
> +	else
> +		update_cr8_intercept(apic->vcpu);
>  }

Fine with me. This also addresses Sashiko's comment.

>  void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
> @@ -3290,6 +3318,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  	kvm_apic_update_apicv(vcpu);
>  	if (apic->apicv_active)
>  		kvm_x86_call(apicv_post_state_restore)(vcpu);
> +
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  
>  #ifdef CONFIG_KVM_IOAPIC
> @@ -3394,6 +3423,8 @@ void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu)
>  	int max_irr, max_isr;
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  
> +	update_cr8_intercept(vcpu);
> +
>  	apic_sync_pv_eoi_to_guest(vcpu, apic);
>  
>  	if (!test_bit(KVM_APIC_CHECK_VAPIC, &vcpu->arch.apic_attention))

Fine, seems aggressive as you said, update_cr8_intercept() is already
called before the single kvm_lapic_sync_to_vapic() use. This is a
follow-up cleanup in my humble opinion.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed798..116ce6209c67 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -128,7 +128,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
>  				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
>  				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
>  
> -static void update_cr8_intercept(struct kvm_vcpu *vcpu);
>  static void process_nmi(struct kvm_vcpu *vcpu);
>  static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
>  static void store_regs(struct kvm_vcpu *vcpu);
> @@ -5340,7 +5339,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
>  	r = kvm_apic_set_state(vcpu, s);
>  	if (r)
>  		return r;
> -	update_cr8_intercept(vcpu);
>  
>  	return 0;
>  }

Okay, because kvm_apic_set_state() -> apic_update_ppr().

> @@ -10595,33 +10593,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
>  		kvm_run->flags |= KVM_RUN_X86_GUEST_MODE;
>  }
>  
> -static void update_cr8_intercept(struct kvm_vcpu *vcpu)
> -{
> -	int max_irr, tpr;
> -
> -	if (!kvm_x86_ops.update_cr8_intercept)
> -		return;
> -
> -	if (!lapic_in_kernel(vcpu))
> -		return;
> -
> -	if (vcpu->arch.apic->apicv_active)
> -		return;
> -
> -	if (!vcpu->arch.apic->vapic_addr)
> -		max_irr = kvm_lapic_find_highest_irr(vcpu);
> -	else
> -		max_irr = -1;
> -
> -	if (max_irr != -1)
> -		max_irr >>= 4;
> -
> -	tpr = kvm_lapic_get_cr8(vcpu);
> -
> -	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
> -}
> -
> -
>  int kvm_check_nested_events(struct kvm_vcpu *vcpu)
>  {
>  	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
> @@ -11361,10 +11332,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		if (req_int_win)
>  			kvm_x86_call(enable_irq_window)(vcpu);
>  
> -		if (kvm_lapic_enabled(vcpu)) {
> -			update_cr8_intercept(vcpu);
> +		if (kvm_lapic_enabled(vcpu))
>  			kvm_lapic_sync_to_vapic(vcpu);
> -		}
>  	}
>  
>  	r = kvm_mmu_reload(vcpu);

The other side of the refactor, sure.

> @@ -12481,8 +12450,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
>  	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
>  	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
>  
> -	kvm_set_cr8(vcpu, sregs->cr8);
> -
>  	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
>  	kvm_x86_call(set_efer)(vcpu, sregs->efer);
>  
> @@ -12511,7 +12478,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
>  	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
>  	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
>  
> -	update_cr8_intercept(vcpu);
> +	kvm_set_cr8(vcpu, sregs->cr8);
>  
>  	/* Older userspace won't unhalt the vcpu on reset. */
>  	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&

Right, because kvm_set_cr8() -> kvm_lapic_set_tpr() -> apic_set_tpr() ->
apic_update_ppr(), so setting cr8 and updating the intercept are merged
into one step.

I can send a v2 which applies on kvm-x86/next without the refactor, the
diff should be quite small.
