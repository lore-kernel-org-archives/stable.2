Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63333955FB;
	Wed, 19 Aug 2026 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118418; cv=none; b=GFve6SRDNme+i+0/eVB4iXv2W4qu/DrsJyb856rGTPTqvquyRY2uMdZ/tTdtOpyiMYMHqpddc6gvmbp+kzhesuOI72xggh1pp00z53tIm2IT6BDcKYJLHRXwxnkw3ZsKVKQHFkazhtiN4gOmAiHxnKgjjL+zGCDR5uI1M+jn+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118418; c=relaxed/simple;
	bh=T5vBRDnVupH3XyAvhS/ZOxPjr1UrFUBeTb28Zmx9lzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2aK9okNN1EXPVucjnzxE99lKfSR9zAl5nUDXTN07cMWXAZLjuLA2Y662R9xwNnQFyKMl66N+nRmKX69LSwyaneqLw6DxajtGG62K0azRtdt2sPfWM3eVbQE0KkZR4hWEE+tsJp6xDfnGdOu5S9zfcJnaOfDfJM17ZKG61Kfkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D680268CFE; Wed, 19 Aug 2026 07:46:50 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:46:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH 1/2] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260819054650.GB32649@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260817143714.1344255-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817143714.1344255-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	ret = kern_path(ns->device_path, LOOKUP_FOLLOW, &path);
> +	if (ret) {
> +		pr_err("failed to open file %s: (%d)\n",
> +		       ns->device_path, ret);
> +		return ret;
> +	}
> +
> +	if (!strcmp(path.dentry->d_sb->s_type->name, "configfs")) {
> +		pr_err("configfs paths cannot back namespace %s\n",
> +		       ns->device_path);
> +		path_put(&path);
> +		return -EINVAL;
> +	}

String comparisons are a bit weird, checking the actual file_system_type
is a lot cheaper and more safe.  And please move this into a helper
in configfs as I bet there are tons of other users like this and they'd
benefit fro ma common helper.
