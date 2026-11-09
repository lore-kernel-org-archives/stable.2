Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225057;
	b=JN1ozW3oemOpqRAXUy2L6W5QWKoJUFPsuYkZrm2QLeYevuRFkZL3ze9QTEqMQL9LT/M2
	 3EOfk3vK6JS93AxZwqVWSvQZ4NXPlTvSh0HbXbMoFGeLjFpacnCwra0otJ/GYTjfe1chw
	 IbAaajzSI+kjIvvYapu1RsP+g6fyEGOhQ44VWsW2/IdZNiaIYaXx3m3VEqy0BvaBSlshe
	 ugqx0mC+wW7vhSOgmcIS/Pla99agLlFBUKvH9OZOQGv2Rz3L5/35UZnBnLc2cpJq53FI8
	 egad2zSt0ueRTU3pcOD6b94vZZJDyYxptt1Q/iHzsAoCTE0Bu5kp9oPHC655aoAri4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z6bscx+xVoDHG6nk05Y2GvjGVXrUF0HJS/uHEwq9jUk=;
	b=D670PuToNueRB5IpM28p2722uzZGV+n1iI4zs+frkqQ4/lt2/OMC6OB7ML+wl1ZnivH1
	 sAEzEDT+8pE7xesLd0ZuyBzNBX8oXaxcf4zCKkTJnJ1lc098PsoxnOHn5V7nsEM3/TeEU
	 rjdjtxNSXYZuHUai8oG53nBlJ6LKxawMUNIGdOaZH/aW+mxrMvmFDi4GXHZyp0fk+3L42
	 E2S9DcPXUdT1XmE7Rd5e0eLz64zZdVHX9ewBbhtva+Dl+MELLpnANrNbTCVuNGGwpa39l
	 0rLCBaoXC7lk2nsRMnBqNTEzCosdYwqsh2i0YkwhWGdA3H6jWT4QZ8RPrtCgCEbTyTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S87JFWNJ;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4F606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B4F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S87JFWNJ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso107939066b.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794225055; x=1794829855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6bscx+xVoDHG6nk05Y2GvjGVXrUF0HJS/uHEwq9jUk=;
        b=S87JFWNJydoMxIV7mKMHe7x/pGXcmHCujJzMCyS8AHDCJy2Wp88bNO75387DA8g0j0
         jo07ecG0bZ7l17c1PgxWnOXUU9299sIPuQxkA2eCs2vE50tulaL+Y53DllCL7hvP0QSW
         LvrmjST5KtjYrh6qk5wXNwnSSO5REcGgKauM49JhCcrJC8i2XPnPtIucLBTv4HfKvLxG
         lPUx5SQB3KolAP2gsHDHAQm4SVcx20ceEsECKfrQ+826XTCuGQTFrog2nYR53V31w1Dc
         nPQlAw5hLesIB6RBmyp5rP1oN0269RlmSx5+RqokZvZ2vtL6l1SMMkQ1Z2X2wDlDxkHQ
         g/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225055; x=1794829855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6bscx+xVoDHG6nk05Y2GvjGVXrUF0HJS/uHEwq9jUk=;
        b=2JZojrUNeiOWR2sPfwXo0QUVLR7Hr5c1Tfja31YwOOOveRLi0RO9Kfv1IrdXv+weH6
         1VMTZBZ5G+q4yPUJ6zfZkVEoxDYLtwXSYeC8VmEbt2Uk6VSaNiNone9NbE2zE79jvFM/
         nLn0WtAssqNxZ7yf2deo2bdY/fsTwPYu9DkXTs2Wil78zprttQZ0ntP7VAQnFNIihQfs
         PjPqR4N7VKmXbZhwxeSw4Hk9GrMnHIWO30RuSEnBM7G/41TCsnGUWm1qRY+lBXCvymnj
         sgnu5oy1ZJ5ht1M40WZykt3lQWShksnqfn0sUeuWdUCR3orbTmVzhPitfwBHBE6TgGz5
         yAuQ==
X-Forwarded-Encrypted: i=1; AL+hErE/3f0P3LUCnjzuHwT796OvvqnqFzGv796xerPRCpR5vL9f2LtHT4wO7JSXof39i4c66m8n/Xc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/hPTjC96DE0wzgnqAk3SjlQndulTwf7CDfqEbaxVqApXIswaD
	kB2yDwo2yo3lAPrf7bJyFb32Rz109LKEFZcsj/QN/1mtPlVCt8oRnpPJ
X-Gm-Gg: AYBFou1C0YGs/GmzDSew+E/DCovtFzEEwZVx8h6whi/n0nv8iHEZbTT9heRd6NOekRS
	z0QnHOkghUEMOvKdFHbArTsBKMkCzTXWExEZ0Z8Df7YwyjAWq7YWzbmVoPhXqIo1CVJAANbb6ho
	6Y/RvHsroC+7OUfj6RkFFhDinZRcMv4QDsgZ0t/EcaPHeKaLcZ75JUk42IuX5p926Mru3d4sEgg
	z2+2je0tSQ02aNC/fPcWTxmHPl91g72Uysb/hkHQTSqnsj5d0vXFZOH2/2B8wa2TPnvNTp3s5c2
	b/L4RRepJWNPeOfWqVkasKWh1+Tgsb2RNtK4NbYwem/o94rwNqkDFdp2L3CnTW3WziKOufa1uJA
	zBAYLcvnFrTjx1dRMiS/Hf9tMBSzRSvP1peEDTAwPyg7ZK/9Em97XWrynbYF+Tp75ViV9sJsv6j
	he0s3H+K39xo9VOLGQ/NrVVwF9wXxR6VxmxvaD+/d3HQtd7AYDu1ikRnXBLX1v03fdlzL+YT2jS
	FWhEMUFmskH3Y80lnEt5n+9sr0+ootMHIXB8X8mf5PIJ5A3gNadAgifKLln2MbeCjpskW8Hi7kd
	drsIHIm9PM4AdfP9qziY5QJgoLXPU36tD3tNeSS9F3zbjInB+jzQD1MZ1VxeBIWDyYzdzuRZhbM
	RI4aku3vK6A8IvA2s/YTFTrqKvYbX6AsB
X-Received: by 2002:a17:907:c5ce:b0:c2e:856:2a08 with SMTP id a640c23a62f3a-c4d6d15a580mr277220066b.1.1794225055037;
        Mon, 09 Nov 2026 03:50:55 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52cf9sm153627266b.2.2026.11.09.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:50:54 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <giuseppe@scrivano.org>,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovl: do not allow nfs_export with data-only layers
Date: Mon,  9 Nov 2026 12:50:54 +0100
Message-ID: <20261109115054.4031784-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since data-only layers no longer require metacopy=on, which conflicts
with nfs_export=on, an overlay with data-only layers can be mounted
with nfs_export=on.

Decoding a file handle of a lower metacopy file whose data is in a
data-only layer builds the inode only from the decoded lower dentry,
without the lazy lowerdata redirect, so the data of the file would be
read from the metacopy file in the lower layer.

Fail the mount with explicit nfs_export=on and data-only layers and
otherwise disable nfs_export with data-only layers.

Fixes: 5ef7bcdeecc9 ("ovl: relax redirect/metacopy requirements for lower -> data redirect")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/params.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index ad7f30177ef4c..7a4e1be5225fa 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -931,6 +931,16 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		}
 	}
 
+	/* Resolve nfs_export -> !data-only layers dependency */
+	if (config->nfs_export && ctx->nr_data) {
+		if (set.nfs_export) {
+			pr_err("NFS export is not supported with data-only layers\n");
+			return -EINVAL;
+		}
+		pr_info("disabling nfs_export due to data-only layers\n");
+		config->nfs_export = false;
+	}
+
 	/* Resolve nfs_export -> index dependency */
 	if (config->nfs_export && !config->index) {
 		if (!config->upperdir &&
-- 
2.56.0

