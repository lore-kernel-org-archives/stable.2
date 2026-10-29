Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299043;
	b=Pv+rH22oz/dCrRX5IQVazSj660vYDRsLXlQXZJE1FfaJjzOfIwpPq37n+iODiWcuxks5
	 ++jljFAwEK/Qz5i9nmFN598lbN6JGeN6cPl5+3BpsSsQmVNFUHBmA5i93HKsFEW7mM9Ch
	 fty+mNhlbW5CbMntV5beCnX5NKEGQYfcfi/Mx1aZAT++KsemJgyrdZhyOAH/vaZjnJuR3
	 FYeQ+VoRMPH6z7jM/e5jLhWRh4hloMmWNC429wErC+bmOL+UxEyQ+i0WKcJx97Faa8TDg
	 kKba8pV4r3Ss/vhjZ6KezC24/q53RWqcE/uVd36fKgmiUN3RbKZ9Yj0+7RlIiIwW5tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299043;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gx+Pm4s/TyfImCs+tYPpk9KkdGMYfSuxFUC/3OFcAz8=;
	b=O+0ws3uefP8ucQTm3uOwFTyKeb1PIwrFmuSIx3h1SsjgbEH/4ngrOkfymup5JR8U570A
	 p6cMqf3wF9ZiC+zIY3OF2DAacbcPM+hEUC9Xa74gU1c3YSP4YQkyqKJuhs8m1l1GbjBNR
	 EmHCt4y5HfDO6yK5XjykzyBiGtRqL1tBILZXAOZQjHfORvpRaLqmu82TU8vW6LeGKKwUT
	 S8d8BVguzvoNOMHrh+OiMoa6GhDYfn3Wb3vKqJS1yVMtI+fG/iiWp2dlJvfiMMhDLCj7B
	 jT9Bq9lY3flXqbZPsCJQCYWM/9kMPY4mjMiti9DS/bEQaxXoZGLtE0CVmZECXpr/Gew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJ7yoNmJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A90606A31A;
	Thu, 29 Oct 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJ7yoNmJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACDE1F01824;
	Thu, 29 Oct 2026 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299042;
	bh=Gx+Pm4s/TyfImCs+tYPpk9KkdGMYfSuxFUC/3OFcAz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DJ7yoNmJtyYEySMZo3xQ1qROZ8vRaKU8pyjmd56gyO2EEh/gyDZCCa5njZ/6Gg0iI
	 eSiE/U0UkqnlBk/8lYD+j5gH3qWvpc+hujGTd34Q4XCEG7AGmqNGjlseXX1lY9zk0d
	 LS18j8WLYkmuCSoOuH9/+u3uW5/hPTB9IoSLDTj8JIYIWidJ/MghUlgXbE3suxMoOz
	 DUKJuCKu8xwUPor9V1+xx9ulFNyjPZPC3td7ryjUyxeuZka+e+tsQAbxZue52WNUvy
	 p+E/LShxJDzAxC/AyiCqlvnZj0oYv0tCI56f4o+i95JYXa1+BpTbah+b610gWS6I83
	 55337QrgZpoUg==
Date: Thu, 29 Oct 2026 11:37:20 -0700
From: Oliver Upton <oupton@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Respect HA when computing translated TCR
Message-ID: <auOSYE97K5y19DAy@kernel.org>
References: <20261029090522.64662-1-oupton@kernel.org>
 <CA+EHjTz-kXVbzcjtMte8B26f0Undr+kWjF2-d0B8TLT8n03hJg@mail.gmail.com>
 <86ld7gydqp.wl-maz@kernel.org>
 <CA+EHjTw0EjMHKOH8s0F6PZRR7WkmRJJrMrqTzpYoP9gm5n_9Gg@mail.gmail.com>
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
In-Reply-To: <CA+EHjTw0EjMHKOH8s0F6PZRR7WkmRJJrMrqTzpYoP9gm5n_9Gg@mail.gmail.com>

On Thu, Oct 29, 2026 at 11:41:22AM +0000, Fuad Tabba wrote:
> Hi Marc,
> 
> On Thu, 29 Oct 2026 10:58:54 +0000, Marc Zyngier <maz@kernel.org> wrote:
> [...]
> > That's a good point. However, my reading of the ARM ARM indicates that
> > as long as S2 shareability is Inner-Shareable, the resulting
> > shareability is Inner-Shareable (see R_ZNLRJ), so we're actually safe.
> > This should be fixed though.
> 
> If my reading is correct, I don't think R_ZNLRJ is enough here.
> AArch64_S1Translate() (J1.2.4.57 in M.d) checks the walk attributes
> before it translates the update through stage 2:
> 
>     // Either the access flag was clear or AP[2]/nDirty was set
>     if new_desc != descriptor then
>         if (!IsWBShareable(descipaddr.memattrs) &&
>             ConstrainUnpredictableBool(
>                 Unpredictable_Unsupported_Atomic_HW_Update)) then
>             fault.statuscode = Fault_UnsupportedAtomicHWUpdate;
>             return (fault, ARBITRARY : AddressDescriptor);
>         end;
>         ...
>         if regime == Regime_EL10 && EL2Enabled() then
>             ...
>             (s2fault, descpaddr) = AArch64_S2Translate(fault,
>                     descipaddr, s1aarch64, s2aligned, descaccess);
> 
> descipaddr is what AArch64_S1Walk() returns, and it holds the stage 1
> walk attributes (walkaddress.memattrs = walkstate.memattrs, with SH0
> from TCR_EL1), never combined with stage 2. R_VSXXT also covers an
> update "not supported in the stage 1 translation due to the defined
> memory type": that one is a stage 1 abort, taken to EL1.
> 
> But it's not like the ARM ARM is an easy read :P

This is definitely helpful but my understanding is that the pseudocode
is *not* authoritative. I think the line "If a translation table hardware
update is not atomic as observed by other agents ..." in R_NNNMB gives
an implementation enough freedom to decide something Non-Shareable at S1
is actually atomic after the result of S2 translation (e.g. S2FWB).

So if the implementation decides it is atomic, no MMU fault is generated
and the update happens like normal. Now, with that being IMP DEF there's
a good chance the behavior can vary, like we saw on the output of
translation on N3 [*].

I'll add another patch to propagate SH0 and HPD, thanks Fuad.

[*]: c8631ea59b65 ("KVM: arm64: selftests: Explicitly set the page attrs to Inner-Shareable")

Best,
Oliver
