Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D04854ED;
	Mon,  5 Oct 2026 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206652; cv=none; b=SlVtT8ltD3bH+/9vDg6spzXvSnHqkksp2QDSdi5VERKpqSChkTJ210iynS3F6dUae0BZ23M1Y/hV7vnzuE/Gg9RnqYkltFYzzp03HsLkihrFCO1/3whCHNVbCAqCN1Il3Msr7SpSRRrACIh9JrQy0C4yp73Z74vpwakRAjztSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206652; c=relaxed/simple;
	bh=A+4D2pYQnfQBNEnlY28Bqy8nfojKzjtXM6s/gD/AH4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPrRLxS/JZzSJbfYBu/QB7Xeoo5itnAbBLNudOUV3OBfiqYlOJWoHHC0cIzbbtTz7WdrPPWU4lRD1wvFOlvoqEIBqFs5Qcp/G5hSLwA5yGCtxRMFACMD2iPno78NSo0+nRIrdEXSVhfDPp7if6VDLMljBGykJ5oxfof/NeQC+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BCEwkBCV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BCEwkBCV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A+4D2pYQnfQBNEnlY28Bqy8nfojKzjtXM6s/gD/AH4s=;
	t=1791206623; x=1792416223; b=BCEwkBCVhlPKpOVdtBDGEsHmBcgecutjg1nB2TKhYbqfBBA
	7BtvLQdPAlfyX75WvzH9iXwDwBG4kK6Gt3h1cnY8yTgYc7O8NK0buuuil3XTQZ4yXxiCBwI0yuA8G
	RLbDYxyOCzt6y26BvxZkx+FkmhHu15zaX3CdA8ReO/JY0YuSnDP9iSruwhra6AZnTNntrpDbh+UlE
	tQouxM9hZ92v9qCAk/DAx2g0b5CMpiaYwqAroW9RRdASG5ZYf5cKMFz/WsXXN10UjQ2MGNzMqxyWM
	XTKIbUx3EjZxfJyVUmr/sBqYRf/8I2dWxyrps88xY4uplmxxoY8A+Wqvr/Clo5Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xDif4-00000005L8L-2qL9;
	Mon, 05 Oct 2026 15:23:22 +0200
Message-ID: <00a4a6b9aec9329b5d5901c5ce72e2cd3203f2d4.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlegacy: serialize watchdog updates with device
 teardown
From: Johannes Berg <johannes@sipsolutions.net>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Date: Mon, 05 Oct 2026 15:23:21 +0200
In-Reply-To: <20261004114519.1233305-1-runyu.xiao@seu.edu.cn>
References: <20261004114519.1233305-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2026-10-04 at 19:45 +0800, Runyu Xiao wrote:
> The writable wd_timeout debugfs file changes il->cfg->wd_timeout, but the
> iwl3945 configuration is shared and const. The handler also rearms the
> watchdog without taking il->mutex. The down paths hold this mutex, delete
> the timer, and then free the TX queues, so an unlocked debugfs write can
> rearm the timer after deletion. The callback can then access the queues
> after they have been freed.
>=20
> Store wd_timeout in per-device state. Serialize the debugfs update with
> the down paths and only arm the watchdog while TX queues exist. Use
> READ_ONCE() and WRITE_ONCE() for accesses that do not hold il->mutex.
>=20

That's a stupid commit log, I can see what you changed.

johannes
