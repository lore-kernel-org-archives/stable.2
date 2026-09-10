Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB771C84DC;
	Thu, 10 Sep 2026 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017968; cv=none; b=OxyCsULsqyM3nL87oUpBib6rmYwHFsvO7X/wHXhMPUBtoGgL3vlgvyPLIrNB9QlsI6O8j64cv2UkSfhiA4+YQH6kU7MeYijnLx2dFMMt974oQNrgr67hzYLq49V80DkEuVJMWFmb2X/wAvGbv8FroxAhCP5zENgmAv5mIpss4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017968; c=relaxed/simple;
	bh=/eTXD7N9R+MhHHG2jwNg1dr/qsGnHfoiKhNwzZ5msrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjyVKtvk56mDPMjA9GGgD1WkAi5AbKlf293b9n2S6e3XaNaaGpmWx6ESGAF3f0PMx5W4MBgBU402B8hUokq0gDTblrl3J5X6Gh0bJTkTzPJ7CMmPNEfN+JPUsboDBeAxBn9ZDyqfJBf07ogB/DEtWFs1uZ9j26e4GhllUmbfXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A70368BFE; Thu, 10 Sep 2026 07:26:04 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:26:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260910052604.GC27133@lst.de>
References: <20260902103202.GB8095@lst.de> <20260910045400.1201582-1-runyu.xiao@seu.edu.cn> <20260910045400.1201582-3-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910045400.1201582-3-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 10, 2026 at 12:53:59PM +0800, Runyu Xiao wrote:
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
> +	ns->file = file_open_root(&path, "", flags, 0);

Can we please still have this in the helper?

