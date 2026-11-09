Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239623;
	b=ZtPM7mjcXMMqOZ+q9vw/wPwSfuInfb+jMy+wBk1g2qp3SYv5gGD6UlzzYC7Q6NqG3JP9
	 tA2VigJpzEp+n0C6S+juCwsfcFoeOdBjumvNeTzu4y9GUgPXm4GiL0QMseMiGDL9EJS35
	 ghpG5weAymBbxczl67N2EAyfJyaP73yPNkfymTFcgIoBvz0f6f5kFdHzvFe+yLBUCPh+l
	 49JUljqWbtjrci/9s04ZVqk8Qz0JWiK3i3cGuL7NoPc3Fq8mUaN1YUi+XUKvzbRVrNHn/
	 7phjZ6Voeb79CuIg2Et1K/UIYrLAvQTDYxBp8X+5Y3auV70G2Ds7nBRJir/M7TP+3Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2YP4N96Oj1ddvdTfrXKKoJuX4y1RqkANCMhdOg+WUhI=;
	b=1rrrx0o+UFq1cKlrpIZMDRQTLcWXrR0Z5Ny9clpYyaCLYzs0rTRHi5thXXH+9tmnz+a6
	 pYnYu8gGT6JDffnCvb2s7ufp1YuGwgS5K0FL4BIEguQsKGORlz1rJmCJfERfAUMNnmRHw
	 dv78sdsqTkzSq31MSYOb44HJypu6/zphJ04bGWCmOMrjJ/Os+oTQHM5B1BTEuJZnAz3rg
	 ygJ/Es/w8XLcVDeVsThn/aQmpyWucPiLTSWpzCdKxNFvjKUmlcd26QDyVDTrVF6YyNq6h
	 phlo4dr6Yc1WnqJfYpzcDS1rifgu7MNFsJvl8O8pSOOQA2CypTNvbeFfYQiEl9OUAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aX3z/xy3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B1606EE8A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX3z/xy3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3CD1F008A1;
	Mon,  9 Nov 2026 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239623;
	bh=2YP4N96Oj1ddvdTfrXKKoJuX4y1RqkANCMhdOg+WUhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aX3z/xy3ynMRho0VLdnBeZ2S0h+TZcxalrRGbtFtTKMZ1w/b0OD8w+U+3c6ulqm2s
	 XwbNbdcEzBUyjX+DXyN65rcpuK7UZaKoDfkVY2d3WlR/KL6zz2DKUe3Ddam8gWaDex
	 IQDHhyA39i7t2Tiq9YK1EN5o6SMbGsqqfFDEDYkKnbh2XxBRWPf7hRisZOcdU775PZ
	 lmSUOjxiTpwEkXoEBbQGMgENWu5C2kS76OUTyCF1YQPfmk6FOtRBb9RHvVuOSOZCa1
	 P9Psdiybre0K5qn/tGaMIrQ/1lCe7+o6qvOb6mD11L9o926TVbIEy/5vmVZPM5xoxq
	 qQzaYLJdNHQ+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@kernel.org,
	Yu Junzhe <junzheyu1@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: Re: [PATCH 5.10.y] jbd2: don't advance j_fc_off before the buffer is recorded
Date: Mon,  9 Nov 2026 10:52:58 -0500
Message-ID: <2026-11-09-1-daily-reply-0016-jbd2-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109-jbd2-fcoff-5-10-y-v1-1-7e8776914093@samsung.com>
References: <20261109-jbd2-fcoff-5-10-y-v1-1-7e8776914093@samsung.com>
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

> jbd2: don't advance j_fc_off before the buffer is recorded

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
