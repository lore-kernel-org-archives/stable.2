Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202035;
	b=3K+dTIHf9Phq4EwWYVVNO1wtInyz9FNi9tvatn1xE6P4auHU7grkkdPiOMknyzNiILsF
	 PUUaFOuxjOdzkKf1EUzvCv3NuVmXuVPLuAvQvhFsC1ZvWmWZDZa031nQyPFly4R/T7FAr
	 +R4M/U3niDcKfqomOXNq/WXQ36RdHpxFuar3oFPnjslQFvkZE+wcMrmou5lzLH+CDxRZT
	 CQSj11RFEDKNcfafdjDg/rgKzThBlyAAy3USkfHvzwXmWXChgXVOOnvQwIrnjaCEnAPRR
	 EASyZJjewBxvk4ZiCED+C4sT34oaJ1E6NMPlKJg/Wf+ewyaSz65n1xXW/KB05InFDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
	b=Ed+S9H18+KrLugjUCzVluoo3MVCKHAlCbPLIobdkF59xcXDIenK0Zenmt/l7M7Waqysb
	 9hIZUMMgTGgeg96uWnBTFZO2iOD3MevO1cl2LCu8cFG89LarOGwin5VkHMjIRmlrRINo1
	 iYLMJe7loxCYLuncqj4QOydxCcc6AsAfG8s+kJaKvyG154qfyvt9r7OnonQVtko7TTSt3
	 s4DcDR3uRhMWm9DaluHiK/QINntVooSTHrGMxC84f+kxqLrnxrft64qHatRSB5mZzuC9C
	 Jk74X0r+VCZpP+54uqPDD5feXENi2Q657U/axjS/TROwKf0WhD+rwyhW1j6XjlUtp4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1+8Ak8Z;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE71606A323
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE71606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1+8Ak8Z
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-369fd8abd71so1117789eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202034; x=1793806834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
        b=w1+8Ak8Zi6w+lNdL4lEsx4wFs4qd7BtSAE9I8Q2jgtDkMIwbe++yhLjWCBKgx60WTL
         Dl1s5NMPXeUJodvIw07ZBpeNlPxdKOY279Zc0+iH+92DW5UNb/71e/UNGuasDWV1hXd2
         YBZ8WojFNZKqLAmmMlBvkglHjQUb9kXIjVOoZIK3PJLzaJUFmEtnN+U/9HlDWGHVVJ/l
         grQDWcSRW9pa5lmZfRAjrv3s9lwkq4tnBK6aF5evtMReYFBXzFjVI+SlFSX/EW4lq8y5
         XniL9jNnYlY9OSTdnL8ozKyMriMqRHb9+SNK7pZhrn1i+nMrT/4KoSaEoFIimm2YXiaN
         sp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202034; x=1793806834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niA4UwOGFOA4mms81CnxsMGO9J3yqXrymq+0Zzb3sR8=;
        b=flpyOS0irVCFHM+SGdBoijRhp3xeUiDQHpZhB1F24V73Tj++DgNtWKqCuPygi+TNy+
         CJGmoC/if1pi9PltrFUwpJR5llCZHCNijPk9uwT3nWFZSzibuoj3zQ/vVJHuL6jGtk7w
         BKdtPsNTrJ54FF5ajs/t8HwwJacNbXUaVX5TQJd5uyORQuUz6ES/ou7+m+W0yOGIBSoX
         W5a+QAHRX2/FufVLrVizZy07JxDg3hslax+nYx7pEKZ3PUaZCS9tF3atqBngL4tCxWbi
         B9MFSmTgT+wopmLefrZ23IFLiWhHmBcR6J9AbUrMLQNBplUJEw89E6xtoWRPSogsgzhb
         DZTw==
X-Forwarded-Encrypted: i=1; AKwUvBxQQmKPQbAv2yn7ip4sIUbwYAQs3TmuLna+G8svAnPgMu7Z7HLe/nuCwtbe6qezv1a/Ly6Xd+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUHto0Qc36C7G7QS4d6hOAe/eBxdtvUDzYXpAkxMloUHSoqCRT
	2iZp7e568Kc1STsfCTC2SQEPBHAnx7YBrJRZ57rUiDoYKjHHaOGL4GxQ
X-Gm-Gg: AYBFou1NePugoAiM0Fh/W0Fv9XVXWbL87mb7QCsZCVA7xF68jTVi6dbg5XxJQSMa2ta
	/VQPCn3auACb2fZZMVGHrfOqDwJyr1wLtfmu8RMA5zvAJBL7KrrsMPSJqHkTLfwMWRvNferc49d
	+Os53sPeWUmhsik/EATNwe3rjsH0pUzf9gSGPmKh4kosWvVvOppLhzPjou3OymKeNUrnmM74OK9
	1V55ixe2SOIMfhEpVoldhwlf1B6B7wAZLHjeJ75EZrgauG37A40PaYgYY3g/WNXWPWMLI+mSqu9
	kf0FwY+pNOsw4AKjWlcDZTRbkl8dWpjkuQaTRoPyvUGwM1TEXzyCx6FcMzvgO3im7UBibJoDGTv
	HVNzdXTwvMFO+4NKpPcdN4/BagO3m9+hGH/kOgjR6d96QDRrterlg+K5BjhlL10YL718HYBCgNX
	cesOKZ8dHVtDIatt0s/HlFRaKD+Y2mFnPWYAPslKC2fVGxBjkuB7utQOwieCDUtF1cl7NsDhDzq
	vwG6+hv/x8kkQEfAd7E0gz7k8ylREjXxnop7cen0t+t7YyLumOOgAYZYgjKmQUwx96bfbV3RzJW
	+OhzG8pEr2BTdjfZm66HzxC2stSeXm1AXv+7BH7ux7l2Xjz/xw0oONJzvP4B9nqikoAvJwATKyE
	ixA==
X-Received: by 2002:a05:693c:8946:10b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a20407ad2mr4331113eec.25.1793202033635;
        Wed, 28 Oct 2026 08:40:33 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2392ebcesm7873678eec.16.2026.10.28.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:40:33 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	andrealmeid@igalia.com,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] ovl: restrict casefold consistency checks to directories
Date: Wed, 28 Oct 2026 15:40:08 +0000
Message-ID: <20261028154008.67451-1-dennylin0707@gmail.com>
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

ovl_lookup_single() compares every positive child's casefold flag with
that of the overlay. On casefolded ext4, regular files do not inherit
the casefold flag from their parent directory. Looking up an existing
regular file on a casefolded overlay therefore fails with EREMOTE.
Symlinks, FIFOs and whiteouts are rejected by the same check.

Restrict the child consistency check to directories, along with the
corresponding assertion in ovl_get_inode(). This allows nondirectory
objects to be looked up without rejecting them or warning about their
flags, while directories with inconsistent casefold settings are still
rejected.

Fixes: 16754d61dc69 ("ovl: Support mounting case-insensitive enabled layers")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/overlayfs/inode.c | 2 +-
 fs/overlayfs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 63906b3dafcb..4428c50c3185 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1278,7 +1278,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	}
 	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
 	ovl_inode_init(inode, oip, ino, fsid);
-	WARN_ON_ONCE(!!IS_CASEFOLDED(inode) != ofs->casefold);
+	WARN_ON_ONCE(is_dir && !!IS_CASEFOLDED(inode) != ofs->casefold);
 
 	if (upperdentry && ovl_is_impuredir(sb, upperdentry))
 		ovl_set_flag(OVL_IMPURE, inode);
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd..023966d89f74 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -266,7 +266,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		goto out_err;
 	}
 
-	if (ofs->casefold != ovl_dentry_casefolded(this)) {
+	if (d_is_dir(this) && ofs->casefold != ovl_dentry_casefolded(this)) {
 		warn = "child wrong casefold";
 		err = -EREMOTE;
 		goto out_warn;
-- 
2.43.0

