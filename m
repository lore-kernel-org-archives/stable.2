Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F747A887
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392918; cv=none; b=QiX4N4JBGPNZl+D9Cyb5Q0AWl4a3s1DMDz4EmO0jocUDjjphv7ATBOZFFHWVgR6O2NP+Dnufxeacka0a3D7KY3FiEDYRby0HMzbusiA7tFxGQc5pJN85VA8/W0XtYjcfgGrTQzAjHsKQ0zbyvg2bCLxnzrUrToIdbmjfdQ9YolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392918; c=relaxed/simple;
	bh=rob29vuMJiM6unglL8riKgmWKOv8j0OKpd04pbbohkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq1tAwzf/m7vRMmzfs/pXrJ+xHOcfgK2OA1vrVhdpkNH2euGrVuG8HzJ5ak5UKIEE7bp+tMPElWVq0pJHoBA9a1RIywbqShQc1klQ4y89oPEjuCwKwpggSPpiWArW8cbzjdcviuLgPY/84n8OM5L/RDz2+UcZhWRHfaOz/hS9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZAT7/a3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZAT7/a3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c29667ed561so405162666b.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392912; x=1789997712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7u5qVr4y53yodZo8gWGizbwm6BRp6jZIIKbBtggqr88=;
        b=kZAT7/a3mbujJosWxfKTCqT05ZSrRD39fxUF+69ap/lY2cHDGuhz90ofIQJUrYehE0
         +Xe90th42rikLASkxM7qCuidIGtuzIf2CR0jy1x5UM5SEq912DiWgw45ml2Cv1AgYkQj
         yUl9PznwmGvwu7RkgeE5ObJweqps9tZ66u0kj7TCsfs9mjB8Rlj1UFU2FX67+cg+cIFc
         +ehIitYjJcyFcvDy+tgUPuqZPsBXWOt6/lBKp6vt2yCIQOpAHYBS4QcQrW33xk60f5/l
         6DZSHwMqRcMN9jGrHrT3AioIuexDBhok7pbeCcjf5HVbmkGyhTzp7rBhOtjyHMH/aWz9
         2Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392912; x=1789997712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7u5qVr4y53yodZo8gWGizbwm6BRp6jZIIKbBtggqr88=;
        b=fXFxie5xFfCyNKG3+/IW5WMjkzIOwdZSym3D3vR2bSu3P502NSxfT2Herxdag1bvk0
         0UU4nHyRwLFVtpgEEyQICxAPzH3HVNUBq8Vxyo0O/CA14VgecGqTkXqB/JqSu9abKcHl
         NDyzrkaiSGCB0Se2YwyolR21y4OPMzEYvby3twUwyiQgSrmI6QUNwWir8eqjauHgIDMg
         0vPPifRdBtWi2P8odlDr3zNO/sseGXGgNcvceY/AvYDV/aZNPKX73Tt4XsKxO9wR5uEj
         Gl51NiNS2AdGoGFvu/T8GBGitCGGq1rVRE6LEmnIVx2jVmxrKA/wxNl6USD5ku8IVFph
         ZWzw==
X-Forwarded-Encrypted: i=1; AKwUvBxyC2ydE67QB+OOGbsGxktnNbE4sahSB/KIsU7LI/hcJXVrbELWBNwXklonZpHWH2uwsLX4RaU=@vger.kernel.org
X-Gm-Message-State: AFuF++njdA6L4p6A+Cih+ZmpYdDku+/UZf5yoi6tivAjfMTL4UV9UPah
	QILerHC6oNJJXLEV0GWUkv3WeVFpqsVltE4s+OglEHlVKthPKY4vYJtT
X-Gm-Gg: AYBFou0mm02tfSpJ9uWb8iZ5uyixFmHF4NVjn6R+zk//IaWL1T+8t397gA/Z1qYjUDS
	OP/0LLC1P/6zv349SfyXpylWSkdGFEeB1FgkktTWIOkoKyHrxe+9q0olArUn5Rhr5C91F1BvJwr
	PO/WQAhDGk11R2MmkG3AbOYLTioJzohfe/oxMEE0Dl8zd/3w1h/SDBzOp/Q+XwK26yuqt1LfHZk
	q/yczBBD+tPYVFEjgCfgeL8zgX1TocZJuKvkysNA0msfjBeo+X2h0jP6vFdbqqrC61X/iWqYQfI
	7xYFM1glx2mx0ACXipP6otM5/cuKAYVqk6DsNO0rT5vLLdNTeGfz2j6O+JBAmJfMhUStCUnwwr9
	HGqqy3F6SJxMYy6LI2dMIqmKzXD9y6VtEUEial09kz91I881oNbfsZHVrrW7qqNMMqUmAPN7ivj
	cEiVFOFxU9hTo6SyW7YthyHIXCVI9x/1EnyJJ65Y3idFoEeUsOjez8fq9NZpAPo+3bfksshmxbK
	W085EjjF5DoUpcJatIZl5vgMI3Ffdff2RYNobJI8wFVFtsqUxSNDZ4SbGQ=
X-Received: by 2002:a17:907:1c2a:b0:c26:2fc8:4e91 with SMTP id a640c23a62f3a-c29b87055ffmr157187366b.29.1789392911608;
        Mon, 14 Sep 2026 06:35:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966159c07sm441454566b.63.2026.09.14.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:35:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] ring-buffer: Do not show buffer_meta for CPUs without a buffer
Date: Mon, 14 Sep 2026 14:35:05 +0100
Message-ID: <20260914133506.4865-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914133506.4865-1-devnexen@gmail.com>
References: <20260914133506.4865-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per_cpu/cpuN/buffer_meta files are created for every possible CPU,
but buffer->buffers[cpu] is only allocated once that CPU comes online.
Reading the file of a CPU that never came online dereferences a NULL
cpu_buffer in rbm_start().

Fail the open with -ENODEV when the CPU has no buffer, as the other
per CPU ring buffer interfaces do.

Cc: stable@vger.kernel.org
Fixes: 950032ffcee7 ("ring-buffer: Add output of ring buffer meta page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260913134906.6E8A01F000FF@smtp.kernel.org/
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..8833d04b9fee 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2381,6 +2381,9 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	struct seq_file *m;
 	int ret;
 
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -ENODEV;
+
 	ret = seq_open(file, &rb_meta_seq_ops);
 	if (ret)
 		return ret;
-- 
2.55.0

