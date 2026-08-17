Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCD368D55
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001844; cv=none; b=dozvg6RJGjP2sW68kYlHYTYE71nuNDssEz6p051n+7yR9KvSqGwhbnDXZ2v8tUz9ggXjW2sLrpd1hXxTaP59SA8IsJOEWq0kPT57yAug4Gc4mIDrvPaIqEFJwFXAhgQe88BfoI5tGuzN0ZOGurRVzFF4P/u3+AAAA2eKGIoARh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001844; c=relaxed/simple;
	bh=4wIatAuEuBA2poSHi4R2wlRFzM3pyYVAXgZXrt7AqI8=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=m7wU5HTE+k9xB8uUoJLKCGzEx0wf9Zn2GwBad9F4M7YWidSeCsFVAd57Ey6HfWy80UTg5wQAbhvCv8lxaeg1r4VGaGtmVdpZg7llF9QUAPyvMwlUO9/H5Dp71xDJs6mqcFhSIbrLUbwOpz6aV2D+Oy+McDmHAuNueXgiuL9rEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Ba3MknKo; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Ba3MknKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787001838;
	bh=TX3kmIJYkJOtgyYAatpBOmlkoLyD+JL6HL1aggbvw70=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=Ba3MknKoVmumjG3eeanIKM8M+tu3mSc5oLyQO5ntE3OahegQE9Nd/lHOOZLbHP+31
	 DNB6OpL0G+0KPq7CTgxy213Ylxg8svqdTqYZqGGMJn6kF51mMPgWiR0yBn377UY6oe
	 ZsFshiWHKU+9JYbUTB9uwDGgAdO7iWmkYzOC8w2I=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hP5Ry4Ctsz6vNG;
	Mon, 17 Aug 2026 21:23:58 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hP5Ry1FPmz4y6W;
	Mon, 17 Aug 2026 21:23:58 +0000 (UTC)
Date: Mon, 17 Aug 2026 22:24:00 +0100
From: Bradley Morgan <include@grrlz.net>
To: alifm@linux.ibm.com
CC: eric.auger@redhat.com, gregkh@linuxfoundation.org, jgg@nvidia.com,
 kevin.tian@intel.com, lixiao.yang@intel.com, mjrosato@linux.ibm.com,
 nicolinc@nvidia.com, sashal@kernel.org, stable@vger.kernel.org,
 yi.l.liu@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/5=5D_kernel/user=3A_Allow_user?=
 =?US-ASCII?Q?=5Fstruct=3A=3Alocked=5Fvm_to_be_usable_for_iommufd?=
In-Reply-To: <20260817201606.3194-2-alifm@linux.ibm.com>
Message-ID: <A8667FCC-75A1-461E-82A8-5318859E2ABA@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 August 2026 21:16:02 BST, Farhan Ali <alifm@linux.ibm.com> wrote:
>From: Jason Gunthorpe <jgg@nvidia.com>
>
>Following the pattern of io_uring, perf, skb, and bpf, iommfd will use
>user->locked_vm for accounting pinned pages. Ensure the value is included
>in the struct and export free_uid() as iommufd is modular.
>
>user->locked_vm is the good accounting to use for ulimit because it is
>per-user, and the security sandboxing of locked pages is not supposed to
>be per-process. Other places (vfio, vdpa and infiniband) have used
>mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but this
>is only per-process and inconsistent with the new FOLL_LONGTERM users in
>the kernel.
>
>Concurrent work is underway to try to put this in a cgroup, so everything
>can be consistent and the kernel can provide a FOLL_LONGTERM limit that
>actually provides security.
>
>Link: https://lore.kernel.org/r/7-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Bradley Morgan <include@grrlz.net> # kernel/

>Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>Tested-by: Yi Liu <yi.l.liu@intel.com>
>Tested-by: Lixiao Yang <lixiao.yang@intel.com>
>Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>(cherry picked from commit ce5a23c835aa0f0a931b5bcde1e7811f951b0146)
>Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>---
> include/linux/sched/user.h | 2 +-
> kernel/user.c              | 1 +
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
>index f054d0360a75..4cc52698e214 100644
>--- a/include/linux/sched/user.h
>+++ b/include/linux/sched/user.h
>@@ -25,7 +25,7 @@ struct user_struct {
> 
> #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
> 	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
>-	defined(CONFIG_VFIO_PCI_ZDEV_KVM)
>+	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD)
> 	atomic_long_t locked_vm;
> #endif
> #ifdef CONFIG_WATCH_QUEUE
>diff --git a/kernel/user.c b/kernel/user.c
>index e2cf8c22b539..d667debeafd6 100644
>--- a/kernel/user.c
>+++ b/kernel/user.c
>@@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
> 	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
> 		free_user(up, flags);
> }
>+EXPORT_SYMBOL_GPL(free_uid);
> 
> struct user_struct *alloc_uid(kuid_t uid)
> {
>


Thanks!
