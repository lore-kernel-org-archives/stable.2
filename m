Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32D3560AB7;
	Tue, 29 Sep 2026 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709207; cv=none; b=Apd+X63pfUpRmNIA4lrJqf1CGcRrr8MV9kZuR/iFTcN8q4oWsFmtb3JvUZ8/HO0OaXvgAptjj6thn++jkUy7m7Wf7CGI9RWsgJMi5zxsTxs9cr0RCpHYv8EhnWzDJdaexh37SEjC96D5kzT5zU3/aHHpEWhQ66V0UvWWcIfO5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709207; c=relaxed/simple;
	bh=dx4bxNxlHbgLPpIPVxflZdL3jaEoNZNWaR2/NXJmBzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gphKhvyVwZDAeErCskYZYI9vW+qIWiZQa4FSOa79eBmPSuGIeEQOTErZWmeSo1kESukT35fqLk0YGtjpXL6tv/tbkq8gFUuViTsGV0SF7ZXtxCfCDGjMfQU9ZaHE6VC8UdmeRfRf+UJUQBlbjV+CdJbuFtTDIQZ7E4mkQM4RzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjwpQ11C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjwpQ11C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C391F000FF;
	Tue, 29 Sep 2026 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790709204;
	bh=5r3uHgRMEL0KjkMkPJ+LZyLaQ/rueZBjpaVZwh05yFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjwpQ11CD05WkSCL5UBH+9YY1tbKVrT20kVb5z6MnTWmynKbfNwOW0XHqOGfy0Sg+
	 wxNrMh4RgReKpMdAhGP4eRpRiYrM5dWd+JDplMwa6Ans29LCPYAoW93uW0LzEbFFeN
	 CzkYj8ung4us6RrMkT8GvaD8vZwnEaozhgktKZcHKO2qQ41I+MP8VfucyoD/dDv3OM
	 bzRCeSYqGsORuylELeNPMOwtE2+uNzPKKXLDrLOdAFlPJiLE8yzVaov8R80R71Xm9T
	 Fil4VHQkWmXICyYev9ROYrTWYVrmU2o9LRlpq+6NA0y3RwRlzlOTZd3Hs7ijrUJ8nw
	 ExLuDvUtdzvRw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Date: Tue, 29 Sep 2026 12:13:19 -0700
Message-ID: <20260929191319.10187-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929174456.9251-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello stable team,


Please don't apply this patch.

On Tue, 29 Sep 2026 10:44:55 -0700 SJ Park <sj@kernel.org> wrote:

> From: Liew Rui Yan <aethernet65535@gmail.com>
> 
> When the temporal quota goal tuner determines that the goal has been
> achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> zero.  However, damos_set_effective_quota() clamps the esz to
> min_region_sz when quota->ms is set.
> 
> This is a minor issue, the main problem is that it doesn't match the
> description in the documentation, which state that if the goal has already
> been [over-]achieved, the quota will be set to zero.
> 
> Fix this by set quota (esz) as minimum as possible.
> 
> Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")

The problem happens only when there is temporal tuner.  Temporal tuner is a
feature that introduced in 7.1.  Hence <7.1 stable kernels don't have the
temporal tuner, and this patch shouldn't be applied.


Thanks,
SJ

[...]
