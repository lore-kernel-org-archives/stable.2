Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC553A9630;
	Mon,  3 Aug 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790967; cv=none; b=gHWH7H26fIF2gLBMst9XSGDGVH5F0PHp3vKfyr+zZQI2YegdamwuCEDCKt1jVoAu3uX5nlxbdsMveeHPKhq8EUghbsjR1CNCC+/5o7qb0tl58EHQROl0FyFjvmvwv6nbrpWP+p3oMIq5o8NU3WkInxrT3xweyp8gZJyPG/wOi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790967; c=relaxed/simple;
	bh=lGP2X6dSU357nY8L8mbyIrpAFhTeWZvjNedNM0w7XUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6CayhCLeyYnatwrwIOKeGZ86LvskTe3TOuYYoMrTVdVM31Gaf1X+P0XSubwaiK4NOEhGSbGzj6LeqjK2F1tJOX1cgsH5y0RXMwecVndXJZdna2tDuV4RkoSipQIv1Ed26jtakMZyq+AMJdbA9SzIa8ieNNZrOzXayMZkaWIy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZt4wzKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZt4wzKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A511F000E9;
	Mon,  3 Aug 2026 21:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790965;
	bh=Ra7HkvSPvuQGLIW1+R69jpUuCCgg35DjxnHgH0rDyjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZt4wzKSeZJQ+bYtBddkgN+12Pg0LuScB/Un8v3Zl900KWCJjqfgo+SDcXEbazBIs
	 1yxO/3ZMLvwjj+vjaK3FduoIldYeobpeivXirpAydPqCe/bQ3T4UOeyy752SQTJmpE
	 3MUUiMqMLUE46gkh7IyFPHzC1y0C+u9B2yp/o5M5Nffi/87UEf7fHkLRHjhjaVX1w3
	 kdSrtqgNYO85sLhO8AVdrgyhAhgXkZQYaFtqDMIIDk3xOb3W4NMVWPpbFhtcnQAM0b
	 hBx+sGUH508XQMgagtHipOu5fcmSwfSMQiw7bjMJncCjO/rcT+ScgbtqFpwyaDPKsg
	 coJdKUjBoy8BQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv3 bpf-next 05/12] bpf: Disable preemption in bpf_get_stackid
Date: Mon,  3 Aug 2026 23:01:42 +0200
Message-ID: <20260803210149.296496-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210149.296496-1-jolsa@kernel.org>
References: <20260803210149.296496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_perf_callchain call needs disabled preemption plus we need
it disabled as long as we access its returned trace entries buffer.

Note the bpf_get_stackid_pe function is executed already with
preemption disabled.

Cc: stable@vger.kernel.org
Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3ee0034daf52..5b18d728f4b8 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -632,20 +632,22 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	scoped_guard(preempt) {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false, 0);
+		if (unlikely(!trace))
+			/* couldn't fetch the stack trace */
+			return -EFAULT;
 
-	err = stackid_fastpath(&stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
+		err = stackid_fastpath(&stackid, map, trace, flags);
+		if (err != -ENOENT)
+			return err;
 
-	new_bucket = stackid_new_bucket(&stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
+		new_bucket = stackid_new_bucket(&stackid, map);
+		if (!new_bucket)
+			return -ENOMEM;
+	}
 
 	return stackid_install(&stackid, map, new_bucket, flags);
 }
-- 
2.54.0

