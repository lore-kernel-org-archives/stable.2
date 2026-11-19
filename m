Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104527;
	b=azKWCtv9/xY/3PlenAFvn6wy3F86EsUKL8ujli/og477UMqUnGtbCc5ch+yHXVLdBBk0
	 5LOXHJZXIVgoUTcwrNubyc/r12P05oOyvrXzv5VKX0lSkdl39JVQ4OGRIuJN1k2I8temt
	 EGDG5NscHs1Ja53tA96Zg0soR2GZIm7VVruFzlSCUFgE05a0raB1B8n0G0r4Mm85UNifs
	 FUWEOo1RtA9HLUoPuJjoe03AKeWW6ys0MrHqz9ijA8KE0Dz7C/qxAs1DEiVQihJ9Jj9Wj
	 cq6F+rKiyl97dQGyrn5FJo+aRJsKyhbBANH++URXSND/Cm54dR8Gld416ib54NfnTYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L+fOQzkuR9p/lQlFBhBHKN1+IW0TfkLUc5V/er/Z0fU=;
	b=vRVYd2nsrVfyFo7VFnobros21QM4shJ0XfBo7s1+Tr/J58okK3Hwkh1jijcB3RiPJW3h
	 oDdPbXpThW91yJJhRteS8CzNjOPo5LDYsU6h0F+QthIhQAKN5OlCv9O35kaGsNZfa8LtL
	 iShySsj5BTH7as/r6Pz30WfviZNMPebH9THzoo74cvu8kNeqk1CTNbB7LpJJCWKW09Y91
	 j8LmfUNm9IUFT2hjfGg2hyx9wFXlqfcXzBanCiD8Yt9hnZXMxsLscj0TNgAbNeDBDvv9W
	 KlWGU/i2qmmaRV1fI6r83XOmXOonuoLwpctiKQSakiy8/B4dfHLR/2vicra3kMb0VbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dT9086qF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E6606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dT9086qF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135FE1F000C9;
	Thu, 19 Nov 2026 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104526;
	bh=L+fOQzkuR9p/lQlFBhBHKN1+IW0TfkLUc5V/er/Z0fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dT9086qFgO6Odmk5Lw1NO6qvlcuzB+svozLChcpjdpNRmlQ1uWhPdsAced0Swa5dS
	 XtLYKKC9VWA0s9cO7v8jr0iSi3piI2GJ3RWb/D204k1oSqctA565Q3Lx87xXBzwPE8
	 TznRj6VDWJBMrwOr7OMwtT2oLzIA8EFyGA+CZ8LIddw+iowWXWRLsp80ZCf8OQT6iv
	 2xPCKmRkwiptXADlQMu6WcvOCIvYzvbajxAhUW/NNkDl+GjiM7etQaNfx3j+w4/OTv
	 W7YAKNcvD6FCon/cLGnvRAoCXlJwMvu0l0n0rf/8SPL2XZE4IkrWOPpj3DRYePqT5H
	 46NGiD8yIWZ+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6 v2] Bluetooth: hci_core: lookup hci_conn on the ACL RX path
Date: Thu, 19 Nov 2026 11:08:14 -0500
Message-ID: <2026-11-19-1-daily-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119035758.45-1-junzheyu1@gmail.com>
References: <20261119035758.45-1-junzheyu1@gmail.com>
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

> Backport of 79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX
> path on protocol side") for linux-6.6.y, L2CAP only.

Not taking this yet.

6.12 (and probably 6.1) lack 79a2d4678ba9 as well, and a fix has to cover
the newer tree before 6.6. This v2 was also not rebuilt or booted.

Please get a review from the Bluetooth maintainers, and resend it covering
6.12 too.

-- 
Thanks,
Sasha
