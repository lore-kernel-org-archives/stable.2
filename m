Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1A37CD24
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781518798; cv=none; b=b33o6iDGs8y/T1HHRjoQ/pBadwUFeCq0f7sy3LOAXY6eNnGSYaUOjzkqx+8ZWWbeNkhlmTAJIG2nYWNUoYiU7fzn2FtlujcmBG5kn7KhXqv/usRQud375suhbhHZM44Iqndsb29P94r2jfMsCW6H0eHK690NkYngtfv7HfqTcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781518798; c=relaxed/simple;
	bh=u3C61S5DxXPzziWGCqZwUPeZaV8SqqYZUqxNkKGhQKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkhzROLdKPNQ//5ClUb/Z4FsgWH2G2BYCiAPfqChiwE4pveWkk9ZLGII5wOWsjcWvto3Jm2ltL0o6q9/nYv24GHLNGePED5i7b0VxgHJVcgyZr0KgTd0RaZHMeXNbNXQZXir8YsZxpUTqIK7PsW0tnSuibgpQ+HFLh8Tg3JTdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aIKtjh/M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQOioZkf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aIKtjh/M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jQOioZkf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aIKtjh/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQOioZkf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aIKtjh/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQOioZkf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B77876ACFC;
	Mon, 15 Jun 2026 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781518795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiI1S/AKACD4xKPsymAzQLLVEJL7P3F6rlzjBEp4e6g=;
	b=aIKtjh/M6bTaPOtIeRfhv4L7o0rZiYRqnAyBDV0KBY6NA+K1aSdKLYgOGhneTnIFCqxexZ
	wmxwO2N9xD4d0N/GNwl2jpy7EZiJ3ys0n/QHy9Q+62fvDLVhuCfFxNXwjN2E0dc8H6VhK6
	4yIB5rjCE6lenmF34/L8kjKPudpxoJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781518795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiI1S/AKACD4xKPsymAzQLLVEJL7P3F6rlzjBEp4e6g=;
	b=jQOioZkf6oOt3nbtcAzSr4ccj6sWk+P3+gz03WcZlsr45knYs5QkKlWMVDycqGSHK4BagX
	P860h73a05CZM2DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781518795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiI1S/AKACD4xKPsymAzQLLVEJL7P3F6rlzjBEp4e6g=;
	b=aIKtjh/M6bTaPOtIeRfhv4L7o0rZiYRqnAyBDV0KBY6NA+K1aSdKLYgOGhneTnIFCqxexZ
	wmxwO2N9xD4d0N/GNwl2jpy7EZiJ3ys0n/QHy9Q+62fvDLVhuCfFxNXwjN2E0dc8H6VhK6
	4yIB5rjCE6lenmF34/L8kjKPudpxoJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781518795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiI1S/AKACD4xKPsymAzQLLVEJL7P3F6rlzjBEp4e6g=;
	b=jQOioZkf6oOt3nbtcAzSr4ccj6sWk+P3+gz03WcZlsr45knYs5QkKlWMVDycqGSHK4BagX
	P860h73a05CZM2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC78779A7;
	Mon, 15 Jun 2026 10:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lTaML8rRL2rjcgAAD6G6ig
	(envelope-from <clopez@suse.de>); Mon, 15 Jun 2026 10:19:54 +0000
Message-ID: <79c59d84-80bc-41f6-950f-41ff2e6b2b5b@suse.de>
Date: Mon, 15 Jun 2026 12:19:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: KVM: x86: Unconditionally recompute CR8 intercept
 on PPR update
To: Sean Christopherson <seanjc@google.com>,
 syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 osteffen@redhat.com, pbonzini@redhat.com, sgarzare@redhat.com,
 stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <20260610214523.2905255-2-clopez@suse.de>
 <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com> <airudX6N4oL5X_wE@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <airudX6N4oL5X_wE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[ci493c6d734b63e050];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 6/11/26 7:20 PM, Sean Christopherson wrote:
> On Thu, Jun 11, 2026, syzbot ci wrote:
>> syzbot ci has tested the following series
>>
>> [v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
>> https://lore.kernel.org/all/20260610214523.2905255-2-clopez@suse.de
>> * [PATCH v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
>>
>> and found the following issue:
>> WARNING in vmx_update_cr8_intercept
> 
> ...
> 
>> ------------[ cut here ]------------
>> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
>> WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
>> WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
>> RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
>>  apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
>>  kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
>>  kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
>>  kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
>>  kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
>>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
>>  vfs_ioctl fs/ioctl.c:51 [inline]
>>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This is "fine", the assertion just wants to make sure KVM isn't access vmcs12
> without holding vcpu->mutex, otherwise any queries are inherently unstable.
> It's just that vCPU creation runs without taking vcpu->mutex, because the vCPU
> is otherwise unreachable.
> 
> I'm pretty sure we can squash the WARN by grabbing vmcs12 if and only if the vCPU
> is actually in guest mode.

Will you add this on top or should I send a v3?

> diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
> index c548f22375ad..332fbcd924f2 100644
> --- arch/x86/kvm/vmx/vmx.c
> +++ arch/x86/kvm/vmx/vmx.c
> @@ -6876,11 +6876,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  
>  void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
>  {
> -       struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>         int tpr_threshold;
>  
>         if (is_guest_mode(vcpu) &&
> -               nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
> +           nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
>                 return;
>  
>         guard(vmx_vmcs01)(vcpu);
> 
> 
> Longer term, I'll work on figuring out how to handle this in get_vmcs12(), because
> to_hv_vcpu() has the solve the same fundamental problem:
> 
> https://lore.kernel.org/all/aeqRzanSaa9P_EPg@google.com

