Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37C584941
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156577; cv=none; b=bcU4WuU8pKlHzZB7ztGGPU5GjTbDXJ/hnwXGScWmBLk4RY2Z8boS8Gk1A78WAdOgD4Kw59OmWF3t9GlVuLUZ6XJDu6IGhxBPDQrRL28cDk/swb9PuguVA2feXEDCCkBLPSO/mMEbZwDPOCWYkVBWh0xpgPf/qdd6DxAbD5lA2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156577; c=relaxed/simple;
	bh=MuXg6y241kQAFFXgtK2Q3UkQFZr1v0D+y3gdcjdSvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXvdWnHr1kyp7t4z/xdwvFPhnsMjdcOBs4NNZWoD7OY1kUTklnjCEmWwdolIDgouzErRFhi6EQyvXb+34QhFIESlqns1ysZUTa5vvEsEmmX75emG0Is45dMREatoqpwmgDmMy1JioVqD65LynXDItXfcCix/pe+8Kil2swX2Rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNN24k9M; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNN24k9M"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2941f7229dso198257166b.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789156563; x=1789761363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbxJsFTbQ+RydGePFrpF5dFVh+W/MFXSp8uy2MJMaaU=;
        b=PNN24k9M8dVAGL8x7ciTQZ44C20MJ8Kj2jfC8cWHrn60dNP5vW6DzIwEI95FGciRUr
         zVDqyAkqgwGWNqsAAeJEXUkoNllXuMG0h4OKmnxE6ee1Vm+HrAZ1Wm/trBrOrzfYm9fo
         QrtLKwA9yrsg1t5oD2NFqn936poJJgcZidGWT+LRjFrLm87ikyxRVIDOnXwsjQQgC6Z4
         4M8PYa++upd5egNnZ6qJ7wTMLxTnj4g/btxW2u0438RDq6EsIf/yMWgmzmUdIn/8cs5l
         AvswYJrh8qSRdRNnbZglzvycyT8qOhYRAFzJ7B4BGePPICvaIu+533364JEOc96YGFig
         dPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789156563; x=1789761363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbxJsFTbQ+RydGePFrpF5dFVh+W/MFXSp8uy2MJMaaU=;
        b=URy/jY6JqVaiZZtn7loWmY6lvwTYI8vT+Ri+ttPHnhuw/NeFy2nQhxNN6Jw9xSdk23
         IQzQgn5UFuvrnBp36RK+51Wpduuxsml0Zaiy4qP2VY8kwy9uPZDxfJCQNph7QuMYMIYS
         QWoJPMUG0VOw+EVOgtFG0IzHS96zs12pX/B79qDyvh70sijbbwzOCmD49ZmwsSdQLBzx
         415kb8ecsPukgtP5f+opGsRLM/WAAwLG3S7XlWHLTywrvUwdZtYsmuJnLqqusMOKC35D
         gKTdte8AFyu13XNcNXLIu4a51PmxpF63gL/Sa9XaaNY6a2xNvu5tGaPpjrCQYQW3/N2M
         hIXA==
X-Forwarded-Encrypted: i=1; AKwUvBzpi3JDAvKo4Qu4G2FRy1PWvgc7wwDxeAhBm3PkMY7qcm64NUU/nuk6gcIac6aZruDoGdjdsQA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMtH9LUXVbZ2EbtO8Bar2uYMK5MjNYLwI689wR5wKbsWDoSQuD
	uwaSkwuPk9QC1w/ytXIF4EaA9//rPVaBTk4BIxf5/JjizF/JNPZCJ6TM
X-Gm-Gg: AYBFou3nh6I5WdGwnF7FbpxijOvPKPJi7MeERcnNaMOZ74ChtUbL7RS6eAL1xssBOEs
	CCPKsQ1ZXReNo1eoVdFXF+E6TFbsBwtAazF6pd+rYfSD1/lRP4wPM/iVS1H+YuyGQ7Zb+jvmFQt
	NKYyXsGlmsPn3pPTrpfh0YnBU9dcZbAcaaIS4lAR/YnJxex0nTRJi9pWVnPTyzdmrp2+zv8psaa
	lBBtPvbJvRsla816m66v8uRB5pJ0lKxfR6WI6+FLKhqNU1V+opNZQcgYgMx+ahnhT1/V72JPmqT
	diqmW3sOgWVjQuJhaqmL/mrHgMWBHLgtW3UAoQjCeZtnYIEzvapJnj7nmK30OXVzntVPtmvi4Cl
	8MM4wFd83uU0S4EcC1n/HvRSMpXW0bR8JYnSQYFznztZrBJd98Xxsq8p6yiiceCE8IuVm0whWam
	vX89BLY6P4k8lHV8qwocQs2qTXfIB5EwATxyKZsGd8Z4KJiSZ7QWCJ0BFQ3Qnphujd2uvRNjm0O
	eim+1Xwf3se7BOuGjrmrWbpqaEKeA/zKTp4iYmNFixBpQdN5eu+hR85s7s=
X-Received: by 2002:a17:907:c28:b0:c25:34c7:44d1 with SMTP id a640c23a62f3a-c2966235aabmr287609966b.0.1789156562685;
        Fri, 11 Sep 2026 12:56:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm121013966b.1.2026.09.11.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:56:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin Kaiser <martin@kaiser.cx>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fprobe: Clear the unused part of the fgraph_data reservation
Date: Fri, 11 Sep 2026 20:55:59 +0100
Message-ID: <20260911195559.230709-1-devnexen@gmail.com>
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
0. fprobe_return() walks the whole reservation, so the unused tail is
parsed as stale headers from an earlier call, and an exit handler can
run twice or despite its entry handler asking to skip it.

The original memset cleared only (reserved_words - used) bytes, and
commit e0a384434ae1 ("tracing: fprobe: do not zero out unused
fgraph_data") removed it. Clear the whole tail.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/fprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1e9b00997ff2..bd84a982961a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -635,6 +635,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 
+	/* Clear unused slots so fprobe_return() does not see stale headers. */
+	if (used < reserved_words)
+		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
+
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-- 
2.55.0

