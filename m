Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15862D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941247; cv=none; b=BxbI/AoW5mVYk9yEWcFeryOKspQvI6iQC5dyDTik1sWwauIh//EVB+3660b7PILjOBJe5ZgGIsUgorJHobwWFUoliKkVij3btgJZ0brc2OspPbbu9hAQ+FnIXzeFst9avHRJapM0u8AAqM64rO3LQtUTApw4bdDAaOW59leXTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941247; c=relaxed/simple;
	bh=5nU53GOFX1YajZ+fDCmRyji1Tyq1PmY/e6c6dVEL4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6JS7QmXTk/ljwvJa/i9xNvQkeNOzM8+BNhQzCjnD9lQH97en1786yF2QV1zyLWq6H8SnkwQw0S4fSWiyuw7hRyl/EvHtNWhIRSFuyJIa+Wu/TY9AAM+3wsVLR8S7Gtsoe+5u172cqPVChW+ibPf2p6MCvdjW9qTcUVJInbKqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq092qWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq092qWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B67D1F00898;
	Wed, 14 Oct 2026 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941246;
	bh=YAcxxhysIGsx40mjNwyBLaUYASfRmoRjCW3bF7kVEwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sq092qWigFclG12z6YVJSYNf6WSfILd7mvW4XmitM0e82o2WSqdecaaYFWA+e+v1C
	 Qj3tSny0O0J4NyYELWL3zqVj6z1BJxYqIrq90ryPC5Py30RnoTDYFS10XCQTnbLyfy
	 JSaSLgGSAWYQ44ILdGUeZMgE7ulWF6OTyM9wNkjgnbmzyUjMyP593nKDoGw/dtmR+k
	 /SWTbRS5/3HslJH9GWjdoeoykTCoOptQ6+bnoGINU+itA97H3+ij5HlHDYbz/fbqL4
	 r4HK3yXd1GkGNQl7XKErTL5NK2Aw5Ave11VrknyDXcspWZJFUepHZsFfUNXV3z5m5E
	 7yTsmdGhvkz7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.15.y 0/8] Few stable backports for CVE fixes
Date: Tue, 13 Oct 2026 21:26:56 -0400
Message-ID: <2026-10-13-1-daily-reply-0005-5-15-cve-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
References: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We have backported some upstream fixes to stable kernel 5.15.y, based on
> v5.15.222.

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
