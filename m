Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839740D586
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520480; cv=none; b=PkRI30JaItM4BdtmYDdQ2JxkJ9fnMs4rB1GleLNIfBB9QYJ5DhkU6jC+ImqNpdDLEfHJ/Kk9JM9Y+Uhx7rTy9Myf1gXj3ss12m5uxsd9bO0TE29HQqxmm/IYDHQdeLUk5k6j6rw+XbVAK/lpUUoBQx5HljafKD3JREZvw1pCkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520480; c=relaxed/simple;
	bh=WJa4UCVH02RHe9+Oq31r/RrrcBb96N2j4OM1JKwV2Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i80W7CBCudus4hPCw8QW4mxcGaLivceR/EoMq2Q5aek2LwBD4jEKaCIDGBQY/KtfkxTBWFA+EsOQ7EZZe0/IPVuDYTnT5qya5TA//atSv6bf3daIKJGsBTNdpmeQodXAclHyejMriH+WuIXQUFrhyN1JA6fBeHimafWb8sK4Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jifd+g8L; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jifd+g8L"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304ec41197bso3473284eec.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781520478; x=1782125278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5p1FqpKBE/WpLH7RPMIfnZsLIdey33cIaJtrksyMY=;
        b=jifd+g8LSiYrnw3KRiC4cW2qqe5NgT3B0wGTZKVbYL1W11sFhdbm1j1f38eysN1OKd
         SJKY1sd52d3r+uGjbOeN4bZ270lTjdHAUmq0Q4+ft7wFFRT3tA3tazIYWnVarSOqeE8Q
         0DeDrPXKP5PdbN6uN3lQQW5kzYieiDyVFKe0lCN0zP8TkekMaZQA2tIIk8qycOhFGGDQ
         LS5Bd/gkMAUHUpBqzpjgWHWPOLd/oFCPxfThUVeEEgvyoP4+X7UXqAzqYgXxXw0r4HhX
         Cyk8eU/kx3NMi9cYtSFsLj7YWXmhgaNQim9zkISo9NR57KVYpTI0QnkTeEIopGxNoY3K
         08xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520478; x=1782125278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD5p1FqpKBE/WpLH7RPMIfnZsLIdey33cIaJtrksyMY=;
        b=Py6cJzu5fPqr3M6iT+1bw0/+wrQruLFBJFohlvVFlTxufrQ+8nO3DHGP90hYPyZJkG
         U5jNwVEyubUw4SZC6lhJHg61W/3hsDoVQtJPKzN5TPgKpHlwJqF6zRwdkmfACbtobms9
         Cnc20d7Lwx/QBe5PZw0VLNvt1o0Zl/hDvOUGOEChUBfxqHgfe93xgN1MuBhvo51r/cle
         BO2HUvuGYWBYE1r2KLnI4Bm/pt5uXH8Baovb9A3XZ1m7Jk0+ROg5IeHPKovZZ481f/Q5
         9SNGuiX+tZdxwkjVCglCYO7drEn0/q4BH6ad24e6pdcQkGrRnyIbDJaIO4xJAhJ2BLuY
         fPaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dRrcUFPoV09j+qZLYm1ZZJRilelj8zLzft+iLh/ZrWxHSmKHUt+0IqgU3BCgIT+jL1AG6fEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyH2DjJv5yH+vt0xmgdAugtY0zHvz15IxKHhojyIpAlCLICbjK
	3YSthHFn4fo4MWtrEiF4NlnlLsxpFZA6u9oObmrsG7kflFkMon5H9Gpa
X-Gm-Gg: Acq92OEo0sNk3NbkrdQifEN8towhbJ4V7S54z985Sy06BRLLgxcv9xAxB0VtoXdI+5H
	XVnqgu7aamG5haITD6yMs4amJUosAlsxRMQbg5FSmSdJq5jW6Hd0UUm3kn/US8wFbg9O1al2xw/
	Awgr5t+Kc0+/IgoBIan1f3/tIZZkXDi5qyRe3C9BdVGywD15SfSa96tMXguFv35dDx6pBI90LYP
	vRaPUQOcda2R4V5tN2xomBRSs9Un2BzOX3/UnRYz5h4XdCyOcVIIJeeUrVq13Ei8Cz3dhdqMnho
	105PAiYTcsTXXLYorpFMeaIdHQ9eHggZZgngs3SMeJHCAF5hxWkRjaCZmAeHqObJzw6IXB5ODFR
	i6vYWWFUQ93n69kJrPiiPkf4GfydoFh+2kTkBveYEz6AqSNPG6hmgr/xaJu/kHpd33gC0L0q2ts
	nKlLFZXXEH/fP/05Oo39nNwA==
X-Received: by 2002:a05:7300:501:b0:2ef:83d4:647f with SMTP id 5a478bee46e88-30820096d98mr7471008eec.25.1781520477763;
        Mon, 15 Jun 2026 03:47:57 -0700 (PDT)
Received: from linux-691t.suse.cz ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm15480774eec.4.2026.06.15.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:47:57 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Chun-Yi Lee <jlee@suse.com>,
	David Howells <dhowells@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Date: Mon, 15 Jun 2026 18:47:50 +0800
Message-ID: <20260615104750.1000-1-jlee@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chun-Yi Lee <jlee@suse.com>

Commit 651fdda8406d ("relay: update relay to use mmap_prepare")
changed the `mmap` file operation to `mmap_prepare` for relayfs, but
the lockdown check in debugfs was not updated accordingly.

This prevents debugfs from being locked down when the kernel is in
integrity mode if a file uses `mmap_prepare` but not `mmap`.

Since the conversion to `mmap_prepare` across the kernel is not yet
complete, update the lockdown check to look for both `mmap` and
`mmap_prepare` to ensure comprehensive coverage.

Fixes: 651fdda8406d ("relay: update relay to use mmap_prepare")
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
v2:
- Add explicit From tag to match Signed-off-by.
- Fix Lorenzo's email address.
- Add Cc stable for backporting.
- Check both mmap and mmap_prepare as suggested by Lorenzo.

 fs/debugfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index edd6aafbfbaa..08de6652a4f3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -273,7 +273,8 @@ static int debugfs_locked_down(struct inode *inode,
 	    (!real_fops ||
 	     (!real_fops->unlocked_ioctl &&
 	      !real_fops->compat_ioctl &&
-	      !real_fops->mmap)))
+	      !real_fops->mmap &&
+	      !real_fops->mmap_prepare)))
 		return 0;
 
 	if (security_locked_down(LOCKDOWN_DEBUGFS))
-- 
2.43.0

