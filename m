Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625134;
	b=apwpOQylXxUumGx6Cq1gpeFtKXYjnTffw+2whNpo8Cg+7LhkR3+POr1b1qPxtpzatTxP
	 ljwQVdxXtQkjh6MN19dYX9Yxogo17pssV9ogXVs1zmWnaF9tMQ/SO+iaNLktwtXnKvwNt
	 p6EcOMOES4Zx3aiv7w06SWxAA6/Giy3LK3xUkrBVUTLlF4jgYyApKsth2y/7hO1BqgTFY
	 uk5Nl7qzoJAW2aP+PgWOvaNGzNKxEA1gwauLCe205l6OhX43FUDFkIm7TL67MyjRzvl7i
	 dCjn2a5xFg8qXr+kK/egsmqEtOWuPY6nqwrveR6uME9FrfmivGdNamIy+c1zEkuyxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wIeO8jneqkVW+G+CbQGL9V1JsqYJAQi750I3C5Z5N/U=;
	b=RCHWUkuQGx7WJiV1g1fTbVt72HanJGpdW8Pi7GNlP/iDaSSY/oWD58v/PTZjdbNKFOKJ
	 VfRt3/BqnHgBoO7ob6tjVTslvXgJKVyd+5jJ0Dk8GkeEeEkcJdhklKL443IZy6Z0NCp0X
	 UwmMsOf9CgUjL+RvdP1OPRhI/s5ZNOCpysd0CPvXSn7ELioRT8/ex+CfnNJH7n2pm1xTY
	 r0/kKwrnWLo4miJt7mvr8U6ZEufRWJ3b4/KJXyVY1w+XmDM7s3zVjAuwwrOqKBEXfiYbl
	 vwv8+4ixVY5kwM8GTlGaYKSospBxHJ3EpS0sKnKIVr+BVq7LZ0nvPTIRm5j3hsEtBjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNVA5n38;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB1606A319;
	Wed, 21 Oct 2026 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNVA5n38
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60621F000C1;
	Wed, 21 Oct 2026 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625133;
	bh=wIeO8jneqkVW+G+CbQGL9V1JsqYJAQi750I3C5Z5N/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNVA5n38vrHd5Q2UwAq/6iHqK/SMH5vuQYpinDCEHUY6WsTP1s/dlKs4oLK1SDOYb
	 7DZUA/af/ij0jvTHSsAR7CstxV2tLW3ZpTZI5IfeYD+Wyo55BXGzAL9fLW9/WOd1+n
	 6IO6rFsdSCtjQDZdmIKWUobMh0tBr6NrY62fruhW2wXq5Up3j3BbspMcUtNPN9yys5
	 UAh54wJWjEhklRDGAk1B2ppF+bTe3Qp54aqwsVIjSHm9PYr+lLwiew8IdTCCOweHbd
	 J1g9iuMdl8SYuEZ4joiRVaZWOqOHTtvojohi4+TMRo2Z4BISmn7nSXxBH1f5IAG8yD
	 jPPbXOqXOIs5Q==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sparc64: flush only the aliased page, not its whole folio
Date: Thu, 22 Oct 2026 01:24:23 +0200
Message-ID: <20261021232424.351-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <84a43e75-6302-4115-9e68-90576a88163c@gaisler.com>
References: <20260928132102.1707-1-kaloz@kernel.org> <20260928132102.1707-2-kaloz@kernel.org> <84a43e75-6302-4115-9e68-90576a88163c@gaisler.com>
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

>> +#endif
>
> Another thing, an /* !CONFIG_SMP */ here would be great as well. In the
> followup patch it drifts even further away from its #ifndef

Good point, it was getting easy to lose track of. Added in v3, where
this one is 2/4 now.


Best,
Imre
