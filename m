Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021455D88E;
	Tue, 29 Sep 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707863; cv=none; b=sGJzx03ogZxEmbmdSiP8DEfmJqX+2FbIz0e46+6IIjKOumIf/xZD8FCp6x3Ygh8TEUNDVa4BcbkY+XzvGbFGtvLCGcqh55n24z8Z3Zsg4McEJvz58b8+hcIfp50mznQEEaz5ziwd9prXuXUpYP5MHHhJabyJqArcIkvxT5tQn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707863; c=relaxed/simple;
	bh=Jcib6OdrLFdfUYJhX94NBQLMYnE07JO0b3cUbeLdDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo7lSRPx7vE2BgFFCfEG0djbkcfclofwPLBg7EOLtDM52mrSEXPJHOoOteW+1ucd2DWEBCg9J7QzQ6bYgam59Gu4GZY9nB3GmgulWIFrXpC6wLxFOcX8hHKblMI1xUYMjIe1oJEhdmRiOCnxCRsUmQ55tLOSR9F+6i4sL15Pqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvXMWgaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvXMWgaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF15D1F000FF;
	Tue, 29 Sep 2026 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707862;
	bh=UUkR1Wi2hcjvOkfySJDer+DfIynnzWSlclr8tkVzkWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NvXMWgaWRSSRRx7WwvghL7XznzCUEIV826o4sQJQMkyFlD6SYAKayX+2LL7yqNk4a
	 AGSzn0Hnw7nbhlIOw6r81X4ET9djUJOBRExeIaMGmQeZ8RW4V9tH1O0TGNYfyXstKX
	 GzTgo85f35+JFCpMgWOf2NhgAxeB7c+9O1m++QWInoKYDeq+4v+3DxdOkEqByY8/m5
	 pbASInKhpuQiqM7uyY9boZQVjXMIM1puZoTkBxrLt3EPc17FsaPBAP9xc03k0b3uI4
	 4Dl+dv6izeVfX/t5vtQCBcAuM5Aa8fbBBBNvxT0WBu6Oj/3dsSlsXPdjCKryUDfPYz
	 xauMeGJAcmX3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	syzbot+ad9ec60c8eaf69e6f99c@syzkaller.appspotmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Simon Horman <horms@kernel.org>,
	sdf@google.com
Subject: Re: [PATCH 6.6.y] bpf: Fail verification for sign-extension of packet data/data_end/data_meta
Date: Tue, 29 Sep 2026 14:50:45 -0400
Message-ID: <2026-09-29-daily-reply-0002-re-bpf-ldsx-packet-ptr-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929030127.86206-1-artem@trailofbits.com>
References: <20260929030127.86206-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-47702. It rejects sign-extended loads that can
> turn packet pointers into invalid addresses.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
