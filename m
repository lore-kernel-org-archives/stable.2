Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668227;
	b=IhHMYy1YG7zu0H/hk2cshGvycOoajQQfqAhDt9Ur/Xz+2dbHeFoqwAkARc5h+v7sgKlT
	 342fqK95JH7njENhkDZExIBuwCiQtOzxB6h8KnHVBSLdpnH5Mu/RzuWN8f4QY1aqiLKO1
	 DpJggyNHuC38Q6FQdJpqcagqVhl7RSgUl8qziP8q58mu3+xhtBHujLbDF2VeA8Oo4GOTy
	 I5VwDv2c8wy5PwE0YUcngkdHfQmT3BVfgmfgt31EJ/MEE2uEbqaHBCXb+Ps6DWgkoTsP4
	 CXOscdt3Y8/S6gGWBcch4MKtA9rHV+p46BT9ohooTdrJb4yiIZ8JJyAApmISVtSQDug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RbuYOQqzgIfOAiaZGXnsrc5kralu1woOsjsJovLSjjs=;
	b=klgYEokaYAv/Cid9km5qPzfCmsHgNHIzTSff4lTqToq5OVgv+i9wXVxRXQ56MXkq8PUu
	 RZ3IxlkGAUGEW1BxkpKSmdOCEaH6rHNlqk30b7yweCVe/OUDjK7ISJyvGdsNuGipdh7EZ
	 1sj2EJ5O5nQqrlERN/U5/35DyTEnIVUeauJRvmmi780wHTSF+cqLCJLgaJ3D3IcMhLTiO
	 /BYW0bbE82d4IoInAe0OxVBXbVCwB7eqOAacmkKuG41VU2K4e9CNsl5RMSkI8mEWK8Prk
	 r29SsDdn1DFs6w3BNpK0yBkHFrrxQ4MiAqHb8lpIrKAWPCbQ2cJtWvonngRw8NS2hlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrJVOppd;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FA606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2FA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrJVOppd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33e623bd651so172680eec.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792668226; x=1793273026; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RbuYOQqzgIfOAiaZGXnsrc5kralu1woOsjsJovLSjjs=;
        b=OrJVOppdJmpQzpESNnbFh7FZ8bViWXC3cUjorcBi7DoWTRLoNWKjqoq3ED5QmGPJ60
         TFiku3HnfFCx/qDcUdPyYOK1MMrLUH4jwgZ03+npwHiehHjRednoyIgHL2zHTFqtOFPO
         rvVQC//0bD4RTn47Nxh8PIFp31JO8cMFvp8SbdcOPrup676IWiqy/2MzqurMnkI5L/bY
         9mJ+KRF1njvlEhevTmjxP7VpF5inuFMe44cPCDKJLM46OX6MizS8Tnhj1HQ1CqsFQeNP
         ofih15laI4RkIeNh2qhO27Y4IchRphFPcLZOCgrz8RJlYK2EJb80Axw6EV/njxNWq6qH
         rXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668226; x=1793273026;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbuYOQqzgIfOAiaZGXnsrc5kralu1woOsjsJovLSjjs=;
        b=EvpZMIUYHdmCHCUb8m/T3Gx45/oekXVl6WCHMUkUtA7ROIZOJNO0ptf1c0Q0H6617v
         0nEQvHlAaD4QK2ubbirDgmY+6YKVs8BxE6pDMvVpcy+dmgkqtkc2efcAgSeingnknE5v
         zJmNvMWFWO6LokQ+2SMjIvv1QnS8E6iWDbv++5nx7h4do8SSpBs+Qqf4KfhPtIxzh8JO
         /F60vscAtbLP2KvM6rshgkZn2oXoXBg064lv2NHbVLUkfo7/FDC0lXiDxIB4T2rQ7UY8
         M4FyjHHALeUHbssTVSRkoFdr8Hjlw67Q+1Whr6pc41qXhzHNRhWdehPc+pbn+gIxXi4a
         A3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlqJuNRwRk1+tmLkmkYls+SPDBTK0tH7tUekrFp1DXxvZF/rw+MNj5a8f7gkpQkAr9bRPBWFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIenA9SWortfLGg/G4BxiTbtVf7Nz42b+tQdjQBFfalGEY70QRh
	3k0Rdzp5pmFHXD11OrnEdpL5AVx0ltiswNyxMJP3awwdvu7zXaMNAVVc
X-Gm-Gg: AYBFou3ab1Adg5p7VCv1clwAhsurbXWqd/6dSy6Xh1LF2hsMw8m53oUg9Ad2z4DQuVh
	NLJ9kWT7UJn32cddsPhkabeX6z6Vva96/QQPv7Bp2jSr7d+AM1u2uV4BFRH1HARa24PYUEfHLsH
	ti8eOkfqSU233nmHECZrUFbZMhorF8utAZHe37jgert1KuQAuJ723mJTgKwxUSMeKt5Kubntz4t
	dE0CussI32WWIuR4tPx16nI4kHYWb50lFltR1TTkwK7IBBw4IKiWJNgsuLUeC8NeyFmWtU/T4Zy
	6pB9V32nlBQ0MHVGz2Rik81op27VwFaKITN4k+H83AIm92zfLzPW2qY02DFqbh8X0TZo3nQjfa5
	fO9NY/PjYjyMH9mp7A0scVtCBPFFjTrq/cbafc9N5zIPyB+rM8QkeVNLSS4prU8grIl7cjnz6RC
	4V9f19H24c0IgGLitCfMLEzoI3ZpqsDUzaBc5EmG5i1ujcO5Szt4fO8eUMks216mpouU7ZI8sWZ
	De1ZmPzFq4nMPPXBEstIjUGFXrytNH1nfnfHzN90pOZjus+gWIUK4UyNhiM+jDFlT6N2kTWXYra
	UP0lCLanRBS73vTpqQ==
X-Received: by 2002:a05:693c:42d6:b0:368:5521:612f with SMTP id 5a478bee46e88-3685522022emr5243257eec.0.1792668225739;
        Thu, 22 Oct 2026 04:23:45 -0700 (PDT)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc88b5sm16249400eec.10.2026.10.22.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:23:45 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/vma: avoid broken uffd merge on mremap
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>, 
 stable@vger.kernel.org
In-Reply-To: <atniL5lYyE28HSTm@gremlin>
References: <20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org>
 <179266301162.763593.1501773594946042790.b4-review@b4>
 <atniL5lYyE28HSTm@gremlin>
Date: Thu, 22 Oct 2026 19:23:38 +0800
Message-Id: <179266821816.763593.10189260302790417327.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 11:15 +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 22, 2026 at 05:56:51PM +0800, Xueyuan Chen wrote:
> 
> > > diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
> > > index be8f5161f92a..f786a585caf0 100644
> > > --- a/tools/testing/vma/include/stubs.h
> > > +++ b/tools/testing/vma/include/stubs.h
> 
> > > +static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> > > +{
> > > +	return false;
> > > +}
> > > +
> >
> > Would it make sense to have the stub in tools/testing/vma/include/stubs.h
> > return a configurable bool, e.g. uffd_without_event_remap, and add a test
> > for the true case? The existing tests would continue to cover the false case.
> 
> No, stubs.h are for simple stubs.
> 
> Changes like that would be only be made if needed.

Got it, thanks!

-- 
Thanks,
Xueyuan

