Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD54AC17C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376406; cv=none; b=piEO4YxoyTYOx5yqADHhm3Pi1LnAddxEJYWPAbYOKHMJ0+8pkrXFcLD8SghafMEsWnJN5KxbgnV0hBOX7J6eb3mytCNBOnu6R8CbT90jFRGK/aF+aoLWcWg0f8cFuxbecJd8oKxxcH+qsSFGPGKFv8FVOP7s19muu9si4lSu4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376406; c=relaxed/simple;
	bh=y0nOywplQ3deuSEhSsaVE3Xyee6bNT1wa/osER2A2b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1GAYCf8nsxGtkD/GiXtnxv0Fa4UjaZHUEUDaFTpSkXvQ5p44hW7lwmmmlPICLYd+MvX3yCQBn6V6P9XhSD/Sb9L6dKhxVPs3s/i3kUJoJv1k/NxQh4C6TSexPn23v+IN62n1zsX+vE3tu0/b3KoIM2K+qrvAvMF9E6sadSNRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikKfQANQ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikKfQANQ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-854f274dd69so1711531b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788376404; x=1788981204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N/WHyg1m6TTdS/dUEqB2VFq+qj0dM9IofHpTvipqAJU=;
        b=ikKfQANQ1ZMjs61k690NKiAYStnMkDdxCSvDcB00Tx2hzEu6cvAI5zDDwsmSzlUSkZ
         3kHmHG3acHfuO+Kug6u0v83GCG6b0cLmcV+NY4ixNGPqwNqkD1L+9sqMBg7L4s1IfBsn
         g3BG5f/A3oz8OqzSxnykI9W92bemnWvfav0azMWgKNHxXfrlkK/WWho88xHO+W1egwoo
         AvSYCe9auPkf8M9ckY3E1CVsFNtXpPkzEuzl6sqav8wCqDEAtovTpITNXpYE83x9ywIO
         piKLbnUATanjS69yRKQ1ChQuT+HILsYwZ54smecCx39WOnlt3v0pUsccbOtVfEuU8B7p
         HGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788376404; x=1788981204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/WHyg1m6TTdS/dUEqB2VFq+qj0dM9IofHpTvipqAJU=;
        b=NlQo/QadzjQ28grF7R47GXNVX3WXjz5ttoVXjR+GScA9SzPidFnx65JUG0hJIbGeRe
         QuQAbB0uX7nN/KZcIoSfqb+j4lZFep1nXs1lplFFKAg45MVnp0NzWsoe4Yes+jZs+z8/
         cMKViuF8L2rb951vZ2FRrRFzDmEMxOKfcTsNHKIBGTtvLS2CGWhGBGFjhDAo0ocDQVvT
         gDvYg4Oy7bdFw+Gg+r3bpv9fkGrsz+RT8fWgnDePFIGkswEinWPLxaUk1NLDAuJyhrHe
         Pp3w4bvTAUEBojNhj/F3CifRH5iiIOh7Irf3id8B2zNw0yurwH95Wzx0OHbP39y4az1d
         jTLg==
X-Gm-Message-State: AFuF++mY5dtdtAfcXx/JR5DF89gTUiTVPGIuAkGQO3IxucH3nTAOvob4
	FGADpemVUhb3/EjWVVTv/rEEORdgSCyQmOzq35dk0aXxz32fbQJUWxrrJi/MONTssJbd4G0Rt8S
	gDqtR7xRi0qy9oJUEy+/IVXj+LAagz+sYam7H4wBwRou8wZUN7Xoa+gIJ89EMUG+z4GFAe/+KrM
	lfcrdHa4FdjsbB/FJjJLtmrBitMad/hcoiflBP
X-Received: from pfbbd13.prod.google.com ([2002:a05:6a00:278d:b0:851:d12e:df63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab8a:b0:845:31a6:d84d
 with SMTP id d2e1a72fcca58-85ed20ee9f1mr11533931b3a.7.1788376404046; Wed, 02
 Sep 2026 12:13:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 12:13:19 -0700
In-Reply-To: <20260821-stable-item001-snp-builtin-kvm@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260821-stable-item001-snp-builtin-kvm@kernel.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902191321.2644150-1-seanjc@google.com>
Subject: [PATCH 6.12.y 0/2] x86/sev: Make SNP usable with KVM=y
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Gao Shiyuan <gaoshiyuan@baidu.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Sean Christopherson <seanjc@google.com>, Stable@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tested SEV, SEV-ES, and SEV-SNP, with KVM as modules and fully built-in.

Ashish Kalra (1):
  x86/sev: Fix broken SNP support with KVM module built-in

Gao Shiyuan (1):
  iommu/amd: remove return value of amd_iommu_detect

 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/virt/svm/sev.c    | 21 ++++++---------------
 drivers/iommu/amd/init.c   | 36 ++++++++++++++++++++++++++++++------
 include/linux/amd-iommu.h  |  4 ++--
 4 files changed, 40 insertions(+), 23 deletions(-)


base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.55.0.970.g62bdec98f9-goog

