Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904191;
	b=Vl4Y37aLWyI2AQ1RXXJlsLuZbRofQLSuaxEDGSiN0oAJsRhl8WXJ1rp6SbRVcDv3OOmO
	 dVNkJsPVQ8HFETvFVhkEGce1NcAhQwe+OGRGatVGVgmR94BWFu5zucZaUgSziIuxzF7PA
	 AGU/JZX/BoDgVF+KUZTWxgPZPgg5nwwKJ8aZb20Gl9SoTFhSAUpsAtvAnZW2MBFJDlNv2
	 gBE44/7LV10RG4XBOHMLzYTd3xHkoyvKSrqM4/PRf1pxi0+vPLQi8d2qOPeAs85eQePqQ
	 wMAb/QWnZc1bYQA4OuD/Jzb3vnLl+1KlkQMDAGD5MdCozHwOQykj2QkTpOKJ4AWGnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
	b=B/iDG96v+AV7wPB03PvOIG5FOXkdsk0meTVo4wD8l2ejSX75kkI/FH5Ru9PlftbU2/jR
	 xb0QoyiKNERZGi9qzqFan+EqO7XT9U7sX1K0J2VaLufiy2x1bSnBZ26jpMYliJW1dTDJV
	 BvwSU4T3VoHcS+MXwEm5mkPe0mYfQuKb/BOakl9zglzELZnYSBy71qDbUEaunSQ/jASQ1
	 MZ2AGST8LnjrFP4Yc3wFO5ugVg1nMwZG02Y4F2xCTrxVrtCAqMUAtfNyb++SGfc2Bmow7
	 KHnpSythYu+fApJFGfi91gk44OBgB+tYbXxNVXQB4fGCFYPaLClLDuL2Eqazr1mvsXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="g/40v4iR";
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F05606A8A8
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F05606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g/40v4iR
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b7a647c6bcso6363964a12.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794904182; x=1795508982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
        b=g/40v4iRuWwI5fUGgNeFddKvD6lR7SkzcbzzaKqUiz2wL6lb7UwNmZz+mbPRRZnLfu
         +58nh0rf9C5g6LKkZflitpOi7sQyrBdkaMPtL+1aYm5pqh+lWba503aaEywfszr1qivO
         u8wOp50SmK+zDTFyswVTMAIi4oGv6LyGeyqlsGbJjExfnUQWSJfo5Sw1a2WkwLzHiUas
         Mkl9RfXrRQZWmg4S+DmWgs2Q1vIDsmMnJJFgg61dHfmG1JVu/DReyq0CxOMwGv344zFl
         TjGRzlTze1ijG1DekJK+neRJ7sfZ6ij2YRdvPKH4jAEdfgs0WaJkRo8JCNwW2F2jf62v
         vtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904182; x=1795508982;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUzJJDtkx8ZaYRA5grqqG2mwrrLwcQbjsBpMmpNBpIc=;
        b=2pMFn7pXVCKBeY5KrnzKH/5/xmoJN/PwYk05wdxMe/dPil3Vjl02rdO4YpO+EsVOje
         rbVxS6rRISrF0e+KRKRC9dxh2REhE1DF83x+AHL748JyFyY1mxysYjnWNIR46ViEDwDR
         OP5mdyt6cGI1ZMclD+48Y6+8fZ1ioIyzyJISWMDanC1Es+m+5YYA4ZYwKgPFqZJfhLDA
         xsqkgXdgjyg3vOzbpDOR8p2EUmn9ABw+Wo8doYp2jqr/da+UBJ1j1mryuGwGBcpMoLZ5
         ALv1JXkEkRNtRfyQM1UfXieDMe/07NtjprE2SCYAK+yBaA714AFa8irC5LXdx9Bj+w03
         w9aw==
X-Forwarded-Encrypted: i=1; AL+hErHw15NK5MNwE2+ztUbcxtqSMkgg4UWpdcxEgaqRHhmvS9sUmlmV89mDTgEVqzNRcABO6fJG4eA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+r9TbaaVkVxOcG76ZdDhEYB43ugfCWYX3U7/K7FPy1ta9Ifhp8
	X9lC2jBakqpdwo9QlT4iyK/l0hC5TKbXd5TlcUigfLxZzGI4Ewc5vBLjZBKUNtpubAGWKhNParp
	/HZtU7yDpcqsnfN52Xc4q1Q==
X-Received: from edyg6.prod.google.com ([2002:a05:6402:1806:b0:6b8:7992:6727])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:42c9:b0:6b7:8b1:aa6c with SMTP id 4fb4d7f45d1cf-6b7c0bc4fcfmr10380043a12.10.1794904182145;
 Tue, 17 Nov 2026 00:29:42 -0800 (PST)
Date: Tue, 17 Nov 2026 08:29:32 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117082932.3441173-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Take trace_access_lock() in tracing_buffers_ioctl()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Kyuwon Cho <kyuwoncho18@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tracing_buffers_ioctl() calls ring_buffer_map_get_reader() without
trace_access_lock, breaking concurrent readers. Take trace_access_lock()
around ring_buffer_map_get_reader(), matching the other consuming
readers.

Fixes: cf9f0f7c4c5b ("tracing: Allow user-space mapping of the ring-buffer")
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/all/179485165154.2547186.6129837870360499372@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..456fc388a31f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7404,8 +7404,12 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 				return err;
 		}
 
-		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
-						  iter->cpu_file);
+		trace_access_lock(iter->cpu_file);
+		err = ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						 iter->cpu_file);
+		trace_access_unlock(iter->cpu_file);
+
+		return err;
 	} else if (cmd) {
 		return -ENOTTY;
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.703.gf848ed807c-goog

