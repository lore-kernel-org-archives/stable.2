Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793591114;
	b=JyGScXR3L3kbaXy0ZEvPNP2ns/iLmgSTm5n/ei0PvOoResxIJEtmxJ5PZyB4+dKYioAg
	 qFKbYyqYUOpL9XLGvzTOV6L4FgM1YPvK67QMklzprTkJTJqpmvld8dJwJx3q41tbca7wP
	 uxpOWx2eVypvZ4tQ/8G83xsUs54J3J73VuXP2JXLYmmxq3IxYz5KlDjx+9tG9mhgnSI+5
	 tJzphzzsO4N2iiS+j7MnnxNriUY8VTvSkb8qqWatUMzwX7jRmvG8x4BY/dm8tkjQdPL5o
	 TKYlyTrPGdHLxWTaV5uRSmgqh0UPClxCkv4yBdLxipHSl/57xfJbj/n6dt6N+jV3wcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591114;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2wa6GtDXj8hpo+k1EJW2/u0+icSgK15ObOpBbCvF5tw=;
	b=Z6Uh5j84Jf7mHKV2oiu1MWPfdtQ/XpWPt0HvUrbYDLSbt1hrGnKKQj2JeA4mWFljrcPk
	 mQ6fpk68wtFDYsCSL1TWuMyiq9hSnwJphA6eQ77chCxj19V2rA/Em4uXg7ZTU53uEuXqw
	 U0s62WzhAy6xyF0VcZ/lOOqem7Piw//vP0sdPGsjIyv6s4StYCSVEp626TXJNnioj82uq
	 H0PcTQIWmeZwNSYTOBmk18OufZYZPjmHBdej5hWOqm8DKloVNs8Xi8mLBrL89Om1z9oZZ
	 9b/1PF7yUJZsXU/jvlHHm8++jpfKWKYBKNidH58CCfRASXKH+EdRJYTRn8Lj+3LkoNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1zBGUVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6C606A326;
	Mon,  2 Nov 2026 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1zBGUVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652D1F000C1;
	Mon,  2 Nov 2026 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793591113;
	bh=2wa6GtDXj8hpo+k1EJW2/u0+icSgK15ObOpBbCvF5tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O1zBGUVOkxmyziSsMVxTQHlu4oZ2ZG2siNU7SLlEoDJ9ZqeDTW4D/B4Bpc1eBW+ZU
	 tDlIDMQsEanTCE0FkgUjd5Ir22wBg1Hupyg9tPeaWgkIqP5HwwD+D7JBgxEWUPoVi+
	 OZQIVSPkTh1AsbZ3amRPMSj0GOx8X+nHBTNGnX7t2nd+F2yTfP2mfG1k9cEVo6ZL5A
	 RjQFBLqMXHjP4yWtLJ4Qnbnd6ru8vrK1NSjb/qrqZEbkoTIxQ5l7hUtj3PQ/JhCcqu
	 cQkLfpBsfK8EbK3+hcqperMlh72V1ZUr2f4Cq7tNE8QLBbC5LZ8r+B0JVz8d69kvuK
	 actxuq3cUVI5Q==
Date: Mon, 2 Nov 2026 03:45:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/chrome: cros_usbpd_notify: check ACPI
 companion
Message-ID: <augHRuNZnHwSdQiI@google.com>
References: <20261028051200.145621-1-yaojiale02@163.com>
 <20261028051200.145621-3-yaojiale02@163.com>
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
In-Reply-To: <20261028051200.145621-3-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 01:12:00PM +0800, Jiale Yao wrote:
> The ACPI probe installs a notification handler through the device ACPI
> companion without checking that the companion exists. A force-bound
> platform device can therefore cause a NULL pointer dereference.
> 
> Return -ENODEV before allocating probe resources when the companion is
> missing.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[2/2] platform/chrome: cros_usbpd_notify: check ACPI companion
      commit: 87f74d2b224ae6484628500136a75677766ed52c

Thanks!
