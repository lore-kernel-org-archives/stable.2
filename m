Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780C48D874
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725034; cv=none; b=JukxxJSKZRPtY1TbFrFvZXAjmsDyYoMkgnwyRKI2P/K+jb/VbyGAy4xyTMQgPLm0erLvakH0CLFfUop9by65+QkdJXcOm/iWQBfFYhs7bA8yZTj5XvsJ+W0tJrGojBIPrcfJlVpIeDDfu7a0NfJ7hAJr0sj5Tnohaugc5cDZtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725034; c=relaxed/simple;
	bh=plq1q1+zH6vn+DCuYIadjLq51CI54UcXONxzKupXTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCtp+5TXdOQYvU/VnyDIXi0DY+8zmotznukfhcdyffPlWx9LTqg/EMtPMwCO61SKIsK4VC/gFmDoy4H8JbX6Oj0PevN7P8JXOUGero9f5+ZeeL0smdRRcAk7ONqfkEow8S6dLwJTufAIm4ywiahJUoDAWMDIlgMDHCMSzCPzL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz8afG91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz8afG91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B641F000E9;
	Fri, 14 Aug 2026 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725029;
	bh=zTSHfVFlIyP3No+ych9sX+3eIDYanupXU3o8EYU/LXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qz8afG91whF46nNqqZ0GCYYrIk3FdWwm73kEL+I7nLt5Xntd78ymTvQQeyrSDNOLR
	 fVRaBf+p+wHT+zfoT2+Cir8iQOvL+0w+28QKmpBQZypqCZRTxDwMK42zlQV1v0hbA1
	 b+XLt2YPH3+nmDGaxA6/ZJ72t5kVwsQrIsCI/aavMCihzle6LkJ+6adrNhOyHb67l/
	 3v3Zt5KEa223rcCjDDDHXoz0wIl7QbJx2gtL2BJexsMzM4OQTq5VFhO1FDG7/TSpYV
	 C4WvkKDh5sdizYBuknJUk0DOVgrF+xzrWpYdmGLDKj2rDFvlldnzs/HoB2tFH6AB+P
	 lNXVoZjOwf+bA==
Date: Fri, 14 Aug 2026 10:30:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <an9Co6vHIqggWNIf@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>

On Fri, Aug 14, 2026 at 04:38:34PM +0200, Niklas Cassel wrote:
> ctrl->ctrl.opts also stays valid for the whole teardown now.  That is
> not the bug being fixed, but it removes some fragility around the old
> idiom: nvme_free_ctrl() calls nvme_auth_free() before ->free_ctrl(), and
> ctrl_max_dhchaps() dereferences ctrl->opts without a NULL check when
> ctrl->dhchap_ctxs is set, which nvme-fc permits since NVMF_ALLOWED_OPTS
> allows the dhchap options.  The nvme sysfs attributes that dereference
> ctrl->opts, such as hostnqn and address, evaluate their is_visible()
> test once at device_add() time and stay readable until
> cdev_device_del().

The allocation that ctrl.opts points is freed in this error path, so any
access after that is a use-after-free that needs to be fixed. I think
setting opts to NULL is easier than the proxy locked list check.
