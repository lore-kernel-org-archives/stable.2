Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD22340A6A;
	Wed,  2 Sep 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311066; cv=none; b=O3cE3EGKPOZ5qitXo/tMFe6jTv7fUezjFGmGhPBqIvIeohr4kzrCgZlBqoX6fvwcjkzX8xqBk4wi8838PJ+SollUaqGsCh2bPV750sADWA1lgyM0nMcY9j3V/XvNK3n6oJmuU3Q6i9IZKa8a8+dNtO+hYRrTlgHVielTmtS4GiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311066; c=relaxed/simple;
	bh=Pg3dHLA5He7k+8TRj2wxCsDSz/asKN23Oy1XqtrBO5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea9/uky8FaOWJbHJHPK8E1webgtA+QHDRAQ/NndRSC7hbSC+uDqFXTh3qKsVl9gLzTtpOAdn7nEoMb0TDqlJpjUuoczRBfTrcixeXSMuGy6bpnsZlCoPCecyMvD4dfobuNXMi4TlrrqE/pa+WlI+d4PxA4EioJxYfnrwHu+d/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtFMi347; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtFMi347"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6DB1F000E9;
	Wed,  2 Sep 2026 01:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311065;
	bh=Di+0IBh6tLmVqnPdTQZVJOnFu1lqBzd2k5DnV3cMywo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtFMi3479qMs5alvGgR9GLqx37YivkxohtOlpbk+IeZ7HqpglQ1UCHej5hEcebuFj
	 4LfYBJJsxBHHtgRFwvZNcL5Llr+uh2RWnlABbCY0vNilX+gFLDIL5wwzS0C12WAtgd
	 miKvr4cL/Pd6J3wAe0UqA7F7hhVVigWF0whEPSFm3DXOXDYMNRDuAIV0X0wOqJv50R
	 kGK4o2/TQERIj7sl+4sMEIZ3azo98OWKRdP4hw6pfY2ui/wxpZH5IN+KHNgDHQSG2Q
	 cZqoaM6YvqpLmgiO9zArfpl1j1m1jxn053/Zl0zKXmkIBHZrpRpJkhfIUMQk/x5psD
	 kpOReVJ1SjbKw==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix quota could not be set to zero
Date: Tue,  1 Sep 2026 18:04:17 -0700
Message-ID: <20260902010418.109621-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901105951.106246-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,


Seems Sashiko found something and you are planning to revision this patch that.
I will hold review until the next version is posted.  Same for your other patch
that sent in the same time.


Thanks,
SJ

[...]
