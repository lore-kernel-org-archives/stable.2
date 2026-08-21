Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D7351C22
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286823; cv=none; b=kbdjuYNGk08n1KLOulNEiWyOL41SQxCgeYfXpyCSs239fsuzE8mDBNlXqpc6e8nxNslS/lIwFlzXo51AuQy/5SAIfIjBnQ3SHyGVFA+VJ5+jTIA1nmrq/FCKHwh35n7n2Quaa5JyNvVSdbXSA+EcVa5P9675nwPRIq0m/NnQsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286823; c=relaxed/simple;
	bh=YOe+5cst6g5jVYodlyxSSKf0FAjJTLy+63AbY+ZR4KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fpj8LQfdlN4k7qns4rpMCfw66iNEza5Y4H6G3u3nfAZyt73HzYhhdJzBCfjgka36GEtjL49rq04v73aEkDOBDmhtRq4DcW9gd+qiKS79eWcal9LU5i1t12uPCRrwgvulokZCQrsGJcpE2WfTLxMHc1e4STFzSOuua8NzT/BqJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Xsz7eM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Xsz7eM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6A31F000E9;
	Fri, 21 Aug 2026 04:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286821;
	bh=BVe09rXIOSGtLsKlX1/Z/hB8CERAO7794u3pZt8DzNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/Xsz7eMwQtwHYo0QnQIL0H+2vO9FLrmgjrpWOtTgfLcTMGRHFSbszyN1Tni/vVxN
	 GuircwGUYqaxYO86Qkb2upk5edXBihx6iOfOgJLK6D44S1JLxSaeHt/NnrVR8YxXvX
	 Pf1ttaANYOiObpJ7uu0PzMVm7WR+qmWoUTeXV/P4IrCLX2xvgyIfRJLGhn8ujLH77d
	 umA9NCbzLqFJIhCD9tuQlO/6Iedr+4NLZMYJvm1sWPhVcmH117QPvWqMPmO49e7YAw
	 sd7BzM2f0UezvV+Y1mG8oxgvSu2Pvg6EZxBkre7QjFvvpmcUH4ovXdTNBE0UczEGqR
	 PlITANHPqqE9A==
From: Sasha Levin <sashal@kernel.org>
To: Hyokyung Kim <pulpannie@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y] virtio_net: clamp rss_indir_table_size to VIRTIO_NET_RSS_MAX_TABLE_LEN
Date: Fri, 21 Aug 2026 00:33:34 -0400
Message-ID: <20260821-stable-item009-virtio-rss-clamp@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082033-driven-tumbling-f69d@gregkh>
References: <2026082033-driven-tumbling-f69d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why is it "too large"?  Again, we want to keep as close as possible to
> upstream as diverging will cause bugs and maintenance problems over
> time.

The question is moot now - this one can just be dropped from the queue.

Hyokyung followed up with an upstream-shaped backport of 86a48a00efdf
("virtio_net: Support dynamic rss indirection table size"), and that already
shipped in 6.1.178 and 6.6.145.

-- 
Thanks,
Sasha
