Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF75394780
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390273; cv=none; b=RN3U1arPaVirnKpS1iM5qtag4UYtO2VBjNb/wQzG1kZXbxbBl8jRUpn9xo8kmuzTn9i4z0Qp00LL5GjxNSUPTvU6bq9TY3Xmsbbz+T09PRr/Zi7sjud7LHiOr2lGh1k7iPukwObaNSvY2JlpYsYf8Jn5Gf0E7PWanzCulNFt9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390273; c=relaxed/simple;
	bh=2LEh4N21WEQPtgsS/wklt177lc/JUP+Si+EuLT16XJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2D3otAPHY2p5+zCBCUtoZw8kWERg8L4tRo1lTTOoqHujCYnAGlKDe8AFAzpjBsjqL6KBks6BVzJGyBE67LTZpgysBKmo7hvl1hgZRGnG/68+iVbkz2nkGJJvQaTHCbc3P2UqogvxOob1A/Eb8onYYQMrSIciVloSCtEN6n5jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmaFeO0J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmaFeO0J"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so3574724a12.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390270; x=1786995070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRKEDfsj3neRvHaPQAcC4yHGhjyN32qyFm0f+mmrXno=;
        b=NmaFeO0JX6coxrJwuBusuGPTlW6rQbRyBddIVJQCLHNr8qzULiBwu2aDFjZhnAjemz
         JTpMJ4NHmYzcXqjc0+wfbDzRf+x9UFaFVEtyEG13vo0uXQKYzFdj2FI3fESfUzjs3w2i
         y5AR+hzzbPHqkCeeoduJHDo1qBB6b+BL6N10OxMqT0p3+4BOuqjJiJimNpfs8E5s0fIH
         1m686cTQZJnI03yHKPa6IKgDB3x7TJJiVLi2i1aTgYGSkTmkplRv+s+e7x7nxcyB47Rj
         2LYEkdw8S0vnw82wZfhdvYVA3Ig7sdUNjlGpMocVIBwSXHALNfnUO57c8ibmPM86Ge9O
         +b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390270; x=1786995070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRKEDfsj3neRvHaPQAcC4yHGhjyN32qyFm0f+mmrXno=;
        b=D/h6ahZCG4+gO0hI+ukICSXZMuHaAH13EevAFdEGJg3EjKZwi9X4riQAo50OCjWrMz
         caLbP3iEbQGiuRQXLnmAEMkYNV+OZNI0WdV3dQE29SHXPQ08EhkSnucupyPfcfS1CSze
         ho6vpFtFfK7ttYi/jBAXguUjxUZLY3csrRz9hZH0jfmiSPV3f8d/TLnmY/ceZ0cQRM8p
         a0P3lf22RjffBJ41X2K3q0IhI9YLcZ1p1kuvcdf7iSWICAj8HIvysXIJI/3Q/yo8hCBg
         jCCUqjqh/8361imYVmD+HGjXMjbwuxH0n2xJVHT3qdRPykQBqzaSNajrLQzGsFAHBiQq
         E7jQ==
X-Gm-Message-State: AOJu0YwxAl0oR2VAmqTePiMWu6SncRnzSVihVtBqlX3NbUrxG/RU0sBb
	GktszkKKj+r6JkSaR/CMdYZ6SHZwAlLuW+Q7M/kKLooFoEVdyZ7JyxXFj768Idxm
X-Gm-Gg: AR+sD12jqTIZHbteBSPaFW8HJMIy54vAKaWf8cpQ2ue+GCDAcU3WQhRYAucFttfm+Ge
	Am/IXflUXC/KN5rF9G32A4h+b4Wl1LRgqfPuogv38OUCGVnUgN8+0bwm3YHDgTGUQlAORb4BMS2
	pz3enfWeUNx6ahMTsRqhOaVy3ZAzDb3KYnYKbMvJ42PMnLUKWrcM7z4u9RwsKJtS/ZyCP+xdq+i
	qkTD4NGpthXhewyvU1/ftBfasgBn5XPt4rpK4TLX3lrkUCmgjfcexyz9oGU2TflI1qmKvGPWIZU
	FRoG0HsKRda0fnwsb091c51jPnTIVl3Bi/aLiiSpELpEVg6zy7/gs/MkyfXpX8co+7XVD2BwnGG
	ExiCk196E/7IOMpZ1kQM7GUSMev0ZLzfldyyZoYwn0VGPsKBjwZGt/AzNetulveyv0FDu1P4SKJ
	0+zYnmGI5G/M46K9hcRwy9BIIEnwl5bMjaFOndMrNegz+MWKfbYkWrURZrQkfJJcBVTPCfN9EJP
	SQRDOADLfD/NBMerWYFOYQdCI6TtFk=
X-Received: by 2002:a05:6402:5303:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-6a355e781f2mr2410580a12.18.1786390270122;
        Mon, 10 Aug 2026 12:31:10 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:09 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/7] alpha: only use a targeted tbi() when the target mm is really current
Date: Mon, 10 Aug 2026 21:24:46 +0200
Message-ID: <20260810193055.3286239-3-linmag7@gmail.com>
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

ipi_flush_tlb_page() gates a targeted tbi() on current->active_mm.
tbi() acts on the address space context currently loaded on the CPU, so
it reaches an mm's translations only when a thread of that mm is running
there. current->active_mm is not sufficient: under lazy TLB an idle or
kernel task keeps an mm as its active_mm while a different ASN is
loaded, so the invalidate hits the wrong context and the stale entry
survives. Nothing retires the old ASN afterwards either,
mm->context[cpu] still being valid, so the resuming thread can reuse it.

Test current->mm instead and otherwise fall back to flush_tlb_other(),
which clears mm->context[cpu] and forces a fresh ASN at the next switch
whatever is loaded now.

current->mm can be set while the mm's context is not loaded: a task that
borrowed an mm through kthread_use_mm() has current->mm set, but
ev5_switch_mm() only prepared the PCB and the asn_lock it set is still
held, as described in the previous patch. The !asn_locked() test keeps
this path conservative for the whole of that window.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..1ad448105201 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -669,7 +669,8 @@ ipi_flush_tlb_page(void *x)
 	struct flush_tlb_page_struct *data = x;
 	struct mm_struct * mm = data->mm;
 
-	if (mm == current->active_mm && !asn_locked())
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm && !asn_locked())
 		flush_tlb_current_page(mm, data->vma, data->addr);
 	else
 		flush_tlb_other(mm);
-- 
2.53.0

