Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556497;
	b=Rwn51SWqM0Yqh6W2pJiW768lMpyXLcntEmUDupHUNqc/mmwC3tM4Wp5MM/RqRkAMXxIG
	 jKVCpoM/JCMuQ5T6ZB45MHDTioiPZdFZsCHMBIE9SBEgm5W21dzEex2T428Eue0M/63+g
	 /r3eFWnCEWiFxw4+oZzIlQg/5H4VIYYU2fsBwck4sBM1Q1QgE0TbLANStwK182voxKp0V
	 ai9VAPcCsF7c6+uufm6D6CDFSNhBzT1lAcZbWfQwomoRvvuOjoEJMumMlCFM0PKc9JaR5
	 fs9YTpxeW04JtsweBEmFAmgLXhfTycQFSS0JTa/teoVJmJ368d0FdyZnVnGe8cnd4vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
	b=sdfo4N1K19iRC4pm87RcIIJUgCYCdqOuqc4oU3TtkgoQrVU8SecIEin2upaNkTJkVWnU
	 Z7p7xzadaaKAVOxw1BJfLbywO0/PTGodoJzq1kU5tjSNlM551F52eEMK65qPYE564kjmG
	 GYo8K2VzgMObSA75Eq9ZOHz3jIY5BZwadTZ0jW0agFAQ6veo3ZSzOkShHcHOIwIg+OaDv
	 2idDSXwpJIBNf70wucRkf+DJbRi3cyqncoIzFfnta79/8cxL8GvJN6EPd3IR28GLs3xxU
	 TIa1deo2nNmoehpiabupbBN7WKZDxXpPdeL6E/2HARGUElzyaypVbHXlykhgFeDCqag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96324606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96324606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso4466666f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556495; x=1796161295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=MtSrbVdvXPESULp49wFyKVViyU6uV845m7VObPFqQPp+cyXIAZJY0lPMcSZaqh9RMU
         N1tn7Cskb/nzr5TmOpSei1JbApwJPvIUOkkSfAmWzK/tZT6ItSWCfbM8Dqt8uRrm6ILw
         uAxYcp3P/gS4qEes1+47utnIUp6VHolN9lPusRgZZNHcsMeZ4aRO6PXyE7zt9JRzN+of
         s7geRWDZ2G5R369y+x98KK0gmNXD5A+NLVUkRHcLq6qgLwbJ523zzN2yhGFEmYMiWxsk
         XHOahvLYAKaR6JTglJyNLuiV8s4uu39q9ZuzK277Cjv85T9Pg0iVNzTDL3rWXY+2B0vz
         bRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556495; x=1796161295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=KSPcO0xzJ6Q9B+KTpVzCBNXjRcmNUM1DLppoItUXv58N4zBz0+3s53CGLRVjAmKzt+
         3ZiqaqgFWud1wbiz8cafnZvWTMmVtPcsvCy91CIkaWzg+Qbzb3WNVOuGC1gHjen0xSX5
         m3drtAfOF1DDNWhHnSR2iL6RR4gWUbzR/W7ahn0VFm5sYcty5WO/4Yp0PSAprZWzPe+q
         4sSOX3639DybGCk5w8n+YrEQVOKQssGZf6pbyRWMnl6W6UGUSPlir99nqsIzamOSU+dF
         teCS8i1lG8lTJZ0HLBpJQgASt2XXmQ7mNMSF74eGcz051srXQjbCMR61h4T61P311n7b
         yhsA==
X-Forwarded-Encrypted: i=1; AL+hErFV8znDkEjmwC95BRwJBO8gBONt8makIRFqEjZ6g2Vn9b4O34IqMLBOQpZD3Pj64Ktf/ItE32A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mnBUxqk8Gp1rLoGAhufJiEKVZCkrvMThTagaj+jvSnMvwmFsS
	IxCKsARy4s+DPxxCPctv1sM1LrZFMNUX9+75851pKmuaj/J0SCiRYmY=
X-Gm-Gg: AZFdTZem5FZwnjBDsN8yJMyqPbiWzNSO31aFHwH9lVrKDgCTVlpbkVmMvdsa6aLUpGM
	E/p8rNaOGQYsIrpFZX6Se2kMFdODsQJfnTV/mAg2aN+nnHiko50k4WKdW/v7wuCou8K0zrZPKy1
	v81zsYupHAzbCO19LBSWboDuNOosIUCUjlghA9PamC0HmXY9PE0vgTD3vxmfNsLDYlGLmfMIsle
	xst6HxRxOEm029az0KCYij7lY76ETEXAVQtQYn0HJpn4SZlnbyzYb73EEZkyiKtZ1FmfMNxC1gL
	esd9YLr1p9HXmRy3oHFcLF20e+c2o+yxutkB6CEZKhGYEbnt/pS1nhjSFoBOg0aHpXR8CM48e9W
	AZw1VfIa5yvpl4Q0fr52+FEns4ChMT8tnWnkuNRR7clIBzI2d7VldSfwBMti5V9Za8Ys8Wl1H/m
	PE/gWpkirlvTCYzljtitk3XxGeyXATKfWZimwUFYQ+KEuHujPWamWTs87pc4acdJre7H566Gpn/
	GPl+kUoiMsYtaF3BRSYWT79hGUyu9sdGqQqKw2jTe6RyUbSzPsPu/3Go83YJYQC41/2vtYl/enl
	svdZqpL7yA81uqM=
X-Received: by 2002:a5d:64c9:0:b0:4b3:f000:1bdc with SMTP id ffacd0b85a97d-4b3f0001c13mr12286559f8f.45.1795556495020;
        Tue, 24 Nov 2026 13:41:35 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm31041908f8f.53.2026.11.24.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:41:34 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] KEYS: protect construct_key type dereference with key semaphore
Date: Tue, 24 Nov 2026 21:41:25 +0000
Message-ID: <20261124214125.3198541-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem,
then calls the resulting actor function pointer.  The key garbage
collector retypes keys to key_type_dead under key->sem write lock when
their type is unregistered.  Without the read lock, construct_key() can
observe a stale type pointer if the garbage collector retypes the key
between the pointer read and the actor invocation.

Take key->sem for reading around the key->type->request_key lookup to
prevent concurrent retyping by the garbage collector, then release the
semaphore before invoking the actor.  The semaphore cannot be held
across the actor call because call_sbin_request_key() blocks in
call_usermodehelper_keys() with UMH_WAIT_PROC until the userspace
helper exits, and standard helpers such as key.dns_resolver and
nfsidmap take key->sem for writing via keyctl_set_timeout() before
they return.

This follows the same defensive pattern as commit 925c84e3cc21 ("keys:
Protect the read method check against type removal") but narrows the
lock scope to the type pointer read to avoid the deadlock.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3: narrow the lock scope to the type pointer read only, releasing
key->sem before the actor() call. Holding the semaphore across actor()
deadlocks when call_sbin_request_key blocks in UMH_WAIT_PROC and the
userspace helper takes key->sem write via keyctl_set_timeout() (Sashiko)

v2: hold key->sem across the actor() call, not just the type pointer
read, matching the established pattern from three prior fixes (Sashiko)

Build tested: x86_64 defconfig + CONFIG_KEYS=y, gcc 14.2, W=1,
0 warnings.

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18d..ccc4e94197423 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

