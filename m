Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C036212C;
	Fri, 11 Sep 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138988; cv=none; b=obsrCfmJedrBvcreIwNAoa2nhib5N1YaoUvmvz/Fdbu8nhbq1oeP+Y8g+K/OfUAouAxcaLz+XwhLtwfiZS7pzJ5xYCxUcOla3QzAE41GoUkJ2CUQNSYukOGJX4HflbOQ7wrInBqkIJa8JCHPg5hEM3IUPFAf5jFg9KcbvIvPb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138988; c=relaxed/simple;
	bh=T9fvsRnommmEv40Ny88ZihFmD7htCm6BZ1gR8iyNfWc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wrr8hYuEd3DRMgAh3Umo0YVKYcPWdyJQEHqnbY+Mi6uAP9QQdg9fGh1duVUVUUosywb25fO6qQF/AT4gYNCp+SMfdeAd322Q69zv5F/5N3rBbctkjVeQvgD9NoLVMj4QBgarzGYh6KPeZHRFv7xi43fZixDTCl8WwcXW/jw7eig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFT7s6dE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFT7s6dE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484D31F000FF;
	Fri, 11 Sep 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138986;
	bh=6Z5sI2tMP2r1wyjFSRn9tBULjseiSpfAaPBZIS6hV14=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SFT7s6dEZwTwiahH1LMJSuQiwDi5useSKHDG+W/uZCSp7dZKaOE6Y5cOt5oDQ+8T1
	 HNNqn2Mcm5khwsCvT4FC2hoc24WfFSacigHH9ZL1FdFZdgUH4rbLXZ6VPnHV7hSlww
	 29zDP278cC82czgU+ygKXFCM+BW4Z/BAeRVi4sM6cqgmSFovc4x+HSGF/ty0wliVLA
	 qQJnfeTQX4+2Iy4Iy3MXJJmzaJCGIPo/iJZRhG6a441c3Rfoy3TBMkpCwug7xOFz4Z
	 FFLqczJrZHs1nNrUFuOZlm1945KWuVV91IxSfi+fVGE9u/Sywe78VebBlkOM94kdga
	 eFFXDfyswsEkw==
Date: Fri, 11 Sep 2026 17:03:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, 
    syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hiddev: keep state alive through disconnect
 unlock
In-Reply-To: <20260629152947.13821-1-alhouseenyousef@gmail.com>
Message-ID: <r5s40r6n-o5o2-p8n0-8n36-0n66r1521121@xreary.bet>
References: <20260629152947.13821-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jun 2026, Yousef Alhouseen wrote:

> mutex_unlock() clears the mutex owner before taking its wait lock. A
> thread spinning in the final hiddev file release can acquire
> existancelock after hiddev_disconnect() clears the owner, then free
> hiddev before the disconnecting thread reaches the mutex wait lock. This
> causes a use-after-free in the mutex slow unlock path.
> 
> Give the connection and each open file an explicit reference. Drop each
> reference only after its existancelock critical section has completed,
> so neither unlock path can free the mutex while the other is still using
> it.
> 
> Fixes: 079034073faf ("HID: hiddev cleanup -- handle all error conditions properly")
> Reported-by: syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=563191a4939ddbfe73d4
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v2:
> - Explain the mutex owner-clear/spinning-contender race in the commit log.
> - No code changes.

Sorry for the long delay on this.

Thanks for fixing it, now applied.

-- 
Jiri Kosina
SUSE Labs

