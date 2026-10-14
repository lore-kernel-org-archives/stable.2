Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85A5452B3;
	Wed, 14 Oct 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988079; cv=none; b=cmMmN0gehtQS/WDA/ZD96c662ELTcP8SKY6ooZul+9GRND/7HUvJKaxLY1+m50NASb4HG+FOXHSaWQW+U5/GJ9QTcxkNIRhgnECSBFIQ8igS/1GxwWG/zrKDAHd7PcnBqJXi97nkJTUu8ouiw4I7+S3LOPFcEsUhoJFXDkEEyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988079; c=relaxed/simple;
	bh=RK/pJrl/hTl09VCFa/qgbYMGeOmIkXyJF3BCc1FkFcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJBadrXf5X0pobIxOKP+0CP/7GpS2FYixxF7um8uDkotKC0QWKn/B+97jC/bnJegLf2iU3f52DbprkCtXS7EmtOgRKrvSHAjZATtV+G4G0M7QsXz9GPGOKIvtCEimWHX8XY0xtx52s4778Krtk9HNGvQdAaBtb3v/60TTlfiASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irkxCvfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irkxCvfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243E1F000C4;
	Wed, 14 Oct 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988077;
	bh=B7pyNGqh+SbryYMg1hFxXJ7uKTFQB5hqKmPbvQYFBI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=irkxCvfv758WtQRJ32C5x1JbWXyNYhw7VbuSHpcl1SUKwxBkHo0P397A0qRVKTeuY
	 ZV/FqHvVKaMLDd5QldjCd9LDR0L1Q7zNUIOpZ/GZusd40FfF9pXzWw4DWCsHMNpBi+
	 PktjkFavSuiIXozvi03UdHaK/9FLKZvaXa0H2OVtx1IyFXDkQ6SpEa81j11FChqwor
	 dgU+kc4C3tXvx5Dub62EhZxDECeMYtSBclNfKdbiah2bAMusDnPIVoIdiQrzFgzGt7
	 e6W/mPCN2nW/Hc0A7JGengE2JkQwFn4VBXNRMylRymriRFeaA753WmVhzRB7FX3/af
	 hSZFxgobc045Q==
Date: Wed, 14 Oct 2026 08:27:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: martin.nvme.dev@gmail.com
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v2] nvme: make the DH-HMAC-CHAP secret attributes
 readable by root only
Message-ID: <as-PhyF3rsVXcNdi@kbusch-mbp>
References: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>

On Wed, Oct 14, 2026 at 08:02:57AM -0400, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.nvme.dev@gmail.com>
> 
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
> macro takes the show and store functions from the attribute name, so
> rename them. Writing the attributes was already limited to root and is
> not changed.

Thanks, applied to nvme-6.4.
