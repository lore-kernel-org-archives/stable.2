Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7E395AC7
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362119; cv=none; b=eagyvw0A5zbBYrqm7v6ZWtPZzuMlTPChbYM/fQChjGcemXLoba+l12whfwikcQVM0BuAvd+U+YAIiRAZiVWXyDWAe7I4tGPYm6t34arweSHbd6eOcFZ5+Ypnbq9YUg8qezCxrc3HD7svfJlBArVpQHFHxB9oPX8MmGVruCZTYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362119; c=relaxed/simple;
	bh=/5gMV7YPnyP08wW+ZMeDnJZ9msy+cnJ+Gz9Bdc6Us2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ut5cobfgLxbo2/OUqqYIAGgq2kZkkuabTpZUwvf06N70PrVBiliE+CpwCCEeTZdbsKiqJAFR7dunDJ3hOZ8hTwZkcTS8T91VsSKV1OA3khlqPMzLN+AV8ScS7HN5Xg7EOu/A1TphPJ0cvGkx10Y57+lJblI55ikB+wesunHwOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFJzqDoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFJzqDoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F921F00898;
	Fri, 25 Sep 2026 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362117;
	bh=ydBEpBWs7cpFfpr0eqgVlaxoHPdTo3p5GNPpfZVUs5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFJzqDoCqFhiWgVx7QoEW2iiTUyOKWAzgV4hP4FVk61O1R5gfUj40ggsUUSFhn4KR
	 JnYxUpMBbBWLCi1/01ip+0L1T8QeFRAoMdtWq0Jo0w3lLWG7qT0Nl/eM3tAq2lLkd6
	 UCLNIyfsAHqgUYyuApwx+m9OK5sHI9UVDG1gTITY1VUcK5Bnmipc0Sy1bazeyjq0Jn
	 EZ1OqqxQsiRaiqfmvgmQoUEeN5faJFk28ZBBd/OE2DFU3CM2M1Tnag+eaBhIDTFMLH
	 fTKbqnFY0QaECjQotP7WKZfLsLFVrCbf44CD6bsOkna1ToI/Chqz0aPBn+pXpSvkqI
	 F/FA/XW1KR2dA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH 6.18.y 1/9] xfs: factor out xfs_attr3_leaf_init
Date: Fri, 25 Sep 2026 14:48:07 -0400
Message-ID: <2026-09-25-daily-reply-0015-re-xfs-attr3-leaf-init-6-18-superseded@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092314-paparazzi-lethargic-486c@gregkh>
References: <2026091651-freedom-anger-bd4d@gregkh> <20260917151724.693663-1-sashal@kernel.org> <2026092314-paparazzi-lethargic-486c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Series does not apply :(

This series is superseded. I've queued a single-patch backport of
865b751e7503 ("xfs: don't stash removename operations with unknown ftype")
for 6.18 and 6.12 instead, so the series can be dropped.

-- 
Thanks,
Sasha
