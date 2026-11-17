Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910759;
	b=Z/yNW5MRRDJuhIa/NTnlBbNKQ0fm/SaLdqXppSLJN9EY5BreRaETwKfFW8A+cMFpW1+b
	 qcNWK1FdHjm98BoOY2DZoPZumqylmWlK1/NTEw7Up6aqu6GFxAlw8QPxPJRc+83E4DIuN
	 eQbB9KwMqbNz9r3s8Dqr9nzuf300usy5lBYVLVUGqGNXL5aXdTzjH6xzGQwiFAFY9JGHT
	 fnzmeXyd4q1AE6a4KcwdVivua3GGxS57hDrf7kZMpzcmLRTQ32Czr5A+8IYr5MQ+2KUxM
	 F2OvAqYIal/MR7JO3QfnC5wLW/NfagaTYrjS7y7pnzv6Hhp7D7/Vk+kPfjr7Ux18aqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6tYUDeaUmXci4DtaZ3KGPX6vHUKyaaYpdht15nvdlEk=;
	b=aV5hBQ2OQRg9NX8NJ2J4ohdppzh3T7Z8mON0L9qu9csoy0BonpJIE0bgj+xncyocHq5O
	 mWO9lUnaqNwljHtihXRdYafR0PW8a/56olLD91sx54h/TumZAnMH/OTuMmY2AZgJKTaf9
	 /4NqavyIjATg0d31HmwWuIbkq8smao8RBnoF2EpE91tU9rwozHYUH6Ujkg0Btowz+sNWe
	 f6um03bW+IdzqxhKzqdfxvjilhDpUAzvUejU1n8OzFZuXjUMNhKJji045iZJKvGQ25v1u
	 7P1shm2i5e5sX64x0j6XniOQrYceFZrujvkjdJUwz4IlZj+z77cwtjU6hOWMxP4M5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hq3XZ0Sw;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A81606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A81606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=hq3XZ0Sw
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-949664ee41cso324985485a.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794910757; x=1795515557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tYUDeaUmXci4DtaZ3KGPX6vHUKyaaYpdht15nvdlEk=;
        b=hq3XZ0SwNMPqXAAFptW06QVzSro3dwLjHjkyW+FcJdX8JacGeM+g0F1PVT0NcnNGLR
         pWIqnoRkRLpX6uT704N9lgLnJZMOXKtfyZAEfepQLPYgdPALZ8exgL8o6AtB8o2dJmoR
         SKoc3SHsCyYtbybxCpm9+/Wlz1hWI9LfcnNS9DyKSNFe7SwwIUMZ2JZGoPpI39/iaaSj
         NXv0MDLiflmcZEdKELJJjgKVXCGHpl4mQOY0L85DyFSj+WTjWsHWS+D7Op7kulJ1s8aj
         W5u5c5MedZ8rtI3CtmQH0CzGl1ejvYoFEpFtBR5+ojk6BamBB1BZQKfJf6B2vQtRhnbV
         0iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794910757; x=1795515557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tYUDeaUmXci4DtaZ3KGPX6vHUKyaaYpdht15nvdlEk=;
        b=mJmO3D9coFO+yFjPFc5fpT/qV8HgOHE5CXxG5+3U3IttEsz63H6I0Bpuaj+ioCjTJt
         NCaGqlnjak58KlUplCwiI1mbRnIUz7mlG64oZfnAW5ArWkc1NK66rG1opbD/zx+vSsXt
         qpyZhgIaVH06lM88murRdst8XbnHyh5dVqVZgGTamj4rKwsRo3gCuAg1VaQt7qBTlzTB
         nW4hr3q35wtN+I0IXXDYHWWdEaabtMHms1pSqQdenorrJzAfT6Hsjm/K/3pDEMCLkC2d
         LBiSGMTqMb3RcuMyCYJku+G8knjPDli+CWOu9Jv1j/At92ZIaMnN9oY/sw34Xb+rpiYf
         Qxnw==
X-Forwarded-Encrypted: i=1; AL+hErEH/q7Rkc9vpaOcEG78s279A7aAVABqAdvLF+4wcIuk/WHMh8vodmDLFRpvdPdbIeduaPT75Vo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+D+9Xc4RyD2RpPBR0yiSO+iW1R2FGf9TUxnBCTKftVtxFpuM+4
	ko3ihmU0Ufjvp6AVUnT52nqq2q00CF/iP3G0UQOSfearwYxUl0ODyzEqMPidTvq6+U4=
X-Gm-Gg: AYBFou3grXMt98G+2ae5nbA/NRqkllPBIC3JYmQrH16wmdjqJnzIPHtopyK/ZpVZ0mX
	f712jVDOQYnafyXppKQBVQO4XWaPgHrgZLo3ODbmdhADzdneSFbo3caFBNuxSL4dIASZx5zlZ1F
	BxR8JzYsQWve42fql9iXbzUVqgqxeO5OPHZSFpIHu6DiNztC6+9zqcc/I2sewY57kv7DipZQyPX
	MKDrK0W9WZLQePwNekK4/jUWleFfQvbGb53h6PPifbJM5eYTi7BierCHawilJ4Up4xhO6yrBX+7
	Gwc5I/pcKSsQFilFI1MCP10oJlFGSqP3FqgTGkKJL3IZ9z/CPr+4444EXv5C6RC2gyjOjuya9wY
	7QOIpi7isFfevdoXe7fKEYfw050cBO7a1EtzT4XmSr3JGRKxtjpXTxFBME+Y8+8DczYCaZ1TXEt
	1wZAwxgQ1I494STbrN3qY4RzE6eT+UWdRhG02Jl/+AatBTceRzy/6anQU2+USHehU/4fcAkvEIS
	T8DmrwORX2mZXWRkFVaA7HXZ4gEtwjciEOarniTL7aIw61rZgpijpzDGBJOCi2CDrL5UGV89xnT
	510prMuen374M1NGg/qZwuGZ2Z28gVC7Am6j6PdK4ASe+YBVtrHkvXFMG9OF4A9vcQElMtWtvVw
	8JvETwP54fsFKO8w=
X-Received: by 2002:a05:620a:4048:b0:93f:dea:3b7e with SMTP id af79cd13be357-9494baf6928mr2132633385a.24.1794910757471;
        Tue, 17 Nov 2026 02:19:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9496bfb7fa0sm719926685a.34.2026.11.17.02.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:19:17 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	larips <larips950@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/mempolicy: limit compat bitmap reads to the source nodemask
Date: Tue, 17 Nov 2026 05:19:10 -0500
Message-ID: <20261117101910.1820066-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
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

A 32-bit get_mempolicy() call can read past the kernel's stack nodemask.
With 64 possible nodes and maxnode=65, copy_nodes_to_user() computes an
eight-byte copy, but compat_put_bitmap() reads two native words.

A kernel built with CONFIG_NODES_SHIFT=6 reports:

    BUG: KASAN: stack-out-of-bounds in compat_put_bitmap+0x113/0x120
    Read of size 8 at addr ff110000099afeb0 by task mpol32/246
    Call Trace:
     compat_put_bitmap+0x113/0x120
     copy_nodes_to_user+0x137/0x200
     __ia32_sys_get_mempolicy+0x1a6/0x280

Bound the compat bitmap read by MAX_NUMNODES.

Clamping every call to nr_node_ids would remove the extra userspace
word when the kernel nodemask is large enough to contain it, but this
keep that existing compat behavior while preventing reads beyond the
source allocation.

Reported-by: larips <larips950@gmail.com>
Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd4..d9177c5504879 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1715,7 +1715,8 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 
 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), maxnode);
+					 nodes_addr(*nodes),
+					 min(maxnode, MAX_NUMNODES));
 
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
-- 
2.53.1-Meta

