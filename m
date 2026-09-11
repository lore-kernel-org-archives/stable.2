Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E163B9935;
	Fri, 11 Sep 2026 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155136; cv=none; b=sPbicuSQw9HPepNa6Z+w4CgE6i/fnouQl5N+YRBCZ9YztxcHoOOeVT1h73B3l6S5/XcSZguiZCAY3M4DBx3mVQRpak8K+IQOwgQ0HXWYNMiE4ZCoSN2MvZo4F3ht5lssVzzFcALi9gU1KkaAf872VcAZ3/iUZ7jqezTzObuyrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155136; c=relaxed/simple;
	bh=my8F0b++4+/SrWCHHWDCVUe7ZyNpxkzqfe/jtVDLFFQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PH1d9PcAcZsftXx6MThveyKHU8fV7yWbymIcpI2ziXIkCODxNnn4nHNXjLZ3ly1w30nXyhTpBPvjdPECI9Zz6y7ZB83THvSDEuAtfNzhnQi+L9gJiZzUj3/YsacWdzruqhm1X1mqC3k3+rzx4OeSJY9ydFCKPeAXcSwGtGTcqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S6NG9S1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S6NG9S1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F1E1F000FF;
	Fri, 11 Sep 2026 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789155122;
	bh=qRKJ/tEmrkPVoFAYCp3A9/IzZt2yR7tG2arLtuFgKvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S6NG9S1idtPtkyjJPU2oZAFt2sMBrMDvApMrgGU9+oAWVclcGSm9oQuKkXaU9HqIg
	 V9H4TCxN2Ga7PY0eH+5ro/FVhtIb05j5M1uWgamxbWACnOKNQV3e1w7OyOIHG+KTxH
	 8ItBeMoFJp/0+DLBDGfOk2MpzZO8EyHMQT7i3HpQ=
Date: Fri, 11 Sep 2026 12:32:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Dennis Zhou
 <dennis@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo
 <tj@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback: bound cleanup_offline_cgwb() rescans by
 rotating scanned inodes
Message-Id: <20260911123201.8fd2cc28abcbf6bb794b4ce8@linux-foundation.org>
In-Reply-To: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
References: <20260911-wb-cgwb-rotate-v2-1-a9ab253a1295@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:49:49 +0000 "Patrick Lu (Anthropic)" <perf.patrick.lu@gmail.com> wrote:

> cleanup_offline_cgwb() prepares at most WB_MAX_INODES_PER_ISW inodes
> per call and is called again until the dying wb is drained, but every
> call walks wb->b_attached and then wb->b_dirty_time from the same end.
> Inodes already prepared (they stay on the list with I_WB_SWITCH set
> until the switch worker runs) and inodes that cannot be switched
> (I_FREEING, I_WILL_FREE, !SB_ACTIVE, DAX, already on the target wb)
> stay where they are, so each pass rescans a growing run of them under
> wb->list_lock and a full drain is quadratic in the number of inodes on
> the list. With ~17M inodes attached to one dying cgwb we saw this end
> in soft lockups, with CPUs reported stuck for 21-48s.

Well.  "quadratic" is a trigger word around here.  Even if it's O(n),
someone will hit it.  Thanks for working on this.

> Walk both lists from the oldest end and move every scanned inode to
> the newest end, so the next pass starts where the previous one stopped
> and the drain becomes linear. b_attached is unordered, so nobody sees
> the reorder there. b_dirty_time is ordered by dirtied_when, but the
> oldest unscanned inode stays at the end move_expired_inodes() picks
> from, sync takes the whole list regardless of order, and prepared
> inodes leave the list as soon as the switch work runs and get a new
> dirtied_time_when on the new wb anyway, so the only inodes left out of
> order are the ones that can never switch (DAX), and only on the dying
> wb.
> 
> Fixes: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
> Cc: stable@vger.kernel.org

It sounds like this.  Maintainers, please lmk if you feel backporting is not
justified.  It's a five-year-old thing.

> ---
> Seen in production on a 6.18-based kernel: with ~17M inodes attached
> to one dying cgwb, a node spent 36 minutes in back-to-back
> wb->list_lock holds by the cleanup scanner (~6ms each, ~46% of wall
> time, starving writeback on that wb); with v1 of this patch the same
> workload drains in ~30 seconds. Also seen on stock Amazon Linux 2023
> 6.12.68 as isw workers spinning on the list_lock in
> inode_switch_wbs_work_fn() while cleanup_offline_cgwbs_workfn() runs.

This is super-important info and it deserves to be above the ---.  In
fact it deserves to become the first paragraph.

