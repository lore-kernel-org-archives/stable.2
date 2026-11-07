Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079395;
	b=15vCvL7wHsgCsCDUGQ5XMHodzJe8JZtsJJUcKN3YbGMxB3+d8XjzojyUHVBb4g2NwYRY
	 n3GpeiGOfb3eAieF5xywHgjWXKEJk+IJVsc8dhXuh411S5M0HMIW3tMpMLvFXkr2q7YPE
	 htSZpy1w4uuqeSszQxZywp9VTo/kdokVM76yOZC8nKoTsRVa+juTP/A8/dhDUGQqXDnBr
	 2DZuVF1LXbZVpeB1Y3bcbYFgtxp/ugFWQYZ7lxdSqU3jZs/MwaEP8AIlZqv5wun8sRJDa
	 SbBZeD/TuLaK+C/h7KFTmE4hu68kUM8sEkL8LOZiZ/UsDpx/zIFGHZ7l2JUmn3otQ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079395;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3zUI8NUITzTee2M7T0uV8NYDOEa0o8UX4A6U1gqrzZs=;
	b=sUkMr3g74Kkz19xTj9QHA9UY0psBlWqMFPNQo2XX+/hUi4DLisBE8wNkz4W4wiu88Yxx
	 wCaO5hsINOT7VcLh9sDr0KVRhPIekh+8XZuXprtJEWV+vRkg1OIyzAP8hrnCG0xYJexNY
	 HFs0cIZovL1urc+kSzOAEknMLGMvWWEmlqyBsY2/PsgBHFoWsq31eQVUBnXRRy2ESGm57
	 saA77NBKNXvDqnQMlrkb1E4BYwwzp1nSAPvSUMd/YVzfeTUi3MYKyhSp4RJsefLAk+fLG
	 +sJJRiJ7aVYvtmW5nO5sfCz1VK7f3GO/s6ghdIsFobLkuRJUiKW+z0VSwdnfTKB8AmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxECBn+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCD606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxECBn+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29771F0089F;
	Sat,  7 Nov 2026 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794079395;
	bh=3zUI8NUITzTee2M7T0uV8NYDOEa0o8UX4A6U1gqrzZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxECBn+hJDfgB4S1ShyJaCImQJEb4WLPK8Lflg/YSgybPWVbv26z5j58pTD5U9c0N
	 5LL73D8UF2/QMnaVKAiNsmLsLrDpAgSA3XNl8yasQBEeUSQ0LExoJyaISEsize9E20
	 6JpDYoh/estD93ldUIHmY8mfvKQ67IiRi2xADyXFZJvTRnjkR9pQ460ErWlDveYg4n
	 gunccIVNb8gJLjIEzZ460Dx6J4P32sv+cOsHutkQ6fcbYWmWtR2VDI3PjQC83Cgy+Y
	 8I8H6SGQL5CexLLf6WjEpshvocSQ6OUy97DVTks0tr/X2s11KGNjW0+gJuA6cmBvZr
	 oA/AhvKoQIleg==
Date: Sat, 7 Nov 2026 11:23:13 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: herbert@gondor.apana.org.au, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crypto: sa2ul - Fix HMAC key preparation"
 failed to apply to 6.18-stable tree
Message-ID: <20261107192313.GB6049@quark>
References: <20261107050806-failed-6.18-780cd10c8e78@kernel.org>
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
In-Reply-To: <20261107050806-failed-6.18-780cd10c8e78@kernel.org>

On Sat, Nov 07, 2026 at 05:08:06AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 780cd10c8e78f97ed768be229acff0ffd5483477
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050806-failed-6.18-780cd10c8e78@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Actually a clean cherry-pick, and failed to Cc the linux-crypto mailing
list.

- Eric
