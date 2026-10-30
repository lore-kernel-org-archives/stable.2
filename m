Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385419;
	b=K+fyxSA9PVYGvhN36BTXKdnkNBCGiStQw1UF+TN2fN0FkJxw/k5GTZPrat4vBjxRqKN4
	 9irKJ+qM1Lr/8zDPhatckP5SOMITkkYTOVzhU1SPOs+U4G3cf++/++88SLSXQepsgS7P7
	 RCjkj31y5ypCmkdXVbrJcCAIUc4oawZ8KR2UpGQMOnhrx4t24Pw8AAYbOA6jyGjChxzq3
	 HtY00qz6kT/d/GTCp/dAXf0BJDbp6eTVSHnuczk0q5ecAF8pbghOrlLnEG0Lp/1SvYVqJ
	 vJPzSKr/dmzeYdY+AdwJbdeqJjf4i9YNzLxFZql2Mg66ahf2mJMNuwjWeisoGvJrWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385419;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hQWb7TJsKWyoKe+2xRhxz4iuPIx/iKeV4EOEe75oHAY=;
	b=MB/9Fu+ZJXA1+QyYCQvP3kc8KdOlNzgd1OxLeBGh9vFT2f1CvujCgFiJ6ZtbQvJ7Na/d
	 SqW4NPEiMwtHHB0yjpbOtG5Uli+VO2mme5/sSPxsDPQiTAL5QBYbt6NPLEZZcUlKJcpRb
	 A4hOyKGYGSse6UYXKzqHAGIk+cC2aOoM9oS+q58wrSjOmXqM6aEKx+u5/AgUOR3KoS82C
	 iGUZQOpVyxeUAD56MCv8eprgnolhbZwCkyLi1CgUCrBZwMH7kbSmXKiL9vPlg6B8n5u4f
	 AkjvrJLgsrNO6kQbSmVzNOnlxyuty1sDVi6RHAw8ewEKlQT8m+gcvvw38D23OI9dQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andres.codes;
	spf=pass smtp.mailfrom=andres.codes;
	dkim=pass header.d=andres.codes header.i=@andres.codes header.a=rsa-sha256 header.s=protonmail header.b=FlbJDvrz;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CA9606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 18:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andres.codes
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andres.codes
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=andres.codes header.i=@andres.codes header.a=rsa-sha256 header.s=protonmail header.b=FlbJDvrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andres.codes;
	s=protonmail; t=1793385413; x=1793644613;
	bh=hQWb7TJsKWyoKe+2xRhxz4iuPIx/iKeV4EOEe75oHAY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FlbJDvrzu33nzhrIMp5epSrskjuDi5oIlM0QpGFHcmJZguAuUTCvL+oe/Jp3xP5jW
	 dWOhrIHb/XGuLMnGK3Ikoboy8ntSBsYqkPrIUF2jdHKEW0afKlceiqLFQqAlMrIpTv
	 UmzwwAdA+niUtUxVnPDm1smGiWbBkhC4a/UUjv+63yPBT9hBY1AQrVSDX7LiKkwObi
	 W0zEwgkAC5lcqY9yGZk/fYFvkZ7s7/ukeo+o13C6XhplHEvuh8EIBUG4B8F+MWBfLj
	 U0Q/idNMLO4IN702cPfZxjWTV1EsLK3HKCz+Jkb1ninsurGHeA+iJQnyu9e8P0a03v
	 LCq0V4kSsXHmw==
Date: Fri, 30 Oct 2026 18:36:47 +0000
To: adrian.betschart@cinemaone.ch
From: =?utf-8?Q?Andr=C3=A9s_Rodr=C3=ADguez?= <hello@andres.codes>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amd/display: Apply the HDMI RGB range default only to HDMI signals
Message-ID: <20261030183450.31119-1-hello@andres.codes>
Feedback-ID: 74930084:user:proton
X-Pm-Message-ID: 116c1e407ddbb85253cb08b2e3ab49f6b92ff6c2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 08:45:58 +0100, Adrian Betschart wrote:
> Require an HDMI signal as well, as the original commit intended. DP++
> passive adapters drive an HDMI signal and keep the HDMI behaviour;
> native DP, DP MST and active DP-to-HDMI converters get full range again.

Tested on v7.3 with an RX 9070 XT (DCN 4.0.1) and an ASUS PG42UQ on
native DisplayPort, 3840x2160@120, Broadcast RGB left at Automatic.
The monitor reports full range again and blacks are correct.

Tested-by: Andr=C3=A9s Rodr=C3=ADguez <hello@andres.codes>

