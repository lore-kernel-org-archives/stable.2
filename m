Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207195;
	b=XQp5OmjrxWomNUMjouYsj+WmMjbebPDMjzIQ2TpUPngqULjrHAtfLeOrpkXZqTGynEH9
	 ACuHaa3QdVNA9WHecTymIhRV4sd3o+F3wcdTSP2x+WtVe29/qCsNhjfcaM5DMZzNJTfbk
	 /AKULYAlU9JqizUAQUA0F8Z2rsgV/PIke4twRLYwj9tYDK/GMbQ5sarg4H98vbJVHgozg
	 OXltkxrL9BWh+rucT42QZBc19z05v7X3Q35zvGtrTWDBAfcJlZwIV3+5k3eKMTyNGjEne
	 0s7LyEI+DCmhCjCIG8gdHops6rRI6OP+WgkeQ+unq5mUZ4kAsPI7rOAYbcnyWdbsIEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tGrhs9x4eGI2rilzfhPa4/lDsJZ8nr4YIP38FNjmM+s=;
	b=Cknl8jnqfbQA659VdVcIsqdTp8EHnZVA3eMqK3dZ7OI+74JCoUtpaX6pSBPfF2npjy7F
	 KK/Yteqm2PdPHi99gE+U4r1FtreS2yeZO/+fj4v/PA0zTiQjHf1xlx/8OJIJ97usmFGaq
	 AhCeHGKF6hdstvHpZ3EDXsNnH5+H+dB/vat1GOEzo/KOoktUQLryjly9k7+dwbYTAUjfb
	 1+vcZtFBQh6gxCfuQ6w5iPqZb+aII7T/w+UYVYE2YiziBEVSzA8X+VwvuUdrFviig/xz5
	 McLbTHAeIVdHfmnV+fRQwge5SUXKxqH237Yda88fDailJNnCFNm4JvMQOXDZQu0vs3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC2s+qjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CD606A6FC;
	Fri, 20 Nov 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC2s+qjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97B1F000D2;
	Fri, 20 Nov 2026 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207195;
	bh=tGrhs9x4eGI2rilzfhPa4/lDsJZ8nr4YIP38FNjmM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AC2s+qjwbwhhHhED4Yu7rfQ3q1Xp1OhzZO4S+uNWdq+9fbTnErfQU50MlS1WTsNKJ
	 HKIs/Oh33owFyOXEdMPgQbabsF1EHYbExfuRYS2Pa1PTs/JNKK5dgu8LLWiRtt5EB6
	 C+TpscAu3ACr1CAc/P++rRkRaiTlciHkvGrfhvb9SM8SVH4Txq7u0i5BSSKHZirkpN
	 gE0a3jqqqrp41GZjxsbX/+ZNWEy7oYFNHAqVTCV/RczoJRaRHXfF4/dbKJkUKEDLwt
	 U5jUl8NeWo2RbNgeRSQal3zkk4Gher2nuBFZG5WTCAEmWfcUaWIFfUhRYjPm6A3Ild
	 LxUyU9i6TKP4g==
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	Yufan Chen <yufan.chen@linux.dev>,
	dev@rebasedinc.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
Date: Fri, 20 Nov 2026 15:39:10 -0500
Message-ID: <2026-11-20-1-daily-reply-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112048-paper-radiance-199e@gregkh>
References: <2026112048-paper-radiance-199e@gregkh>
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

> > >> Commit: 3adf7ae18bf4
> > >> Date: Apr 18
> > >> Fix: Partial mremap of the ring
[...]
> Great, then someone should have tagged these for stable inclusion, or
> let us know after the fact :(

Queued 3adf7ae18bf4 ("fs: aio: reject partial mremap to avoid
Null-pointer-dereference error") for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10.

c03ce4173c7b ("fs: aio: set VMA_DONTCOPY_BIT in mmap to fix
NULL-pointer-dereference error") isn't needed for the crash there: d53b5aa5cfae
("aio: fix NULL deref when a fault races ring truncation") is already queued on
all of those trees, and its ->read_folio returning -EIO closes the fork route
too, so c03ce4173c7b would only change fork() behaviour.

-- 
Thanks,
Sasha
