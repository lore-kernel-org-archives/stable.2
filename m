Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEB33D505;
	Mon, 21 Sep 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978678; cv=none; b=gHTmDGffuRyPAvNSKTqWgndq1nmUwBB2/mGgNg3+81q+0lBwiRhejdVlI+BmG7e8cQiNL3wanHaobDoLsOO5yft6APYyksYPt705T6W3eyIi9mmtkYUDfsW5fdilMJJFtiYYqZ13NRWFyYdZAbmPZ7ViVc+6U++clE8pYQPOhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978678; c=relaxed/simple;
	bh=wqdCyfKeWuYNxI9NvUWBUNkBQ6XWJ0LPvgeGeHTleoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuLoZ8XObSOmLFajeMzEo/eud06ndIj8Q+JCt6ZW5SeGCg4FuzJnQC5uZwom9C7X7O8PmpJzKOb00YoX85S4s6NDvV9m7OAtoXHJnR1U3VhsGHeHmjVM5T/XEC28AzWOYnzyAXHNIzEbJFVpdX7DVr30Lzn83Xqgpy3U/vdul5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PV/FN0hW; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PV/FN0hW"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8c1e34b;
	Mon, 21 Sep 2026 16:17:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Mon, 21 Sep 2026 16:17:45 +0800
Message-Id: <20260921081745.15699-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910052604.GC27133@lst.de>
References: <20260902103202.GB8095@lst.de> <20260910045400.1201582-1-runyu.xiao@seu.edu.cn> <20260910045400.1201582-3-runyu.xiao@seu.edu.cn> <20260910052604.GC27133@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c30af3ec03a1kunmb8b1aebe3d318
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEgYVhpJGktCHRlOHR5MGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=PV/FN0hW4FW2J7DTkvV9ZgFGikAqjvTtZI2sJ8BIF+4N87hw4bjV43BzqNv2UcyMfxULXVHmOwAT68yisU7P5VNCEExJolno1FEaEbdghIoRbK60Nyna6NXfjMoa9yjfo0mfdQH7/g79yMH3AhdNVwikZi0lqM7ejzQJEzLqekY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Ny61zYs0caS3gVIz8LAYFEjQRdujeI4Q9bB1iCT9rvw=;
	h=date:mime-version:subject:message-id:from;

On Wed, Sep 2, 2026 at 12:32:02PM +0200, Christoph Hellwig wrote:
> This section of code really should have a helper in configfs.  And should
> also be used in other callers like the SCSI target patches you also sent
> out.

On Thu, Sep 10, 2026 at 07:26:04AM +0200, Christoph Hellwig wrote:
> +	ns->file = file_open_root(&path, "", flags, 0);
>
> Can we please still have this in the helper?

Thanks, understood. I will move the path lookup, configfs filesystem
check, and file_open_root() call into the common configfs helper, and
update both nvmet callers to use it.

I will also keep the target-core caller on the resolved-root path so the
db_root TOCTOU fix is preserved, rather than reopening db_root from its
mutable pathname.

I will send v4 in this thread.

Thanks,
Runyu
