Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009C3D6682
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985606; cv=none; b=tl6otwoHnH/ZDDdrygMcLDLoPcgaq6TxguptZuqCbAJB+GTMqvjpkQaFgrEXkLh9/NCzNJUgT4ZOiZ3D3qLm+Nhx6JtZzI8zipLHjPXmZ2yV5GO2+3IZ8CTzn6Q4GK8UUCc9vy/U8+HncvZG+relynkV4zoQ3sJXO853eJ6v+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985606; c=relaxed/simple;
	bh=0qQ9LgR9ga6ktXk7B5VyDLMA4tP0qrUcoszPBAVUNl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbadJ1pnczM14kaOZl+d78LZDrUUNxGIeXH0BUNJAWLNMnJlsbDCkh3sWpOaMe2EEC80L5RJL/5XKUWQ4VTSeq5/PigAIOcm6Hm4Ec96cAYk0T2RvbSrl986HhBaPb7EIM2avTwrf78cCTEguRHH/20MwJeFKXSPO/zy1Cf6Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwetpJwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwetpJwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA461F00898;
	Wed,  9 Sep 2026 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985600;
	bh=oK8vXIkNWpyXqwOXOmM9TD+YHrH5B5HFfY+NiZAtFns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwetpJwTXUdzP5WGuhVO+kRD44c2ithPVm1g5gVJwtlHpj/iIZh8q/zXM3QGrwhbp
	 1DLabDAjiHTrVmSMUvqZa2SmeO1wIWN8g4mY2Dkga3Tt5EbylDN13gX5JI3a+WzY+Z
	 pCWjgePhl3W3QU4Ui6Xk+uyYN8xu3M+oUfgPviGv5fxDGksvTNko2AAmFjb6hiMsqJ
	 5WnkXGE2sbuCXEZvXgkKDGDFeV9f+jQ7f0G7q+dsHe0dWVQOm4Pr8bNTy4xMtRqd51
	 rFe0cVrIh4Lq49yBBAREwyVCsq05RvPzteS2hliGJsiKJYGrB5clEe/ovaYUf2NiAK
	 l1zl72GS9tRkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6.1.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 16:26:03 -0400
Message-ID: <2026-09-09-daily-reply-0005-nvmet-auth-sq-teardown-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909124335.1794480-1-hnkz.64@gmail.com>
References: <20260909124335.1794480-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nvmet_auth_sq_free() cancels auth_expired_work with
> cancel_delayed_work(). If the work has already started, cancellation does
> not wait for the callback. Transport teardown can consequently free or
> reuse the queue containing struct nvmet_sq while
> nvmet_auth_expired_work() still accesses that SQ.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
