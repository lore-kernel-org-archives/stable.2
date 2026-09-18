Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A1395AD3
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760759; cv=none; b=dT2D1UWjhcPN5DZuvFJhLQhNk0OGkIJbWjcBM24KvC4LTmTfNfOEX8FDQrZsEr9Q7tvlrBBAhmqCV6LnCfBQnoS+P3gmfxp0fatxo0V87XL3knRbyuevGohgQgwuo4KNqaLwSy6dcKfikvaU4ebzxE26Aifqi28BDGSKnm4WVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760759; c=relaxed/simple;
	bh=yUtttVQXGkT7DsVjd+ySfJDMA9pugAaRDX1AkXftSJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3ITX/jZwCrgP5u2uukgWg9UqiQLLK9SpQ408NOYPmd1o/eTL8DAl3wJZxKmkGk+8HpnNA6Zg+Ax6XbzpQnn++8BH0nexBTpERvGBDP9DA9hGeNaH8HO/grtE+GeTylOWPe+kcFpaYbf5IuSwaOfqchwMBxxAT2oIwmPr0oD2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObNdInAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObNdInAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2F1F0089A;
	Fri, 18 Sep 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760757;
	bh=ZfMfgAT3Q//kkPgS8mH2ppdEVyRc3YRrVIPUefFOFsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ObNdInAe2A1HhnnUS8d0C5uZ0mh50zds8Qv0DZjPjyphrx8dfl/b7P5oFydEVd2/i
	 7j77p5U2T5c39AGxhIYpkiBOKfPNXbDCAtXyYU9eM+aAv/EB88HcAruWBRFOPIJ13d
	 ixWfRK0TLoRxN/rQbjJskndplt08hcj7QeBGtQWVP3tGijqoX+pW0mIq7EobqUG3Iy
	 CVgKTAYk34cvn1bCGUMrl2Y9M+XkQ5knzsufhaDw27JIwOKup8eBzXJFyVoWjbBGNW
	 YKXyuguQLv/5MqMHlHCSS5313P+AAExvsE24F4pXyXh+fJMhUcEZX/G36XaJBJzr5y
	 BZzBrJpTEJKlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Jann Horn <jannh@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>
Subject: Re: [PATCH 6.1.y] af_unix: Fix peek then tail dereference UAF in unix_stream_data_wait()
Date: Fri, 18 Sep 2026 15:45:37 -0400
Message-ID: <2026-09-18-daily-reply-0010-re-af-unix-peek-tail-uaf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <16dd5af86510d1fed6e9dc9aaa4b1e350e0087d8.1789702442.git.jamie.bainbridge@gmail.com>
References: <16dd5af86510d1fed6e9dc9aaa4b1e350e0087d8.1789702442.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Linux mainline commit be309f8eae8b ("af_unix: Fix UAF read of tail->len
> in unix_stream_data_wait()") describes a UAF which it fixes by removing
> the offending tail->len dereference. This was assigned CVE-2026-64109.

This is a stable-only fix with no upstream equivalent for 6.1, since
mainline deletes the tail->len read instead and that change is documented
as unsuitable before 6.5. I would rather have the af_unix maintainer ack
the approach before I queue it.

Kuniyuki, does taking the receive queue lock around the peek look right to
you for 6.1 and older?

> Cc: stable@vger.kernel.org # 6.1.x
> Cc: stable@vger.kernel.org # 5.15.x
> Cc: stable@vger.kernel.org # 5.10.x

The diff does not apply at full context on 5.15 or 5.10. Could you send
the variants for those two trees?

-- 
Thanks,
Sasha
