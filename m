Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686064;
	b=PHb0v50Z4q+VVwx++D78ZWCoXgmajiZky8MQLdH+uryGPqvdRe/jC2D5iLnZBVBhpTp/
	 tqaMGlBpfsimPlm/06FozXNdQIaH3g/8HLtDE8cBH3tErdYPCXeym1bfe1DNh0W8zxzgs
	 XOPgr4ICWGOtBBcqy+iZcDze8mA5aVEmx6nuMGqa5t5LRFfxLUjFZCQerOdDWEaiJtkeB
	 l9yOz7iySnaLIlIVELJPfD0uXtgdoq3IKElE3R4lvWFZNnF0u0llTPuMmbYhMHTyzdkud
	 Co2eobxjRz+D52ExbQT820hMAg+E1z3rpgK05z99rd+OmIqEN413AgswFTKbpeg4R8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3qJyGE4a5UB8YhjOY/fzHOLCz805/i0NwCGq/ktQh8s=;
	b=RIIhk4HALWLO5hJ5zqRiq7gUTuXjObf1a/g21S4fryK5SUU2S7GUi7dx75UMC/GowHSA
	 nyhC1kUO+DuZZbFFS4oxbSS2U6DBGEkL1zjKpzZmMg78tzt3fKkwQjO5VD/kM5s5ZQ2oQ
	 96edzSMnigVIytPc+TbcCJJoqF+/xeEKzvXxJZ3GxuZceD2FoyYi7bSBcEi0qS9MuDZt7
	 3PHCQCmjr0qf53E7xvnVuFlxmf858PcR3zwLRJIr0io2Snhz774ROuJlKdK1na/1qKDbu
	 I8KwXuLggati0b8TzaA8DuY/7lJxJNLkIOoKy7RSQQr6oXkmaNWQqtatbPDDByUs+Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIUueDOB;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC9606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BC9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIUueDOB
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-37628596783so3712184eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794686063; x=1795290863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3qJyGE4a5UB8YhjOY/fzHOLCz805/i0NwCGq/ktQh8s=;
        b=wIUueDOBpnVCEvuV8Dp2/5jiAS+lYJl4cP2IVvXaTwL/NtbOF8E8OqpR1ki0rwgV4d
         Qec5TkPv0LlEh2Y8V/u9Q43jXt1yQmzhpMWLB2CUDZgGmaA3QxIAqDH0yKtxJgtwhT2O
         5bgWymkei0ImgUBzoSsanK+1ZWFBMKcSp9Xnmjz+usNmf59VffX6IvJ+uAMZ6x4MIva6
         Y56K6nOVKvFIOxhdmCokMLbIt0LEN0RrmXyhCSk9sOIgG4HLbEWsInMOfIhU95K1ikJ5
         o6jpnA3CHQTHjXPVjkosZKfqXN/2gs6gqXC1Ymz5ux3Fy07zhmVMY2BhXS4dnBIGDWLi
         xL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686063; x=1795290863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3qJyGE4a5UB8YhjOY/fzHOLCz805/i0NwCGq/ktQh8s=;
        b=hEoliQ88RplpI8OSyvhAi6dYeyDf2+xmb9kzKjcspwKAYXn58B7dyISvWbUb2wRwpI
         hLdQOC48cPRnxnZVazHZnny0A22Vvd5WgqWVPjbCZW5AD6SiHVqWyek+FZQFIGq6glCA
         9RHMrh+YLTAGhCnlY9Q0ckcP+UEAW8jPpRhIGFdSpFAEBRUn5IIuHWoU/MblzhWm+bV2
         +FBZQFZUoILFdd9r4fTbOidJ6UGmPrb2O11R3W5XpiT5XwHxUa7oFcm/1jLSJZESPvnJ
         aeantS/O0a7qXvyqUOr5DNpJkc2Shgkr+W9JujpnnuTpK4sAOkQItqUgC5d+PXnHDh7u
         2m3g==
X-Forwarded-Encrypted: i=1; AL+hErE+8uNsuUwVMmepxns9wCuNhEzsyAdcMAWZ2uGDF6SkXi8oTWfc+0UhXHYpkaqxrbPQXglxp/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VBi+qCcgk76DHkwA+Izu8CXFYNS/wfAdz0pVSx0sXm5gwVTFv
	Nqy5GltBUR3+Sf1tbOCW/mYzCc69N+vR11OS3yloEFS5a3lFpwF8eaYG
X-Gm-Gg: AYBFou1u83NBUbmv0BY53xtt/qlTm6onF1ZRLXh5eXpfZxXdRqjvKBi3M0QSXA1eJmi
	uYkDGJReg1x+jbfN5bOn/p2sVFpJk093QBpFwJ1wGzfGqF+y1XzTFRxGNq4L7SuCCrmINCzW1uk
	qvsRORJY78QV3JucAius8DyqioymqD8I/3+QHTKyHG96Z+LfbOTeLeH+01RQ5Jcl25EA4+4Ulo2
	15uc9rjfDTW4wD4++vJ9Ht/Rst3oRgOqkQfCFId5PVpiTKDAwgD/H+hPdvn+xjskSHc1gDlxM3e
	gocVEGiAb+LLvsdSbUso0n01Tl/jgGjvcOGUKIjX/dKV+IWXol8LLT+SEvhKB87ep0i7OW9u2Q7
	twS9sK0mv+1YF377IkR1ksyGQKB5GmH+pyt2F+6AWRw0jtiCV0mqjeoIBSr4Vqw2y1LtXs9aQX6
	dJGi4JMuKN6CMtvED8mZloPdxOA303q2QCPYftjPcvgeLuTHoppGmqvkVuMlqzu0GdM7w7QLwqD
	cn8Joqio5WZBMofJCvRGBaTzC6zHNeg/C+4t08Sj6g+89c3x/x57KrgEFcsWP2cwFNnsdiECXk3
	1DjvbXYd6oEI10Q6xImShEVSmkC9nzTIgS57
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-37966a58499mr5631650eec.26.1794686063266;
        Sat, 14 Nov 2026 11:54:23 -0800 (PST)
Received: from user.. ([2405:201:c052:b00b:f7bc:3425:951e:ab09])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm23226931eec.27.2026.11.14.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:54:22 -0800 (PST)
From: pavankumaryalagada@gmail.com
To: horms@verge.net.au,
	ja@ssi.bg
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>,
	syzbot+84e27adb95fd2a1fe9bb@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] ipvs: wait for RCU callbacks before dst_ops teardown
Date: Sun, 15 Nov 2026 01:24:09 +0530
Message-ID: <20261114195410.96503-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

During network namespace cleanup, IPVS releases cached destinations
using RCU callbacks. However, ip6_route_net_exit() destroys the
per-CPU destination counters before these callbacks complete.
The RCU callbacks call dst_release(), which updates the destroyed
counters and causes a NULL pointer dereference in
percpu_counter_add_batch().

Call rcu_barrier() at the end of __ip_vs_cleanup_batch() to make
sure all pending IPVS RCU callbacks finish before the destination
counters are destroyed.

Reported-by: syzbot+84e27adb95fd2a1fe9bb@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6af795e2.98e60839.1e023a.00d4.GAE@google.com/T/
Closes: https://syzkaller.appspot.com/bug?extid=84e27adb95fd2a1fe9bb
Fixes: 026ace060dfe ("ipvs: optimize dst usage for real server")
Cc: stable@vger.kernel.org
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 8a3c880fdb26..9c456efe13c7 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -2553,6 +2553,11 @@ static void __net_exit __ip_vs_cleanup_batch(struct list_head *net_list)
 		IP_VS_DBG(2, "ipvs netns %d released\n", ipvs->gen);
 		net->ipvs = NULL;
 	}
+
+	/*
+	 * Wait for ip_vs_dest_dst_rcu_free() callbacks before dst_ops teardown
+	 */
+	rcu_barrier();
 }
 
 static void __net_exit __ip_vs_dev_cleanup_batch(struct list_head *net_list)
-- 
2.43.0

