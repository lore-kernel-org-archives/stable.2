Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EC29DB8F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975496; cv=none; b=HHrojAchyuwq6+dl6GvC+Cz+PJZ+SgTt7CUPEDWEhJEMA/qC7o3m3u3wjYs5aLZx9KZmFVYDPaPhsnq0VdkYjgRYucWVf0ytuIzPLgEW1fEHDUQrvvgdNROeFr16LKa5enJGzx74B4dJ21ws914M4bBCl+Su+COuOCSoUGAE7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975496; c=relaxed/simple;
	bh=SbeoSzc8717QD/IqpcZd0l46LWnbezvyajiiws+1ApY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DZgURK2x0JESbiqSsqJ/CWPbTqVuHr9h7BVsHDnrWrh7yDZL27On9d3B14IocrofszMtSdy70Q8TW57Lii6ZFEg2Iv8yRp+jYj3Jq2PFfFNnqD1JlSYQZJMMQmiheCXxw+ubIE7uhrPyDzkZ/xdXwodyvGg1gu4AZI/RuaMh16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFV2swOR; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFV2swOR"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7e6720b31so11612a12.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975492; x=1791580292; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wShwsJKvODsiktjEQtwHrAPB94R0KVRpk+BGj5cEKBU=;
        b=oFV2swOR/Zcywc8myCyZ2GnQmITK4lzFf4CizWfJzJZ3x7DFkCVoPPRvQcZP0N8jCp
         1JP8uv7WfZzK5sBU64OofXfEExyLrLaokCFB6h1ibJeHR2GEKPQhKOJ0RxSwDwuHihyQ
         V2MhfnhcGYdR2CrObdMIPG6GGEUuUxUU5tpzXNWdDoOmzG88SIz4PDp8aUVvrM8gRxT/
         AouP7CiKNU99kIuLwaMR6tVCIr3r9G4/8YcUgQ4GwY376LpBff4pk5fenip+js6R6kf6
         UYh1H7b0dpRnWNCYbzpZvcfxI/lP/ljxAIqk/xR+NhL4pUeNgLC5fXcFZEbyDvVYIzvQ
         pzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975492; x=1791580292;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wShwsJKvODsiktjEQtwHrAPB94R0KVRpk+BGj5cEKBU=;
        b=veSY1WSmISVonjWfTWUmCy2Xx/6WS/zHcwYWaoWwMd4z5zHCs/m/5ckK4lWtTkGSnW
         437Wyfox8hqAV6dLs+8qt6HjWMV8WS8bdOW943qvetd5mmw79Z8qNn5KtKyQm/S38KSA
         Id0stGAkZj+XNsNUKdJtNl5LH6OzTeFvvb/OvYhIq4cswn7OYc65im2nPtGMS+RfbCNr
         Oh8qLB0M1d1fFfSfW+F5Pkecl7r37xmoRxyTRy0dn1tpEa1os3NYaDq76+xHKVMEoQ5M
         ZCYkLcq1Pvcl1tEQMY0WX3vw4KKnEnRkwPqm/bED9kw4xKo18HYMU8J0BOjRnC3hUpOO
         S+Mg==
X-Forwarded-Encrypted: i=1; AKwUvByy1Yqo5gUWEgLYeGBkj5Yalgrnu0XTkBVQDOrBC6qZquJgKjQ8s3W2imPdBcbhkTvytIn7q0g=@vger.kernel.org
X-Gm-Message-State: AFuF++kr/0aC9q11EhQTBEGZVS2zIM/fMB0/jMjV/qNypDFYaAl3EdMQ
	UT7yHFwuOOKIHeZFZZ/9zbIRuTazPOcbdZTeNCkWWyXQE7PfudRJ4eC2tn1KeQV0zKqMAP6hetd
	bcfuMvQ==
X-Received: from pfme28.prod.google.com ([2002:aa7:98dc:0:b0:885:6385:6167])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4516:b0:3de:61f3:33f8
 with SMTP id adf61e73a8af0-3e0bcf64e6fmr3964720637.43.1790975492097; Fri, 02
 Oct 2026 14:11:32 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:34 -0700
In-Reply-To: <20260903223258.486034-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903223258.486034-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097499601.4081097.16696339000915079689.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 03 Sep 2026 22:32:58 +0000, Yosry Ahmed wrote:
> When the pCPU where the VMCB was mostly recently used is switched, reset
> the ASID generation in both VMCBs, triggering new ASID allocation for
> the immediate VMRUN as well as the next VMRUN on the other VMCB.
> 
> The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
> nested transition. However, since pCPU tracking is done per VMCB, it is
> possible for one VMCB to allocate a new ASID when migrated to a new
> pCPU, and then the other VMCB reuses that ASID on the old pCPU. This can
> result in the same ASID being used by multiple vCPUs on the old pCPU.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch
      https://github.com/kvm-x86/linux/commit/bf260dc9e7b8

--
https://github.com/kvm-x86/linux/tree/next
