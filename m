Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308573ACF16
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490404; cv=none; b=pf/QTaCeskLU1sW9cwOlgcKqRF18BA68B/uExFAVY4ykBM5Ysi+KhxUhzcYYEjc2lqnjzokeo7BdQr2G2NaUh9YpY7CUS79hgaXURtF8NnMRkRilPkTF6buBe9/e71dmqIVqxbV6OfzD6uEKmU0TDeJv0lLWwu63hznXszyATAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490404; c=relaxed/simple;
	bh=eiOlwmMdp1CP3EBXC9YCT2GVtmxodebCutdNHWLlQGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCEPmF7P8NNIap40ZG2s3LiegLdcvm1dc42+7/N6IVwzf0jH352qe5BN9QHGf3jw4jppm/sKvGfosO2lwYde2xdOqZ7WXhyOeLvNIsqux45JG+CgJUpa5pcmmowy1cbyZ9Hai6Z1us7ZoSwiUTPQ7hgyE2iQ2fuXStlaHp4+VYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhbiq0mR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhbiq0mR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ACE1F00A3F;
	Fri,  4 Sep 2026 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490402;
	bh=LIG5OLJik8bisouTDqnAD4j1qIO0nocofcuvHfKG7Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hhbiq0mReF7BUeXsdmT+aV4MiaCzOjwmtzEVp4dLBHKnMAzO9Bl1ojq1JqztbYzka
	 iW7PgroSibqYpgQRFFCXjqL4pr0enMV+pNIxqIeF6kRiEuJK5+If5nJgAg1b1oFXLs
	 j2KPjDSg4w55l0Ra7cB3pcklfDzHfcf+3RpgbjqII0dDkIv2N4U/jFITGRywFyr+XE
	 wsIhJD+Z2lJSdhWN2Q1ITfxOlo0H9FHeuFpDR9lAnOb9VcuMDvHgDZ4CScKIU3uaND
	 Kq+7Iq0IQFR4x38hXkzf5o8rludIibYDJQXh7GFF6tb52pIydNjtsSiAZzbs4QA6qL
	 f0tEEmMrd8WnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Burak Emir <burak.emir@gmail.com>
Subject: Re: [PATCH 6.12.y] rust: rust_is_available: warn for `bindgen` < 0.72.1 && libclang >= 22
Date: Thu,  3 Sep 2026 22:52:56 -0400
Message-ID: <20260903-daily-reply-0004-re-rust-bindgen-libclang22-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903181056.11003-1-ojeda@kernel.org>
References: <20260903181056.11003-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This was fixed in `bindgen` 0.72.1 [3].

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
