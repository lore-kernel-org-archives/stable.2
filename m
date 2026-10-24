Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872686;
	b=cAbMPqYRoi0EeEBjJ9eR9wKpd3PKXFyb/egz/ddjewf571aNQwSTh6Kyy/E+NtXjr/sm
	 PFagh03THnw6EDb97vZgbHKrKRg0S1c3IoE1NrW4dzp21F05eYoiLF0jrwR4lXkVPVrNA
	 GAf1y7WEEspcB54pIDPAXMvUDwYY0g6fgKoo39WHkXKCFcaxdG2oWCUpGqtH7boFOABYN
	 5APA36V7YRRYfx1/0/aYvpnXJHIjJ5zuajvUOLZTLyRts9EEzbfaXbBljgzpTVfaWjxaT
	 wAjwyS/aIYIBNRZFxtQIGesqGShqGtqn/sOo0Haedv29QeVGHBMLOURJCKZuMMqGP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V+GbDgbvhCLiJhFgeMPopzEBGnYrvYydXPPXHjCneQo=;
	b=dgOaZQ9fAfWFMCZ6PN3kcWMcQ8AK0D9WAnhtLElAM7RsPA0epmQm8iIGgQU2A4L1M/xo
	 9kbsNDywe2bTyOG7c11OV5ugVLQDkwaf4CQQyxw08Z1ovUUSRVkElO6WeLiG1THKzA8NK
	 ILiK/ontSwg/vjE5UQQTH+yXeBdGtE59NDs6CH/B2BZaPc+Dv0XHS/+nC5Km7SGsC08n9
	 8+ioYWdTaYouCH9GRKiN0hI6NYf9STTLG7grlnFm2U/ZsCpFy0yE+EH7FUxMXNkbycMUh
	 cmibQyVNy74RhCEc9WgHbJNjYHgCU7LhvfrXX6JNgpDQIgLwtwp7a+BSzj3HS9ZhQqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc1YLwT1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C44606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gc1YLwT1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B59F1F01825;
	Sat, 24 Oct 2026 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872685;
	bh=V+GbDgbvhCLiJhFgeMPopzEBGnYrvYydXPPXHjCneQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gc1YLwT1ML6DwtoIJfbiEjLDTxCL+dW2btp0zqzoI81szZTvO5yFEdUidhHsaaPTK
	 G2/K780mhhFlynQDdLiLgdHKOWs7U68TioQPHJRJXr0bN2fLf8tXFhdFKSJ/3CF/jC
	 BoP2RLqX+Gmp7/uA/dkHudtJ8cSx2EPtaAaajs2l0QPtIm1GGl+VCO1mvulKg9nPGZ
	 1jjvbKvgEqWnmWp1AKsn1Tp5iDPDh5p9Xj0NEGlVjtqqP6dieSjPC5fNCFg5hJTjq4
	 +CuxSz8I6MBj66+Mb7AAieq3SN4XlyHZPWI6s4KblicMtlIWsbCXR22kmYsTMeBP0x
	 sHIJqdQKYlk5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 6.1.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:11:01 -0400
Message-ID: <2026-10-24-1-daily-reply-0003-mm-huge-memory-pmd-dirty-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024083834.466-1-ue081723@gmail.com>
References: <20261024083834.466-1-ue081723@gmail.com>
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

> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> file case, but not the dirty bit.  The pte path does propagate it, in
> zap_present_folio_ptes() and so does the pmd split path, in
> __split_huge_pmd_locked().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
