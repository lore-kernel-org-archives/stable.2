Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625569;
	b=UHt4EUw24oSVuCRWgIOOODYMyA4pjqDf1U/d05cD6eK2lwFvwcXpME314pfC3cY1fGta
	 sXvxkONTNN1Tn/BMMUDuAygGbpdIY6A0s9AMMP7pY3pj37yBLTuQB6aejZPDoj7wpMSEA
	 lBSUFvRyuVMFCCg/yuU4Oaw5zyhairExoQxZUezoq2zOnbQhvgroc5007tJ60G1NLnKSe
	 quikI9tFfZeWNhsF+l1dYB/crlgdTwmwM/r5/R2Lli4k1lvNirrYDb6wGFdOmx/5ri+RQ
	 2HPhLhYYRb6sUtqUD8u3vAdW/cDaGAX9mMSHPyuXveoe8ShTi6cLdglpw8H9+G+ZtSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625569;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CoDNx2ORHU3Q/BEFy3nYC5wv5kPrSTM3G0Q9KMektEU=;
	b=mf2y/Op75alJLJAFoAeglK5/4c+U+LCpMTAJ4k/F3soa0GuKC6uEvA4LyOuIcNzhpo/I
	 Z1fJpvtNSYa4kDcGw7lCGH1f3n9DSs0YUM/KySPCEmBGjAEIA/qDlnMT4rxNuzfsIjCo6
	 DwAAVaYILYIO6bxjG60a7UlXQtbH0dsojldGbEdrA8bJeZalYKjnID1+CXtvO1hswMSwO
	 v/EXC6/2ygNH+j8WQNk+lzrMZC/lOqyLTuoY967Aygy0SZc0raBYs2Ak3VKTSp61jgIxk
	 3JN4qiYOYTjjiiYs+9JejiqwtSGi3C1IQ4V1xYWKfy/7CWel/PyWYpMDuODdqmNlRZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oeHs/Jxc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D1606A319;
	Wed, 21 Oct 2026 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeHs/Jxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C901F000C1;
	Wed, 21 Oct 2026 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625569;
	bh=CoDNx2ORHU3Q/BEFy3nYC5wv5kPrSTM3G0Q9KMektEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeHs/Jxcj0jxp55A8R+vil0AVqaPwk1B0PDDKnwOf2hOs362ofJI5/vWXy3VWkJo1
	 D2XyQp6iPXHAqx0/oZ+DFW/BBUQQaE52/eUCvRj4orpXC5TxpUymfMBMI8X2kN4gmy
	 RTE76DkhDv2c8geshpcqoSzJfGw6uZtJ3TRJyxBb8xnztgtqnQVSiepKdK/LyIomYp
	 jfMRdXYZt8eB16EDLwjEZFLIS4fl8AIcQIxn0QHEudrlSAyjfGEUnzUXFMtpNUVTSK
	 6mJNsZsT4K085eARWSztuxozF3EoAMKQfWCdGSeKJLuKtc07sZZt74Fguw4+ekeL1z
	 SgCBJxESKeTDw==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: Re: [PATCH v2 2/2] sparc64: flush vmalloc ranges from the D-cache on map and unmap
Date: Thu, 22 Oct 2026 01:31:38 +0200
Message-ID: <20261021233139.27341-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1649afcb-ae04-406c-ac41-92f62d7343ed@gaisler.com>
References: <20260928132102.1707-1-kaloz@kernel.org> <20260928132102.1707-3-kaloz@kernel.org> <1649afcb-ae04-406c-ac41-92f62d7343ed@gaisler.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andreas,

Thanks for the review!

> I would not say a cross call lands on address 0, which kind of sounds
> like execution would end up there, [...]

Agreed, reworded in v3.

> I'm afraid this solution could be a bit fragile though, [...]

Good idea, that's the new 1/4 in v3 (not for stable), and the 3/4
message now says why the filter stays.

> This is a strange email address to use for a Suggested-by

It's the GitHub noreply one and I don't have a real address, so v3
drops it and credits them through the Link instead.

> Given that this patch depends on the previous patch in the series, [...]

Done.


Best,
Imre
