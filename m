Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62C3D5C0C;
	Tue, 15 Sep 2026 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446791; cv=none; b=ZQUlxGYxn5wtSgyLzRgZDLA1ntEkOkrxetBqYTV0Q2ZEfoKhhmVein9dXr2sECtZ9XhWStZ9aONdMpma5OBh4bKRFH//ZchTT+9aQcnu/yELbJ00A5ij7wDcVUmuaj+vMWa9EYFvSvCy960Bm87bkiR+q7KZvDlnJVvSIOFxQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446791; c=relaxed/simple;
	bh=F1EZz1gvYL2yeAGTnSSdkFhbs1XU9gNCm7qgfr7UKiI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WQSemXgWsb5krcqLNhU0y5YsWa4j/IRrqRENXto9Uxq44fq+yuq22MGdLejR2qWXVV+KUSQM28z2BriTr0+jq3vBetnXhojUUsuwSttqjTrbsBuQTiKJKgcyJI2dVRhdoqZUZ7+ApMaHVc8TZP1R7FcTADE0BAbmOY90WCb4DLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h07fm6tJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h07fm6tJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775951F000FF;
	Tue, 15 Sep 2026 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789446789;
	bh=AA0z69BlegLX4MyUvkz8G6syjEXB6PXFlXmYSSb0GhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h07fm6tJXrCqhq4PwvmHRpvDl+sUxOxl6I6ZrPCJWuiBiA643R48Jp1WiUlccMvs3
	 Auo/ZmAHF7j4dAzffmHVyj+cPG3dFspg4gpG+Z8UbvFqkmLp6l89vphOxgr8BysQN7
	 kLXyiir1xpVduYvt/uRV1xcgR6LSjMq8a0k9RQkQ=
Date: Mon, 14 Sep 2026 21:33:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Kim <james010kim@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine
 <alex.bou9@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: mport_cdev: fix use-after-free in
 mport_mm_close()
Message-Id: <20260914213309.4caf81cbb1794b774e1ad7b6@linux-foundation.org>
In-Reply-To: <20260914042327.49798-1-james010kim@gmail.com>
References: <20260914042327.49798-1-james010kim@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 13:23:27 +0900 James Kim <james010kim@gmail.com> wrote:

> A use-after-free vulnerability was identified in mport_mm_close() in
> drivers/rapidio/devices/rio_mport_cdev.c, identical to the pattern
> previously addressed in dma_req_free().
> 
> This is observable from userspace when an application creates an mmap
> mapping via the RapidIO character device and subsequently unmaps it
> (or terminates, triggering exit_mmap()). During munmap, mport_mm_close()
> is invoked and drops the mapping reference via kref_put().
> 
> If kref_put() drops the last reference, mport_release_mapping() is called,
> which frees the underlying rio_mport_mapping structure. The subsequent
> mutex_unlock() then dereferences map->md to unlock buf_mutex, leading to
> a use-after-free:
> 
>    mport_mm_close()
>      -> mutex_lock(&map->md->buf_mutex);
>      ...
>      -> kref_put(&map->ref, mport_release_mapping); /* map is freed */
>      -> mutex_unlock(&map->md->buf_mutex);          /* UAF: map used */
> 
> Fix this by caching map->md before kref_put() and using the cached
> pointer for mutex unlocking, ensuring that freed memory is not accessed.
> 

Thanks.

> Note for Andrew:
> Following up on the Sashiko review results you shared in the dma_req_free()
> thread (https://sashiko.dev/#/patchset/20260615070530.371640-1-james010kim@gmail.com),
> I audited the reported pre-existing flaws and verified that this UAF in
> mport_mm_close() is a genuine bug with the identical locking pattern.
> 

Thanks again.

Sashiko blew another fuse over the rapidio driver:

	https://sashiko.dev/#/patchset/20260914042327.49798-1-james010kim@gmail.com


