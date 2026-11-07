Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085290;
	b=ctduYJm9KJbZ0v9hdCMr7jFAz1HzP3plCSeJ9njNSJWxKn/a04QxBbaKzk3WAVB0cHBC
	 OB0c6l9kNSeU/plTDAr0/OeHK28QDgDaQ96ghSS70U5AVmjDqYZtssdWg4sgmnXzMgwD5
	 8iwaTcu1VouTFJaZvlio7UsjLkTyVZnlRwv3SYb7shP7Qt+ob7dDQZS+wI67doJxIlxcq
	 rGnqYcpkkGyHs1obcPJDDn/FaIWP5qyAKo4ZQiDIH5TsXs8NoWopMSZlAdDCtbMN7eISX
	 +kD294FWL42N79dkWNJkqv7mvi7zBE5NCl3w/hgqR+U9jPR6IOxkVXh2H41FQ2C5hCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085290;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sOA44YoxPQVvGdEMaXi0+AmgG6ByQMuITCfSYFe/6fI=;
	b=aFmoSTXc0Dd8tngZKyh62y4onl0hpZmXR73u0kEIwhtBpnDpODgpjAEZXJwV7Zr84qNh
	 fnT+A9xOMNOwOvgnoxy66rUnDJbOMOYAnEmMCvrE0F7MtjI4Wx3wzCHnPdnPdDi7WkIbj
	 wJ9mDQYDfZ4O3m/JnRw0qbdnOWYb6q+UxgOH2njpvu+xRhuBwGVDyAXodF8qLZLb+4UeO
	 olejkw2G6v53ilJmLpt/PIGqvhLGTH0KCpIGGCaVUbSH1Y7+Fn4+C2gHIXqTmXeF5MQMQ
	 iNIIHxGjIM1ulWTF/IgmANLyKvgfTXsq9ZFnnHebnGtJHJ1UdAdsHhdf7zKAi6m4/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TC9Gi9tF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A797606A32C;
	Sat,  7 Nov 2026 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TC9Gi9tF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26041F0089F;
	Sat,  7 Nov 2026 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085290;
	bh=sOA44YoxPQVvGdEMaXi0+AmgG6ByQMuITCfSYFe/6fI=;
	h=From:To:Cc:Subject:Date;
	b=TC9Gi9tFzcpsvR/2saFUxIf64m/Tyyrnr3xir/TaM/J7y28+6fefaLX22Ac6KTOO8
	 rjJE26J2Rgno/9cgWdnICuYqbEqIKpZaB3vinje/JK2Ald6jEG7dFgaK0lOCSuxYD6
	 XEaCCkwcp1QIgHhEVVSzF1S9qpWLDCEka4vtypFFXDcTt/g1FvIDRhssSVn8Mh9qCF
	 EhrJkESleYSdA8e5KwhEldNGchvtVUSI4cBmJdxVCpfpwz4U/vQMO5HJyIE4i8vSAS
	 kEag5PixS9F0tB86cR9l99gbEAVCQ5/Ku0IRdq2v7YSJGhJWP4+3X6frl4+w56hHJ6
	 6D4gkLiMQkDvg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [stable] Wrongly applied DAMON patches
Date: Sat,  7 Nov 2026 13:01:22 -0800
Message-ID: <20261107210123.270641-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Hello stable@ maintainers,


A few DAMON patches unintentionally got [1] Cc:stable@ tags and queued for a
few stable kernels.  Some of those even causing test failures.  Below are my
best-effort (having no Fixes: tag) search of the unintentionally queued patches
on stable-rc tree.  Could you please unqueue those?  If you prefer keeping
patches that not intended to be queued for stable@ but not found to cause test
failures, that's also fine for me.

7.3.y
=====

b7156fe3b9cdb mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region
2ae8e0a3f49e3 mm/damon/core-kunit: test invalid damos filter commits
96af19427e2bf mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input
f13b460f99105 mm/damon/core: return an error from damos_commit_filter_arg()

The third commit is causing a test failure.

6.18.y
======

c088f850b5e60 mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region

The commit is also causing a test failure.

6.12.y
======

fc18efc64dc84 mm/damon/tests/core-kunit: test the size charged for a filter-trimmed region

The commit is also causing a test failure.

[1] https://lore.kernel.org/20261107194352.198354-1-sj@kernel.org


Thanks,
SJ
