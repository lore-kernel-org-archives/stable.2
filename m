Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793666071;
	b=KQzRKIm7h/dAClQdytYkar2rUkwip8awTTxAgQ/TvXg9+jWsfATxvvLSv8jQN4OaaiRn
	 Fkl8VzKUx4DOH124d8VicROupnTrVq5Bz0mfXqleXOhuZSB+2WE42Dl2ZuFHhHxA5R4tj
	 oNKOkcxa8Bi4PM/EYwWtLhcIugnDtPwj3LENZkpDDgG8CuPYAOm2HvvA4U6RAP5sxHoh1
	 7zg2ed6XKSHDgiXojS+pzMegYCAbIUxeBIjaDa+MtQAnBELHfCMedA1QovStdULOdIUny
	 4HrAa3pGPT/KpdHwO+woWPYBBbIIiM3Pc1MqLqH+W7jMHHt9AR01e14LNjmjIB3koRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
	b=Pbsd230hrUHsGUUh3ESPvzksDM5qa0eoCEkgXh7w1DG/7MkoqbOlVA4B4X/4cHnaiXO8
	 ylht3bDvkPiBl1CgnyAAg5Zjax6/rHDRTtICrs2nz+feOL5RU4si7GOqTxIGmsPkpwnBn
	 cE57PzOFEo0tqOV0zmcH/DD4eS0oQHrQAXZtDjlSpfVyJN/CK9h7HoBaBk2j5gjvcrSt4
	 B+/a8srGJRIc+loBTedku1MS2sKBdIU8PWcslA8M3ee2AQTlZTtwdOeWq9zHWsxjcSxr2
	 asjzwwLDfLFYzjcR4GUOz7i++MXdOx4e3QGiATWSrjD9j4UXm6RpEAhmzWCMLgYxqEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cN0iJRAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60204606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60204606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cN0iJRAU
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1735a12.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793666070; cv=none;
        d=google.com; s=arc-20260327;
        b=fAzCTKQE99Uq5Lk9VptRImSi7ORYvC3XOzVtJRnFXlhc821KljVuZYrXBepqTGwIhD
         nTmHD9dLetAfjTzGJIPiR1Cs4J0SL3Bpu+cE4JCAE3nyOofhLHSABUjm+w1BhjneMYyz
         QzSFNIXM0WryWsPh4oa2zVrAyFtSYaOLcnyqHedqPufS/RVC5ZTftjMsYN5SZJMo32NO
         TXPflB2Q5FJ7xMdbLJwub3smk5jKZtCNKOuz+MY4QgwKwiqz0Thl3ImROiqzKEZOrDin
         Q/TOt8yixe3uJ84s+sXWyet3q9N9vU9/Ih3T7qo43k+MP1q8Xu0AiusoOTvoymodTUUg
         zncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        fh=Q33aXe4//oQSHcFbDN4Emf5nzt5HfoLh4f6HSFA0rKs=;
        b=qR3ccQ3FpIyXV6yaUNVJYlminb6hiyznAEApHMaSYjVUU4jcPbgxtPUpCr4z3eVFpu
         dKrtAozQG0P4PIrobPgQ0NGLCKY5XdyJfCnsjNLnIAzeeILS557mkHO3JFSxBe+H61ZD
         xfOYDmt28MI50eX2e67JG4JBKUVEahA9C9DWTLr+j2QQdgmxYY06PUP5IeMuN5E7IcLw
         ourpgc7ZbxH9YCR6Qpizt18cilx2bdr847gIutUv+DKIiZbSfujE598o3Z6rH6gslPFB
         /JD6ULhqUwSrctD8mDMmB94/S0Xn2K8IaNGVYpsmHttc7/j/ebhjNe5OYSg91Q7vUhbs
         1fEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793666070; x=1794270870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        b=cN0iJRAUZTWFJPu2xP47AzsFQwwDHlwRCp7tiGw9UzXTtd188TpuktVfe6W+9lNWhV
         g+jnzckczYT/wyawEqJc5CL/by6p42E1nf0netC4eThk9nE2yVcHZE4D5kd9k/ZAxaoI
         R/hSnb2l0ZoSQVN4zpSVfl7FfSUqMvI/1bndhyA6/R42v8QooZU6mwhlJzBBGKvwp1Xw
         4YN8Z0uBLqNu/pp0DcMrFF+k+KTqx+i7jJ7z5qhlb3805snE/lZU03LjQEcEOC6OMopk
         3MSrgral6YurjGusBMxiFnhAI8gp3gxYzKC+57v7xz9WaaPXN7Nmn9kf6Qs9bwrouIqo
         9uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666070; x=1794270870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        b=IHil67FYprzF9srqgntYG92PgZgZXMG5S6meltcY2yaJpJuRFzuAaLKzaV5PTJlPIa
         lEax/wCoDDtL7rb5Wgv212kvN4+f2CBhSEiYLK+5uHJc8Jr97OR58TTcnUc24/UCPDEc
         qnMrHhfodrX7LG4MwY/IVcN+TsGuWuxxbi09HvvYS3cqK/JwQs9J4j6aXHSeffihJUTH
         mTvlz/dml8SHUAsYjTf9l2RV8YuB8kobLw+hfH2SW4K5fVl84cOWmH4Vd35MlsmDL+k+
         zytSV5cz1oMj6qJbh71MDBLAxI3bdzHD97KRkp6b4nsnadMSR5wsAHda/zMghcbPShHZ
         9IVw==
X-Forwarded-Encrypted: i=1; AKwUvBwprBFGBAGOtKZah1eUpq46nnm3U6jzBwLxZc3PR3+JqPmbwZY+1KuKKrsHWTtoDmOfpAxN5fk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BLjQdY+lsY64ODuE4MApo+AHoS/ivDjikMJeoF6dKsT/mavIR
	Xn7bxzLsEPLmNzPNg9bK6CS+Iccam2MVbethfE+akqUJUjzcaHrQkTi2/NvkkME0bNnj9oojvNb
	cB4i4gtMsfbsQSzL9yqg2P3iV1GrLKCx3xWMGQ8Sm
X-Gm-Gg: AYBFou3GIymL2DAEBLBW505U5V3/X8TOGWyWpZgO7+J8irvtW7Ib1wQuLozH9xhySHP
	fmqUEwv2ZKsGO1xX+K4jA1a6X/+aqL7jNfUSJ4myiGvNwCN2akd3I9aWKR7gVpL5n3QEJx4r2Nh
	yvIbySsixep2LTWWWlVaDRme2tg5KrCN12ANdJC/5XENV0NsQOOZbme/IhD56cfQs3qCeGkIChC
	xTCQFU2+cufNtWNeiRHuRwqHLfivE+YljAH7Nlq1wj6a5XuUoe73yv28ruy/G0FFyWwb2QLIluO
	MEg8h/rBB2ihiFmVdxiQbvyeQETR1GwfoRDzlpRE0xZZ8UiLO3lVEwaa1BVAFL+hQDDP0AAqiAp
	n/e6mxgt+XkhHvPHIEYzrS1xu0YWz44uSnkd9xDdNa1T9vZwripXjMTKa8w==
X-Received: by 2002:a05:6402:23c6:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b53e99397bmr14504a12.14.1793666069308; Mon, 02 Nov 2026
 16:34:29 -0800 (PST)
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
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com> <aukmeb9mV8b504T6@google.com>
In-Reply-To: <aukmeb9mV8b504T6@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 16:34:17 -0800
X-Gm-Features: AclHuK-5rtlAEwRRycyUXrlFAmgT2tBIF1kZJbMFG50_yS4OyXqjAn6qnB5u6Ck
Message-ID: <CALMp9eTm1GfVTSCroWNXi_jeGcnEg7AfxEhcqJyN4s_v-PWcmg@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 02, 2026, Jim Mattson wrote:
> > On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > >
> > > From: Sean Christopherson <seanjc@google.com>
> > >
> > > Add a missing "break" in the inner for-loop of the open coded mess th=
at
> > > unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM=
-Fails
> > > due to a consistency check that is caught by hardware but missed by K=
VM.
> >
> > That sentence does not accurately describe what the code does.
>
> "attempts to unwind MSRs back to the pre-VM-Enter state"

KVM makes no attempt to restore MSR values to the pre-VM-Enter state.
MSRs are forwarded to a post-VM-exit state, as if VM-entry had not
failed.
