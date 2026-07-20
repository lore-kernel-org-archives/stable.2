Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988E3B993A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555584; cv=none; b=Zy/xIjuPN+kcxoRr/pOb/uNEMu++5oXYF8dXTc3iXH70wp9ntNZ9HNa2aBdTgMwiGm67cNIYHTJ/F9nQ6sNvUlSDw6FpO5wIbX09TfbOb/yd0S1eizbyC+MVsznO1OY/7bE3TwUEPsb91+Ow9syD2fUw1RgNCMF4StIbgEhW4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555584; c=relaxed/simple;
	bh=3lK0nnR/GZupXnT7g5CwyHFpNtuwZnAULe2KSLyDvnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwgDCaHfgXiQ5xM01jzIAQBH5mfm/x3BsKdglI7dJsvsiyWjFPo4CSDADztDUWgGLYuHEx/YApPsTa4vXxKAlQxhl9RHGT/6uCfKmHT//M8AcjgMF9n8mZXycR33+hw6WUXe5nDExS3x6nvBJAcuZKJcHMGJYIsUPvE/OyBpDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZjSbPWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZjSbPWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784555581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uUDrQr+WCuvUguH1nbyv3TH9ET43Ve5esNSQTg+ZrN8=;
	b=VZjSbPWh7AU0Ml1DXCtQbY+5/DMU7kSMjbk5d+BVm13lkmCEAOkkr0ic9WCg3aQi42XdhX
	JyFPW8d7AWDcf8/ym3ymxT83WVGrsxe9cjf0d7s+cNkVZ7aoTBT5GY6AlI8YBwo4pFUSjg
	vVCPJSC8CGTKNUDpAEwYwXQuABNv9xk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-EfM9b9-zPgqcveFKyyz2ig-1; Mon,
 20 Jul 2026 09:51:19 -0400
X-MC-Unique: EfM9b9-zPgqcveFKyyz2ig-1
X-Mimecast-MFC-AGG-ID: EfM9b9-zPgqcveFKyyz2ig_1784555478
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A86A1964CCC;
	Mon, 20 Jul 2026 13:51:18 +0000 (UTC)
Received: from [10.44.48.28] (unknown [10.44.48.28])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19C83158E;
	Mon, 20 Jul 2026 13:51:15 +0000 (UTC)
Message-ID: <12ce1012-a382-4cd9-807b-68d8b04f1008@redhat.com>
Date: Mon, 20 Jul 2026 15:51:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Only reset TSC Deadline Timer in
 apic_timer_expired on KVM_RUN
To: James Houghton <jthoughton@google.com>,
 Venkatesh Srinivas <venkateshs@chromium.org>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org,
 David Matlack <dmatlack@google.com>, Sean Christopherson
 <seanjc@google.com>, Jim Mattson <jmattson@google.com>
References: <20260715234234.15382-2-venkateshs@chromium.org>
 <CADrL8HX-wfbjF=huA_kopNEbq63E3yhO6_9WfrcfH5EgJYAk1w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CADrL8HX-wfbjF=huA_kopNEbq63E3yhO6_9WfrcfH5EgJYAk1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 7/16/26 03:14, James Houghton wrote:
> Hi Venkatesh,
> 
> On Wed, Jul 15, 2026 at 4:42 PM Venkatesh Srinivas
> <venkateshs@chromium.org> wrote:
>>
>> Fixes a lost timer interrupt issue if:
>> 1) We are on an Intel platform w/ a VMX preemption timer && APICv
>> 2) A VMM calls KVM_GET_LAPIC before KVM_GET_MSRS to save vCPU state
>> 3) The thread executing the two calls migrates CPUs between the two calls
> 
> I think the paragraph above should be rephrased, something like this:
> 
> "On Intel platforms with a VMX preemption timer and APICv, if a VMM
> calls KVM_GET_LAPIC before KVM_GET_MSRS to save the vCPU state, it is
> possible to lose a pending timer interrupt.
> 
> If the thread running these ioctls is migrated to another core after
> calling KVM_GET_LAPIC but before KVM_GET_MSRS and the guest is using
> their LAPIC timer in TSC-deadline mode, not only does the save LAPIC
> state not carry the pending interrupt, the TSCDEADLINE MSR will be
> zeroed."
> 
> Sean doesn't like pronouns (like "we"); he'll probably have similar
> style feedback.

Yes, I sometimes use "we" as "the code", i.e. collective past 
developers, but not for runtime situations.

>>
>> After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
>> interrupt and clearing the MSR:
>> vcpu_load() ->
>>    kvm_arch_vcpu_load() ->
>>      kvm_lapic_restart_hv_timer() ->
>>        start_hv_timer() ->
>>          apic_timer_expired() ->
>>            kvm_apic_inject_pending_timer_irqs()
>>              . post interrupt into the LAPIC state
>>              . clear IA32_TSCDEADLINE
>>
>> The saved LAPIC state will be missing the pending interrupt and the saved
>> MSR will be zero. Oops.
>>
>> Fix by only posting an interrupt when we're attempting to enter the guest
>> (vcpu->wants_to_run == true), not for vcpu_load from other paths.
>>
>> Assisted-by: gemini:gemini-3.1-pro-preview
>> Debugged-by: David Matlack <dmatlack@google.com>
>> Debugged-by: Sean Christopherson <seanjc@google.com>
>> Debugged-by: Jim Mattson <jmattson@google.com>
>> Debugged-by: James Houghton <jthoughton@google.com>
>> Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
> 
> You have included cc:stable (on the CC line in this email); could you
> include it here in the patch as well?
> 
> Also, what is the appropriate Fixes?

Fixes: ae95f566b3d2 ("KVM: X86: TSCDEADLINE MSR emulation fastpath")
Cc: stable@vger.kernel.org

> As far as this change goes, it makes sense to me.
> 
> Reviewed-by: James Houghton <jthoughton@google.com>
Queued, thanks!

Paolo

