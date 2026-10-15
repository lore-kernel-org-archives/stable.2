Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA5568FD2;
	Thu, 15 Oct 2026 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092990; cv=none; b=gGCx0+pSGCV7RU5d74OWbx9C7ik8KaA+kb+umAzlfK63SdzUzHPWh30sp1WQQanOvrvakeXbj1pfZw3e8NvrxgcIEoM0fDjN9CwkTjVEPvanlXAswVN4wFSj0Ut48Qjgtr1vLHdSwl4G2zubWV7FpNRAtLpDruHeHTCjyFsaZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092990; c=relaxed/simple;
	bh=Hx+AJv/o+tb0C4Z3KRIz5rGJOL99bG4C3tc6qwVrL3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Hhvf3UXmiR1GAWWKSPOH44OJLTo2IAxKqVHZLKi18syGyjLsUvG9dGuMcWaI5tjNsO6e+ZonFhfpgr7BetlN/tK1GPRkIeUx9ItiJP15Lub42l5IyKDNj7+WZCxPSdAjZVsHlbgUf8nSNujS+BL2nR7+4K04jUb2Y6QmbUcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djyi9OQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djyi9OQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C55A1F000C7;
	Thu, 15 Oct 2026 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092989;
	bh=hXGA0b1XwWIXyKViWpinYs6M4d9HToK4LypLLz4iAF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=djyi9OQDFWdfOCIbkurzYTxGCjSI3BnP0YMnErHYimPaUS3l0nTjaLf9q+YadJ1Zl
	 XcGXu7U+HSTYloVsOTmRp3ddZupnmGN+R4kJ2HElSKEgzMMNYj2yhFWSCspYjAozlB
	 t2bGB8x4nk55/fvAObl2zFqkXVUdILIHUgy765KTiZJBOyYDfi+CEfUbl4rLhqNlHb
	 L2MkXJryIhy/RIzOJ53nzM4KQOH4TzJ+Ef6tmVPMpqZijLZZf+Aa5+LdewGD5LbhS9
	 exLAnsAIJhiiKxXWatQwprlAIdSJwcI9TCZZUIplJ5evjsBGCkCacjUHm+OfM/nnZK
	 VYE2/awI+xJvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ALSA: mixer: oss: Add card disconnect checkpoints
Date: Thu, 15 Oct 2026 15:35:50 -0400
Message-ID: <2026-10-15-1-daily-reply-0007-alsa-mixer-oss-disconnect-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014192420.24397-1-artem@trailofbits.com>
References: <20261014192420.24397-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ALSA OSS mixer layer calls the kcontrol ops rather individually, and
> pending calls might be not always caught at disconnecting the device.
>

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
