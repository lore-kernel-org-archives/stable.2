Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F79768EA;
	Sat, 17 Oct 2026 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268313; cv=none; b=q2xTtdpCeIPf5ftQKKYP15k1aD1BjkiU68LFOKITLQ+dgBAHCmWtfEJbYWi3RfYXHV93QhNxE+V2oA4fS/440B3Z7RNdc3q4abOZKX8HGrVURoFiYoYmHUDFXazurZsr92czN3jPcprYvB7aBgqh/I8rEw7fDK8YsEg+RE06vyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268313; c=relaxed/simple;
	bh=0RjmdEzx1dEa77m7XPkGxCV4G8P7wf/2lCoqyJZVEuI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=clihg08KukP5Jvv/cXmtfyyTrJtFkR0F3+/1eUQQ9OSgFonjM84EnJVUANWK9TgJmIUwPAbnNsDzSRA61GFkkSUbARXKEU/xEqmLSAmsRrt/dNYG6ZemBdxZNUHPXrN22QIq1CukBFgm3scPekSSD3MyYig1dlxlh0Dg2lVbBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WSe2nSLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WSe2nSLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F41F000C4;
	Sat, 17 Oct 2026 20:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792268311;
	bh=lAhESF2COvNcZpbBEtxaDnp4lDWPBoATUHnjiDJ7C6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WSe2nSLhoarMc88nXYKJ1TgMSop5g7gaop+Z4z94vHqiXXNE0zFqr7efSgtk22PJl
	 IudNt6TcEJx/DkN11rFzUyiYj8DN8txkgDbgG/reLq/Qyt5pvRneSXsInMobRvJQ5x
	 ydBVHjJrQDo9kc7imcx6Dcy4vuKdyxqkA43Bosbg=
Date: Sat, 17 Oct 2026 13:18:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: hannes@cmpxchg.org, david@kernel.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, yuzhao@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, apais@microsoft.com, rlmenge@gmail.com,
 stable@vger.kernel.org, Hardik Garg <hargar@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref
 with memcg disabled on cmdline
Message-Id: <20261017131830.d698d0a474745243d5d5b7f7@linux-foundation.org>
In-Reply-To: <20261017050928.128582-1-sidchintamaneni@gmail.com>
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 05:09:27 +0000 Siddharth Chintamaneni <sidchintamaneni@gmail.com> wrote:

> When CONFIG_MEMCG=y, lruvec_pgdat() returns lruvec->pgdat, which for the
> per-node pgdat->__lruvec is left NULL by lruvec_init() and only filled in
> lazily by mem_cgroup_lruvec(). Normally that happens early, e.g. on the
> first folio_add_lru().
> 
> With cgroup_disable=memory, lru_gen_shrink_node() passes &pgdat->__lruvec
> directly to shrink_one(). If direct reclaim runs before anything has
> called mem_cgroup_lruvec() for the node, which can happen during early
> boot under memory pressure (e.g. a kdump kernel), get_swappiness() ends
> up dereferencing a NULL pgdat:

Thanks, v2 lgtm.

Maintainers: please review and let us know whether you agree with the
cc:stable on both.
