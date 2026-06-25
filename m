Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3223E9C1B;
	Thu, 25 Jun 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404309; cv=none; b=YPwgfCZYh6P7Tt47fzAV2zETFeFU3TMPSYwC+hMIcuvEYpZQjdsD+6Qa/8Yt4aBW0SOnOnuxqoIB+SOJWrfTw7A9rFj8HyhBABIXjIWeFeKEZZbhK/VgGcs5zybp5/ZZLd++YP6CUlWlBNvuXgFWqX8YS5XiQAN10qbqbSNwqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404309; c=relaxed/simple;
	bh=wEqQnucdYqXikC0tfDH75q4hToX9NFR5mDe+redajDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Awr06QrxjmHUXvmuY1mqhzN4WjGvdpz1IJiRjZEwBI9DRS+hh2UjgaEFNpXB9wNJriNZuZvBt0k1D5t5zzXFExO1niye/s/AW3CdYkKx7tONch1ADwTLweS57gisV9XQPRJvQT5gmkDvMAdDBdOXaOxFbTO3YqgPxYMxA/o/GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=YDEr/DB4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="YDEr/DB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782404293; x=1783009093; i=deller@gmx.de;
	bh=wEqQnucdYqXikC0tfDH75q4hToX9NFR5mDe+redajDU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YDEr/DB4bKjhYfk/mjVR+TL9SmWaYVRU98e/RKA6CMdCR7AZagwnZ/oR1MXZbxcn
	 DJRDHtFMgrQfuVu9Y4kLfxqsZCmFfQ/A97zEJcloA1zHq/Xh0x6Uq0QGvhzaBal1E
	 fQzJTq3cTmuB55mOcBL0OfSX6F5gzPnhMrF7zuLO5FdVD15E7qYj1Y+VqLNGpMoCq
	 Z8NVG+jcQfl1araLap37DTElHnetQZhwuGGngQk2Z8I4y3Lf1VbmFRu5Y6/5WJHUs
	 4tJpo+lzJQ2jMfE/YvNkxyOztGhPUctgNEx1XFBs1+rBfvL56neuLtCinE8UqvawP
	 82Ihq38Yg6RpOGIN3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1wkAl73wpx-00K9OX; Thu, 25
 Jun 2026 18:18:13 +0200
Message-ID: <79ba53b6-97d6-41dc-aeaf-69181262e8b5@gmx.de>
Date: Thu, 25 Jun 2026 18:18:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: fbcon: fix out-of-bounds read in err_out of
 fbcon_do_set_font()
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: syoshida@redhat.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 w15303746062@163.com, stable@vger.kernel.org
References: <20260625160306.438847-1-25181214217@stu.xidian.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260625160306.438847-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z5EmV5/CvzIIvYhlz8ba1UGYGRN7gmFeXZ4/8wMRNJes1x41pS0
 gqATlltZYt4NJjZLe111okZeZKC4I/3syn6ZNsDyqAX6F5L4/lfRt5xGAJyw77DKmLcJ/9l
 xLWuW5XXOg4JAhOPuZsQhS9gf42tfSATGmKD9B4jZzYgjHyqZteldmbiRY17i95zLozcYZf
 I3lYPH20bX+PPsMRSs7bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jRfPgT09SQ8=;moUaJNiVOX+7nM91aN8wIqIibfD
 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

On 6/25/26 18:03, Mingyu Wang wrote:
> When fbcon_do_set_font() fails (e.g., due to a memory allocation failure
> inside vc_resize() under heavy memory pressure), it jumps to the `err_ou=
t`
> label to roll back the console state. However, the current rollback logi=
c
> forgets to restore the `hi_font` state, leading to a severe state machin=
e
> corruption.
>=20
> Earlier in the function, `set_vc_hi_font()` might be called to change
> `vc->vc_hi_font_mask` and mutate the screen buffer. If `vc_resize()`
> subsequently fails, the `err_out` path restores `vc_font.charcount`
> but entirely skips rolling back the `vc_hi_font_mask` and the screen
> buffer.
>=20
> This mismatch leaves the terminal in a desynchronized state. Because
> `vc_hi_font_mask` remains set, the VT subsystem will still accept
> character indices greater than 255 from userspace and write them to the
> screen buffer. Subsequent rendering calls (e.g., `fbcon_putcs()`) will
> then use these inflated indices to access the reverted, 256-character
> font array, leading to a deterministic out-of-bounds read and potential
> kernel memory disclosure.
>=20
> Fix this by adding the missing rollback logic for the `hi_font` mask
> and screen buffer in the error path.
>=20
> Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resi=
ze() failed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

applied.

Thanks!
Helge
