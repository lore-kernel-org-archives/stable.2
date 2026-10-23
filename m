Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783863;
	b=t7VBs056jvSVqNnN2MORDhrqtninFiPA2w43imiZBOi4yhkbJV4gyGLgCnnd0l2umQ7f
	 nmrQXYlc64xCV8goV+7haQIP+tNy/yRG1FoNF+/LYnOuo/7RnzbbeASmeiXKJAICDAgJA
	 BoEMy/KgR+cheO33c7kkM6IQVlRDb2RoqszRSTQcsWWQrkFjP5VjabeXb+GlD7W/ARfS/
	 dwlr30bajs/qEOSiUcjlGvyYoBRI71/xmnY33DXoPVt8Mk9fropexLxM4HK7+7PZ6Sb32
	 /sToyJICcEW9wLfEPjTSAQUhZRtKCeOEIRrH21nvkgWxaM4RC/3mwR2/WhAmgOXUifQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783863;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nB2gaoU0hmYvZYSoXJf1tRJ5p2ObyHTPEEeKB+5Oz3s=;
	b=gDOQRduHp+kTAXnKcX01W0F4PbFtY67gGhaZiKRaljQtN/J1UN9buAleQonzZw7ySX/d
	 YLS1dKN0DEFwzm8dZinqyaS4jdZ4sN18fY8yc9L7idMK40GsBLyrUPnVgtKEdnrLVGEe8
	 HYxyxpBACPSKanESLuYqAzptsIJpfO3aR2Gw2YuObzF2im+ESWk00zumMzJ7ALQx/gKjE
	 wEn/kxNGW0pX21thervpZwKJsuywt3njPw+ffDPole8TW9PyWQ80Av5d26WQ9kosyriTP
	 VzDj+BSzzbLC3Sk5ndi7aEAuZeWuRd2p3vzSCv3HtO+CPkOeZXzbMsC/BjS1y5w1WZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oogApd/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CE606A320;
	Fri, 23 Oct 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oogApd/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43861F01825;
	Fri, 23 Oct 2026 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783863;
	bh=nB2gaoU0hmYvZYSoXJf1tRJ5p2ObyHTPEEeKB+5Oz3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oogApd/WS+Wgs4M/5dynlevYmslCFO08SV4zPf/i1+eI0MDn+qgQwsOmC9wIfg73G
	 YTxEcLF0c4vN/qiXOXLB2WLPIAzUXVg6R/+o2xA6wuN3fbhuZlhO3jU7fXEtxaRzvh
	 5F34fSK1h0ns/alwgUfCndYKd7fFQMNSJBV9c1e1Iif4y0BRmx5zrWlhzBN9TiN4nx
	 HlbLXrn0JRsBcbFqs5yLcpTNLgML0cjMfzTyJ+q9UUW0jgGqNPlq0NEamEIvmGlAS/
	 9hhoGhn1q1eU3Ptz7ka7RdQPboH0btxv/BJ9awuA5Fy0L7cGSXTfZn0Bp3jPgFBL6T
	 77JVjUcvQEcqA==
Date: Fri, 23 Oct 2026 12:31:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, Joel Granados
 <joel.granados@kernel.org>, Matthias Tafelmeier
 <matthias.tafelmeier@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: reject dev_weight products that overflow int
Message-ID: <20261023123102.3c30d01e@kernel.org>
In-Reply-To: <20261023114228.289161-1-jiayuan.chen@linux.dev>
References: <20261023114228.289161-1-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 19:42:25 +0800 Jiayuan Chen wrote:
> proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quota
> to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bias.
> The three sysctls only have a lower bound of 1, so the products can
> overflow int and end up <= 0, e.g. dev_weight=65536 and
> dev_weight_rx_bias=65536 give a backlog weight of 0.

Not sure anyone uses these, maybe we could cap them?
1k for dev weight 8 for bias?
