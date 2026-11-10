Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335712;
	b=iPXNNObKjUK8DR5S0wLZAHNfdsk19XdN1e9y7o+EY6r/w2Ozv4VexHxIegspw2dGWbPq
	 ddxjMYL/aPalgc8HqYEAa7+QmZ3kwpFlYFkn592iUAh+A6J8qtQ+NRcOnJkPCVOQ+Sg11
	 Op8ats/SVzgVYv4oR2gt0x1XxIesAGwI70C5LIYLTN8Rtnk7TAOSHVnGO0OlToqqlLRSW
	 IufZ26vCbrc4XUgzR00P8bq2zjKrySS+XhsGEx2nyEtgwBvH4ebGVDnvia0a4n+qX9nGU
	 qWcBqcjZIrDhH4uIVzT7eH4GvpGa+atpjUceSAcjGaDAKL6qKS6JTzdvHYKze5rozqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
	b=nZQeT0xuS8Vt2tOaOcAgNMxD0NavfaiCK1D6Ozd2ZQQS4DhrcWxQjRlsn3Y2EyQcn0L3
	 8F39geKQ2P0gt2CotSZY2Q5Z4D6a2bqMdDaqt22vNSjsThzw12kEj+412xhMwDyqpZFNw
	 yT83lKelcZpB4myLPS4aJ7oyHP/rQLQAWOuq1FJy6YDuypbbTP1rawAbrBKl8pRXvmcJ9
	 DZokVtsNC/F5zwBiozrM3GX6SIviK3WPv/rvTDFDGPNtH9om1ADzr87R6F8RbWdtvCcYz
	 XfRgwRbzsexZF2yisw9R/qKHkEk3ucMRLlsnmuDrigRZNszok2RhSetdV0yCxDLuGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctx22OId;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4C606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB4C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ctx22OId
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso2482219a12.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335711; x=1794940511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
        b=ctx22OId3b1A89h+/g0DLFFIvF1rE/LJiVCOg314dN1i0WsgjGNLUdr9g5ogDUofXQ
         iTytv8eWhKYvvAc1PGv3tO469SZSEgiiM8pzHozoBPZ+JLjj4U60kg4GE7ooJgxxgMLD
         yYkNR/2PgzAqsrdBgcDkGmqae2glgyxhphW8A59/68tE1XL5f9uZe+BYr1Q+iDODYe5d
         DYjN8zKbWgC5M1atPcdss9TOVd98YuPqehqpzIzO8IOUKFSKplq5o47oSsn2tnQxaxmm
         uT0VRNaOVvoGtA5U6P1PyJMJR89m+mn5fyW1gkyhmmAlacc90Jj+otaDm3KCwrVsse/H
         ntQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335711; x=1794940511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCp0Db26sWh4sAbqSPzWp1M0J6ydStL+IzHoLsVEdug=;
        b=U2m1C3yic/CHS+eGrybYwHJRhwLHqEc7V3/QyU4xW5iqKD2mBxsvoO7Uh87pwuotY6
         ycs3FJgxolBJ81imVDyaWDv8Lcr/p/cvGpjlD8e+uc2zCraQ8kJGIHnejftPtXV2QWVX
         /xboCsoWSI4NkSjqZ8LnMPIGKDUmNM8+40844wqTKgifEB3p3cZqDsALy9IcmFKSHEs9
         +znfvPMoMPbZDe+/g7vVPGPzI6PEWVVdx67M/1ddbeAaGwwj7q6x8gXmXFmGI5vw4llH
         b16igVe/c1fuYpyFfBmQbD1FI5IPS74LkgQrwTLlmQCXPOwLXkoJPs8SVn9k1omcroxS
         Valg==
X-Forwarded-Encrypted: i=1; AL+hErFAjTDNx6A9iyfZc0pvhCEo09Yu472/SBz6CXp6AFD/9TBRdBTZzBKraIWfgKto3PTMHW4yFnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wm1We2N7BIUYO7iuC7ncBh4zdnsPEQaxtzq3mJ3fLo95IXz0w
	AW7e+CnPcS4ioCg6y0adwYt8vByUTgS0hzf0UvCqjJiN8nitJ7FJ4oXYRUefgz1zzCai8W5ly4U
	j4jySXg==
X-Received: from pgbbo3.prod.google.com ([2002:a05:6a02:383:b0:cd8:ba74:813f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7907:b0:3e1:bcb:1d19
 with SMTP id adf61e73a8af0-3f1901885e4mr3216153637.67.1794335711215; Tue, 10
 Nov 2026 10:35:11 -0800 (PST)
Date: Tue, 10 Nov 2026 10:35:10 -0800
In-Reply-To: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
Message-ID: <avNj3kdnvQiY_ity@seanjc-mac.roam.internal>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Fuad Tabba wrote:
> Hi Sean,
> 
> On Tue, 10 Nov 2026 15:48:37 +0000, Sean Christopherson
> <seanjc@google.com> wrote:
> > On Tue, Nov 10, 2026, Fuad Tabba wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> [...]
> > > @@ -4461,6 +4461,12 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
> > >                          break;
> > >                  }
> > >
> > > +                /* Like KVM_RUN: only the iteration crossing the soft limit uses the reserve. */
> >
> > Please don't include AI comments verbatim.
> 
> The series is LLM-assisted, but the comment was actually me.

LOL, I think all of us are getting a bit corrupted.  :-)
