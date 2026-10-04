Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C0330D24
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131429; cv=none; b=K8WoDeiAZdlmp/UMvMA+ilAqgOvGmceKb7TZxOiXufG1k5ha03tfyMkSKrbze02/n6H1KfUibaNg/5t8EpcXta8vUBHZn6hw2VdUv+61LTTGPZuySo6eK57SskhbCQwO677haxCyw1UW5MuRTmzCYv09gpxG/YpT7ULmtly2QS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131429; c=relaxed/simple;
	bh=PlrN4KgpuWeNcwFhrngZqVI154v6CVWMREBg32RUXIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkyOo/L6YnI98g/E/jYwRKH47hh3JVaOez39nVWSALfe/nv3hbF1wADvwDDR6vlng6jK7DcKylCi+44EMpZGUVlgEPgRBKiH6t8z7cfXhJ0s7VqTEiiCk+cJCFe5EO5TIdo97N2nxiIPJ9TssWFJtq73R7sJ1rQRPoFgZZhffbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS9VLNu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS9VLNu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EDA1F000FF;
	Sun,  4 Oct 2026 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131428;
	bh=WAQCWRj4aFr3UmdeJpbIV0bQB3YBwLMP8aIVJSy3Iwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AS9VLNu2X528q4978Ni74lZo9OV8SaOZJftRYD/kIsxu3eiMV/J1Q1/coDqMK7zNh
	 MY2KJ1GLKaeWzlC3yTu7oCUaCm/bENU5WRssYB3zLLqcJvFgEN0EIuwDP+PxPIox2E
	 aTmKjiCYatbYdNwA+k/I38gF5EyE3yFO9Kix579wTu4FQhbDgXaEtOtyb43Gl4/5A6
	 3TUXcJpFEoeydUozuAt9mW8CWyJ//EOFwgtfRIvUhxXKHaX6W3CYg+m+nkS8gvk4br
	 /BtmUoghZORU5kk4aQYuXjEc5oaO6Qfov7WPVm/y5Eo8OF+eFXrTFCQUIvBgqudHhf
	 K+RG7TAouB4MA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Sun,  4 Oct 2026 12:29:50 -0400
Message-ID: <2026-10-04-1-daily-reply-0012-hugetlb-avoid-reserve-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926071811.77481-1-kmehltretter@gmail.com>
References: <20260926071811.77481-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 58db7c5fbe7daa42098d4965133a864f98ba90ba upstream.

Peter, Oscar: I will queue all four backports (6.6, 6.1, 5.15 and 5.10) on
October 9 unless someone objects before then.

-- 
Thanks,
Sasha
