Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903966;
	b=guXsNDP84PGEqIpra1mxjPm67A9YxgQRJS2QQn91YVWQg+t24+h7U2VTZ0SxSQFr7u2H
	 2xqHk7oHbF7EHhJTuLJDxqbyry9yvQMhyIMRWlQZbtsC52ViuK+epc+gBGMNulQmTjDKS
	 5GbU0QTDYup3EsNptCuHf3MtnjqEfAgEoT1vZGs5G4QdJM2Lx3cv98+KhlIVREYKrpzQu
	 /uhhxPLP+SRsvFbj6TFDO0glXzDJVg5PFw6Pdo++tWOhGberM+Hv8R93S+SzVwT0bI6sC
	 FHGRyI4eHgzI0AV4/VPSX7YIMLzCq9LlF8LnS0Wis903gqFxnXqyjFUe8EPTIuc0wvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GoohItUOO5zf4oFiIvz6JhAxH1uPXDxOuR3GAhYqZCs=;
	b=oPORUIKi5VGTajBE3psc7nponfyJfZ2ETLoj7w/yqOhPz2SVQ8oy7eoof6CvRaswoKfR
	 FFmTIZ2xJvT39YZMjyco67MuKtqtWDdj7Cg5ihv648JZVWKzVyxn6GIRHlQhwQIY159P4
	 FKARlkuxu3Xd1uOkFENj6leOlgUZUH/NsPon64VU8kl9e/xxnVRI8T3XkbWF+SyI2YDh2
	 5jEd+g/aNRapnaaMPLtN2sm6DTK8Kb6rYdEq7d42vA5VB+cEcGTwkBL1lv/UI+ryIi4l6
	 +2W7h5iU+v1O63RLWZnj/w2vYPr4ncTqkTl72kZMhl9KZBQyMvp2EQ4zl1mrgvs30aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlunmwIv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77C606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlunmwIv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5601F000C1;
	Thu,  5 Nov 2026 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903965;
	bh=GoohItUOO5zf4oFiIvz6JhAxH1uPXDxOuR3GAhYqZCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GlunmwIvahAV5D/tOJ6ggOv1UKPHWyiuvZSfOA8vhF1bp397An/HH6A2xG3YY9poi
	 MXpwubHa6vk+4yfAK4DdlgD9TZ8oxMlPWeglNOKLkVdHQ9uHi9nlic6KcvcDozoUcb
	 XuVGPJ8zIcJomHmYi555IAiT0O7MSZFm/tbpD7wqDxRTvURSDT5XrDIABJRDmc2eir
	 kyden8duTviAQV71AKrmEqAuqq9O9lz+ffk+c2NffQtXA2zjETfLOndwoqO7CYNB94
	 E5lMHAiKlMokP09w97F/9/xeWVfiRQ5euYi1jMWCWLSUAItT6NNu3xzRXly12vG9Bd
	 E714lHDgfHs1w==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.12.y] ovl: hold a reference on the parent in readdir
Date: Thu,  5 Nov 2026 13:39:10 -0500
Message-ID: <2026-11-05-1-daily-reply-0005-ovl-readdir-parent@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOQ4uxghyqkUkabY5-rcwUrUq190Mvh36zgQBJ6EwYsnAiDtrA@mail.gmail.com>
References: <2026110447-widen-reunite-2c7b@gregkh> <20261105025023.1204346-1-sashal@kernel.org> <CAOQ4uxghyqkUkabY5-rcwUrUq190Mvh36zgQBJ6EwYsnAiDtrA@mail.gmail.com>
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

> I had already asked Greg to take my 6.18 backport to 6.12..6.1:
>
> It'd be a shame to have different backports when we can use the same
> version to all.

Agreed, but your 6.18 series does not apply to 6.12, 6.6 or 6.1 as sent:
patches 1 and 3 fail on all three, and patch 2 only applies with reduced
context on 6.12 and 6.6 and fails on 6.1.

Could you send per-tree backports for 6.12, 6.6 and 6.1? I am not applying my
6.12 version.

-- 
Thanks,
Sasha
