Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B93D9048
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701650; cv=none; b=oz3I3l6w58pNn3oKD29rpEZ8l9kD3AJBNihHjKmnWExCfKOWfV7MV6rGYxG5f12xW8m1x2+g3IaOahzAyyMw2oAGLfGyZQutcqgLSJH5tVNJyVmGxsPfGPjlZ0lAE33G4ndSMdfrmoJiV6CuCZg95vrQgK4TXMS/bWYplOwwxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701650; c=relaxed/simple;
	bh=AvBmdaDaf6nXts/vVHg+iwT3R12WEUKngPpWVuOcvn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9bPdxbwimdq1CBohncfN+OlrpopwHtITsBbIgnEGReZ/MrRgM72O0X9v9aq/aNqqLInW2XUhgyJ/cMafT2Pv8omvDZ3lrE7cZ1uYLjD8DOwLnWop9zioPWiasIgvlKH4it1UhAJxGqbKQRHnMlcmL9LUa17Yg2Y9hgx8HQev7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0/3abqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0/3abqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353911F00ACA;
	Sun,  6 Sep 2026 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701647;
	bh=UbeZq76Y2p5T4kf0gsikREyWOeO2+uFN2qn94JbeoWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0/3abqJK3dmK8sKUoneJQB/g1AG8mAALXKkNviW5YCpUMfePEiTNj8s2royU1/Gp
	 FD2FKUpTkkpMNXcgYe9Gba1LbUyeklYQv7PuRrm4VagHaTF4PDMaQDd2n5Wh9mEt30
	 a/92JYDbl4s2PUDGsgOiTt8mQdCKVqoO6qQR/fDu86r0rzqty1mMUsL/Tg/s45kA2c
	 mor8T1Q7348nq2DLfy8fFok63QB7w5vcMi8iMsLA9N+BI9KURvWJ0aoVGUvuSniwEK
	 mBLRkSERpznbV2EwBEioG1kYmKCA6lAJhmBDx8ssJ0a8Ib99rgBB+LnRO1w7WS9TO2
	 lWgm7q4/YjmQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Sun,  6 Sep 2026 09:33:13 -0400
Message-ID: <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904022657.2656810-1-ziy@nvidia.com>
References: <20260904022657.2656810-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> __GFP_ACCOUNT is needed for xarray node allocation accounting when
> XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
> convergence regression") fixed a workingset regression with it.
> xas_split_alloc() does not have it and needs to be fixed.

Mainline's c299a2285d9d takes a reference on the folio's memcg with
get_mem_cgroup_from_folio() and holds it in current->active_memcg for the
duration of __folio_split() - rcu_read_lock()+css_tryget(), released with
mem_cgroup_put() afterwards. This 6.6.y version instead holds a bare
folio_memcg(folio) pointer across the same window, which includes a TLB
shootdown and several lock acquisitions - exactly the kind of window the
upstream refcount exists to close.

6.6 already has rcu_read_lock(), css_tryget() and mem_cgroup_put() available,
so nothing's missing to do this the same way upstream does.  Could you resend a
v2 that takes and drops the reference (under CONFIG_MEMCG, as upstream does)?

-- 
Thanks,
Sasha
