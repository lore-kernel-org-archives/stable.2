Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283B23183F;
	Sat, 15 Aug 2026 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761209; cv=none; b=rtPxBJMMIc0TGWd0u+e20oEObEUUCn69sFoNDUjtKfC045Z1zNPmYG+F+z1gS5QMYT92+7ihy1mHzBEA9RTa6XhTDU3fY4Xrps4ugh/gaLrAtNPqhXeIJvNM1XDyiwL/mbbanslI8GTx559Qdc5rqfKMaTgWHhS4Yiqbtf+J9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761209; c=relaxed/simple;
	bh=ml4F+sbIkuDjlBtGFoWi3+22h/YIw+/bCUoa+CZDqZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Na1dxrF5oNZME0gFYakCDafrKW8pyUDHpVeWH0kO8UBe+yxq7unFBbhLODU4VyXf2MK/jrTZ0u57oBdVk1HbFqIyhrbRqXObqrNewyq6cxAcfTE8/hHQsCLZH/3qCDpI9hWzV/u/H3ydRwCIwHIV2yWfw9awuTzEEQSIuCzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bitX7zpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bitX7zpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F9A1F00A3D;
	Sat, 15 Aug 2026 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761208;
	bh=Qgu2PA27AaJ+UNj18qtGrqo7K5saoymIzc4Q6Lr98Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bitX7zpfDyRRGBFOXYpxLQpGf2qnH9/iPdFO/cdGtOZARY9DCONjXyFRncFtDwpPW
	 thPBOn6pHmgZPUp5ZfAHoWVqekXgdbC2AMMscf7TQ1PzCuO9/tzlvDeNlE6VwX8mbS
	 cKBSqc7YOc+Q8jYIz4lLvmk+8muN9Fs2wRB3HAPWGhdysttaN6Xi9l2c4YmMtWztwu
	 4GHaBWpMKzY+Dh5SGpCp+Tc+ennCOsQ6A1FUiQWpLFL1oD36ZC2SxIhJLGUeLgJ2/n
	 My030XHQ+CMYZHuUV/bIjOZdiaEEsU9W3H4pjI8HdhsDNhSyPW4o1SOvMB4gChSn8m
	 O00G51bgV76Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.18.y 1/2] blk-mq: pop cached request if it is usable
Date: Fri, 14 Aug 2026 22:33:02 -0400
Message-ID: <20260814193000.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812112545.2630000-1-simonlie@amazon.de>
References: <20260812112545.2630000-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit dc278e9bf2b9513a763353e6b9cc21e0f532954e ]
>
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
