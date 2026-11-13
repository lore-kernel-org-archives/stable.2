Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537224;
	b=nx3ubccA1w2WYzeugSQZuTQ/5Jx3TZ1jL1bP7060KLeHBzLyp9GYE2jUvVDanHx3o8aS
	 7Vy47/4N81/HrrH2YLQO2HIpZGmMsTbZH3OeSWDCK4OYPO717p9xw1jkp4bB1B7BiocSw
	 8X4A99XufYkmwvo5AlfjH2/qEXsZPx/5drtNqZPmh6mf/FJwCBzwu3SEcKs1Qfrighkyl
	 XerZKAtC2p8rzvB2Ysi1MBG06tN5ZgQ/f+JbwK0pDKkikMYSVg+zwt1AVZohSX/f8XnQR
	 QhxA9Uao2EWxeDXwYHKssvx39Qh7UqKyXlsqxCpYPmkOr/WvPtAmPYNpdwiRf7DNMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K5mRZnhIei6FHFF34hxmFAN7wjJ9hwFen5TdwA3GQs4=;
	b=0VhQgPLMSnimKkExd2pGEVwTM+5bsj8xM/Vm2f3AtA6owTqMKo4vVkSBh6V8RrfdITwt
	 GhekqXZHazw91gpNacPooPaqaapqVlmB5Q54R2WERs5pc7jPiICtbJYH/t4K2BrUvKzbM
	 DcLyE/0HfuCrvETGiygBg3zj4+KlbTW40+WY49NKNyLvQ5jUhCToO3BBMro3E5f1YH70Q
	 b4BwH1qZkYEV+KM4wcNsDu3hahYzTATMG/W93wZeNl2qTNyzMz0b9TdqVJqCvXXUQnRPO
	 jOGZwlWXyaHTQGHDycFUDwEL4wPNUL816g5gq1nz8Dojsno5XdrxWxY2SFcvws3YNkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5a49off;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D0606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5a49off
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0771F000C4;
	Fri, 13 Nov 2026 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537224;
	bh=K5mRZnhIei6FHFF34hxmFAN7wjJ9hwFen5TdwA3GQs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T5a49offNEqJo506OAS6l1n0YgsQef+xfXh39mbk7wt3HGxqrkRTPMYcFUQYSZw8a
	 xperS2hl7EHpVBj7AqOd1sfm8xSm9b/v5JpeXasGhuFHzY4UpEn1xxh+gdgp3LtD8G
	 mF6DAxlmr6k1dDmp8o/QYeNXNf19A6oMutoQQGIZ+MObkFWcfgCI4D6TQPxw0gdqjt
	 QsNjxKJOGNmqCcl6NpFef2Xv/7+1oLJcjxuqEYFJdZCMyqlfyMUcX+MUKIDJnau90d
	 a2uYT5GSROLPD4ossDZluqeIAlCWi1zjZSjuS8Cd/zicrxphCh6Zn3EqqShBM5T6j7
	 13ua8d+HoZIpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	odys.yuan@gmail.com
Subject: Re: [PATCH 6.1.y] mm/migrate: untag addresses when querying page nodes
Date: Thu, 12 Nov 2026 21:33:23 -0500
Message-ID: <daily-reply-2026-11-12-2299443806@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112081905.6095-1-dennylin0707@gmail.com>
References: <20261112081905.6095-1-dennylin0707@gmail.com>
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

On 2026-11-12, Hungyu Lin wrote:
> [PATCH 6.1.y] mm/migrate: untag addresses when querying page nodes
> When move_pages() is used with nodes == NULL, do_pages_stat_array()
> uses each page address as-is for its VMA lookup. A valid tagged address
> therefore gets -EFAULT in its status entry instead of the NUMA node

Queued for 6.1, 5.15 and 5.10, thanks.


-- 
Thanks,
Sasha
