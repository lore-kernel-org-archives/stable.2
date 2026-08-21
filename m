Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8E38D3E4
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336736; cv=none; b=bWpJc50jkMpi5zXnmT+SCCwNhkvah+jbWWENUVhn3TLp+a7pu43mS+6n6GG/XLowhiO1S453ljeX9JXMOQrTDJM2GJE0ipEoSEDVgYCXBgLrjmPhM1SelielhBngLR9b6Qq391PHGhmuNqmbnQ1Twz7J1Mdq7/gJs1FlQcvBZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336736; c=relaxed/simple;
	bh=+jEjnMMcx1Z4BgKf7iCzxIErD7+9CDxFlLEG/VspZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIBk69fO07pfCjKV64UYuXDUxrxx1YnDmDVU+MIi99m0gETW/PWGVfxixJkPCrTa3luEH6R/vDa+HJWam2JNDgm64SAGTtjf6jEg/1Tiya/xDDbfyGamOLwtuH1zcWB6R3e7psv0jQk9nQTxtD0C1rdq7W6E6dT/bTNirEd1aJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJk8E6Dd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJk8E6Dd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1370095a91.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336732; x=1787941532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F9B7c0XpIh0nkrhvveEJrVj3ZjtXGrKz5tFqZu7UN7Y=;
        b=IJk8E6Ddh/4Or6soIIeUdxTnJCrNTKKr+qwGH6dyvyp61DvObHtxW47t1GbfDgNdUu
         7u53AnjEJ/2c1dFqpg3aokXEpCGu50tqoxUmSCo2zoYvidybeEkgiFzzx8EnlZurqgAW
         wDJPMML+E1gAxrDdJIW8WhykFfgc+mb4ULChucJQddaYpPdCxHy1nykEEtM5abibOblR
         JH6YXBrhm+etQul7HrXcFBP6o2wO4KPI2EjFom0ndOWsgk4juW+VobWt5wa7TaqUlDgm
         7HuMWkzaX2VcEYHiUQnGkv2CXC6V16LfgMXh77xBkRPehomjIi+CZyJKYjXCVt3xOwY1
         i2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336732; x=1787941532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9B7c0XpIh0nkrhvveEJrVj3ZjtXGrKz5tFqZu7UN7Y=;
        b=at/p4UwzT5TCPIReSr9GdKtfTkacTKvKZ7qRnfLyp7jtIo0YNgzqhtf9elvB7X7dWu
         m7JnSXRGIvpeEyDcrGl/N1XAHjKv1PH/Ead9DLP0qSp/GfOwfYWwiBxS1UySXoFAxqs1
         kx8E6mrM0fNYlmyzjSfoZuD6kWAsMq2UxZi1rQGqYE6L0huZj55gqBnaxr9CtwpUq+hK
         UcDFw/ruTYaZuPGTJObJiVMT4PE829zjju5/SfwSOTPZMxWXYo0qwEW6qUOdqtjpVzaL
         mC53KqF1H77WX0dZaB1U6/4W/g5i/FGAQf0xrjPsvBJtIv70QnrbqLG0c1BbuCB+ctSy
         H7KQ==
X-Forwarded-Encrypted: i=1; AHgh+RpB4qCbVDZgMXUUg2pkFnxfEUhYtJ1vk/He/JjO4TfIRtOIvjwg3hSTNR1oZO03h89sXsxXoCE=@vger.kernel.org
X-Gm-Message-State: AFuF++kHKGSFSx1/BlrqUVr+CfH1Ef4xsunqsQzkFUKKN3/EzR72FN6m
	/hyvnz5tha4wLXT4EXrp75ojiy850dHn5nkBVIgvbPgQdv6tNS9/s7ds
X-Gm-Gg: AR+sD12pq0jHr6eTgiHS7hUWdmJUOzn/bJDc9KqApyyFhGMYmoT7nY+hh5HbLZW4ros
	RRb/pljWvUIctoOH989MudjRalicHMXdQZWKfH3jY+IiqFN/qC6Sxf73akQa8ymxh1qf531AWne
	VAoFuYkjAeCusVyFQR9cz9Znxnyz8788XFZzHUicVnJaNsASwZQvKqtDSYdQe3hnXxXOj+zVJw6
	ympIqH0eZTceRZk3FOb5m0a5GwaHEqz0hHy5+hRPaYnaRsA8ybeS6aiQM41tjD9pGE0Ys/nxcVj
	TaNyRRqesbXtTm5m2/GhIKlGDpFfvHu8E4pIQFQ5X0jGUwgtWU3gy0zLo98M8KPVLcNPizuj3Tj
	RwmYaOMilX6+MXlyXmJDQnKZJjFZjPoZoYCcV2ywHkkZkx2kKMvJApXSjCv5VB30fd0uSHPPZLE
	/yrtFS1c6u91drgrVxZav1+K3qQc/Pb0gHsEW7FwYMswcauHZzLs+c2mLjDLUQNaVxIbV3sK5Zt
	M/HKEwvyNDoSDmmNgZPzqyJ
X-Received: by 2002:a17:90b:3c50:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-395dec98ad3mr1029902a91.0.1787336732318;
        Fri, 21 Aug 2026 11:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1012:54e3:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm4243013a91.3.2026.08.21.11.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:25:31 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Fri, 21 Aug 2026 14:24:49 -0400
Message-ID: <20260821182449.79785-3-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821182449.79785-1-blbllhy@gmail.com>
References: <20260821182449.79785-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
rcu_read_lock()/rcu_read_unlock().

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
The unsynchronized icsk_ca_ops load also constitutes a data race.
READ_ONCE()/WRITE_ONCE() annotations are intentionally left to a
separate change; related TCP annotation work is available at:
https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/

 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7360ff718f1d..43ccd2d37f9c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4562,9 +4562,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
+		rcu_read_lock();
 		ca_ops = icsk->icsk_ca_ops;
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-- 
2.55.0
