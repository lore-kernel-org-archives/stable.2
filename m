Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD864A8C;
	Sat, 19 Sep 2026 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777568; cv=none; b=BLkZsxW7Gzu+32+6SJD0GqRORwStb6p8fAjb1l8AfkqwN3vRYLASsv7fFv41LLHK7/GaoD31TBX2R9BIY5yWRPw+E+3eJdts3yCURDsvOhEgHebob7u8M3EXoSR++s9uIkN6KJcYD8ug6twdd5j3rUHzz/an4bY5rQ1BO1cVRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777568; c=relaxed/simple;
	bh=Yoyql3cjZgmbP2RVwcMSapgV6fogC2z04BUy9vju/v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2uCSq6Id3nPBykUEkpJHFVaXTjOd3ktp/1N6EAMJKH/jlCPcQCmUR4F3k5Gl+5bGVq3wDWi7+FtzflRrvfM36UaCqZ4dX0iwU8zTdQarX8NfynAR8b2DMBRAwHPUvOCthRND6lcbaRtRZBVfnhio5iuMpmEr31XdZ+EmV0amkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV3bGKNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV3bGKNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A801F000FF;
	Sat, 19 Sep 2026 00:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777567;
	bh=GELPEbFVXKBklHiVlViGJWcS9YhkAO9x07HDRK0Qds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TV3bGKNTwt+dkaw3NYtbnogRbP7A4Fi+w35zUwtO1TuyPq0NINwHeY5n/wakATuno
	 uyGjDCfSlS0O1xEFzVIL1rXT7NBO9Jzdqa+SByrG9LvpD8YlE2S914XaajU5ISUpEd
	 jvFA26hMiyQLQi1o7hSESoH9n0XSesNoLYx1Y7BXRzYfshv06+6JfJVH8vqSeuz1MV
	 AUgjctXXZk7BV2l9ahtxhEfEN2BfWFHIgHx1F5QUNoMN85fyKiN9BA0aSQ+l0t1hQr
	 G4ONe9h6qe3s/Oujmq9+uLFdqYPimkS9LC3ayndEFuiaOcqlMj/72pH/rNIE5HwLlB
	 JFLjCPqxwQsZw==
From: SJ Park <sj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: SJ Park <sj@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: report RCU-tasks quiescent states while undoing a range
Date: Fri, 18 Sep 2026 17:25:58 -0700
Message-ID: <20260919002559.77365-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 04:24:37 -0700 Breno Leitao <leitao@debian.org> wrote:

> This shows up in the Meta fleet on ftruncate() of large tmpfs files:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>   00000000752fd185: .. nvcsw: 59455/59455 holdout: 1 idle_cpu: -1/0
>   task:rocksdb:bottom  state:R  running task
>     __folio_split
>     find_get_entry
>     find_get_entries
>     truncate_inode_partial_folio
>     shmem_undo_range
>     shmem_setattr
>     notify_change
>     do_ftruncate
>     __x64_sys_ftruncate
>     do_syscall_64
> 
> shmem_undo_range() walks the whole of the requested range in folio_batch
> sized steps, twice, and its two cond_resched() calls are the only
> reschedule points in that walk.
> 
> cond_resched() is not an RCU-tasks quiescent state.  Use
> cond_resched_tasks_rcu_qs() at both points so the walk reports an
> RCU-tasks quiescent state as it proceeds.

Makes sense to me.

Btw I wonder how many cond_resched() will survive from the Mutphy's machine.
Just thinking loud.

> 
> Fixes: 8315f42295d2 ("rcu: Add call_rcu_tasks()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
