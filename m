Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3783F65FB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473217; cv=none; b=FXRmUOgpGtXPScmVcp6jel4v60SM4njC6HW8TYVnhclQ4XcBzenkN+dPODF3NBXRF4xsujmCit/8I/RFoZGcFJAoIlrgolPjV3JicDqnd2/3oZzPopWT3aUoLu1p3Jh7ukI60RgK1myR/MbUIaxIY4LSI5HcIuL89DJf7m40qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473217; c=relaxed/simple;
	bh=kCOzpLNhrAwmd2Cv0+NBTKi/WyuAD0zGKc/AN655oTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCJXhViODLdW9vwjlqZGpVrtgsOZPsfcFNFDMHS8tBxmLeLmIC3O6RkPU2M8xw5t/u+IUgI6SKiq7zm8G0BuBU6QK6fN0qNmeUz9U7dnkTLEflH78BI5h5DB7jAmmJu3OW4aEWtJ2njyS2debjYHPoibPFjV/u9PYYA/afI9P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fbl9XItl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ljWmfTdt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbl9XItl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ljWmfTdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
	b=Fbl9XItlyQTUHXra4smY5lhPa2no17JYo0NaafP775amVGErHDfUmN6yY+69PAkxF+uMO3
	NJ+gtJ+Pd3gwsnUNDFUWWg6s0oQN9USWbhisnDxXcRZqwZN0ekQTKk6luiFaqyf5GsB3qc
	QtdiH9RFp2rCwGOcD0Bi9mupAuPMMUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ZZ123iOANzeM58pTq-05sg-1; Fri, 26 Jun 2026 07:26:50 -0400
X-MC-Unique: ZZ123iOANzeM58pTq-05sg-1
X-Mimecast-MFC-AGG-ID: ZZ123iOANzeM58pTq-05sg_1782473209
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4642a5651d4so711685f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473209; x=1783078009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
        b=ljWmfTdtPeDfU2XKxNUYTKSJtVvyEj09QBiisIRRcD9fmWOdKIXiLt/BB0U+wXQCU3
         HceUrF1syo/G6y2owCrbQGySNKvZx5zRYJpjNqV0uvTE/0r0U/KHDyIm7602HvJh73wd
         bjIjJYiB6I/pqUalR/RFq8KJXVdsrpTzDlmvaQawB/aqSUk0eEbYZRCstvlGkxuZt/lH
         uaAXgdF/ZfvnHFrEXjCllYBMTjkT9YoMmnrCGAPhNTyzOO1M0f+6QKSIES/0tK/M4H8Z
         ImpwQ095nHOQAnSxFDT/Vw2QTv704hJwIAFYEPsN1sIdHHYbE3i1ojbOvoqfyvSciFH3
         iolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473209; x=1783078009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
        b=QI0xJac7ALH2ZbhdOzMBbqaJGR7hgU0wGA4+HjnK0AltCYf6u+ocPqqPrs5RdqHzrj
         oQJF8GpkYzq7MdmbRz7Ztj++HSdK5gzLH77ktBiuRGWWa+WnHPoWjYG2v4BjPiGjtb4x
         YmIg7FSjk2pjt0UD86bGjq8KN6SDrVs1ZY0FLjVSj78Yh17IMja8uVjJAKhEuRkfgvrY
         rni+d22D2e6+S10goHjXS5MiRu7MfMSkbzPwNLkB0p2nsLxHasboUrH557ryehjaxx5k
         aMhR1r1zqASFvSMAfIP4ctxG1Z7/iJXnNWTcGBK4MXpmE4E9CEhZDUlyg0zFzgrYC4Or
         lSHw==
X-Forwarded-Encrypted: i=1; AHgh+RrEdA0ig6Iq5S95b8GxdNygyTYQV9gdLkwMN14brPO4D9DMsNijMQ2TZLMU0wF96Iqpc7JHbrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0KIhk7IO4KQdbrsCbItjQDBVELqBT4vHBm5gXjPTSg62fpIO
	yc9fe9d6+sAXrw6sKTPjbU2S2KecFLmT1/lvMUkzVpgnw1iis8Xe7f0gAoklGudA7E0qHKocwjJ
	NyHBEzAIujN74IA+kMIz9T9vDTsS/Dum+GPyP77fYuTuUo9OSICAK3bk4Vg==
X-Gm-Gg: AfdE7cn14DOMV0XB9LZy/HzjuGNipxYvupbBpizV5mpI8RfUyAi7YMXNB922j1cfQ3f
	OC04AXSKAQ4khYBV6PWQsFJGVPB4dHpWpLvEufXD+kuNVH2BWCGRTBppgE0uosE/ckmmtqZ8O94
	4nUoC9wNl4YozEV5lA1ZnCzOl+isXibqeFtKqXSyYn49bkIAJM/tzvpNAQUMyaUlJX3VS36L5ti
	gCqu52jcMCQiyKfS3U2OCt/7pdS3H6Cm6JH1GF754ndJSzprHp4ah0iNxJ1FdoJzax2Pbdxw6tV
	869kJn3iMcTHRE5lWVClXre2XZmEuwBK5mUzQ8NMONAPJss06kPPDMDoEEYBWezJeX9nwjPsBMi
	w+oqfwzlcxE/3QswAtFVwhYQ6BwZzGa9rg5MaDBjmPl4ktjtE13cGBZ9aW+1cgjucy0vUppTUo0
	JiEqJd/nRV5cEEg5fT
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id ffacd0b85a97d-46dbf117b6fmr10461193f8f.6.1782473209417;
        Fri, 26 Jun 2026 04:26:49 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id ffacd0b85a97d-46dbf117b6fmr10461139f8f.6.1782473208986;
        Fri, 26 Jun 2026 04:26:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1b754471sm23396909f8f.0.2026.06.26.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 05/17] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 13:26:22 +0200
Message-ID: <20260626112634.1778506-6-pbonzini@redhat.com>
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

From: David Matlack <dmatlack@google.com>

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9b1f63b5e86e..97705c28a97e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1659,7 +1659,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2021,7 +2021,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.54.0

