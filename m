Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49357382381;
	Fri,  2 Oct 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950820; cv=none; b=IZgKQNhuYW5b0m4JXYIszNo2SkMVoClnXq0Yj7j2AxLoddNz2E39KbpieSxbuXO3eBlkr7a4XeU/+udc/qtikKQFZKth7+XhxsFkmJHAWOaFyWAP7kaTdJ2qJV6hA+fFfIlIjzufeettjw14h9ur2PkHW3HqbNjSF7sgSOrbHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950820; c=relaxed/simple;
	bh=LITY+t8n//on0/3D8WBhlk9G13HuGGeIpZrGWPvfzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA9z2KIfcnQJXlXSCvFxXWpRiwyEm69L4n2uQy913FNkEft/VuFCaFTUgkPa8PwdahSsrTI9A/ghlY/S8hz71GIxOm95nCyoYyWxFLVWi5tHQJLxDrOWUPTxHdcZVQ62pOfkGPZumB1JW1s7Ny2wN42bq2+zT9xd3PRfPyJbRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omENPTd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omENPTd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6A51F00893;
	Fri,  2 Oct 2026 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950813;
	bh=BGOxvfHN6O4PeXtNTSU1Wm11e0LbAQUwGvTW7m/K2ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omENPTd/q1I6eXxvCYCzaW3Y2s3PDwLxGR98xFyRoqWjuORJUwXcr8sC9bMn64d9W
	 XoHKKpRu5QUIOeHb7SI6w0VHfPb7eY9Jsk7e26/akSWtTesbASszZM22NfYJ0G9qfN
	 U+SDP/fjX2zxIQVJ4EgwHQ6i0U83FkY2PPS28KDZh0DuABJ5VYHb4uym+rp+9U3zjm
	 YIOrpY5ywYjLJ3/sqJy2QljRgK8t4n1E6KlOHowuNX/oJ7szSWpVjr4drbdZjufRmg
	 TUb0AuwRVeOa+04lR1ks4QvgPsY+AcYv1fm5GmF1gNvdcQlzk4Oa6CF4F58j7zWYEn
	 VxX2t3BF95LIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hubert Mazur <hmazur@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanislaw Kardach <skardach@google.com>,
	Michal Krawczyk <mikrawczyk@google.com>,
	Slawomir Rosek <srosek@google.com>,
	Atish Patra <atishp@meta.com>,
	Atish Patra <atish.patra@linux.dev>
Subject: Re: [PATCH 6.18.y] mm/execmem: make the populate and alloc atomic
Date: Fri,  2 Oct 2026 10:19:55 -0400
Message-ID: <2026-10-01-1-daily-reply-0011-re-execmem-populate-alloc-atomic-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930-execmem-atomic-6-18-y-v1-1-bd35d4523aab@meta.com>
References: <20260930-execmem-atomic-6-18-y-v1-1-bd35d4523aab@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please apply this fix to the 6.18.y stable tree.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
