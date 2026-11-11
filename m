Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434103;
	b=cEPT4xfom7676zBoRdwPjuJauvWF6+PzQSh7hEYyAkygwgyqg3BkrYmj8XVdnE3vURrQ
	 xAIzKyQHl43l6swlMiilNEtd0jxNdpZp66lP+SPNf6W6rMfeaCvQAEo9KL68regTwGHDH
	 V8TAXpFZ4zAr89TPyAR4JtlcVIkew8rKYGKJXo9SqM9NFbgNJm4MMTHDsi5owyHHslTuD
	 ZxsPy9vxWqsVDffh+kxuD9FQ46mqzk0hsW6pFnS4aHvLeam6eiZfLINUXQIN0pRmAQVIY
	 FJDn+cv/WuNkSdH2afTEskkHLjnBUItWUP68Jk/5cr0EmCfVKG7W0Y888ZnQY/8+QbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5/Lh6qnLdAJTAdCTzDNAkd+VUDfClbRlblkskJGF+o4=;
	b=mglXmKwUyldpYNYWu36AKQoSs3GVWa36s4JZDNyiM4EtLkRR5SyZp1l7CrvnJAR70DR1
	 /s2eIl13Y9qT6wFBqg5qJUUfG4AWWyTRuyj7seSB/9We0kAgZvan8wBbrbcFv6LxmQjYT
	 B7sysDM3ITcBFBwgowh4QIKgdh+G2gmnWgDieDpGg8yLb32eGUPGGfC/JRqAFZmp00vfN
	 fAjDzI5HzkOvR5Xr2dscPdZbJUox8QP6puddHuBdjtkzfY9S/mCW2I1ZzbgvYal9ybzXg
	 6n2blV71Ddww4dg+Jhqz0FIE0cXTtS8IEkuwLgs89OLfKJGdK6aUR7xgT+HngmJIp4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHd1X0UR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786260A5BC1
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHd1X0UR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DCA1F00A07;
	Wed, 11 Nov 2026 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434102;
	bh=5/Lh6qnLdAJTAdCTzDNAkd+VUDfClbRlblkskJGF+o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aHd1X0URuU/iNEmm1jtBiK9ouuKT7sDUgRojcPH2SUci9FeiMJotxb5AcFozYY3S2
	 761LUKdgL4Uuyilfa7ZT0znzl05IR94nQkwccOWd4vo36IWoXfy+fMpWEUAhvvd45G
	 IwD+GWZSRE8doWIqta1FFHphI+METIwtzS00+doYQ2dTsBY1/f9VHmVQePaBOmZBk1
	 1vumAE37h6BF6igy423MY1Oroc7qyfvh8fCERnMOAHdgdcaBt14ibVvifXw2BK4DDO
	 BiXpZ56RNeEnPIxseAgg7Ht1IxSxfQYN7Ui5i7eyg35aE9tANLQQ2u4AnnW9aH98ql
	 PhypEH2jZPsAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Chris Mason <mason@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 6.12.y 0/2] mm/gup: memfd_pin_folios() fixes
Date: Wed, 11 Nov 2026 16:54:34 -0500
Message-ID: <2026-11-11-1-daily-reply-0001-ee2f9edf0f57b52b513b@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111000605.3227011-1-skhawaja@google.com>
References: <20261111000605.3227011-1-skhawaja@google.com>
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

> [PATCH 6.12.y 0/2] mm/gup: memfd_pin_folios() fixes
Queued for 6.12, thanks.

-- 
Thanks,
Sasha
