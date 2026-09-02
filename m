Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C3450906;
	Wed,  2 Sep 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345129; cv=none; b=LY3V3sMsCHndEfsjXs0oMBW1wgldArpge0mKPJYjzjshDrHQxhB8rmvjGKi8nNQ1QZXzXQaVMDEfZQLMnYWwYyDtBZxRCxkv1Ikd9TYwS0HTthKwvKCpNogV6jlxrv/19nPCi8hV6+3mc7bbeO9f3L+D9Kmg6EgpiZ1eA1h8X20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345129; c=relaxed/simple;
	bh=LVxKK5sxMXR7dXWz9J1VD7fJKoyudIJc5Ziqxy89GVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBXAoFZ6EKUpefjMxRNlujxE1jlDGR0Z65ldJaxYPV2ZPc8RAMO1uFkUu+JOQIRGp4N4uAx/vWcl8KKzrT+cWrz+sFgjrKreqeVbYl7orMapRCwJLSCxz5V35Vgrx1UQ29vwdPjl9KEy+UiconlIa74KwH71AOeOQrx7reS47uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82B5368BEB; Wed,  2 Sep 2026 12:32:03 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:32:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260902103202.GB8095@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	ret = kern_path(ns->device_path, LOOKUP_FOLLOW, &path);
> +	if (ret) {
> +		pr_err("failed to open file %s: (%d)\n",
> +		       ns->device_path, ret);
> +		return ret;
> +	}
> +
> +	if (configfs_path_is_configfs(&path)) {
> +		pr_err("configfs paths cannot back namespace %s\n",
> +		       ns->device_path);
> +		path_put(&path);
> +		return -EINVAL;
> +	}
> +
> +	ns->file = dentry_open(&path, flags, current_cred());

This section of code really should have a helper in configfs.  And should
also be used in other callers like the SCSI target patches you also sent
out.

