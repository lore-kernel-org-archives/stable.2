Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864378;
	b=2mm/SPDXrG3baq7wjvBPnVdOdTUm1FlNdYTX5qrk3zSNQtITZFFBxO56cw4Q/BAnT9Bl
	 FFZ68jFUZAuJkPRf3hBqRDMNpg9kBgZcEjXZR8s2oAf6TtcTpiqzV9ob5qOQLF2WclB/G
	 PNfE8Fq4CPlB4hkHH9FCo5tkPTJVM2kL4sCYHYnSOzLY0S9e5rh8R01Kk38qwPsqQQeLj
	 Cm9gzxweTJn2s+h7VQrTJQUhlWwedVjpVNDLF1gRTjWfVJbaHYrp/Ah5EtO7LJRPZ6D1B
	 Z5xWw/18a5wtKX13HlJCA43hAaJFpMcZB22Hu+O4ZA37JrI9bs6Wk54gggn2jVrMTqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=wirPd/HZBmrPSXI+3F1vJVN7iYbeA/Q0PmPxqhTzeSw=;
	b=IgpU2YHop7djh66tk9KEa2ATqD8zr+rw8Ld/2lBHDOhSHQSiIi5gNyYtTWz26oINTfYy
	 jRHixMeISwfd+WWQ/2yZkAyQ3YH3YDFh1GtOUU9zJS4Xtmn+RWNOS+gYVdEdfAMJjHEz+
	 i9YFkiYaJWxsN51NjEeuQiCPOq5tbQR/OjHW9ZIu21gZ1vlWgACyEt/g0TkzwpT09hZcn
	 LUz7SE3eIyv7p32mdD8P3JKRzUIruioKT+mmPaJogwMsuG11YPVovHUwWXDnNBTU72hlW
	 B20AwRDxNv4yzy0iwuWk/hjThJ5ZHJhghkwuxJPsJe5mJ28AETM0hgv4W5r6kn/KTPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0tYqwJe;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C5606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 21:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E75C5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0tYqwJe
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso34633925ad.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794864377; x=1795469177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wirPd/HZBmrPSXI+3F1vJVN7iYbeA/Q0PmPxqhTzeSw=;
        b=n0tYqwJeMc4v2zrWl8uvmedhCwLdzcqg7ev1AtmP47ZCpEtws/3x9nooLTjg2EPhZC
         e9bIVTDFJPTQrgqIIiuGv4+Ih/yjXouHQpNmlcQRimN9v+mp12x6BvqZPv42jpHhyfcj
         AWGMUp84hMZ8xumyFSquS6ZeHlLUNfxj9xSwuRjlrmwoUUKlE7VkJRxxFx4SocA7t3Jh
         4vK76dHX1mcnTSi/sm+u8eRclLw8mkNWJoLhm5MiIYkOxH9BMA65HoiGEKcJ1VSMUkmw
         EKn5UV5ooUeiW0NfgTK5FddnaOAqm6S1zBRg2504hXxP9YVDSQTyk49Ir/MLCtBa/9H9
         lI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864377; x=1795469177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wirPd/HZBmrPSXI+3F1vJVN7iYbeA/Q0PmPxqhTzeSw=;
        b=Pz4oprvYqusiixZGd+Wg/woQcMl/Wi9+ukedUGkbXoeE0c+94rkPXUIjeFpa1jnUjP
         MRtUpxBpv4bUzvQKCyjp8JNYJS92kLafHmEtS1tUIeCvrmv5nwRfhIRE6e1nH7uc20FD
         lFoUoBsqH8EHllxmAYVOU25XdodMWLE/UhfYjLqBbUM614tkxggrroi/I0+La+u3kCzY
         P1aXe91osMz4y+GBwOrzd7dHeADRoukarLSrP3/iX5tWr3Gl386SHRrxIEJi+FbYmtPh
         gwd5DwXXH9SGx+nqzL2UBWXSFZbbnwzhQJmGHfC4mLDLBWU5qZydcuqc5KDQWg0hg28E
         8cJQ==
X-Forwarded-Encrypted: i=1; AL+hErFAC8mQund2tzYjOLFd/33+veAyqzEywk0V/Q3Lv7gtelWoUHoelBTAweEUtmiMdV5ueR08Kzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XieFd7+IF/6GSiSV3ulVEibYILvoJ/A8F9HEwA5hhKi1Gv7oi
	102rL8ER7HQeO0MVZu81j4JU74dARy6cKB9aSQdnSrJoNMj8UPgIpUW7J9uH4knrR3oRFx2ENQS
	RU/p7+A==
X-Received: from plbi3.prod.google.com ([2002:a17:903:20c3:b0:2ed:f7be:4684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1249:b0:2ed:630:40ad
 with SMTP id d9443c01a7336-2ee0dc91d2amr108548465ad.19.1794864376828; Mon, 16
 Nov 2026 13:26:16 -0800 (PST)
Date: Mon, 16 Nov 2026 13:26:15 -0800
In-Reply-To: <20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com>
Message-ID: <avt098dxfwl0FIGE@seanjc-mac.roam.internal>
Subject: Re: [PATCH] KVM: x86: Start IRQ bypass with local interrupts enabled
From: Sean Christopherson <seanjc@google.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 16, 2026, Satish Kharat wrote:
> Move the first IRQ-bypass notification after releasing irqfds.lock so
> that the vendor callback runs with local interrupts enabled.
> 
> On Intel, pi_start_bypass() issues KVM_REQ_UNBLOCK to the vCPUs through
> kvm_make_all_cpus_request(). If another CPU needs to be kicked, this can
> reach smp_call_function_many(), which requires local interrupts enabled.
> Calling the hook inside spin_lock_irq() violates that requirement and
> triggered the following warning during VFIO MSI-X setup:
> 
>   WARNING: kernel/smp.c:943 at smp_call_function_many_cond
>     kvm_make_all_cpus_request [kvm]
>     kvm_arch_irq_bypass_add_producer [kvm]
>     __connect [irqbypass]
>     irq_bypass_register_producer [irqbypass]
>     vfio_msi_set_vector_signal [vfio_pci_core]
> 
> The SMP API documents a possible deadlock in this context, including for
> non-waiting calls. No deadlock was observed in this case.
> 
> Keep producer publication, bypass accounting and IRTE error rollback under
> the existing lock. The IRQ bypass mutex still serializes producer
> callbacks after irqfds.lock is released. Notify only for a successful
> first attachment, after any IRTE failure has been ruled out.
> 
> An LLM assisted with implementation, code review and test automation.

LOL, I couldn't tell.  :-D

> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 7f8b092b4479..611b3e57b09a 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -485,13 +485,13 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
>  	struct kvm_kernel_irqfd *irqfd =
>  		container_of(cons, struct kvm_kernel_irqfd, consumer);
>  	struct kvm *kvm = irqfd->kvm;
> +	bool start_bypass;
>  	int ret = 0;
>  
>  	spin_lock_irq(&kvm->irqfds.lock);
>  	irqfd->producer = prod;
>  
> -	if (!kvm->arch.nr_possible_bypass_irqs++)
> -		kvm_x86_call(pi_start_bypass)(kvm);
> +	start_bypass = !kvm->arch.nr_possible_bypass_irqs++;
>  
>  	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
>  		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
> @@ -502,6 +502,13 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
>  	}
>  	spin_unlock_irq(&kvm->irqfds.lock);
>  
> +	/*
> +	 * Wake vCPUs with IRQs enabled. The IRQ bypass mutex keeps producer
> +	 * callbacks serialized after dropping irqfds.lock.
> +	 */
> +	if (!ret && start_bypass)
> +		kvm_x86_call(pi_start_bypass)(kvm);
> +
>  	return ret;
>  }

I would much rather fix this by having common code send resched IPIs for requests
that don't need to wait, same as KVM does for single-vCPU requests.  Because the
current task needs to be sleepable if a request needs to wait, i.e. it's not just
IRQs that could be problematic, and callers shouldn't have to deal with internal
implementation details (and those details really shouldn't be different for single
vs. multiple vCPU requests).

Compile tested only.  I'll write a changelog and post if it pans out.

--
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 16 Nov 2026 13:21:51 -0800
Subject: [PATCH] KVM: Send reschedule IPIs instead of SMP function calls for
 non-waiting requests

<write a changelog if this actually works>

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Cc: stable@vger.kernel.org
Reported-by: Satish Kharat <satishkh@cisco.com>
Closes: https://lore.kernel.org/all/20261116-b4-kvm-irq-bypass-irqs-20261116-v1-1-6cc721a062fd@cisco.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..0b733746884c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -218,7 +218,10 @@ static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 	if (cpumask_empty(cpus))
 		return false;

-	smp_call_function_many(cpus, ack_kick, NULL, wait);
+	/* See kvm_vcpu_kick() and kvm_make_vcpu_request() for details. */
+	if (wait)
+		smp_call_function_many(cpus, ack_kick, NULL, wait);
+
 	return true;
 }

@@ -241,12 +244,20 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 	 * satisfied if the vCPU migrates. Entering READING_SHADOW_PAGE_TABLES
 	 * after this point is also OK, as the requirement is only that KVM wait
 	 * for vCPUs that were reading SPTEs _before_ any changes were
-	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
+	 * finalized.
+	 *
+	 * See kvm_vcpu_kick() for more details on handling requests, including
+	 * the use of a reschedule IPI for non-waiting requests.  If waiting is
+	 * required, batch the SMP function call until after all to-be-kicked
+	 * CPUs are gathered, to avoid waiting multiple times.
 	 */
 	if (kvm_request_needs_ipi(vcpu, req)) {
 		cpu = READ_ONCE(vcpu->cpu);
-		if (cpu != -1 && cpu != current_cpu)
+		if (cpu != -1 && cpu != current_cpu) {
+			if (!(req & KVM_REQUEST_WAIT))
+				smp_send_reschedule(cpu);
 			__cpumask_set_cpu(cpu, tmp);
+		}
 	}
 }


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
--
