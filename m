Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425218;
	b=bWn8VcVk7qNazHcbAKB2KcLSM2ntCMCgf+EDO6KABzaajYqAQirrYujbDJMZaKOO29Sl
	 PntXxNoZyK6p42vO4DF/AW6FaP8vkObM5y8tg2d8wvZKPA1rqvNqpIpsL/WOTLMobzFW5
	 8oGVB9aljvYVmVSWllJszTzmb7KVX/slU5TGgNGqdsC/PwjfwX47HzKAlc87FmT9CAoHd
	 vgQVFKggRfRDY8WMeA5mGrgCWaxHUG0dDXTDcvU+mzAwyFNh+iqiUYiPfe/VFcvDZrF9w
	 TrZnYnd0tRjJzvgk/fV0wJMs5qMsuk3oospQN9EVE6LZcJ6ETisW1G4ZqfBWbTEKVWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ebivgiuvbN3l127D1q4e6dwezpwZR2FhoIKtzcUXl9k=;
	b=TG02/8oGLwEL9MHZTzgnRUE+xOSFm03PCF6AwHDV4LyNTZp8h1cKhNI6ErJNyfv4crFy
	 QTAt26K5Reb2CcaifkmFaZ8QphP4H7kt473wvxR0nX+7YFRmNtxClx3wMkwdOhbrGhRS5
	 nf0p/9AV91vDD83kSNqiLN22+okh2QY3bhq9RR2bQyuRih0mAFaAkM1prLepVMNWL/z8I
	 DVL6gl4B6N8pOfJF9C5+11cvyRCgvW4E+MAb9BPu4YigsU28Son2lwmBHBAwgb0QsXwpA
	 YpY7G0z4K9UiXlPjOUv3ye/vS532VG8a9sWa1AIYZdFad6ov5b/c/wpY8UeonidrmBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDzZi6Mn;
	arc=none smtp.remote-ip=74.125.227.203
Received: from mail-pi2-f11.google.com (mail-pi2-f11.google.com [74.125.227.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A5606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089A5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDzZi6Mn
Received: by mail-pi2-f11.google.com with SMTP id 41be03b00d2f7-cdb46439b0aso1670911a12.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795425217; x=1796030017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebivgiuvbN3l127D1q4e6dwezpwZR2FhoIKtzcUXl9k=;
        b=GDzZi6MnBEvAb5mfrGHTDZnI8vjcqgLv9IboHCyECqWIZ/+9FelkzoZWjAJJf7fjhg
         ztf7ymroCZbKuE2FHIupYfdSNCkX/CltmAaazkbAfdNyAsK45RI0hw8wKOmCfpBxbOxG
         S5RfZWTqV4tiJ9RjKVArefQfKjsK+KBbuisATxqSpX8SEyx8fPp/vgkynN8m9FksNO6D
         PB66E70MTiKv2UARPEw3XHnhHEYBRc4skSKieU505f5L24A9aPALJixlOdQxB5I+KRqF
         enj9PWPAFfcwIP14EU8l043te4GaCiNvrqmUVppybSwy7oDjps/e6HYEFObGweMyjp5P
         o6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425217; x=1796030017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebivgiuvbN3l127D1q4e6dwezpwZR2FhoIKtzcUXl9k=;
        b=jCstMY6CUr3HxdhkeV2ZytyMTqz5XO7ruiLP/ci5/QpSUZb3BAsGrVXQ0M5+SF0z7r
         ++8Z8r+zDmuSDJxNSbfBfwKbKRyUq/bRZLMMYieQWyEj032gszFXqGeWQI5SviOwvElx
         1BldnfYAzy5LE0gJ2zvfoJ00vDYHdToGwjjKRZgev3tQSeCHtuMw0w3NU3mAGIYSib5L
         Ol4TXtz3wDt2XVtAwxVvGxQ6XnPzC5i05Q03GJEN9vhSTKugK+BeY2UgJPsssaVt7aS0
         NBeP/lCqPQUwWK97C23zaE+Q1VKL6wzivElbD5bANjvAyfIVkVbVEC/9hByt9L7uEc6d
         gwuw==
X-Forwarded-Encrypted: i=1; AL+hErGHAVXgzLT9SiGgicjWYWH+KwShAPb87tfaYxzi5rxvsH9pIfs/lWXMPwYG0fJOHsc5LpZXm0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A398berGXF2b/8k9qpG1a6Q4tTx4y9sHMDjeGaeCBfHzjk6wY
	g1ITlVDH4x0RqdvqgCFra0SvWtKRAXlUdJ4bJ0p/p4L6x5K+Es7/nvod
X-Gm-Gg: AZFdTZdhKbNQtjtNK15KwqNWETVvCtvrvev73a9A8MiNygpfyWKgrSmS2HJl58PgFCe
	aJ5+INpG53Uauud+DKKD0BERTf289MRRxRyKCUWwnovFfumhsqd0o/vt9hTxOPbRXvEWm7Qz/y/
	E9TJzLia+dRvDdsTmm6Ao2/QHxCv6O0C72CswgPZEnE2oTVwRhJzabOVHhhU4jz1bhTxcTGaDBN
	8G5RpZ8n9EBLst/q+4HPUIe6zYEggQ2G0rB6huXKqeA08ziKCDDLd1ql1VFsjbB2TWZUl8+8CE1
	Vwaqs1QEZUQmLl2rIW12irkPBT0on1pj5NIJ6rtEZ5QI3F6FBCRXdzKRQx48j7kqL0jlRwEbMbk
	X6zGShQraTTTLrFdo85yZwU/Kj7T9bbeLPE/FEQ9z9ixCtHTT/eaiLpSxZbDql7Z0j8ToTTZ8kb
	Q5sd4S7GXJyMmf512b8G9Z+YjcSL9eRugLmZVIJVVcfcvkiNEHlxehse2uNy3z8VvEwKxtgUP1u
	EiiX82t2uagojJPV9v5fxjbv9hMWCf2Vgbs3RLF+4pWJmmVkMcXFFyE7gZL2Em/KlAPXIbdX3W/
	IbGz402VnJeBGJZJ7pV93nM3PzkQcMQwvSPS+H1R020sh2iy7RuMfXshwf0ipwjUvqLfQWpXU78
	=
X-Received: by 2002:a05:6a00:3e29:b0:870:c2db:da2c with SMTP id d2e1a72fcca58-8c87c2936d1mr9928497b3a.25.1795425217254;
        Mon, 23 Nov 2026 01:13:37 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87344184fsm5364341b3a.35.2026.11.23.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:13:36 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] signal: initialize k_sigaction in sys_signal()
Date: Mon, 23 Nov 2026 17:13:29 +0800
Message-ID: <20261123091329.3658965-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sys_signal() builds a struct k_sigaction on the stack and only sets
sa_handler, sa_flags and sa_mask.  sa_restorer (and, on sparc,
ka_restorer) keep whatever the previous syscall left at the same stack
slot, and do_sigaction() stores the whole struct into
sighand->action[sig - 1].

A 32-bit process can read sa_restorer back through compat
rt_sigaction(oact), which always copies it to userspace.  The leaked low
32 bits are stale kernel stack content, in practice a kernel text return
address, so the two syscalls reveal the KASLR slide.

Zero-initialize the whole struct so the fix also covers architectures
that keep the restorer in ka_restorer.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index dd770e68faee..460dd4d1d548 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4894,7 +4894,7 @@ SYSCALL_DEFINE1(ssetmask, int, newmask)
  */
 SYSCALL_DEFINE2(signal, int, sig, __sighandler_t, handler)
 {
-	struct k_sigaction new_sa, old_sa;
+	struct k_sigaction new_sa = { }, old_sa;
 	int ret;
 
 	new_sa.sa.sa_handler = handler;
-- 
2.53.0

