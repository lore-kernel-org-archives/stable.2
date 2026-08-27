Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A530566F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807888; cv=none; b=s093t6DcMBCKrl+BddLIY3wc4qSC6MIzWtW7CAPRADlGAGSemY/VCym9FafFM2/W44Um1oWZbspnnBY3jSAat7VN5We+dysiR676dbjSfwLwW0ntHDy2RRGAnHBWQPiIvFCjuQ0bTKyGE89EgbA29wOhdIVRGXm61BxjVZsw21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807888; c=relaxed/simple;
	bh=d5Js2DHjuoa1c0ngsQ6EVCQhqdb4GMiyq5CC8Or7UtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvmFjsKo335gdpP9rz4i7f3Lc/xIBeKKKF03nWGZYN8IlQ0QcU/zoBJNvmoeRQb/X9TFP8yWkFLd+yRN2D67ujqlbgQX92xb0hWrAlct1ZpYNBQEozUaphDWCOIJaEKhBXe5XYWwe4G52BZfGOo3h3ZM7WAp5j4eG8x6JtP9T+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep8v0lTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep8v0lTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F21F00A3E;
	Thu, 27 Aug 2026 05:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807887;
	bh=sOXk0K2hrR3SDmSUYSgUFTxey95sVImtvM6Mf9GvKWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ep8v0lTp943YEv579Ls8FO5hhV8M8am6l4QKJkXTVqmHB8h3cdBX7OEFlVUYytPNj
	 a6qz9HtNZEa7fzJ+pIlDOz2pEPeTqwiWTC+9eYLI/44dHFjXk7vLY67hVn4uB4wEet
	 YWiknZXcyoTRyo/r9uxCBALAosG5yCzawI7efoSSfNs6shEgl0sQv1qM+UtgHWlZqP
	 xMpAEGGH08GAcRE3VN1cp6XKrZe7fX/ePlPW6X3B+bVswhDw6kzbalbSVjW4a6PZhF
	 Pw2hCqIGyrZKCn2Da4yMRS2lqjaeoY1WcSz/WtORXnWQteGLJ4tB0+62b1wuTTt5vJ
	 IiUHqUQsoMJcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 5.10.y] RDMA/rxe: Fix OOB in free_rd_atomic_resources()
Date: Thu, 27 Aug 2026 01:17:56 -0400
Message-ID: <20260827050834.10006.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825201450.1688478-1-yanjun.zhu@linux.dev>
References: <20260825201450.1688478-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> free_rd_atomic_resources() iterates using qp->attr.max_dest_rd_atomic.
> Updating max_dest_rd_atomic before freeing the old array can make the
> free path walk past the old allocation and trigger a slab out-of-bounds
> write catched by KASAN:

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
