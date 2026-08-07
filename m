Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB423E764C
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143976; cv=none; b=VQcbE013FsK5Zb8IhkECi4Tkno4n0wbKMjmTeLXID4G+WNETHy0VQN7IEm/7poAnkLb9v8zrXu02brSukp5I7WIMeSEAd479sPYvhypNsZ5+dTPWey1WM6hg05jGqYeH/5pksxTRAvzGY1l4CdbJcI0840bI5G3O/ZI+zyyBbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143976; c=relaxed/simple;
	bh=Ah7os4dPUnM7PXOAVjFiX82IffndnNTATTNU1WZd0JA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J96vO/xrs7+bmGJYsxHsshpl5YRMz7qWsHQw4rUCgdZ+3QvsgZ9lIZq60QWXF6yNmns8/1gzsoCCDe8FWish30XJo3lHkrn2NWevZAHSXLJfl+TrM+bQNrLZ/dwQGVOTrnKoF2WNBodmwTAC+/RfyAKXkGP9N5KReHHA0iRjxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdWgIA23; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdWgIA23"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so51675b3a.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786143975; x=1786748775; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi54ty/2uOVISFFIV8GBz7xZ1AQ64miqFpO9VtjCRnI=;
        b=NdWgIA23pPjmpFYaabmXPdmBBIxw9entcOfgxkivCioLxg368CCj7L2zmlzf0lS4DT
         eKqXt3LybU7ydoCkk/PCO/xb8oMeUCeX8R4siORlESDdwYYUxKVP8GnL+fXWrtqjhcjx
         fQTONbt2NwhjEMrfVsvMS/WYRAz0hYUROcq/FZbC/RpHaFOypVf9q1YDgpbC/UujOf2x
         R4Ho2/VhrK8y50QZoYWVJV0fhivcYWVEx1+W/vxLuylb84tVIl7TEi8hz1+J8iYJbsy7
         Mom+mL/4P8P4+71GRZfz65FyfaHFHO+XiRSVpPnvspIANWkRLhocEtm5aF6idsE3Rorh
         jO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786143975; x=1786748775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi54ty/2uOVISFFIV8GBz7xZ1AQ64miqFpO9VtjCRnI=;
        b=A/V6kVYdjGLt9AAKoPtZ1WOgqgRRXuh+Io05z4utx5kgIW/FlkhPXiKsDUu/MTZJqH
         m+NQ7ExJMH/uk04Whlw4rdIHLSiIns4379obv318oSL3EhHnGAzHlxnn4mqXK7PojPAZ
         bQJlKzP2xPd09uhJPCKfM5K1nTwUt1vw81iybsZ2DzoN3HwVuMtTzpSGvYKWdwx70R2K
         mskF3BIqYWnnp6KeDFPyvqpGpcbwZhXgeJJ0x1qnBbD0uEv4tbZyWcqAysce9jQkNXUU
         M8ZuUB83h9HPCPsJbvQZsYRZn0oFTHV+vAieVxeF/xhpG4gsSl5RMaAu/2RN9tmshEux
         ERJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5vjQsIdszoYfkdBJDY68YV/LLuVditwBwo+PD8oebdje9z4BTJfuPlLlNRNIHhnTkk08j8nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1GjqfaRsFs+fv3UyR+ex/ySL3t9NR8hRqqePM4yrbMsGfrqn
	Te0NNS576McmSkRTcH8fQIGsExErvXbmR2iC+u8KOz0yYXoAW6Miz3DXTnnu4l/Q7af0WiuzCNb
	jyMCLlQ==
X-Received: from pfbfr12.prod.google.com ([2002:a05:6a00:810c:b0:848:40f5:a538])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b02:b0:847:8acd:747c
 with SMTP id d2e1a72fcca58-84f2e022980mr28214031b3a.13.1786143974654; Fri, 07
 Aug 2026 16:06:14 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:06:14 -0700
In-Reply-To: <6bb4252cf3c41de5e58cce5c5de02660d8350f47.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071934.786879-1-zeng_chi911@163.com> <anXnmvp2_Rj62huS@google.com>
 <6bb4252cf3c41de5e58cce5c5de02660d8350f47.camel@intel.com>
Message-ID: <anZk5hTf6-8HWHBu@google.com>
Subject: Re: [PATCH] KVM: Remove the kvm debugfs directory if kvm_init() fails
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "zeng_chi911@163.com" <zeng_chi911@163.com>, "zengchi@kylinos.cn" <zengchi@kylinos.cn>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Kai Huang wrote:
> > > 
> > > The stale /sys/kernel/debug/kvm directory isn't just cosmetic: a
> > > subsequent attempt to load KVM makes debugfs_create_dir() fail with
> > > -EEXIST, after which kvm_debugfs_dir holds an ERR_PTR and all stat
> > > files are silently never created again.  Worse, the leaked stat files
> > > reference file_operations and stat data that live in the KVM module; if
> > > the module is unloaded after the failed initialization, reading the
> > > stale files is a use-after-free.
> > > 
> > > 
> 
> [...]
> 
> > 
> > Already posted (twice) and applied:
> > 
> > https://lore.kernel.org/all/20260706095910.39798-1-leixiang@kylinos.cn
> 
> Do we need to "Cc: stable"?  The one in your tree (commit db3a46e200df2) doesn't
> have that.

I was thinking "no", as I don't think it's likely to be problematic outside of
fuzzers and error injection, but I also wouldn't object if someone feels strongly
that it should be sent to LTS kernels.
