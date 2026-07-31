Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE430DD30;
	Fri, 31 Jul 2026 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465591; cv=none; b=lBPozqECWwYVqBLzJhH+r4D+avWdy/7HP5nwMqTwKM0T+i+Bq+4E7gS5DFJ2fEYLHCjbKYju96W49y0nDGiD95P01YRHZrxhTLmzKwDkcXY8oYrm7rzFIseuiFuH1wqcnXNTFuNAL3+eSHG+0yUbKHBVfkv6Y3zUmchp4Rb8e54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465591; c=relaxed/simple;
	bh=mmksDFtQRonFXHz4vA9hTEa0tQXVpEUelJT2nmyRC8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfefCJiAxNuwJbKQUKXdrG91bMZwAH4+d6/cec0xM6liOM7DQZNvZJw2Iz1tcl60XIAXscBIRSqKAgx4Snb8RdvF2FqGiX85nmF68fmq8rZbH/Z4ibkeeCajkmYG53HhVUnuRitI7azZgwSDUzghcXzIZtwB8dJEqbH278K4acY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B34/JsVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B34/JsVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4391F00A3D;
	Fri, 31 Jul 2026 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465590;
	bh=OnhvJHW1cs1aBZFvQyqmS3CltXiu2GernWzu9lme8hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B34/JsVGhSurons3UrHDOKf+1xQ66xWKvl8/dTgSafS5QX67lSreEHMxTDXeGWjC7
	 hc2A2um4Cx4i2PpAkCLlF+pvzjkwwlcVSnpENxq8uFNGLm5eqQKQnZzhptZuuBNuf7
	 Nv1E+0ewHfvgyHNI6J8juwqZWuuJvuszArRwA5NaT2bvxUDt3YSCm0CXj8pGx3kOQC
	 zlYA0EiPID0buALHhBdZE3Kpi8Ql48FvNiJjHPnxamO2QOuuDkPZnqQ56Ri71wUPNp
	 TGw85wCDzNIthfqQ3PTazS1s8xFmyR/sp2fOwZA7cqKb19OsmEKi9lwzx33vG0mz4D
	 +UIC51Gl0yl6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core: disallow overlapping input ranges for damon_set_regions()
Date: Thu, 30 Jul 2026 22:39:42 -0400
Message-ID: <20260730203620.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730012100.139829-1-sj@kernel.org>
References: <2026072945-freezable-opossum-1bd2@gregkh> <20260730012100.139829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 06:20:58PM -0700, SJ Park wrote:
>Fix the problems by checking the assumption and returning an error if
>the input ranges don't meet the assumption.

Queued for 6.1, thanks. Applied after the range validation patch, as
you noted.

-- 
Thanks,
Sasha
