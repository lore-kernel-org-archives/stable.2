Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30342AF9C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209589; cv=none; b=ercnme1Xc6rNof0WwnEzX292y+UkdEMfNx7YrrrVz2syCEl8rPFRyyMfEVyL3iBlTFv8wAPXYlqRAL5OIP56NAUvDiODSFDVaIhuMYDs0hmd1JyHtiRqhV/3joESmi1pPVeTc/9XSDnQRn+1tDOlUVFBBszNwrRh7YvyHF57nNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209589; c=relaxed/simple;
	bh=woTLYl0W/1NEs0vAl1EUBu9TVuDURQmng/NEGZELhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMEY4m3fzeRgVRdBaLEgrZkLR/G2J/n1HoMCrrvv4Bcv4Lc1Jw6gSMpmATiD1yfPc713bLgzstmJzxBdIlOvard1vRyYC2Ef0nGNFwaDrGBVZZuXpm2RSA5+oYAAxUlp6yCOOsle8jgOtqfz4i6012MzqVdCaHEQXj13LQDrh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQlf6HB9; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQlf6HB9"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7daaso1156585a12.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789209583; x=1789814383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4i5WEIS0+RCnxCAmvMzbRWJ6LAh/sKzSDUzg0eVAWQ=;
        b=QQlf6HB9YLjOEizC+acH5G3M+oPFReMfkXdU/9qo+XmCWQvNzbSh5RHnq9so4ZLNSh
         4+Hvn4Eegce8H7m8nMer8ih5NFmIVljW2fLqPAWzGWjahHzqK0T1OYzeSdTMzrBgkMhT
         py5bZYhQ73eGYDWIb3GMVzg6wzxTxguSqi6HJKQxXsOcaT+zGMpbBVUcIZLFqstMp1k1
         m3wa9iwPXUMh2t6eZRUdOMSsME3jAEsQNHJe6avDSrJGFQP1/+G2PbZ7u/ngM4Imw7oy
         4LOt90iG+tjzO+ckiUrinXK37IPPTF7wS9lPEhhKQZJRR8FqgQINdc9iG4wDWQh8+E6g
         Yppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209583; x=1789814383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4i5WEIS0+RCnxCAmvMzbRWJ6LAh/sKzSDUzg0eVAWQ=;
        b=ktgdyRqr71SVJZauRRzogDWoNx65sdlII08BKqK8m9FopDgwhNG12h/lvPjMP9xAmH
         8TE64ACyA0u1UipSBKYycidIgowuqqy54YsECKJ2kb8UqDz2u4c1LgNGG+HFrC+W2/8Y
         hvZMDBcVapvud2tZxp+n18cLO5yVmYH3dYjTUlC6WqjAwYRgEbd8n+VHdehPffe0R8AR
         dJpJUnoL4+7tY3yW46wAJBzUa7tkO3Cqn/QCduMEozrtSxLskr2UHEmRc2cQj17nfOVb
         89/jTIZib4F5zNRauhWL1Ao/3oBHDxoMN9THJ2sjXQ+0IA4Aoa611N44RrgeXlPGr4fs
         /amQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDERXzLgxhBLZhCC7+RDpqiCkQ3GUpGFdyCJm1VRqMGG94YuIj1X0gFe9jQtVkLPL85ekp0zQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ2XNEuJt+EYkBl9UWaejOs4TIHV3SwTWm6nDH5nKXanw12YVX
	ijM2AVJWOsJucXCdM4nvC/zdNv1TttFbyaLPXdMYoJZvKd/pPuW1jIA+
X-Gm-Gg: AYBFou2MP2wL4hHcfLLkLJM97toPw8HyUp/1WeFmfye+avKK6DA75CKi4kXY/mokKGY
	BqXo4S1R7TnWA6i65tgj6zMUtuZEW5qgYn2HQDSgDeb77wPdHFzkC+0dsgj2BC02tOUVCw+QCre
	EpWSzmXjtZeCSYu+CaWvEClZLuT5lpY0knKsgERCq4Nas6FcH3Arj257N+ZtvHAJ1Za4LbNRGYx
	IC5OLw37R5nos5Lk1eT63j4vtng7XZwwVBX/9jDei3gVU4vlOG1NzT1gKCjWCJ/MGYUs7f0ldpo
	t0RNVhJcscs9CgAXLmsdZw8iPIQ2MEirgr/OWSpcTcQNk2XiSo0yy+qPhaMjWt7LEmhFcq8lE8z
	tYSCvKpbem6UzQjmeR8zzOtzBaZJ5Tmh3YulFCZVfzaUeIasd9sWx95LDBG5f29pmcv6yqsVTeI
	Nkfch/npNUltHrRO9UTV13jaKKpquA9kmR2waIzVSS6nW9IADBtWpNxPg8wuVm//aOOGgphd+NT
	rndv8rH2EYqk0sglFCqhX41nbwMUiTOCOtdfPcZR2Ota1HwqZBH0/HPSf0=
X-Received: by 2002:a05:6402:1588:b0:6a9:93b9:f098 with SMTP id 4fb4d7f45d1cf-6a9b56a7951mr8237467a12.16.1789209583154;
        Sat, 12 Sep 2026 03:39:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5831187sm1818923a12.1.2026.09.12.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:39:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ring-buffer: Check resize_disabled before publishing the new subbuf order
Date: Sat, 12 Sep 2026 11:39:38 +0100
Message-ID: <20260912103938.1127021-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_subbuf_order_set() stores the new order and only then walks
the CPUs, returning -EBUSY if any of them has resizing disabled. A user
mapped buffer has resizing disabled, and __rb_map_vma() reads
buffer->subbuf_order without buffer->mutex, so an mmap of an already
mapped CPU racing the failing order change sizes the mapping with the
new order and inserts pages past the sub-buffer into the VMA.

Check the CPUs before storing the new order.

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..d7e5e4620d09 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7474,6 +7474,14 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	old_capacity = rb_subbuf_capacity(buffer);
 
+	/* The mmap fast path reads subbuf_order without buffer->mutex. */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
+			return -EBUSY;
+	}
+
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
-- 
2.55.0

