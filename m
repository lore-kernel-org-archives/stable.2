Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991C411F99;
	Wed,  7 Oct 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407065; cv=none; b=lpd+Bnsv2v+VaBhCTdbve98EqhUNRNbBiibvfK2I3AHCaEG1t3aXTuQi6n3RLTQ0Dsms4Frfqio0p0IYR808sWlDfjhZyJVtr01hoyel72hf8OEciXJrJFyL1Rt8ZGpc2OGpLPk70h4uufI1Ja1gjn9Hv8lpRKQWNhF7FisWrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407065; c=relaxed/simple;
	bh=8qZZBZmujXsnUmal2mVffrne8mTRG55SwXa36qqOr7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyXNlzB7HsJCx3udGBa+ueER/41t1yE/aIGj2Yhacx49kMNFOPBZdufxtcJlvqlkdABSPPVpWPMJs286JDDC5ke/hG2e/nXunznOgI4MN4rxyw/3X/FwcOsNHEPaiGHCW9mYT/OS2dnqyxiVv0p7KDErUzVH7irAJGXHHz5+jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7OUWzSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7OUWzSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BD91F00893;
	Wed,  7 Oct 2026 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407064;
	bh=2gQSZ0tzQCagzbbVWFsIfuUniGVyzMOGnpkWABPqHd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7OUWzSsUTe5YQyfLzsLbp1XFC94E9sO8As96pjuw0FmLGYTpdXYTms42EM9In76s
	 P1sVQikhPYoBSg2wmRfMFRvV4pFN6r1TXN+VJiejKKdQrGv/lTCCFB/wpoZh209buk
	 kDgPRhTZwiz5cL5HG4weOgPlFOjep2k2jR3TUTf3sh287mbbpKr/lTGN01GjHGBCYn
	 i+2RK6hRzxkJXqZAtDKkM+UO8d9C+MLLETnbAQLOZsxHOtZHUM25TOF1af4kh/koBG
	 5u+AWI5qloxDL7EFkpHVcTYS+1DKxajB4w7JV5TfI8UBFRDXOMTJGVxjB0OdIzOkg0
	 QMFvyG24uCs7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 5.10] fsverity: add dependency on 64K or smaller pages
Date: Wed,  7 Oct 2026 17:03:39 -0400
Message-ID: <2026-10-07-1-daily-reply-0022-fsverity-64k-pages-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006215853.59771-1-ebiggers@kernel.org>
References: <20261006215853.59771-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
