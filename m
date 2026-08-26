Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDC3655F3
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764473; cv=none; b=przKlEE1ITc1uAeyZgys0n17Tnog9K/LUnO4rq8F1SgmOVDJXT+h67TAOxdSpCGPVZFvIiFgzS7AFqcTKCJMliB9SdGU20wTXyici48WK2rN2ZdOZ+tprkgVgjh+O5nKLQZQngaOu919i2ecfayFhrDvzyDEE22U8HgouatzknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764473; c=relaxed/simple;
	bh=8bKsD9oWj33NgkNdGu55Mu1gP/LaW13d70gMWYrT2RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAJXTlebU93fw3yoOyLr9xswhxnZ2bsezohJTgRywr8wRHgugKn0f4Vkn7glxQrNShK4Z5IYMVeoW5fZix7jXBQUWo/Iy3kvo8kW2JUD3ycbuMz/R8j6YnOIydJt6VR3MmHjM9quog0AwvxfS8hNI3NluQJE/Pd0Ta0RbzdlYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcq9Icxi; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcq9Icxi"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81f64e8dfbcso19616917b3.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764453; x=1788369253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clawZ9fzGlkquq5rpQ6tbQ3zyBYp/FjuWXWqf1icnXM=;
        b=Tcq9IcxiiKSKq/fZL3nZOK0DUOiImiwt5ucFSDz0n0Hfv4hKHuB/lkm3308zMgqOaT
         8O/Q7ginBMV/uEnqj3Eg75JlgsdeY2xkTg3dRPu4yUtJxfZR9xTwqHR4KY8/rr+yeeSW
         7r0ypbem+t4a+p3gvOpy4Zs5k7WhJOPyw+hHsZFX9FMY8T48QeqWCBhH5pAhW+xBveSw
         KkvQEJ23w3m035f8hOVt+pUfGXH5iaZmxiAziGWYOqa4SU/qgBN63d9qZIGoWSIRthqc
         liFKoc9PA+EOeUBRF/MzyspVGNfl8zACjQFfPttg6uNGxmiBNDmZIFSQLuy4++Zas6+E
         PcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764453; x=1788369253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=clawZ9fzGlkquq5rpQ6tbQ3zyBYp/FjuWXWqf1icnXM=;
        b=Qw0JkeSSm4QRZaiwGU/am7913QApjJ7Nt+4BWTdbt7yaGoQP4C0r38W2m/bQ4vNSKC
         BVg8pCSkjtnjUkpc4xMoGvbXq2jh2NzvMv479zKGT6mJgnibJ5Y4ZMD8aoUR0HZuypWm
         JRJ/gbrdbgtWWXBlCSDPem5YTEh8waH7G/ouQorp9ucuolqc2x3wp4tvJ0rJkTdhOMWx
         XCBJftjs44LBx9pH43nYED/LJH3zdpd5TmjYXnexyNkaLPR07Y3Su4Sizjf8lK57gxVJ
         C9AKr8IRE1tR6mo22JixLtFyP4yYGWZBym4rkJ1wOlva0JSSKt0sDLgbIp19tEbuALwb
         fBQQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8/gI69G1J2tOYBIgLN6VNGXTXbOUFRCSZ+RFJfPWHDPpZ8U5TTFA/LjFLzg9Ac3tAnYtnodc=@vger.kernel.org
X-Gm-Message-State: AFuF++nv4q4GfV/AkvcA1SH2NTen0TdC0O+IEu0MSDNYNhVpCNCp6ETU
	A2Ez/ES3lKLDwxfdVLaFRs995sOFvtudjcZtrHk1lxgTPcdBAcTY4y0y
X-Gm-Gg: AR+sD11dbEtCoFbygAXbjwnL1dLXWxSdh7KrBuOIFKst4VJIfnqo7Xffj0fX88ag+k4
	uWpnAEUCLP2zhudxXWgWJdO1dBLdMgMrMWLNCGU+lbKz4wYXBFG/Efgd8F2OZRUaR22YUrHa04Z
	SXZZTpVFYV+DnAnB6E5YWJIURRoJuDCl0EcVttDIkgLHQZz1qfARFw/jKeh9r7lt61qCs77VyyA
	95px4cEsRpYOHCnboAGFa61yKuTrj8YBxAaq9vFc6jruk4Z3W6x0vgL+G0jWy66TDIZpGsHuT3k
	ZWDsB05QloztlBJeFweDsCGkgLZAsQMH9FyeW2GDa+8HdlY2d7Z6hvO80N7L9lQNiVG+mk+2DqI
	hWlijdNP3OX5Js+D8+9Ik1Y4QBRq3nsHB/RPt4UpxeQemO9yKotvCXqkbjV31co7Xm49k2EjUrs
	R75JTuLrusNLsUzAergcUZSaHgbAwjO1kExxyRmKIAtsjD9eGPHf78vX88zQVELDuaDh0=
X-Received: by 2002:a05:690c:6d83:b0:81f:2479:16da with SMTP id 00721157ae682-8573e062ff7mr37338717b3.16.1787764452549;
        Wed, 26 Aug 2026 10:14:12 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Wed, 26 Aug 2026 13:13:44 -0400
Message-ID: <20260826171344.4133-3-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
get_info function pointer without rcu_read_lock(). With BPF struct_ops
congestion control, ca_ops can point to dynamically allocated memory
that is freed concurrently, resulting in a use-after-free when the
kernel dereferences or calls through the stale pointer.

  BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
  Read of size 8 at addr ffff888013701258 by task exploit/149
   do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by wrapping the ca_ops load and get_info call within
rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
the icsk_ca_ops pointer.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Link: https://lore.kernel.org/all/20260821182449.79785-3-blbllhy@gmail.com/ (v1)
Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4918f48ba76d..c45776d3ed90 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4562,9 +4562,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-- 
2.55.0
