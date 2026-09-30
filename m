Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07116348445
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760724; cv=none; b=oOqCjA4C0EdrLjkzs6qGUY0vnFqvFe8lePbRRKhyNs7vkY9tljkkNEKfUQMhW9sE2yG0XC87muPdmSRRWUiEGyOx1zQfAI72+6QZHxKTcwjx6hsqolMBN9C01ryt4ExRDgjawjTKKujOse/bBnVfUVFKereloQfRsxAuKwlTF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760724; c=relaxed/simple;
	bh=SK9+hRX9I8JYd0FDEO4zp7AoQZGwDZd4UKZRluasWyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkz7aCw1LvUodVu4zgURcQB5gYjgEooKTUFgtc4mtOVZLO65NxO30kifWzxN7cZ/PUS0DDciqIX4eTiDQ1wIMziBlKDYG5NiiIDZAa7E1UOe2dhQArg7ednwkxwG7dtMwRTHZHjDmK/z7VEcm+UvRplE/sgl93vJiZixoFyPaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIEBGxId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIEBGxId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BD11F000FF;
	Wed, 30 Sep 2026 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760722;
	bh=AqP7K7fUWh7BhVqSMhbGNUiqNy/oZlniie0yIQdWnrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIEBGxId9aktDWNFvzfiyoq98G8JDeYhIRKCvd6BtrJ/iBVMMY8RIhfj3ACVkMpFK
	 A/ZOfm66qYgLx6sAoWMMJywzkjKYMfhdlbmcaCU+wCm9wL73KNgv0jrQ9qW67Rnli3
	 OGCjiQb6Niauc7FtE/y/jUrQmyLrap8XDBLfqUBCS+jIEmfqerNxqZcgvvV/uKeKGP
	 3qQP6I+swSudungWjeTSaIcW+oNbe7ecKSRTdYcewdRTB7lQfIKMTkLjxGtZxHPKxw
	 2AOP3iGCIe0Pv9HjHdPldgTJkw0NjeKXgoYlsuPgqsn9PORE7htteTxUcUre8gYYWr
	 Z9S0gmX9JxB8A==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 2/3] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Wed, 30 Sep 2026 02:31:58 -0700
Message-ID: <20260930093158.45932-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930092449.43969-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 02:24:48 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> I will post a manual backport.  Could we drop this series and use the
> manual backport instead?

Just sent my manual backport:
https://lore.kernel.org/20260930092829.45885-1-sj@kernel.org


Thanks,
SJ

[...]
