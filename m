Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AE40F72C
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815680; cv=none; b=gIkCgkCQ17NbcpaPwAXTQklcYMSuo2aGyj6WtfvIAHTF1y9qFnnjlxpMHUykT2fZvzx9d/DJ0NaFX20/chh8jTJP+GTqcVW3EmE8sJxlZANs/XWhhOG7T5xPsoFhpkwhY3Gx4jM1dvbztHs4EvQL9gWBBav0Nu00ekgjI1I3NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815680; c=relaxed/simple;
	bh=Wn9+l2JU84UKw0Yiuc7+aPiX65TB6uHIAEb0BYHiXSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf5Nkx3nPH+404XXYMVbJQtseIUl298eAqTUoC7QWaZpPTdFridSbloBjWf64+SAKYY3N4O1GZzRXfSN4r8c0BTlGgNTbj/epvtgZ1p8LLD+8iQRRxBTp7urTF09FNUBTvLDg7QvRslCaPqEd+CD+bbd2qdTfx0pw2vaFC1dHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyTMN9t9; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyTMN9t9"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1264645a91.3
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815678; x=1790420478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7N46zResu6Oq8coyXJXO8ECM93/wLky7ePjmFlAAoA=;
        b=IyTMN9t9wzkxDoQGKqLt13m/xtlfT6VEp09EJRUXqlLrtn6xuXxV9WfXlW9pPj0bj1
         S1kJaRW12hQZjH7rWFNqSizWv3fAOxQZIHRG+WR88cf5AhM4a3MVcg11YSEh6kna1NRR
         X1YDYBJxzRW1KtDvzs/OE9tvhQZWteKdzKK9p/dn2xfExbzs8UqVuIdTQV4IA8dbB3s4
         o9uKkDLDK49uIQ5zDQL0WTrIVFkLNh/d1e1UfjQ3g3+j2H/I4ZsiDBmri9j6K4n6AEHq
         h6r4kyA08QTH49++hQcy8vCLLikh3DJx9ZqQtfj0Nk6yaaHKPhbiyI7Kss+2vcDXT0af
         POlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815678; x=1790420478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7N46zResu6Oq8coyXJXO8ECM93/wLky7ePjmFlAAoA=;
        b=yY+xk8bhIotWRz/dzVrnUqHbwsygRAhJX3GpcMFVc45zAje2UUPQ8Sn/qdbbgD1O5K
         M58IOsA97+KxOj1wOlyYdZf7V6imDZPma/wzXb98NSWMzuW0ojeTbmcrC/0xFF2woNC0
         rkGi/rxhGZLArmAvpy+bc2/pbjIOlOKPvS7L3bAPf0DAiBbRa9etBwWYv6nG/bUQsHpU
         OVqfRIkJJIB9STPEVcFMydsMuz0YPEZbfz3yKI6eT35UO7agwn/igiF2io5lRhWpBbKj
         Zl1XI7rFOtvIGPK1v0k7nxsY3WgaGmdUWXphZXXXSeMSQgJPPPSlHYN1LLugSPYKbAmc
         kKPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzVrS4CCMchbxcTy/buWZzCHkmboUR7Bkl1p1k74G0Y40utiIKegFCJKgtfZVq64MoDiecmLY=@vger.kernel.org
X-Gm-Message-State: AFuF++l0rg2tK0ugRN5mZ3f6/vnoi8VPTthWEXs24+hVvB7sFjYAaEoo
	7PHZIROFzGivDywWFrzy09dR5usJ/NDXlKQk8P1dhTm2QeggVseAaABB
X-Gm-Gg: AYBFou0lQp3U1L1jmWtu7w6RDD/LyioWqIsQ3zIucU8ALss0eGPFiAHX5WdlWa9XXAQ
	Y9l+RWNJotHxAlK7C0gnKODaHXFUlKae/vkjufyRuApEu/H1bAQTmNs9oPaNRoBy9kQOk6KKd74
	6ceDLMB0cdr2ZNG8tlJz3ovyaABFwzhVowCJOBXgV8sKLD/bIh9WsFMpxB2aBf4tjmsT8aq+k9O
	/5C67qMlwnU7i2g+VMtGXsHYH+BQMeL16H9FZZmqbpi7xDqMky6+Zo+R4opMyu/QQx9qBmg851c
	Ehh7AwzusHmuXGV91mRQQpsRZ0BVTdxZvO0VhC/EL98CxjCXEvtbXTjvYRkowddGUX7rxt+nQjH
	dbM/FBmXhPxl9vzT3EpGkvZGFJYzhIYVyOIAvvTqNW6QeAFuWQ3K67LXtO36+As0hsqZsNkxXBe
	fmAg8eBz3h1WS1qcNBboPItSw6J4uAmh5gW27yjA+2FT5zyqyk9M1mpYf8PIC/GufI7SnbrphnI
	1FrqMy2ApUKP8+iAiBy//1Coh0ib9Zz
X-Received: by 2002:a17:90a:1057:b0:39f:d323:c988 with SMTP id 98e67ed59e1d1-39fd323d93fmr1553771a91.48.1789815677698;
        Sat, 19 Sep 2026 04:01:17 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm4147054a91.11.2026.09.19.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:01:15 -0700 (PDT)
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
	co+ac0a8c41de69121d@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: reject dev-bound-only programs on other devices
Date: Sat, 19 Sep 2026 19:00:53 +0800
Message-ID: <20260919110053.497301-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal. A bound-only program on an
offload-registered netdev can instead inherit a real offdev and match a
sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfuncs
specialized for the bound driver on the target driver's xdp_buff. Running a
veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
veth_xdp_buff.

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
Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Drop the redundant offdev NULL check.
- State the capability requirements instead of using attacker wording.
- Move the regression test to patch 2.

 kernel/bpf/offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..d85539981 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
-- 
2.55.0
