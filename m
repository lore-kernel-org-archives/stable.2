Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1D47ACF1
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431794; cv=none; b=NGle5vFnrhP3nmhQ7jthc6FMCHqQBVxkJtr1fwMuKCqxWzYeigzZO3ww4dhbWtKR1CkUnVAQCQtGNBsQ3eZfEBaQuspJK786YyCKaMJc+TjHxn6K7hMWFuqx/nH0/CVrggK47hEnb0g/w02ubmxP4dCEzllKhjILRyW2gkinTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431794; c=relaxed/simple;
	bh=5NhOeMwcPL3cNQit8Uf28rrEJeSCa/+CpoNhBZRrIyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC3slbvPB9oPlL1izYswqMZVsumrQVUe1WjU1bvOtMgOFC6q4SQqhv/xPWup8wTQhijuxgaNIP0zL+XKE+SgFTHAWHb9D6AGZGdgZm89HAKQdg5J7TvbbEe8WXwdGrzAIsOR4sL4Oyx6GJ3tAp5RT/jdnuo/Ubp7X0QpnMKbFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/aHmaOH; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/aHmaOH"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cdb9cb7feeso243640e0c.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790431781; x=1791036581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQMP576kCixbzoD00htnAcU/ItaFh/gYADgGL3x8irw=;
        b=O/aHmaOHjYRx84iTOspstA/o04IxztWPwhPQNP8mbcDQxFjU2/OZmB7ny3Hu/Sh1A8
         o5eA3c7CNZjmEql+oTWi64ayl8qYsAKIQmMJDIlML2MjdMuXM1FKeHkoXGd4153ZEdLf
         iLoh6/KDBgFW60ZPM29VVmN73sgXt3JYClgMUszF+xdaNvQ8ZhERJPIzJjSDIU3FesFP
         hDVb17UDceYU57kin5GOjN9FyOjVTxH2ZdcOxIC5nXe8YWGCjKl4aFlpAKRwN4dmkivf
         l4M4VICPgDPTSi/chmSieuyXY1nsPjHWXBrnin5QQ01Vlh7OkV5UT0fl0K88BRM/KSsl
         JedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790431781; x=1791036581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQMP576kCixbzoD00htnAcU/ItaFh/gYADgGL3x8irw=;
        b=ygdD31mlOR1dSf98IN/z8+EAtRXgi+fTbS1gqD4qV2xrgKmEmOiWAAmcxY0tPuTPMa
         v0wZuykmJgr9JFFos/NwNplBhkdw/7UZ+xW+psf+OgY9vYWxaWU/l6oIB+kRRnhmgfIY
         hSwK6N6p4tUkQaaas+qs9vjLl/Z6Avu1zFqLR4f/3VnU4ZVNQfX/pVHes5oa9qBvzRNc
         ulLYFe1/OaYNTxKI7QZ27QW6ouXh+gnU/NxWRnb98SAF8W5TumOtTqNOrG+w/nVP6WDZ
         WEqe7AE1g5TWry3r/4EOgE9xR1Y947HyDTmhwsh/tPidSaKO1++HgIx9W8oEZzJHvV5F
         Ja8g==
X-Forwarded-Encrypted: i=1; AKwUvBxAfckvyG5RXx6WaQSyTofCELlMfIO1lKjdl9FAPnPKsuYtnIfnWx8Q2XdGq8LlHaKnWTHuUKU=@vger.kernel.org
X-Gm-Message-State: AFuF++lT84YxdNjVjoRMPfGFDce+mR0kKRGd687NmZrkDd/BuFwideyI
	aoiPxVbXCW4ZyMShOZBnJPbnzLkxT4ZshCANj97gTTmZ1ic2XyaXRxry
X-Gm-Gg: AYBFou0yBBgls1WxajxQZopLmlke2CM+oudOgSx4roTp2LcmX26uehms5WvKoejEpCR
	2AsArhTVYynGN77uyihgQFVQcKvP0gOAMl7HL68L4jCfFzGuh9A/gAEvRyuxb66gsotWltSwdI/
	2wDmoLWtvCosm81sfi1TANx43W4Gjt3dNnxhatOUl3wdFYN38B9S9gPWX2csup+zmhUKVmz1Q7w
	ere0L6uK3oCWXZNXCMFqkE6gJvEqCirJeKTwIRIabEev1aD+mp/3NdVfnn83FXLtbJ/ctHf4nlm
	qOKIvEKFJS8K8b+w1v1qbXxkSIsbiSAGk1ocfdCXyC1WBhm+G0HU9aFBv1EE+bXbw43QxZpOjCB
	hXLDAPwLFVQJ7h+IxqBFmTpxD/r+nubgm0SfvqU284WMOyCE6NDoXZWUi6p6nlgzanwjOHP69r8
	lMNiy9zX+iVkvrt4KMhkjxsSrTpzTbpAmqwbFMvAMImpeXqTxGBX2MIysyHs8tOco=
X-Received: by 2002:a05:6102:390f:b0:7a6:d3f5:3554 with SMTP id ada2fe7eead31-7af1ebf5867mr3357716137.26.1790431780695;
        Sat, 26 Sep 2026 07:09:40 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afb8343sm6580624241.5.2026.09.26.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:09:40 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"sashiko . dev" <sashiko-bot@kernel.org>
Subject: [PATCH v3 2/2] debugfs: serialize concurrent writers in debugfs_write_file_str()
Date: Sat, 26 Sep 2026 11:09:30 -0300
Message-ID: <20260926140930.1077742-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026092647-ebony-unlatch-d3d0@gregkh>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_write_file_str() reads the current string pointer into `old`,
builds a replacement, publishes it with rcu_assign_pointer(), then frees
`old` after synchronize_rcu().  There is no mutual exclusion between
concurrent writers: two simultaneous calls can both load the same `old`
pointer before either publishes a replacement, and when both later call
kfree(old), the result is a double-free.

Serialize writers with inode_lock().  Use rcu_dereference_protected() to
load `old` under the held lock, satisfying lockdep annotation.  Release
the lock before synchronize_rcu() + kfree() so RCU readers are not
stalled during the grace period.

Tested on QEMU/KVM (7.3.0-rc4 + KASAN).  A reproducer that spawns
concurrent write() calls on a debugfs string file triggers the
double-free reliably (~3900 KASAN reports in a single run):

  BUG: KASAN: double-free in debugfs_write_file_str+0x194/0x200
  Free of addr ffff888104542ec0 by task poc/305

  Call Trace:
   kasan_report_invalid_free+0xb8/0xe0
   check_slab_allocation+0xd9/0x100
   kfree+0x163/0x510
   debugfs_write_file_str+0x194/0x200
   vfs_write+0x1ed/0x920
   ksys_write+0xe5/0x1a0

  Allocated by task 307:
   __kmalloc_noprof+0x264/0x680
   debugfs_write_file_str+0x106/0x200

  Freed by task 306:
   kfree+0x2e5/0x510
   debugfs_write_file_str+0x194/0x200

Cc: stable@vger.kernel.org
Assisted-by: sashiko.dev <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/debugfs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index ac4199e9f..c696fa44d 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1054,40 +1054,44 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
 	if (unlikely(r))
 		return r;
 
-	old = *(char **)file->private_data;
+	inode_lock(file_inode(file));
+	old = rcu_dereference_protected(*(char __rcu **)file->private_data,
+					lockdep_is_held(&file_inode(file)->i_rwsem));
 
 	/* only allow strict concatenation */
 	r = -EINVAL;
 	if (pos && pos != strlen(old))
-		goto error;
+		goto unlock;
 
 	r = -E2BIG;
 	if (pos + count + 1 > PAGE_SIZE)
-		goto error;
+		goto unlock;
 
 	r = -ENOMEM;
 	new = kmalloc(pos + count + 1, GFP_KERNEL);
 	if (!new)
-		goto error;
+		goto unlock;
 
 	if (pos)
 		memcpy(new, old, pos);
 
 	r = -EFAULT;
 	if (copy_from_user(new + pos, user_buf, count))
-		goto error;
+		goto unlock;
 
 	new[pos + count] = '\0';
 	strim(new);
 
 	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
+	inode_unlock(file_inode(file));
 	synchronize_rcu();
 	kfree(old);
 
 	debugfs_file_put(dentry);
 	return count;
 
-error:
+unlock:
+	inode_unlock(file_inode(file));
 	kfree(new);
 	debugfs_file_put(dentry);
 	return r;
-- 
2.43.0

