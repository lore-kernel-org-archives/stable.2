Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A981FE471;
	Fri,  9 Oct 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565840; cv=none; b=L0b7X3WqBNptThW6SiH8MFg4boomM3AL+zuhlHcnM25bfxEANXElLWJTeEN76WIRl11cGEwS9KGPd67uK7GvzssLcLyqrFqlgEU8ZiivyZgn8+ncCKbCNSEP8Qjatd0mIKlBSUuwQKS47I204KWo2X9bJO2TJgo8EiaQEJgE4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565840; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDGmXy3tb32M1wK4fy0ma7b+oYPXRuG3m6tvMUEawfFgibSJ32HJuMjrlJV4yT5a+B/Ygc9+XIKBOsZXDm42/YvDNwNpprmUfvz7Wynj3dgatzuLZoQoGA0QwrosRh5iz/uWQMbScrvdrcQ7cMa33W7AYrzJfhNgaTh5nRAEyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNJmsG4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNJmsG4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3431F00893;
	Fri,  9 Oct 2026 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565839;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fNJmsG4zhF1In7gUjuHjtoK0y53A40lP41waKw8zUGqnvv15X1G9pdk5Lqech6gOb
	 yENDX+AjLLoSkDSU4BS0Ai0SxkRgfATOzRdD3r3tPsEJk2Iay3psi9yFFAGXc+AWS1
	 DFsJRk0BPOk34qC4wTly5FvQz0LcAo8n2bKwNo7xK4uS/VLou944qNzjR3e4HsEBSO
	 MI5o2jheNu3TG3rZ3M0WWGXTr8pWgNxTq50I++Ve562U7XLK7oWCLYemapQpHy+tNi
	 HK+A4l4d7tQo4Bcl/iqDPtnjREwKxdM/OBHgSctFsX9WIZACkNqTFllxlMRgrlOPdh
	 8GoxcrYGpOICg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Scardovi <scardracs@disroot.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	jay.xu@rock-chips.com
Subject: Re: [PATCH 6.6.y 0/2] gpio: backport CVE-2026-53226, CVE-2026-64241
Date: Fri,  9 Oct 2026 13:09:48 -0400
Message-ID: <2026-10-09-1-daily-reply-0011-gpio-rockchip-teardown-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008191824.98662-1-artem@trailofbits.com>
References: <20261008191824.98662-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
