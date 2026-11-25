Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586025;
	b=3V3WO5gB4gWPp0w90VDMY4VWQfFF9/79lqKiZQj8iA1GP4sreFovZtsrN/uDxummpVrN
	 jh3ZNfBt/bPOmwu5TY43TGwWbNro6I12slk7pBeSlLGhMZVbSg8RTKdxfkd/YO9ZaZYnB
	 /BwoxmMWVVXHuRAQdCFFprbsjkyVA4nu3gYQRB73VctDNMQlwHmYVwtlqoxyRHjEDNOdN
	 bGY/G59BcRtjJ3nboeV6I1Q4+C+V+2sFhzsiNOZGpSDPZM1ip1l/89+207EtpaayP5EcU
	 Cv3dIYSAlpWlnU5WIvojjKoJdcIXScjf0nOcJJ4RVEUCTAvIClOuSevtB9WanQwB6eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
	b=ZvgxZ56NwvJIWhhela3LOUoqURT9ncz3xS0+5yAecjY/FrE7KNGudet87H/UKi/Hifxy
	 eQ1T0gFvvIaz2g/hMtnDjg15RlLnt+b9XDNZhi8R0JSp2K2rnmUZibqv7q4fK+lBGw2ir
	 apuTwmtvXpBbcXtPpdNioN7rYwkFKmYJABW9CrL2Jsl1ecKNrbL8FZJgK20QNDxrD5zsn
	 4/20bvnew7spUkSpITY/EiXicFO7e4eYbZewbAjn/dmvdTeZ8PESylwyRY7ctcUMRK1qJ
	 NNJn6FGFfhGkU9kiAmPX35c5lh5nhxhZU00vb6ciVIVh6smTkhxT5Yvm/2bYNk5+RWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFVlaU4A;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687B606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3687B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFVlaU4A
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so2605180b3a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586024; x=1796190824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
        b=eFVlaU4AiELn0jQHySTu52yAagv9Y98gP99pMo0Bp5hXsbOCq1aHnPwOqZ84fOaWvE
         bg/IFGrK8juukRO6U9HbapVs7osBZx/xLlrZ/pS26L40b8IywfwPpQLVmI/xcctN1TSv
         6AicBNggBCCnDuvMpQbb1xPrm5TYWtEVVE72pmjdQUhHhWdaCdEZapXy4W1PWL7iXm6q
         QuHFKpTzAvrCh8ZznEXd5mxk4bz1UDy1UEnSVwLFDmYsnvItpL+IMBAeobcif7eVois5
         qyNESM18ITf3rIjG6PhJq0D7jwxo96eqiPiAdAOUVeNxbdo+/L5EoP0oPyvnLtBqcZAX
         RWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586024; x=1796190824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMgsgpEKznfx9E2tPu9EJE/6blmi3j8XUJFr/xHJgnU=;
        b=0t7tI2K8+VhY4zDGQG0V8fs2r6UfvVB1Pnw3LSRofO8OeidpM1qvw+kj5Zr4YmLYeR
         fnWheXZ4OFf32v+cn06I2xnXacvKvWZ2UzpIqkJpUjS0IXOV2lUb/rBB3MFs2XhCa4Jy
         Nh+8LeHCUU6gNSkUKZ4vALwTLX0aKgurq4kAfQ/79c72rZ2GXPKvl//kLAusKYXBBoW5
         Bcymyqv3ne5dtcX4xL+l45HDb83Z37JkXJGMo0NTYHk/Eb6NwrbPSyAyqVKVsVSNx7Nz
         6LSyJzkozEdZWxysV6TSOFSOjs3AIveffIWo+hgM9w7i7y5YEi2xAZETlFxj6oOXvKjU
         y0Jw==
X-Forwarded-Encrypted: i=1; AL+hErGfrx4MnI6OwYr8jCNWQsFwiutECbkCnRindQ8zPknhm/Giq3SKwOaU8pS/aTI8cmJj1ssiBMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aLZQ0mZ00tmYs3EHQgmaT7D4SpjDYO3GikWejbN8ZR7w2pekt
	JSwziP4NH03TN784s6hjSgygT90Oq6+vlps1FOUC1T+CMUEZPN/z3KhC
X-Gm-Gg: AZFdTZdRKxZywrIaHAO5zuYxxR2OFR9aCxWDfcbhArhg2KslDIjITnLq0z5ALcUfEEl
	4OCxxMT4x0i4MnRaRHvr99CRBFQ0bxWwVUQxdZ5INx8ioi9XRXpwKyye4QT+zx8xZUuijjBvXfK
	7kpnPgf03BSY+bXzMSvANzB2W7p/xSfT0qeWHO9pAm1xXim11x4hZoamGoU4EthdqNxqxBsULpW
	zRgamDExR/tiF+Va2VbviOYEntq2i2U0pB0j+YG3NhzeiH+KtRR1i0GdDGDpI9J9BN3tPPn+7FU
	L70BGagqybVcU+X/ePr8Y3Z11Ag8j3A8QjNoXS8uSX6nPLVuGC9cN8BugM4lUeIzzGf8QJvRFPY
	2YdbpouDmZQP2gkskkX+hJ583fw3Qxf1hpuF58/nzmfcPnVCPlYzBN0tXBllnyVK8WLQBf9xOXG
	GTBvgGgjCv0cPRSnl3gY9krZFONCsYPBUdbKpHV2DNduy4oYlueC8Xvdxg/sU5TPzPwFFw770oI
	EEEXbjQxs35CEHZu0/GCgeGLoDKDSXKWH71pJ9Wl4sEPNd0MSrNBIdS4W6htmMr/sXAo9epm3Pn
	SGDyhRyBudnNyo06ajVXBzugdcvP2dPQpCGjilxwcuwsdf2lvJbGAnftJuD88kB4RY3QK8dKe4r
	e
X-Received: by 2002:a05:6a00:2996:b0:89a:19ae:10e7 with SMTP id d2e1a72fcca58-8c87cf29209mr13734304b3a.42.1795586024370;
        Tue, 24 Nov 2026 21:53:44 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.51.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285ccf4sm7958930b3a.12.2026.11.24.21.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:53:44 -0800 (PST)
Date: Wed, 25 Nov 2026 11:23:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb
 GFP_KERNEL allocations under spinlock
Message-ID: <awZ31TppgNv1uBuW@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>

On Mon, Nov 23, 2026 at 07:21:52PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_init_hostwide() takes lock_l0_stats with spin_lock_irqsave() and
> then allocates the guest state message and buffer with GFP_KERNEL. On
> a nested API v2 host with DEBUG_ATOMIC_SLEEP this warns at boot:
> 
>   BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>   preempt_count: 1, expected: 0
>   RCU nest depth: 0, expected: 0
>   locks held by swapper/0/1: 1, on CPU#0:
>    #0: c000000004ad95b8 (lock_l0_stats){....}-{3:3}, at: kvmppc_register_pmu+0x50/0x270
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc2-00028-ge5a8bf3a3ee9-dirty #124 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0xe8/0x150 (unreliable)
>    __might_resched+0x190/0x30c
>    __kmalloc_cache_noprof+0x4dc/0x760
>    kvmppc_gsm_new+0x68/0xcc
>    kvmppc_register_pmu+0xd4/0x270
>    do_one_initcall+0xac/0x48c
>    kernel_init_freeable+0x3cc/0x7f0
>    kernel_init+0x3c/0x274
>    ret_from_kernel_user_thread+0x14/0x1c
> 
> The lock is not needed for the allocation of gsm and gsb buffers.
> Allocate and fill the message and buffer without the lock and only take
> it to publish the two global pointers.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index aa72b96b5a8c..a58634f656e9 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -314,53 +314,48 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
>  
>  static int kvmppc_init_hostwide(void)
>  {
> -	int rc = 0;
> +	struct kvmppc_gs_msg *gsm;
> +	struct kvmppc_gs_buff *gsb;
>  	unsigned long flags;
> +	int rc;
>  
> -	spin_lock_irqsave(&lock_l0_stats, flags);
> -
> -	/* already registered ? */
> -	if (gsm_l0_stats) {
> -		rc = 0;
> -		goto out;
> -	}
> -
> -	/* setup the Guest state message/buffer to talk to L0 */
> -	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
> -				      GSM_SEND, GFP_KERNEL);
> -	if (!gsm_l0_stats) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	/* allocate the Guest state message/buffer to talk to L0 */
> +	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND,
> +			     GFP_KERNEL);
> +	if (!gsm)
> +		return -ENOMEM;
>  
>  	/* Populate the Idents */
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
>  
>  	/* allocate GSB. Guest/Vcpu Id is ignored */
> -	gsb_l0_stats = kvmppc_gsb_new(kvmppc_gsm_size(gsm_l0_stats), 0, 0,
> -				      GFP_KERNEL);
> -	if (!gsb_l0_stats) {
> +	gsb = kvmppc_gsb_new(kvmppc_gsm_size(gsm), 0, 0, GFP_KERNEL);
> +	if (!gsb) {
>  		rc = -ENOMEM;
> -		goto out;
> +		goto free_gsm;
>  	}
>  
>  	/* ask the ops to fill in the info */
> -	rc = kvmppc_gsm_fill_info(gsm_l0_stats, gsb_l0_stats);
> +	rc = kvmppc_gsm_fill_info(gsm, gsb);
> +	if (rc)
> +		goto free_gsb;
>  
> -out:
> -	if (rc) {
> -		if (gsm_l0_stats)
> -			kvmppc_gsm_free(gsm_l0_stats);
> -		if (gsb_l0_stats)
> -			kvmppc_gsb_free(gsb_l0_stats);
> -		gsm_l0_stats = NULL;
> -		gsb_l0_stats = NULL;
> -	}
> +	/* setup the Guest state message/buffer to talk to L0 */
> +	spin_lock_irqsave(&lock_l0_stats, flags);
> +	gsm_l0_stats = gsm;
> +	gsb_l0_stats = gsb;
>  	spin_unlock_irqrestore(&lock_l0_stats, flags);
> +
> +	return 0;
> +
> +free_gsb:
> +	kvmppc_gsb_free(gsb);
> +free_gsm:
> +	kvmppc_gsm_free(gsm);
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 

LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
