Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55901436BDD
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390275; cv=none; b=IjoLjmdLtRVJgrvvudq9A/f/8pXr66tKdj35fBKHAivyb/MtYa00dSahaiZxcbmLlh9yT4EkB046B6zrqVPXJnExcvE71RyDA5Lz+WVMV5IhKiJh0cjZVVJlSDZUlGQS16mpsesVfL09KDVcWOBq0fjQWlvy+dMnDzU2wKCcAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390275; c=relaxed/simple;
	bh=fkhO9HAymugVq4OmMKfG9p3rUYCS/g1mLTnUWI2PGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVk3it1Pijx2i10QnUF7Y+hR9WqO0adG59tA+Pv7IejvtTcwxgI1yl231Ds/Yt45z3V7hUVk4dqBlwVIwz7lBTzgen5DbsEPtP7wYkEI/TE3RhM+7xUQs9J4Mfo6TdU9NJCigRHNncokTkQwSj44yop6T33Kvnk23h7qhp1vho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXN3E9D4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXN3E9D4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3296016a12.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390271; x=1786995071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFDzrFtlZRT9MfM2jyoJYH75f+Nc89HfWr6+v0kWxgs=;
        b=LXN3E9D4mLlUYhuEUkPoC8fq5/ymqz/jiH7Gem1ADcZEKD2atalbCyYehYmjPWWDdM
         DQcnNVH9hyQotdScCG3VoNk95ingsppWVujigD5sWfzEU4rmt6l+Vr10rbuOpH9mpgWR
         RiuZ0UW/ck294psW5fgS4S/1UI/ryiFurIgdi3JSYXLAfWwMR6ctjBS0pvGZRjo4Rbf5
         rkxHb1w8fPT9wWeCV3C6Kf7iiyjaeMx0+dFhw8huA71SGyoRDVpWG8jZwjTiDzKYuq9f
         yo36iV9IqxyPdCiBxSSqO2o2cmOu+oDroT8ymuXG7tzHLVoMvPTnbnPBeeQ2NSjIVIaC
         Jwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390271; x=1786995071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFDzrFtlZRT9MfM2jyoJYH75f+Nc89HfWr6+v0kWxgs=;
        b=pva6YyPrrIsSavzYEPDDMRyC+aOAAaI5hxDRffmTuk4N06pvpPev1a1K45dPe9Kt1q
         Z1eZizAbU5GlfDbU+EEZfs5oZc1cOwX6SJ7CJgX+jRY2wuOzXyP1ieGCLwe3YfOkR4zK
         DnvsH2EufMtJsNSzW1r//oVmrzx9hfj3Y3f37HHe+Tef0OiJDYpG9GXyYLkghQ5qUDPA
         Nbp1XKPTR9fMdq8YJG8BkjNvI+b5T+GCHpLddd1P6D9NkphESu7xis7KhhwlQ+F5Z799
         81DtpUFfkjcVtIYRHgVw4pPYFdWLR2Xexw5bAivNJNcwNPmgLnmEoggJ5qSXGwAA0H3Z
         GJeA==
X-Gm-Message-State: AOJu0YwUDZNSsrRRopTy919e1uFEWuZq+TTDGbcAALA5sJuKH3raL2dG
	4TadKIwNDJdx1yBImaGZj4elYFA3whSzNs5D7mqVku2dI4dMlb43qugN
X-Gm-Gg: AR+sD100VRp+sInKn70caoWHH3yM8FVM6vI1VJc/OGHIWk+j6w/Gam7nF+QnhelW6fW
	JkI1w2pCnHIC9HCcarP1fbsmB2k6aB8aDgY/DNkgic4rzEyN2bAI6endqU92/+C6+GCpEqnDwYt
	W7C3UXCnTSGP29iABhCSwH+wdH/4sr8KalLN5P2X/MYDVo+1H6lYrIU3XBUKsrpIGXHQ1WFkr0g
	xvcCG3hMX55ncmJij05ZUd7HwB1plhTrWfhAxE/gwLEj4HlbwZ6EK+4aDDzzmipAGAAs6LdUj6A
	8K+ER+B/8dQizMLrUtr1oMSjY84n3ua6Nm59oWKs/pnnS6YSWOm8FKhBk4SEUSyenaO//2Gfjt3
	fm0SOATR5lq50IkrpJIBNdCNV+H6wNe0A1zD8ohzmvN4oVwDGwMuDB4dcUMTkT/v5wUCqlMJwsm
	nQ2GrZau/4IVmlj49/P65mDzt9XLM6Z12pwHFq+Up+Nn9oaFfG/S1hgAosAP5ZVLRsT+pnyy3sm
	dCk82j2+gRacaZsUF0UohwvVVSFR8WJAMiIuucWeN8=
X-Received: by 2002:a05:6402:5188:b0:6a0:a492:1f46 with SMTP id 4fb4d7f45d1cf-6a1f23fd501mr10906395a12.8.1786390271453;
        Mon, 10 Aug 2026 12:31:11 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:10 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 3/7] alpha: fix the local TLB invalidate in flush_tlb_page()
Date: Mon, 10 Aug 2026 21:24:47 +0200
Message-ID: <20260810193055.3286239-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flush_tlb_page() invalidates the calling CPU itself before asking the
others, and gates that on current->active_mm. For a non-executable vma
that means a targeted tbi(2, addr), which acts on the context currently
loaded, so as in ipi_flush_tlb_page() it reaches nothing when only
active_mm names the mm, and nothing forces the old ASN to be retired
afterwards.

Test current->mm instead.

Reached in practice by folio_mkclean() from the writeback flusher kworker,
which has no mm of its own: about half the calls during writeback of a
shared mapping, and none at all on anonymous memory.

The caller-CPU omission in the same function is fixed in the next patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 1ad448105201..7856d23b3384 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -684,7 +684,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 
 	preempt_disable();
 
-	if (mm == current->active_mm) {
+	/* As in ipi_flush_tlb_page(): a targeted tbi() needs MM current.  */
+	if (mm == current->mm) {
 		flush_tlb_current_page(mm, vma, addr);
 		if (atomic_read(&mm->mm_users) <= 1) {
 			int cpu, this_cpu = smp_processor_id();
-- 
2.53.0

