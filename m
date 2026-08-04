Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4C399340
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854082; cv=pass; b=Fn1e5C+5nY9AgR+T5YJSqks7EL1zjUOOtHr/xQRzN23Jd/3ZkKvGw/9fSyO+L0HPmA7m9JxkL5KTqLva7iYzecS+Mc6AAA5OjocyVBeEi5ajblHo8GeX412OG3gR7igN76ZE+FmIPFt3OqoQcLZZbQP3vZqBGZ+D5dwdEIi3zjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854082; c=relaxed/simple;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnjoQpgU/4ilwU6nwvrYzggND40em71QTDJgiuRXDR4y0aNFOpXu5BqamFezVzL8BeQ3LGD7uS2SRfstdwckO7Y78msfXVCpTaU1TDPosysv+IB5HEZMpghiD8W6zyii08WzvwCOZbq7Z3XGELtlB31QKUIU9nwTWihFcMISzxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3we5V7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oeMRMRpR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3we5V7U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oeMRMRpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785854068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	b=b3we5V7UvlhlD3TTG9R1sBM9eROLbjYrnKuw+fq/CN5lpvoGXBS33Rxag6DJstwW1aMFc9
	m1kzFk5iFziFyYifY28KKX1MqdZuKKpTMDfSjw+PFRVLR+QcOl0rV2tnvltblqIG7iUQyl
	IP9zYpw8Ztil/RJ2qInZyjdAgGV7MGQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-dDXBEqiMPDOPU9hRZifeIg-1; Tue, 04 Aug 2026 10:34:26 -0400
X-MC-Unique: dDXBEqiMPDOPU9hRZifeIg-1
X-Mimecast-MFC-AGG-ID: dDXBEqiMPDOPU9hRZifeIg_1785854065
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49544a639e9so17879975e9.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854065; cv=none;
        d=google.com; s=arc-20260327;
        b=EzsqXHIlNCKg+0+vt4HyfsdngXibdI/AhVM4oSk4co/AnKWRliQRSt82PbyhfKwaap
         ECwKDjFupne8+M4V4TOWQ5ObjIsQRAtAOuHJIEt77gM0QzKL3HztryzsdxLijaG/JEu/
         z11ZW3LTQ88iuvCK304d0viczd8LQbrGvcGVVpZME9f8l4qQGkzxF9XRxAmUIHi5mS6v
         zHtw2rYBXaQWXK6HzR9s7P+pDWXfMig9H7hRptsHkxrhQ01qv4vycGEYoPkgyZgJeHnY
         r5u8czckO3XmKUhw/pUgXxAq++0v0Hnph/tT3qmhPVl8QDDsRkVw2+/7v0UtNTfUQtSo
         3obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        fh=4HnrCL66xgVEBZU6xA5OYAA+22Wk+Wh9uhKyGmngRnM=;
        b=p9qtVqbSe7iRgWFez+9XItGAXmAbHa9tOYk19kopCUXnSUdsV+h2SWDVeaDCCRtC9w
         1XAdF1f62GgrH/c7Q1XoZxHhr1E1/WKQ2K43nn1iGu9NObjzjve8QpCOqupnNrHydx62
         k1+zdt6tlRANdKTVgYdKI6c2EpbQ4yG3p8K2uIB1fDB78l83ovIktT70gRfqSyfNPIZ5
         fMe8wFotMUTPcb4RuNmhcXc8DKsDufwO4opNOWfS7F8Xk+R1dZ+f0SI9g7a0ZLM7JK+L
         FGV+nnZLoNefA8V4w/IX7BniOd6apfU1HqsyLLwnXb0+6wsk/eU8rbETgA/PM8FvaSy/
         BaWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785854065; x=1786458865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=oeMRMRpRXphJnO2A7FxxFVB0wCiMjMW8eGzqDqv2/23j2YgrmWgB31vK8yab9wfqmT
         jeXV01qn72sI+XW26nr9Pp+VaUaYtCIwGOEN2kQTbP3Y5NDiF11zSq+99UbaZkOJkRn+
         lP98cWMUkl/z3pBC62N3IYiwBs9uXTzp6ONVbnk7Wy/UqTkWYoDzNuetR4hI57Tb7Gb3
         /7h/ywWBQEAF39kFKL65t05fzKpIOE81lYviqwnR+q/7opfdn1AhQ2bxyR0eP2Wrozuo
         8Dad5ojqaEsh4lUNarBzp+AdKK+TZjHygsQvdW9wwyZz9AEkOYm7Q+BmyYiQYiS4PNGE
         T9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854065; x=1786458865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=VDcDXLwAw5E7ERZUi1i/JdL25+bQNCAZUVdYkaUqJWcnU6P72GvhGbLLBmM6UzveTP
         vGNHc8U8QXA7zrMSCE5n3rTYWH66k3GVt3OiwGF+Ucsmy39jbdgmCKWvRv/iiCZbrn+v
         tMCxVi/jTN4pZ/bGGUDMP2xXI3p93OPJ1Nc9H6ROWX8xk/CSTGBEofyK3F73WK6Kgt90
         SajX2URDZnPni75FPLrSyLgwhE9VnSJGT30ncs+7hOwwYj0hWrWq3a4je5fviSMr4va9
         weQrALOOkO7jsVyWL+NurBSbD1SO9vlWDsEaiKTPdpzRCbq8LweRbYKNBg4zPNSpM/Fj
         uA/A==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Az319G3m0selvmwLCx6BpiLI4LLwe9htM19vVqM0BNiPvh74dlWLobNs/8F8Vu3VGwvb3JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKwnHC/N5JwjYSLeI+e2TN9EOKzf2tpie6NkSY33a50JT5+3I
	9HskGHrTmGP+oRxrc3KzkQZWKnm/1Q3GofBZ5s2aiVyRnjBKiSKNGAOHgyuKQ4qvdHuhmM1vKo7
	Ji041jtoj0c8TRjRsnboSzvyb9sv3OgyRbEdNCbkccn9o06Rh8Ch9zkHvn8RZ3+7lWdzAxdf87F
	VAPtSpHydfcL3wZaf12QseXGPYRn6zMxaU
X-Gm-Gg: AR+sD123Vo48r7aezjpeIydsrCqPn4LgQIl6YVA/sdTmk+UYr7tGx9heKM9syWdop3k
	Cuqh3adCo5gljfn87Kr6yoBH+FqQXq/rQg8Bw59+qPCD9tfBHM3Szt9CtEoCXYS6Nmew5RfkRw6
	ka1QYRGgvJrjlhPXXJNc9fGy7+7OnHvEiFN0vdoYlvSGceL9QzzgRzkoEEL2CP3ZAxQyfvzsN0G
	B8V4kQD0eWnnBQJh0TM4JpDB7kuaaTjdeqFTgciUocWvP8l8Dbj8FdBoBg=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr337369065e9.11.1785854064946;
        Tue, 04 Aug 2026 07:34:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr337368035e9.11.1785854064514; Tue, 04 Aug 2026
 07:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
In-Reply-To: <20260804161850.58c55c6e@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 16:34:10 +0200
X-Gm-Features: AUfX_my1qzxj9_dJklyDF5G5un-IXavjOuTxcyczoqFAniCfVGichGNEROtCVP4
Message-ID: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Christian Koenig <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Tue, 4 Aug 2026 16:15:49 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > unconditional (for PTE and PMD updates) in that path, can't we drop the
> > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite()?
> >
> > Also, I'm not even sure we can end up with write=3Dtrue for PTE updates=
,
> > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERROR
> > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > implemented in finish_mkwrite_fault() [1] will take place. If we really
> > want out try_insert_pfn() to be called for those RO -> RW updgrades, we
> > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite().
>
> Nevermind, it's all explained in the comment you've added. Sorry for
> the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> pfn_mkwrite() though, like is done in other places.

No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
and mm/ already takes care of making it writable. So there's nothing
to insert, you just have to take note which you do with
drm_gem_shmem_record_mkwrite().

Paolo

