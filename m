Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F903876CD
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437061; cv=none; b=o2wM4cl0fGeGVx6ez6mVoQrXS8sNCAbhOTogpwAF2TBz12zzxjON1LmSlwwVPzvmDIMbRuMmbs0ZW7IPELA1oRwMj/5vojrkRG7X31+e/7PFoe/9ZmG5B+LovHPYpnxDwB9ZXhrrT0+DUDEt74SSz6GdT8eAf0XaT0YRUgCmpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437061; c=relaxed/simple;
	bh=v0Ax/0GmxO4xVaTCoct4d9rpu8qqhvU/A+t+7Gl3VBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XO9vWo4oUIs+6ObZs9oYnR17tuDSzLp7pBjR+RO0TLAi9CU6lqMkFN6OABSOmSAlHrvKAPdg0CXu6WaKvex10kdCeX8i2fKfGjyKCLzObP/kamagLp2Y7osYmt1xLYBosKvrpZIgILdiP/eW96VrGMJJ1jl1MZSfKTShWlD4xcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cur06KKd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cur06KKd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab066bef7dso100962a91.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791437058; x=1792041858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfzt/oNw3kBm1sNxgf8XLAw4jjuhyZRC4MKG/SZu2ts=;
        b=Cur06KKd0ifN+/42Ke0Yn1I8xGooulNIAOqrTP0eiDDG30bDAOoBVRmSXFCPViTtLp
         Oo7O0cejiVEIvuR8iz41u6rc7IE6dw56fl5HXzbZaAmlrrIPkkJNibV+gFCXHDZZ2Hzi
         rnhRVzBm5ZfSqj/kBKRnZ+kEGk4iXXqal4TqK92bMGaCkEisTQ+ft79pMKUAz0iQ8Ua9
         mDHSJemrN+8qg4RrPpfddYgg1OxsZ/a47eUdAJWRfY1WLAKcTtR114UOOMpd3KdJv02v
         QwR00V/3k97LF2bWP3RHA9hQ8Y01K9VjUrJg91qXvg9h3dh5YRdVB/pfh1G216YwIiyL
         tznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437058; x=1792041858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfzt/oNw3kBm1sNxgf8XLAw4jjuhyZRC4MKG/SZu2ts=;
        b=R+aV5o2iX84U8vBPz4a6tAs4fTsC1MNWL5cdSkLNWLG3TBIgEbyepF4oFTlB2gRH1E
         jb6XfR88epEK9ggbkdtgEbZehVv+5MTIvduHMsmuX29bJ50Aqmuyy23xGGH1MBKVuEcb
         8DU2Dm5C9ZkwtLIc7e0W93VLxoUm/hLAPxPXRcHdmgH6OfCwBZrTkNoMrBVZRtJkjCjP
         pa+Q6nh4D0U5RB76R51/7NzjDjk8pPMkRc3X32/aB5dI+Z/huexcvIPGZ9EY0llP+F9R
         /8Kp9hijPfcxnBUivTsDgexyJ5590rCHyoqW0b1dBGOk5D2Qaah5HXIJH+vr7Flo7VE5
         zBjw==
X-Forwarded-Encrypted: i=1; AKwUvByjvIBdcyDg4okjXHeXShN4kCt73CuHhrKpQAX4RdDSYdzn8HAzUt3668i66TONLwmT9ybYjsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYmXL5UKlvednUD3JGUkEA66X4PafkH+odinNjUs3eKBiKsPCt
	GwcQ3cbDY4bIHNb9/ZMLS82g8jZm8GvD2F8DcFyAMmKmabRl+e6x5sDx
X-Gm-Gg: AYBFou1PkMfiWCaWwqyilA9uqZ5fs6RCCupcmLyKKP63Icu8TYzTo0hvYWwoBgy7g1F
	JjvWocKiBfcfSgJwcQ8fNzmPFM6GXsbbr05P1sF/UXFvir7VB10opfwhHIUzfQL7uWsYBRcxkWE
	cdzZbhZMCBTCxVoqqWQVErcGHusZvyzP16S4B/EKrmoCT1HpsLUGy82YOxVPsKeLeVTEomaRI1v
	jTnyUcH6OSBmXHSw9ksT+DnRxEtBKXvw/7BX6wJ2RBOgoRrBVct4C9ZR6JgH64OzBzJAE2K4YWa
	JCM1S9aZTnDnMj4PLL5NindluYU/dHTI1j5WTTWEXX4sdddMWVsRKaQrwh+mB8lxeLbL2l/ie5W
	yUST7cpeK4Mx594xBG8FiDdqNKxgN4cRS2FlynVjivPvFL7i+k+AzNfwe8JgkGht3dnkYDsP1jo
	g9F2+DdgFpR7vSfpdgW/lDUQjamR+t5WO68bD6jTFsxi7XK0ysL5dkCo0CC0Pj4d7lJYo=
X-Received: by 2002:a17:90b:28c6:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3a8a1ceeb7emr3756258a91.66.1791437058229;
        Wed, 07 Oct 2026 22:24:18 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7a7445sm2464870a91.5.2026.10.07.22.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:24:17 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Ilan Peer <ilan.peer@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] wifi: mac80211: Pin module for hwflags debugfs file operations
Date: Thu,  8 Oct 2026 12:24:12 +0700
Message-ID: <20261008052412.541780-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, hwflags_ops in net/mac80211/debugfs.c
has no .owner set to THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the mac80211 module. When CONFIG_MAC80211=m
and wireless debugfs is enabled, a userspace process can open the
hwflags debugfs file and keep the file descriptor open while the module
is unloaded (rmmod mac80211).

When the userspace process subsequently closes the descriptor,
full_proxy_release() accesses the already unmapped file_operations
structure, triggering a kernel oops in full_proxy_release():

  BUG: unable to handle page fault for address: fffffbfff8056f03
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x39f/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0x115/0x6a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue was discovered via manual code audit of
net/mac80211/debugfs.c.

Set .owner = THIS_MODULE on hwflags_ops so that debugfs pins the
module until all open file descriptors have been closed.

Fixes: 3ad4fce66e4f ("wifi: mac80211: add strict mode disabling workarounds")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/mac80211/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index e38631d7cfb4..6a84321cebd6 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -529,6 +529,7 @@ static ssize_t hwflags_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations hwflags_ops = {
+	.owner = THIS_MODULE,
 	.open = simple_open,
 	.read = hwflags_read,
 	.write = hwflags_write,
-- 
2.43.0

