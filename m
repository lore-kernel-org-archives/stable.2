Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48060522F06
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686806; cv=none; b=FtA8RO/En0nDBVdCFO/NYHcfk/TijzEyZpESHwjYe1kE2hI30YKkWGguknUOUZKkLVgjjMambSNxIkDRTWEeXTevQU8E1GW/+K4j/OwppuJ1KgP9tRHwkJ4c4qXXx798cTS2KakCywBT+9U0V8nc/G+eTQEZW+c+Qiv+3056PKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686806; c=relaxed/simple;
	bh=3g9q9xAMofPTtsw+JqswDBxUzsiZn8hnkYRupWW+aWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT3g/WtC8HwrmOAf87ZfnF1140orJHoIVxiM36Y/1QfruqM+UGc7lhJZLNUaeznM02sd6nVnUPJKvWZXyDnamVxG17U5+AYaUwq1yqzES1QcVM2bccUz9Atw+FQ+91uYeLdYeckJXZxLGnqJEHjWj/9/C1LBwKAULbVIvsN/MHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsBQvUTg; arc=none smtp.client-ip=95.215.58.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsBQvUTg"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3g9q9xAMofPTtsw+JqswDBxUzsiZn8hnkYRupWW+aWE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790686802; v=1; x=1791291602;
 b=nsBQvUTgw4afC26JM4TpKQc76Taz1O8vnzwdu+OqB6EW1fqcHl9sxTBXu3HXekyvTpH1VFEy
 SFUcMdheleBzBJZK17ye5sV8kU1FCJyzOC22qKaFGZgzRaeY8YX1JVz1Z7xZcDQ0cuwQwXEyuuT
 3zn42feT6aQ5lDj6E06/3AaE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7997d03edf1b4b83;
	Tue, 29 Sep 2026 13:00:02 +0000
X-Mizu-Trace-ID: 7997d03edf1b4b83
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b8e81e2a0bso7823e87.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz55sMv0BPcTQRsQ1OHuC/sPHDNRx/989M1SyT0fZfoA6LJxzyIqhxVKlLJ46d0RkA1UKwkj1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKq5X7bh5YgCxZxnbhG/Rkm6+TdlS+siHjezjVwGUnnr6leGNcZ
	aXNqyIqIsK28Z1HE4Dkaaazh+5bNUcusVpWSyM3bk6j8j7mj2iyhUIYLQ78AHHBfLrgHxEQ+GrQ
	x8WTBWKae6pbSNAlMIHZFmJW/J48bqcZHhil1jYcK
X-Received: by 2002:ac2:5b03:0:b0:5ba:3602:4343 with SMTP id
 2adb3069b0e04-5ba360245a5mr41833e87.16.1790686800038; Tue, 29 Sep 2026
 06:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929093548.3598547-1-maz@kernel.org> <20260929093548.3598547-2-maz@kernel.org>
In-Reply-To: <20260929093548.3598547-2-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 29 Sep 2026 13:59:23 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwZSFUZmavbB4tE-eFxHg9WF80CA230EwvynuNcZQ0prg@mail.gmail.com>
X-Gm-Features: AclHuK9iOAMxlNpl03FjFTpY7NaQOY39bA66xUuGfPVEXi6mkeEvy65UK09-Y0M
Message-ID: <CA+EHjTwZSFUZmavbB4tE-eFxHg9WF80CA230EwvynuNcZQ0prg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication
 past context being saved
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Yuchao Zhang <ndaugoing@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 29 Sep 2026 10:35:42 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Move the publication of OUTSIDE_GUEST_MODE to the point where the state
> is actually written, and give this write release semantics to ensure the
> correct ordering.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org


No Fixes: tag?

[...]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
[...]
> @@ -1386,6 +1385,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>
>               kvm_arch_vcpu_ctxsync_fp(vcpu);
>
> +             /*
> +              * All the state has been synchronised, let advertise
> +              * we're outside of the guest.
> +              */
> +             smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);

Pardon my atomics :), but what does the release pair with? On the halt
path, the only reader I can find is the cmpxchg() in
kvm_vcpu_exiting_guest_mode(), and the LPI-disable and MOVALL halts
then take ap_list_lock or irq_lock. Would WRITE_ONCE() be enough?

Should the early exit path (the kvm_vcpu_exit_request() bail-out) get
the same treatment? I think that's what Sashiko is trying to say in
the patch 5 review [1].

nit: "let advertise" -> "publish"?

Cheers,
/fuad

[1] https://sashiko.dev/#/patchset/20260929093548.3598547-1-maz%40kernel.org?part=5
