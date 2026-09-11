Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD543B6D4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125694; cv=none; b=hkquYrJjICh80vmXQMY4dY1Qb5+hBTcff8DKkZVv9uvLK1OMmgTVYcBa0Imy6V71Md7qqwFp6yJH98RAnMtcLHzyBNbgF3F9rvwR17DIceP2eLtT+Fh15Jhc5hLX9lvX7B9lv6txunvbq6970KdeiKbxLkK3G9cUZgQSh+e22lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125694; c=relaxed/simple;
	bh=lVCTNrAQU0/rvcWjpY9vvRYQS9humbYxvsZnW7/tX0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rijW4ZUQ5goqoUE3A26JnYDQTiqZgwDgvMyCpPKNhW0DQt+DBAzETGenQMc6hyWzGiqcp7NBJ7Z7+sR3L2fDcsmJPlXCJVEpmAPuhF2ohu3rwpyaxDQBjQXaocnH8s0sZqzHP1OeYY6Wi7qhqH9NVY/n+GZc4I7loP73NY1Xu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkRZ+rCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkRZ+rCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13431F0089A;
	Fri, 11 Sep 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125689;
	bh=lDF/02Lp6+QVn7+jxKuUQFuC2ILiYrfwchkLol8wKCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CkRZ+rCdW61JL722geuXVQXwacbrIssJ+Svx9GpUfahLb7N1hdXA4l/WRWw82FRXR
	 FeaSGzGfc59a2byy1bj2aMYbLcpim0JOqOl2trJzgKTA5dsVTTVInbE/S8pjkw54X1
	 uzFN8rslNYE6mCsV2mzvk6w/kbhDgw8YGF/WPnYC9Xkxs9j6UYWZEURIui58aED44u
	 a/E4CpSY9pwZkC09RKCl2jPvSLShpX9hBf7gibuXOPok+RSdhr4u/CTqDCqutL9P38
	 GdC/EQwWg9R8ZJvhXs+Nnj1nSW7ozWTBgFF7oap4UdTB3y9nYkAvO0hiB22jD19uHu
	 0q+Sgg74inmMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 6.6.y] clk: meson: align gxbb_32k_clk_sel number of parents with actual count
Date: Fri, 11 Sep 2026 07:20:50 -0400
Message-ID: <daily-reply-0031-re-clk-meson-gxbb-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910072347.317012-1-jbrunet@baylibre.com>
References: <20260910072347.317012-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The following out-of-bounds read has been observed by Christian on a
> GXBB WeTek Hub:

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
