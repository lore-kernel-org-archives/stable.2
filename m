Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888546D543
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926655; cv=none; b=GY8ffH8s6MutHx1JHCJ6nQPyC9rQBuYHQJsP03kA/m8BW427MsN/Ru2Z9xewRJ+TxhyzEYQlNfvi4oLAgeq7gQfNGrZUaSGCAIYFic4PQYOnZKjB0PDZ4ptMNPaKBlb6d2UQjHjjwcUMlPFYhaYlBo6Dv4Hu6EMi7LkikX4+psI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926655; c=relaxed/simple;
	bh=cE3dreVchuyXl7ba9wI9mRF5T9GlzmWhL6pPb3FShpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgrY5YX3OMTNHiydt2S2bstWMcg7d06icdUpm1OSwhvKM342IFRB97NNlAdt8SffZl6JAvf9LMbt6ni5tPmdDOkJ4MipgGGsS0lJwFitaPm3D/2rTaLEzCDazpLJAWAEwd5NVtYjv9TATLKuHUTaauYLVrFkz5Pudj28+27ztAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjEjAU2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjEjAU2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F131F00898;
	Sun, 20 Sep 2026 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926653;
	bh=u9tC7KNlWPg/OeK6w6rk5GMKuOsMjZGiRKzrLiLMWWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjEjAU2+9RkGjqZ97yS7rvZa0H3wMpKoFRBHfuxy32gsj96zudIse4DvRmiFFezNq
	 8u1yq/0HoRgf4sSsttZr/xBO81PQC/q2QlKE0SEoqQf6Wqm6IeosYHYOpdY5e+OFkd
	 4D664oxElHI2Lnxtng7Z8UmY3nja68Wtgr1jNGAc7yy/E4eMD+ttxzyo6qAxIYBqQw
	 gVtoa0m1+HL68MqAtRhuvLBgzoaFl3L503YxMiftlVdW5u9hzrfEbDa50uBXTwhpkU
	 M5ixcQPoBcDPkq+4zcRyo9yctFHGP7rYuHbF2+jiyiOsPNaBS8rrz3i9lQ3VAGe34f
	 pmFukqATrCDFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 6.12.y 0/2] Porting two fixes for the cpsw Ethernet driver to the v6.12.y stable kernel
Date: Sun, 20 Sep 2026 13:50:37 -0400
Message-ID: <2026-09-20-daily-reply-0005-re-cpsw-rx-mode-work-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
References: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As requested by Sasha, both commits are now being ported together to the v6.12,
> v6.6, and v5.15 stable kernels. The two patches apply cleanly to v6.12.y.

Queued the series for 6.12, thanks.

6.6 and 5.15 still need their own versions. Neither tree has
disable_work_sync(), so the teardown in cpsw_unregister_ports() needs
adapting rather than a straight port. Could you send those when you get
a chance?

-- 
Thanks,
Sasha
