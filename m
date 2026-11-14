Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678157;
	b=psbVwX5pgUqNg+ChQCvU1OsD/87CVrMdmrAzsXo/zpAbFNd65pzZCFz+RnEG3PWUPCHT
	 +d/3mLEqfSIYXshDmEAeGpPdP4gueWtEFaA43k+hhlhmH3zja7ubOqfCg6BuEAWhfVKdK
	 gOHdeSN0VzHAe7/qKr3yN1zTc1rYM+8+qPna1+za27JKfZZ6iBUqHWg6LT/aCcGv2+XJu
	 nbxPD1s3JwxJtnCI8LUA3WCO2lfmI68HhSmCwCVY6GKmQVRYC6pvQn4wB9a2P4LqM3jAj
	 hkTHH3y91mMCIY+lMugKavhTjdquyF2p1iNvfL2sP2bu+PC+VaxoDm1dbfpRU2Wt9qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tHgeuerGYE2nCicFtM0VIE23u62kRY5ss2jEySdldPg=;
	b=zi4R2OO5btKWgFeqdLDv32DIpUp35Ulov6x/l8IPSTCODJJJ4xG5pwtUfGDZ2qKK6N90
	 8C2lp1XUt5xT918DvNYRSohhZvo5hJK/pcNtox1hCCMxhGj/zSNAnICq8R/ejimX85nAB
	 PDlhQ+/4Gq2iZJx/n5yy/sX4UBMxhWb5lMHh/8yF5JETfJ5UgbESQIiAdMtClE2IFd1yg
	 L8P+venudbkiO4miLMBF2Cgcikigi/n9B+5IQBHUaW6PaRc5S8i9UDFd4XgJq4BxVZTXk
	 l80KtLTX2G5alp6BEHsckEjDMo0eEF3lBnJz/q+T3DlkSPy7G1BTxi4e3WrKapzU3JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CERlxO+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AD606A8AA
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CERlxO+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168B61F000CA;
	Sat, 14 Nov 2026 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678157;
	bh=tHgeuerGYE2nCicFtM0VIE23u62kRY5ss2jEySdldPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CERlxO+3pZdOL4Stok2EokCxxHj03mO90wBLxBOV+408Nw1khyY/uWAZH7QNsRg4Q
	 iqltvKYsM3GnmwL5ySGVN7To4tsIxuUmlTxJdVt8F+gXwwZCo1qmpqo/1tCS4v2TVe
	 d2TpHssHUsFFNSs73lkB8vfxX9ta1TZ7Svf5/KoekM08FCQORVDv6DwD/vD3rBD+ni
	 UOHoulEapTP8/2yfisMxi8c3nRs57nCc56AkSD2Q7H9N5TJisPk2IrsZrXFRAj9ZR5
	 hzCt4VMUcGl6Cb6nBfENyzFRyr/mnyCdMZQOwd2R1K5PSBfQEQlngDp23khzMaCkCf
	 Hfn5RffwAM6EQ==
From: Sasha Levin <sashal@kernel.org>
To: Bjoern Doebel <doebel@amazon.de>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 5.10.y v2] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Sat, 14 Nov 2026 12:42:21 -0500
Message-ID: <draft-agent5-0010-re-sunrpc-deferred-5-15-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113172457.222949-1-doebel@amazon.de>
References: <20261113172457.222949-1-doebel@amazon.de>
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

On 2026-11-13, Bjoern Doebel <doebel@amazon.de> wrote:
> I see the verbatim patch is
> already queued for both trees - it will refuse all deferrals there,
> just like my v2 would have on 5.10.
>
> Want me to send v3-style backports for 5.15.y and 6.1.y?

You are right. I dropped the verbatim copies of 2192a56b0686 ("SUNRPC: Copy the
deferred RPC Call from the head buffer") from the 5.15 and 6.1 queues.

Yes please, send v3-style backports for 5.15.y and 6.1.y.

-- 
Thanks,
Sasha
