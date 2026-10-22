Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634664;
	b=QiZ+v5jpnnLOpzFhH7z6XfjiRaZMcmX18zx8MX6hVr+y5hAVSBzwICkJY67uLJayjmqE
	 tyTR3q/KSKkXhEUiebxZio9oOLkh4QBykzg78S2NQw1aajiMbOx+I6SYTtY08GB6O/Qab
	 sJgcic/maTjXp+zlQMeKqsjiJ0acX9aa2XwvviYuN+eUe16OBTNGfSoRsQJHeSbzzjPlG
	 6qc02JEQZfHElhECHnWN7Wr1xXYIjU+Jj6/rq+wmrFKLdO6qhTPcCXifsAKtt27DcUNQu
	 TyUEhVVkf4xVo4CeuGBOLBXC/djM+xNtpIF20b9ioyRnaolhdYkiCBxK2mczQ+1M7Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FHoGU3P8VaCb7/TjoA/yHn/2fh7EfJteNLTHV+aLMyg=;
	b=G6qMuiQtvQyeSAYxG+NYk08NYbli2LD1sNHQ07zA8q7KwCC/o2U7IMaTbms1X/hERs2k
	 hQHY5VmHHR5O8KYSL5lmhFzLoRB+sJMgU3rcCdzYpUIC9l5GICjwwDzxEBtBfGiK2dxbu
	 vUKSyr16YSK+SdJDfq9NfsllkWveHYLyUFvyuZA4oicLED8PeTvSnfWCfHqfyLtztNbfM
	 OzNnsbMCiupFZ6gYceacjUlKB2aCZpZJz0B0nFhP6A6SKvA5MVGwkneIh08u0MRwgFyD1
	 yDgrLumeWl9iiyqI8TC4YHsrmPMgz9yEHc4tMFpQOHoY4X07UROQpCMLjytrX3l4HZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LguxVDUa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101F606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LguxVDUa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335EB1F000C1;
	Thu, 22 Oct 2026 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634663;
	bh=FHoGU3P8VaCb7/TjoA/yHn/2fh7EfJteNLTHV+aLMyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LguxVDUa060MtVkf3nwBL3FyN1TegKbXqcTQDYiTy+02gg51mVIJl+uyFQGweUSnA
	 PNsk5kMMHB2kpHlGqvCEhZPBVtqEDqvKYZ32jfid+P5K7qeV7cK4C6RRNbCMJ/YFHL
	 cXsiAKH8vpa5Tq2TCY+X3kfROqnTk/OZlBymnT9XS7Gz01z+WypIVtar5VQNvM4ShN
	 ZZQ7mSqVN9Yj3Z9wnSjPRt8TjgHwSA3XI5kFJjvEYNqRgZmcSD4v+KYR/IV/WE0j6T
	 IgOHBbxfGnvaGufQe+PQvclrtsXdveVLu5D3Aj/3hBsQ2AoUoRG4jdFIQgZtFN7yeO
	 ORLYiaB3IL09A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/huge_memory: bypass THP tuneables for huge pfnmap mappings
Date: Wed, 21 Oct 2026 22:03:48 -0400
Message-ID: <2026-10-21-1-daily-reply-0023-thp-pfnmap-tuneables-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020094231.759650-1-ljs@kernel.org>
References: <20261020094231.759650-1-ljs@kernel.org>
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

> The sysfs THP tuneables at /sys/kernel/mm/transparent_huge_pages/ rather
> confusingly only control the behaviour of THP in some instances.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
