Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239644;
	b=VLCxcRTGa3HUOJXNdTMzpgpYbqA+DWHVlWJW8IGrqDlodG+jVC0tOKfHyCknLvKC0OqA
	 f12N/mxOqdi0MD6pFeuHWDdOVQ66t/f1wQHTt64GuYrv9KZ54mo0A7tzJTzj6UsQ1zmdX
	 AFiipmpSPT5rQHVOpA6gVDBLl2iCz8woS0SYwqyS740AeJN9ij4wE4t1WpOwYdoTKORBt
	 l/1jEQ5oQfoQCt1bEJJJxZyGnB9tccAdXNeXmgn1Hkeem9wpdcM3uVg/LVXhGuXccEZ4v
	 c2P9dSfMHQ1849STLhg4TKjb3S6ebqmLEqXvG+G5pECoutnpyT+aQj05VzcfQzzE+Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cSqwI1NNWDem7D30yuhvyJ/bVXuGiHGYHODQsO9GSn0=;
	b=eqoDq41VBhjgVXRtHOYmQFumFpPsW61dXoKFC3wKwGpe+q1iWWZ1rLes1va4EgB+8CX3
	 ygkZdw++zXsFVnKyIkyj8pdRroyJkraYvfwK0R/R6UDyJ7bXZHdHo/eQLtgWwdrDJhUv8
	 Hukp+LvdeppOp7ZBRfGrDpAqtvZt4kWkDus/t3oTllZQdZUJnMC3RvFbo0YGIpm+CIIHi
	 GkoREd7NekJaM/4Vn+GtKc4aqBlreJAqk+4ialoaahq19QUyUkRuyWaCDEUJeho0YkljA
	 Tlvw64z0XFGjTnGpwX4QPQ4mhWKC8CWAcFxlQsteGIuk2NsKQDmOm45UiAcVQLOldUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMvMNgOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E68606EEA9;
	Mon,  9 Nov 2026 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMvMNgOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4D1F008A4;
	Mon,  9 Nov 2026 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239643;
	bh=cSqwI1NNWDem7D30yuhvyJ/bVXuGiHGYHODQsO9GSn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMvMNgOZOtObYqeNQiWIyzsERrBLodB1wvy2doAkth9yz5Bf0LB1SLtiDMH8Az/YP
	 avhUCzDSdP4nYk/kCyXgRAiUOycDyFJBTcp3OM6TSB4BiUQsTOcdqx7IaG2h4LHsG9
	 UBo8ySywHII+z+kwaHm5PbD7CGxKFfNlP04DNO0PuF5aPlj7xXnkmn8XSvpkTlzfdz
	 bEQHKqr0EClTV8D9eIUFl8+SZjy79ATQUsP/xUQInitM2zHFUX4k+XPV55o19okgk7
	 OdGynpB8f25TkaAzJ/ayOvRgVXxctGt/EPlTe8reghIV0oDZpOciRS1ZBOdVySVuis
	 kgeE5oqp9p8Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH 7.3.y] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Mon,  9 Nov 2026 10:53:18 -0500
Message-ID: <2026-11-09-1-daily-reply-0036-damon-sz-range-7.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109005724.87550-1-sj@kernel.org>
References: <20261109005724.87550-1-sj@kernel.org>
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

> mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
