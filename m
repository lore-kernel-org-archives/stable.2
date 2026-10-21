Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613840;
	b=iw35zKFKFgUBdokrNZCqaJ5fEUUSAs6pJ3Rok9ASSjTy0Ke7DK1yysx+GZry1ldeRx/q
	 G4+x065pxhFElEB+MIWrTtfFb3Bj2WiiDnsZX2JzLvorEr2g8UIF5xOtPyYkadbCyjyKa
	 3NlAhRobNr6dCoXj0BlxJw3jrGcjAVz7nmU6DCpMJgD3QHvu0+RKhtLJXssgj8GUVkal1
	 +fswJqIpVeOfaHvO4zmSFQ0cJ+kfmYv8uB7Nh0gvSXYn8GdS33QRB+T9Yy/s0GSBhc0Av
	 AjWZrnJB5z1qKxWDlakH8YTOGDELUfhpQEqRUh4D54prSRs/zLHxHDoAgl5LcVgxdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=y5zGwiWlY/+7u7tVy4Nz9l+XQayzXqtSRL/HPTqEiC4=;
	b=jImvSabeLPU9Xv+oDRfsCHOsG/mhy2vfo577TinYmm3uh1u7/OVTwxmZWgPM+JxAC2tO
	 XLE1CCXb9VKiHiHmWrEkBPhSDhwiuz7L/TBZT1HOIwREW+oS565NgPqNFkfJw2DJ9eR1u
	 PiVlgbleh+F+CMduih3sKQQ1JswE2DwfPy7rOMJ8lyS/x0rws+uo01+E2gSNIsfWYyHE4
	 75Cw8chA7zJiV/YUpx/wpQZd8jL9C6b7hJ1RkYImeAUh8b3Cm1KHN5UENbQgQt7SzzBTC
	 eG6YonzdI4HRM9dnriULVU2kOo8J9lcBscF7YadFa9A2NOCfWBXerN0IwLNU2BJy8Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JAetp1ki;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62AC606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62AC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JAetp1ki
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89f9fdbabe1so1459165b3a.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792613839; x=1793218639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y5zGwiWlY/+7u7tVy4Nz9l+XQayzXqtSRL/HPTqEiC4=;
        b=JAetp1kiqkjzlxZL8Jo5eBGSC5QmvhuD0DO3wx9QMVFZM2GFR+8xAh4BTJruUr8+IP
         Xl7a+9mL4boAb+Uz1za5fjJgByqs7v+sNwrcTn204r/O7aUk4OOsFjq/Jv/ahitzpduV
         SVCruaUS5OUIAiPfcVSDyxjxx4tpRF1VTr4UajXW02W24ozBnI8JIfkBnU6lq41gP00b
         0wMd4qv9FpV+lQ5uCEBTIDAr6bj5g13v2x70/KA8Y5FfYVE1HVYwopLs75ilUgrjqF6C
         jBVSZAAwjC7E+RN/cj7QIp5JkBjiyxEv+AvSyh+KfxItcved4Ol/oaBkFVVjVoqQV+Oa
         PBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792613839; x=1793218639;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5zGwiWlY/+7u7tVy4Nz9l+XQayzXqtSRL/HPTqEiC4=;
        b=d4+DkjtTfLV0+TR0YkD6F3LhKb31okU3fPx/8Rx8TRl7O7S0xYbmH7qWSaeyJNHQRh
         nSWDdT/rVqpn8mrpP2T6pjlQHPY4qA+Q09mLlzXn3sVofuMYziU70UD+csjCbP4yrm5Y
         o+WQKwxDsCP4HHC2gy643HwvD3ro+UZuuP5DnwWjkYuHscDth7jeEqsGX4XjPKDCy3pP
         zy71dGoU/726BjZAs1fPL/QAH2XcBcQXnXATSkoEdR1eL7ACmqBB2KhUXElyX+480W62
         e9dYryG8nfCJm02dfdJJ7T0kgFRO13mXpOtUExDjLyffUDjPXHmRnqRC5TsB6gPEcxa8
         3i/w==
X-Forwarded-Encrypted: i=1; AKwUvBwA+Qv51ZHpNlfGrXQXAGFTLgDT4vjtTh8gRHG3HAXmevVsi23btSkn8DSpBqseendf3VJ9gVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6j46PHc6XXOVTTtJbDlEjPstDY7uBZNjaV1gQDpOyhAu+tW0b
	GCLEYKF4xA2tBJZ/L3ZXTDvy8CcYgvPGmnMgD1vwm+ZatCBnnA2fFMNbFJmugxbMMlNLBGo9og9
	BFj0mWw==
X-Received: from pgbda1.prod.google.com ([2002:a05:6a02:2381:b0:cd6:9aa1:6906])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8d:b0:3db:4e0a:df51
 with SMTP id adf61e73a8af0-3e287dd6182mr2176941637.22.1792613838826; Wed, 21
 Oct 2026 13:17:18 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:17:18 -0700
In-Reply-To: <20261019135441.1420968-127-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019135441.1420968-1-sashal@kernel.org> <20261019135441.1420968-127-sashal@kernel.org>
Message-ID: <atkdzsPJgcu123DO@google.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.6] KVM: x86/xen: Prevent runstate times
 from becoming negative
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Paul Durrant <paul@xen.org>, dwmw2@infradead.org, 
	pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026, Sasha Levin wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> [ Upstream commit 36a85200643e62d20a91f0bc1a811187b59f7762 ]
>=20
> When kvm_xen_update_runstate() is invoked to set a vCPU's runstate, the
> time spent in the previous runstate is accounted. This is based on the
> delta between the current KVM clock time, and the previous value stored
> in vcpu->arch.xen.runstate_entry_time.
>=20
> If the KVM clock goes backwards, that delta will be negative. Or, since
> it's an unsigned 64-bit integer, very *large*. Linux guests deal with
> that particularly badly, reporting 100% steal time for ever more (well,
> for *centuries* at least, until the delta has been consumed).
>=20
> So when a negative delta is detected, just refrain from updating the
> runstate times until the KVM clock catches up with runstate_entry_time
> again.
>=20
> Also clamp steal_ns to delta_ns to prevent steal time from exceeding
> the total elapsed time, and handle negative steal_ns (which can happen
> if run_delay goes backwards across a scheduler update).
>=20
> The userspace APIs for setting the runstate times do not allow them to
> be set past the current KVM clock, but userspace can still adjust the
> KVM clock *after* setting the runstate times, which would cause this
> situation to occur.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Link: https://patch.msgid.link/20260728144954.355376-21-dwmw2@infradead.o=
rg
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

...

> **Step 8.1: DETERMINE WHO IS AFFECTED**
> Xen-ABI KVM guests with runstate/steal enabled (`CONFIG_KVM_XEN` + VMM
> setup). Not all KVM users.
>=20
> Record: [config/driver-specific: KVM Xen guests]
>=20
> **Step 8.2: DETERMINE THE TRIGGER CONDITIONS**
> 1. `KVM_SET_CLOCK` (live migration/snapshot) after runstate SET_ATTR =E2=
=80=94
>    documented, exists in this tree
> 2. kvmclock discontinuities from masterclock re-snapshot =E2=80=94 still =
present
>    here; the rest of the series is **not**
> 3. `run_delay < last_steal` unsigned wrap (ioctl uses VMM `current`;
>    vCPU path uses the vCPU task)
>=20
> Unprivileged guest cannot call `KVM_SET_CLOCK`; the VMM can. Guest then
> sees broken steal forever.
>=20
> Record: [migration/SET_CLOCK and steal wrap] [realistic in production
> Xen-on-KVM] [VMM-triggered, guest-visible]
>=20
> **Step 8.3: DETERMINE THE FAILURE MODE SEVERITY**
> Not a host oops. Guest scheduler steal accounting becomes permanently
> wrong (100% steal for ~centuries). That breaks guest CPU accounting,
> load, and can stall workloads/watchdogs. **HIGH** for those guests (not
> host CRITICAL).
>=20
> Record: [guest steal corruption / apparent 100% steal] [HIGH]
>=20
> **Step 8.4: CALCULATE RISK-BENEFIT RATIO**
> Benefit: stops a permanent guest-visible accounting failure on a path
> used in migration. Risk: ~20 lines, no locking/API change, skip-
> accounting is conservative.
>=20
> Record: [high benefit for Xen-on-KVM] [very low risk] [favorable]

Two questions: do we care abou this specific flaw, and does anyone run Xen =
guests
with KVM using an LTS kernel?  I agree with AI's assessment that this is lo=
w risk,
but unless this will actually benefit someone, I don't see the point.
