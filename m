Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2939A7E5;
	Tue,  1 Sep 2026 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225717; cv=none; b=YQockZrnNFvgrvbgwsZonu+0L32nKcYJ2jXOnvzDgvs4QYTwcn7DFdzI4z4DV18TaRWciLlKsYTrW8j5nVlX5Cn0Rgc3f9VC/y1fb4NCQoHkwnGALAyIMnPpuXbEBzU1ixFV5a+OgIG6U7TO21givke3Xy3cCu7MaZ4ONBxMvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225717; c=relaxed/simple;
	bh=++J7cXlEmUpRE8piZkq+UntvdlAo7H21rgdE18DPugU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmSw6G4W7GrmF/7cpBj0dxKBEXJ/crBCIpn1nXjF2cNYaJQXTL8OEfYOXV0QKxyvn6mo/3r9WF599G9taylHCRiQkyzShaR6r8bEcN+bGSu8qwqV3sl5b6Nr/Hp1bmfJSfZCiNzqMMJvpmr0uvuELFhWHZTcmbBluC32+0i/Ffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/0FdoO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/0FdoO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD21F000E9;
	Tue,  1 Sep 2026 01:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225715;
	bh=CvJNWacLfzkz7xlM5/HVuXznG9juQQyZz0vxPso6JtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/0FdoO50NEALYzDX7ddDBxBxeQOKr1838kMhSbm6dG/g4tETeLAeH5KAhJSacrgR
	 GSqIc70C0b2pXqlw8M54r4hhpWAfrt0LjQ4i5tKzPAtHDk3AYCb032DhZNm3TwpON6
	 apUSLg5gYiw21w0yomJDJkz6m0lZjZmMGyGceMWMSTp2SpIlH97zDjntg3jCKg6LNu
	 r5VCfjsvPiwpKI0BiI1fBbRk3qol+DQIUhW93NARFVLIfcU14zY91RUsSDLZ94WKuO
	 +Ic0kMJuWch8NV5xAA7Eldtn3+FQ6OWPWCl+LT5+Ps54uRxm0/sXJ2oZlNcPbhAHFo
	 cOHZKnhyAmcUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] Revert "USB: serial: keyspan_pda: fix information leak"
Date: Mon, 31 Aug 2026 21:21:45 -0400
Message-ID: <20260831-daily-reply-0001-keyspan-pda-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830145321.100701-1-pchelkin@ispras.ru>
References: <20260830145321.100701-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit cccef1711efbcdbe999738ac27d37b9ef6271abd which is
> commit 6bfc8d01ac4068eced509f8fc74d0cd205e4dcec upstream.
>
> The 5.10 backport is incorrect - instead of keyspan_pda_write_start() it
> touches the wrong function keyspan_pda_write() which now returns an
> incorrect number of buffered bytes.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
