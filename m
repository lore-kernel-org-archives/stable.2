Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180845;
	b=CEUcQS+IgzSjOl2LI8+bgdK9pjniT6BsJgfbmcGtzscrq29NhRWnGl3HLdmUWtl2Ho9a
	 VPceo/tpdBoBdOdPfBMcYxJszWIWLUCFWbB5OhIw+ZlbJMYsdP0wjd5A7DGCEk0jqVN5j
	 WebMYxiIDrkemWIUuVLrP/85M7NwAe0OGk+2mwmAV1EzkbkAo+DHJvUiQTptv5gfTPJQJ
	 sfDTl9dAyEM+A0QelxxKYUEd5d3/wkNW/j6z1qml6Wu4zk/MFXa+WfB25Qz+aw3usSz6E
	 qESdjrtVNUkqDo/86ExAQZYn5thdOoFjp5R1hy1dQwnKiYQ+3HEeQDIO8oCQciVp2VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180845;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gkaq7y0t6W9u9ga0uuU7sK+gI9R+BYJHhIlyp2e/T7E=;
	b=ocYHlcY2uO20ivEGkjctkRkc/rf3hMvCQ9MPnswOiAg1hCFTQxrNwzuDAeF11nGYA7uk
	 53zNKNFuHPMq76YgbgWjjJchzSohlTKTbR1VwxjFrrKG0PF7OZc7/pb5pa9VhbB3lu5Wp
	 SN6n6M2QVRqm02FMa3r4KNPthmvSN7xqchMV7R0A17LLtG8fnn34YKpbpZLpZAq+IwyEg
	 dmQT05AhZwwsVnu4iluHrT5uzUJcgx5PD14Ty0qsT7gbNpGp0gntcBsmPzqLsvqMtggTj
	 gYo8SnQPRazgI6lDDFxo1IoJJ/2Fn6o5izN+gUmm70hKfSv+OMN0BuxczhZoW87CAfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=B+dnc40H;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC1606A320;
	Fri, 20 Nov 2026 13:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85DC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=B+dnc40H
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1795180837; bh=Gkaq7y0t6W9u9ga0uuU7sK+
	gI9R+BYJHhIlyp2e/T7E=; b=B+dnc40HTqT0Asf/fygoTtwvxSKN81ITvZTE+gl2xUSDC7Ha4Z
	TfagQ3bq2yD7fILjtHAW55d3JOX3GT8jzmFtqmBr5MIp3I970aobEKP6BP3/I9dPMXnCDcIYvpC
	xFBATnKzBNZJL3GYk5yMviN4GQSypYgC56e2u10zNa6x/xQMbbwP8o3wYMrg1IsaszlMeX586A7
	kni0jAb9OHEpqlxL2Q6PbPcjS3nzSoZvj4BARldMoSYxb98pRqd8KMjC7V00JSu6SUVGzbykNb0
	uzTn7FXKRzVXKX3P+ZXcGhoKMNKINgbNwowYPnfkH1pqaLnIilISPlBBEzW8KbOl2uw==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
To: dtatulea@nvidia.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nikolai@kalinidze.me
Subject: Re: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
Date: Fri, 20 Nov 2026 14:20:34 +0100
Message-ID: <20261120132034.1337770-1-vladimir@dfb.sh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <d4f67696-5095-4948-9029-f657058431b0@nvidia.com>
References: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh> <20261119101523-mutt-send-email-mst@kernel.org> <d4f67696-5095-4948-9029-f657058431b0@nvidia.com>
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

Thank you for the comments!

On 19.11.26 19:12, Dragos Tatulea wrote:
> Please make this paragraph more human friendly. Enough to say that
> the type doesn't fit the value or something like that.

> No need to say what the code does. Focus on the why.

Shortened both in v2.

> Yes The limit is right.

Thanks.

> Comment not needed.

Dropped.

> Unrelated change for fix. Drop please.

Dropped. The command then keeps today's limit: kzalloc() caps it at
KMALLOC_MAX_SIZE, 4 MiB with 4K pages, which holds fewer than 2^18
KLMs. On a device with log_max_klm_list_size above 18, a guest map
that needs more KLMs than that fails with -ENOMEM and a one-time
warning from the page allocator. Do devices report more than 18? If
so, I will send kvzalloc() as a separate patch.

> Why not DIV_ROUND_UP_POW2(map->start - pe, MAX_KLM_SIZE)?

I missed that it exists. v2 uses it.

> Use mlx5_vdpa_warn(). Rate limiting here won't help: the other prints
> will trigger.

Done.

Vladimir
