Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47B4E9C30
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743525; cv=none; b=A6QVxvYGJUYY/Nd95cd4c85qI/eJDdEvs3Rta+a+PY1GrfjImT05RT8ZizwiFTpZgq/MNci7p2hTzmdmWtjICAK7Ppu27g+7vyKvBbI3+rPhau0D3FMJ5/KT1arS9V0gpI7K0Z70rUWzlE9q8H9EFkJ6wHHgH3gg9NFv4w1/ELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743525; c=relaxed/simple;
	bh=zoNTVsFn2L8ZQUpNzfD8JMrdLAz6HTNoSDK6XN9I9T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJ2T2f3Fd75yeMTQ2b1v09VKjnKrEv+w+Uib0NMvIZe0q1Ya0YV5Z2a6XIkYqjqTxddVKqHt1nNIy45ZCdaoazveWDGx8agS/yzludR2jl2/dj4OhTEx+AStKmi+PLmquPxYpwzDsh21hEuKN3cLZSXrZzRN45QJ8Q6IfR95DSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seKNOR9/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seKNOR9/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso889870a91.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789743522; x=1790348322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGf6+GV3IIEO6NYP1DELXeYxIupStmMlcHdqZNWtH0E=;
        b=seKNOR9/8koI9tnFQ+ChF4kzmXWLW/oMqCfWRNRvrhNMXMKs5caedlQKhbwKh/8NvT
         NALCpmoTabo2+S9Yr0z7Kp/tpU27nAfy1y/dpxvi/cB4OAfxNpENWXht5S9Wo7mMRgeW
         uDM2oXvfUNZj2GmMmSfreSp/fgrJhuHEBVXtd0rjQQLn168N1QqxdwdSUn7M7FXGv5rj
         AIplP5pblejPuTRq23D6rlxU6wRtA8dSfMs1Dt8OUwPIVPF+WkXVjB5nFHNDNrjSwgYa
         xJHEBk5mAO28is4YBNy83EYUnvm3wzyZhodH3fOZOoBpOKKN4l9SpUdIvvxLo7MRlSYI
         a6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743522; x=1790348322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGf6+GV3IIEO6NYP1DELXeYxIupStmMlcHdqZNWtH0E=;
        b=VlYS7qTXJMctYaR+8gsIpdlcjwKKwQDNGbw3kR3jOyQaur1SQKZG3BJymFjQ9+v36g
         hgINdiRq06sXM5pJ1YGzlbNJYTiday5R9Xqv8t8TuUrXbbBrgFJiRh0rRGCNJHvbc68g
         I2N+kpxBj6CA6ke5HlohTHYS8+3HMrzMnfANt7CerdXOySzR4YSFod0zUWW6eAQ/pNHS
         vkT8ZTS0f6MRfG4MTvekQZPld6PSSrw4Kv5cMwSOhr5b+K1zzXtdRI9/YEUbylfghs9I
         x00BHr+y/2HLJ9VJ7nQKyKWhdWirGTH/GHq2o/zbCQza0vTy+5VvcVu7VYi2ht8ifiGx
         rBow==
X-Forwarded-Encrypted: i=1; AKwUvBznXwtmVneRhp6ZBJOvESWEPloKqViC/FksMRzgTxCinlgjYzJnrIBZ3sR45lgF3ZLGqhzSnZM=@vger.kernel.org
X-Gm-Message-State: AFuF++nVwWZS6bcpnlQ9zUHEH2lZC5FaTlId0h9ba6GWr3ebMvlMzrRk
	z46Gcn45cRFs+SCzDkND6iqkdcoyV/1Wo0RV0juLBBHZ7vC7ah2LZanh
X-Gm-Gg: AYBFou03QEKOB+VjvPjfc+e4Td+7cwFn72M6PSb6PD1ACbiDzG1p6qSwcCxRtHjoKYR
	AY3mNL8X4ZGpom51iknvgl1yoi99rBgHYE0DRW5fmXK0dmPIzkoWAIxBjaZENunMvJdPUjcvAmL
	8IJCLJROTZgaUsdwjahhc9KAFvbnmJqnDrQedEVKUjXf1r6BXnkHbLsBX/clzNUBshbuf2IJCWI
	Qs+faBvI1NslgBd0/FDJn+PwC6VAFwC6biyxs03FX3P7lSxxZx1/k4rQAEXEcoqwMmMSbvwFgAP
	l61y3Uks6/sHfXgq+qN8rX1+YycX7JIj5TUAwdQ4pgUSOm91W4Lw4w7eNQn+Ch+Xncko4wAfLgG
	FNrPYadiwCjq6xF2cUlGzyBG+/7PCE/MSi7qA72f93R8DiRZHWryeoRfGOa9TleY4ijN9WrGEaR
	EBxYD3OS9/ZwLo5XJLFIavC0Kw19GtR3XQg4V4faN1Kj7qHzt61G1sHUKjx9wwwsPdTYGu9iZ6v
	7jzycbVKZVeUhPWeIRLQGLkGP5EXUFD
X-Received: by 2002:a17:90b:3ccb:b0:39e:4c7e:f03e with SMTP id 98e67ed59e1d1-39e54f2158bmr6529020a91.27.1789743521728;
        Fri, 18 Sep 2026 07:58:41 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a50c9fasm3954108a91.8.2026.09.18.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:58:41 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+c09f7e87f6209a56@bugs.sh
Subject: [PATCH net] rxrpc: rxgk: Initialize challenge control message
Date: Fri, 18 Sep 2026 22:57:07 +0800
Message-ID: <20260918145705.1511737-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxgk_challenge_to_recvmsg() copies the complete rxgk_challenge structure
into an RXRPC_CHALLENGED control message.  The pad member of the embedded
rxrpc_challenge is not assigned, so the copy can disclose one byte of
kernel stack memory to userspace.

Initialize the whole structure before filling its meaningful fields so
that the reserved byte is always zero.

Cc: stable@vger.kernel.org
Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Reported-by: <co+c09f7e87f6209a56@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/rxrpc/rxgk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 77a67ace1d248..799772b0d8472 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -756,7 +756,7 @@ static int rxgk_challenge_to_recvmsg(struct rxrpc_connection *conn,
 				     struct sk_buff *challenge,
 				     struct msghdr *msg)
 {
-	struct rxgk_challenge chall;
+	struct rxgk_challenge chall = {};
 
 	chall.base.service_id		= conn->service_id;
 	chall.base.security_index	= conn->security_ix;
-- 
2.55.0

