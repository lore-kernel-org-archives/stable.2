Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412172;
	b=sAMu0clp/tzU3KWzOlvLbmKPWIx8SHBvsBm3I/J12/8wAq5ACZvngJp1ciL6evj+drZm
	 H/TF9XRbY6A7f52kIHJ+rVVYiifl0PvwCT3un1sGW01kTTPEYPfFj+L1TWaTfc9on8wvE
	 4uLcif+ArxwQLKFiO5EVFaH0edlnFzmre4HF4yohTNob2qEtdOiBTOrrO+WmW0vPJFzCS
	 m2ZHRqVnuFWcxNcPpT7POHS8GY6z1x/SZTSrPg5wAIhh/MkEr+FL3+GY/aFvt5exSpmap
	 x8/6E3TAFYThUGTmgTf32v+R8bVkzubKUn9UvAHFl/qxHebSZyGWlehJk9T/4XtO9nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=X2stYxycmmHDtlb7oc6zbpLEleL55evUAL3ENHG6ge0=;
	b=4iT9iQhQyfU1GE+N4RdUwzu2ZoRTG+9aXeZjmLqk5X/7E0DWOKmlwDlF/MLjZdtg67+c
	 QKeDv/UfY2LzSr9LFurKFeCNozA1GFzjlRtgsztuQbBKC5zDtZGlNDpXY+RRHajnRj4aN
	 pzvHkUWPRFRwjXtprj87O9s/9abE0xiaU3cXJ/DY0cI3r6cvaaIBNLZaQw5IGcxMvq6UW
	 7rGwHk7LSlPchqpNkgIZ6ylab2pz+vLVZ84thbOGMm7Dk7aV4qA3AwTC0h3hhAdI8pE+a
	 sAqfWC5pgb4YxQf1fYmjP67hpQa8p3IxY6V/wfAN59m+0D+Bq1nWIepRISSJ6vdnL1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D9CPcDjl;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7C606A8A1
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C7C606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D9CPcDjl
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed05900df7so31154295ad.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794412171; x=1795016971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2stYxycmmHDtlb7oc6zbpLEleL55evUAL3ENHG6ge0=;
        b=D9CPcDjlts7Q+PPobmXQdPZ8kp1soJwZ1RsD9KeGYFbsTHqR/cPY7ZhWifoHUy5i8N
         n3+eTJSaRg9dvZ/9MIWys8LjLVWQPKdq64z1ElZSfsvua+EKfO15C3WypPG8mjbHR5wI
         mKMNyPYGgZA0jWEjS5seSIkxwCxpPNTxd5WsbL47U2OmAUiJIYjcEVmnjWGejGL9AUbX
         EepAiOpAVkg2V9L0RJto0SQ57GeyeQofntnRwsWGTQqaJ21sB8pTllwlHVM+wZ9eOeit
         3jI+i9AT4k6J10srrQhcyFYq2lbwBr3xcETipxAXhCIekjYOLBq/6k/h5OIQ+B0PLhDo
         PwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412171; x=1795016971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2stYxycmmHDtlb7oc6zbpLEleL55evUAL3ENHG6ge0=;
        b=J2T4RlVzoh2JA2slmreXdHwgHzBMtem+3aaixxV5HGNAablywCQY/tCJ1tWj5K3d8O
         uuyFZk0DKiZIfKMK9pR4BqW8i08lzUct6olIQg0qeb7+pZstYXULf9smWHKs/T/TtMRc
         xhTqBeaKiG6xlkdqG6ZbSrzvjoQyc4xcDWM4Do511sA3IQ3qHt3Fiexxtjkz6HmJJE5k
         CR3rh0fH4mW48by1tGKciE9XhYgux/j+oxOJaoUMRb70aNv1BzcJmjsqrAFf8P97fdv+
         KpK7nhy/zPsnGaMn93V1MAfm+b7x/NYCeaeFseTXsh4vVStv9MJYEwrwCFrBQRcu8RQs
         l8+g==
X-Gm-Message-State: APuU4Z/Z6Xblewmzi2FsfBjfc75HCSwxfV+6SXLlqXa1gY8lhiDdIMO+
	Wksi2H6zDJzk38F22APL0xpEa9PRe5OW+RtDdYyWabV2wZW7gNYnRkul9Sa6V/OPTYyuFqks+Ur
	1dcXlFA==
X-Received: from plri13.prod.google.com ([2002:a17:903:32cd:b0:2eb:515:b000])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd87:b0:2e9:5ed2:c39d
 with SMTP id d9443c01a7336-2edd79bf74cmr32671085ad.36.1794412171306; Wed, 11
 Nov 2026 07:49:31 -0800 (PST)
Date: Wed, 11 Nov 2026 07:49:30 -0800
In-Reply-To: <20261111024039.676658-3-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org> <20261111024039.676658-3-sashal@kernel.org>
Message-ID: <avSOil0MeDFI9AQ8@seanjc-mac.roam.internal>
Subject: Re: [PATCH 6.6.y 3/5] KVM: pfncache: include page offset in uhva and
 use it consistently
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paul Durrant <pdurrant@amazon.com>, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Sasha Levin wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> [ Upstream commit 406c10962a4cbb1e04aa7993ea466db1a4533ae4 ]
> 
> Currently the pfncache page offset is sometimes determined using the gpa
> and sometimes the khva, whilst the uhva is always page-aligned. After a
> subsequent patch is applied the gpa will not always be valid so adjust
> the code to include the page offset in the uhva and use it consistently
> as the source of truth.
> 
> Also, where a page-aligned address is required, use PAGE_ALIGN_DOWN()
> for clarity.
> 
> No functional change intended.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Link: https://lore.kernel.org/r/20240215152916.1158-8-paul@xen.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")

NAK, patch 5 should work without this.
