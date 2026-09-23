Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED894772B1;
	Wed, 23 Sep 2026 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157060; cv=none; b=aUlor+Xmr9bEVsfl/lQgMjcOlqvXH7E9YJ55ahw2z7TrNIRlbtGbqzfMSnwTu9K2hLVUhA1yVj3ORk3U/SN4Wc8w+TMooPkok89gHR8hl60OHa07Ku3Qo4wAA1bhGFdaXiOfWGEscjC+j/NBEGA76ZXe/IzogY0mFxYGOatfvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157060; c=relaxed/simple;
	bh=eO50WRokU0Le8oYc0F/j8XCIY++hEjeajxmtEwWIC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGQ3PT+Afl//RO0o3CDFsleJrLJQF9u5/DxkhNehG06MX5a7XaWjraN6qT9hgtT483EP8t4JmNRQEQjKQ5SWIeuFyD23xrJWc9G5CjKQTokbHfnzwTIzB0dn2J6inMDkyMiF1wD6/CmoGR9Tj4lt1oOlOr9UbhlYxra3MXk7AIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=maWW8MzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="maWW8MzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2D51F00898;
	Wed, 23 Sep 2026 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790157059;
	bh=bWg9QZ1/koufOP7KjTyCgw94I6q9Yx73f4LS8gkbkck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=maWW8MzRegmpto5f89SoDg+b3hTt++rEr1qWsz5OwNlf//gF1jDA9flaW+IXGqJZq
	 BwLDaDOd9fDBW/kNyFCKu1N7gds5URgwb1fdAz+NjQ/jlY4gORc41dZVmuwTWYl8u0
	 3a1Y5/wU0FyxnW4X96hcYaD24d+jkmjaZEOTgHLQ=
Date: Wed, 23 Sep 2026 11:50:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: jirislaby@kernel.org, broonie@kernel.org, zhao.xicheng@vivo.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] tty: serial: max3100: shut down timer before freeing
 port
Message-ID: <2026092346-sizzling-dallying-a3c1@gregkh>
References: <2026080353-bats-jailhouse-804f@gregkh>
 <20260805004039.382698-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805004039.382698-1-fanwu01@zju.edu.cn>

On Wed, Aug 05, 2026 at 12:40:39AM +0000, Fan Wu wrote:
> max3100_shutdown() stops the polling timer but returns early during
> system suspend. If the SPI device is unbound before resume, the serial
> core does not call max3100_shutdown() again, so max3100_remove() frees
> the port while the timer remains armed. max3100_timeout() may then
> access the freed port and re-arm the timer.
> 
> Add final timer teardown to max3100_remove() and use
> timer_shutdown_sync() to prevent a racing callback from re-arming it.
> Also free the IRQ and destroy the workqueue there before freeing the
> port. Keep timer_delete_sync() in max3100_shutdown() so that a
> subsequent open() can re-arm the timer.
> 
> The workqueue is created before request_irq() and destroyed on both
> request_irq() failure and normal shutdown. Its presence at remove thus
> identifies the IRQ left registered when suspend bypasses shutdown.
> 
> This issue was found by an in-house static analysis tool.

There are still issues:
	https://sashiko.dev/#/patchset/20260805004039.382698-1-fanwu01@zju.edu.cn

