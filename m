Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E54363081
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068163; cv=none; b=RwJe4DQgtLH2ONcQiJdglmfdFn29LTFjNvTrqQIDESjz69gbmY4typD1oJMvtPnbgVhko+MTQsAA8tSMjA8uptQvjIpYOPau+9eLlB9wgc70crn5Q2Q2/j3vBOLJmZtoQRCrFnHazowBW3zpL9w2twEe9kO5hKtPTajHp6G9KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068163; c=relaxed/simple;
	bh=fo5PoXZ5ZKT8MDrEaZn6E4TyN2oZ8TJ4XeZLBR3XSA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYRHoN+K3DVKk+qozIWlRuzNHxZCxEGxZIqxGZznKIzWvHnjHuiR2rTVvJ1LOPoOcBu4uf0ZIkdnZA9A0XirHxLgn2nSkAvXRu1kntSXTSllDTnm9/33xcsc4vIyNoWmx5SddAKZHQn0JCFVC/JJDtr86HHXHfLCohzMucmijME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PylBpURd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PylBpURd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf52d15d88so44818075ad.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787068162; x=1787672962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSuvpzf7rU+xT5RM3KODXO3i5VoabBrqOkefcg/k454=;
        b=PylBpURd1jLiVAm8Cs7dCBobDJvvZy9TGx7l+ZjllMkDrnAoBsWnRm0LEitGLy5ior
         fRO+97ovEeHD7R0dkpTMuFZ+EvC90M6hly50UyUQh6uH9UTDJaxcM8TFuXxWlz47vI/R
         SU34n+TfVbXF7KAJpg8htzK4FqwDbv4ZY4JKsS82IADbPqjayswGuWbids6QN4Mbnnwu
         +2LK1O3IAtFa0o1igXqZm9XvG8epRDhBzHB05xh3qZILigP6rp3YgrPmZFFXipCCnaST
         TfLBjY+y6FCj6TXYhyh7fyoOYd+PNDIbd10JnhzysNf8PL1uKAqZoCfdsdFMHTetOXI9
         r4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068162; x=1787672962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSuvpzf7rU+xT5RM3KODXO3i5VoabBrqOkefcg/k454=;
        b=eHlORXpYPnZVzJyP8dBHSvMYbhvUh4/9M777zQIlBt7JNmdmM144vpwFORbXYsBdo+
         FDF+b6uHICnFPY6C05ZAW3PrYVnOzGwZWJLGjGKIJi8deYfZNiU9UJB3GXo6eUIkQ66U
         He4p+P+la6wvbDffYYc5WBkd8CbZ+gHPawpohije2pYa3h6JzGlXmZFfOI6qJTYD4t+k
         fnBY7W3ynsg/imWT2BeGEiOfcQFkrwfGfgizmhhpdGwAMvOs3klbzpt0Q9geXT7/h7iH
         g9wqSH14mToPtTMlGpMoJ5FCC/DstldeBakDVmYS9770pHBt3ILVXNDpeWWyj8e3eF/w
         Jxrg==
X-Forwarded-Encrypted: i=1; AHgh+Rqcvq73wSyFmuU/AKeZwkw6vxe5mAu0bG3a2hw7uhsczcmYOCMJG2kbguIxEsWOnK3/WTvYvzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6gGgMCKWQPY649C4nelb+EWJzc+elRkOjfgHdUviy9XH5bTY
	1Fe+521ZV6U8RXfqL0zmJ05roimpi+xWVIHWoMmYCNzsiQdwoo/4crrR
X-Gm-Gg: AR+sD11+KpPNS8z34UGSMBNjr176awzQxz4nP8z9WcHYCgRIEtHzBgZhEVrciWhgfYj
	Io3wF3s1BWaVTJoBcloEQMUnl+rty4hIzhJSdny0b7y4Is7RFMKxyLmIO+7dh+11zOmb8X6MZUn
	1UsvwEjWqxBTN9b+TQB+UNkNAfpiG9LBLcumAlPYDkWRK5z6Pmf07ry3WwoAX24PMZBMFiYUa9u
	KQhuc/i2S4Af5ZgE9RBv8pbbUx3xqLlOvM805b90CACqXJmYuPnF6hfCB1zkym8SYxu4fyVEKwf
	GzHHSWEI8i1x4FOIm0ti7p5Q3GeTteu6Nv9963pcIk8qGM/glfGkJmiP2vF08+R+FH4eZgvz67q
	ankyi0rfbNKWlUFg25xipVMCcAfpM5Fjp0IVm+C4Ol15scNRlh+Yrzk2pdzTZV39qhkf5Qik1OI
	eE9fJ5aILsDVLC8yHwrnmvrz3vcTwoluG0NiewARokytXMqEOWPXwVJIkusPodh32AxD6SP3aHR
	iyyqIXl+z9rYB8jFxxCvys=
X-Received: by 2002:a17:902:d4c1:b0:2c9:c517:d070 with SMTP id d9443c01a7336-2d3b0ad45d3mr352820585ad.3.1787068161635;
        Tue, 18 Aug 2026 08:49:21 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.113.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e543besm16937955ad.41.2026.08.18.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:49:21 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH net] xdp: fix zero-copy frame layout
Date: Tue, 18 Aug 2026 23:45:15 +0800
Message-ID: <20260818154516.793517-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_convert_zc_to_xdp_frame() clones an XSK packet into an order-0 page
and advertises PAGE_SIZE as its frame size.  It allows the copied frame
to occupy the page tail needed by skb_shared_info and records zero
headroom even when metadata separates the frame header from packet data.
An AF_XDP zero-copy packet redirected through cpumap can therefore make
the skb overlap skb_shared_info or place it beyond the allocated page.

Limit the copied layout to SKB_WITH_OVERHEAD(PAGE_SIZE) and include the
metadata length in frame headroom.  Redirect callers already handle a
NULL conversion result.

BUG: KASAN: slab-out-of-bounds in skb_gro_receive
Write of size 4 at addr ffff88800cf37004 by task cpumap/1/map:1/146
Call Trace:
 skb_gro_receive (net/core/gro.c:174)
 udp_gro_receive (net/ipv4/udp_offload.c:812)
 inet_gro_receive (net/ipv4/af_inet.c:1539)
 dev_gro_receive (net/core/gro.c:515)
 gro_receive_skb (net/core/gro.c:633)
 cpu_map_kthread_run (kernel/bpf/cpumap.c:395)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:164)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Fixes: b0d1beeff2a9 ("xdp: implement convert_to_xdp_frame for MEM_TYPE_ZERO_COPY")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/xdp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..4bb97790b189 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -585,7 +585,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 		   xdp->data - xdp->data_meta;
 	totsize = xdp->data_end - xdp->data + metasize;
 
-	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
+	if (sizeof(*xdpf) + totsize > SKB_WITH_OVERHEAD(PAGE_SIZE))
 		return NULL;
 
 	page = dev_alloc_page();
@@ -602,7 +602,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 
 	xdpf->data = addr + metasize;
 	xdpf->len = totsize - metasize;
-	xdpf->headroom = 0;
+	xdpf->headroom = metasize;
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
-- 
2.55.0

