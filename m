Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298819;
	b=dwGvei2IfrMuvxXshxEdOd2Xx8vyJVAshxKha0v/bH23bAikar8/0qcJDSds3vVn4v5t
	 E/XfX1wbSgRGFGj+OL2POrhci0oa1+x+gqi7/RWy49sQyJyRU7XuVQCjdKV4ZstPDSIFO
	 nvx3yntVig26GrgfL66Y3dyXP9sEYN7tNkGicEsSqpyPR/ZU1Z5XnnjeqEfQaJohC6Mv7
	 8GiZbiabLMK3TyAX5lLoJM7vKibvp3lFKOaO8RYH9fT1+znQOXMqMctbHh+ziikhSNedy
	 aXR67FPRTfbPCiPSEzONWrzJ60UJ6h8KLtZVRODlPoKZ3orqvCYB/kba6AiUo87AwJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DiM6YP4+CBrBTFVeBZJ25fnu2+VqmiWWjax4Wxfqkno=;
	b=BkN9JSnpzYGIlkg8kkQV5wBskqDR4WBtkSymCVLQINTr5bRAQElK2WNmb5RLYH/ZFuug
	 +trhL4Jmh64U71g0Qg41EANfVQ/WjTn4+Mq3eT3czcmnRfC2Oz5Xsmbma2uUti9/DOaqu
	 +lRFoHCdkHUKbzDa7nks6m2nH6vLdOPfQQXXIKCvYuG4fPblIDFC0jKOHXoii4iUaDfES
	 fUKWDS1PtWXv2yM+e5FPZxo5GH5npbip28Lvez9r3XtIRdSAnMeiu8ALCSK3T6rzwM3Jp
	 EgD0tVdj90bDwB3cNqJJRI/pJW/IvCVeJdFoAqEmVOffMOaWkJWf1rmyu/kj+wOtOqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzXhwZFJ;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00170606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00170606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzXhwZFJ
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b360828905so17182497b3.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794298818; x=1794903618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DiM6YP4+CBrBTFVeBZJ25fnu2+VqmiWWjax4Wxfqkno=;
        b=CzXhwZFJen+WMza8xTBvYfPZOYotMskv4Wt22df7oe4GD/fc9sB0wGaoBIsmfP5kV9
         7JJ+JREM4BkB51IK9ZpOAYZvu+8vEtF5BlN1R5Iz1w7TyNBG2/uHeFZ5OGXzUDXxeCM4
         S+czdU+6xAJPzWHAvWDUZCs2adqic/EAHeDxeyhqPSP52yX0VVnnPx5XwB2wQmV3mD/d
         Zm8WrC8spF1WNhraT1AzPUopwzC8pDeX8HadORQBmuH9IkJA5TMmOV4Re1u21BRVB33v
         Bobn/od3CDkwog4dFD1NwDjYjEM6BItdfyuEh3C/IP25GKWYYUBfD75lE42rDoK+dJxG
         lu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298818; x=1794903618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiM6YP4+CBrBTFVeBZJ25fnu2+VqmiWWjax4Wxfqkno=;
        b=bUhQyGUJhHEHROmfZypHKx0nqWpbxfGffua2vBzouDoBWXKte1GlOCV0cvT0O1h+uL
         LuvRz1rXqtKVRzC1OW+nYyCdI9lv/GDNYJZPlW7xvDkf0JNfV6udB//2o/Jwi9mMw0RV
         dAi199IHOqEmjussASRfA5MntCwOo6lcREJx4PA8A4VHeXIQTIMfklkdAVYjYroi2EGO
         1kKoQD5DbGLqVrcjUuWFmIBf4OuCtJ9ofFxeEWV5R79GsL3EJFBPzLuL86ib8lJa3oxf
         ZdvrREd4zAfSAxDi1PVtPU+ZaM1tsYpEfHpTs3jhq2eTF+vlimb588ArYNy2QFRKih7J
         QsdQ==
X-Forwarded-Encrypted: i=1; AL+hErH2ylO5hv+jrxGHB7zSQr38NP1peiYTbBlBa6Z82LR+U9y0hQ3K/5zncrWooreSq5+w3ic4W3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9recS31svgfvYfmP76fh27KKs+bpklu7g0LCfVfKXxgVcHdknw
	BISpVC/Q9D8cKJ3gTGCjzejqZShemiZOZVbkRVARkOC15YXDFkPP1Lm+
X-Gm-Gg: AYBFou1ldS3Up2y+sGPzfOk5mU35SdwoIcqm79AQNPQsy1VM8TQxnOlAKsm+My5GC7S
	dRRQ4CKAAjq1eP3eOSgWXloFv0f1USzGls3x8T4uYLpwXmdH2XuGOo0lx9l2d4Sb4qn+R4Ju+YT
	IdTuSK+WGqXCzP23t04HSXVPaKF/cAQxKhsqLQY7i3cq4L+4CrbXQ/3d2JylDbjS78iUKPFcwjF
	zGlOyD9v4u5gs+k+H8sLRNfgEHdUqjwnYCISvgfP5lNsp4QMnS/nmYVxoqiemfSkPbvh5d7wdTk
	YpcCbsd0UPuOob229aLm0X4vTZwYDwHyr83I40b02bVR/czLJDfKwYE+/9c0/N+S7FMNoN9IJYD
	1d3qDuPmeNvSVl1SXuGrop9idWm16TWew9wGRuC6rLzEsBDHNhqQO2hBuxdaesGcFyTTQIi6OS6
	q6kR707BpTlOe+0P4YnqT34KLDReMzRYgIkY95C57vX57qcUegiqI+rUAzWzopqu6ViJX9T24DD
	5qqWQWCScpiK5E6kaW8/vclvo7uu0IZFoDl5q26Bs7+7rOyD/w9vBdo5h0fhEx3kzAd+LtdSeU6
	RmAnFeoXA8Y6U3z3XTS62rm5TnKvnc//X1kLk3o=
X-Received: by 2002:a05:690c:fce:b0:8b0:f1c0:60b1 with SMTP id 00721157ae682-8b392b04348mr10481377b3.60.1794298816905;
        Tue, 10 Nov 2026 00:20:16 -0800 (PST)
Received: from bridge.. ([2804:14d:ba6b:8339:dbe0:e4c5:1b9e:1438])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393437e54sm13910647b3.35.2026.11.10.00.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:20:15 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] kgdb: Fix buffer overflow in the qfThreadInfo packet handler
Date: Tue, 10 Nov 2026 05:19:46 -0300
Message-ID: <20261110081946.38783-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

gdb_cmd_query() answers qfThreadInfo with a thread ID and a comma for
every online CPU, 9 bytes each, followed by the first page of tasks.
Only the tasks are paged, KGDB_MAX_THREAD_QUERY at a time, so the CPU
entries overrun remcom_out_buffer[BUFMAX] once there are enough CPUs.
On x86, where BUFMAX is 1024, a typical boot hits this from 109 online
CPUs (222 on arm64 and riscv), and GDB sends qfThreadInfo as soon as it
connects:

  BUG: KASAN: global-out-of-bounds in pack_threadid+0x2a8/0x2e0
  Write of size 1 at addr ffffffff86eecc20 by task swapper/0/1
  ...
  The buggy address belongs to the variable:
   remcom_out_buffer+0x400/0x420

Page the CPU entries together with the tasks, with one helper for both
loops, so no reply holds more than KGDB_MAX_THREAD_QUERY threads. The
CPUs still come first, which scripts/gdb relies on to detect KGDB.

Fixes: 25fc99991383 ("kgdb: fix gdb serial thread queries")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Changes in v2:
    - Move the shared paging code into append_threadid() (Doug)
    - Link to v1: https://lore.kernel.org/all/20261103190622.925741-1-christian.aurichzm@gmail.com/
    
    Tested in QEMU with KASAN and GDB 15.1. Unpatched, connecting GDB to
    a 109-CPU guest gives the report above; patched, 109, 128 and 255 CPUs
    return the full thread list with no report.
    
    Based on v7.4-rc1.

 kernel/debug/gdbstub.c | 45 ++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index fc6a7a8c1f6e..679fab102760 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -732,6 +732,22 @@ static int gdb_cmd_reboot(struct kgdb_state *ks)
 	return 0;
 }
 
+static void append_threadid(struct kgdb_state *ks, char **ptr, int *i,
+			    int *finished, int threadid)
+{
+	unsigned char thref[BUF_THREAD_ID_SIZE];
+
+	if (*i >= ks->thr_query && !*finished) {
+		int_to_threadref(thref, threadid);
+		*ptr = pack_threadid(*ptr, thref);
+		*(*ptr)++ = ',';
+		ks->thr_query++;
+		if (ks->thr_query % KGDB_MAX_THREAD_QUERY == 0)
+			*finished = 1;
+	}
+	(*i)++;
+}
+
 /* Handle the 'q' query packets */
 static void gdb_cmd_query(struct kgdb_state *ks)
 {
@@ -752,28 +768,15 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 		i = 0;
 		remcom_out_buffer[0] = 'm';
 		ptr = remcom_out_buffer + 1;
-		if (remcom_in_buffer[1] == 'f') {
-			/* Each cpu is a shadow thread */
-			for_each_online_cpu(cpu) {
-				ks->thr_query = 0;
-				int_to_threadref(thref, -cpu - 2);
-				ptr = pack_threadid(ptr, thref);
-				*(ptr++) = ',';
-				i++;
-			}
-		}
+		if (remcom_in_buffer[1] == 'f')
+			ks->thr_query = 0;
 
-		for_each_process_thread(g, p) {
-			if (i >= ks->thr_query && !finished) {
-				int_to_threadref(thref, p->pid);
-				ptr = pack_threadid(ptr, thref);
-				*(ptr++) = ',';
-				ks->thr_query++;
-				if (ks->thr_query % KGDB_MAX_THREAD_QUERY == 0)
-					finished = 1;
-			}
-			i++;
-		}
+		/* Each cpu is a shadow thread */
+		for_each_online_cpu(cpu)
+			append_threadid(ks, &ptr, &i, &finished, -cpu - 2);
+
+		for_each_process_thread(g, p)
+			append_threadid(ks, &ptr, &i, &finished, p->pid);
 
 		*(--ptr) = '\0';
 		break;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

