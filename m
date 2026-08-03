Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A742046B;
	Mon,  3 Aug 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777628; cv=none; b=URz8ezOvq1t6yG697/yLWXU38xeVoN/hYf4ZMXMWvlOF+I1zBkUlFXWA6gf3UNxYi4MWUZAnUAUdmcJEsx2yr/CFHiRGMkZj4cwAR2XObKA+TdoI/JYlz0/l14mEQ8+4x4VyMoQL5XJU7xX+b5HJmNnGfsQ6C6QanKhMi2C/7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777628; c=relaxed/simple;
	bh=QmvMno9gIK9I6rykjqIsSJJvbm7UPn9LGNwtXjjM/NM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gcQc4lL9ep0TgbdT9BB1Qa2N9I/NfbVbo1VZqPHhnHJkFGyZpgpYb85O8WlFnXIMvW+lWZMDpilNQpO2Ev8yra9S2Q34thEZ8ozWMsAOQ9CiYPOEGDV+8Ut7Bj3ToBDlnRhAo167XHsWozo6iQnM7IBcXB+PaghWF/23TwYTNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLH5x5zB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLH5x5zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E2D1F000E9;
	Mon,  3 Aug 2026 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777627;
	bh=ZYhDR2llqPHVUqlj8rY66dvBfc+QMCYJWpvukxmLE7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=KLH5x5zBxI5Hvzdeak4tO9f+jChyPW1nGHXWAizAJCrdUjYA7WVEujvnxUzzA4Hks
	 xPATvR1s28+OrycwGXIB5FNpHfREWiHvr5Mhk+ITYMoIvCk19mwVOPg7bkzlwma4vl
	 2/+ElIzWT261f4Ile9W0wdsWwlBkQ1PJVMom8/I1NJ7EaaIGnOLEy6hxpXlZmUAEhY
	 uu/MuzXE4N4a0W9C3+lkhTEtV1/PowGOfNFXcvKiZOAInnou14bkWdUjmzFRC4f0tS
	 BvN9/4o5Sw2z6JNXKp6uW1J5cdwVCbBzZ7EOwy3BXX8PZflaN9FZqzIcpZ7hpQMV11
	 ywAgSxCsp8yUQ==
Date: Mon, 3 Aug 2026 19:20:24 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
cc: djogorchock@gmail.com, bentiss@kernel.org, linux-kernel@vger.kernel.org, 
    linux-input@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: nintendo: stop device IO before hid_hw_stop on
 probe failure
In-Reply-To: <20260730031927.25444-1-yijiangshan@kylinos.cn>
Message-ID: <4npr6sq8-np7o-7o3n-2n8q-93no9or6p584@xreary.bet>
References: <20260730031927.25444-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Jul 2026, Jiangshan Yi wrote:

> nintendo_hid_probe() calls hid_device_io_start() before joycon_init()
> and joycon_leds_create().  If either fails, the error path jumps to
> err_close which calls hid_hw_close()/hid_hw_stop() without first calling
> hid_device_io_stop().
> 
> hid_hw_stop() does not stop device IO, so hid_input_report() may still
> run and access driver data that is being torn down, resulting in a
> use-after-free.
> 
> Add an err_io_stop label that calls hid_device_io_stop() before
> hid_hw_close(), and point the two post-io_start error paths at it.
> 
> Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>   Changes in v2:
>   - Resend as a standalone patch.  v1 was accidentally sent twice,
>     once as [PATCH 3/6] (part of an unrelated series) and once as
>     [PATCH], which confused the Sashiko bot into attempting to apply
>     both copies simultaneously.  No code changes.
> 
>   v1: https://lore.kernel.org/all/20260728061132.299461-1-yijiangshan@kylinos.cn/
> 
>  drivers/hid/hid-nintendo.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

