Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9997481231;
	Sun,  4 Oct 2026 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791141457; cv=none; b=qzBSXbnD1x7zBN7xJfuFLsM6S75465kJOSFod/p6R8KF+ogFPxbKdbu+RMcaHLVensCNZIlb8wp/nw1EYpjWHlY5E45Cv6nU3J7S/nY26K8W/nRzGLavrkY+LWLrrdtM32gjDlgQfZ7/VUhnCsNJx/jwSEcLY8jMFD9w3AqUlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791141457; c=relaxed/simple;
	bh=cwcQyFsBdQiz4AODDFnIK0iCJGhvrYvXDWtLCbj7cp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rIC8IXqTIuuM3d/G9RyoPGWb3MyjZUS18gvDP65cM4RMr3WzfmznZFV7xyVeJSXWmSeCgQDM2L+7CU+SM9n06KasY2yYQoYP8wAis4I8Dw0Kqb2H5/mCmXzFcmnbxYVOd1YVjAGPHLpFrqlz10ELqg4aTdrFvwbv6CELoFeye5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKC6SthU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKC6SthU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF58C1F000FF;
	Sun,  4 Oct 2026 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791141456;
	bh=U4ham3UZrahVIDbrzBfATMX1syRWuwrls4wKXjImMmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SKC6SthU55XlTp9mE+cpIajS8CNRph+jRc2lzip24tbr8pl0fOn5ngaIQNG1bPL+7
	 UlVa6hT6/aYEwCom+056VnSZN5gJ/GMnQOhSWOF70d5yJBbd6twyaHDvst08eveLd8
	 P32k2paNM8in8kEgnrYlfHh+mTz+0IHQ0m+m8hHoWbOo2mmE326UCEf4pKPSzCOOgK
	 ME38BqbQnKfjuYg6pENS2PlEg7qMA1WIDhYd4me9VpLZBHVJGCviqmxGUBQ4Q36Qud
	 gd8v8VuSyZS/CDRkvLUYb0jWZ9df2wk/o0mZveQwY+oQyp0GNLBAI0Feg1+odGNo6U
	 Qw2WZGA/Gwnwg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Corentin Labbe <clabbe@baylibre.com>, Alexey Charkov <alchark@flipper.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260930-regulator-get-all-v2-0-ca82070d22f2@flipper.net>
References: <20260930-regulator-get-all-v2-0-ca82070d22f2@flipper.net>
Subject: Re: [PATCH v2 0/2] regulator: of: Fixes to
 of_regulator_bulk_get_all()
Message-Id: <179113136860.150114.14388134115062666575.b4-ty@b4>
Date: Sun, 04 Oct 2026 18:29:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cwcQyFsBdQiz4AODDFnIK0iCJGhvrYvXDWtLCbj7cp4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqwqZLNAWgT2xWSIY2CnKmG1NSVeznmqCN6qXMP
 CnuplJUHv6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasKmSwAKCRAk1otyXVSH
 0GvhB/9GDj2/bU0uZKh/V37XeEgE0l6nDE9HSVD16H+cCbaqEefRP2jTv9ZU4/0ntlDI27hxAmh
 6Db36j5QxV6G+tQHSLkYxM3AbtX72Lk7OM1hzgXzVMl4Iwd4dIIet6IFZWz2Jd2s8KpvIJkevyd
 PYRsk/AF00SuvuJlpVo8oyb1o0ftPWhJ1o3tFUHQTa7BB3pNoGPLfduKeBQ8KqyIVxS2MO5TJzY
 vwzgfD6mq7pAhCP06sD62gYTLdeE9OKpz+raa9gubRP6bbcq5v8R8LTyX4ycLmtuwqRffeON18X
 kzQJgcHHqgM4YobE4XDxlAu1NMNZZuaxw1QpAT1mCyzIOZsP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 30 Sep 2026 20:13:02 +0400, Alexey Charkov wrote:
> regulator: of: Fixes to of_regulator_bulk_get_all()
> 
> of_regulator_bulk_get_all() only fills in the .consumer part of the
> struct regulator_bulk_data for the regulators it gets, leaving .supply as
> garbage, while the rest of the regulator core expects a meaningful name
> there (e.g. for error prints), causing uninitialized memory access in any
> failure paths in the core.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.3

Thanks!

[1/2] regulator: of: fill in supply names in of_regulator_bulk_get_all()
      https://git.kernel.org/broonie/regulator/c/e2151c29cec7
[2/2] regulator: of: state who owns the array from of_regulator_bulk_get_all()
      https://git.kernel.org/broonie/regulator/c/b35ff7bd7dd5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

