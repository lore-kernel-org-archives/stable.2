Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10A2848AA
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063187; cv=none; b=d4YN23rMib5OOMARSOrlcRdWVEGyRbbhh+sCf2WN6U7of4Wi4H5fEKJPCWL7MMA5zC1icEsWk9n2u9wK3cQiSqmP6I8va7btI5XWWZx9VDaeG1ywI0dkYOrbmcOTF4Njegw5aWRuVtK3OwSkOj3s+qDOlgMOslx1qIYuy8qEW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063187; c=relaxed/simple;
	bh=gzrrEiwtcJ9ivwLoJnL+m8n0FS7ubVze2VOLPpakTLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNtRJowedFa5jgV+tEGxdvuh7s+OFsdpRbm5mlqNjtdzzOK8/CNdRUCm/Du0Uy6FZ4RqDMqisP+iue9qfsAZD2vWh6oZ8ZAixjMY4LUhRxS87hwp8AFqsd1M8jAVyvCVLy0LCZctYiqsEyWPxWQbEO3TIu4yTYJCwT51/A528i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb45bJJO; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb45bJJO"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137335bc3caso5526908c88.0
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782063185; x=1782667985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/VThkN0DzvQ1cJGYXECCnKHRSweermGUmHPNf82Maw=;
        b=Bb45bJJOnW2gZI/MoOH2aN6SFbgp+FgFBKX92TLNsDLD2NeNUy9T0FpU5kbAQvQJQa
         d6JZWpJD+IOGQzvaifzCalDgOanoH5IUXpHBVd4EMz69EadslkOwg0oDNW9CG2RQc5WK
         2+2O2w23mC2EtLJ2ui5ryuk+HfgWhIKdLN/+ME1PB2FWgDCZXf+k+W93ESqUMtE9CPh2
         SykioqLqsTdTx+6ezE5CcXiUlSPzjmOZcwRd9hOnI3pAxQbRqmD+VcnbxUKJVVcLBI3q
         hXhBWBybOGdFIw67KHUco4InnoG2xox5HiKx3v9ZeGrNkilFYCLGKanzvmF19RWZksSP
         fkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782063185; x=1782667985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/VThkN0DzvQ1cJGYXECCnKHRSweermGUmHPNf82Maw=;
        b=kVbl3ufyHbnXUWfqemX6Zggk2Y5MW48UDh1VuaNzxp93OL+/TmqRpOJzBIQIyag86c
         amUWrWM8xJvCfOyDtVHe9inDHV8iJqMlrHW8/5es/aOXjv0c+6tsDC04ASNFLw3XYcuj
         d41MHiV+WB1ALaxf2kiHrGM9GuSCIZbjL5z73aBkG1MiRFov7Wm+AgZFT6cHk2+OHpjj
         2WhoIGnIo+DAvmJDQ82pB1gv7Rg47ba+rbvBF9tnERxLvdgr+b+M7jRFtplwi1yLv7qT
         k5yusMpimKMZcJfaegN3nuXHyfll4yTWDuGUfgetiKlkoOr6Pre7rsE3MaGMqlow0anP
         CLgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VtAgd6uILHTKrcYA8fXmFsmmc+RslUu1VPsmnqqJ/FlYBJ0+5ls/7pG+KB6L67fg+/yRVtKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzabf0ZVOfWdtAaSEOR0rLlgFf/xC3C2hW3BccFxv3XZHAnlNor
	MyZBOKO6o6wLBqjnJmVy1hGuZrsAHpAQK70YCete1ptqq78gG4SMJHfMEtyR1ahmlTw=
X-Gm-Gg: AfdE7cmk1Pz8qvnTt2OrascSItQDfN4gsq1TKdNb5WBBNuYbRjUdvEcW+dXkNQkBCMU
	nnpSh5O/igiXz84jvxJ+Qun/TP81HeOj6DjLZyw6sP3KDBeaAAmpjNQ7Bc7YbpOtyh3TnE0DHWK
	pCIHCyDPMF4lT9oPQnBwz4chmJWT6EuypwcTCRm0tsQ8JZnCmF2MR/2zSJsJ/9dJDwPOMJqPOib
	tWQnfu4ni2CkCPHcd+nVbvZhnrshEbATZrFlx765KhZdXI2/Kk9iKhvcTX99pGs/LUtCSFZJobw
	1qJLU11xgCuSTquWlXuL7d+tYAs8b5AfdXgYJGWtT2GD3F77NQv7BpU8A2kOs/Hg6MWiOkKgcs6
	GS85qiYUqWa4HhbbSVV7+vtSCd6+qlJPb6j7MkNmpNwLkW3OYYvdaWjYANMEthvILaAIDb6W0t9
	JFY3tRGqCvoMd5u3KoHrqy3PyvnCKbHEKMww==
X-Received: by 2002:a05:7022:608:b0:137:fad9:3a30 with SMTP id a92af1059eb24-139a365c5a0mr5970356c88.19.1782063184980;
        Sun, 21 Jun 2026 10:33:04 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:33:02 -0700 (PDT)
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
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v4 4/4] selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
Date: Mon, 22 Jun 2026 01:27:35 +0800
Message-ID: <20260621172735.409355-5-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit cfbf25481d6dec0089c99c9d33a2ea634fe8f008 ]

find_equal_scalars() is renamed to sync_linked_regs(),
this commit updates existing references in the selftests comments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-5-eddyz87@gmail.com
[ zhenzhong: only two pre-existing comments still needed updating in 6.6.y. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1f71f596d33f..07a2527a8f47 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -392,7 +392,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	*(u32*)(r10 - 8) = r1;				\
 	/* 32-bit fill r2 from stack. */		\
 	r2 = *(u32*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -431,7 +431,7 @@ __naked void spill_16bit_of_32bit_fail(void)
 	*(u16*)(r10 - 8) = r1;				\
 	/* 16-bit fill r2 from stack. */		\
 	r2 = *(u16*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
-- 
2.43.0

