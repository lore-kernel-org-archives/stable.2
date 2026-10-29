Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274126;
	b=iAY38cooPoo4VKdgpX7uC09VDXTdxHweP+iahuwdQa+hv+Jcfl1e1hhVtKR7nV0pfCDC
	 GATfWEO6dsczmLvtfkycc1qYQMN3uqQvZnyI6ZLXOdg990hlEy0sRZBoXzu1T8aUIu3NN
	 nd0FboWr6GB5B7fp7CWVz0kD3oA5/hFcuPchtZEwJSD1ZZo5M/z3qanbZXrVowldHwDYg
	 H8a8CHpjuKJyKpFfJs8MPIySntQ3h2CCMP9VpwVETRbkuoPB2V7RsT6parwZ/jFbSgt0U
	 D87gPFns53BndCX9fraldtl5X5nwp6s8c/9QJbiR/t/JSseKAQjVi7atNs8jOl5eGig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274126;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=lNKnDSm6DWP7OhUxWQd4mOe7im/nMYs8Ki0YFs7PQN8=;
	b=AjW1ziuy/YNAw2k7dJLflt+yoXzhsykOY/Sah8vXZmoHwHdf8vlCM7nCRcgF0/DNxXnz
	 sGqlMphUKvITyI2kZLkYOzCWL3vAttk7TId9d1xQCHQIutvc2xnkiV6mZhnbesTKqHr2P
	 e9WCZwkI/0ZgxoH6w5NgT/SW0UUSJ1LVr6/i+lG/V6LReBTd1Vdb/2RPmtZ+4JAJ8QQYF
	 R8Fv9XXFlrd1ZXR2mmxuF1hjQE1VygZ0QcgOVCzg9InaaGgsGwKGUoiSo77UfhYs2NodJ
	 D3UY7KiArsnBcYHQF/IL+f4kBjBF3MdaSAutxyhhR7jWuomFfjxiQKRKjSuuhOp4v0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ViYcAhwX;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E5606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ViYcAhwX
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PnHgOuaW7I0Mn/MofV12U5YliQliS5wKeUNRMOs0Mn4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793274121; v=1; x=1793878921;
 b=ViYcAhwX4aOh+SjcV/ahUSCk9rLCWxY2AaRMspXtdN+GAmLTvlXudu+iZwbCjk8+YBmhCnzJ
 1rOZbWQwxK1uVMfKHMDVbRMiLfSOeR/FE7KB7c2NgVKzyRTAQpRA8qOa8JMWKfjDeEY3bIcEhIQ
 9BQ0QjWgyxGijD9IYB4tBzMA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 779e1a2d9eb53962;
	Thu, 29 Oct 2026 11:42:01 +0000
X-Mizu-Trace-ID: 779e1a2d9eb53962
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so7936e87.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:42:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwXKbtyAvVTwgAICIuEp8WXNOIPUe4wkfJKJEQDUxsVqZtRkQqYRTG2GfnLVz8M8A9W3sMFBt0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvScTuK6xWSrJsCPTUdnMpAeZCGhAxSusci0bMJOH3Hpzoz9Mr
	Mu5Pxz2AuMUYg+0tjzQrFPBU7ioZc6WobuKMWgd7NpLarj0dHbjGd5wo2oSAMPlCobMoQrVZp0J
	gopJBfOyTtU+4iRNxksccyhSYhzuVzROdmuF3sKcu
X-Received: by 2002:a05:6512:1052:b0:5bf:b994:6598 with SMTP id
 2adb3069b0e04-5bfd142a3a5mr145865e87.6.1793274118982; Thu, 29 Oct 2026
 04:41:58 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029090522.64662-1-oupton@kernel.org> <CA+EHjTz-kXVbzcjtMte8B26f0Undr+kWjF2-d0B8TLT8n03hJg@mail.gmail.com>
 <86ld7gydqp.wl-maz@kernel.org>
In-Reply-To: <86ld7gydqp.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 29 Oct 2026 11:41:22 +0000
X-Gmail-Original-Message-ID: <CA+EHjTw0EjMHKOH8s0F6PZRR7WkmRJJrMrqTzpYoP9gm5n_9Gg@mail.gmail.com>
X-Gm-Features: AclHuK_Z0kHPbYh0i1HryGJaOSIwXE6_zjBe1WXl1ax6QBriG_I6vIJcW96TN10
Message-ID: <CA+EHjTw0EjMHKOH8s0F6PZRR7WkmRJJrMrqTzpYoP9gm5n_9Gg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: nv: Respect HA when computing translated TCR
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Thu, 29 Oct 2026 10:58:54 +0000, Marc Zyngier <maz@kernel.org> wrote:
[...]
> That's a good point. However, my reading of the ARM ARM indicates that
> as long as S2 shareability is Inner-Shareable, the resulting
> shareability is Inner-Shareable (see R_ZNLRJ), so we're actually safe.
> This should be fixed though.

If my reading is correct, I don't think R_ZNLRJ is enough here.
AArch64_S1Translate() (J1.2.4.57 in M.d) checks the walk attributes
before it translates the update through stage 2:

    // Either the access flag was clear or AP[2]/nDirty was set
    if new_desc != descriptor then
        if (!IsWBShareable(descipaddr.memattrs) &&
            ConstrainUnpredictableBool(
                Unpredictable_Unsupported_Atomic_HW_Update)) then
            fault.statuscode = Fault_UnsupportedAtomicHWUpdate;
            return (fault, ARBITRARY : AddressDescriptor);
        end;
        ...
        if regime == Regime_EL10 && EL2Enabled() then
            ...
            (s2fault, descpaddr) = AArch64_S2Translate(fault,
                    descipaddr, s1aarch64, s2aligned, descaccess);

descipaddr is what AArch64_S1Walk() returns, and it holds the stage 1
walk attributes (walkaddress.memattrs = walkstate.memattrs, with SH0
from TCR_EL1), never combined with stage 2. R_VSXXT also covers an
update "not supported in the stage 1 translation due to the defined
memory type": that one is a stage 1 abort, taken to EL1.

But it's not like the ARM ARM is an easy read :P

Cheers,
/fuad
