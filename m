Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A5279907;
	Thu, 27 Aug 2026 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805782; cv=none; b=rjuzG/gRu3Yn4SIngm+8Z6/83IqsktOdc/nw+Mz/25savIy9+NhWAlQJcNzGz9EUEp2v9E0MPEucUNaWGKf5qcATYZaXolR3K/aCH4HHKFwHlKhJf1T1AoZmLe+HFL/a+XIM4m6IxwNNt6MESAR/osfd1hFB7eX/QMk6I9Fwi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805782; c=relaxed/simple;
	bh=f1FhOXqiy7+iwtdX8Oz3wYnbCKC1tg9Y65Ck213usu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q82FoAim+eMreMBcVqyVJpVSv6IZ28HSheeVYulnk7CQ5X8hZpcdEXe65lfujSZaBlDcXb+6OKjNogXz/Aw7xvrRMuI4HqcumeYEVhv5Tjmp2h38SFdY4tD842U8k7vjSpOR1lqL/lwb/lNn3gzjRjAfYf51aMh7NWdLBu1Jris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvqjgOj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvqjgOj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657F1F000E9;
	Thu, 27 Aug 2026 04:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805781;
	bh=s5YZ+GuJeRRZH1agj7KcIAS0ia4/0OkA85eBYTvNaP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvqjgOj1EeO3PkjRlYBNA0v5ab+DZndSPRhb5IcJAffJjXlfz6SB9s4xsE5i+GLMq
	 BVgzbIg5YiXTLph2KxJ8eqGjPZCAzV5EuiNFHHV0m9fez8UGqV9p3F2rlmV3k8eHLt
	 wxrAo1EA6qeAjFCagOD6FIATbl7j1BM9PedMPiLUDGgCdszNNTf83hiPb2GbmFp2I7
	 +HNlQXYMClTpl5XQXLUrbgNt49IUL0853m9S8uG+cDysuF8ApjDFUuIb/Q8iZG3Vem
	 f3wCaZ+FIelR8eODNQ07WVzyvEvNxKxsfeXOoAKJpJ0zSqLCadezmJoe389kiqk/XI
	 m7i+C831kMuxQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm/damon: fix wrong behaviors in DAMOS PSI goal and sysfs refresh_ms
Date: Wed, 26 Aug 2026 21:42:53 -0700
Message-ID: <20260827044253.94417-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827042920.93580-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My intention was to send this as an RFC series.  I forgot adding 'RFC' tag by a
mistake.  Sorry for noise.  Andrew, could you please drop this series from
mm-new for now?


Thanks,
SJ

[...]
