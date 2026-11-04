Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816160;
	b=EHbVj7tf15z8j6gI0Vl/MTgHY/ZPv9QvxZYbAfxVdth7YyGLGHuJ7soR3XcCs+T6whf9
	 2A8n6r3+/miiVNsvUttVkLsibe7XoGiIxuHlcsORVTIfDbimwL5+UKQMikBww37+/Ef8m
	 NkzZFwCF9Bf+KLV81dgyMbvW/rfobu+mpkvy8+Jfcf9vtwbcjh1u9S6VvvqHkFG8u55Ep
	 wykjrCi40jEnUyYL5an2Kc6KcMEf7GHwCU+nZqp1kGleg8kvDN5hEWYCzN/xPdDpAkw6Y
	 sZWI2tayV7fV7iv4Yin7lUZ3bv6uMWeHNCvKiIMgucayU3Y5+ztb/uNHgHllEwvMrog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
	b=i+F/4PSg1lwetaEJAyehNzAQ1gDN59bduHxLQpWq/QyOVfZxdKDmWJl7Zpbva9vbpbQp
	 vv3kGU8B+4roLEuc6mQVvv6eG2ojZ3oLW/mrYdM1tmqPN5ZOiLhSoIWcjExjoXRwRYV5A
	 v+ZFhrgbq+ScKfPVoyPcemwbKurnkWafHO9e5BbVb3jJ2go1GxHGA2RVn7S4iBLsd8xm+
	 cJFStYjh2CxWJJ5nKsBW/iQMOJqbdWZCT/1j2hhFgufIR1ROLfQujAJmBJ5MPOyUJbBmM
	 vMH/BEzUgOE6gR+dPks8qD0QRTjU6qgHA8G/iakm77/D27Qi9/+jTc+KdHibYZN7J+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dh++Upn4;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86A606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A86A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dh++Upn4
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-89f639ba307so458910b3a.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793816160; x=1794420960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
        b=dh++Upn4ZWf7TCTz0JkNT4qSQSDu2Uaew4OU6cXSrs7FN7XOMXZsdZov0rgiApzPdc
         j/ns2tZ0F2dx8nx41mTa8X6jql6kq29Him+xrNExnL/EM7kKeBV8ig+90HaAGgqZAnT0
         LMettOORnr9NA//uos5+vFkmDNagJBGWiOQsed3rCndc7d9bJkQuY7waS+JLgLTTTOOy
         mBOzI23pKm7CIAMKMPrEoPNirsQWVh5aoYVmAVqFVvbXlVpht9LmGTxRgpyaAIIXSUp/
         oTAYhipNNWLuQs/zyCPXYHTZAnXDgPYTakhqHWuy2hrQCEQL/YrC2pcCxPGbjZ7j36ME
         pQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816160; x=1794420960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DnkyCFwfTEyghMwBbYx5eIEahNaTNIOnK3R3J4LlqI0=;
        b=avOBPYn1awTPFbk3f42bIPVNhXQgLFEfZzao8o2zbninrPcM9xZlqAVurA5Oz62t/Z
         qgjsIr0mXdDrk+P+A8oLW89zqWzXoSF4S/Y1KBFSTUw+K2sS/KB+lJTsmPuhqMcfi1Hb
         7nv5hlekedVLxsSult2/kIJZghp8l2TAcVyS3bK4u13kUWpu/xsrrbDOg8yioHAvxWuS
         xN5JLXliu3O4+ueSQbaAsHBh6TiqLF3kWfjuFgScgD2SBpLY64G6qdseLawTIxEcBoh0
         VdTdTWY5VgpJaOzVvdleojdnjI9fxpoO83XJazWnkwn4XOlUOZzN4icrAOGPndxwzL3a
         Af8w==
X-Forwarded-Encrypted: i=1; AKwUvBxehmRoHBawng2PsikQ8rCbtFlBFn2/GwnTfRGdizRe8aRswcOdiuCbVB6SI12G8vYWkCti/0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CXhl5dYml76/odl3ZCC8LQVSHooikBRiqF+E9wyxnjAwgEGnL
	amngV8X82TCn8YrdBtitImDjg3C5FVCakRxW7GeQSfOsPdVCcoCl1rfJPi6lCypbwQ==
X-Gm-Gg: AYBFou0hc8LpbUsIna2d4wCUt2rMvAAzqrTT1ndMefRA2f+Y67NOy/GRjQqWrizGJHM
	AASZgMPPTXdEYnLGUXB012u4eho4imMCJ+t6nCkQMfbn6P5s68aLfdd1Z3b9SvQMfvI9gyKZwu4
	/WmsMwHDCUeGyOPQYnEdt4SBMQMFvwksIS1WKpJ/ip8lR3WwpwtOKPGL1D/108/JO10YkYqqg2a
	L1C906o3POHt937ejHFZQtmU5h4YDXXr4uhdVizrR7ewnNoDdS/ZHUzqJ3KOWV1b+XMdLMOj4h2
	SEBinKqP5jGTr4WB7psASUKeOiUqsaMtaOkHxZHnD9LnJko7j1XTqiwzoua3b+bX1j0lYz2TRom
	6GyrhS7VYv8R/kmej8VQeKAuVghq9dxoZjcDdBj9EF5I143Mw+IVhpJCFNeCsHTJ82H2BDduUD4
	FIbJA3zcTdfWDqqMrKdIDK4S9vzK27IHOky8TERohJX8gW8G+OdexLLtCBpQD0npwdkngJpsM6m
	Vg0pBP5vrkZu6tf0lp5ktRhYbr4L5rqDGqNr5llgqrA8xMEnTYwsLsQZ4QMcQlP2EBf4Vkz6pgQ
	WRqoMAIhk3Muk9a1eKoeH2fW2tFydShAieEXahn0tPl7rd+V1rY1CbIPrMerWJ2L
X-Received: by 2002:a05:6a00:3c89:b0:886:46c:8a1f with SMTP id d2e1a72fcca58-8a9bf0466d7mr13529775b3a.35.1793816159117;
        Wed, 04 Nov 2026 10:15:59 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09bd3ad6fsm1246841b3a.55.2026.11.04.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:15:58 -0800 (PST)
Date: Wed, 4 Nov 2026 18:15:54 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	Abhishek Sahu <abhsahu@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 5/5] vfio: selftests: Add test for device power state
 transitions
Message-ID: <aut2WmTGY9M8BM4U@google.com>
References: <20261029203324.1637772-1-dmatlack@google.com>
 <20261029203324.1637772-6-dmatlack@google.com>
 <20261103153553.6caa7d7d@shazbot.org>
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
In-Reply-To: <20261103153553.6caa7d7d@shazbot.org>

On 2026-11-03 03:35 PM, Alex Williamson wrote:
> On Thu, 29 Oct 2026 20:33:24 +0000
> David Matlack <dmatlack@google.com> wrote:
> > +/*
> > + * Put the device into D3hot via config space and then close it. VFIO must
> > + * return the device to D0 when it is closed.
> > + */
> 
> But we're only testing that it's re-opened into D0, there are multiple
> ways that could have happened.  It's pretty common that a guest
> shutdown might put devices into a low power state and it's brought back
> to D0 on close, on reset, on the next open, or even on the reset in
> open.  So I don't think we're testing what we claim to test here.  I'm
> not sure this specific D0 transition is observable, even if we were to
> resort to pci-sysfs.

You are right, this comment is not accurate. The goal of this test is
to exercise closing a device while it is in D3hot. The close should
succeed and the device should be in D0 after it is next opened. The
transition from D3hot to D0 could happen during close, open, or anywhere
in the middle, without changing the uAPI.

I'll fixup the comment, changelog, and test name in v2.
