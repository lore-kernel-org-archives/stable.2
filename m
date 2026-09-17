Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE94F4D0E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661651; cv=none; b=ihcUzCaLgYde/lKmNuVo8OpbpFyQHQFgjVPtYANS7zEgOnL/X/NkzmZT1jT16iHveS9jBWtQqQ6XpPfROiFjZSIMb2ziamTUhKTBg1MjtTnL8kcq4m+qF4dncsb3ADb/ZPAOPBPKfSjDlPtpWpUZHb8K8nhc93i7mfjXHyh2z58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661651; c=relaxed/simple;
	bh=CEQYbOWht2A7b+OZw6MvQpQz1NKPJ1hneP2IMPR4sXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJySwl6FoAWyG9uDYmE5Di2vwrnrR17sw28jTmf8v9nFx0sokdimyMm29iOxYfsFDH65j5iI+PA+5KjboqhyWztHNEOyO9Ls7NeMv7RXmgGnBJXOWXYhvD94wCyAuVR2+nHKfaG0aelsQPHzMZp4chrEP0XjwXZ2ZlcjWHiMGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlqHyv1X; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlqHyv1X"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so10438015ad.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789661647; x=1790266447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=dlqHyv1XRsLqDp5qUOXg+/wJ6kuePbWyEjwqg5LTns+wG5J1XsoZPp/05zOFlcUEK7
         XY2ZI0tsUi4subD+GCcnr9gkFh3ZjHWqlrqQiE0QgN/jzFkUcb0sXbaUknzDpFGLpVz+
         aWrysSgYPF2C5WmkHOQTDRxYUhdjt2mXomqv6KscQF1Qfs5DpRR05S7JWCoEJTdYYjua
         rfoyqm6yQbSMwsJUZ8mwyHwBCscj4hXEQPYz3ltpGtNolU9fnGCEyXATAPwZVbIsqu8R
         fVlN7r2lVwjrxjS6ifB4Wt2wYSme8fptWBi1CcVeJZG45uhY41B1InsksZAmk+uNj2AA
         8lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661647; x=1790266447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8bSU+iv17p+dmRAzgAgwO3BTC71XsPeXgtmHePe98I=;
        b=XdURy5eS0eGs7+n72flDw9ETwGO7dzO188XNCs1kvF6E+6QWPjLbyIPgcB2NRRlMLD
         XEmQTzy2Yx0RNVwrNLAkzNRPnxzvhpKvTqqQx/d9p8PGIaSYThma2biaGsbx2oU66oeE
         PXvx4YvDmC2JTzP93f4vysqqCq68cu8NzzorwaE3t3xUd2czKV+nbdyF/JoMoF8r5PiZ
         JzOoML6Kage3LOHdtoyA7ohmrm8ZXipLKZxEM6xGvrEIagXxoTJ/Wpw6Ofx/tXU7hHN7
         pCbacAyaP8liIzzmwG0l4Sc8/S/eSHkiE4wnncpSXgBAeNxbPkfHD5V1slI5ljYPFo7N
         wswA==
X-Forwarded-Encrypted: i=1; AKwUvBwV04bRPL2jW4FpebSvFJCk9tEK3F/oCDHJ9/yLdYHJHnzRZYFmm3feTPzlCfW32ikct9kiEwE=@vger.kernel.org
X-Gm-Message-State: AFuF++mWLWuSfSravk/M8r5zD0k2D2OKQsPJ2QDBoD3EKQ+tg5ioOjRL
	S0/DgvtY4Hr7EaPhjRk1ok2DtrnOYN4lbCTau5y0fpbsifQgHMq74176
X-Gm-Gg: AYBFou2AIRK1aDe6xroWPmniDhEMMfxFznHQTQUZdbIMT10rHUjr5gWornKKNNnnntY
	tUblSFLiKd8l0v9o35G7IY3HTDOIPAp/i/kbHYeVOBzf13KXawyPI6gTEjYD4UKasFJMcPzffsN
	TZpEdob4+dD8b09yPYvsGl5QBYsBqQxx4qnabDASemnl8bmb1DwIT+NElPmfLwsIR2KbLWwRsc7
	OifteuOqRdtNDrg50aqJNrAE+tQZES+Y9c6uAJ0sUpdoMEiblXgh6ea9VgG5v5NPVeGYSDcOBxq
	5/JJ6dI34euC+UP2H0SilliCVLAdScQF3IAYmq52BfXTwLIe7O7FEx/dlUPBqKq2YRfNHGTPFN6
	QWsbVMLTylio5aO5/o2+qqabddcaD7mBhPs3uk1da3IcApUXTjX0b6Qk4RAvG+Xsj4lRlmtYm3L
	DrpiUaMwJay0tAPVRkaOVMFBrAB7if2rr0AcwC1xcORdTvMwnYIsW9eZocZ9BazKHi4UpikjFmE
	oL5S3duvlBRfVDSEKg9CvF12ImUY8LA
X-Received: by 2002:a17:902:e94f:b0:2d6:fd55:3a9d with SMTP id d9443c01a7336-2dd8dc06da5mr150178695ad.3.1789661647417;
        Thu, 17 Sep 2026 09:14:07 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fd37sm29489395ad.3.2026.09.17.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:14:06 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+ac0a8c41de69121d@bugs.sh
Subject: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
Date: Fri, 18 Sep 2026 00:13:36 +0800
Message-ID: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch.  Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal; one loaded on an offload-registered netdev
can instead inherit a real offdev and match a sibling port.  An attacker
can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
metadata kfuncs specialized for the bound driver on the target driver's
xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
stack xdp_buff as a veth_xdp_buff.

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
  Call Trace:
   ...
   tun_build_skb (drivers/net/tun.c:1739)
   tun_get_user (drivers/net/tun.c:1856)
   tun_chr_write_iter (drivers/net/tun.c:2091)
   vfs_write (fs/read_write.c:595 fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Restrict non-offloaded programs to exact netdev matches and retain the
shared-offdev fallback only for genuinely offloaded multi-port programs.

Cc: stable@vger.kernel.org
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: <co+ac0a8c41de69121d@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/bpf/offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..8c91d00d4 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
 
-	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
+	return ondev1 && ondev2 && ondev1->offdev &&
+	       ondev1->offdev == ondev2->offdev;
 }
 
 bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)
-- 
2.55.0
