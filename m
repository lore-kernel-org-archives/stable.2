Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154830;
	b=0zWPuxXMdIZwQcvtyiygrhHfGlgYlxNhggBlzUQKIfkrPvhtz8rj5BjtQzJA47v0vh3N
	 g8MDiRsjAHCsEo3Vm/vIAMfwoxbi/Be81hSiDFDm6DI5EaPLX9sNJEyjTjcTc2A5iIRhM
	 B04OubN1KG5e2i4JPsA6GHfb/rBaS5o0gb9M9LAhY7oD/jSttuL05+hhe6FQ+vXQR5cmx
	 sE29tf4Y92ef1gVxZFpoGNLc+GfwavPWiFhL5ikj60MzoHLiydRjQhw90fYWkI8giAiwg
	 fb5CFQSe9G3LMInVk9Oorxz2d2wXV0DK4yeVgb4GsShI56HKIoCNOskYSJkIpMq4O/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=0oGjzRH+k/8DiJzENwKa/OrU1oqb5ZjOjEqz09VTOFNhEzY6HVYwyP/w6ZVX8CM2PrBF
	 6kR1gDsZZL5w6FNezs8cGzmBJ0D2Cdz4EJaTGBfWJGfvUYtUQvbSipGtz69d7xORVp1Im
	 lQ6PcwPXPY45creHzx+XH2+pPVLAeqAlVGmAkFcU8lRrHCMHRVOjs7qe7tjsY16yhS1Od
	 emiJfnJHVUFlzSwdfD+Xkhj2SOxoIBGiV9+VDLmoCVAgpD314/SCtSpiyh/siDsqDNOLr
	 dRizepxVb8yo0wnMvZpcp6cYVry21EfC4fs5rqGux1A0E27t+rWBm2C/hDtxs4Ricnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuiKeaak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1B606A50D;
	Fri, 20 Nov 2026 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuiKeaak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46F11F000C4;
	Fri, 20 Nov 2026 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154829;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LuiKeaakr0NsA9l1iTn0cvPQ8JwC4D+7aWSbmRtfE5aoTS6a8JYVYb1Tqlq5SsBiF
	 4RXlofsaNUXvaxpf+3+BCe0gLvubWRS86rhh35tKudzx0rZM+6GcdC9G5rfX7M3F7N
	 y78jgfTC9itVP+n20wQhfKbsnpXqZWPOagYv+/kFZges7iyB7OB7fLKD8ugwxyFzch
	 0FgG63StPKTG7k6linaEu7xJJ1uq01DMc+TS5TtzHM/MTsM+lv+d9adWQHb2bXwE6+
	 nHzli0cJE1JX4CPFA6WuETjc0uc+v1u4e/oYhYwneMB+8/BL0ug4QwI7f7HS3zGjwS
	 DShPMTCMU5bBA==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yun Zhou <yun.zhou@windriver.com>,
 Maoyi Xie <maoyixie.tju@gmail.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Ilya Maximets <i.maximets@ovn.org>, Frode Nordahl <fnordahl@ubuntu.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] ip_gre: fix stale header length after erspan version change
Date: Fri, 20 Nov 2026 06:07:08 +0000
Message-ID: <179515482829.3291.14775329880270454349@kernel.org>
In-Reply-To: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
References: <20261120060254.3766851-1-bsdhenrymartin@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
