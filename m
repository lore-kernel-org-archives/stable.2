Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274874;
	b=TDjTcgjZpB8xddTCrr298jCOBa0zRQrAR9FM2uFhYhxtGQjqzkpro0CgMKjEH1WwuhTk
	 RLEiVj0HCxZ4C5UuppElNGDNJS5hHZebpuTdCjmx/uU2puojysrX7t1OGpY8JmZeftxB7
	 YdCjwCLOMra79iIkKb6epE47Pr9VhSzF4SNxARJeULZgugTUbdH1LVaSVDtk25INFKAaD
	 19qWfVix4x8qGMjDwyYsWimp1OaHayRar7V5KMO8xnTtFeHboB30Nr5NaL3NFo7bK40pX
	 ChEFfndzA+aMUGfFSRz5g4OHMjy3DKSES2kFkVRrK3jQCS92qr2xm8AYUnJ6zsLKBXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zgQymTj5zj6QQGl9fTcd/jbTu80sUikQ+ngEqSrA6rE=;
	b=TkXhMQHv5CWBimjgxtH3zAsbu3eJhn5Ffro0MP59sEpv0WNas32ewl/n0vO+dzCr9TGW
	 F+lbZl/hFrANASApokg0jWyfAyJ1gdfWHM61rGIIPjJIriZXF0gV2ljkaw4loRj7fnCIQ
	 suW1Psp8vIN4TvhzWqnOI/FsUKRa4uVUsSEY3jxkLN3TCZDVJqHOMusxNzF3WcgRVgcs7
	 qn3D3ZyJpXU8mQVB598G3PMnkCLlZK6r7KtWnfThddVsOF/gE9XKl/XIAT/s+j5Ofs0/N
	 4Mcnim1bWRVMhGoJz9FE69djiKOp1iirTd9aCGoU8bkQBn2UUKqcD6xRlEPMUjycX2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA7+k7bT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F44606A320;
	Sat, 21 Nov 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA7+k7bT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E191F000C0;
	Sat, 21 Nov 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274873;
	bh=zgQymTj5zj6QQGl9fTcd/jbTu80sUikQ+ngEqSrA6rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eA7+k7bTNtTpV1N/bkZ1z4PZuxwDiplB2sYoFcgIe/S0eC1hhYoKSGaYM+iy3JDDB
	 WTOMpBEkz6xH3Fo034BN06/CgOoXYGnU7g+5gkOxMxIyiRYI5GLtid8o0esX03chIt
	 OJXVyK1Y44elW393MsK8BKGcp4+XoWZCvsRIyBOsdNxX4W69n7pk6qAfhospcZFcu9
	 UoiH2sVNI5ln6Iwu1RkayeTIuBBdj2bivXLC467raQlH5BMRmybtfScFjbXYWQRpUL
	 FJzgdLDEZaHUS21xyb3PdwcIDYow3oe60RR/oNcGqb3jSzKC0C+qBGixXYlmRBjBhW
	 uAsgwQTBr/viA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	mlbnkm1@gmail.com,
	simona@ffwll.ch,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [6.18.y] Please pick three fbdev mode-sysfs fixes
Date: Sat, 21 Nov 2026 10:27:34 -0500
Message-ID: <2026-11-21-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120201003.42046-1-artem@trailofbits.com>
References: <20261120201003.42046-1-artem@trailofbits.com>
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

> Please pick these fbdev fixes for 6.18.y, in this order:
>
>   d15d51fb26e830af58f3f21964f1c09c239077ea (CVE-2026-80580)
>   ("fbdev: bound mode sysfs output to the sysfs buffer")
>   95e647d2a5304a8fd11f1ba3c8502de700650131 (CVE-2026-80579)
>   ("fbdev: clear fb_info->mode before deleting a videomode")
>   061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 (CVE-2026-80785)
>   ("fbdev: serialize mode sysfs access with lock_fb_info()")

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
