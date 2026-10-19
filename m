Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423324;
	b=FUaWxLw8qhWukozgW+TjBIhb/qI1SWOF1qbtEhPwVWWphlYhuuDHPRhoz0p1Eo96165n
	 p/wbRcRugQP6qAUSpt+ipgMEL72XUUPgeP2u8SwGAJVXxR4IMB2oQhSdVhCoxhbVWP6fZ
	 APVF+YS2bmXl67f92H9JgjrxRMKEhQDbirgj8moOTZTRCBt9Ak/3wjkN06OzWR/AmZd9k
	 s5DL2fyg9qkodSsJWeiryE5AgJGMJH0GLkxT0UngV+g4nKgZ5qCg4Q0eL6bY1pDJV/RQN
	 U7RMVlDHi8Pa3+iuLp18vCw9ngyOeKc2GZc5qpgIEXtM2mJIiOk2rlE+H0oV6G81GyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423324;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CVvYJSMvSsGSkRMqKLY6ZTXC9wxv6gDsXZTKWE4b2wY=;
	b=hhFdJGEC1lyUxqtbkiT+W2x9+rz/KMG/zEu45nR54jL5R0wosq4GDVy/5ziGmDbMiD/n
	 iBLY9FW1sZltb1aSU2WqGiSO0iUgMi1OKCG5rzsYNqcCDtWepsxf9S1jU9R9tPLU3PcFz
	 qDtaQSUBhiesfuPqcqT5PorEnKmFkRkw9brWNmKxeNX8PE9q0IoO4BpvAAMNviJTeRP1X
	 DiHXel0s1mT6hmg+Eae1OoBFZP5pk4R9MxjkxgaFWS+nXQze8w20PuMHwo+1078rMcsa2
	 cxKpDfexYFLpGCcetdF8AoFns3vORT2ExYg1E9Apxua/5uyD0JMW90PlC+iO8KxplPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXQnxIKj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4360AA0D2;
	Mon, 19 Oct 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXQnxIKj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B711F000C4;
	Mon, 19 Oct 2026 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423323;
	bh=CVvYJSMvSsGSkRMqKLY6ZTXC9wxv6gDsXZTKWE4b2wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aXQnxIKj/cFcl+YiA6cPj3DsRfhN18y2LRzbr1rXACFZbsCqkXaOOWb19/95wtg6S
	 3TCafnZjUSWxY0kXmL41WRQIe5yoWyrOHtzMBNisy7jXKXg/dq5dPMRA2uZzg/X5kL
	 9YVJMqG/Qtd7tIlF+SYuGZysdyO52wAjcw7veEszKrUcyH9kzIYthdiMK2hb3nXnYq
	 zywLHxjyS0SWb6t0z2Ea9A4m1cL3+j9tDlHSjeZzaKBH9/j3ii+55uPuJPlIYvgarY
	 RtbYnjDYPB+kSJm76hHjzIwD4djdp+5fcMkHEJonu7iXNuqNfSWzd28A2aAXRPu/Zh
	 qdaSZ//+6YncQ==
Date: Mon, 19 Oct 2026 15:22:00 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/6] watchdog: w83627hf_wdt: Fix watchdog identity
 truncation
Message-ID: <atY1mMlBN1L93rbi@google.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-1-b6f6b60a9566@bootlin.com>
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
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-1-b6f6b60a9566@bootlin.com>

On Tue, Oct 13, 2026 at 03:58:45PM +0200, Paul Louvel wrote:
> The identity field in struct watchdog_info is only 32 bytes in size, but
> the identity could be at most 33 bytes in this driver, resulting in
> truncation.
> Remove the "Watchdog" suffix, as this is implied that the device is a
> watchdog if a user request his identity.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 3d6757a640f8 ("watchdog: w83627hf_wdt: Report the probed chip name via WDIOC_GETSUPPORT")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@intel.com/

The patch doesn't really fix anything.  The longest string in `chip_name`
with the " Watchdog" suffix is still under 32 bytes.
