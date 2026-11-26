Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795734968;
	b=Iq82YH8aKw8f5UJK6Y8OPeXVonpInk1sgV4zSrq/0xprXLigyR0CvZ0Sgs+WixwDZ2hR
	 4FyTi29DI2OjWBntLNoNR6N1AEr4R2ZLdi6e8qtZBNY1FGKRJVsQjK6FkU3e7xdWdMBjv
	 oI/WvOPobIetZyRq9JmWRjkG6BCE1YmoflVZn2HytQ8CK60RYayrc/alsY01wAo42L0uL
	 3PSB1PTe6h7GSzVSaks3oRPSidpYKmhawX2237N3BcLHw7eQABOxymWu1h7czfHyNMW8p
	 GURCJ/1ux8qbmDfzA+Ld6k6g3kuGSZkJnm/YKoojWVu5FiKrsBWybSh/DyVI57amDyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795734968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BWrRFuEPfNkDDgiMO5F3iE5SYJuRJ+VyIA3mL6UAwNc=;
	b=oH/VUW80iScZFnvZWU/AJwnUKsvZ9QeguXgSP+NgxUl7S6eI41qxRax+qFHkhztwTfDB
	 2XF+eWi4dx6IG9L6t515n/OYFJq2lY2rDC5viIyD3tNSmrXD5ayiHb4NpK+i4i69YAKSS
	 P59PoFpj/si6q7WUkq+hWeSMvWgzGXDF/I4npYZGNAxc/o+hnaCZGmRPdLhWp3/QQkMGX
	 djbA9vYDSEcSbidz1PtmUt/mqQ6ceVjUhdSioqEWtSLiQ+UC7vLYf/SYX8z43n3wqPnyE
	 o1TolY/2vTFzfylEDZA8k0n2t2b0cOo3lXiDKEfkuluVEFMilO0Vb+AojZyt2Fb+sXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tailscale.com;
	spf=pass smtp.mailfrom=tailscale.com;
	dkim=pass header.d=tailscale.com header.i=@tailscale.com header.a=rsa-sha256 header.s=google header.b=am1QVt0l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBF1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tailscale.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tailscale.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tailscale.com header.i=@tailscale.com header.a=rsa-sha256 header.s=google header.b=am1QVt0l
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ad1db7e31so5359020eaf.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:16:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795734966; cv=none;
        d=google.com; s=arc-20260327;
        b=LWVRbxs6+sxVo25yQldTiJivLrQkaunJFv2kJJQYZPkzIoVsDdHo9Dc2Gn+La0GACr
         oc2soT+3EtR+vnBdhb/O6McVPuSoTVfDQzOoGVG1TotusoCsBKrorxf2g0viv5BjMzdA
         FHPV+Kq1e684j9dD+AhcGW+eQwUW8H3PFc+cmvy9XRKD6kRAIfZI6LK/GH2EGzG/1+Ef
         2gZxnsKAYrrCpdky1bZwOZT5DB7gumJTspu3DS5MlZSgfMaCtMhEM1ektIlQDmtWGoKu
         G1YDVFxVDo3wkO3rj+0lyTTcjtPA2AoUsWJZ+TVbaCEVQW/IoOkFJwNLbSrxHq6/QWpz
         XVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BWrRFuEPfNkDDgiMO5F3iE5SYJuRJ+VyIA3mL6UAwNc=;
        fh=Dp+X2cS7uQIgMDD56uJMMcdmhhych8JQrXReCww+1VA=;
        b=khrTR9MAgWhwJB4BMA0iAHF+2fSYoa7GDQhLkP2Y+XXRjLe3cIfwQMpl23GeJJxZC4
         BygXQR9ACb9Kqjcsc5aYTYAmpK8zp36ryrdk8YtmQwsOIhHWcbq1JJmM71y0mOke3Q0O
         bDn0Xy8jasLIAGINFqsVVxfI9dIs9ollLm+ev9cOsEDyo4Wip4EbiO0fkYb4AztNF0ji
         ZCnce5viEM8Aa6csbnG3hLmwQEf7zKlxDRmEucFo5qLsu0LgymHGqshwIVMkmfV3y+8P
         gWQ2R1I9bYeHF6Yh+s0SDZk5qI81lMlpgdqj1rUNFN14HBBQwdbbgjk7xsv2oG31ZAL3
         kmBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tailscale.com; s=google; t=1795734966; x=1796339766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BWrRFuEPfNkDDgiMO5F3iE5SYJuRJ+VyIA3mL6UAwNc=;
        b=am1QVt0l9vBa1sGCfvHT6b+PUrVEEaddIEySPFstexs2sWRsezFksHnuHPmWkcWAQj
         qQXHPFInPRlIeh7sdYtyMjDkNjqmVD9kskQKqury2aWS5T78+NV71Y9deBIiai8WiOGE
         K+xWuMTlZnia2rKpP2D8q3GT7M4NDEfLjUXtirWtDSl3klbsaZ4KgGefQ299X+atrbfH
         JkjZ57CvZh17rgZFo61YmpGyMpAe5taTy+E0H5bPRWgnqL2nUWg0KecrOHHpW774z4Rd
         sIf54evJKyBWvxJLU0cM9FoHr5GnP6/9k79OHH6ByaHIv62NakQdkl8ObF6Tz9Kn+7ak
         XXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795734966; x=1796339766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWrRFuEPfNkDDgiMO5F3iE5SYJuRJ+VyIA3mL6UAwNc=;
        b=bwZsOleDWllk/as6QNIO/BAFP7h+V3NTiN/ofFRsVPuiJSHoB5wV8RD+Sltmcu+46o
         lLySdlAyy8nTsDg0YAjARwl6NBmT2NGLowZfhbFTkycgES27V8uYWgxamSenl9zZAsVs
         VyD0gGBafO4dgPH1UsPf5IH9vANQp1eaMe5j6qAQEbTQ9M4ttZnr2jVCj9xn+jxLw2k7
         DKE1c8G1Wy+WpF7vRxZJLpBraZQ4Jg4vIYZFwsUgRQxMBCc333VlDrBbMRpvhg+Phm6i
         VmaC+s7qLh8KJ3s+WDPcR15uSwxc32XTrqKWQDr5RKYG3ZaOr+yv8SQof+NzLt0mFPrA
         XD5A==
X-Forwarded-Encrypted: i=1; AL+hErETWx5DT1FO5PUNP5Bz4v+prpQOgVl5fyMDG3Gu+rOKjelulgHJpXppPch8JcVg79SisdjJf6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qa3wBPOoMrte3FX0I0lkrxNTAOcsEp1uIER1hrN7BH28OcFgQ
	dBpKMXtlm9BfUfPnyrNvbYvizr6EKmBM2UXB9GXdt2XXJRVqqgYki+cI8mQfdsLWzhGCdxnKQkX
	eZAGXlY7EzEgKRbRYWtCJ9ifCxgVkVo9Nbh6bvJILow==
X-Gm-Gg: AZFdTZfTpqHXdBRQXchzrdCwb5hYZeRrQ3467BbGj8X0DUuZCDNrOTKO8HKJv/+qBAV
	tmU7koRoANHmmCTtmlqHlBEyNXnWFsTXDkiVgwCA97D8RHlglYDe/PP4FJX2aRUTR2lDNclNStz
	QrGVv6XCKlSj4BUzPTysymwwmaSEV4x4HUyGYP/z52d1waZsRyyWYnh4f6md5Y9apYdA5G9G3J/
	AWWfXyium76ALWoznTaQ6e4PAKPKlIOp7VGH5s8EIvQJLElW/b8yMqjcMuQswM1n+VsbYx/W0pR
	XpenDz/emV6EXL4fzDKo/VVuDVKnhazCIXfbu5q5Q5OeO2bioN8e6LDPr8J50I0GdI0dfk8P+t0
	iX9DmQvpP5MjNajomSstpuaqaQMGpeqaZsDCyOmP/Lo/I5opKglAgY3kIFTPjgzU76I9Y70GrTC
	cvVvl0+4ifXGqPNsY=
X-Received: by 2002:a05:6820:6706:b0:712:b60d:2ed1 with SMTP id
 006d021491bc7-71b39468d77mr11717331eaf.10.1795734966468; Thu, 26 Nov 2026
 15:16:06 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126-bradfitz-kvm_lpi_active-v1-1-9ff28176bf66@tailscale.com> <86y0agx9om.wl-maz@kernel.org>
In-Reply-To: <86y0agx9om.wl-maz@kernel.org>
From: Brad Fitzpatrick <bradfitz@tailscale.com>
Date: Thu, 26 Nov 2026 15:15:55 -0800
X-Gm-Features: Aa3M54rQby0v4QzOGwyotbdQYWTk2b1yNxvx7ILnWqoqPCMk8Ods5BwBk5a9gjU
Message-ID: <CAMkNuKA0ogr-1pkL8Zg+cS_pwsF37mL=He7V-XowhvtUpWL5DA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: GICv3: Keep active LPIs in the LRs
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 12:45=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> Hi Brad,
>
> On Thu, 26 Nov 2026 01:42:04 +0000,
> Brad Fitzpatrick via B4 Relay <devnull+bradfitz.tailscale.com@kernel.org>=
 wrote:
> >
> > From: Brad Fitzpatrick <bradfitz@tailscale.com>
> >
> > Since commit 73c9726975af ("KVM: arm64: GICv3: Drop LPI active state
> > when folding LRs"), the active state of a virtual LPI is discarded on
> > every exit. If the guest has acknowledged an LPI but not yet EOI'd it
> > when an exit happens, the LPI is then pruned from the ap_list, and the
> > guest's subsequent EOI targets an INTID that is not in any LR. KVM then
> > relies on the virtual CPU interface performing the priority drop
> > regardless.
> >
> > That doesn't hold for Apple's emulated GICv3 interface, as exposed by
> > macOS Virtualization.framework to a Linux guest running with nested
> > virtualization (M3 and later, e.g. "tart run --nested"). There, an EOI
> > of a vLPI that has no LR leaves the corresponding ICH_AP1R0_EL2 bit set=
.
> > The running priority of the vCPU stays at the LPI's priority forever,
> > and since Linux uses the same priority for all of its interrupts,
> > nothing is ever delivered to that vCPU again. The nested guest's CPU
> > spins on WFI, with KVM seeing pending interrupts and waking it up over
> > and over (about 30k WFI exits per second), while the guest itself
> > reports a hard lockup on that CPU. With a 2-vCPU Debian guest, this
> > happens within the first minute of boot, every time.
>
> [...]
>
> This is a known bug on Apple HW running MacOS, which has been reported
> a number of times to Apple (both directly and through hypervisor
> vendors), and resulted in a deafening silence.
>
> The nature of the bug is unclear: either the host hypervisor is buggy,
> and it needs to be fixed, or the HW is buggy, and the host hypervisor
> needs to work around the bug (working around that bug in each and
> every guest is not an acceptable outcome).
>
> The other bug is of course in the spec, where the provided pseudocode
> for aarch64/support/VirtualWriteEOIR1 is remarkably buggy. But for
> that generation of older ARM specification, the pseudocode is not
> authoritative, and it is the text that matters. Dozen of
> implementations got it right, and it is surprising that Apple didn't.
>
> The proposed fix breaks all sorts of other things, and can prevent
> pending interrupts from making it into the LRs, as we now have active
> LPIs occupying LRs for no good reasons. And to be brutally honest,
> carrying hacks that make the vgic even harder to maintain is not
> something I want to entertain anymore. If this problem is to be
> solved, it must be done on the host hypervisor, and nowhere else.
>
> The workaround I can offer is to set "kvm-arm.vgic_v3_group1_trap=3D1"
> on the Linux kernel command line. This will ask the L0 hypervisor to
> forward ICC_IAR1_EL1/ICC_EOIR1_EL1 traps to KVM, which will itself
> emulate the HW. This is expensive (each interrupt will result in about
> 4 extra full context switches in MacOS), but your guest will hopefully
> work reliably (assuming that MacOS implements trap forwarding
> correctly). This is exactly what the host hypervisor should implement
> if the HW is buggy.

Thanks! That works great. It's indeed a bit slower (12% fewer IOPS, 5
to 10% less disk throughput, 5% less networking throughput), but the
absolute numbers are still so ridiculously fast compared to the host's
actual hardware, that it's a drop in the bucket for us. And even with
the trap enabled on a recent kernel, it's still faster than the old
6.17 kernel.

I whipped up a workaround at the Proxmox layer instead that probes
whether macOS is still busted and conditionally sets the trap flag:

https://github.com/bradfitz/pve-on-macos-nested-virt-fix

We'll use that in the meantime. Maybe others will find it useful too.

>
> Feel free to additionally report the issue to Apple (once more).

I'll poke some contacts at Apple and make sure they're aware.

Thanks again!

- Brad
