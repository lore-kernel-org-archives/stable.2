Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECE3C8C52;
	Tue,  6 Oct 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322568; cv=none; b=HEAGMyeHUzJ/8RO7lepRlfanNM/eLAqwzKDKQ4ZQapvcSE297xvyc9N4Uc5N13Z9JQeZCdcVZum939BeG+67hZVsw+/xnAy5wCVzyp0lsCLB2FM7WNXcLu3bXKotF+fzphSaRyluh6Buj6zEBlgnrlFXEzVznhZTUqBx3UbutWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322568; c=relaxed/simple;
	bh=wzNHqEJjWNi72fZg6cy5i4gnBrxb/M1yVd0cLJ+SVhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mooZDwiqtsUwCvL+/opooCMPfWZZWygbnJ+cAndavZvc0N2ZUuXH5dOPJcZKG+YJWPXLWNidIO5vzIHb09/QwBvNhydeYvaCOQFK0rKsjM+NDz6cATJm6f55NWTKlDmQC5sAzFL7kfb0oBSIu2A9Oe5P9rAwbU+jGZaYo7y9wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/dHxYeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/dHxYeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA911F0089B;
	Tue,  6 Oct 2026 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322567;
	bh=CBaaGXm2X2r+R/E5m2P3fbU4KMUvDVLEd+FSy+4Gwpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/dHxYeVY3hqRuGcSpFUO06PEnkce51tuns0LUJQ42O8YF7IbbyjpXaEqViWwOOO6
	 Yc6EP9R39iMQacmT8eFSRMveLu+Xf8i8CysRI6NmoOASv+QTrhe2NPVSxfoLAj4KQV
	 lonUZLs7K0xI4ShEQn/4BXO8QyW6Og6FF8lNHPmheRWC4K+ysm4zDS60EOXLUDxDme
	 7X9mfjwALPGOJ3JiRf4NnQ32+MjfxsK5nH4mYOjQZVUxY86OyeoNGRvGZ+5p3ToQRJ
	 223EK5fuNHmmK7GRytV1YGOKXkxhd3ZTA0z6ovKobyKKLEzZdSDRwYJy63aWJdcZOj
	 oUDJHmrl/whwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <ming.lei@canonical.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] loop: Fix use-after-free issues
Date: Tue,  6 Oct 2026 17:35:35 -0400
Message-ID: <2026-10-06-1-daily-reply-0003-loop-uaf-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-cve-2023-53111-v1-1-d844a2fc5e57@bootlin.com>
References: <20261005-cve-2023-53111-v1-1-d844a2fc5e57@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 9b0cb770f5d7b1ff40bea7ca385438ee94570eec ]
>
> do_req_filebacked() calls blk_mq_complete_request() synchronously or
> asynchronously when using asynchronous I/O unless memory allocation fails.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
