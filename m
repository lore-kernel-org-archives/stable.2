Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984347C108
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721950; cv=none; b=hY9Omc0bpD9Bu41cxKy6uohuuvcl7P8EEYqdkKJcHvLTRcNZP+UwZsVFD4v2jtywWcQ/i7pcr8uRpFTsADXYD5G083OEbg5/KGVljxmH7yvkcJlUigQWu71FVOF2tgVo8b2F2kITKmoVqWuGaHrjf+LPQa2Wo8FszPbP6Gy+jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721950; c=relaxed/simple;
	bh=BiwMGlo/TiDs1rDpAufMP26cbpdmc+V4yzYFlCJAcnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9JGpt1XmNtdlrcNDBJOkJBRFxqJxuw+OZhuZiL42R1pF7O/C8KZX9WTY5yxooMMg5KLEFS8QazIkzqDlv3zT0LnaK+/nUfZdCF5lTsfv8kWPhZa3XGJzK36jvVXGWHNKo9HNruy2ggc1jHuw9bhg8Kn/65sPHYjSDKRiIBD0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4djiRf7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4djiRf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721948; x=1822257948;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BiwMGlo/TiDs1rDpAufMP26cbpdmc+V4yzYFlCJAcnM=;
  b=G4djiRf7wxVUlGOH2tiWsae1dopu3nyDTibsSf+uaTT6kYUA2/uJG/gS
   qxtQ28ep6KJvf5ku+ocn/Laklb06QXhRPkAhrFB4ayDcA6ka8MeWFTg3I
   494Hxadt9WUFJERyl7r1jhjUG8WRkSwmJ8hBgteN5N2NAEA6gkRrrfIJt
   0XzsL20H+IVuaIXnTFcLItyBFUwm6QPZi+OY1IM+1WkePoPlR8jsWChr2
   Z3JiNWRZggWW7b4Bc/k+/3XocyzNyu+p0AKom0g+dQAM4juCXVnw2I9v9
   qy8xQhNpIt4P70/WQnXkK5Lr56F4a6Hzz2NKuERPhupNemncocE01hTQQ
   g==;
X-CSE-ConnectionGUID: yLpdXLVbSCKb0t4VjYUguA==
X-CSE-MsgGUID: 2e+vii3PTr2LdNx3Tmj2vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102126653"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102126653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:45:48 -0700
X-CSE-ConnectionGUID: 3RvYXp8FS4evPNhqiAfSYA==
X-CSE-MsgGUID: x7m8EW9JRiazKjhjlWmVwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274704128"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.111.124]) ([10.125.111.124])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:45:47 -0700
Message-ID: <850294df0f51d6ccb131557af74d4a42dde00b3a.camel@linux.intel.com>
Subject: Re: FAILED: patch "[PATCH] sched/cache: Skip kernel threads for
 cache aware scheduling" failed to apply to 7.2-stable tree
From: Tim Chen <tim.c.chen@linux.intel.com>
To: gregkh@linuxfoundation.org, yu.c.chen@intel.com, mingo@kernel.org, 
	peterz@infradead.org, stable@kernel.org
Cc: stable@vger.kernel.org
Date: Tue, 29 Sep 2026 15:45:46 -0700
In-Reply-To: <2026092935-angelic-kick-1d0a@gregkh>
References: <2026092935-angelic-kick-1d0a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-29 at 13:43 +0200, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 7.2-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-7.2.y
> git checkout FETCH_HEAD
> git cherry-pick -x 65efcccddc83d6a19e8a2e2a6117811e39e589bf
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092935-=
angelic-kick-1d0a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
>=20
> Possible dependencies:
>=20

These patches in upstream needs to be applied first before this patch:
f0d243a96f268 sched/fair: Avoid creating misfits during cache-aware balanci=
ng (should be included in stable)
28f9c0e0a0b94 sched/cache: Decouple sched_cache_group from mm to fix UAF  (=
just merged in stable)
b636fef85bda7 sched/cache: Introduce task_struct->sched_cache_grp to fix UA=
F (should be included in stable)

Thanks.

Tim

>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 65efcccddc83d6a19e8a2e2a6117811e39e589bf Mon Sep 17 00:00:00 2001
> From: Chen Yu <yu.c.chen@intel.com>
> Date: Mon, 21 Sep 2026 17:37:26 -0700
> Subject: [PATCH] sched/cache: Skip kernel threads for cache aware schedul=
ing
>  to rubustify the code
>=20
> Kernel thread should not be covered by cache aware scheduling as
> it borrows the statistics from the user space thread. Filter the
> kernel thread in account_mm_sched().
>=20
> In theory a kernel thread does not have any valid
> cache group, so !grp should gate the kernel thread.
> Add the PF_KTHREAD check explicitly here for safety
> reasons, to guard against future modifications and
> to pair with task_tick_cache().
>=20
> Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-awa=
re load balancing")
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: <stable@kernel.org> # 7.2.x
> Link: https://patch.msgid.link/058f0c6ea7b991c177a17de347fa3157f25489a7.1=
790035273.git.tim.c.chen@linux.intel.com
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 974a7dfe3215..57360f5cdde4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1907,8 +1907,14 @@ void account_mm_sched(struct rq *rq, struct task_s=
truct *p, s64 delta_exec)
>  	/*
>  	 * init_task, kthreads and user thread created
>  	 * by user_mode_thread() don't have a cache group.
> +	 * In theory a kernel thread does not have any valid
> +	 * cache group, because sched_cache_fork() is not
> +	 * invoked for a kernel thread - !grp should gate the
> +	 * kernel thread. Use the PF_KTHREAD check explicitly
> +	 * here for safety reasons, to guard against future
> +	 * modifications and to pair with task_tick_cache().
>  	 */
> -	if (!grp || !grp->pcpu_sched)
> +	if (p->flags & PF_KTHREAD || !grp || !grp->pcpu_sched)
>  		return;
> =20
>  	pcpu_sched =3D per_cpu_ptr(grp->pcpu_sched, cpu_of(rq));
