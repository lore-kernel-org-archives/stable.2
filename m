Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618E3F6C48
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473221; cv=none; b=FTw+lOEyj8htQ775LtxNJAmHNRzUxAkNLgdPQZxeEw3U0rGThvsuvzJD2WUOPyRQiEGH+pKq1scSitxgy+8sPWwom8Eaz6iwi+2sSjNk9hdsGV/npDP97HpdIAAj+nJ+tgIb+uW/7RsErst8eH7vEDe58JFa4xcuuY5Y+hRhE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473221; c=relaxed/simple;
	bh=weYSUgaYkqSXYwb5X3ty9F+fWEmo2ZS70X7C1+bNYMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSY9rA8U/aPzuki7qFRzkr9t4mGMNjywnKYqy1Pfr6oHVhgHZYBvWoyPIcLrWk9Bmr5vO+mLjPJQWg+IRQIgeJXKe0sFXMTQXuW9jGEfLKahaqzsQDoMgIG/uy5p4Yeop8CsfaaVBo47uxDqW8pR0Kdqv1jX3rO4QlGKjq9SJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+6FPsYt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewUeV75r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+6FPsYt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewUeV75r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
	b=W+6FPsYta9OHeEphRS7jJzmsi5eGGi5klEvt7jHBJbWCmo7n2tqA+u4oUEUgTejgfn3Tk5
	PqfmxHoOwCIleakPwdDJJvgnUoZDBUMLbG7eMRbfyflGTcn1iC0P0+3KunAMXpAZyzVZUK
	+9wjh6FKWSK1U6mgzSi9qqunKgUAPxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-I_97ZMxiN9-tugPhhabIqw-1; Fri, 26 Jun 2026 07:26:56 -0400
X-MC-Unique: I_97ZMxiN9-tugPhhabIqw-1
X-Mimecast-MFC-AGG-ID: I_97ZMxiN9-tugPhhabIqw_1782473215
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-463aaa77ffeso489130f8f.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473215; x=1783078015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
        b=ewUeV75rBwCtRpO5pIh5GVMsmn0RTcGtLq7hUgno9+r8DOX7JhEWihrX9mPFVOq8cL
         Kkv7OqVHgt3OYxP1Z87hq58RsTw7O0qLVnXOwTlO8vTbMaR8Tz8OSKi66EK/JxUmHY17
         7SO/G1Hd/ePPe0hQHP/ZHdYgz+O3jLRAk3VETCmpTABXW/4X3PbPfzw/gJ2xk2THG4m+
         5WDTIBiASzk3YGohJvR8HosHTSDcBwhkt6d45vMoyvzPSTSA0flPXzpvVjSB/IuBsf8w
         KrCnWJ45cQkJpOWj5WyTIqKd5oJrokIxA9QD2OPTGvMXlnrIWMi7v3bIZV0BW+8MsB9q
         37lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473215; x=1783078015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6BcOA0+z/i0uW3obMPgn2IQzAL5+x4K+CGN3abb/tg=;
        b=dNuih5s37uIgKgFPPQyhRSVoJlB64TYRENIcNPWElfC3kPm9rVJBiG7au8fSWEmDMN
         LdxGAGsN3ROYdBgkHQE8itz65NFhURw8v3CSWyDSMUB0qfg/py5TZ9pOpmB1LBb+Y5xE
         Mq8VAQ+q/gP8L7t5dHd4Clnxb+tezVuFTmQ7j08AY+Bfh9EjTgQDUPUpnOdIZhzN4ZM0
         CYP6iyk/Y1Y2AJoPUixHFlsQwRvSMxGjRG2ms2aS1geQtQbV4fxRvlpNrjNo2ZvkqTBB
         qpp1gEBQJGe3szn1iJLv0DaX2deQ38FSN32QoooLLLHkeAzq8NQ2J5K5DSLM35Zz7Sr0
         P4QQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU4nzyCCUvMRZ/IGg9ZqgqMMnN165lPCWOKH++g7GOPfKOV/tJzVJd4beisSWkOVE5HmXNzmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ8z72R/tbCUPsIJ7YzErqjBCle37q8wyAym0F0SIDPypcYyU
	Kboq83rb8cvg0gA6EAzhBFUqo7b0fSTaxJSqWzqY55pKs862Dz9S7lDIUGwhdF1R/iZ7pKylJ+J
	wP7ytA5DAWzhF71uliqbjXcV3pYvocRZ7cWX3ww0roRwvpVrbISVEkDWBjHXRa1WcOA==
X-Gm-Gg: AfdE7ckpSy8zOAJJqNS0qrbTJ1wXjYl77ap5KLsDWqTK5diGqEEbvcM60EuqmEPvHZz
	w7vjwOjOzkI5vORSZpL/RP28HiHvSX90QOLA6WGrprAWhMWT+2/G0mrNJOxBNhcNprcdmjUu9fA
	id5YQYrTJnM78v36ai6Vpn7o8BidWUrOohxTrwxfyk0tenPRtCGwkYjhMXvyBhtPNa30wpo9YeF
	rTREm8k0tGvreToOlU/djt31bGggS3sOft8In1r13qDVk6kGZXUpSyo3KjAFsWpK4FAHiekSbRB
	gVY3gFQMkmHtbp2F3aohhnNS8Hf5IZazgG4vPpPObN67ppLYTOQyVMsjSAnq4SyV+nNkZXiy4ii
	2tBpCb9rXI6VuMRKxEsJfZt6LnFZKeyyn4pZdje90rnSUoSXjDucjumVWHyeAjSfj2UWdTyJfhZ
	gCeNbIpqEEzhHqOSOh
X-Received: by 2002:a5d:5f44:0:b0:465:fa66:be57 with SMTP id ffacd0b85a97d-46dc12df7bbmr10285956f8f.30.1782473215057;
        Fri, 26 Jun 2026 04:26:55 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:465:fa66:be57 with SMTP id ffacd0b85a97d-46dc12df7bbmr10285895f8f.30.1782473214656;
        Fri, 26 Jun 2026 04:26:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm14175351f8f.19.2026.06.26.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 5.10.y 07/17] KVM: x86/mmu: Refactor shadow walk in __direct_map() to reduce indentation
Date: Fri, 26 Jun 2026 13:26:24 +0200
Message-ID: <20260626112634.1778506-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 03fffc5493c8c8d850586df5740c985026c313bf upstream.

Employ a 'continue' to reduce the indentation for linking a new shadow
page during __direct_map() in preparation for linking private pages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <702419686d5700373123f6ea84e7a946c2cad8b4.1625186503.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b168b804ac7f..161e05783629 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2891,15 +2891,16 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			break;
 
 		drop_large_spte(vcpu, it.sptep);
-		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-					      it.level - 1, true, ACC_ALL);
+		if (is_shadow_present_pte(*it.sptep))
+			continue;
 
-			link_shadow_page(vcpu, it.sptep, sp);
-			if (is_tdp && huge_page_disallowed &&
-			    req_level >= it.level)
-				account_huge_nx_page(vcpu->kvm, sp);
-		}
+		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
+				      it.level - 1, true, ACC_ALL);
+
+		link_shadow_page(vcpu, it.sptep, sp);
+		if (is_tdp && huge_page_disallowed &&
+		    req_level >= it.level)
+			account_huge_nx_page(vcpu->kvm, sp);
 	}
 
 	ret = mmu_set_spte(vcpu, it.sptep, ACC_ALL,
-- 
2.54.0

