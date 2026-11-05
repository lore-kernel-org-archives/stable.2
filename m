Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888875;
	b=Qqeap/sPZUhUvsOoV5UuIdknb5zyUmYsPEWwr3XjyELUW9eHpBd/ub7uawfHcxr/S4lY
	 giHBeeNA2UtXG1l0WgWKsLuNPvGJ8cmOGEMlMAcvPYTeE4CJX623pYOkmhsdAzG4nIG5x
	 FCwzFLXjT41Afui6ssCkMvZaHJa+vn+Xch8922xAY6q82gNZtszMGXa5ofUMigP9RVKwD
	 WZaHEDyiQvOzkM22Ux9Z4BDeZ+gj3s/JO/M8ySb9vIrEh9d6CAjPuRYdxFFv5/mHZgslR
	 o27IVMjZbGEj7fFMLYvOOJd5dPuHJwWegMkXgeqZGhGAmuAAOCceFr2UL8wPXIi0ebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LRV93Nqcl6llLVOsU+H1CS51ILRBPhoMbPofrdUB/74=;
	b=AYblHzL7N2OA2JBAa/+7qteoFOz5o5OjsDD1yolTbWUt1RapkdsdQ/JuaMg6kiBZt+7N
	 lZx+n3jjlHabzDAkk24T7V8DPV5e2bEC88YpPhXVJ7JpDyLlEk/6yEMcqJ/CZsVv9j/5E
	 jOLT+hScCMXibiEfuwWA8tnnIAvK578VdUhRVuKKb65yRK8AU+1R8UZoyqQE2ocYWYuYQ
	 Kmu4hemSmNdk9oFZh0Qf+9LFlwLRNuxHYDidA6DXp3sAipQuBPFxMukPr6hBHjDBFJV9t
	 rkZBs/VGP9egjSQjj2gvjEkxOMWM7L1d5KM56iyQjHr3VPOhMRr+0TsAG1aMUwHaVdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aN24FoPH;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93928606D817
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93928606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aN24FoPH
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed2c307e62so9384115ad.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793888874; x=1794493674; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRV93Nqcl6llLVOsU+H1CS51ILRBPhoMbPofrdUB/74=;
        b=aN24FoPHt5Fu/VbR5YA9iqjw9gkOHF1L3A557BNn8meDy6aZnJXgPZTx7RKAVC4XwB
         rHG9q8eIUDfoOI8qcV0OL29yQQ+tBcNxfpn6U6nZ8TlL21uO+NvWuYiNDOWfKoVwDUZ+
         lxL1CW1665hITaFPCPpkJpSIoWWH6oKaQ8zK6HQ5fIiLurD2Z4xndd/C3HIDoH36XZa4
         cFhBQpDNrWKM2AIqZjavEni8R5yijEOikryd7H0J9I8ORrgMZDOiaU2x0BzKXEVadqfQ
         yu39hDUdtzR0Pt80zJ1+WR/e6Utasjubwnd2okamJsOfbIOai/+pGiD1xGYZI6rJ9F1Y
         SO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888874; x=1794493674;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LRV93Nqcl6llLVOsU+H1CS51ILRBPhoMbPofrdUB/74=;
        b=gOloj7g7Dowu0JuoDgmF53QUbq0jJf0cNgrPnWM8FZejROGuDclKinUtJ7Kb27cq9e
         kCQwGFGmpKy4u0MUgYo4A5DbgZ1W/d88OhzaKIYOpxfXNesAx0eDaIsre8NA0HKBQ0Rh
         ps9+kIF3vX+9RO0uGh6MBqv6Xqey3+lXOY+9Peq2jemTYrAq9cYrnmU2A9PIW/hNi7AD
         TcLX9VKcG4xSJuFbABEbzEZX0337B11DRl4n5WjCc8GWDwmGKw3AmIhMjuExQq31x7G6
         5727RaoIHwPA6CPeeQjAH98u5ue0qKS0vmeKVzPZpIgAFtc9T0L/u0j+9TugAVFu1VOr
         sqVA==
X-Gm-Message-State: APuU4Z8VJq0gIsgNYhd/eGGhoQqwp9k8/oOD3VpL+JWmCgN2YWCZQeGT
	vE0sdRzB1ejtIddg0iY+6crTNh5B3i6X29RA5zHRIrf3hoo6lcRLX0EKer3bsuiEguxIcbXpCm6
	qfU6p+Q==
X-Received: from plbl8.prod.google.com ([2002:a17:902:eb08:b0:2e8:dd92:634c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd85:b0:2ed:124b:6fee
 with SMTP id d9443c01a7336-2ed124b7265mr40484475ad.62.1793888873749; Thu, 05
 Nov 2026 06:27:53 -0800 (PST)
Date: Thu, 5 Nov 2026 06:27:52 -0800
In-Reply-To: <20261105120208.2031475-1-xiaoyao.li@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026110438-shrink-panic-2119@gregkh> <20261105120208.2031475-1-xiaoyao.li@intel.com>
Message-ID: <auySaIYe-EowIYxG@google.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Formally define KVM's "0xdead" exit
 reason used for failed VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: stable@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 05, 2026, Xiaoyao Li wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7 ]
> 
> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter so that the magic can be
> reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
> defined value (though the whole "dead" thing makes it pretty darn obvious).
> 
> Opportunistically add a compile-time assert to ensure the KVM-defined exit
> reason never collides with a "real" exit reason.
> 
> No functional change intended.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260921235656.1107929-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---

In the future, please provide a quick explanation of the conflict resolution(s),
it helps me assess the safety/correctness of the backport, and provides a paper
trail to help with debug in case the backport introduces a bug.

For this, there was a superficial conflict due to lack of upstream commit
3c75e6a5da3c0 ("KVM: VMX: Move architectural "vmcs" and "vmcs_hdr" structures
to public vmx.h").

Acked-by: Sean Christopherson <seanjc@google.com>
