Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5873B4EB6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356320; cv=pass; b=Yc/x1cdBsDWc89xHwYyJA91M2N0PPtS42XBHROXwxrMfmJxvGh56Hhe5XZgmsUU8ahYl9U+4l3tK3MSiuC+dPrtLh/CnlxcMLzjN9DLgTIw/Rwj3UA5MpEnF+uWHcoo3txTkzxfG2Tur1eFKS8aeO+VokLYCgrZkf9HZ3nJrKRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356320; c=relaxed/simple;
	bh=4LdAx9fvvsBB7MjnkYBLZN0nPHxZGz7WnwP8m1gHhRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+M1AC4nRQibRWDl84iMbk5aH5WTYtIFfbzNs5FdU0WC0mVaxQyKPnRpdT7rt+dUmvKGT3Y/NKz4Eq9YaMXZEr5Z3t5n9oYZn0CEmZ3B8f0EP6MgaMVyhh1JWf0GJrB+AOaacmkpv61RsZMyxHIg+0JJBa+fWCrOX+3rqzFtetw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvqrQBK5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C550Dx8Y; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvqrQBK5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C550Dx8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786356318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
	b=NvqrQBK5r4yEX0nJ7PBAvq9tinGywCi1nkYG1IA9JOYfF3RY5f5UM9ebZr0uHHqtg4P+mZ
	cpJUWAFPg1W0x/4s20MHTL1y3pbVhetLTHlLSPjDFmWNIWBZucr7ySuPRkKr76oHmM+GRi
	BDQ1TMQ+/RZu2GZDavLZXbdlqHYvQfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-DxXW-gk2On63lJDMOoJ9rQ-1; Mon, 10 Aug 2026 06:05:10 -0400
X-MC-Unique: DxXW-gk2On63lJDMOoJ9rQ-1
X-Mimecast-MFC-AGG-ID: DxXW-gk2On63lJDMOoJ9rQ_1786356309
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so18777925e9.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 03:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786356309; cv=none;
        d=google.com; s=arc-20260327;
        b=aNrJjmNJx7KslTHA2UGsi0JzLvE6a1yPtgsne5qzActO/SoyKAmkKuPRqfYS8/bY39
         4qgw2BLXU8BD6N11+dB4pjj7FKpUXOAhC/hstl/hQqRtCAuRxehAS1PPvPm1EdfwBSN1
         8J1uoq1gRAnmxEOuhs9hEX6UWzx+i7LiLysTuvWR9G9b5WGot/lQGeNMemtXd/0u6m+v
         gmxw8YT2rxnT84fiMQL/wwZHvvB7eTbtRS+5ecT6sPXxvPYeZEdVrbOP2zfJ2QeSxtRe
         4leUza+RRalhMvTvKLKRIbCPowcx6P7lerBfN8kp7e1UEDs0a/aywI6SemqSNO7jzhvO
         RyUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        fh=3/RHLD2zJTZgFTrMG1y93g6DfRJSaGZmODuJz/nN7cA=;
        b=s9veggh4V+Rp25m51aFGjZ75omNLw80Q6O5LPjXbZUBZNi/PUxCCLHwXthrcokIRt4
         qYzFpeRc6TvD/dwETvR3zrHghaZ0sR2Tl3zOp+1wJe7vZslT7D+iCWkXIbe0NNIy9rV5
         MSpedjVhBncEmB9qSPMd+WXuXOxzu2/OGkoI9IpO/lToMiDOWTxlibyRxjetkEfEtSna
         spnpDpYSags7YxNI6yZIMesNEP7RssI9TZNg/3yLqFonbF3gqioq+SMVFtXG5VRdzdHw
         2SAW1aZWhw76sYKR857XnAmiulRKhVVx/0oTSfiqwFa8+7IckLosmVmmbEVxa4H0KiHt
         7j9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786356309; x=1786961109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=C550Dx8Y4F8LdeHXnN+Nag7AvjpSQKSZJigSZZ96cHQU/4uJlKENkqe3evapvfrPWy
         /Bgzihvkp04i/sbEHSMDONR1oyVL8+nFQH5ixnxdiSihyS6EArcRGJV56mV6bDgg9k4w
         6uIIYgRkr6suElCfqPTEAi4PKGRNkpV72812R7c3cyIY3wB2RSXG7xRgOAZQDZRkchIQ
         VR9XVvBbfaGDa7goWuCZgFacuejAawigokyVHlUq10v+yPIGSRcKZ/urTa+iw1dBt6x7
         UO3AiQSynCtHlZ8o9jtGKNDT/cEcFktSxu3Wka254ps0arMhAEzif2FxWaIn5AH9Lg+U
         oQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356309; x=1786961109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=fB9j2FxGozN3AcmyvIMcaGBgiiidsVu6EN8TMMTpOkZ04FM0EZ0MqNL4C41NDPlRAG
         D9qxBz7lRgQdxkYgHzNi3r0pvs/HScq18W2fK9Rtxp+nKvvFE1DOooHfRLuAXCMW5oLZ
         hTKXCcGGFnbBHHv3U22FwI6XltOapEW+Ce7VmCINQiT0dKFAIvUVhq1czf9akJxFtmh1
         enjP1DCX4OQVAgBwJeZa9+D6ITk/Wh+ju3tK7o3Vv2TX9DvyO8zBTh8S2gaEgw2ZCNrz
         u4V8WHsl3X5rPNQO4f9gJ1lEdCNY9U4k+sT3R5WbR/Pis4pFpRs3rseK7Xn5f3+SpdYz
         ds5w==
X-Forwarded-Encrypted: i=1; AHgh+Rq3xYpqYLCZNvyptsgy2IhhRug/4xdKk2tiuOSkucuT4a3sa/N35uNJv8CnxmA/rTTqseA1ptQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGDI8WPU+oYapjXySWPDf1piWyD1v4yv9b1K2R1c13477sH9C
	j+lmjpAFi/vNBXHzWvlT9wIOjyJ4OZJDPXkIAhKvNoxLTBMTwwW0cXYLp7y33yBUMxDi/hUPJdq
	gG/wxLEydZXC2XG+ZqXR+NoKFXoqp0XTfE2QMJL1waZd6g+rBopmORQNdeoTx3W6suo4Gvsa93k
	PJQgCLgG+Ais3rYoqfVZHxPMJt//GyTLCx
X-Gm-Gg: AR+sD12O26k8PTa1CFt6n0uMmfJZZ4+/zEHQHoyFaQ5vX476FJug9bfNDnClCEUk783
	0pXzc2UIhs0Aw2z/rRJ9k1Ddl2viJDsUseW6iRU1Ht2TitS4MEpR7h2j4r63qDuTZO5OOd8SpLe
	UFgL0r5jP4TPELjx86VYdzVw37h8GLOjaqEuKz4MB1iFWTvtsRvQAdgYZk4lGhI6gvEhRIbx5iL
	doFleijB7FS0acUEQK5IRxqytDUq9pd2Q0yKQasLSf7OTSnMM5v3pK4ots=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499727a3b84mr5344115e9.13.1786356309181;
        Mon, 10 Aug 2026 03:05:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499727a3b84mr5343835e9.13.1786356308812; Mon, 10 Aug 2026
 03:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-4-pbonzini@redhat.com>
 <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
In-Reply-To: <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2026 12:04:48 +0200
X-Gm-Features: AUfX_my6VzuSeHJgh3uVKaTYyn_VnWzP5xLi-qQ5sWEuv-5l4TAmINZeor_-704
Message-ID: <CABgObfYvz_SrBBXmzJfiW0VsQyRa8OWQdP7myfY=WAws63oguw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:01=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
> > -             /* Never error on prefaulted PTEs */
> > +             /* Never error on prefaulted PTEs and never map them writ=
able */
> > +             mkwrite =3D false;
>
> As far as I can see that is a really bad idea, we do want the prefaulted =
PTEs writeable.
>
> The whole prefaulting is essentially an optimization for cases where taki=
ng a fault has massively overhead (virtualization for example).
>
> Wasn't vmf_insert_pfn_prot() making them writeable before?

In general yes and they still will be, but not if pfn_mkwrite was used
(as in the vmwgfx driver). I'll change the comment to "never force
them to be writable". Setting mkwrite to false is exactly the same
behavior as before, setting it to true is a superset.

Paolo

