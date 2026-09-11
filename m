Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F033D4116;
	Fri, 11 Sep 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125712; cv=none; b=HQP5tne/EB0NzkmS08PdtXO4klYGkjfYTTsRApaCSg3bYn6/IaCw+CpC7yp1UVB0A4cEnkRy7w0jhnlERCORqRgxchNRIyC5mz18ps2omrR4eRPP334X9C4Nhp63gvqr9h7Fcbhx22kpVRJWakdf53QPg4rURyiOnUMd3bhGHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125712; c=relaxed/simple;
	bh=5SXto4QRldbwjvYS8NRoywRe9w/ECZ5cVf6CKa+a8as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxtsWuREvm4ACYm5Qd6sWRe/BnbJ7HQ4sDktjh7R+FvP6vP2DudelcdJzbszik1IDSZghxj0wpEbCG7/51EvJn07mndy9APupdVKOs0jd4s8uEwdGaBq+ACWocSNz5SzHcRP+mJNKTXXvleDQ924xJyrWEqa800Ta7LXXOLMjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWBiOctC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWBiOctC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0581F00893;
	Fri, 11 Sep 2026 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125700;
	bh=sYo3n0lLfLLWuEK6g+WP/WPIAjStQP1ZIANqVYbDZQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWBiOctCR73LTmgrsOE8jW2lT3CBz5DttkV8GjLpWNkGT5XbRddr6MSqPUEB5ZUBB
	 Erk6/v/hEecSPbJezctYNmspP98emF/IJvGzTmO9g51d3NN2aZydvi1yDmf6aIKhJE
	 xypgKDJQTpfsch5KwowuYaAq9evJdsy4p/H//dyEQyg6uvRc0KWzTgUX1GPiBUDGUs
	 bc2ZRjq4P09IEXweTbtYGQxK9cElKOoD92lftvkYhXMpUaT4teSWQteYdBsSFTqQM+
	 gBS90SUrzt0thzqp15Nsdh1kmKM7XxAfevuKuDibZuhOyuTfJKCuK8aonGPVV6uDb6
	 hNWhHjT3rfekQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Fri, 11 Sep 2026 07:21:00 -0400
Message-ID: <daily-reply-0041-re-damon-skip-aging-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909044433.218263-1-sj@kernel.org>
References: <20260909044433.218263-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
