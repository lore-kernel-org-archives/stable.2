Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661932DCF74
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852231; cv=none; b=EM7NBpsTnbB5Sj05EsuNlCF736ITdsPnfB0S0IbB5//ChMG+i9QCN5wNUOwwKnrtcawiPk3ewzLR8CoSTPSFhfWnmNtXEA2N6+R38/LN/pp+f815NUfd8lrJp+YTIWRoWB9ZdWl4DMGBxTXu+mD+Vuez0+Fgd/37EtaD6oN8f0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852231; c=relaxed/simple;
	bh=POr7Ix06Wp1uWzM/s/uHnlsY2+YTVLr9bOr1tz902ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHo2MNEUprKFpHmZl/QDlW6YbDk11OLKjMGp4Wy6ABYZh/Gzvo7iaud5g84pQ9eeeyDjy2timtZ1MvYhnOv7JZDxeImqZgxQDVdVD4A5cqFwvOyTsZRHBQr8/PxjdyJzxFnyzMK7Tu2sE9tlaqSsdI9RXd5UcMs3UvjqbQpKhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOnqxaAQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOnqxaAQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf237e1433so40784695ad.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852229; x=1781457029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=GOnqxaAQGzQVjv888xjQFkCye5CGOIV+20umJK1IzH5A4zf4/fbK7of3ePnQhItiMx
         9C/rDthzXWuRA0H6mWLZ2sorIAqRbbjUgUzcRhsjIbs0oZ1luD/smsD00xAaY4OzACLl
         zivDjLU09inS7/B6LEfy8AuhLwV0vG0yV3FkVQ8xyNMqISLIcRhyiXZNbRtz2lC1uDXe
         a+5TLg7SgMEss/QL2NSKkESL+T03UyF+JwIBn2WgPAi0T0Z3aO7vk8bimoOSQCqr6sal
         IXIrjWTpWTIiWDPao/oR3BfvOatxLkmuCuhGHy+eUERJODWpIlTGL2RoiyVrEYWm+0s2
         KSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852229; x=1781457029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=YpT9SmMQEYb+SF5mAexerds1AHytQYMt1tQOsjy8PAeRpQR8VD/rMXsBZ0ApLGXLVp
         EKysx7/qmd3ceNoEe6iCTYzeaCwSL8Ip99AG7PWy0rYrvl6lYnHOIl7LwDDyRqXJ1ed3
         V86imqLFKWQaF1jb/63+Kv+mnEiBOUxIjD9PkmXya5YeLxCzGraOn7xDpHKGyaIZD5TZ
         xOD6wHhKyKT7BsvYOUw96AfVXYcRRbi5Qh7pY6vQmcjw50pXQXl47xjy8evj+h/K6eCq
         wFh05wxnv8PfEjLoqU05j6szvjcF7imUa2fk8NkjufRJMNtwtY7Qa6w3fmdx9h+aqU+V
         MJTg==
X-Forwarded-Encrypted: i=1; AFNElJ8mTTWh1HoCkT0P/V1H15O/TE2NN0PgPGxlU79ZmmRyuFCw+KZTVD/aaUOzmh+Ceo1JOIt2v/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJP4gKVXTMeSjhL/25fpYJqFJDpsfyetmvkvnaC6iOuUUJ9bE
	emE/RB53CvqtqObKjxV2tGW0mQ1gWgCYT/Db7hipgN/GcdvcKYmnb6co
X-Gm-Gg: Acq92OHRvf4Bq2inK495cqfW8p5kpRn7MOGcxz93XgQavUP+QfPaMjfoQ0pTMn0JXl0
	dkG9FnjEFOuDw5QW8yp3xz26XsHL0Z55MHfuSKidNABUmhv3tugvHux6nEsRDIKbwDOoBQ9OGPl
	mAD6VKC/xU2niMQGHCdoM0HXiPHfJtBSk+ydRJfjgG/ZSLzbYgSgNxlD9FMNS21VhzVAcF25dkt
	VKt2lWOI1227OzymsEcgqg2kW4XMAbxMJn4/KvdyNJmtFu0BKI+krDEPqzE1qt+6D4plA7l6WFM
	mC8Q9DX4IlmBoW7ZPqMvTkdKDTytSq41JpIoT+butV/qmShEy9yiRdagjzHpnwweXYQN5XW510+
	5GDebHzw+YJsp4uGWYecoRpriP7lnBM4WtyJw9sllUybpZPqhCEmIgEoojhYUApJMj85NBQYXQp
	OfE1GY1atGBwsKTRUP/RGjFPnyfOhqtXvnbBOc9EG6bw==
X-Received: by 2002:a17:902:ef08:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2c1e820e30bmr150565325ad.13.1780852229364;
        Sun, 07 Jun 2026 10:10:29 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:28 -0700 (PDT)
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
Subject: [PATCH stable 6.6.y v2 3/3] selftests/bpf: add helper retval linked scalar pruning test
Date: Mon,  8 Jun 2026 01:09:58 +0800
Message-ID: <20260607170959.823755-4-jt26wzz@gmail.com>
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

Add a verifier test case covering a pruning bug where a helper return
value and another scalar become linked by scalar id on one path. A later
branch can then let the verifier explore an impossible continuation and
prune the real success path.

The test uses bpf_skb_load_bytes() to create a helper return value in R0
and a scalar derived from the tc test packet length. It then links the two
scalars on one path and checks that the later branch keeps the reachable
success path.

Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_reg_equal.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30f..269b2af50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <stddef.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -55,4 +56,38 @@ l1_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);	\
+	r5 = *(u32 *)(r1 + %[__sk_buff_data]);		\
+	r7 -= r5;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r4 = 1;						\
+	call %[bpf_skb_load_bytes];			\
+	r6 = 1;						\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+l0_%=:	if r0 != 0 goto l1_%=;				\
+	r7 <<= 32;					\
+	r7 >>= 32;					\
+	r6 = 1;						\
+	if r7 != %[test_data_len] goto l1_%=;		\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0
