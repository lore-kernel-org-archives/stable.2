Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184489;
	b=tdWTuqLzVoiQN8UYZqmQ0HN7r1uJucW6/Ua+wmHTpUdCaoBkYl6lg48dYM3KJGkqxXNc
	 WrM6zpvqF2LLwF3DlZeJqRWYvwV+ulMqZSBx7LpXVhupkiJPAKtd7+0vEg1mzGC2aoD0L
	 fXp44emQvnGxjW18jbKQgvMLi0YSbduOxKy8+apAZHvvQQ86+SZXHUMz5Mi+o7JoeQfde
	 hTVg7c3qCn3yqKnNPGJKlQxpcc+oTCKURI7TAohlPfowv2etlzkN48rN3PxXqUq+f7+bK
	 y0I5MlAZH47AU2MOYP4ZNa2C2M8rNV5nMEjGOKA2AGcywTd0seY+dD89rsxTz2a7PLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NUntpAonRvcpcVPcOCScwRYJccNQJLCTw+ohkdvE5wU=;
	b=epPfTyiNseakvOXVlEd8K2bzws00AOpUulUeiGwoZC7wwE09yRPPMf2MvxufJigDtT3p
	 SmAn+4e1sDnghumAgEX9sU/daxXMYzEWXUXrlFO8rL3o2g+MvFACbZxTYZPgqwXZNmvSU
	 5giw8JegaPtVR+PyJpopxlxjqgpRM1uvXhkT+httwofbsBLjGMQorP4b8Mar17dkxUiC3
	 I3YhY/XCsQT68QTpp4nIgFHCOcLsTfPpmqKJe8lGFz4V4X1RCYayNGGAdCNWfKqtZwKvh
	 oWJpLnzQgAoOs/L+tv+Dx6TuaDVMqBx85CeHKe6zneBCIm+N86zesgMbPx/OA0kd62w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HsoiCMN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B389606EE81;
	Mon,  9 Nov 2026 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsoiCMN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18621F0093B;
	Mon,  9 Nov 2026 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184489;
	bh=NUntpAonRvcpcVPcOCScwRYJccNQJLCTw+ohkdvE5wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsoiCMN/4vqUknHAbeJQ8zWnIsiA9cwyA3KShKP29a1IqYoriiozg1xuzrT2FSfEF
	 TBpJ5a6+jCakiPJ2YzOBamupAt/vPeQqRIsk2yaHZpDXRnD3jxJTZOAxLFFbr4pJbz
	 bw57LH3+F3BtOtT6qgRkdD/n5lWDWs73CXMG2dCk0Dku26ghf3F7NVA7Ck9F+BIxXH
	 oN8m6r9wI8q0N0+pafyoBdQnfh67gqGU+3b3Cu4f6hgdZh6SPNNpRXsCPgCc2Kmmcc
	 XQNUMw2LQLCpZ3JitexPn73wa00owe7BIwjDhfWigaABg/zMzYCzIa1hiTHibWvruc
	 qPJGwYQbseVFg==
From: Sasha Levin <sashal@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 19:34:34 -0500
Message-ID: <2026-11-08-1-daily-reply-0006-damon-6-18-sysfs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107201001.206120-4-sj@kernel.org>
References: <20261107201001.206120-4-sj@kernel.org>
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

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.

Patches 1, 2, 4 and 5 are queued for 6.18.

For this one, af19aff38d6f ("mm/damon/sysfs-schemes: read
sysfs_filter->sz_range only once") is also missing from 7.3 and doesn't
cherry-pick there. Could you send the 7.3.y port first? I'll take it for 6.18
once 7.3 has it.

-- 
Thanks,
Sasha
