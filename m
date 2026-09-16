Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9804195C8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586810; cv=none; b=lzfPPlNNrHXoM3xemk1rLzFOviYuJQOhiXjGUllqRaREES+nDJYZ/oPdEs1VECBtwjkM+5ucjD77hA5xotbH2Ywtb71r6FMIvPxyXT+mizu8fYoctHIB7PDE2BPbpRmuIR6U9L0TrnR07eL4lsNa9kE+A0JNymEhWxO1g5i3sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586810; c=relaxed/simple;
	bh=D1h9fsMcvjsKv13n+F+quh0HDSXrCR58YnIKhayYq6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnxNGqFsYLkN8XUp45A/aERTuFY5ahD2HY7M+d72rhoOqesK1ww84wI2RTktuUAJ73P2eA4z+9xwUpkKkj+QdJxfQuXqsX1aw5Y3acNfeKAVANL3qZtGXahMNQ1h6HXVeSLUJs0oGAnhZoYWgwJl6E7QtDSe8gA3//4eRZMT34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7IXdfUI; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7IXdfUI"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so133199a12.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586793; x=1790191593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TLJ0RsVpJxjU2Txsy2gxZGoZCHNVB1C035SNno+0KY=;
        b=T7IXdfUI7un8s+ZL1UnChTYNpTs9yZJZtGmOSrp12EZxRKl2TD86G86KI8xRJ/0t8I
         53Y2ewErheE+HA8WPn0unLymNt9AB51/NEhYwz/XJXJ43RBgyb9lrqzM0zjf3x4BZe03
         Kp23i7V04BO+pne4QFu5HiL3pjigTZRdqYOm5Mf25OMaQqWlV73/JnqmphY4wKnDCMVq
         u505X3pe1zJ9Qr3jruCMqW02tP+GpSt/tFXT0KFohodkrRN8XIug/nhVglwbchFKiSwC
         Wreaa6N6x/zbvlIteo2A1Tk9m/xGkbfstrWBdnx6XqIimAVFwIPoXE5p0A/iFsSECd7e
         amgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586793; x=1790191593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TLJ0RsVpJxjU2Txsy2gxZGoZCHNVB1C035SNno+0KY=;
        b=f21v/vCETTo7aSfNaKGSHuTZQubdZe8Nr98L1CWrUcgIVkljMazDi3wG/bdY55R2tD
         fy/4JD9/Xs3ueLqvGUOXpxqmDBTPivhL8A4aJaT1OJ7ur630AK7RJz58b4jEMw+7+/FC
         OLw8TIZq1e33JOghL/6bBhrjy47j+wj2/Jkf1kYUlGDhO0LbuflVQed5aRROc0NYvUuH
         kGPoXpA8hi9/txAP+lZWJoFo2ftstJn3gf2zLJB+HB5bITHKPYa/QJLr60Rjf78Gxc1r
         wCalFZ1QXSrtV1r4607LVS5Cir0Lf04d1b34ElMTbkLxGukfKuclqE3/8e/7nUl3NTMU
         ldug==
X-Forwarded-Encrypted: i=1; AKwUvBwIpUZyrPr0S4n9HKsbn1KYRdz9Jn/jFvSfISkTnqu5bP5rrrzOQuOekDZyNb4EVhVty6KYeWo=@vger.kernel.org
X-Gm-Message-State: AFuF++ldLVhn/20wNIo4+gjc44ePNIwuWJsdEk624ttS+G8FS6Wu10ml
	5qxNd74K4LTAFCn2sRzDmzbNPC8Y+i7GOeBz3UyvYEBt4uBMUFdMDer2
X-Gm-Gg: AYBFou3Bgduxd+ERqeqPKiMNQDKfq19bDXs7Dpitj9K/cbmjx8Fj8HlF5Oji2Cy2maR
	JGd6i0qOhh+opXZw1F7tBChbrlXF/3igMb0o1uEPJE74RamlKUFtWoPAJa5L4qO4L1kCHXmJdKz
	tNvEBqSIPjaqzCd7UvAR3z7VJiJTlxOIiXH00Yslu67QBW3J+/358QyZizyvoqJYmOb6zf+eD1M
	GfloqWUqJofPltsnaa9V2MtkuznrvRsh64ddwPCBZO2XrHFyhsW2POrfFrzWOBeMDTjjOPKkcf3
	ZeXl4cc9WPZQw0oXMMDQArUUI8KKDko0qOTv09LrEBCHw99T0RPauc+nzrLbuzo+DSICi07DYqL
	QlDeRN496JvNtGii1veWLDPYjPYcvqneDX4ZgyJk5gf2MiSo5l1oawUhkYpbcaHw0gVYbENyRJz
	zmX+zUV0ETZNPQxo4HlGLC97zdC3OPLTcW7zzOwLTlCnemlccQc95Ad2TpYB2EZt1nDpKI1iqNF
	9Mcwq+CQfL8cYJnMzw7bKbJRi6HzdNDgb+cmI85JWyLjJFYPtOZ53X6NoQU
X-Received: by 2002:a05:6402:21d0:b0:6a3:691a:9d71 with SMTP id 4fb4d7f45d1cf-6aa22251052mr3001238a12.11.1789586792762;
        Wed, 16 Sep 2026 12:26:32 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d25e331sm2303248a12.17.2026.09.16.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:31 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: vdonnefort@google.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] ring-buffer: Take cpus_read_lock() when changing the subbuf order
Date: Wed, 16 Sep 2026 20:26:28 +0100
Message-ID: <20260916192628.274136-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914182850.21449-1-devnexen@gmail.com>
References: <20260914182850.21449-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU coming online for the first time gets its per CPU buffer allocated
by trace_rb_cpu_prepare(), which then adds it to buffer->cpumask. If that
happens while ring_buffer_subbuf_order_set() is running, the CPU shows up
after the allocation loop and the install loop walks it with an empty
new_pages list, corrupting the buffer.

Take cpus_read_lock() as ring_buffer_resize() does.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---

Notes:
    v2:
     - Reword the changelog: offlined CPUs stay in ->cpumask, so only a CPU
       coming online for the first time can appear mid-flight (Vincent)
     - Drop the comment above guard(cpus_read_lock)() (Vincent)
    
    v1: https://lore.kernel.org/linux-trace-kernel/20260914182850.21449-1-devnexen@gmail.com/

 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..e78fb4bb2195 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7464,6 +7464,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
-- 
2.55.0

