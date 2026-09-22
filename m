Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997655221DA;
	Tue, 22 Sep 2026 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074731; cv=none; b=u6kYk4wvhWLoxmSVxomsRLtGJHSsboeDJ5rSwUG9hEesOPAke0Uk2mTAERkKLj1YrMMNYiYg/qv0j4tKJyYlGoKeriAOK9ZBmYtUodNe+1ZHJIybWqMiGKNzNQEKsbNq3YiO47Tp4t/CJz/N8Ya9C4wQpYAXFkt3Au5anWPocLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074731; c=relaxed/simple;
	bh=fbAc7ebwCqxuH0VG1ksDAeVSDAb6yVypBrz5cAKdMRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myUgYLNrUcm3bWmzQItce7hFzWDJPZ0DpcYcGHESXW1CtAmycgV7z5D+TjlOEaC5KjHg2AKwl8JbSzIU/JNQQmk20Bl8QCyIjA5P8sFVmtv6zv6pkIaCsmhDRF67hyoyg/klblOJ+enqNaXzUrrNChghd3gyivR3TMaaw+2PblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=fNWUDqX8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="fNWUDqX8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QC6dGDqXkFixLgf757zeEyQ66heKcQh39eXEjVnWscw=; b=fNWUDqX8vriA1q8ith05IO5rqS
	D3MlLBl/jttxfHlkHKZycMHYCwtD8FoZtGqYuyHDICmM/msHYfoexppcdh23KTi3Y4j7jUtuvzhea
	n/AV62kIe6FYySLnORFFBdyKhO0phHdRmlve2y+BG3zRFKjOC/piXjLKrfd+Jt+Pusm20EVSd4b2q
	5AhfW+REXE6P1YUqDLMt9wvXUOOWNOlv5UiX1cxJlXGA5bc4CydjY28aS795B9b+vyrtGjq+hG4zR
	KPvbAkRhVxmDZ+DdHvSjSyqy9IP+XQ+kBYyvyHOR176SB0b/3mBWXJ9g68ZynlZGhiSSGDopSAG3l
	+/t7vypg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8yCt-002vqp-2w;
	Tue, 22 Sep 2026 10:58:40 +0000
Date: Tue, 22 Sep 2026 03:58:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
	weirongguang@kylinos.cn, u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: ngbe: clear DRV_LOAD bit when
 ngbe_open() fails
Message-ID: <arJev7h-_lEii1Z2@gmail.com>
References: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
 <20260922100836.1147718-3-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922100836.1147718-3-zhangyunfei1@kylinos.cn>
X-Debian-User: leitao

On Tue, Sep 22, 2026 at 06:08:36PM +0800, Zhang Yunfei wrote:
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit via
> wx_control_hw(wx, true) to tell the management firmware that the
> host driver has taken over the port (NCSI/OOB firmware stops using
> its management channel). Every error path of ngbe_open() returns
> without clearing it, leaving rings, IRQs and the PHY torn down
> while the firmware still believes the host owns the port, an
> inconsistent driver-firmware handshake state that persists until
> the next successful ifup.
> 
> Roll the bit back on all open error paths, matching ngbe_close()
> and ngbe_dev_shutdown(), which already clear it.

silly question, why unwind, rather than not taking hw control until the
port is actually up, as the last thing in ngbe_open()?

Looking at txgbe, it does something like:

	static int txgbe_open(struct net_device *netdev) {
	.....
		txgbe_up_complete(wx);

		return 0;
	}

Would ngbe_open() be able to follow a similar approach?

--breno
