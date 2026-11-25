Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600296;
	b=4V/f4e7IUR8rl7MQB+LLU640/IRU3z6hr6TRZc7gGDr6Rp1afFrLwiLFhdqS0PMRi8jl
	 CpzTV0hnC59o+Q54bx6s23fpzi+OfFA3JJu0QqsSczD7tQ301hGkTcqJctyKYi+T84JNd
	 aZDg5o8NWv+Y23R3RdOKAo0Cpv9X9bxRUZCwzWs5Gp/IwlOKnxcY9R0Nmh3gfDpNOl3Hc
	 +iQBuBQkMnt0YJr4xLUWO9CWFoxHRxlHamncCthX8FlYlBIM0kMSjfS9vRLLJv/cE7A82
	 yougXpvptdm01r282zUdE14fMnGJnixbTYdAyl0WqBPUlWnHgiwuyV2uZViixQWm8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
	b=sQ3yekCZUUAw88IjQavlXKj6rw71hwy6H3Uv1oYxjum6sBxTIc2df1GtsdQAQOi7NHKC
	 rbWGJD2a0G7qRKdNlP17NwrpuK9Ux5un9KPSQKFKZ04DvcaQMqcbvRAue2n6+mU4oqrJu
	 KEQCu/Vw7nj2pp4yBC11sf2KpindGuSZz6bZ/6dNuGkRknCKHKdti/jGEWUcQiFkMUfY4
	 tQ3kv9hUwGIqZcAySLIPMbgP/91ytLrgZO+u8IqaP7qnpK/ZTvGIwZy/5W6yek1WpUhhy
	 3Cam346VzcyeWPRpdgHvht025Y1lCuVnaIaCUxbA9A6q85w1jHkPaF/fQYBSQCK/zwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZOTq6OpF;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58363606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58363606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZOTq6OpF
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso3154330f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795600295; x=1796205095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
        b=ZOTq6OpFmLPEfwnp9q8dUA0AGMbQltxU+d0PUMHlX0ejPnYg8xRfbNG+MkMuq8ouPF
         5RwWDOgzMMtcvTSE1C/hLlzuPiUQZYX3PnnJM9OCcyC4YCghxnmn2ED1I7REeawXpTCc
         MyodRJH3uu2ySM5gCJ/RnduJiUL0Nhy4hv+PIvQmV/D1LKJfK2K6YOZlhp9JNcVh5a2t
         LEDl9PGb5xEqTHmHMEv9sbGjoXm3iZeDTi5n+DkZ471czuXyZ1YJfsLVhMxtY1DpivDr
         iRWqJ0kdppUTHXR3FCsll2AVQl7nQYqA+aC7/G4RW9Ncsk96ZIwgi+Vay6i6h04XGVfy
         /Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600295; x=1796205095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
        b=pqzcDos8uuKg2/+9o1C5trBC0Pu3c59lf76y/qKkjoNi8lyjitq+jpDmy44Ojt2sVG
         zFoPTqeUjD6CVE54v4lPOS3TqVCCRM3oZ/PUZk5q2rRE/1SSTA/d7D5qV5Iw+WGW7nfp
         vaXX5M3fHlRxDpRc0UXmJTvNnqMjtLM3YtesTFe9l7hIKcJ7SdLe9ML9J/bJIQlgMEqI
         vu72k+d/XtPbLH3C0GelZvXofDCdOQ5H0sIUKJvEKJjw6unhNMTRVSeCGtdbSQcLPNR5
         mJUnOwFOhGEXjAZNtFoaIsNrzxHp6fPDOdIyX2J+RZ2hh5/K1x4BUejVm5APVV6rK9/9
         UKuw==
X-Forwarded-Encrypted: i=1; AL+hErF0WqhOpQ8eobdoX+VOTDJmjxm5ctzohk8XTyl3h9ZzrqPvQtYp9/iW6zjIlkLYiV3vzSbYoOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b/SIPVPO3RQrcPkd7ZSojEY4wnyFD+TfPBvbvGtOLn1Y9v0Yz
	h8Yzd8UUEYIt47wwViBxNmTadwqDpjqhZX+vJNnx769ehjJqlhYIaH7c0bBoUwcq9k4=
X-Gm-Gg: AZFdTZf89y79DJ+HSz951xYptZCQDe9deCl7a9JvMZG/+xfkf+gqEkjChHZDWhNh7Nm
	zw607LF9S5+XhcHiIukG0hy8qEQ1eC7/gMcaNq2QRxLJ4d7zVXnPRYj//m71IadDOTpveKfnQ3y
	P+QFuDKDH45FJ24m4LP6dmeDEteaAcggbCCIUHkILMBrplp7fZl8Sj1c8Nu53TkMgTlHD8JzPtu
	yT4e/lIyz104SChwkh6yi/X45oH6KpcEPb2+MkMxd++1PTT0w7/68N/M8/Yg+wYfh7y5C3gXWND
	hSwVkCohfFQrEarGBW9TFzDqx0s9pOX72XsYEn+hJX/c1dFrTBmseitTE7ko/ljJqJJp7XK8vAd
	AOvb4ebDD0osfi+JRiJv33TFwy0bizrKgJzh+1rguWNwa9+1PCRewk/xK41N0IYtW1bnOT5hGbv
	OTn25yhrtZWw83v0X1nvq/eyixD4BVpVaihDhtAmp1JgrYRLGlJqcH55BUcmGVHr7kZkCh0pGl2
	Pbj9yhPFZ+9Tv7OLla/3eiHZeMn2/fjKHj/gOctTXrC9FOnhOq8SMphhmvRzrP6y0wlg3KjNGBN
	okjnsU/0ZY6tJWsh5iQ=
X-Received: by 2002:a05:6000:4617:b0:4a9:760f:1824 with SMTP id ffacd0b85a97d-4abb19c153bmr33040480f8f.21.1795600294485;
        Wed, 25 Nov 2026 01:51:34 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm32867213f8f.42.2026.11.25.01.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:51:34 -0800 (PST)
Date: Wed, 25 Nov 2026 12:51:30 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <c.dall@virtualopensystems.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] KVM: arm64: nv: Replace a pending SError when
 injecting a new one
Message-ID: <awavokPJT7G8J2fX@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-5-224689d8a764@pereq.eu>
 <awaVj0Aa6dMSksxX@kernel.org>
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
In-Reply-To: <awaVj0Aa6dMSksxX@kernel.org>

On Wed, Nov 25, 2026 at 12:00:15AM -0800, Oliver Upton wrote:
> Hi Dan,
> 
> On Wed, Nov 25, 2026 at 09:56:20AM +0300, Dan Carpenter wrote:
> > The kvm_inject_serror_esr() function injects SErrors as the name
> > implies.  The bug is that it doesn't handle already pending errors
> > correctly in nested virtualization.
> > 
> > In vanilla KVM the kvm_inject_serror_esr() function always sets
> > the SError to pending.  However with nested KVM, it might set it
> > to pending or it might deliver the SError directly.  We can only
> > have one pending error at a time.  Imagine we enter the function
> > with an SError pending already.  In the current code if we decide
> > to pend the new error that's fine, everything works.  However if
> > we decide to deliver it directly then the pend flags should be
> > cleared but they are not.  So we deliver the SError directly and
> > then the SError that was pending on the next exit or entry.
> 
> I could use a bit more color on how we got here. From what I can tell
> this state is only possible if userspace changed the routing / masking
> of the SError outside the context of a KVM_RUN. Otherwise, if the SError
> is deliverable on guest exit we perform the injection prior to exiting
> to userspace.
> 

Yes, but the main reason is that I'm changing the way
kvm_nested_sync_hwstate() works in patch 7.  Now every stored SError
stays in NESTED_SERROR_PENDING across handle_exit() so this situation
will become more common.

I will include that in the commit message when I resend.

regards,
dan carpenter

