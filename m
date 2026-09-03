Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427A4B04A8;
	Thu,  3 Sep 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444344; cv=none; b=pSy93YTmnuYUVt4Kv8K9oqra8O2eZV8sdIFq/nESotc3MNFcZHVvBtHhSxYcKlu+wqTYx8IlJ2MLNGQqEHYWKFA76CSoV5zDj707+gjZZlWXlSm3UqBQEAi1tFX4l0PdEWrmZHCxU3a63SmJn0YwyFUXbDpcDsSmxFHsgqsgNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444344; c=relaxed/simple;
	bh=H2exkOVXvIrD9p5uc4sqHT4/wXdbw8AY8xV+9VDCOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/cKgQSkmTGHnlamnr06GiBiSXaE+SSSgb5qBgYglCLPSC/gj71/i98CThjlxxKXiYK8U9pa1exn//6+tN73yRWYwQCAMLT/rixMIhv5UBEfJC5MH4ktjo5LtezfTFEF5oAjDf5SK/BIS4WB0UFHO+9eF4cVN1+aGow9VWo3MHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckNGaMeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckNGaMeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D421F00A3F;
	Thu,  3 Sep 2026 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444333;
	bh=MaD2aj64RBdEMELfyTFkH990wKoNoGi7GvA6hmcvB1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckNGaMeGbq4NUN+udET1ZeqZaP+BGvezF9qItzpVRqi1NymBYkzNSg86+L3OXPGkB
	 EexP2DVFe5g98f91vY1sZHDg2Xrjipeliav9WcdTCsN3zRCdwABTgmM8MieUj9tfsp
	 86ccDTkqUoMikZZId9aNy+KFjTUAqk/ybNomIzxkG0aAFm+GO08/LvmBdzxRYyR+SH
	 e6tvxXoNGt9vheJJbfBxh9QgO+mYD84xk45nT2Uo5QWMB03U36BrL8nd1uMEyuDlDe
	 yEkVZ/bucO/W7E7MNvQIMZAJ83Q/QiE73ZY/SMFmKvg9bgN+2R4fRecNLULJBlNtLV
	 TAQjFgQCoQ5kg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Thu,  3 Sep 2026 07:05:20 -0700
Message-ID: <20260903140521.98604-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903124422.5340-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Sep 2026 20:41:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Wed, 02 Sep 2026 17:33:50 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> First, I would like to clarify my intention to avoid any
> misunderstanding.  My actual goal is to fix the semantic of the
> qt_exceeds statistic, rather than necessarily changing the underlying
> logic of damos_quota_is_full().
> 
> Currently, there is an issue with how qt_exceeds is incremented.  When
> the quota is set very small, qt_exceeds increases frequently.  This
> produces a statistical trend that looks almost identical to the
> continuous increments caused by the Temporal Goal being achieved.
> 
> The original intent of introducing qt_exceeds is to let users easily
> notice if the quota is too small.
> 
> Commit Messages [1]:
> 
>     mm/damon/schemes: account how many times quota limit has exceeded
> 
>     If the time/space quotas of a given DAMON-based operation scheme is too
>     small, the scheme could show unexpectedly slow progress.  However, there
>     is no good way to notice the case in runtime.  This commit extends the
>     DAMOS stat to provide how many times the quota limits exceeded so that
>     the users can easily notice the case and tune the scheme.
> 
> However, under the current behavior, users are forced to manually ignore
> or filter out the qt_exceeds increments that occur after the Temporal
> Goal is achieved.  This adds an unnecessary burden to the users and
> contradicts the core goal of making it "easy" for them to tune the
> scheme.

Still I feel the problem is unclear.  Why the users need to manually ignore or
filter out the increments under what situation?  Knowing specific and detailed
case would be helpful.  Are you or some people you know doing that and feeling
it is too much?  If so, what is the real use case?  For what purpose and how
DAMON is being used?  Why and how the ignorance of qt_exceeds is being done and
how painful it is?


Thanks,
SJ

[...]
