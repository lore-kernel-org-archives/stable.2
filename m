Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366122;
	b=L1IoGmzcKVLNH6mzBcD88doRJKYq9qZ3JfL34fjWWBV4gRU7PI3aL/Q3qnsP/E0NOeh3
	 Xx08FMrJwnvA8HaULHblIAFl5wnAqKb9znor3klfbKm66yAg/JjXjF+CG6EfksFdQ6mVF
	 lIqtv1RKNWTdzW2Zc1vNuy9fheWMWfYSrmN4PCgRxPuHHBgwepOheglsyUsr+fssTbh0L
	 CSILqw588WmyJIta1YH0YHBytZa25FkpLcDEDLqw66XShHo0YwdHMOJIn2GABmcxWPhSi
	 01JELRK5zm2H8HZDfAU6t6XwtH9FOqSIYPWo+V3U2R0pdub9Zgewrm6uKizIz8gUxJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
	b=NTxqO9PUJ8A26YZFnRsaA0/BOcCWOC3uU56kEatvLxgAV2YwCtzouftshgPq9/YmdzlP
	 Rct7gmKTcIZfwsNwy/6giedpmhM67EzBzA76JTQpUccfHRl4wIsk13lkoT29DaVUe3T6X
	 E7roNDT2BSRzuIqTxx1aY6i6iNZf5a+C/A4u/hrXROa7AZHcqnbH1dT81dgF57o3WBius
	 tGZtN7iwcbjF/J7i2eF64dJ25SVLHJZm8VXxZeg/OnhWfzMGtGEAlSUFdm3GHCPlIfEM1
	 9OUaIbL90Y8P4U2hnTUJSGaXL3pRvoTEs3RNobMv9LFelYIgJwmpClzEoDeF5S/vtNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmP75mV3;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390E606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 13:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4390E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmP75mV3
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a315ed211so865624eec.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793366121; x=1793970921; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=XmP75mV3neSqZ22BCv35kRM/Wm3vPyca4tPolWX1a69c/hYMeB4QTg//T+7dyBId7J
         9kTrfUoQzQgh7Fv67xnr8TRo2oZ6DnGTuh0RJrQsMUJsvl5MGRki3phVoa10KhO6uLOQ
         HPKQ2Gknd8SkAtmVZJVKe1M/MiwnhMt5pB0Ot7VCXPqLwcJeMOmUv+xmLt9Ep1dhtv2F
         FTGw00XcOZC8XWJMdqeuVppo9LkVY20+uHvGckz3QFPbgS4qQzy+Nub8qDvbUaTWrdL/
         7HIe853SBAp1UF5XhHNpO4RkYDmr4a0H2fJaxobMV/Y6ZYFXSrfsl4C3O/g2dBw1yrEq
         GJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366121; x=1793970921;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=lzGtGtWHee4Lu4/bUX67cSBZqZZX3+0warQuB8AYE0ACh/PX1pYHQNsLSLIKg0Z6m+
         aM9z8mjz2Jc3Y7FqcBHk3Dk0DCfHCQZx0IZr+otMrMm2KNUVoDynEykoiUGnRt7D3yw+
         ki0RcRvPoYLCyqOqgqbj5F5zgbNVr8HdWy0QCkEVW6Lj17BbCVY3JMoRmTPiWaTaF7Uw
         EWLNH9FhSd+lO4yihuRoAk7BpTZPYXm72j+IiCRVQ5jDemm/WgyRwPeKVOVHH+AY16yg
         I1daOy3u8vmSZqZWI2vbAQqJ/1nrgUqXgkZssaOd1TsXLU23PgBEYVZVxC0jUVzSLKzS
         1Aww==
X-Forwarded-Encrypted: i=1; AKwUvBz2XZEbztN0XInn2cn40UrtMdvKDXlu2Zg7ubNzri1i12nFif0gd0y2JmU+DqP0jh1z8kX1tew=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkkQrgtF874rO3w1CL+FLaMEp1hFJndUBvN7dwqOzzQOZZbbXY
	kIZHN2goUnigO4TntitNywgVRlGQYp2NkHxoiMXNsrOxsg2p26dsQwsNQailmg==
X-Gm-Gg: AYBFou0o0wtmQIDSof7XTw4Kw/V8UmakUQ9IxMPQX7BCQ5JotyynN/5NN8JsA+lTlu6
	+nWgZaGTwJryh0EGTgDyTYB88pcb1Xn48oEfmXUSH1d4TNd+ScD3o1WH1Dlyx6d6INOBQbm3+bA
	e0KG3ff9nooBPaIqQaGjwUzqOMCDmfW1CQLWlKgjRpNsS7goTAdhvcvfEe7S68JBlOWZQ6SFMhU
	YXOy6ORc0EfqMohPA+YkIPTQRgmtfXT2zJ0evC30EUGD63dsyMBsYWcsQwBdwAyJQ9acj6Rpsfy
	OlOUlQF+ubR6B4rMl3Ffs5uFni8gL9AqbCjhIOR8DQdy0Qyd5PN+kh0b/mvRKSowNUcm05NIDsC
	bKwoO51cn+Zz5iGxNfsZxeNi3KbE4qDkOsjGnWjRvohBs/Aqz1Wswd7fqiB7QY12b4fjDLDHFab
	IXidWwS7HqmyPVvE9JhIIvyOEzNO9RjV3YRAUmX/tX0TKT5SL0l0Ezh5WQ7oDmsitCarwskts2N
	bsm4foil/RJKvniQ8XPiFKR+MYS2BfpEG15kFdW3QQ2BbY2pCw3YsS55hX9GDjGlwY6ZRrWGfml
	9OGFxWAuzIL4SpFrgO7KR+qFA2k=
X-Received: by 2002:a05:7300:3d0a:b0:35e:2c6:d462 with SMTP id 5a478bee46e88-36a2fc203c3mr7157186eec.0.1793366121263;
        Fri, 30 Oct 2026 06:15:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10056827eec.1.2026.10.30.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:15:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
In-Reply-To: <20261012082922.218799-3-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 18:43:54 +0530
Message-ID: <a4nvwctp.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-3-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> In kvmppc_xive_connect_vcpu(), if any failures are encountered, the
> control flow jumps to the 'bail' label where kvmppc_xive_cleanup_vcpu()
> is called. This cleanup function exits prematurely since
> vcpu->arch.irq_type is set to KVMPPC_IRQ_DEFAULT at this point. This ends
> up resulting in wasted memory.
>
> Fix this by setting irq_type to KVMPPC_IRQ_XICS before vcpu configuration
> starts. This makes XICS initialization symmetrical to XIVE
> initialization done in kvmppc_xive_native_connect_vcpu().
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Mainly fixes the error handling / cleanup routine in
kvmppc_xive_connect_cpu(). The fix looks good to me, feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

