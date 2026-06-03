Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8B3AD52B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499697; cv=none; b=pLsdPBErWk6S63b2vyeGE838FybIt74dMP4wIhjD95haBFPH8h5jlEWqfJ/+Vsd4ZzWEf+yPPEELVrwitcyjbJnMoP6ycc+vwss/DX25HyFZgGhpJNmtorKsG6hCB6NQYd8D5Rx6L8tr9TIsJwXTNrKIUGg5LQXCcmQhYjmTFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499697; c=relaxed/simple;
	bh=KfHgXhbPniMJaBbvlyUkTWGRgQ2rzezoVeU83qmDbrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNWNogM7H0jswQ3Xynjuu2YKrxlmPcgbUqgZr1vt/bBPD6Y/3ZjN9h+buXi9nTjZPhAYaTDRwMThjgDen8ygjUgTgl8nOABlKFwgWy5F6yougKoZRGzQDDoN4hzfOH9NX97CLt5rOrUfX/EISt89A6jqceZv+xWmAfddsmsbMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqaTe9LR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqaTe9LR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2541F00898;
	Wed,  3 Jun 2026 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499696;
	bh=yhNbQwCeczwm1UBqSPhOp+DKXYAnRtGUvgijtL9mFpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqaTe9LRINPluBj1nYX3rF+qC+0yH62e6bO6RETvfhelxXfCN8LGDqOvS8KM0nba5
	 qie+aNpzAQ7ZHh5EFKO7bEzlkKBbF739FQCIgCfja+6p2pNFjGN0OWsrYKuCkLl1Ay
	 k1lLYV2PGrvvk2KH/S/Z4HqSHPOafWzFeGa/0shjGFcMNK1QER8o0NagoXUw95NkyT
	 Xbf7IvgECPQwwbEQPZTaFBmeWKfdBT3w8RZ5kLcrS368DDZ3SbFYbjyCHNtc7RZPC8
	 qdOZYPQrec85nsZXlyfmEALparaAjW8EUXfhYUVx2NxAQGcq9t4ZdeXUxJrQNDcmw0
	 O4L/z//j9Rncw==
From: Sasha Levin <sashal@kernel.org>
To: Li hongliang <1468888505@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	patzilla007@gmail.com,
	stable@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH 6.1.y] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Wed,  3 Jun 2026 11:14:22 -0400
Message-ID: <20260603111500.item068@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601061558.3703791-1-1468888505@139.com>
References: <20260601061558.3703791-1-1468888505@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.1.y, thanks.

5.15.y and 5.10.y need a separate hand-crafted backport - the
upstream patch doesn't apply cleanly there.

-- 
Thanks,
Sasha
