Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918426;
	b=pnm0r4XjlfUrec7rP/T10NZMwgeFCzte7tKep2c/QrQOf56/ratKoL77eBLAmX7H7G0p
	 XG3WjSPkO8+xfGt/Zd3vhnCzrVHzlz1+hkJtiX3YkmSaeBWKWrUT/cKsTOsvMp6dmcx5J
	 ym/Y7w8FuswX37pUcvh5m6TCaeLROfc9rPgxDbKwYtlQFkFyXYWUGaymIlBtpbnWgmGd1
	 whT4vFoWzRIQkJzYlNoNvJoBMTV5/YsJDXv4B821uqQthXwgceCzxBZs6rHxGh8QKatWC
	 /mYDYaDfrXpD6NG8z9S/S5mUuid7jLpU6whMroXcYxvVARFuB7otdL6dbl1n3TQLf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UXtE+j/cqcFyda/TqGBQWXHPqYIyz06WBkp/r9gDWMQ=;
	b=NaQagIeVTh7xAQetK5fw17t6DAT/6kjeCiNDpxAXS8jhwcAvS8bOJxS/ar8Z6Swe2lCv
	 jw1fI1+xbmwAqFI2EEH7sHsoKmXQE1L6rKiqkWkoYrS/qVfZhmjQ+6vMkTqg/dVB6eRBG
	 YzAs+XbBZ6eaA8JhOepikih8/Cg499XYlh2UjoV00gCBYHzCtim69Zzsc9kFKlLQwHj5U
	 bHzVLOjxVxSm9Kp4SIKZ5HgCpUqIa8zZdtnxqU5lK+GYF5Q28H93euX0GMbYkAhaI75KS
	 Gp+0Im77eAnvE4Rs0pTP82B1gLxOhZExig4VxwqnLcc488c4/i3FsgX7ZxzJsPS7/Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=WdsK6ZAQ;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3915606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 22:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3915606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=WdsK6ZAQ
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36f6295304dso18226eec.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 14:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793918425; x=1794523225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXtE+j/cqcFyda/TqGBQWXHPqYIyz06WBkp/r9gDWMQ=;
        b=WdsK6ZAQI72EOCMYCYaXRSMKwuGuxqbLxfLR1dRJuKcVkeKCeJf9a3fdRINIKra6BM
         TwnrBSX6pDDF0nK6ZFsaT2KjbT9jRQeMlwptUPIGgVGW/SyftUmoH6wBvym51nGWfaRU
         vW6ecCU8IrQKAWJHprqrTaYTLdvWuGfO9GOXAG56OCjZ6sSO85HXV6bKjRdTB9CuCeGQ
         p1BSIw3f3dVcRxdkmIZgfVb91pjuXsWPyLvBtb5rsXWFVI/vju2AFJFTIpnMi8dXEt5q
         ymGtUvIgJ63WFzFgJAXFW+PklozGO0UYW+n2ZTLZHFcsv3IsjgLnurBwHfaStrO8ug4S
         Ni4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918425; x=1794523225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXtE+j/cqcFyda/TqGBQWXHPqYIyz06WBkp/r9gDWMQ=;
        b=kitmw0pVfRmQCcqA50j9WkRyfFKw6WFN9AsazZh6ZUUWIMKX4fo5mU/fz+O7z+cEke
         CRCitxmFtZVXN7jj8VxfonKprxSyNWs/fFz0a8Z1sE/+36z4ZRO8ZRSGpl+ULUHCPdp6
         KSca/u0D8kcc1r1J9Rj/9+YOJ1V6fNV2EvZqiEFntBHMG/NlAPVjD96/v5oHL8EMWiVt
         Q+/0ncbdaUEAkEJ6Q+JKuCupafbmb8yRIwkLp3XY8ceDBr3SFrYuewTqCGFRUalu1G9I
         cosnmApxYXnLC5AAJRrW6rB19fINZlzwkYuZyRc9HpD+LJTKCjL2HLH1Lp4lsnRpvOe3
         y/6A==
X-Forwarded-Encrypted: i=1; AKwUvBwDNMZCai8Su9SIsc7V70TjPfhg5xUwXitI/ZvMjiFoNyzI24epMxLowknvMOw+FaRbMC8hyXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ix1WzuASJUEIpJvZICFtVi4bynsfreFhq9hk4DubJ6YukA6Cq
	iSg41LmA00csqR6kUTOjHDY2zGhri2g6W0b72CsDNhL+dd1b3aZOfb+z+7Iig56z7w==
X-Gm-Gg: AYBFou1jsDPsZwVISj01dGvHRKcAqiaAvZy/fUrYs/UT6+fpIwSXenm29FGUWTp3AMf
	an7ftoZi5Lg9xLpiKfxcL6VN9Babcd2LwiD7lJM08YTJ5nxAwoP2u6ZTftNeDgKLJDM4bgc1Mxc
	/mZ33YNSudXTwH9vbXyZoeQPx+1x+HDBvWC+mbAZ/Z4ihXepxMjGgY0Wz/VKAL/THHGqYgEbtrc
	7v0Luyx/Xp2qtQauLc4UQt0ERd1tWVFQ5tMJOabWxUWRB/GqwOndYeMY7wvVnbr3Q55aupmJ0HL
	y52e+dswatuchSUQhfmcgm4BGn1jCQIifBukyPw+6oSPKmIHDPM69tdwcWUhjkAhTk9CYDal37I
	WzO8yqr0sWuF9KqXmy6pBF9QV1e59dHOvbsoBNi73TPrDRfSjaG7kv6xHm29v4ZcIcalZZPezMJ
	nJXcePRz07kfEec7qDSJPmvFAtAAxrUqelqdXWBV32IjbHsxmFaZVpBwr/C5prtdf8BasJhkmgw
	XiiwSSglupaYyzuf9wxqEL68Y4SL8qVfVAn/NYZ2R0HUHluRI1zofhpxutRs/yfD5SOLFd05n4r
	LtDD5/5/FNsa0tJM2z32lRy1qwPVXIQ7B8XTDvNGVDQ+yuc+mHV0v4Zo9g==
X-Received: by 2002:a05:693c:41d6:10b0:36a:1008:5815 with SMTP id 5a478bee46e88-36f729d054amr794897eec.5.1793918424869;
        Thu, 05 Nov 2026 14:40:24 -0800 (PST)
Received: from localhost.localdomain ([206.206.222.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651c57asm251536eec.2.2026.11.05.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:40:24 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com,
	mason@kernel.org,
	josef@toxicpanda.com,
	fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+dc9291cf132691aeb478@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: overwrite a leftover balance item instead of BUG_ON()
Date: Thu,  5 Nov 2026 15:40:22 -0700
Message-ID: <20261105224022.254528-1-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4c59541a-3f19-4ad3-bef3-59b9c42c2e90@suse.com>
References: <20261105214738.111967-1-smish149@asu.edu> <20261105214738.111967-2-smish149@asu.edu> <4c59541a-3f19-4ad3-bef3-59b9c42c2e90@suse.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 08:39:01AM +1030, Qu Wenruo wrote:
> >
> > Both assumptions can be wrong:
> >
> > - insert_balance_item() inserts the item, then commits the transaction.
> >    btrfs_commit_transaction() can fail without aborting the
> >    transaction, for example when btrfs_start_dirty_block_groups() fails
> >    to allocate a path.
>
> I think no call site can handle a btrfs_commit_transaction() failure
> without transaction abort.
>
> This is a way bigger problem than what you're fixing.

Are you suggesting that the right fix is to make
btrfs_commit_transaction() abort the transaction when
btrfs_start_dirty_block_groups() fails?
