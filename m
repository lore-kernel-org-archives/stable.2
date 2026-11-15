Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758278;
	b=1QjQOjkf5mNV+57sSPek0Pznd7ZUlVdqJ5vQUYRK4GdHuUdD30vLtf2KYyXt1EY8QKwx
	 ozDgQghktU394L54mfwqX7y+Zzf21+wyGoB1hnmC16bVVg8IxVsmhbIquuvh2oCg1DGBt
	 UIG0foDphafPnt+mATjnHxQIqeD6NUwaflxRYmYce/IEAxQcVpJotyWd8icyInikPHVrO
	 ww/m2UmMvG2nTRYvQ7r8spiKzu19IJdYvyxD7H5iht3yNdIUZEyZNcKAdhV/MbeXR3Ul3
	 jEhLEhi/1KX3s08xhNr4WIyxmzbsT2Lp78isnc+Exzjj/sIMjrcKL76BQQEMmk2nvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758278;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0v1zQpwZaYEyKOsC8gR5uRwAge3NFdgyHe9M/NEthDo=;
	b=CfrU7st+dN7xJfrAkzI+kc1nABIrXfw6SZZon3TIY56AXCQWsP9MJVMesLhNLlc1CB9J
	 opcmuB/3Wk54SGZP0yxzXNyxUR+wFvkMGGunaQAgekDXbUdtXl4Mq3Gk0Bf3nAq6xVQPZ
	 H1BWTyR9sQ9ofRgHNezOChG1BlPD9AtOg1d7+MZfSYbwm6azaV5/zWjeJ5ykEMr+1aEV7
	 Mej72WyVPDQyux9vQ5c2LT3G9bTdhcDHoCr9rfbHgyauF9ZxoYHhinb04GYfblx+IJu4b
	 HqXMuz6zUI7V0DisosFD1c0M/n0qKO25cvzdLJL2ZsPNxHD8R3gkFAXaiJUx1aNVhYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qvHk8tzs;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051C606A31D;
	Sun, 15 Nov 2026 15:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A051C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qvHk8tzs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794758272; bh=0v1zQpwZaYEyKOsC8gR5uRwAge3NFdgyHe9M/NEthDo=;
	h=From:To:Cc:Subject:Date;
	b=qvHk8tzs7PQHBEutlNzfpoShDxiaQMtJM195x61TwiUUzO4WmKDkMQ1+kOzxzgWPT
	 JtVn6w0JMOo7zYHc8highZNhR34/YJO6nYWVmTWoqijzkJny3TnS/1pqjUmCST3f0a
	 j73CQWdWUJOI/f+BcdGwF6kmBS5mge/kZRXXdelc=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:103b:e9c7:571:634c])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E701F634; Sun, 15 Nov 2026 23:57:48 +0800
X-QQ-mid: xmsmtpt1794758268tbcjhdllm
Message-ID: <tencent_CD9EB89144BF9CD313CA1A2F96EC49889B09@qq.com>
X-QQ-XMAILINFO: MILSKRzDrLPbjPCGtjdGYX5Gw4l311RgOHiCX7K4CQAmYD6xTJfBmCW1ojFvAI
	 rhP32xDbvZBY6mSVQ+1q5Xg5GI9DJyjH5TNAF7uT/UfcAQIsVd3lZof7bN5o19UKK6SvUj4lB3PD
	 UoR22gmttqonTQf9ewbXORee+yJ6JB1ezBaHwu1HuTYZDgJdnmXEZvZvO3eeUuR1Rsyb9HCzFfIo
	 ueaPihFGBM6dhtVbtcB09QSKTwbR2FMe8hUdpxO9qvEb+2NusahYswUHn1dIoGb1rMBBuw2HF/Ax
	 zeEZ1o3ufCmNlx5O0UKoDSlCGcCIo3w2l2/3cKxBqLqHsDXpk/f5gBWAuVUvIaZo4drJwIoZyKE9
	 TStkb6wv98tIz8V65WjYG9H/oo3jpxV4Qh9k5oeC/wmjhWPC23TgHRuSS9eK2WhS2zEwHVzz2Kit
	 XgqnT8+lNfyUUyJ40WU5FXJToXRMEYxl2A9ei6bGYAZuJrZQrGhJM9Lq1AI1g58wZ0hhdh3+ULPx
	 oIJD3lPsSi4vA15E2BNc+2a++zbxwOWZFwul5jcS49AO0A1KvCwdcDx4EFs1ZsIli6CUarJ12Zjz
	 h3RwNlKCfJ6dWoPuC0+calfjnn5gK9T2K4UM/8O48tExbcxLCOkYj+UsMH9k6LA+Nd+goqdGGApX
	 HVsGXLkCRgflybKkDRNucPXCqXJL1poLhLBnFeXVTZfJFSFUCrKXd2q0Hu56UWEf85Cut8kZVL2T
	 B0hBecCxmnXnDHo9aExbWkz/dyN3U/N34U1Ax3SAwGYFeE8gGZ5dveQ6hg+4WDDxo9zKXOtoAHXv
	 7m58zvUThwKtz7zkM4PqXiWYkAjBEOkaov6P4zuQBMFUT/nTHSCKMv6JtQZZ0ICgUoomyh7cNEQ6
	 sQH03GGoAxdHSrhHBBaob8lAELwyGbdQ/xb939y8qQwvS6TTRv1xnJx2YCBfo1onaOHtkQrnyYeW
	 5CrwOpz3jeDY/joY+Wqt5ijXcTRKt3BpC8FAV6LbOQBh7nqyOq4X7XY1JiMwYlKrdqPd76sVRMGN
	 RxMCm6p782D1wqPJ0nsXJsQ+XzagGSM30dw6XluboGwBT/jRexdOSZSpez5bWfs3X718CFVZgCs4
	 oRwVidQbqQagq+eXslVex4b3U9NQinAevA8tlxLp+XyWswIJxIAFgVK3U8xJ4xCs08VfiP
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v4 0/3] mptcp token hash ordering and token 0 lookups
Date: Sun, 15 Nov 2026 23:57:44 +0800
X-OQ-MSGID: <20261115155747.178858-1-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
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

From: NanHang <2122295973@qq.com>

This series restores acquire ordering for the mptcp token lookup and fixes
two pre-existing defects in that hash table which ordering alone cannot
cover.

Patch 1 converts mptcp_token_get_sock() and mptcp_token_iter_next() to
refcount_inc_not_zero_acquire().  These sockets live in a
SLAB_TYPESAFE_BY_RCU slab, so the re-check of msk->token and sock_net()
after the increment only rejects a recycled socket if those loads are
ordered after the increment; without the acquire they can be satisfied
before it, against the previous owner's contents.

Patch 2 rejects token 0 in mptcp_token_get_sock().  Token 0 is never
assigned, but it is what mptcp_token_destroy() stores into a socket being
torn down, and what a freshly allocated msk holds until it is hashed.
For a lookup for token 0 both validations compare 0 with 0 and accept
such a socket; the token is copied from the wire by mptcp_parse_option(),
so a peer can ask for it.  The join path then uses the result, including
msk->pm.anno_list, which is initialised only later.

Patch 3 makes mptcp_token_iter_next() re-read the token after the
increment and drop the socket unless it is non-zero and still hashes to
the slot being walked, so a socket recycled in the same network namespace
is not handed to mptcp_diag or the userspace path manager before it is
initialised.

v1 -> v2:
 - Point the Fixes: tags at the commits that introduced each lockless
   lookup instead of at the refcount consolidation (sashiko review).

v2 -> v3:
 - Rewrite the rationale of the ordering patch: the acquire pairs with
   the SLAB_TYPESAFE_BY_RCU reuse window published by
   sock_init_data_uid(), not with mptcp_token_destroy() (sashiko review).
 - Add the token 0 and iterator patches, reported by the same review.

v3 -> v4:
 - Drop "net: core: take the reuseport migration reference with acquire
   ordering".  reuseport_migrate_sock() does not validate anything after
   the increment, and the listener state that could be raced is re-checked
   under queue->rskq_lock in inet_csk_reqsk_queue_add(), so the acquire
   orders nothing there (sashiko review).


Hang Nan (3):
  net: mptcp: take token lookup references with acquire ordering
  net: mptcp: reject token 0 in mptcp_token_get_sock()
  net: mptcp: verify the token slot in mptcp_token_iter_next()

 net/mptcp/token.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.47.3

