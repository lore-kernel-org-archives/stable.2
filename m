Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9B3C09FE;
	Tue, 22 Sep 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083749; cv=none; b=UKaQJougzoKsmVBJK8L9g2rsGJQbDlFa7I1zll7oh3RWu2cQiJkaCLHNW+cWvXhKKJlPQXYBAKDUVHZ8hr4kx9duKrEW6XSd4HWYlRMW3KXzOBmukRjsjrDV4y1o4FWTTsxEs0iMiB/Rt9NnZvrVAHUzybFz0VbIVR6RvgKIq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083749; c=relaxed/simple;
	bh=Kuzbvln/07omGf6mQrm0BZdeG3oboHQDa9u0GO1Zpf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKbkfEeHiQLreiSPP8hF/Z53Qo5stNzlwAEPs6DGNLO9qQVaYj+xHD4CHKASTVbUr7j6Q0TKgr6gF7js1K2ELkBNn7D72l7egHqZc/xMcOK7aexJO4MMPpvDlWGHCjkV1/tX8Ten0CS75V64IkZ+iD7p5L2ZVHopdftMuessbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 301FD68BFE; Tue, 22 Sep 2026 15:29:03 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:29:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 1/3] fs: configfs: add helpers for opening
 non-configfs paths
Message-ID: <20260922132903.GA31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921090559.41364-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 21, 2026 at 05:05:57PM +0800, Runyu Xiao wrote:
> +bool configfs_path_is_configfs(const struct path *path)
> +{
> +	return path->dentry->d_sb->s_type == &configfs_fs_type;
> +}
> +EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
> +
> +struct file *configfs_open_root(const struct path *root, const char *name,
> +				int flags, umode_t mode)
> +{
> +	if (configfs_path_is_configfs(root))
> +		return ERR_PTR(-EINVAL);
> +
> +	return file_open_root(root, name, flags, mode);
> +}
> +EXPORT_SYMBOL_GPL(configfs_open_root);

These two aren't used outside this file, so they could be static,
or in case of configfs_path_is_configfs even be folded into the
only caller.  Or do you plan to have other users?

> +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)

Can you add a kerneldoc comment explaining how/why this should be used?

