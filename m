Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CC46AA7B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648113; cv=none; b=uL4TzVn5LKmIhjS2A0Be9M2N8eB6KsilWaA/g7xz0Yo1SEja8E9WFG9d8epRw/g/zI9f7VBcElVACbqz0gQvVpixEXn/hUykUG81xEC5ntZykAG6xFyarLNqCIhLa+olojM2LPqQB4lg6edqo/ejJjJ04Ya23t7KSY526aCUYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648113; c=relaxed/simple;
	bh=2+8jG6jI+dimhmqP2ySW3r9WCChohs6wY9fJCohlnbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4K9qCMURQRKA3xEwUzVYnUHlTm2hyYjgcDdQs9TgxvPe5t4XUQTlHnV0WQmucbHDXYGh1KRcib4KZO9QzWMdaaybITMULzg/Duq7nbLHx7m80sBrYlWD9qg05idOuipKzsSRWNiHd7L2YrMbdLOqkXNi7KKDQQW2b/j9/Flo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=i+8K7khL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="i+8K7khL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2+8jG6jI+dimhmqP2ySW3r9WCChohs6wY9fJCohlnbU=; b=i+8K7khLSQM5x+z1HmIgDRrawA
	jrybN/9nH3p41z47UPGjysyvw8xXDvOWueeSGUGI5dCchG6Ea9ez+bSd7J77W/6CRowPHsXKVeuxu
	GrGPLezvNPuSVjb8CrcOTVHYBLWGqtnkMyga53yLEGPuSm7MXakEQiuAB4QShn9bxqGtRbC128nM3
	PQX/E947mkBkzMNz2PKWnufzpp1lFgakSas2GSYuzFQbNS5kfePgy9hFMN53kUyIr1RMhEOYcRPug
	kAfebsmHQ++wYM36N1OySrdorStUVvxF/+TS8/cqIb5aw56xZyJn7z/nf/RV4AWId2D3znZFQAHi3
	C+7nTzOg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, quentin.schulz@cherry.de,
 kuniyu@amazon.com, kuniyu@google.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 6.12.y 0/9] Backport "af_unix: Drop all SCM attributes for
 SOCKMAP"
Date: Tue, 21 Jul 2026 17:35:07 +0200
Message-ID: <7935491.oDFzTOozpa@diego>
In-Reply-To: <20260718192718.0009-stable-reply@kernel.org>
References:
 <20260717172922.3398851-1-heiko@sntech.de>
 <20260718192718.0009-stable-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Sasha,

Am Sonntag, 19. Juli 2026, 17:00:23 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Sasha Levin:
> > This series backports the "Drop all SCM attributes for SOCKMAP" for
> > af_unix onto 6.12.
>=20
> Queued the series for 6.12, and picked up the fix for 6.18 as well,
> thanks.
>=20
> 6.6.y/6.1.y/5.15.y still lack the fix, so backports along the same
> lines would be welcome there too if you'd like to extend coverage.

sadly, that is way out of scope for me.

I did look at 6.6 to see if that would be easily doable, but the number of
(required) changes adds up quickly, so I stopped quite fast.

6.12 is the LTS I _need_ to look at, but hopefully someone requiring
6.6, 6.1 or 5.15 will step up.


Heiko


