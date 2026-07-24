Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581A3D9551;
	Fri, 24 Jul 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903200; cv=none; b=r1I3+7UYJ0xsTkzeULxVW6GiwSBCczur8tRpmAoJBoORdStuHa520CpeuZZxbcezt/Fs49lvTG1KX7W29m9sDLihIAZ7ngdFYb+5Lv7dTxnjxnvUo8X/vqXxE2BCznI+m8obwWl5hwnU/f0ykpDMOJLUGDzBAg4/WHkyDaksVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903200; c=relaxed/simple;
	bh=eYKCRP6Xa6djvBULOEjoCmC/F7JWjgTfN9qLLnRLSHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7XjlWeOabQOF+8r5drIob4GTeOOiSGVq4nVENiMRPrv4IcYW00Wc1KIHhExVsPwO24ObMrnliMFNn2HD4qidKomd5HMYGQuewaLukMwR2sl5bEbrCoMy6QFyHyPX/b3fZ5eJI9DOgvPFcHteibDrnc3DKBqeKdkXX/8/4H2Qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dux/sLHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dux/sLHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF571F000E9;
	Fri, 24 Jul 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903198;
	bh=r+VsBrgqmMgnylKKDE6sUiG3OINTfUBlUudCXfXiTsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dux/sLHMsptGYjDdSOys+5saGrO2hY0qqeWGU3tmR/m7AGZ09iWI3QyQkv/Oiw6gD
	 fj7ZL5QmfI6mRfwvp3SH3xU2M/Ae9cp0BgBXoxiqynYA17VdVmVZA+YbuQVpd4WbNH
	 gQz4qgRy47s4iPrR29Bd9FW0THbXlGx/QPUxiMCeeWHIGPg8esCeGQ9DvZXjZ7qCE8
	 uHjFATxoPIMSKWq9oDh7Ar9gUFfaJ+SfSBiMxoWYyZxLCjAFmaY3I0vvqMinwEifjX
	 pJuWE8zSXdOxkOPiR1qcaz5pYxZ5Y75l9xFEQnhEK+xkXSqc6qUcKJK6PJuYNHbovW
	 5aeimj+qt1HOw==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Fri, 24 Jul 2026 07:26:34 -0700
Message-ID: <20260724142635.93839-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724060135.3014676-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


'checkpatch.pl --nogit --nogit-fallback' suggests adding below recipients.  I
added them.  Please consider using get_maintainer.pl from next time.

- Joshua Hahn <joshua.hahnjy@gmail.com>
- linux-mm@kvack.org
- linux-kernel@vger.kernel.org


On Fri, 24 Jul 2026 14:01:34 +0800 dayou5941@163.com wrote:

> From: liyouhong <liyouhong@kylinos.cn>
> 
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid (including
> the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> without putting the folios back to the LRU.
> 
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.
> 
> Put the folios back on the invalid-nid path so ignored migration requests
> still return them to the LRU.

Thank you for finding and fixing this!

> 
> Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Cursor:grok-4.5
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
