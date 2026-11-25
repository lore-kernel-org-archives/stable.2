Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645709;
	b=Ap8macCSloIXjWnxHvNMqf/QXVK1ec+377p+E9LCCxm0mab86YbPFt7IJgCHsquB0otv
	 HyJ86bmH7yZJ2vKQf9wvgaAUcJmb9IzLYxHc277L6mU5shqN3sRhJMZC+/bMB6Ze2k7l1
	 eFHnS8D+Sf5lqXw4ezgKaEaH4K4bjbfKYJi/XBRERceN8pu7C36sS+8jLYWHyuarK8w/f
	 eONRlMMQShk2xYmQylypEmUcZnrZGf50LO+j4PjWJujepzKy7Yh1iY1Q5rN32u+mJB5I6
	 ltl8IWSpel4wVu4UcfrYYO6z80wWG0YXgXmxa1Uq8nQmOY4+q2ewPSa8c12HKzecCow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bB9dahbauIY6gVR9GUf26/TEEIOmcwn74D5zXKoaRTs=;
	b=1jmjR+n6MW2xFrVWrGDfo3vheFnjZjBKd14B1vNZqBArVY3sqD3PhcWKFsE6J6VopYae
	 R/mF+2kU02pkQV+ZnZrXdLPUz75dJjOwbb1vdIZMdJqJXJs5rvgApF3AgZJwZKZZkcOL1
	 28qFHLTBCNmLm+Qj3zl5wR51JxO88uDskzA5cebWRyD55YLiuwU8DxFon+MPBeU3yMjOr
	 5MUP9Ru7225smKclcQ8iwRoe6KYy5BCqjfKi7jaFFjHtKPKq1TPA5FkBfXxZ2UI4j9mLL
	 USh2Xanw0fb9m3vYaUOfYid7GmaosE9/M800xOpGXexUZQJD76rovFLAXUHpokwo2sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gEuAIfW2;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3278A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gEuAIfW2
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so6455587eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645708; x=1796250508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bB9dahbauIY6gVR9GUf26/TEEIOmcwn74D5zXKoaRTs=;
        b=gEuAIfW2PwwuZoWNRspnLc6yTnLsXF4VrYR69h/SaRXixoHcD++1Er7TnVuIcgATxq
         LDRSPcab9ONssZt805d131zL+AcHL2t3U8L5HADpSvbVhN3GSOMNW9e6mtTnzougCeyn
         oPpd4N47tlnfiyT/3d5tvNgb8zA3KCCjrCmCFJYiLsHZkQecTi3LVjof4Hk078j+ymmn
         3nLiBV1kEKz+c0tqRA46C7CuRuFKwIxndqXlq3BUtw/J/rDqfuJ4IkPbZIUWGYtDp/6R
         SpAZ7Xb/9eSW/a3V1dsdNa3PLZBtzysvovrSXdi1ZfLm6eCu/uJZFkQMabzwVbn+BsYk
         H4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645708; x=1796250508;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bB9dahbauIY6gVR9GUf26/TEEIOmcwn74D5zXKoaRTs=;
        b=Yt8Ms/wDiSpLgHRpWpWs69RGoWWrqoZgsl/9XkWaYwGyg+JQDia88JHNLCO7lgdfsB
         zURWnndrZYTJrR69kL0jvNJrqUXtVmrWygGDtYfDez+oyj7DCq3pYWKYlzisdm8SHSI/
         wciIRaR8hrdqu6USOFpWhmciwCPWuuPnCwpzdAgXLW6H00HNhEd5Vwo4J6CSNawghaji
         RW6HMEMLQcaYFaAg6Dx+OzAntQhjVipduyz7w0zYfcGLW/uFcuFe47kIvwfMOUmGaseB
         4FWZ4h9spTRarWPxDxGMwxq8Uy3kSRi9M2VQ4o9tsfdds2PwLYlI0BqLFncp1dikXY6v
         LuJA==
X-Forwarded-Encrypted: i=1; AL+hErHSOz8xE1EWz1i8yAr9hY+rjYgsXJIOlca2/ppzZL9VBknAfiS2KARLOZTYBYkKYb38zONPfKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rTqYtUdXhgSAfghGrQZnPP6kdG33Zy5lOPfE4KR99IYuStiJm
	XM+9gOl7hKBy2kdJw9UfMfLJkE0rFbRuJPF4uwmKGsjyzBiKHD4OwUrWqsGEpErdy8esucc9tQ9
	8DQ==
X-Received: from dleb17-n1.prod.google.com ([2002:a05:701b:4251:10b0:1a7:f7dd:f258])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2706:b0:192:a481:361
 with SMTP id a92af1059eb24-1b5568c12e0mr18196883c88.7.1795645707988; Wed, 25
 Nov 2026 14:28:27 -0800 (PST)
Date: Wed, 25 Nov 2026 22:28:02 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222802.1451781-1-elkin@google.com>
Subject: [PATCH] media: cx231xx: clamp bulk buffer copy length to vb2 plane size
From: Elkin Cruz <elkin@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In cx231xx-417, start_streaming() initializes bulk URB buffers of size
320 * max_pkt_size (up to 163,840 bytes for 512-byte USB 2.0 bulk
endpoints), whereas queue_setup() allocates vb2 plane buffers of size
mpeglinesize * mpeglines (65,536 bytes by default). Passing unchecked
len into buffer_filled() overflows the destination vb2 plane buffer
when actual_length exceeds the plane size.

Guard against non-positive lengths in buffer_filled(), clamp the copy
length to vb2_plane_size(), and record the payload length via
vb2_set_plane_payload().

Fixes: 64fbf4445526 ("[media] cx231xx: Added support for Carraera, Shelby, RDx_253S and VIDEO_GRABBER")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/media/usb/cx231xx/cx231xx-417.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index 55af8b9f2038..0b3e856f6d21 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1297,15 +1297,18 @@ static void buffer_filled(char *data, int len, struct urb *urb,
 {
 	void *vbuf;
 	struct cx231xx_buffer *buf;
+	size_t copy_len;
 
-	if (list_empty(&dma_q->active))
+	if (len <= 0 || list_empty(&dma_q->active))
 		return;
 
 	buf = list_entry(dma_q->active.next, struct cx231xx_buffer, list);
 
 	/* Fill buffer */
 	vbuf = vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
-	memcpy(vbuf, data, len);
+	copy_len = min_t(size_t, len, vb2_plane_size(&buf->vb.vb2_buf, 0));
+	memcpy(vbuf, data, copy_len);
+	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, copy_len);
 	buf->vb.sequence = dma_q->sequence++;
 	buf->vb.vb2_buf.timestamp = ktime_get_ns();
 	list_del(&buf->list);
-- 
2.56.1.839.g22a8290db9-goog

