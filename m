Received: from mail-pj2-f19.google.com (mail-pj2-f19.google.com [74.125.227.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1242466B1B
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921976; cv=none; b=GfOfuAMaXNGFzKi94jz/woOX19vlOC0idTYbtO+jgSI5DVx1OG0JViG3KYL3WoJbOCYVw9T1kSAN3pVDkKrRK25gtW3u+1GPoHaGF8TbDP113ufNTt4nJcRA10jzuoN6BCvQKAaCHFiaRZq9toEeQMZWiNuIWySBY9AOOwxAZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921976; c=relaxed/simple;
	bh=ISMr9k/4ayfp7cIsuOtuFI3mL3SoCez2K155WDMQWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQDldUCyzPTftFQyo4t1Z+W+W8H9CYMhl7wUd0jx7N0XPcSUKgXXm+hSRUe6A7qjb5NBrxsNFZmaVV0nwtr6/sneKiI6niLogKmuhtKGk927SpnILtfa3cVzGV4uYC8xvX+e5vcjV6NTnFCI2cWuUerpwQBUMWMThBQbp/adatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB4EHrZy; arc=none smtp.client-ip=74.125.227.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB4EHrZy"
Received: by mail-pj2-f19.google.com with SMTP id d9443c01a7336-2db18fe433fso19427865ad.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789921971; x=1790526771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxrYw5XYqojCDttriJ4CNjE+Rxifl6ZmijYb7xfnw6E=;
        b=SB4EHrZydpEUlLfwAIrxMb/vSHzMILHeky8mJrePffr9xV/4uoNxd0IcWezRAtp6aI
         mp2KK8qQ6ud98djfGG8C2EpEDn2Dq2ClxMhmEb/NdpaZvjFw1SDgbtx5b6NiaM1ma7Q1
         YthFBhKJd9H7GrInfl4D6n0raeu89h7pOdGeQ2yhAi+yYxZ30f+QEaNwJH96gKBb9UeG
         izxgqDA+eu/plJfl9VPUI+GCCjJ4xK5Xtg9Gn+SrkELJSLDtrNYvXMRqwu8avXrpyFCi
         2urqYrT2e6/hkyjk7nu3j9t3N7n8HiYVKD+AksT6BMz15d8N05wbQtrn/5CDNtx+UgiQ
         NMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921971; x=1790526771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxrYw5XYqojCDttriJ4CNjE+Rxifl6ZmijYb7xfnw6E=;
        b=aCrGeZT15ZtJOmJ4lkl9gbJPOlRsKUYb/ZrddbH3X0j3woTvYZI1wmurQBdu7IDJP6
         HDWs+ICpnKnCEiNgE+OwxfOOFUVjNbG/3qrBJ1SIoM/b7X7HUXOIoufDDWCyg+bbMxcN
         rpy68VXV51y41HCJTSLx7UW+M96iaytnkKYDmQ+a2cpTmSu6STOp2bQR9mm+L0DgjurZ
         +OaJprT1qiKXLNnooLjzHPdEaqGV8pcDmEL/lJdXFuZfzRZIm3o2g4uROTw82vIeU9c8
         bZCD+LpqD/Jzd15O/qSFDbzXrIk1uNB8VS0w+ALtUjk6Csv6Ja5U4LCnC6DIcPoT7OGc
         kBPA==
X-Forwarded-Encrypted: i=1; AKwUvBxJafcQZ4+uS+914eM19UIFzEx8VBFUcDVdp3gxwlFhMg6RrsGYnAQjodX8H7xw9MZvDPHkgUM=@vger.kernel.org
X-Gm-Message-State: AFuF++mNGPd9x0GR1lzr+rzG04Z7Y+flZOFJ+8zwLh4Q58pqkGGSMUyr
	7Z6bmRU4+Iamw83rwktWHTRVSkuiQeFUrnGVl8HfLuOsnVZpiPD2HS5x
X-Gm-Gg: AYBFou2GwUtRKZiyDR9JlXzibEIiTgptelDEqCDRt+vWbWW2XNbrvLeMX98AggEG8o8
	la9e0pY8psAhy/D7glrmsApj7ylZmsSRAYJno0BvrX1bubVxtGiYqKhqKXUUbX/ciXPHVkCsMNa
	ygsMsIgTAo5VhiUy407GsQgJ8ZymJBk4BzRytZP2HciZVWF8uDVUH/4pwLloIn2K77/7Xguqy4O
	V/oWikDles/bIGltrA5sFBYDw5HvI7vWQJdYdnAqhaB8RM2cS/W5UpgzvwKGuheC5t+U+HEGaoJ
	pul0iJk/O4HE1gtyRIK/NxPQIeYriLntSqloMVxSEOS89tuAzjmYSpiMyDeu27Xmr2dfXLVJZKj
	qMkX0GvVnXHxZDTnhrQty0MdEVQDCm5eJigeKCYbofKkNzPQpgW1FfNRlgVUuet3jO6ilqHoUPz
	uBvYohftFhTYbrUS/cYkdVOrMg/MxJFx2SQRaRk98wDoJDpCSLcTqNZD9D1+/LdxGCNsOiZuBVB
	VhfV9IQQrUjmvQDa+6n0y+kIhPQmzNO
X-Received: by 2002:a17:903:380d:b0:2dd:c100:b2ce with SMTP id d9443c01a7336-2ddc100b384mr67923315ad.57.1789921970736;
        Sun, 20 Sep 2026 09:32:50 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm21784355ad.70.2026.09.20.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:32:49 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
Date: Mon, 21 Sep 2026 00:32:09 +0800
Message-ID: <20260920163211.795547-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920163211.795547-1-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_run_save_cb() and bpf_prog_run_clear_cb() use the target
program's cb_access flag to decide whether skb->cb must be saved or
cleared.  An extension program can introduce ctx->cb[] access behind a
target which does not access it itself, leaving protocol-owned control
block contents visible to the replacement and preventing the wrapper
from restoring them.

Make cb_access independently addressable and propagate it to the target
before activating a replacement.  Wait for wrappers which observed the
old value, and snapshot the flag once per invocation so save and restore
decisions remain paired.

Cc: stable@vger.kernel.org
Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/linux/bpf.h    | 2 +-
 include/linux/filter.h | 7 ++++---
 kernel/bpf/syscall.c   | 6 ++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c3..606e7cf397af2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1864,11 +1864,11 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
+	bool			cb_access;	/* Is control block accessed? */
 	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
 				jit_required:1,	/* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
-				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
 				blinding_requested:1, /* needs constant blinding */
 				blinded:1,	/* Was blinded */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc730..788c2d625db4a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1047,16 +1047,17 @@ static inline u32 __bpf_prog_run_save_cb(const struct bpf_prog *prog,
 	const struct sk_buff *skb = ctx;
 	u8 *cb_data = bpf_skb_cb(skb);
 	u8 cb_saved[BPF_SKB_CB_LEN];
+	bool cb_access = READ_ONCE(prog->cb_access);
 	u32 res;
 
-	if (unlikely(prog->cb_access)) {
+	if (unlikely(cb_access)) {
 		memcpy(cb_saved, cb_data, sizeof(cb_saved));
 		memset(cb_data, 0, sizeof(cb_saved));
 	}
 
 	res = bpf_prog_run(prog, skb);
 
-	if (unlikely(prog->cb_access))
+	if (unlikely(cb_access))
 		memcpy(cb_data, cb_saved, sizeof(cb_saved));
 
 	return res;
@@ -1079,7 +1080,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	u8 *cb_data = bpf_skb_cb(skb);
 	u32 res;
 
-	if (unlikely(prog->cb_access))
+	if (unlikely(READ_ONCE(prog->cb_access)))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
 	res = bpf_prog_run_pin_on_cpu(prog, skb);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7bc9ba9b331f..43a29e47c8d01 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3812,6 +3812,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
+	if (prog->type == BPF_PROG_TYPE_EXT && READ_ONCE(prog->cb_access)) {
+		WRITE_ONCE(tgt_prog->cb_access, true);
+		/* Drain runs that observed cb_access=false before enabling freplace. */
+		synchronize_rcu();
+	}
+
 	err = bpf_trampoline_link_prog(&link->link.node, tr, tgt_prog);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
-- 
2.55.0

