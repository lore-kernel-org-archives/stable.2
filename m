Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793662777;
	b=sP3bhjchD/wThgIrj7Z9YrD0/yrGfPPbOA3OHibYq9mUdO/Oas1ZGPJ7ffUJKTx/Pp2x
	 PjTzA0gTtKEBGAapIPLFXsL1KehV7tgE3jAfVsV7H4HuhuMQbn0/QdT82x148bDf0yoDV
	 uZzgC1qXLQ8Ky0hDKvc2jZezzGilcT8X3uV23Lf5jzT5PctZ0RCZaz9JZ6yn66LRSEtAB
	 GD0ucChNL/w1yG3+AjKqIXt9a/JNaearzClZ547wjpAtA1k5gbZlPf6GENinJcsI/bfK7
	 y0s6hnzvgb4jvZWv66V5qZ4lAxMCWLFMBYSGHoyarzfPNHXZ1GUq9ZTuLtwiWT0xXAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
	b=kbc/dB3grqNB3MkXWcGf/vAIWAEFbF+qhDNhShzn59mgYHJdwqZ6qCFCMsFb+1zKFQuz
	 Tes9gM85qvnCVvQwI1Ar5uKBNHL3XkxNvxk0q07hdQ8Fjx/xZcxGZN4pQRQJKSPadROqf
	 Ugj8Woe9u5QeGrQSBvuMczdY3nnfgwS7vIUEMU6/tkuiLo5gdsHYK0jiqEkXoI5O4LRdx
	 2WOOm3pUQOJdLhUG6tnIqE7qIRaucedUgrNsjAJlgiJ4M4vdHAHkXVYR7DcGJHeZC5ySR
	 reLN2d7RCNIOjQ8AQxfgu1XuqXE9xnGCxqJ3T5KNWCPPRQSinsSeID25Jw9Ac5XU5aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUVIaN0k;
	arc=fail smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2098606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2098606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XUVIaN0k
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1582a12.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:39:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793662775; cv=none;
        d=google.com; s=arc-20260327;
        b=WPjnH857xS+vDthrYA+LBB+6k9wBTASzoTA3YbFiw09vr9hJfrnO7F9ayHWSX1Qxbk
         nj6QiOpYPFS3klsHXYs23BxNc5hZmwiGNzepxn8G/OtArdp1mLyREMAPEEqwhyJBF6VS
         nrcpMwodHYTHxNdyzuZ6WJQGEK5wWtztODtgeWT0sluTNHivjTVaYwXKan8/5om2x10+
         ZoA2TYvXBrpqWqS3AJvZsdGbxHHc6DNwoUf1q4NPnSaXFoeuVjfFRmMonOS+WU8QEXRr
         LmV0QMkZ63x6hnIVxOXBtsNfd7aUF7oEhcLJ3+qDQEXiroC920LkZjAA3/YGtSZcEcEa
         DwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        fh=PboSP9bNNA3H8Qf2IuvaUcuN3a2OFFpGtWTAayYFHbg=;
        b=qQdQrL8Z0ejkguBtUWFz4j9YVn4T0+Ew1digdszc6txq253t0qOrLNpzqE7LkMpPJr
         U9migPjgd1nj/0mSUxPhAdimVm6q8ndTUSuDRRoKXQdpE7l3AlJ014ihRCQGQ7sip2jY
         6wuF6z+sEvjClO8j/AB1uQHAcXi2nNpCff9FtskaPleWfM+Avvlayp3btHSTenU43LdP
         ifquz4w6qbmkGdnJmdsBDXVrHRpc5mGR/Vy3dYjaKFonGn40lbCoyWtIWqGVwqmr4op8
         KPUr5mFvWyt8C1ulG+7Luqq6xcSEfFS3G/K9z7/T+xHgUFLqjQgM+QiFf8Pah/VVPlNI
         nS1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793662775; x=1794267575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        b=XUVIaN0kG8xdtu5h2ZGfO1duG7NUeb3NlnGwuDdCm7+GDP4sti5i3GtIgh/wGANS3v
         iLG4FWeU/XVJ6RmDWvjMsWFVP2ETCkzWNm6dvkWqmBfIMStsQjPPeFKt9onzqxRkV+9n
         SZqobE0JlV574RoDGd+Fk3S5HJchvZj1nbns4BOgjX5kWZ5+GqfI504FWg8QCZ3CduVA
         txlnmutgVLylcu9Kvuo57PytOMdh+52MKoLswapw8HS3LbMVWaZ+aOYTma39FPnOIL3v
         aolVSsmSvffPjE/n/j/IztRqZzgXtwiE2epckEY/tLPgbodm7hh+EjAE4BoQUwHS5z0y
         K9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662775; x=1794267575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+q4epD+/kjYFUHxTaUaWiSwNZ7dSox/dJ3V0P9S7xc4=;
        b=DSAUPyrQmpbReDX9V/th5GZvfhkSUdLI3kG6D2qKClU34VNN3iW+OAQIbcz/03RgSE
         bdHIQ9Rmpv4tGqLXK6uD/neRgEF3uDCTuIQTgUmuIAb+2zoWC+6I/l1L8gCxPxCSG/uP
         n1iIuvBT2ahDCopSe+naWtlMAKlEYSXosvp/wlFw7EtRDqfAbjNmGlHOHBnpqetBhE4m
         2askLZK41K+fP/06/D3j5Eih6/4FZM2ND1W9wZo+GsjN67XJMMuCjpmgt9LD8bOrtW31
         uuJ+S4GdSTgpowiprti24R+JRoCxZvXhbICnVkbovwiTzcNwVWoW6EJmp+DtC0b1N+ff
         7+8A==
X-Forwarded-Encrypted: i=1; AKwUvBxKtt9qqLvjSU43T8F8AMeV4E9hwQmHA5eP/YW38kGZ2c6Q+j52DIkA9BH32wCLMPGJgFJX8yM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Lib5jL1IFiOVWD1aIIxbGJCfgDMuOGaDNi3f0h9F7Z9GQEUEV
	77Cw/i4BosU3X7j/FPNPQqp6rbKlbi12ePiLiovM2g9cWWJ6SUd1ffoxTXnthcg3XpxWOlRklSs
	zV6LPZRrjf3p0nlMCvtud2N46jaPPqobkQDhbgnMY
X-Gm-Gg: AYBFou1HHjutq7AqJhk6QFiYW0L3q1bTNkmUQaItYHK1fwf5Wys+U0SsNPtne1ZaAIV
	viwo2YRzeoHrlVYzbAyrbHMHJElweS9wjvqyzpAT9ffzFgahtWU/hXIrbqo9o+1ZUc/1Wgyi1vH
	f+RTYrovr0IpljBImoMgJsgiah3wjui874K8PWokbt0fqxew/0z03EBRg8qyNb8CmfGebBB2cUk
	UacmsE1reg7xceHSjDLB5d9RCDrfS2wgDj2YfgTNbd55IQxb9Nj40L5o2GDrpCapCI//g7uHBxa
	CuVR0nBYvh8IfsQt9TubRIYgjfT6FFoSeu9XqsGmdgV2GZx6a9yDNMm+K7kaGaJUuYEzJCb0s7T
	ZIxp3aamIlOzdojS76drhNI8yXQvXje3GMMOB
X-Received: by 2002:a05:6402:10c9:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b53e764c47mr10361a12.10.1793662774603; Mon, 02 Nov 2026
 15:39:34 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-5-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 15:39:22 -0800
X-Gm-Features: AclHuK_llZQOnCwx54tZ59oMjrQu1r-_j_89HC5UjrdUh8dhwsQ0SoPYuUVmetM
Message-ID: <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add a missing "break" in the inner for-loop of the open coded mess that
> unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM-Fai=
ls
> due to a consistency check that is caught by hardware but missed by KVM.

That sentence does not accurately describe what the code does.

> I.e. move on to the next MSR in the VM-Entry load list after performing a
> write using a value found in the VM-Exit load list.  Processing *every*
> matching entry in the VM-Exit load list makes the processing quadratic,
> which is problematic if the load lists are full of MSRs that are expensiv=
e
> to emulate.  E.g. writing APIC_BASE triggers kvm_recalculate_apic_map() a=
nd
> a whole pile of unnecessary work.
>
> Functionally, arbitrarily restoring the value of the first matching entry
> is "fine", because none of this is architecturally correct: the load list=
s
> are never supposed to have been used in the first place.  In practice, it=
's
> likely a moot point as no well-behaved VMM will have multiple, diverging
> entries in the load lists.

This isn't "fine." This is disgusting.

The assumption that the VM-exit MSR-load list will "undo" every
assignment made by the VM-entry MSR-load list is misguided and wrong.

Xen, for instance, puts SPEC_CTRL on the VM-entry MSR-load list, but
it does not put it on the VM-exit MSR-load list. Instead, after a
normal VM-exit, it restores the host value in
vmx_asm_vmexit_handler():

        /*
         * Restore Xen's MSR_SPEC_CTRL setting.  The guest's value resides =
in
         * the MSR load/save list.  For Legacy IBRS, this flushes/inhibits
         * indirect predictions and does not flush the RSB.  For eIBRS, thi=
s
         * prevents CALLs/JMPs using predictions learnt at a lower predicto=
r
         * mode, and it flushes the RSB.  On eIBRS parts that also suffer f=
rom
         * PBRSB, the prior RSB stuffing suffices to make the RSB safe.
         */
        .macro restore_spec_ctrl
            mov    $MSR_SPEC_CTRL, %ecx
            mov    CPUINFO_xen_spec_ctrl(%rsp), %eax
            xor    %edx, %edx
            wrmsr
        .endm
        ALTERNATIVE "", restore_spec_ctrl, X86_FEATURE_SC_MSR_HVM

After VM-entry failure, Xen executes this code:

.Lvmx_vmentry_fail:
        sti
        PUSH_AND_CLEAR_GPRS

        /*
         * SPEC_CTRL_ENTRY notes
         *
         * If we end up here, no guest code has executed.  The MSR lists ha=
ve
         * not been processed, so we still have Xen's choice of MSR_SPEC_CT=
RL
         * in context, and the RSB is unchanged.
         */

        call vmx_vmentry_failure

KVM needs to do better.
