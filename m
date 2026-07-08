Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F653ED3CD
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549340; cv=none; b=VJMVXQYisNNYA7mKMFdIFRiqzHuaRsq0F4OOYh90XmVB+v77+J9jVHL96Mc2FsM7Kvxiu+kz7IFlejid425mhuu8nmR+vHxi9llLQgvHv5X7BPjlov/jI2kzoYI9ALDlPPe8hr+T6AGWaIV4/BqUYoKFN38bpUobZAyMl6n2le8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549340; c=relaxed/simple;
	bh=kB2vyd29/wFkOJxb5hRcwtTn9qeEKRW33ZRyUqco3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIl4d6wjs7XYvKILbyY9K1cQuvNZM8DUbh8D9/1YzZvh7INRTJ6tutTFAzhgPF4PVIc9IoZzY1jj79WpN1ah9P5R0oMwZUO/4u0vjY5biwUgODmo7mCT8NMy5Kb3pY7SZN1ZHl/Omvhxcc0jS4Tl/gjaBmGadsHM8Mrr5Zh8LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6L2RIgo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6L2RIgo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cceabd70f5so25820355ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783549339; x=1784154139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfstwW5fdgPHEqzlTVyIef12ZG3uZSmm4XPE4cEuyck=;
        b=e6L2RIgoTh8mnqCkHnP0+ZK71peQgkP8YNh/WlR+ATBMGq6DZ8o96A9K2C2aL0IlnA
         Z/T7Qf/3GkJHArJA0iSatCqK2d4oOrHfqItHodozNjkcfcUICLwcGPxbc6oDzW8CMp8O
         FNEoaSWBw00ePuwW9EGxvXmY3DVx2xnoPSYH9nE2w9hIKeafSVvE+zUaCPRxQkJBjTDI
         aqzY/k/auYgCxoTbbtbsXz4K2qhtqSiyruVlZ7I2LSZXAolfFDdi+6Od5as39CciPQfy
         Z85lym3TePLfE+Qj5oqmibLHLw1rdfSrqxqK87xS88J+4X4/7gbvMfA52O8JBKJliwzm
         Ny0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549339; x=1784154139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfstwW5fdgPHEqzlTVyIef12ZG3uZSmm4XPE4cEuyck=;
        b=KsYPLyP2OD9xoJD2RLPBImrJqwRd61ChZh81/ppPt+hmz02BkJpmeMBXdX/El+kI7Z
         wowEVp6UV/X71l6GRdPTahgJCcJ/681PRBZxujV7EWfPmxzlEEJavApO0nZLK7ztq77i
         +OjSWjE5HIrZQ3EAjRv8MwhS1J3NTnirKAuL0zFrNqELtGU7qhN5P7IKb4MJjuhvGxBF
         7aJvTyPtDLdN+19ccHpRu5uk8tTQjnpLJBcZbh2y6wr0lLgUC8PesyjTwDRJF7xtilPt
         PIYD1ML0Wjy6mukVK+/LNSy9kyi2oMLQMwi0D8vek0fYA4jFzX+Da/w4Pz4gl25OZWDb
         QhjA==
X-Forwarded-Encrypted: i=1; AHgh+RrYqqOKf2MOV038Sg/mYoca3Q2WUFcXl5Vz+bFM2qn7QIlW+bTylCM2RqT5JJ1l+Nv/51fwrHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEq0webEI4r+Y2vF5fI+QEexssmEaPjLFiDLNako/dtMY7SMRY
	py9JW2Gw8DZbtBqsfbfbrDQAt+kkqYu5ZAt7c00QjkH4+z1evzYXpqqNXkE5vcLo3leliZD1asy
	yAPwy5sYeREsZbOaV4xk7UJGbIQ==
X-Received: from plbkm4.prod.google.com ([2002:a17:903:27c4:b0:2cc:e88e:4245])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2306:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2ccea3a7a6cmr42757595ad.47.1783549338708;
 Wed, 08 Jul 2026 15:22:18 -0700 (PDT)
Date: Wed,  8 Jul 2026 15:22:10 -0700
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <cover.1783549129.git.ackerleytng@google.com>
Subject: [POC PATCH 0/3] Reproducers for hugetlb allocation failure issues
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, david@kernel.org, 
	erdemaktas@google.com, fvdl@google.com, joshua.hahnjy@gmail.com, 
	jthoughton@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mawupeng1@huawei.com, muchun.song@linux.dev, nphamcs@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	shakeel.butt@linux.dev, stable@vger.kernel.org, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"

Please see separate patches for details!

Ackerley Tng (3):
  Reproducer for false restoration on shared HugeTLB mappings
  Reproducer for subpool usage leak
  Reproducer for allocation failure due to cgroup v2 memory limits

 cgroup_v2_allocation_failure.c | 160 +++++++++++++++++++++++++++++++++
 subpool_leak_max_size.sh       |  71 +++++++++++++++
 subpool_shared_leak.c          |  29 ++++++
 subpool_shared_leak.sh         |  86 ++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 cgroup_v2_allocation_failure.c
 create mode 100755 subpool_leak_max_size.sh
 create mode 100644 subpool_shared_leak.c
 create mode 100755 subpool_shared_leak.sh

--
2.55.0.795.g602f6c329a-goog
