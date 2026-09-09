Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA303CDBA4;
	Wed,  9 Sep 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985600; cv=none; b=kiC4JTX+zL0hNWoPWA/CQ+PYqRtc/MCOdUXru23EDgw1bbX0dGsYruo7n/M0fJ/PkmAGntVjJxyuc+oA2jtjX+U2abpYc/XFYQmLRlZiIMlhiDe8rih/HLbKyLjGt6m2CWItGw6Q5EAaT2Vr/T4pmx7/OTMN1iztyzn6oJr+xpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985600; c=relaxed/simple;
	bh=/B0BEmfw1+AImewv9HSwP4n+q/lj8Y551EKJPUD7yOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBNQ9PcqS7FHtip3E5KiLiq6zvnlQCFQf1XN1DCjkCyNu2UbC5UvVulDSPbETuoe/Tp5xyE2CWKWo/JUrxxKlgCAYh+LlrWeVVEuP4Z8oOslFAFK8CAmlAbxEPEEnPB0NwVhAaW0AuhxUSynDOawMKcyitVh4kgi45IBdexHpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ9GRTjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ9GRTjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268281F000FF;
	Wed,  9 Sep 2026 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985594;
	bh=VLP5rlPCDRA17XnopQ8izkaJ8zZzRM+VTYn3F6+WpfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZ9GRTjLqzEPuDpn6Bid+GILZvYWhZOb5t7BuQ/m6vj7z3mY7AWSBlhW7f0TDn5WB
	 gosQ0ZnVoyCXbYS+j4zxV2Z0c3+YDckJpG47n/WmkZR9mopcxoOw6DYFuMwScRR4wf
	 mSyVmCR7oOQlCEqjB8UvEp8Cv5DcPUlzW6cWEQ99SjVF+aOwDNqCRSGyLITyvoD5TC
	 mGn0KZH7B08VKPmc+dD6vmA2VDlhLZ0JAhx5ghXIaW3N7Mu9iPZkczMM283/tOw732
	 EjZ4bwr0mfhtWboyWLXfuLucHX5W3HOgdfQQ1xGd4hwMZrXBt1ba1pMynSo1epbkNt
	 0n2G+ZyM/SNlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Wed,  9 Sep 2026 16:25:59 -0400
Message-ID: <2026-09-09-daily-reply-0001-tcp-sock-ops-cb-flags-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909-cve-2026-74268-5-10-v1-1-374ebc121b6d@bootlin.com>
References: <20260909-cve-2026-74268-5-10-v1-1-374ebc121b6d@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
