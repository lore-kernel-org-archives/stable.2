Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800744ED1B9
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680256; cv=none; b=YJLAH5oeCVIQjqpKk2vrd9VP3XMdfvgX9GE/U2+r02I3ElBoY+cVCNvv658zuX6O0Hr05XpH4U3xP5rPSTRTx9dCKvO4boDnWFXzjiGdUoWKGWne5GwDXaZvb4wQpCgOGyFZCLaDV4naxaQOrXvoPC3Gkzv/qQubJVrtn3N81Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680256; c=relaxed/simple;
	bh=JQwsMoeEs+CNvmeMuWW13D3vM2WUci5TzpK0FCUtx8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5gL+vYk+UNSemul57muKRaeSIBmVicEKykgqGJfGP+od05TrPgwz6xGRWL8jtZlyzf/llJZheKxR240KuDOLQ1h5k8TWFzZU4ti9cPrf58KHlcWGJhS1JTfucDnP5MmMCQoMX/ncMAyyFv7QwNaQw6dV2+Uhha3rs1TP9p6VwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHaaweRB; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHaaweRB"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so11049866b.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789680252; x=1790285052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3yXwVGjA/NLuu/ViMF+woKwPwB53HNXmf8EmdCK+hI=;
        b=EHaaweRBE9eOZEozJ02TsHeYR7Jb5omQJ/nQqF6gWLgafq7JlfqgflLDuKocRynEAc
         OKaWkLedUm9gbIZrJ045xhFxeTbVLmg+f+m6hqRh0ovwJTGbNdczj0rVrfHekt/Y3BUN
         RbkXGf+f+G5hr5l4R3fRT3qnomrwcpLly4Ey3oi0Uxh7jupJw7GUBeJXHz3zlRqOv2uO
         49l2oQobtNPVeqQIt4vXulYosXjCHgqLCQ9mBx38nZx9NLyV+qU4sx44kmzjupQTQ66m
         CmkEdR8KZ+4630WtQ7ZBUyYSkr4wqDkOO6DVEe8t0SdvG5yrpNsB5UPyguTXoYqvtGdV
         3AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680252; x=1790285052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3yXwVGjA/NLuu/ViMF+woKwPwB53HNXmf8EmdCK+hI=;
        b=EyDlEufESZKzxYIxHxbrNQsaTMUYzyh55wCQLmAK3X7if9D+9X9kPL73FiJGG2hL47
         EBOrxJY1NbAASXpwf3KtmAIrRhRZXME0GOpqJJEjZOhJ1Fubegy0gnQK0vuLytZRru9n
         Gd37w4gmMD4ltTcfkebtAq/FMGJtRCv2yBrPfuPuJEXv+KSqjBQk7bHy5qeZt+90ebNz
         DeklYLTDS0MVylC89tPT65DJd5422jaZn6WfA8ifswXT9/bidlnnIR5qflJN2wycCWhW
         rBYowkG+WYePlwoW75M0KqtujUYOu9o9XTLst/seL4+/PxkGEkbryIWvZJkLmYoUsFmb
         B3gw==
X-Forwarded-Encrypted: i=1; AKwUvBxTXNHbQeSbN666k4qHVqT9W/U6kiaDj3rNVj43o7Bd5qgSv9uexS7cBPHVN9w/lA06H8Cbv/8=@vger.kernel.org
X-Gm-Message-State: AFuF++mvJ3Mgi2vf1Hdg2oYNlCgWyH5WbblW1vTvpuqPAcZ8JmDqNe4J
	buslkUTq/JOrcQxnGxQt8AbDA8FICLvWnIR34e/LjomrmIIpBT5L2Z/A
X-Gm-Gg: AYBFou0HpFWn4HFEZ38SyLTQ8s+Rc6yN0kivE4/YSD27mIuZKtZ5xGKcSLNzRd6b9uB
	uOkfZAVm3G0wRt1dK2/zeVHl90H2cET9fqf4aFSmE4wl6z/zC7jo20GEF/kp9yvn+6vag7FgqSe
	B8p548qMCSwFVuB8XsEJJldQcbVIh5QAuesFqz5s2e8+/lSoZ8rSrePPEVUNczWlNpLV+mmeSX1
	6J5vVwbMAbHYU7A+FYG0OzcTVfbhqmonmltkY05mLzN20YnGg2l2PbXqgbx5XVzwiQEoHEvVo3G
	Sl/5QCl8uFwpYNVrJJ5ck2j2TkwuxdEYtuqO6MHhtaCXo4GWA5ex7CW4Btg592oJrjgWx1M/sa8
	X889pz9fiGNDXSCCYdJclTwgU1B11kAErPa/Q2X5hyVgrThcFjwttiS114gfTS56h4kjP5nAfZE
	4/Dln8HE7cW7Q1CqAx9j38waAW8kLW5fnxmKOAcpyxAqxpcSxEYlcTH1k7Ay+Z4hPVKTp9bHBLZ
	TrtR52IYVvie4VLNjwq0sjxqSaRxcBgNBFEMT0uL1u//ByxMUjtPqHTg/M=
X-Received: by 2002:a17:906:99c9:b0:c29:61b9:7b3b with SMTP id a640c23a62f3a-c2a15829440mr43455866b.49.1789680252094;
        Thu, 17 Sep 2026 14:24:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2b0899sm4203118a12.31.2026.09.17.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:24:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com,
	martin@kaiser.cx,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] fprobe: Terminate the fgraph_data list when the reservation is not filled
Date: Thu, 17 Sep 2026 22:24:07 +0100
Message-ID: <20260917212407.384468-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
an exit handler, but only fills it for those whose entry handler returns
0. fgraph_reserve_data() does not clear the area, so fprobe_return()
parses the unused tail as headers left over from an earlier call, and an
exit handler can run twice or despite its entry handler asking to skip
it.

Write a zero word after the last entry to terminate the walk. A zeroed
slot does not decode to a NULL fprobe on the arches that encode the
header into one unsigned long, since arch_decode_fprobe_header_fp() ORs
in FPROBE_HEADER_MSB_PATTERN, so make read_fprobe_header() return NULL
for a zeroed slot.

Fixes: e0a384434ae1 ("tracing: fprobe: do not zero out unused fgraph_data")
Cc: stable@vger.kernel.org
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/fprobe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1e9b00997ff2..9f2d98181779 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -171,6 +171,11 @@ static inline bool write_fprobe_header(unsigned long *stack,
 static inline void read_fprobe_header(unsigned long *stack,
 					struct fprobe **fp, unsigned int *size_words)
 {
+	if (!*stack) {
+		*fp = NULL;
+		*size_words = 0;
+		return;
+	}
 	*fp = arch_decode_fprobe_header_fp(*stack);
 	*size_words = arch_decode_fprobe_header_size(*stack);
 }
@@ -203,6 +208,12 @@ static inline void read_fprobe_header(unsigned long *stack,
 {
 	struct __fprobe_header *fph = (struct __fprobe_header *)stack;
 
+	if (!*stack) {
+		*fp = NULL;
+		*size_words = 0;
+		return;
+	}
+
 	*fp = fph->fp;
 	*size_words = fph->size_words;
 }
@@ -635,6 +646,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 
+	/* Terminate the list, fgraph_reserve_data() does not clear it. */
+	if (used && used < reserved_words)
+		fgraph_data[used] = 0;
+
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-- 
2.55.0

