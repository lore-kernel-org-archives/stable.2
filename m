Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202063;
	b=fTfmsHzv65/76nRdAp8pSp0wXsS71reO0SfYbfkvEVhZPMLdZCRZLDwlStmF4nXoRFuT
	 HOCePY40QfzNczUU4H3f6iV++psYQQSOjLqc6z0MvFJ3tYTSoHMqW+7UfrfqvlwwjW4xX
	 DsmFp2oItyT/pt2Ip8nnS3mDCnx+/HKFky1IPoKepaMAmmNFog+QFxie7WRjkid8Gq+6e
	 cuAwX4LLDeOuLS1rp8SVboH+lBSmCrZTE5NHuQvtqUw8e62/VxKeGj7pTwNz8hOYxVIMY
	 xIJs8iV8Z4R/NxSDGDA6UhrOXDC3Yyo3A79z5z0VyvIZY4aUmuyjdbkVIClD9lozOGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202063;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m7g1ib8E/0JVseSD1L6xPryKDxZDRg0LxTuFEcloAFU=;
	b=RCu2jeI4N9UHRUupIRJuB1hJMOhYQApaU8h+uKENmTuTFp1oW6fwQqVOceKq4iB3MJwx
	 WEtObG47yAR3QNYUncmCD2BtCLOZSBbIytIZH103QG5JpDJhybj/WHEeMPAEbQMP6WGgN
	 7Dpw/rtN70cBKPKZoDhm/6FBd9muq1ghXn3EsLg0Mg8DrlmaoHawEyCo3gGYcO/r81Rcd
	 rRC0mCSDBLIflXfs6Tj8r5WDPGzQT7SAwbTmilQGh3G+JnrPlX9Chk/ebW6mBccZt6PEN
	 fYXV1Vuxk+QfScfIV6ZXZ+TzxZA9MYvWCh1B+mDgkCipdGR2eIqlxTe3tE3VRff8+Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csmUhEkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E7606A323;
	Wed, 28 Oct 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csmUhEkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086FF1F01825;
	Wed, 28 Oct 2026 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202063;
	bh=m7g1ib8E/0JVseSD1L6xPryKDxZDRg0LxTuFEcloAFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csmUhEkJnOdNn/F3SJNE/vQF/2r05kOdPKLukpIjUL+uJqKSlacid2wqXK2EgQRgW
	 umGY4mJiPafLEOZigxHGyrEiso9zHLQAf5sO36M1jyFtFpYkiAYkldS/ROtVZD4yY9
	 pDUBvAO0BjRHZ2cB/5YmAZJAvFXWVURd8KUK6Y/Nm6rLo3LnKqggzcQeKl6feB6kXD
	 s05RTvv7HpmJflR4Ty5pcgIichklw1V86Y03dMH3R0EdJrWr9PWfAHL2sig2qvPp7t
	 aXbo7gEdx3SZO83Y4QHtAkL9mF5244qxDScJMOjiCG4Xc26aJBhOkQfa67Inu9WBcU
	 vVVxBQXaKbCKw==
Date: Wed, 28 Oct 2026 15:40:59 +0000
From: Simon Horman <horms@kernel.org>
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfc: pn533: add timeout to USB frame send
 completion wait
Message-ID: <20261028154059.GZ257209@horms.kernel.org>
References: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
 <20261027070136.1339-3-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027070136.1339-3-zhaofeng2@cmss.chinamobile.com>

On Tue, Oct 27, 2026 at 03:01:35PM +0800, Zhao Feng wrote:
> pn533_usb_send_frame() waits unboundedly for the out URB to complete.
> A device that never completes the transfer makes the task sleep
> forever in TASK_UNINTERRUPTIBLE while holding the command mutex, as
> reported by syzbot (hung task in pn533_usb_send_frame).
> 
> Use a 1 second timeout instead.  On timeout, kill the URB and return
> -ETIMEDOUT so the command in progress fails gracefully instead of
> hanging the task.
> 
> The transfer may complete between the timeout expiring and
> usb_kill_urb(); in that case urb->status is 0 after the kill and the
> send proceeds normally instead of reporting a spurious failure,
> mirroring what usb_start_wait_urb() does.
> 
> Fixes: 9dab880d675b ("nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()")
> Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=1c5368988052dc2d8201
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2: check urb->status after killing the URB on timeout and carry on if
>     the transfer completed in the race window; add Fixes tag and Cc
>     stable; the pn533_wq_cmd() error handling fix is now patch 1/2.
>     Issues reported by the Sashiko AI review.

Reviewed-by: Simon Horman <horms@kernel.org>

