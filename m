Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B52423775;
	Mon,  6 Jul 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339153; cv=none; b=to/vNP8JytXEVvzfl/nauMSVaBnl50qHjsG2XOo6xRLoXoHtQC9YZdaE5FnaYtqcA4tAD1ma05bL9kVHKEKV15ToODY8vHHPmq1TAG5yYXpXuu4GqSEtBBoFLT89g65lQbilewMn9andlcH25Wrx0WSBqQXM9aA/m2W4BLxAvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339153; c=relaxed/simple;
	bh=22BQjg59yPQ9X33+2WoEH2fuliWTpQi0ZI9u/EH7dms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcQb1vJ1iy1ZRJBN3+PtaqL9nRil83Lh7vkGHHjeYAKLVNODHfUSXuY1r1GvCUQNKTfpHxYJoQ95P1op43BD/IL5dj3eRr4Q7eIY69K9w2HtMPbBlPgOSe8NZ1PT+M6zENuzppGDFz50mmxnQ4uJXHPmKau9IW4JKv3bypGR2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW3zrByz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW3zrByz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4D01F00A3A;
	Mon,  6 Jul 2026 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783339151;
	bh=Az/VgJcFvYiP8TdLtb8ksrteWF7yotiWeUj4OfyFmD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CW3zrByz/HCZzh2GRQmn/pn97TbNJNtRJ4+iueIbQbpUbJk7oBKSj9i5gDCHw6nUa
	 rGeYyigeQYbhLXUeyYYMHcC1NwbElTgvBnXWxjxdcuDhvX05rYEj3sUX5F3kpSOxug
	 MISCCTZj2YOskJFANM3xFRy15qtig4qn1UreLD9t0iQ3KeNPMAJxvLF0Z0V+aVDcrO
	 1sSQbKtwtY3W22GmeVI4Tx3broy35Eui/whybVEGSAJOAqIqEF0NfiMBAD1l+c8Vd7
	 T5H8KKwx5xj41C+CnYX2hRR4EZ4hGEkApO7AZyS2GLpN6gZ1ecqMiGWkR7uHfLiH4v
	 pyHHr2Z37Y6VQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wghyf-00000001qe4-1udI;
	Mon, 06 Jul 2026 13:59:09 +0200
Date: Mon, 6 Jul 2026 13:59:09 +0200
From: Johan Hovold <johan@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: drivers/usb/serial: garmin_write_bulk: urb freed
 prematurely on success path
Message-ID: <akuYjeD1g_SXJ4gA@hovoldconsulting.com>
References: <20260627033748.58960-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627033748.58960-1-vulab@iscas.ac.cn>

On Sat, Jun 27, 2026 at 11:37:48AM +0800, WenTao Liang wrote:
> In garmin_write_bulk(), usb_free_urb(urb) is called unconditionally after
> URB submission, even on the success path. When the URB completes later,
> the completion callback may perform additional operations on the
> already-freed URB structure, causing use-after-free or double free.
> 
> Move usb_free_urb(urb) to the error path only, allowing the completion
> callback to properly manage the URB lifecycle on success.

No, this patch is also broken. USB core holds a reference to the URB
until the completion has been called.

> Cc: stable@vger.kernel.org
> Fixes: c4ac4496e835 ("USB: serial: garmin_gps: fix memory leak on failed URB submit")

This commit has nothing to do with this.

> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Johan
