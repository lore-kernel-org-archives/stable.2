Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961373;
	b=EqQrkIhu0B3s27wXPB9knUpAwpYC9ZXrN1+/nCgtMf2nZwZnCXhLc6cFjGjEwNJvEe9K
	 Xwgp9k6nczsKkMPKGB1C0hxJkwbvpetK2Wd36/EHZ/9oZ7ETMdDqAYEm1KpIkqiTW0+w2
	 nEbbz7hevsOFXp0vkfKlcyptOJ6hTpV122Z93k9CKsEeQqbzEApyWLgpZAIf3W0FJ46Ft
	 pvKRUxxP4QFmema/LE/u85b/00CCLW8mj1Ud7zPuAxrlp4pdQK7s2qk4EXxBF6ABO4z7m
	 WP2EgyfwHw/FZ9l21xLbtou3QIi/Pz/4ulq1pG+U9wbNsSXFKRKXyjy14EtRH0mOL+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JRw6fEvSDbVhRU8qh+aETvS7Fbkzj3KZVD4IK2wFBqY=;
	b=Sm9+6Js6bvHU6yd9A1VfsDwys78kwoSFxHvK1UXHiXW0NmbMuTdNDHX/rOuN9ATP1Iy+
	 oExVQNXHLZ+sUr+7t0hO50JSapxwK2GPmt2iYbz6anGia6bFfq2WKDQclM3n0pgl+ccF9
	 XMuuWm/lZFpGKEe1MElmEtuckybSJV9YqskFxsxwQJ4oJzSua9C/ABhR5tUJZ5mfOKuCa
	 WiyqWZGJZ1VVRtsKyoM6VrBIwAmelD4/z59SxUFHOzLanMPmqnNOz92x57iRNNlUEUs/i
	 g1Qe9LdV7M9jXghsj1OI1zvzAZMuexu7jLC7BAOoeWzmbSpD2GLB91QwNcBAHMFUb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdwaZMb4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39B606A32A;
	Wed, 18 Nov 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdwaZMb4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4161F000C4;
	Wed, 18 Nov 2026 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961373;
	bh=JRw6fEvSDbVhRU8qh+aETvS7Fbkzj3KZVD4IK2wFBqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdwaZMb41Dr3sv04GZVnGjckzwbg/sehBYDC9dmFCUjWmtVO+EiTp4J4s45P+khZL
	 UCahzLL42MXU12ywdBfCrXPFhGP9An8DYILkAVUTTMREIHqtADzsdw9HV8B7btfy/y
	 Iyn97cZZ0IizG1GH+O/uib7AAFqp6gZOC162nwpAwmV8VzGEP/84mp7dCY8qUC+qo5
	 0yeUEa8Pc2KF3p4wMmNTKv1YFnVhIy2e41ycU1RCksHOXsbjA8JZvewNrJjYSAMVF8
	 Ety645S097tDqS0HarWO2Vtte/fwbY2ElXgqjLueJvKnBN+XEJbP9bSXCQ1vdNsvxI
	 H63ujfIZ03r+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Mark Polyakov <mark@thundercompute.com>
Subject: Re: Backport request for 6.12.y: mm/damon/reclaim: use parameter context correctly
Date: Tue, 17 Nov 2026 19:22:50 -0500
Message-ID: <2026-11-17-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
References: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
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
Message-ID: <20261118002250.L5wk0sBY3Qu2EzVC7WmdJYVS2bxrl_adZ_GylXrcM6c@z>

> It seems 6.12 gets backports of most DAMON fixes but this one must
> have slipped through.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
