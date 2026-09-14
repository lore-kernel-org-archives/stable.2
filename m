Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9827FB25
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410538; cv=none; b=KzAUM4FLdbVZszg5RZE/9CouMdGX2u51bIsdqagzNfO2VH8Hu+kXWYnTcPXfc3qK3MpbZkxx+/NmrX5tRB7cK5KRZq3xOBBt5kH2RBKFpzwPeaJMMagxMJ/S9ZZweubMokwGdusd3V4gjdSrXACyvybjssGpgNueBXbLmqjyboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410538; c=relaxed/simple;
	bh=Pwu/0Cot70c9cl/FQ0qDdWdGr0VR3q3j9hvKe2dSMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIaqX9qcp8/Jd1UCi8tggMvCrOK+98Z3LNpqg3JOYaRh0BSjclhqtPbqa8A9/xNKenPK6biWlyg09idqH/m5+j0d2rTdpDWfFt7bAeX6t6jlw6012rtVuMcScTmSKUJZncN1QOui2bKSXZis6l6Ee2C3gQQJUj2dn+dFVrPAN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIfOgnJy; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIfOgnJy"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso416438366b.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789410535; x=1790015335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzAQVlxc3SiItgqPCAg4pRFm0RhGbGZG5JH2sIt5XL4=;
        b=tIfOgnJyAl/VbEUJeidi5elXy9sxivmH9fqWsr9PJtIClxDujdC6IYllYnY8dPG+3u
         NJ2U5ONAAcD+UFOMvbBlQMFCpTIwYxZ9/WKXlcCwoJGNssKfGmLCb7TJFv8gbFYx0uJ3
         8lH0jVe87JkzHmxvUTWPAfBr6ryLvBi+6QsSgfWY9K6a3O1wAJXNE/NgJf+ZHoeD7/Pn
         E8ef59hAGUTDGF+v3XgbeudtLM+dVPsnDnz8pjR1OQvyiPWek7l9bDtoRsVaQ1NUuEFH
         Vwdyw14+1i3gfyVuOZRU6nPPDcpoFHh0FKgdTjegktLhCZrXlWkY3N5uibhR61CeI/tU
         gVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789410535; x=1790015335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzAQVlxc3SiItgqPCAg4pRFm0RhGbGZG5JH2sIt5XL4=;
        b=znSLvoL6Shke/oRYrFISeO/HyYjyRNPlEBDfb7oxwnlLlirEgE2vP5z/D0eRcBDLlc
         ZONsto/CVKm+V+Vpf+1vrvjVzm9otSJAH+5ynz3LVI0ttToZ1uvIinIY6qPblRUvxGJs
         uynWXAdqIXbzjJNLgAEokGhIPHzUjKqtV2R5rDx0F6pplhP8k2lD2hAVaXGV09AjUbmp
         WlsgfqQuN8F8IY0LASxvtfXGodsGnPJTKNnjyAiqyveT8KgeFQfXj4k585d7r1F/+d54
         zTe92tL7qIh67cQ23nYl3RSVtv91r2zgc+QHHcwsASuKXJleBt2YuQjE+t971xUQ0Avv
         GWYg==
X-Forwarded-Encrypted: i=1; AKwUvBwyLwJHZXT6y6i0z4KV9WAtTA4M/4fylsfHAHwrVHe9lSbbzR9hfis5McG0+cSfrd9JuMpcR7o=@vger.kernel.org
X-Gm-Message-State: AFuF++lqnhLwqGmgVbMSDQg2wNam8ej2pK5Tu5zzauKOBg+/3xlwIosu
	oCCD72hQIiMr2Q8V38FiggzOJ/foSqS0Rbyzojx3Yo2tZTttMqWbenMs
X-Gm-Gg: AYBFou3O6WRX30BsKOduj+otd8V6GF7KnK7nEK08hjkNtOt7mHYy0bYCVMsVGvy9J+V
	67WMKnSbqWos3fEu//NzSuwnfy3lIhvgon3xHIDDwySofmE6mXaeFNuuFI7tDhMhie2jHUhvzYW
	Eeau9AsMGKLZA2I8+/VFe1ydYeDvBsZScpOOucGvUi1nBq6lWLq2pDv9YMZk24mDLvbcuOkp8Rk
	KQmyOzkyMublQwG0ywFwE50Eeb8J0fwMLt6gLtQsoSTpuj5awEoLdfDmgV4cZX2IP3Wzb2GdXHa
	E+2ABxMgGVRWl2yTKCCpbAYkN4KBqztoasrLAiJRi1+rhoeUJahM9qcXqhdyA6pBksBeAMShN5U
	s/PIdiGeUkQnyWHm5yc9uDA9WTxnw+S09TVbmVmzl4gxr/BNljVIKl/7ui8JPNR0P6HLIzsUWMR
	l6JjYGjcFNkuJkH84LxBtxtGK/W8buef1LE4A9gglYibHYbmHW9rAqUtQy7w0gcir5vd8Cs31Fm
	07HJ5ERG/sgD3WqrWhYmQnvfjDIrX24Pi0wwbzduitElTp+vMKXJtRoFLY=
X-Received: by 2002:a17:907:c13:b0:c26:1648:a06c with SMTP id a640c23a62f3a-c29b8770a38mr275145766b.39.1789410534761;
        Mon, 14 Sep 2026 11:28:54 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296614b29bsm467316666b.62.2026.09.14.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:28:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ring-buffer: Take cpus_read_lock() when changing the subbuf order
Date: Mon, 14 Sep 2026 19:28:43 +0100
Message-ID: <20260914182850.21449-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU coming online during ring_buffer_subbuf_order_set() can be added
to buffer->cpumask after the allocation loop, and the install loop then
uses its empty new_pages list, corrupting the buffer.

Take cpus_read_lock() as ring_buffer_resize() does.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..445931bc9ae0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7464,6 +7464,12 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
+	/*
+	 * Keep CPUs from coming online while changing the order to
+	 * synchronize with new per CPU buffers being created.
+	 */
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
-- 
2.55.0

