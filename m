Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640781;
	b=ZcnuXWUc3oA015A47WpLecy7pdQRHEiVtQtFq6c5yRkPltGFu+4egtyNPxGVfP716B1A
	 P8m0V5Z/sm+NHB2XqMbG57f6S0zWfkR/kEY3YfQobVDvGE+dpJV/i5CQw4wn7IRPF4LO5
	 YC5oLJ4puId2eYBi8jf1WbxFADF6u7DXisL5a6oXdjGX4rphwh9IZF2m2305y7SxoPwGE
	 8KNadRNlZDEyQmauxgCzKtLUOZrBjlkSW/RqqXF64E8eaD2/iDF5OOQfgGYqVYtoRckdY
	 kra88PLl4L8ablh5G+nPujf/Ci3/ZhgxjjYAS2cA5P7Y+aNQRCLtDdI+7DPtBsr8isA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
	b=Bl8IYTKhGCzhxurzR/jizvUtb5Tmk/txmvF6W8VchVrT2R2636OlU+iJazhfsRRGArwz
	 KNJtHLZRDEnvpe2TQNq6SweYslUBGFtcuiUFU4pol6KHCfwc1X7+iridBEQGrKl2eND80
	 Rs5kCBZZ9CXo78aKKm9HUYYUr8I6F2HjHVGcqfR9916upyZXapXr+amxp9Ig/FENadE+u
	 AOpo4bFT7xtEQZC5qn2ly8mKg97t09kR8o6A8jSRC72PmEjEyjbNpBq4usAQDhvnXEaFi
	 8DeY/0zCWMau0DCDCdxd6xRAPGaGhPh+nmB9iyPXm6oteSQ3sZm9ygxhByHepB6LQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vr6Gi2kO;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8C606A5A4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F8C606A5A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vr6Gi2kO
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so2327046b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793640780; x=1794245580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
        b=Vr6Gi2kOMGuTpwT8DmkqTZGp1ia1KpMCjpVHjwWRdnP0ZpI2oH5i36FldXtcRECW/d
         F12qKKjdJFpwwePOq967LfDQ8jYLsaaKb6BMCe4wnpAzO0bnkgm93Uuh02bNSxyVesuV
         DxUXMvj+YE7vIIZ9kyYXYXzuXdLlcVKAzWMNKIkiohKM0cPFXLFuupsEqASEWR3LX3qY
         IZowq6X/ACtDazbPyBlmb3/SX9Ul4zfE+9el0SSK2UZWW/CKY9goRqJovKj8EdR0yuG6
         j/TQ+qYOnlUnZHjBHFkGbYC8wQNISeIQFWkIVolBtl3svm44RBat6Z9ku0qUjg5Lk5XX
         s4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640780; x=1794245580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/jVmLYEpOYFqMSJJPUHM0SmNIpzKPl2Q6duRjCQ5xY=;
        b=zkY732+iWmx7eruhT9Jj8d06SCbgIG8THb2xpuUGzEjE5XxTIGekyVX02MF03Gn0K+
         V4O5lpBpsXTd12npU5DESkUWc0w63OeBJzPwX4exBluP6vTluTXtUNP+lbumi9lJp8t9
         sqn/UuInyzMp0/9/avNw0MlHTLMdkbexB+AApM2JXxul4qub4rUfxfPbEz4QXDNVkYat
         Sl8oT4OnP6HA5mSUX9/H21wIHzznRNpspJfvkLhnjf3MX89kxQYs62TL+fHdz8J++xDQ
         6FOvPrG2VFtN9NLFClqLvB+vgVQgvWrcu7XiTDI+AtejXBYHLGnmXDYZZClV5VRVAGiM
         vchg==
X-Gm-Message-State: APuU4Z9Yqc8dbRk5aFQ8SVGz+iSUFDy18tZ/Uckh/Yv28sYxIv5DL8LI
	c6JHWxWqPjNcwUSD/A6qSxKqbMEBGcPadna9vFKxX7cL/LKjnlOmxUe450gTwla4ycYGWXU76b6
	lw7/0pw==
X-Received: from pfwy37.prod.google.com ([2002:a05:6a00:1ca5:b0:89d:3267:4348])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3313:b0:89f:34c3:2031
 with SMTP id d2e1a72fcca58-8a9bfedc980mr10014738b3a.53.1793640779831; Mon, 02
 Nov 2026 09:32:59 -0800 (PST)
Date: Mon, 2 Nov 2026 09:32:59 -0800
In-Reply-To: <auUINwzMTjKCrzZA@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <2026-10-30-1-daily-reply-0005-kvm-nested-ept-gva-6-18@kernel.org>
 <auUINwzMTjKCrzZA@google.com>
Message-ID: <aujJS5zeGNwnDdy7@google.com>
Subject: Re: [PATCH 6.18.y 0/3] Backport nested EPT violation GVA bit fix
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Bjoern Doebel <doebel@amazon.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Sean Christopherson wrote:
> On Fri, Oct 30, 2026, Sasha Levin wrote:
> > > Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> > > violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.18.y, with its two
> > > dependencies.
> > 
> > KVM x86 opts out of stable by default (Documentation/process/maintainer-kvm-x86.rst),
> > and none of the three commits carries Cc: stable or a Fixes: tag.
> > 
> > Bjoern, could you get Sean or Paolo to ack this series (and the matching
> > 6.12.y one) on the thread? I will pick both up once they have.
> 
> I've seen them and they're on my todo list.  I'll try to look at them early next
> week.

Acked-by: Sean Christopherson <seanjc@google.com>
