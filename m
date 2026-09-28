Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01574F3EA8;
	Mon, 28 Sep 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613988; cv=none; b=tBYY64T8sN8p4rUVYzHCP64gQzjcUYfoo/rTKfDMf25HxiWWJq8Lf1Wfu773UZKVSJXbhskB6r40JRQ26v1r1eRxbFNoo8/jpSleo7RhttXcPhYpdIbDnu9pNEyu4gDt+Jw+sf+0PQahRsvYT4bZm62CiS0dHuFjFaTAxYsvfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613988; c=relaxed/simple;
	bh=tsKX//UcRdM0TIYL9A2CvjtTKBu8+YTHXMK9LwZYmqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6U21mg8YwcI5S1iVD2CgQv6jgPKklECkYeQLy/K/xnd/FRMgssikw4jPtiRK7flDu17X3VimjWBK59CjL+jfJvUo7vb+7laBf8CuRq2W5e7HLmcbCNMTwdj7aIAgAxwknpRYP1NnsU0uPvWobrR17CozBLr218n1hsRP8RiqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3WVqCvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3WVqCvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC29D1F000FF;
	Mon, 28 Sep 2026 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613985;
	bh=G/Ey0WEYwX88uCfKL0+LGuFKrX3Fn30Uj3emJJNNfb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3WVqCvSP15fqeQNIAsxD05PB/ftJ8DnUiEv2hjuuJQa3tgzt8Yk6cFmEa/BW8wjV
	 uVpgluZtw/ceC0YxTuTDpaoBU/YXiCuJVB3EjYGm47DHjfA3+4Ab7lq0NGRLRJMOmr
	 OnsC8Z5NkGPAYJ2UiCuxWQRsQuVo+5cT9xwjyVHdLtXNFlWD1JcKdoDiDLgAW2VKWG
	 szspuTP9kEKyqBh/ViNf/2R4MCV/bRloGlvPUgkoSRdPs6Svg+lT0J4EnMbpRdYrhq
	 EfTOFz4bka3xbxje5CPpk4N0BRREq5KVekdcxnzTyg/7sUtgJZAJa78O2UnGbJrTB7
	 Vkk/TaFW5okrg==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Jann Horn <jannh@google.com>,
	Cong Wang <cong.wang@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiang Wang <jiang.wang@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Xingyu Jin <xingyuj@google.com>
Subject: Re: [STABLE v6.6-v6.1 1/1] af_unix: Drop all SCM attributes for SOCKMAP.
Date: Mon, 28 Sep 2026 12:46:08 -0400
Message-ID: <2026-09-28-daily-reply-0009-re-af-unix-scm-sockmap-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928105513.3555368-1-lee@kernel.org>
References: <20260928105513.3555368-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Lee: Drop skb_orphan() from unix_destruct_scm() and omit the
>       unix_stream_read_skb() / unix_dgram_read_skb() hunks as
>       69bbe2bcbe8c and d92fbaccd09a are not present]

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
