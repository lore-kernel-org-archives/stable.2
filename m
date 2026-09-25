Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF030D3FE;
	Fri, 25 Sep 2026 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318445; cv=none; b=bXjd4nddqiW3JZT/Lt8jZyCGCXPAt1mnwwjzpRJeG99LMnbvV/1RScQ4Ia1EDsyvor44Mt0qT76eGq/r9QqGtFiOnEDgMBN9dYr/G+i9BKhAn8ivfS6jX/BzOIlGdnWaxGMKeVTIRi4VfVeccuOEz3KgLZ86xTSpvwLOBLvTGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318445; c=relaxed/simple;
	bh=MVXaqP390HP2CbDIg/sMXdEuHh1BDRf9GarVNEeNbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIyp/g/ruuDLOzHlWW0GHVmuLjb7/HDQabD7mbC+h/LNnMIwRxUTr0pW7IdnZft+BxZE720kE6GDOx4WNk7lp4ZKyM8HYovHW3ndeylOOc0RlZdR2P76/XUnErZ4kQZDdNEDAKtC/5sGPHMUpY68w+DooL6VpeyvPYWdB7ruol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E45068BFE; Fri, 25 Sep 2026 08:40:39 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:40:38 +0200
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
Message-ID: <20260925064038.GA4025@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn> <20260922132903.GA31642@lst.de> <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 23, 2026 at 10:39:23AM +0800, Runyu Xiao wrote:
> > > +EXPORT_SYMBOL_GPL(configfs_open_root);
> >
> > These two aren't used outside this file, so they could be static,
> > or in case of configfs_path_is_configfs even be folded into the
> > only caller.  Or do you plan to have other users?
> 
> I folded the filesystem-type check into configfs_open_root() and dropped
> the predicate entirely.  configfs_file_open() is for callers that have a
> pathname, while configfs_open_root() is for callers that keep a resolved
> root and open files below it.

Which callers are those?  There are none in this series, so right now
this is just adding dead code.  If you have other callers, please send
everything in one series, as it needs to go together.

> 
> > > +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
> >
> > Can you add a kerneldoc comment explaining how/why this should be used?
> 
> I will add kerneldoc comments for both helpers in v5.

The versions added look like extremely verbose AI generated text.
Please use your own brains and your own voice to write a concise
description.

> 
> > Didn't you also have patches for drivers/target/ that should use
> > the new helper?
> 
> Yes.  The target-core patch titled "scsi: target: pin db_root for metadata
> writes" is another consumer of configfs_open_root().  I will rebase that
> patch on this series and drop its duplicate configfs changes.

Please merge everything into one series.

