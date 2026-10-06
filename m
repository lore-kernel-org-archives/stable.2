Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE23A7848
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289764; cv=none; b=uqkdE+iyqpAKIQVNbj+5w4hwfBSduRA/e2s77Jv/KYR1MSzePvsrgoIhcaHMx7/MW7gjCer9mZvTAhzYX3h6LlycUHQqOzqrBvh9jsf3dky7EL9h07pYgAjy2oqcPB04crX+5ViJvXHBvUiSG+qVKqGM0wyvHA7mdWVjdHXxDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289764; c=relaxed/simple;
	bh=lthPC1Aid3RzMwkXHABVJupMtn6Oz9nfXWocpfXLG6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPE14NmqfQlEvjgqTfzLZ72Yzoc0ijPrdQ0OEzw4HX5ZzQYSXyvHO71xeozNno+zSr7/VH8ZNHAMHTgCSodd58HAeAu86youSbtynImayo3QLlRZAEa6xv/Csg6jD9RkFKCBNr/F3+Zg+W2b+EjKdRlGgs8qqsTlIZDdpIcR33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLmfm469; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLmfm469"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88bda150550so362868b3a.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791289763; x=1791894563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBXDjxHdeZnn0EE9oAZG0kH7xmYbT9bOqu8043JSOZo=;
        b=dLmfm469wfkY2FSQWsUOZQhiEeKazJlefm23rKBSNdpucKHj+mL8yieV/v1s8tbFOX
         O0baBUY1QjIEi9LhWYZY7YWjty4rBjuxL+buE30zmdcUf8R9hB1QH4lTWkQeomnRPmMD
         Vjz6Ax0Nd8j7OE7Z4l60nYKXC1sxG5crZ8pyuQsgtV8XlBgFMnGlC+5nMORgfkXzbo7h
         vNEHw3sizjmxQ2BWc09viMSKxVRfLEUNpH7e0Hqky5BVn90E9K0UV9EbppgPyffDfmpT
         vLfFS4gQA7ZuDW1fXkjr/zGLzfbSHk454IljA2lUcwHaSDjFJJcBDwwzgVx9sEI1uRJb
         mJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791289763; x=1791894563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBXDjxHdeZnn0EE9oAZG0kH7xmYbT9bOqu8043JSOZo=;
        b=N1hBVxp8AzWeReEH/2ax30HEVU2rziW/YscxZFnQOPoo48/4PxwOPIC5f0BdGvkZzA
         ZPxK0+dPZbFAhex1gPyvVlWPmuKyoRHi26P0aS6llLC/MvmCa5KG2Y8KX6Da/XJUQNi8
         6XQNkn8spy3Tx6YYet894zDq4/9gwfqRVe/XtZt8dBUbwDGBjoxhfScmCu0wBwjBTsjK
         599xNLk732IGjvXPVLusCj5U+jz3GWPTA9aP8GXv3i3/oIvjBx8fR+4Q1yXrTQoHYOCZ
         gT7+MaBEXJEKxav+/yhYFx/I8b3JA6gjT4m+L3YwZkMSMa27qU+SAPk/IvoB5bd3fVKR
         VCKA==
X-Forwarded-Encrypted: i=1; AKwUvBxrfyq5QJDO9CNjlIYjxEVpCXUJKmrAFiUcJOQqgX/D+JXOaDS/IuYMCPEFM2OBwQU8Jf7qDu4=@vger.kernel.org
X-Gm-Message-State: AFuF++nm3CFg9pi97V6SHc7kw7Q5T/JeXSSnyLzCXM8fI1ik7qVE9jCm
	jd7EVquUeD8usIslJOQkLNTagNmzN/DfL26Oxdfgs7qfsvhzHDdYwQ7c795eQRko5Ys=
X-Gm-Gg: AYBFou3KDHg5yTPTCw+B8PKW6COdfARVaWKzz53nHcFPkDH0/Y8BNQ4mn4dMXaqxj+M
	C8JFt2VbBLdhzQD0DCpgGlxCiwn9QZ6efyuFrpagw72qSwr0B74zIo2H/1LL26BseiZdLVROzQE
	kPTxj1R83AOa0IlKw1zSNiqB/6W+9ZEdZZOTn0V2eT6gpiulhK49p1Z05pzjdJ5ggNtJj05nIe3
	4YEXSx7Eq2EYFju5jusQ6RRctRlINtGBaNRLsFwGwmOro8tjBUGU+8Dbw4yqd3MxMgBdmtkvnjv
	0qNln7VqO4tkWrNIRJBnPdrtoze6jIsHeuHwjKSj6DttN05P2pHH4WY7s/7a7CDedzrrs4whQfg
	hbnCjspt9ZaS0AHF3DGRTTHxJkm2Pl4jEO4Bu+fLabL9AwWwPPl9ipvX8B40IptIkCD6ngvUFW1
	vOXFOKSzpbGG5WN8xx/t9ENZWxCESvyfKDXCclKncmr8IYl2ehnmPR6IOokr+HCLxhKkTZ/OL34
	s5TdZEluHtmohPO
X-Received: by 2002:a05:6a00:1792:b0:869:9298:ba59 with SMTP id d2e1a72fcca58-890d8a4ec77mr1125260b3a.0.1791289762603;
        Tue, 06 Oct 2026 05:29:22 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([2401:4900:6310:b8da:d139:f8fd:7043:7eb2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c88a815sm4679332b3a.42.2026.10.06.05.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:29:21 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] md: don't hand out the array before md_alloc() has added mddev->kobj
Date: Tue,  6 Oct 2026 17:59:04 +0530
Message-ID: <20261006122904.1538-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261004055712.1293-1-yogeshgaur.83@gmail.com/>
References: <20261004055712.1293-1-yogeshgaur.83@gmail.com/>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_alloc() publishes the gendisk before it is done setting the mddev up:

	disk->private_data = mddev;
	...
	error = add_disk(disk);
	if (error)
		goto out_put_disk;

	kobject_init(&mddev->kobj, &md_ktype);
	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");

add_disk() makes /dev/mdN openable.  mddev comes from mddev_alloc() and
is zeroed, so anything that gets in between add_disk() and kobject_add()
sees an mddev->kobj that has never been through kobject_init() - no
ktype, no kref, state_initialized clear.

syzbot opens the array in that window and issues ADD_NEW_DISK:

  kobject: '(null)' (ffff8880120640f0): is not initialized, yet kobject_get() is being called.
  WARNING: lib/kobject.c:642 at kobject_add_internal+0xea/0xcd0 lib/kobject.c:225
   kobject_add_varg lib/kobject.c:374 [inline]
   kobject_add+0x163/0x240 lib/kobject.c:426
   bind_rdev_to_array+0x80c/0xdd0 drivers/md/md.c:2621
   md_add_new_disk+0xe3b/0x1850 drivers/md/md.c:7684
   md_ioctl+0x200a/0x2610 drivers/md/md.c:8499

bind_rdev_to_array() is not the only way in.  md_run() calls
sysfs_create_group(&mddev->kobj, &md_redundancy_group), and
internal_create_group() has its own WARN_ON(!kobj->sd), so RUN_ARRAY in
the same window warns too.

Every ioctl that can reach mddev->kobj runs under reconfig_mutex, so
hold it across add_disk() and kobject_add().  An ioctl issued in the
window now waits for md_alloc() to finish instead of seeing a
half-built mddev, and opening the array still succeeds.  The ioctls
md_ioctl() serves without the mutex only read array state and return
-ENODEV on an array with no disks.

Hoisting kobject_init() above add_disk() is not an option: commit
ca39f7502425 ("md: fix mddev->kobj lifetime") moved it below add_disk()
so that md_alloc()'s error paths, which free the mddev directly, never
see an initialised kobject.

Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com
Suggested-by: Yu Kuai <yukuai@fygo.io>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
v2: Hold reconfig_mutex across add_disk() and kobject_add() instead of
    refusing the open in md_open(), per Yu Kuai's review: v1 made an
    open that raced with md_alloc() fail.
v1: https://lore.kernel.org/all/20261004055712.1293-1-yogeshgaur.83@gmail.com/

Built with W=1 only, fix has not been runtime-tested.

 drivers/md/md.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 67108c397c5a..85439f27d943 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5906,12 +5906,22 @@ struct mddev *md_alloc(dev_t dev, char *name)
 
 	disk->events |= DISK_EVENT_MEDIA_CHANGE;
 	mddev->gendisk = disk;
+
+	/*
+	 * add_disk() makes the array openable before mddev->kobj exists.
+	 * Hold reconfig_mutex until kobject_add() is done so that ioctls
+	 * issued in between wait instead of using an uninitialised kobj.
+	 */
+	mddev_lock_nointr(mddev);
 	error = add_disk(disk);
-	if (error)
+	if (error) {
+		mddev_unlock(mddev);
 		goto out_put_disk;
+	}
 
 	kobject_init(&mddev->kobj, &md_ktype);
 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
+	mddev_unlock(mddev);
 	if (error) {
 		/*
 		 * The disk is already live at this point.  Clear the hold flag
-- 
2.55.0.windows.5

