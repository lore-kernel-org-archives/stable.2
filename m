Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207182;
	b=QY7KjRzOor8NEZZXW7Wd6adyTX0ER66bshaH6/mjxHpt5ZJUhocO99YyKB+jGKhMredw
	 K7r5KcSQb1bNhn8Xjpvj6fBlVVBI3tZmHMYWTKGuMCF2FN33CAgbVN9xnKw4VqlPaMZz4
	 zTai/p+RQXq5cb6moXwlI2uHuy2+m4hVrCov7Aj1Vq/ti9974FaaBMsdMZ6OHrjCpGkJE
	 3Vf4NzcYOKT8NcqMgWcflOmLCMUWz6ntmDLFbJpKct7ktF6UNWrXV0+POhHFwyWeix4OE
	 sKFCkBKTkksIU4t7hhAFoPr1/PeJJ5TiO9JjABeuWkk0pGwniDYZ8SQjBir1kkveAuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QNiyc/NInGi5E7fHNAN8stDOl+ptjDz0exmAKyr+rjk=;
	b=0oA3xpRcg4rCJ3x20cetLqmXI1+n6JVelsJIGzooV32Uv16Qe3kNmiDmhNQHkFmyeYvL
	 +g1GaG77A2UkfoT8jutWkkqMZp0HjbxJluKjt+XCpHt/0j3gJ1Iz9o3v3JR9v4IVFaiAa
	 +l2V7WmdBYS6dvNevnbmY4uJUEnyFl0Q9bs74z60QjUtvVjr/5id+JjBYHo9gkesEDBmM
	 6s4m9nHklAlxn+TOpRbyYky61RuCgzCmHqDLdPTzJ2P3eGrW6qAdTh/qYb+T/2eaCg054
	 lXOZs0FX5iTiEoL3YYxt9Y6t4EBc2vPwjRZN9LeNs0np8/4fQooBEZF6/XgD7t6IqHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW4fxCLl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A52606A6C8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW4fxCLl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33251F000CA;
	Fri, 20 Nov 2026 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207182;
	bh=QNiyc/NInGi5E7fHNAN8stDOl+ptjDz0exmAKyr+rjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LW4fxCLlXgtglZgvr4xHkNDKpysftmWBto4i/40/sTU9AfOcw2eCADS8EMj790ZWr
	 07TKg3rtXneDJz9/ydCdT0DujGBBwP5aEY3ys8zmxk58BG4NEmNh6ilODyaY3x6ieR
	 dDilUvdYvkOKyHNfCzB4Z4yzuzuzd5FxFjZaL+3O5oomSPf6feEUVrNeHSUeLUKltG
	 rH8KPGvhaZ+3y8AsjggCUK6v8ZiC6hweyHOTe18X1rWSNeqU2O+ALzWU1oMnJN5o2a
	 0nlXg4wnc4uf7RMVcrY707H1ZrPo/SnNdm8psjv7kH2IuLJTbzjsdsomTOAsOzoQgT
	 EZ7/+eJ7Bcvzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Miaoqian Lin <linmq006@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.10.y] remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init
Date: Fri, 20 Nov 2026 15:39:01 -0500
Message-ID: <2026-11-20-1-daily-reply-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1795137196-10506-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1795137196-10506-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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

> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
