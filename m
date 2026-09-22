Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C847DD42;
	Tue, 22 Sep 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076972; cv=none; b=Wk+omWODQQGb16i7VmdFWuBqsbu3X3lmV1M6m8WvE4xlqemfyLFnYiWcpT9AP2P2OJhvvBGD5jLtoNsXiXGo2nrw9txli9fX/1LGvAwijPhBT0upHPuMMnccaC1gb33Vxz8lEJ5bL4qtjqHHDmg6F/P7YUOAtktC51KoetMNx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076972; c=relaxed/simple;
	bh=EjaZvIYZH36hkw1Fupqd0+eqFmicqMv4mf3X7fVQ3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeIR0LBzifI2EYR0fxMsCBWVu3BXg3REIubrdQ/ye+yg6dm0tKQXBJHM5NzFazYIUSDBCqjLJqoKAt7clFNp6JEVsy/UJXsDfWykM1CRWS0lIqC/DBsqiOTNy80IYgBodKN5xqcgkzX9c8vPYDq2Flw9SAZOk2dD13ejmKMJTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XBGmAP7/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XBGmAP7/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TDaIUlTPFR1/obqbJ/+5NOCgSFSUgteEaC2g9fZ6c+s=; b=XBGmAP7/mY+orbd0XJM8GHFJdY
	XGypJlBRLfSgcn3dnspoW7GrhquX7sCMjQ1Fw42ZivmoriqLh8t3iSp2Wb6G8fz4IT6IKhsEoNbPr
	3tCEZqNwJGXHMvoo988MnPHTS9dfMUn7JW2sM6+yTQRTNMkd5lNSo06t0dKc7GSELqfG1AeE6BoBW
	DyM4xex+AoGfo/DAslXe5jdFdWegz58vGLU6SGuTb+1zpzivhyQeJ6/D3L8fJ5UesXmeEr/3S9doK
	B3QQ7fS4Z4kUFoJhQegTXCZZZWJfUDXLicBCP/KHEl6wpxg6NQb5KrzavpOLDtmnDf6zX2UZ2qrX6
	DBryrP5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8yn0-002x4v-09;
	Tue, 22 Sep 2026 11:35:58 +0000
Date: Tue, 22 Sep 2026 04:35:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com, 
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, 
	weirongguang@kylinos.cn, u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ngbe: propagate resume errors to the PM
 core
Message-ID: <arJoC8T9R527DlKy@gmail.com>
References: <20260922100836.1147718-1-zhangyunfei1@kylinos.cn>
 <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922100836.1147718-2-zhangyunfei1@kylinos.cn>
X-Debian-User: leitao

On Tue, Sep 22, 2026 at 06:08:35PM +0800, Zhang Yunfei wrote:
> ngbe_resume() declares err as u32 and unconditionally returns 0, so
> failures of wx_init_interrupt_scheme() or ngbe_open() are silently
> swallowed, and the return value of ngbe_reset_hw() is ignored
> entirely. The device stays in netif_device_detach() state with a
> broken interrupt scheme, the PM core is told the resume succeeded,
> and the netdev never appears in the networking stack again: the
> reset task also bails out early on the missing
> netif_device_present() check, so the device cannot self-heal.
> 
> Fix the type to int and propagate the errors instead, making the
> whole tail of the resume path consistent with the
> pci_enable_device_mem() failure path at the top, which already
> propagates its error. If the hardware reset fails, the remaining
> resume steps cannot succeed, so return early instead of continuing
> with a broken device. A failed resume is then reported to the PM
> core, which records and logs the failure, instead of being silently
> swallowed.
> 
> Fixes: 6963e463256e ("net: ngbe: add Wake on Lan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Breno Leitao <leitao@debian.org>
