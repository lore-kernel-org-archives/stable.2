Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6711D5160
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286152; cv=none; b=VWiCytD5unVM+td27Z72Z3LAO4d5JFIMYXRaICeSxCDV+Aj0f/E/SSrqAKnHfIZ9vUnDFquiLgb5RgzPvY5RDcV9R8rjqUkrX3RXDSsdM+wt4PlI7fKj/EYyBCQxd8V4/AX5LqnXjZllrUKWosF0vNCa8R+IDAjuTqzepQ+eBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286152; c=relaxed/simple;
	bh=gvBmCBqn5+uUthgyL/Yo5EJAHOL6uLjcL31etUlterw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSkPheYbWcGxICxwhi1PZmigrGV1UVT9a63u/PyuPB0/1JJL2N9MhGVBkw/kzYdAtwtLNKTjGaPNO1rrU8G8efkwo8yZ8BjVerNMTLogJovOsfpDfhaMx1qSigFA9xZSXpYn0ma2qTPDSLOq5v435LxcasPKouiK3z9Ow6plkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKDDpt8Q; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TKDDpt8Q"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c08922c23ebso89437666b.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782286149; x=1782890949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=//zWkE5eXuOOvL8CKayhYFP5cUFO3Bzt9/t1TnfnhDI=;
        b=TKDDpt8Q6V/W+Fbwcy6TX3g4bWMIjyb45fDwg54yS+CPTRjQDX+45V2nCDsYtuNu3x
         2MbL3Tcdq3juXip8fmID043IV3Vh4MReqWt58/bClmmi/SYqASXSee0bmN3q8lXbgjuU
         U6iHeb8v0dTBnd0MeSZR4x6qVkaMseGs3hQiLE6BW0IxKz3Ki9oB7VEMY1UQPjc3U1t8
         SsOjMq7nP09Cd1YuxKE45aK5+g3DFc8Ce/j/lAknCWXkCN25dumrG2dz9KIIKAmJ39/D
         8Ed8zI0LNr+pCbOQLGQg4KjKribA7KG97Lwcju1xOMOkQF5DBwwGhEFpYeNJWHk8sLPe
         IZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286149; x=1782890949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//zWkE5eXuOOvL8CKayhYFP5cUFO3Bzt9/t1TnfnhDI=;
        b=PV4dVnvfIsR6W74gLr/raez8TSoXptvvaIjNxq2bHSzO3Xan/k4Ik3UJq2xkT/IJLz
         rFMEA7GSS6Z+L/bI/lXOwDhiHYf8kY6BBofxAK9BsCmcUEO36XdAWvy7GEiyzv7uCfBw
         lOZrmrQXJqygGYbQhqfhmY/RslMXtJ3D2GHNsMi8bG3NNjkSMq2wF9dGVe0ihU/NucD8
         eIez2eWfonq3s/ezZqUPt+mQ19m+9edSH+A8hs80zMeDM3FvhKgsN02mq0/ac8e5BLI0
         Inu7wf18hxQYlWb7ZwFV41P8PEriIaCONKyKOIMV/EmRRXimtJAiYnshU6joUB2N0IBW
         Iocw==
X-Gm-Message-State: AOJu0YwawMY2/yOT9cwVrZRjsqc0fUuXy8QL1UZZogRgk/ncz+DUZ9Mm
	f+wxL34WgGB95NzJc4zeSI9nJeJxAUQMvvD0xcEDgYKYofGyEWsPGLwOeiCZrX4KCZlpXlvNlOq
	fE0YJmkoDOtg3
X-Gm-Gg: AfdE7cml6GHLzijs8ogZM8B/448cNllvKQu6hgf46lEZJd0VjfW8kNxcJEIEhEv7fbC
	O01H+Y5xtGIM5Q2CoQ9RuPW7sKcrpk0dQ5Vw76Yz8y4awzz3tWQTbFzKZEQc+q5gnzBQ+Rw/Ifw
	GXuOOm5E8hgqxKek6rNJ2sayhnWWS7wnBH4IkpziW45aVzkf0dOr9aCL647IFdIr45Eczcv0/yO
	ye3rEj/IJ78IY6CICH9u/QN/34/+S+RqnfuRTvqmAr+LyHa7VDQaKgfpaIxmoWmMcp9pdcfutkE
	YBj7eiwhl4VQu6UlgNQ+AZUOQu21CXb+Y/wY1Q6+GxtDRW0hmbSG5mrOwiU5eDyG27jP6LWWg0y
	s1fTF66MIW7qmYVULPJsA/re9U6W2s3y8PbptpAVUycOmLBxWU6es0u5Stvl4NNndHpFzq9ondg
	GNFu5PvvGmCye+ukIiESNWGaMNO8R+u9HKvsX6L1A=
X-Received: by 2002:a17:907:8743:b0:bff:334:1fe1 with SMTP id a640c23a62f3a-c107d40abc6mr352657266b.12.1782286149076;
        Wed, 24 Jun 2026 00:29:09 -0700 (PDT)
Received: from localhost (110-28-2-172.adsl.fetnet.net. [110.28.2.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5ef74ecsm13146195a12.29.2026.06.24.00.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:29:08 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed, 24 Jun 2026 15:28:59 +0800
Message-ID: <20260624072901.28197-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Varun R Mallya <varunrmallya@gmail.com>

commit eb7024bfcc5f68ed11ed9dd4891a3073c15f04a8 upstream.

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20260401191126.440683-1-varunrmallya@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: sleepable flag was in 'struct bpf_prog_aux' before commit
66c8473135c6 "bpf: move sleepable flag from bpf_prog_aux to bpf_prog"]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Checked that test_verifier and all flavors of test_progs in BPF
selftests still passes on x86_64 with the patchset applied[1].

1: https://github.com/kernel-patches/linux-stable/actions/runs/28080168542/job/83133064970
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a896b80252ae..87e7cc2dc5cc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2905,6 +2905,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->aux->sleepable)
+		return -EINVAL;
+
 	flags = attr->link_create.kprobe_multi.flags;
 	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
 		return -EINVAL;
-- 
2.54.0

