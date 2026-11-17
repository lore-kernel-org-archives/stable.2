Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926661;
	b=j16lxjTMULq70y8vFERnswC4iExhXHFpqXjbwhDgA0uf8RApj/MIwqgLz9RRgTZufRYD
	 YbAr/3l8/sS6rWNzCrFLH4z9zokLryuEYYgBpUqG1mIFfbJIuaoOcWJf34L6qeb4xGqaI
	 U5tkR2zj0cygSdNCQnoUR8d5Fi/q38N6QMPK6JU4aVCCitYoZblFBGbwh3/WvPqHZCtBv
	 pIjL2KGhglWQtUoaze5HP52lQYNhOyV4oAN5y38vfLdqodKZn7s5KOAd3pARAr6ZT7w6O
	 kr8HutEeYxu6dxoH00hpAXq2IUgTzaV3vf3zJeRy2o5UmKVZRQPnVILFhxzdTpgeCCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FKqHwWb9Vsr0EE7nC7sU59WB0WtXzppmSDtlUQX6DHw=;
	b=b9G6GqbXnujpOmgKGg15fO6aeg/pIYq4s4oOk1rPiKAJ6oWZnud4cFDlyoOtqMMqEzQA
	 iHbwBfCmvYiOI4K1iCosnMoDiYdMFdAw76vFpLhrCWNosMWHkypYi4hVUnn/DgqVS9GAy
	 UljDXl6jBvMrdZxmWSsqNtucvILEh+IUBLpNkeFNwY0GMrkEwuvLD5Mzmzuek8bzZreHU
	 /eJTt6VUIUStxwgZIySWZjry5lrPl8zPs+xPdColVII23OheZ9PpTacoRHmYlX0VPhzhe
	 r5YrZvB63PZHkXGX0vatcprp03qF2b/pFStlYY0A4DRyDLjBeRFIodaYjO63axnRofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwWoKNgX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E87606A32C;
	Tue, 17 Nov 2026 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwWoKNgX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F17B1F000C5;
	Tue, 17 Nov 2026 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926661;
	bh=FKqHwWb9Vsr0EE7nC7sU59WB0WtXzppmSDtlUQX6DHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwWoKNgX1hhUHyAJHu6ZAUg0po2rNn5Ux+/PNtpD9E+Bm2OyodrDrYc1FiMDBwj5P
	 3wTqUYx3VFocEq2/1uLd/Ki/UDxJDlvHQz98fYmx0GoxnvMkourBD1EwgUgkMZj1Wk
	 p1T6fznV4uQutSDBID4xmBpZE19FNvn4JF05aX3vFYafTW0phXv0F6NtrEIRSLeORd
	 swC6mgJA+HsX2iEaegyisXuBHItMjdR9iyVH2RZbjVRPljcoJwrX5xYMhyFvadVnwU
	 a++BTmpqMH+47Bs10RamSl5pQIYon42x8i8s238NGgd915kykkxtxwnAb4VvdhRTNB
	 TiX8AmCX7s6sQ==
From: SJ Park <sj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle time milliseconds
Date: Tue, 17 Nov 2026 06:44:14 -0800
Message-ID: <20261117144414.124589-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117094339.30978-1-devnexen@gmail.com>
References: 
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

Hello David,

On Tue, 17 Nov 2026 09:43:22 +0000 David Carlier <devnexen@gmail.com> wrote:

> On 32-bit, the region idle time in microseconds is computed in a long
> before the division to milliseconds. It wraps once a region has been
> idle for about 36 minutes regardless of the intervals, so the cold end
> of memory_idle_ms_percentiles reports wrong values with flipped signs.
> 
> Do the multiplication in 64 bits and divide with div_s64() so the sign
> of recently accessed regions is kept.

Thank you for this patch.  Looks good to me.

> 
> Fixes: e5d2585d9e85 ("mm/damon/stat: calculate and expose idle time percentiles")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
