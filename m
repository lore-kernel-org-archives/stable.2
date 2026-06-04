Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566633D6DD;
	Thu,  4 Jun 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587560; cv=none; b=kMVdR+ivXwLY2tyGEpOdMsT9dWpc9vDtWQKhz+NRQfbsfpWsdfrF4ATRKig7hghZ6TOzbQeakNgZgRQ/SQFTUuNatEynu5+InlZ20KGNzGraIRICzvn1eUsHoc7YB8spzAPVNCOgLDGBI+7slpjG4dg6UhIFsYxNDgoELZE8ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587560; c=relaxed/simple;
	bh=FwXfzorioxEmBEwxUR7juggtZ3fXff97YXjCVNMfvt4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uH+Q3ZOyYfYbeeQJ9m5w19NmdJ0kUcIp/dOwFsl5Du1SbS7bBHiLZqNbOlGFNfuiJJd5YX6EH+vU1uz5EkYGqWw1RyQEL6PrHdS00c+GmHyzQGzFFu7BHhOKXjXuuGpxNfspaB/Hs+APJjntVj7+Jg+EErTGDxA4VKty8QegTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRsAoY7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRsAoY7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DFD1F00893;
	Thu,  4 Jun 2026 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587559;
	bh=WIjgeloGGVlHcSVb4WWYfAPYHDejWwOw4WcMpkn2jUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NRsAoY7jriDkTQykWKgbIs75zndpAPjvQizqwq+x/TK2b72/UY6ikrX1gh57dN30L
	 y7W8plQldWmCNl2VxRRAPEPYEJvIRSiU4i+NS9dT/oAI03OxqfWCuBuOysPLninnml
	 qEh8Eo5DvHvho84V3jYCausqaqW0b6ATzx50lkGwRUksPmfIVih8BBzwzQHZtZbEHG
	 S4Cf4LVaJ1LYXqLElxokIqacWK5WLNR1SCQWPgCiyD9kF96kMkupRCbW4ez7H9TuGx
	 W4EtOliIqmKy5HxJZXGa6iDMKN42hjsG0grU90J9GJifhWaGxTmYl0G7aTrfoVOLmE
	 FZd+wVr1KoyNg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, pavel@kernel.org, Armin Wolf <W_Armin@gmx.de>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260524235553.189134-1-W_Armin@gmx.de>
References: <20260524235553.189134-1-W_Armin@gmx.de>
Subject: Re: (subset) [PATCH] leds: uleds: Fix potential buffer overread
Message-Id: <178058755832.68831.13304002591164882113.b4-ty@b4>
Date: Thu, 04 Jun 2026 16:39:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 25 May 2026 01:55:53 +0200, Armin Wolf wrote:
> The name string supplied by userspace is not guaranteed to be
> null-terminated, so using strchr() on it might result in a buffer
> overread. The same thing will happen when said string is used by
> the LED class device.
> 
> Fix this by using strnchr() instead and explicitly check that
> the name string is properly null-terminated.
> 
> [...]

Applied, thanks!

[1/1] leds: uleds: Fix potential buffer overread
      commit: 22b69b2c0a5573e58ad66693196fc86369980568

--
Lee Jones [李琼斯]

