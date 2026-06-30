Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AA3B71D7;
	Tue, 30 Jun 2026 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793584; cv=none; b=HYfD3Z1TMZplSHz4qwfUQ14AEuAgKQg53Ear2KVNtQQdheqRZhymeqvWb0J/AVt4hGJlWqP6mARKWz//aVpB6E7zCnmyLSnhNQ8IeF9RM29Hbyq9+vvRUDTHYePl1yfpAXmD+xvd4J6a/VKsfWInngR4XznnXdUgqA86WQgwdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793584; c=relaxed/simple;
	bh=P6Uk7lHUNXnieCg17gonvdPUMm4uOU4L51FRPAwbrEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyeIp+QC3+gXhoFfzDyF9cczck6CZ7vYcljMGZFCs3dOt2infiVOpfv0om7CbvBamTurkUeUessZLzgTMGjNAK1XJULHGgSjlF5+zf6XziGvpm9wae/gR6wcKbPNmWrbX9LNVRX52fGTCg3CfgWm9XSeBai6sE/yht+yuq8MIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Seo8Ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Seo8Ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E081F000E9;
	Tue, 30 Jun 2026 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793583;
	bh=Ae8t/Ilc5afoONBuaiJzpXJpdh+evRAuQt8lBfqqfFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1Seo8Ffs3lw+ArmCzrhd6+ZuK+vKuYMzCkkcKrKjxwuJT0X3+DzQ2Awmfl08SI72
	 pIaCRoLbGkSpScHQFf3cHZXrZE7SX8T6cbsPSJsSdCA7QOZOubFE3WbK9N5Xuflktj
	 AUJUIUfPmRsOkDNkIW5rAeKIPjhWe6T3AqAhXhyUDW3MKKKBHcUL5Zn9r+nkRAKn8a
	 cz2W203yWDri1oey6bDLcrkSeF3Qd4TFZcPAaHcbpp/K617KHHh/uLB6HIqMIxCDeR
	 aePKtHaldDnUpqJJIdXc+G7FPb6/UPvk5ym6qX9YRCVuERqhXrbxn4qBoJd4AWPoOe
	 owd+xm28QDkmA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Mon, 29 Jun 2026 21:26:12 -0700
Message-ID: <20260630042612.151351-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630035221.146458-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 20:52:19 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON core logic assumes zero length regions don't exist.  However, a
> few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
> DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
> could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
> and divide-by-zero from damon_merge_two_regions().
> 
> For example, the WANR_ONCE() can be triggered like below.
> 
>     # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
>     # CONFIG_DAMON_DEBUG_SANITY=y
>     # damo start
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0
>     # echo 0 > contexts/0/targets/0/regions/0/start
>     # echo 0 > contexts/0/targets/0/regions/0/end
>     # echo commit > state
>     # dmesg
>     [....]
>     [   73.705780] ------------[ cut here ]------------
>     [   73.707552] start 0 >= end 0
>     [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
>     [...]
> 
> All DAMON API callers eventually use damon_set_regions() to setup the
> regions.  Add the validation logic in the function.

Sashiko found a pre-existing issue, and it is not a blocker of this patch in my
opinion.  Read my reply [1] to Sashiko review for more details.  So this patch
is good to go.

[1] https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org


Thanks,
SJ

[...]
