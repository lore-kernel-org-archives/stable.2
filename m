Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0262BE057
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852225; cv=none; b=E13CwrD3p4kT6I5TXDJgJLzAjVx6gizQZOCPkrQ/cXCwqJrvKHldCmouo8jU741bwF59p12rBgK1tEM124qTaowZTUnzQ7OUe04aiwTHQTu5Pjsq/N4ZJagFy/OCfkaoWJyb68QaOW7ydDpJeRKZoNDicP1GtwY5ZNA+Q3J0lhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852225; c=relaxed/simple;
	bh=R0B+wsENjA8ZzQNVV41noFQrCBBvZhllbql1zNNXSuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf9pef4EMwNsRuqNKHQyPBQq6SraySZ4FnKBHnoUAtYUJw0obqHldI32VkR04jqWlowZyT+D9sQty7g23AIsxTB9OdzmLw+fj2Las8dWaAc42y1rM+UigQH0Rg7zm4mQklk9TjWtzmGjZ7W7ocFKb15dgK5wGicdw7UcmToUOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baU2Q5al; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baU2Q5al"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so1288424a12.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852223; x=1781457023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yGPIIhFZdTIFfBstBwjXBL054wfOH0HNW4mEikIzLI=;
        b=baU2Q5alPeotmoK9isaPu9rDpA+7We4H0jmNGUoj7K64MPkKe5jXMVLJRZysLpkCdf
         WVETRxojIcHJrsWxQ3BD2KPrhB/Xy/bDAQ7aDowOthkZQFf3qMZi7lnPM6QHwNAikdFn
         lIZJekZ423/1zPncQRjCyMxkuMF7CVwzRYFd8NYj9G353vPkZcw7uG0t57bFY+cNm7ft
         2SaTb6hlnqCibXXLvKS1tZyagFUsWITYHI2xyBbemuizq27Hrp1bL/dWHM01JmqWc6YA
         4Luqwj/tiw6utOueeQ5xr76tk/MJFFRCTyyYh1T6rg0zS7Km66UdmGZ5fR2+5gB3cSxC
         0IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852223; x=1781457023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yGPIIhFZdTIFfBstBwjXBL054wfOH0HNW4mEikIzLI=;
        b=ficcVueM3OxmcvPkTvEm2LcYDYHOmFFuZlM49I/6+D0WaTKGaYla9RZIFF/6y1OiLL
         +aB6biaEFpFqkhlAfDsonNKaAsrrxOx+ISqGgWvpTSJjFpbWdZPeR55OmoRw0D5vBDU3
         mDels4CRqzu0v3UxX2hSKjppVL/VLJDizoQQtpRvWUoMVuwN5MGZdAvwZOMsUZ6UOZIU
         29h2KGOx5RfJKg4SmywJsHEAvayMm+etErunXrgMFsUMmPlcMBGF7wXt1uyRcULeIAhb
         wNynn8odZno0SDwMjuYT9+gi2OcKH+qTa3w3z/Znv6oMT8ZSo+AcgNUQuywxAw5dsdlY
         mq3A==
X-Forwarded-Encrypted: i=1; AFNElJ9nTt7cAiusOjrA0aCANDv0cNmujz9kj41pq17l8QrHEcStYwe0KS4okDuS1P7NaX658Dl00nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzFTsyVFQIrIrjeWDDetYwfLQOHzEOFjcnLiyk0JZsADzHxKA
	cR52rAhDM42hXFRFzMlW7HjkHTrfGD8KVavb4Q3FrpcvAkz4HudmPKpb
X-Gm-Gg: Acq92OHCJoXwVA6sdnhcFOdCrS5T7KwDraxVYGkuz5jJAhp2hlgU2xNJsFWF4jR59Kj
	Qza39WKtQMPaTpT5Vm2OeyVKkzpgNMlTKvkJXOaHCQKZYSaxacEFYCgYB0SA7a7GCi5yJyYx7ZF
	OhD3bV/nGRTdWHihL3elKrprty5VgzGuqE8PAR/iTvHg41vgFZ7y7CaI3m6DElhj5J/9KWsptU0
	YQz0RSlUVJmpzjn97OdL9uwJCFFzajzbtf9AN001oqtxPabpQsdz18ClTy59ebyZ5AzQIZw8312
	1qvvVR9edAsVmlpMdN0emqKnLbuI/ws+xraTtoB05/8xZ+7PNBC1391eriuD6uQ2KN/6zZtbtf5
	4DnqfK+g8rjS6gULMEs7AyApwVmGYLb1JpsSSjjKvXvPRp//gvEs9EZcRC67ZoDRjjy+JqvZPgb
	TKsuzISQyKFBoZrCr5ASyuK50D1T3GrZ5tyZbu2LyisQ==
X-Received: by 2002:a17:902:d4c6:b0:2c2:5446:30eb with SMTP id d9443c01a7336-2c25446352fmr26955575ad.11.1780852223265;
        Sun, 07 Jun 2026 10:10:23 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:22 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 2/3] bpf: make the verifier tracks the "not equal" for regs
Date: Mon,  8 Jun 2026 01:09:57 +0800
Message-ID: <20260607170959.823755-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit d028f87517d6775dccff4ddbca2740826f9e53f1 ]

We can derive useful information for BPF_JNE when one side is a constant
and the constant is exactly at the edge of the other register range.

For example, a > 0 can be compiled as a jump if a == 0. The equal branch
marks the register as known zero, but the fallthrough branch also needs to
preserve that the register is not zero. Without this, the range can remain
[0, max] and later verifier state pruning can keep an impossible scalar
path.

The upstream fix lives in regs_refine_cond_op(). The 6.6.y verifier still
uses the older reg_set_min_max() layout, so express the same branch-edge
refinement there: for BPF_JEQ, preserve the known-equal true branch and
exclude the constant from false_reg; for BPF_JNE, preserve the known-equal
false branch and exclude the constant from true_reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231219134800.1550388-2-menglong8.dong@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: backport to 6.6.y reg_set_min_max() layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f94bff12..de4f46796 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14169,18 +14169,50 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		if (is_jmp32) {
 			__mark_reg32_known(true_reg, val32);
 			true_32off = tnum_subreg(true_reg->var_off);
+			if (false_reg->u32_min_value == val32)
+				false_reg->u32_min_value++;
+			if (false_reg->u32_max_value == val32)
+				false_reg->u32_max_value--;
+			if (false_reg->s32_min_value == sval32)
+				false_reg->s32_min_value++;
+			if (false_reg->s32_max_value == sval32)
+				false_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(true_reg, val);
 			true_64off = true_reg->var_off;
+			if (false_reg->umin_value == val)
+				false_reg->umin_value++;
+			if (false_reg->umax_value == val)
+				false_reg->umax_value--;
+			if (false_reg->smin_value == sval)
+				false_reg->smin_value++;
+			if (false_reg->smax_value == sval)
+				false_reg->smax_value--;
 		}
 		break;
 	case BPF_JNE:
 		if (is_jmp32) {
 			__mark_reg32_known(false_reg, val32);
 			false_32off = tnum_subreg(false_reg->var_off);
+			if (true_reg->u32_min_value == val32)
+				true_reg->u32_min_value++;
+			if (true_reg->u32_max_value == val32)
+				true_reg->u32_max_value--;
+			if (true_reg->s32_min_value == sval32)
+				true_reg->s32_min_value++;
+			if (true_reg->s32_max_value == sval32)
+				true_reg->s32_max_value--;
 		} else {
 			___mark_reg_known(false_reg, val);
 			false_64off = false_reg->var_off;
+			if (true_reg->umin_value == val)
+				true_reg->umin_value++;
+			if (true_reg->umax_value == val)
+				true_reg->umax_value--;
+			if (true_reg->smin_value == sval)
+				true_reg->smin_value++;
+			if (true_reg->smax_value == sval)
+				true_reg->smax_value--;
 		}
 		break;
 	case BPF_JSET:
-- 
2.43.0
