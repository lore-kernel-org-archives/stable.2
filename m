Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112F36B914;
	Thu, 13 Aug 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648984; cv=none; b=a2oti71MnFAiVM7mngEQa4BWYKrgUKDjnzxaOjKHY3FAhedLxbQrS3f2LuFlre0Nb0oEljc6Tgx5QhwbnGMJGIYaB7pl9mCF5mvtWxZvdmDX4G9dopvI8iToIrFbmhiowUT9nH60HXnHJRYK1LMSI3Ha/2JN07o90iv3DaHXDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648984; c=relaxed/simple;
	bh=aZkxFcMXQq9ASszEUmcpmHZH/WRTD4Ta7iczGBLkYjg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NUB8Nrd+sPZ4nceSXRudUlp5waQpzGIZ0OpxW5rfCZBUtTzjNSj2rw6gMlD1G9MK2NdVgN+TSXH+ys3CCvYmCnoOZM6RPiWY9qT0LSHQVmhwuJu7ehNuG8NdGL0Vj9CFNEbp7IL9YM2YlYh761YvTwk3jSXDBPiy7JrtuU633Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hPWI2LDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hPWI2LDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC561F000E9;
	Thu, 13 Aug 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786648982;
	bh=H5Utq32nBVG5zGqWf4WSM3DsWmatGp6ZBvVtqGuut6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hPWI2LDBHG7D43iUCa4tpf2cpjdK9BI2oMxttDbb9DnipWXU1gT+NN423E+M8eYSY
	 zbdQ54ACS/VpCimCXxs1iMKwOgPJ8s6Ie8WQjlZ9pfTeAYBnSRbSHjaNZahEFa7Oj9
	 w33LzxQgelSkKbt+Ou7dONVXhs+21IGqXIFQXXXs=
Date: Thu, 13 Aug 2026 12:23:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 linux-mm@kvack.org, Longlong Xia <xialonglong@kylinos.cn>,
 stable@vger.kernel.org, sashiko@lists.linux.dev
Subject: Re: [PATCH] mm/swap: publish cluster tables after full
 initialization
Message-Id: <20260813122302.516f19c013a25968e7dae741@linux-foundation.org>
In-Reply-To: <20260813150316.2793642-1-xialonglong2025@163.com>
References: <20260813150316.2793642-1-xialonglong2025@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 23:03:16 +0800 Longlong Xia <xialonglong2025@163.com> wrote:

> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> swap_cluster_populate() drops the local, global, and cluster locks
> before its sleeping allocation.  The allocation helper publishes ci->table
> before allocating the memcg table and, on some 32-bit configurations, the
> zero bitmap.
> 
> A stale per-CPU or global cluster cursor can reach the isolated cluster in
> that window.  Since CLUSTER_FLAG_NONE and a non-NULL table make the cluster
> appear usable, it can allocate a slot without the auxiliary state.  An
> auxiliary allocation failure can then tear down a table which is already in
> use.
> 
> Allocate the complete set of tables into a private carrier.  Install the
> auxiliary pointers and publish the main table only while holding ci->lock;
> the slow path does this after reacquiring all allocator locks.  Allocation
> failures now free only unpublished resources.

This is a complex patch, for a problem which I'm assuming nobody has
ever encountered.

> Fixes: b197d41462c2 ("mm/memcg, swap: store cgroup id in cluster table directly")

For the eleven thousandth time (I'm not blaming you - this is endemic). 
When fixing a bug, please fully describe the userspace-visible runtime
effects of this bug.

If there is a report then document this.  If there is a testcase which
triggers this then document it.  If there is neither then document
that.

> Cc: stable@vger.kernel.org

Especially when proposing a backport.

Think of the -stable maintainers, and of everyone downstream of them. 
They're looking at this thing wondering "should I merge this into my
kernel".  We're providing them no reason for doing that!  We should do
this.  We're the swap experts, aren't we?  They depend upon us to
explain these things.

> Assisted-by: Codex:gpt-5.6-sol

Doesn't have a great track record, in my drive-by experience.  Sashiko
has found real bugs in things which gpt accepted.  And a second opinion
is always welcome.

Sashiko review says "No regressions", but it also says "Status:
Skipped".  I cannot figure out what this means.  Let me
cc:sashiko@lists.linux.dev.  Folks, can you please explain?

https://sashiko.dev/#/patchset/20260813150316.2793642-1-xialonglong2025@163.com

> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Thanks.

>  mm/swapfile.c | 167 +++++++++++++++++++++++++++++++++++---------------

I'll take a pass on this and shall await comment from the swap
maintainers.  And please understand that it'll be a lot of work for
them, and without that statement of "userspace-visible runtime
effects", their motivation will not be high.


