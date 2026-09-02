Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2828030E;
	Wed,  2 Sep 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311701; cv=none; b=BXuYqoCI2Ntz0MJSTRGTWnn8QLxUzqJuRM9N7P55jn6lss6xKFI5jfSx94ahHKgxcy+a8Ji9iMTzJwxyEUK2RbaRkOxv90jFe09bQSe/rjURSXtZuZYBu4qnfHoo50Ap+AoA+B8voBeUyUhCW09AtzWewVkO8KeroV9jTP5vUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311701; c=relaxed/simple;
	bh=C6S73FgGre94oX3rKPJ3TrmDQgmdH3HbLfZwYYSWC58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmLhkaqp0CXvyoeD7MJW1FG4j1qrD3dxCOAoW0vDXzHKNuh/8GWY7cFWxSf6lwBqQtUqxokzWvXeuj2l1xwPtSb6tnHIyZ1Hi+ItP6CAksigQKBdFDzUDFCFT1o/2XeNQARXoBZr72KH05fbnVIBgScH3PCZJYpH6aZKVJxbLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab1Cvvp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab1Cvvp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7A61F000E9;
	Wed,  2 Sep 2026 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311699;
	bh=LWD6z9u9UnNJ/yqZUYiAG+61P0xgSe+8m+TyxTenT4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ab1Cvvp5MF4/ezK285KCgyRKwOFbw7GLHbssjuC85Dql3pcnlpJulqyflGciaKKpK
	 WdHhNvkd3BkE7WTon0fTl9xO573xJghgsVsnwjW7/fKVpUtgpcF0KJ3rH2NK/wS3ta
	 zVdibKigyuPtTVRbQXMNBj5UCIISCEnWXiq85OiiGH3zFmYY3JdOXMQQeP5pQcwwOv
	 2jsz4UfgpmzsVIOwMwMZKQK6y29/XEEzLTNd5fgvBnm6J4hfRIUKi4PwcmpSuu2OCf
	 kgaUeOyNtEKRaupOxHSFZae5GntiV69+ukzZh5RoXg72Zcpe+Fbe+YzOfsE2uNmu4F
	 eryo72PTIIqeQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Tue,  1 Sep 2026 18:14:51 -0700
Message-ID: <20260902011452.110186-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902002725.108635-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:22 -0700 SJ Park <sj@kernel.org> wrote:

> damos_commit_quota_goal_union() is not updating the ->nid union field
> when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a

Sashiko found the above typo.  It needs 's/QUITA/QUOTA/'.  Andrew, could you
please do that when you pick this patch?  Please feel free to let me know if
you prefer repositing.


Thanks,
SJ

[...]
