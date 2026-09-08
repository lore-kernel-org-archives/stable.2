Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1259C993;
	Tue,  8 Sep 2026 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907173; cv=none; b=nhy/X1YNIf0IU9Tl4JFVzQjgexa1e92IWcrmIwEAfC/rv4R9+ZyoO2SzKVqkMpuj5xPqY24S8v183RA0Jxbh5XDEhThutNfUs6a08fazjNDtdxZIEtQsKzLH+OxH50SnEXlA8XaM38685VCcwMLGA5B95v/R65Q/dr+1icrN09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907173; c=relaxed/simple;
	bh=zP5g2Ej9xw93NIsfxr58CoDOiPc6XGnBcHqWA/NURLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD6/iIjFtuEQjRO+lAg9K/PGYJImUDZnCd28LIt3rCge7ft+a4B58CC81eZpiNn6M9ZFdH95gXvSlgDcnvkeenVCajkniBe+2yb76CJsUpuNYW6GHqNJAXez3qGMLZCEQr+ScDkiAKMr9vTenz1/7I1modNSAMuPN07G+AOcfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4viA9O1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4viA9O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA21F00A3A;
	Tue,  8 Sep 2026 22:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907161;
	bh=qrDUNxVrl5uGiciXI2FLRPY/zJ1WkrONkbkkE88nB+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4viA9O1+ZkXxbsaswqiE9SF1FPA1bfeAF9Z8Jax42qK3TWZKD33VLJn4fNf/HAda
	 qDlMST+4/XjLEh9rOqoTgcq2Fcl92sXypybPtH0nN+nRF25S7YPrAhKe+nrw0Q7aTM
	 iTzadPxi5uOuuRAea/MokpyYDi+cDajgC6uUFxxrtQx77q99BPe8i9ZuQa1ec6TP7A
	 6exnNSxRobnX36sOsDWwuhCjg32ypJ/uVXfoBIEb5KyUNr7D7AnxsBR8IZRNEN2pB1
	 npMjsPRpQGtVZFW32dkaX3i0bushc38s9URTQ+j7iZ3k9Wa0WcaghxqNz0+gdo9vny
	 lGFM66FYNtjcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH 6.12.y v2] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Tue,  8 Sep 2026 18:39:08 -0400
Message-ID: <2026-09-08-daily-reply-0001-tcp-sockops-cb-flags-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908-cve-2026-74268-v2-1-3f81ea487415@bootlin.com>
References: <20260908-cve-2026-74268-v2-1-3f81ea487415@bootlin.com>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
