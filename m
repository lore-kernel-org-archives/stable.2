Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEB211466
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708404; cv=none; b=IUM1ud+/vk7aqRRrugnApFvma3hlS4t8GKYanCwiiYdBiCsUDeASms0BMVWkoA7IO4yE9JcceW6xCbLvMH4pekf0huUO8+S1OVcH9UHjkgm7pfR6j2MNiZg/0S+GxwrvgbD+Pua8BgTn+wybsrfNK7AZg0s5K8Glm41i+6UutKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708404; c=relaxed/simple;
	bh=xddEwg9RunMRuvB/k049ds1rBCYLv2ELWCpHxLMwfus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfoHCWjZbW8LBDVL0/ZIyG+QBZ9Elp2gYqHipg+LZRgW6/0q5O6cUZ9T9VDJ4BaZG+yKNYU14QQ2RYBlHUZCI0Z8993A4Z8/qwdH8y6nW/DGw8rUUW+pby7unlH8lqqmrL4Ox0gWFSZF2H+UASii3JpFVTvnTZapVZQ59oRkB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFoWZiby; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFoWZiby"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3964b061528so649313a91.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708402; x=1788313202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9D0ya7fAGHD4mh1WhP+JBRzlt0nXa7uSYqgCddP+Sco=;
        b=YFoWZibyJ9THs0OTsUudD2LnUXl4W3tn0eE9KBlZVzb95U94ymGYhGfYtC3Z5hTI2f
         jLymFKwlMIoHwur59BfZeR21MqmI7o7WaAt6lMh+XifUk9B1usC0CszpVUufpG7etk/I
         uucNDtjhL7r/fLhR2JrpPQeGxgePxmhAftqmJvsjq6Iu3soavwL8BEjs0Q+KFS/XyM+p
         pEn6iFi8ZhFRwJ6mPCE/ZY4T+mhGL+VAOzhkW6VrF2k3lh5ED4RK9lKnDllaY7wYRErx
         TfkyrSJjM1JvwxJAipciqVPy85DFpSAOGZp/P4uxJfuuWNfB4q/4CncH3A5dalyqZvDa
         KHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708402; x=1788313202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9D0ya7fAGHD4mh1WhP+JBRzlt0nXa7uSYqgCddP+Sco=;
        b=FPndX0BPvuELkycIv8S4dhZo5Mf/1/hxjIEuHIVg6u8F0EPU3TDERSikGCOZdPgpNL
         hGKXVdMaFFqpY+D/UqCXJTEpwizUFZXpM3q0wcVz/Pn/bSI2qNuMZY5l1fVLh5DZO/df
         VqfiF6DhhnrO4iAU2bDeyNoE8LuNJOklaReYLCauEK4Nlf/Ojewr+YMNqA2heCTScArJ
         wS09e6MjF3kyM7GooCh4MzFqf5uGCT9jsX9GUHiGCnQCEgrLzC2GAVqBDK4B674ptynQ
         kZ94gRhKg9fbF5mKnQwofun63ziFySdfQw6hqKqI1LToCoufMiQIK+vF/+pSi8hG6b1f
         lCgA==
X-Forwarded-Encrypted: i=1; AHgh+RpaWeeLanc57FPKZrGZcomHStZRug8e6ewW2fNiO0qY0kUL3CZNd/GMKpxoh2NhgeebCd/jQtI=@vger.kernel.org
X-Gm-Message-State: AFuF++luk4QX6F3rxx4n7wAmsGxmBwwCiOJsN7MnoJskqciPvL2ofR8H
	mFfVvAyxfYnhylVtxJEo+V93Bvt9Cfvs/RDaihfdMQLUdW874WaOIKX3
X-Gm-Gg: AR+sD12pNMhfm9JL4KFK9/MgohRpAe6Tk8Vr14I/l7F+iCdlqOFGqaRZ6dOvgAhZS5G
	27Npftvgaj7P0gi9SP4ROU8PqSkny05cuuHLUYVrYaiUzmBfBzClaWHJVvzGoU3IQ1RXOigyxz9
	838xeuyXkfGXG0SNjCvZ2et4tEO1MjTFCfemXsDAhpJ9KzfEo6xyYWpT7dfgvt2McPFa36cqhEe
	ztNlfzcWWymymhWO4kNvtEVjR8gSbDHmMFANMOLJRUr4TiuZH/Yb4iOJv1X0W+UHuoEHj0Wj/xv
	5XxSTc59cj+VJq7Qn50U7OALLGE7u9Lkbdy1fQAnq69Udm8iFSCTiCxVGBcYsuWeWqBNOqNf84k
	tbjEO9tID1X3ulKgnD02tRxk6LTpkh0jPFuSk/2Lb9zCfBIRRvrLhNQBWOOA/CBo1HFtV1IHiW/
	DWlg5m10NhwerPNepriiyUAsC+PB/uvYG9FN9XlYg/tnOwQUok8qf9re92mII7jRk/+0l/SbSl
X-Received: by 2002:a17:90b:3cc3:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3966d20cde1mr7186084a91.8.1787708402417;
        Tue, 25 Aug 2026 18:40:02 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3674887a91.2.2026.08.25.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:40:01 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Hagen Paul Pfeifer <hagen@jauu.net>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/secretmem: properly account locked pages
Date: Wed, 26 Aug 2026 10:39:48 +0900
Message-ID: <20260826013948.1325213-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
References: <20260822-secretmem-accounting-v2-1-fe445a7c6eb1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I tested the exact v2 from this Message-ID on its stated base with an x86_64
KASAN kernel. The supplied memfd_secret selftest passed 6/6 in three boots,
and my accounting-boundary suite also passed in three boots. I saw no
patch-attributable KASAN report, warning, Oops, or panic.

A v1/v2 differential also confirms that v2 fixes the CAP_IPC_LOCK creator
delegation issue Mike identified:

  v1: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=2
  v2: CAP_DELEGATION creator_cap_ipc_lock=1 receiver_uid=2001 receiver_pages=1

I have one policy question before adding Tested-by. With a one-page soft and
hard RLIMIT_MEMLOCK, a non-root task whose only effective and permitted
capability was CAP_IPC_LOCK produced this on v2:

  CAP_ONLY uid=2002 cap_ipc_lock=1 mlock_two_pages=1 faulted_pages=1 raise_hard_rc=-1 raise_hard_errno=1

Thus ordinary mlock() of two pages succeeded, while only one secretmem page
could be faulted. Raising the hard limit failed with EPERM because that
requires CAP_SYS_RESOURCE. Is this divergence from ordinary mlock() the
intended consequence of removing the CAP_IPC_LOCK exemption for secretmem?

I saw the planned selftest split and cleanup in the follow-up discussion. I
will retest the revised patch before adding Tested-by.

Thanks,
Daehyeon
