Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68D2C21F7
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467347; cv=none; b=Cg/w2uo+C/jt6ByWej/j5vdCpg+LOqMnC6XLJrWioiaHTjtHdkMg2SxQHz+xHc65j7LvTyZ6SPzwaXBjORQw1HADeFJkTv5isOv5W1bA6NeKZkyIB3tmRfL03LuKhzuhb4BpxjNqLcKPXYKr6sctFNmW9naH6aNmsB0VRq69AFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467347; c=relaxed/simple;
	bh=AWxMkp4uLu9jQMOO1Iy2udFtkWccxZJD8UMRpTQvwSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dYcmq7rkTyKsamN2MLR8DjjPspipoP6PUNQLYib/qunU7xtAiOH/BHfmEmzX/z4Hro5CUuY1B2QV7TxL4sn/eW1qxrJ6DIcFWXPDXG+NvEnykZbf2ACYkuyBZFCz3QHeauKkIpDSukMLyGs3/oLf9we8futBk+Wb30Voa6tIIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E95LpsCd; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E95LpsCd"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so3208415ad.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786467345; x=1787072145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UUnRurVC+P9y33QGxXFJHGTp+5LZLD/UWu40rCHnKA=;
        b=E95LpsCd9MtGVSnqoNYLYlPeOzob+19wu4ppvvIPm8w78vjKjrgsj/k91pyQupEPxg
         m/zF3r/ocxYKCy40aD5xMcO2dHjMIw3jmtixYL4hB4L1PqHmJH1uzmwfRF0BzX3gZ2gz
         el1/bm5db5zgPm+NFJ5F6txShWi9v9U1E+Cj7gYSpZEho16Qeb+9XuuOsvKhbA7nOFMH
         sn0aH9OgRJbvP+VyXg9fRkZZP+yri9ecDNP3ENQNCoCXhn9XMIu+jF/jK7aal4pLa9L/
         UAtcoECq09vO2S5s/vUcz+JX8LTd1okEmvmnC3YESbUhUDSOGs1XbqDkZpzZ4jLeuZ0F
         0kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467345; x=1787072145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UUnRurVC+P9y33QGxXFJHGTp+5LZLD/UWu40rCHnKA=;
        b=jbiSXEpnfshLOVx1KOe0hpnowaGZuRi/2Mmfb3A7U+HmIUohwVHOETIRO9nTaiowvK
         JSyn/2gH+VBe6Cfhy2lZhOao0UnQD0MW6SRXVn++zg9oaYUVTFUVHlQLUtf66kK7abhT
         vuF/tR4cRbqhYIkZf042eAY4tup3Ll9JTqSPsAJ4O4Fe4CVJftgsF+1rnaORRNkoLhpA
         HyUfk/aFNGEwXYt6Mx6Oevc3H058bfuiyba7aROq38ilhU1LARAy53LUFxIT8Oj38OJx
         NC4U97rwQif/tqzIIWV0uoS/EQjF7wTWdGPJx0h/LTlg1DIPI4ap4F0Of0sTuNI/Mo8Y
         8qjQ==
X-Gm-Message-State: AOJu0YzIobcIb/XdJRh7fgB7o38GuGaXebHu7LkHu3cDyz5lCS4VNAFV
	1BrGbdFgXJUc3IiyDdBQLVd90dgJHpYiQ8PXBDcuMiW6b7DrtgJfSyvys6uDnRfvhkepj3svlV5
	Um5bzCQ==
X-Received: from plgv2.prod.google.com ([2002:a17:902:e8c2:b0:2ca:f436:db58])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c6:b0:2cf:ca89:4990
 with SMTP id d9443c01a7336-2d3179333a4mr60286305ad.17.1786467345390; Tue, 11
 Aug 2026 09:55:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:55:44 -0700
In-Reply-To: <20260730121535.2208491-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072556-gem-immunize-5c2f@gregkh> <20260730121535.2208491-1-sashal@kernel.org>
Message-ID: <antUEPeyMAzPbdI5@google.com>
Subject: Re: [PATCH 6.1.y 1/2] KVM: x86/mmu: Rename __direct_map() to direct_map()
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, Sasha Levin wrote:
> From: David Matlack <dmatlack@google.com>
> 
> [ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]
> 
> Rename __direct_map() to direct_map() since the leading underscores are
> unnecessary. This also makes the page fault handler names more
> consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
> direct_page_fault() calls direct_map().
> 
> Opportunistically make some trivial cleanups to comments that had to be
> modified anyway since they mentioned __direct_map(). Specifically, use
> "()" when referring to functions, and include kvm_tdp_mmu_map() among
> the various callers of disallowed_hugepage_adjust().
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
