Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFE305674
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430504; cv=none; b=Rj0uB0bABr/sIj1z5//lXz01C2OPYapWNSZp5cyVuxqu/8LOofDADZgvfBUdCyIn+DgA6g1DCH/a1ZiXKpPEjyCVblt/v4DQ+pHrgTFXqQ1wf770ucoBjCcbEI7JD8fd+i3jmCG0lpioszGaRnB1zjjGjhMazcMup6h6CFM8k1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430504; c=relaxed/simple;
	bh=bBJpFyWvbS+RZVCK6Git+1Asl9nlHVjk3YAQ3yUX9CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH8XMIjgdFcXPYOWT4gD95XVmkIsX3Cf9JDAZenfn78MtJMgA3GcmG49yQRl2VS8wHwqaFLDG3btKMH8rQg6O0jJG7ptOaz0gBpP6+UEEke+HdYD2TkObxdiSdD0LusJsPsniixPZf88Xs57pE4rbWaBE0i5x/vL/xx5SXxGgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJuK6VHJ; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJuK6VHJ"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ee9debe9so1644314c88.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790430502; x=1791035302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeFcGxb1uwCheJVrqnsn9Byp0eD2Vym48SlgBoqjnW0=;
        b=qJuK6VHJyBOZAuyd2SkE6XSxzzRYfKFzSB8ySjPfxivOwjIm/DNXdjJEbrq+otPkbx
         OTrC9C1CNC9Lsq2O3PTql4ggBKdYKXug6Y9OJLlQoL7SbCystRWfbkwLeDz//NRTIw7D
         w9Vx+iahl4d3xv8twCOcwPOayFJ0aO3KPVppSLyRc2ISLeXduC/776kYN9J6x5JHEUSl
         hBJhMId+CevQd6dVFmbJMj1tkEFKaPxwdgzrPgrxFcum7hiwqf6tQbpxq89wa4wYwH0s
         f1w4oPTayRcj4vk708bTK35tCJlWB/xBBDR+VK3ZO6oknPSjC6KoJQmqHj1p2+I3eDnY
         PMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790430502; x=1791035302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeFcGxb1uwCheJVrqnsn9Byp0eD2Vym48SlgBoqjnW0=;
        b=uEXsr6b1frOyDgx91GNTSvBQK6gBTGbwR/sazEDiA/5k7L5HoXu5eim5Y3z6zM3bv/
         97ymuf/0LeaXXtzPXYpqBWbw9KDXQUB0cHvLW5crlvEnLQ38bJIVZ9OT4dQ8oDz43M2d
         iTSTGXFH5T1hYEaa94eGme6jJ5Km+C9keSsifZQZpIsiUDzSvv2qoVhc4TKyeO0Zhz4/
         uowjRGuzjU2eanci7AGdJ+xw8pCzN0J7BmBYswuez50GeEL6kICWyJnkY7xwZAYpsByf
         8SMxjyjyiOwsxgzut8FQFP/dkRFKJR8hTnM2WFOORHvE1a+0sYG6SjUEw+rdHWtsffCD
         yqMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQRRP6QAjIKRIgfCZf8dpb/utNKLw8W561+BdPL4bQIZZ8nZ6MMUMIjfF09mwNxWi4zthlbz4=@vger.kernel.org
X-Gm-Message-State: AFuF++k4QJKuxsOMy6WuK8MEBjHdOO3tCvSic2Zc/sKi9axPTtThM4Ni
	SksO4IAre13fwODn1rqZ0y8r47/ixhxbmSdm00ozaqWyCPtb2mJlpMCv
X-Gm-Gg: AYBFou1ZO8V/0ho24D/237W+N0NnzHLuprA/oLzZgdWVLyQ9XxY2erY0RtB6I40ddAg
	hq8sfCAZbdzBZe9AXWHr0lOBX4k5qMR6G59WpF2MYmRj7rD6VfTT4eIAVn4p6Fp5VxXnGvSIZ7b
	rHJlrEUJpoVEAagEUdY4WFBotuEGlXUpm0DmMdQETkLrfYurakfPtitoO4Qb+Z/6FEiDbcQCtzA
	m+h8O/mL+YzPwWPZP/5qpwoVwods1FXCKLO72bWCd3duBHRPQGYugTp6UgkA5J2FIf/cUl+sFHQ
	v9iZY+szcuos6I4WYSCPUpKTK1rzHbdHtAISZsGnZ4oGO1gESK9gUlcFyfubD+rHiSMVOvNclZe
	N1v+UnHIbPOPP+bXSW/mRyvEFBu56IpT0YxKwtajJwkyJCO58vcz8oEOWoMpvuFAs3CwjYPD7WA
	LhYo7okYxG/lq4U0D4kBPRowSEnpH8JlMGPA0jzbgQOWfH1dSkf4UdFEerEUtCxvI=
X-Received: by 2002:a05:7022:b055:10b0:145:bd2a:525a with SMTP id a92af1059eb24-146cfbd49a5mr3248533c88.26.1790430502451;
        Sat, 26 Sep 2026 06:48:22 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144172de6sm23530135eec.9.2026.09.26.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:48:22 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"sashiko . dev" <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/2] debugfs: serialize concurrent writers in debugfs_write_file_str()
Date: Sat, 26 Sep 2026 10:48:13 -0300
Message-ID: <20260926134813.1063620-1-qwe.aldo@gmail.com>
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
index a4b7a5cb5e01..f8e2d3c9b712 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1060,38 +1060,42 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
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
