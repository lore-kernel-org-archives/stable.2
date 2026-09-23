Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7757309EE2;
	Wed, 23 Sep 2026 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131181; cv=none; b=TIO8XYZzBdcxBAxRovf/8DlPI0aQYHsFKSIYkLMjWzNyDThDP5rgnl/KuMkkld6v7i+Rv/0igirMv8L4au/miMsrMiMAcjOwJRd+TZWxdzNl/dPEg1IuL1FENfx8PcdUbod3mzFQc4yEAD3lVhcVP4Oc/FySF4C/YWzyr2BtpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131181; c=relaxed/simple;
	bh=RFSSKBGexI9N0SBDFZEj51ee1rSETVvs9ntWuxfZ5DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNyokn18UyQwGPD1+0WVuP+r/5+xqLFi17r6xWT8jCOF51q5LZtlqbDSbIPafVMixzLzelyygIlsL72z08nP2RR2kkWBoFPuHPnyaMVbIXa+vosu2yadpxfQaQbAuO5kx/YKLaqNfF9zMIyp8jlpugt3qMngVgZjgSuC2MuMXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Uos8wgfW; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Uos8wgfW"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ecd1d1b9;
	Wed, 23 Sep 2026 10:39:29 +0800 (GMT+08:00)
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
Subject: Re: [PATCH v4 1/3] fs: configfs: add helpers for opening non-configfs paths
Date: Wed, 23 Sep 2026 10:39:23 +0800
Message-Id: <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922132903.GA31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn> <20260922132903.GA31642@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc21e9fb03a1kunm6371805db4002
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE9CVkhJT01CTxofTU9OGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Uos8wgfWuvg97hGTXQCimpeDGL/KxfneoDrqQgzr79MbLXoTX6xxbEolj66AVIcvQQYC1fciY+/eyLfjWaya06i/eLR8by5hihZKBF3c2DvX8w5+Rc+p25g6Sp/dJXdhd/oINhxC/K7oQLtkVB4znv8WiRlgFEL4NVQmkTuBE3I=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=QhgHqZwIqPh5M6LZoA1GVbbob+NtuP/+uxfc51TgGmQ=;
	h=date:mime-version:subject:message-id:from;

Thanks for the reviews.

> > +bool configfs_path_is_configfs(const struct path *path)
> > +{
> > +	return path->dentry->d_sb->s_type == &configfs_fs_type;
> > +}
> > +EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
> > +
> > +struct file *configfs_open_root(const struct path *root, const char *name,
> > +			int flags, umode_t mode)
> > +{
> > +	if (configfs_path_is_configfs(root))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return file_open_root(root, name, flags, mode);
> > +}
> > +EXPORT_SYMBOL_GPL(configfs_open_root);
>
> These two aren't used outside this file, so they could be static,
> or in case of configfs_path_is_configfs even be folded into the
> only caller.  Or do you plan to have other users?

I folded the filesystem-type check into configfs_open_root() and dropped
the predicate entirely.  configfs_file_open() is for callers that have a
pathname, while configfs_open_root() is for callers that keep a resolved
root and open files below it.

> > +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
>
> Can you add a kerneldoc comment explaining how/why this should be used?

I will add kerneldoc comments for both helpers in v5.

> Didn't you also have patches for drivers/target/ that should use
> the new helper?

Yes.  The target-core patch titled "scsi: target: pin db_root for metadata
writes" is another consumer of configfs_open_root().  I will rebase that
patch on this series and drop its duplicate configfs changes.

The separate patch titled "scsi: target: file: avoid recursive configfs open
in fd_init_prot()" will use configfs_file_open(), not configfs_open_root().

I will send v5 as a new thread.  Patches 2/3 and 3/3 are unchanged and
retain your Reviewed-by.

Thanks,
Runyu
