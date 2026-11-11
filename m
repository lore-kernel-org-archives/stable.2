Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434112;
	b=jtoSs8h6B2AbBfHFKaMw7RoZPpZAG8ymkT/zrAIatp1JYerWTVPwVsPuIlPsgySo6gCe
	 eCr9TOxlRoMYsPL2lOGjZr4YW1CzU/fIsK6tEI2hLn2raXaW91m6/SMGsZov8b8XKqkAJ
	 4EwCGoa2QDvprJJGdzcUS0LOsF0AxtGNp0zu+p5UySyYkSqrPYBHu3kE8ZSsHJeC3uHt8
	 CJdQ1iAhl/aT440liu0+psa1XTUzj2X+1D6U5SCu4eC0KTMlo0mBGgI1h90m3TU/xg1kU
	 yZZEF7nqcD4LwvjAgmHbgD7CkmW0pUcdNiN3KcEeKjHHoFKPJDZZECRP9r9t4bS71ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+4yuTBdLVdxEFVLBP82X+jniAKNXB01wfF6dHW83hW4=;
	b=ACjsUA2niJcE8HR07AS9x7P3YVIL3lbtnislGZfJn1y4BiseBwKogTNsTk4R43sbGzOX
	 8vknulqMyW22WjDI2rYWDQzszuELkam026+qobcwmsJCYuSKt39lnuuEgLLfFfEHpOjP3
	 msionE5U1nFdqqoO0OJGHAeDT4eR6eVVuBR2htYoHTD8i0kstTZ9xi1tJjFFALR6zaEUG
	 4GhC2C+ti6YTb8OnzkZUA5XQkgcs8v2MK9GmMx5fl0eqkwAj5Y1qQ3wKaftNmlzp7X0Fu
	 uTUrfl7aG5k+Umwg0Hf/BJz/dLq/rKS/BHtxPsjVywgT40+BAkcXF3vJjaPLEsj9mwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxBON9BI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6C606A8B6
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxBON9BI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C5A1F00A06;
	Wed, 11 Nov 2026 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434112;
	bh=+4yuTBdLVdxEFVLBP82X+jniAKNXB01wfF6dHW83hW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxBON9BI3wPaCZVYgjY8RABuk84J2T2Y8FuF7LxOfNKkLJPyqmOrKttEIPzCgMjf6
	 Q9E40apKIKjtAa3ydg+Iafs1RbxQUA3gAM5k1tmD4OiCBlML0SPZdYARYfPsHGTTd5
	 krZm5E05P627tDb7bYWV5x8nEIowWwsUfIG60BTY/cssh4QzOV673I/C0onX6tPYK5
	 /+UyVjJPXh/M8y7AjPKeiKdfweLdUuPqxvWoqOPcp9XQ0iPylyxRZFjjw6f3Qo2Nx+
	 lTvpjPPI9G8OTiSFFflocdVIaoNeZEkzMjErGAYrbl1p3lKQvVvC1djg1W0y44MDxn
	 MHDgRwMfwe/5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	david@kernel.org,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH v3 6.12 0/2] mm: replace free hugepage folios after migration
Date: Wed, 11 Nov 2026 16:54:47 -0500
Message-ID: <2026-11-11-1-daily-reply-0014-f65ad47bff8b905fe68d@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110220006.3259056-1-mkbund@amazon.com>
References: <20261110220006.3259056-1-mkbund@amazon.com>
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

> [PATCH v3 6.12 0/2] mm: replace free hugepage folios after migration
Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
