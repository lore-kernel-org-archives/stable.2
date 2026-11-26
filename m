Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663207;
	b=raDUo5EsIItt/mueQELeC0RiXWeQe6Zo2XXOvpYhwrCU/dhTyJkyh0a5A14oTXSU380D
	 YqI2rZq10cOzJe/EXDxS6oGUsYfmuaF/lWrrF9UYZ96y1qPldB94tRLAzcsRd3QrFHgIg
	 y7TSvYYH6zAyu8l5rmRcmkgTfts3NiKXnEIwEnX1AlzyAQffUfavNpshK7kDr8DB6afJo
	 zo2GIaX86DWAYKa24UTVrd4gNeMV+JCn9jDjkaqdQjOpxwQo+utlvNdYogCbvJn70D0hx
	 P9DrlfzTzHjSfDD6QrhR5RsqwVXpzPxB270amZEXDiRgyShgeVbh1wG6DglRYsV706g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
	b=yxU7424+cpDUNAAlgN6xDtQOkEUs+ZfePbSKihqz0KJtX9pdiIAJ3BOpq5VZcppY2hsb
	 lsqbWfg/9uP90yPwY9Qp5sf8cxMxukhC8XU/libxrKdNoZH4/55/24s0oW48xa0vEVwu/
	 3csMiEJimMSQdL1Rgq4RGy5vCKjgfrNeohFUN5vhFIIZ/QCHvocHClHTQoYXGCGJSbMWw
	 9y/Y17oZfRqWhMyFnZczn9i5E06SuZ5T2u4AiyikfbAixFscIGjwfIyoh7PFJC3Opq3yR
	 fVQhihF2joIAg155dbkvW4bMT/YlQBmu8Igwg3xztxf6uuniXrlPf0sh3B64rAoRLnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYYmRu3R;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BA606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944BA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYYmRu3R
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so66355565e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663206; x=1796268006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
        b=uYYmRu3RhA3xo+mDjNGMggA9qvI09pOAtqRznikY1fR3QNyRR/SIXN7iOiy25TWzA5
         +UEjXMFT2DAe1FE+FP6mIOSqNiaZR17HTY4bdFbSZoE1O4fJVBJvURqitjOBy9Zbp9Wu
         r9GKDsTS2Pz2GflqdncYNSt+l0cYyuPu/Z3BMFJQXJQT84oGBH3DFJ6RPLHN9iU80VJk
         Llbmd1oJjGg3cu6VwLujHaWLEKd+3ntGwLCOcMGpp0vK57rs3BNevkOr33dg9mQVd3Uk
         Vsa0tL2QlVfib2qSgcU2rFhkrX+lSEhv11J9kNKXVmtaKn559kw8oaG8g4YY0B9KDduX
         jg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663206; x=1796268006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
        b=UFAzSXS/l4/6gNb/6amV+6DiY55sLn/+H9dpK6NwBzjdySk8xeObydqX+e/ombeN0n
         P6vxKSeHGA71NX+D+NaZjTmD3MbgKaFouzQRz0xIx7Ra3mYg5bQSfX1M3iQAXyQ021jK
         uFV6/csq3kMt2iZ683LHecxGgWy58C8JtaTLnCr0lmrerSPXCjIEYSBz6U6arRQH1Uvz
         RWQaPTAf4FOBZXoawInH3aT6ve6ESSWR9wrtJI3OJNfGk0PMYrUUK/xdMhDgh8WZ/aJ6
         TkTlwAkQG+D4Us+pmLpK294g9dWRUUcF/qsHLnpJyMldxV+EgVVFTb5uqI/vdas3Yk2J
         pd3g==
X-Forwarded-Encrypted: i=1; AL+hErHrtk4RVOemSGR3P3EA83vhlEfyeDCrFMSzoOtUL26Uo+YQgvImc/aLw5sYlywwdyzb6f0YhME=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JRGnqemj24Hly2iApxb/fcW/PMGu0GgsHFfFB1eSswGnPQWTH
	6Q2SOrML2cHeyY2jScN/TC4VG3CC9E29XIbKxWUdGw4oGfdd7+oKFfd2
X-Gm-Gg: AZFdTZe9rHwM8wh6Yl7ARcg6jMi6PPh4Ojf3Wx3NnUIgP+lHc+lHA2laTX7w8ijxmO1
	AiePxJ3fruunGvSapSZ9QoxQdqsWeeEU8luG8M0g9PXDGdf8/daubO2oKhDdE5aKU/1SBDKjwk2
	lWn5SYctzkLXZlRHkbJjQK0yyqfLw88CjB5qQFMKZhxg2MwXnvz3hi6LxDtPybmhby8hNdRaI3k
	1EJWc9KFJPazkGWakLZh8TcAd3QMFcTXBE9QigXsFXqxum8vARiZrlHVHPXSnXl4hlxykWRhjjH
	UYmMjBNx2Mu1aK/vQSmoQVPPstlBx0jXzCYduVAm03TUb/X+3ccWgo9WpEKA0FL1NPaWCBut54o
	PmPUo5Ui2mY1RH3Hdb6xhrjw4TTZwqA8wkdypX0s9mWMgKSq3mcCIQyOJYyGS6K2qNO/mHLLz2K
	1AkBt9ayI7Uk6EC1yPKMtB/kigRjKLY7CgH3DmsZyjqg7KbrMOJNXadxM6bVUN3B0TNdD5ZI8hS
	EKU6rNvG+9kmEKlFK78FuG1FZ+vK70+WEkDZ1hUjgX90USLNro8IfaxvXM9gtXRk4UWTPpnYnNi
	z9yKtYutikMY/sdWPTdB29QGH/mhOLje9zTB0GGxT5RFRAFJ5d8sft3lNyvWdZ5zIWa0y5/kEI5
	aqqKXhH4DhkzO/Q/gGMVZ08uMrVnOHQRXqRPfCC3A4GV1Orn0mh2+YiUVP8L5zxKrTbIkd6tD4U
	GQMqpqTdo7sgPnMiykEryKu7xkqZh3QoD99g==
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr401946965e9.13.1795663205742;
        Wed, 25 Nov 2026 19:20:05 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm537902925e9.8.2026.11.25.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:20:05 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntb: ntb_tool: fix use-after-free of memory window debugfs files on remove
Date: Thu, 26 Nov 2026 06:19:54 +0300
Message-Id: <20261126031954.168544-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tool_remove() removes the device's whole debugfs directory with
debugfs_remove_recursive() before tool_clear_mws() frees the memory
windows. The per-window files peer<N>/mw<M> and peer<N>/peer_mw<M> are
created in that directory, so they are already gone when
tool_free_mw() and tool_free_peer_mw() pass their stored dentries to
debugfs_remove() again. Those dentries have been killed (d_inode is
NULL) and are freed after an RCU grace period.

Removing ntb_tool, or unbinding it from the device, while a memory
window is set up therefore crashes. With lockdep on x86-64:

  BUG: kernel NULL pointer dereference, address: 0000000000000140
  ...
  Call Trace:
   down_write_nested
   __simple_recursive_removal
   debugfs_remove
   tool_free_peer_mw [ntb_tool]
   tool_clear_mws [ntb_tool]
   tool_remove [ntb_tool]
   ntb_remove [ntb]

(0x140 is offsetof(struct inode, i_rwsem) + offsetof(struct
rw_semaphore, dep_map) read through the NULL d_inode.) With KASAN the
same access is reported as "null-ptr-deref in range
[0x0000000000000140-0x0000000000000147]". If an RCU grace period has
passed by then, the dentries themselves are already freed.

Found and tested on a virtual NTB device in QEMU: removing ntb_tool
with an inbound window, an outbound window, or both set up crashed every
time (tool_free_mw() or tool_free_peer_mw() in the trace); with this
patch it unloads cleanly on lockdep and KASAN kernels.

Forget the window files once the directory has been removed, so that the
free functions only release the windows themselves. Removing debugfs
first is kept: it ends all user space access to the files before the
windows go away.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1599,7 +1599,22 @@ static void tool_setup_dbgfs(struct tool
 
 static void tool_clear_dbgfs(struct tool_ctx *tc)
 {
+	int pidx, widx;
+
 	debugfs_remove_recursive(tc->dbgfs_dir);
+	tc->dbgfs_dir = NULL;
+
+	/*
+	 * The memory window files lived in tc->dbgfs_dir and are gone now.
+	 * Forget their dentries so that tool_clear_mws() doesn't remove
+	 * them a second time.
+	 */
+	for (widx = 0; widx < tc->outmw_cnt; widx++)
+		tc->outmws[widx].dbgfs_file = NULL;
+
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++)
+		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++)
+			tc->peers[pidx].inmws[widx].dbgfs_file = NULL;
 }
 
 static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
-- 
2.34.1
