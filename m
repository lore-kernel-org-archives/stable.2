Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861441;
	b=P6nmvLqnPRQ73X/yutZZv6UyguHRD27nSMXZckdtSGrUU6oPpBtUfqM6nqPyIpFtMn6H
	 xHP/wUepVOvx4RyKcsj9ctGsu/O79ay0hi+Ytn0V7CwQ94eACBYWGy6URtqf54Qe2+65G
	 1LFa5vN6cJXJo9tcP2xnz9cMn+kZKC5RXyaES4RCWzVOi+vSkE8zwSEzcWN94r5dw1Xej
	 1ptX3WGAJOG5dNF8WAyPH9zF7hsOGVXpae1cBZgysXlA0Irqa72PnUZxnOZFSDbjx0JNE
	 uPBxGJ3dcgKPm5YivryXOu3vhmy4qDwLVk+cCpOopv9a0t6r+asm2xcJHYxY/7FBCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861441;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=8q0lR6QsKstdpDF4gJX9VbdnKsOKt9hZucknTnB2NSs=;
	b=KvsbBvjKaNheaOwd4vu8qtYKjIy71sGeCGbmoLdZnJYpUUC9DkH04EqSBDK+Oenx5O/m
	 glpYouY4iImskRFOhrIIQKTymrdh/mxzv1bYKO+usRr1hGe88SVanVU/eKOJvJxthSIoB
	 /uJWrFhnBjsYazfZ/Qp+qfopqeIWz/odoaJAg4+keVgN017IgpWXCZzOiw9iBglYbS02V
	 P+IjhTr90wbI/nG7yR0ru6kJ6sKo656yfHG6HH1s+uiOFoBD6jzATApm1ntHI+etNMf/U
	 MXtJn8txpt/mBoW9ET4Nf6jJ7cgKVIJzkRBDzspMjNkjyi16MVTkM2Z90QMqgnEC+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c3TwTvht;
	arc=none smtp.remote-ip=95.215.58.182
Received: from mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156F606A324
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2156F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c3TwTvht
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8q0lR6QsKstdpDF4gJX9VbdnKsOKt9hZucknTnB2NSs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795861438; v=1; x=1796466238;
 b=c3TwTvhtHbuwWrG6yBoiX+Pe8lfB4TnhtX/sPxIkSO6sP61kzKW1W8mqsP/n4UUopPda1pY/
 hChzarSkiZn3JRyoH65k9pejcDSdSyyhf4zwXQei3514/v9s4zKcsTBiCmeL+u+SoD1hnXwluJW
 YzynQkd/waCb1Rrl/I9FjE/E=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 095dcb7114e15562;
	Sat, 28 Nov 2026 10:23:58 +0000
X-Mizu-Trace-ID: 095dcb7114e15562
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c344fc3e3aso1775e87.0
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:23:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF2fZCAt9fA58EmGM3m65dVgIvHQkHMhnBYq692HsoOPPrmyXiHexQfc4RRm3FdTKTQTPFuF/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L0FeRFs8LtaiXxD92LURg6RGjxtf/ro5TnLhuaMQqNj46kblF
	uUk8zRSYuSw7wh7CNHbs1Bt5PCdGiOCfCBnKHI2bPvpCYC2NH4ctV4D+gWflducDV6X29NYTBeP
	BPmb9Qsm24Vi3cqhFqKqS3fk5S8wdy2H6n/1nSG5p
X-Received: by 2002:a05:6512:a84:b0:5c1:5bc5:f373 with SMTP id
 2adb3069b0e04-5c222dc93ccmr890373e87.15.1795861436887; Sat, 28 Nov 2026
 02:23:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127212743.1139739-1-vdonnefort@google.com> <86se0lxpti.wl-maz@kernel.org>
In-Reply-To: <86se0lxpti.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 28 Nov 2026 10:23:20 +0000
X-Gmail-Original-Message-ID: <CA+EHjTy15GC3=c7MvQu7eKON1g-v8KFzYXruoTfWvoSdBOnMCA@mail.gmail.com>
X-Gm-Features: Aa3M54rBUeM9GDr14iZtDQNqhNurSw8bWhfxNqaGvkRf8d9q6kTODFktkvbCXtk
Message-ID: <CA+EHjTy15GC3=c7MvQu7eKON1g-v8KFzYXruoTfWvoSdBOnMCA@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: arm64: Use CNTPCT_EL0 for hyp trace clock
To: Marc Zyngier <maz@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Sat, 28 Nov 2026 09:34:01 +0000, Marc Zyngier <maz@kernel.org> wrote:
> On Fri, 27 Nov 2026 21:27:43 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> >
> > trace_hyp_clock() reads the virtual counter (CNTVCT_EL0). Under nVHE
> > (and pKVM without hVHE), loading a guest with a non-zero offset applies
> > that offset to CNTVCT_EL0, corrupting the trace timestamps. Use
> > CNTPCT_EL0 instead.
>
> pKVM mandates CNTVOFF_EL2 being 0. Has that changed?

Not for non-protected VMs. flush_hyp_timer_state() zeroes CNTVOFF_EL2
only for a protected vCPU, and a non-protected VM in pKVM uses the
offset the host sets. Without hVHE, the hypervisor's CNTVCT_EL0 reads
then include that offset. I saw the trace timestamps jump on QEMU with
pKVM on a cortex-a57, running a non-protected guest.

Cheers,
/fuad
