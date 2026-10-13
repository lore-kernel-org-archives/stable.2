Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5551AFC4;
	Tue, 13 Oct 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906013; cv=none; b=Ik6FSABkB4gKJzDZ7P0ePgGS5gKnxe/K67bz/xyMDTzgqxjSMdhbFxXNiEgf3AxPdsW4Ndo3OFmZ2g0wBk94N9BccRzukDgEzY5ihjlT3oDPRQ9MhW2jk3r8unfqOVcTX1HOmAO3OAjd4v/kl2C454t6H8dv/Zh8/GRDOZ1HCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906013; c=relaxed/simple;
	bh=Kc+g4AYNYaHlUUMpIFwwvMooz+DPHDMnyJyMXL1S6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeANAf3a+cVU9Eb2DErPCA/kXdKVDJk29KL8IjlEuBXy9oDPYMW/TNmf3S+v9/Pge9vFOmdPFIRT0/X+Remq7lCH+SlUvhBUm8TiOFawOb9ecnq7ZKcBhtiSZxIILXcgG2mj3yvzLWPmlfPJclQ3hOLej2DeYCVQgat3SRYy83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SABT8bwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SABT8bwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB471F0089E;
	Tue, 13 Oct 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906012;
	bh=UgznpuaGHIjf/1wAtS+z9UAIAApoFcgHOqVgQ1r4wfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SABT8bwuM0GGX/xLV1aYqca17/tmwLq/mJJlAKIfVhLQLSxnNK1gEtBNLd83MXtpJ
	 2/9VYQIQUdguIygxVTJvlsW34DacLsndpQM2MHI6WJSyyfFC+gEIsie7VMbjAclBcn
	 JR4wX9tovHRzEijrrVm/SX3gOdfsb8uYRQFb46w9AN2eK4WgJX4MrgUZ5LCcJ+Ynm6
	 BXmtHb7FsWeCZ1qWwHGp3xclr2328NuiRJQtJDa9nXbk25B4kzl1Iw6NnGXqe1fnxj
	 djFXz3HRHyPDrrHYnxIb0YiTTiqED6/X+nLen3wm10EDQkkJrXwptkIGHGy21ChToc
	 VG1OTsqNnjWGw==
Date: Tue, 13 Oct 2026 09:40:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: fail when the controller does not
 authenticate itself
Message-ID: <as5Q2k-aQokHA-ar@kbusch-mbp>
References: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>

On Tue, Oct 06, 2026 at 10:48:05PM +0900, Yehyeong Lee wrote:
> nvme_auth_process_dhchap_success1() returns success as soon as the
> controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
> without looking at whether the host had asked the controller to
> authenticate.  A host configured with a controller secret sends a
> challenge in its reply, computes the expected controller response, and
> sets chap->bi_directional; if the controller then answers with
> rvalid = 0 the response is never compared, the host still sends
> success2, and the queue is marked as authenticated.
> 
> A malicious or man-in-the-middle controller therefore only has to clear
> one flag to turn the configured bidirectional authentication into a
> one-way one, without holding any secret of its own.  The target side
> already treats the mirror image of this as fatal: when the host supplied
> a challenge but no controller key is configured, nvmet_auth_success1()
> fails the authentication rather than answering with rvalid = 0.
> 
> Refuse the connection if the controller returns no response although
> bidirectional authentication was requested.  chap->bi_directional is the
> right condition rather than ctrl->ctrl_key, because secure concatenation
> sends a challenge only to derive the PSK and deliberately clears
> bi_directional; a one-way setup without a controller secret keeps
> returning success as before.

Thanks, applied to nvme-7.4.
