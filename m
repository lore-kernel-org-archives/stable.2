Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAE3E49C6
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404081; cv=none; b=YFoWDKR3AKYcZNLdiJPIDCdImy3qheq81PfEtJoDozmvL+SzW5QzN5YM2yUyuOn5dKSAfhqGlb+StG9AUD4ODrwJJV1Dnm2qtEj+YXUJK4qtOw9W3pZJvKB3Jf8Qgc/vG+MVOZekc8E80R4rmmljRDojCyId24XhhyfZxo3dpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404081; c=relaxed/simple;
	bh=7eaxt08mtN6zo0xFSjRxwPoRb3odH0Rzb02ZpzqbEIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mj4RBNCzAlnAeCQsvFySdZrT1khoJ+GQVsoWpWy64WX3LqlMj8u+Bs6rq+4kcpOOOvH7Es7jc7bPxdqVWnoc9zcGbno5QqKdciRn777Xi1ZsIF0yRV9Rz7XJfl/GJHcLQVidHJgYkzaKbvrZMrgGi4uQEkGSodHL/uc9li7kyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJ+R0pX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJ+R0pX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f97d310caso1820052f8f.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404078; x=1786008878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tu9mUrT2j9QVQ/0jr7AGyW7PZp640JOYo5v2vN8k1Cc=;
        b=IdJ+R0pXxYY0Lt6BoY3EQqiGTBwGJLniFtRsUI9SZC8zNu9ougUk3y502bIhh42l4q
         5RPQg2nmjkAxlcbZGQeIvBAHgEbys5U+Twa9F0Q7twSIC2STAT6ztwkGGMzIPvHov4c7
         RejSNUCQtjt5icdrsLS68R+0WJ4ZKUfCwg+ROHn+bXQMELgfVBW6iUniam64tlYsn+W0
         YFimoc+znqwMum3si53Wuqbp0UvzKK4DRKIaEqlDBVwlHz6gJ5uJQXuHn0CVJ/w3jXfK
         NmP5iCRa7ocAMKc0OVvHqlKV8YFX/O9P5oNWJXe+Rf39KnE3aPu6/2B8yWNv7J3QUf3W
         TenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404078; x=1786008878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tu9mUrT2j9QVQ/0jr7AGyW7PZp640JOYo5v2vN8k1Cc=;
        b=sO1+BkNL1AIhtbD+DNtXrx0WSCT7rYKDVYjYJwQlVBWnSzY76LWkw4NBIgtsqa2mSE
         JZGAJSn2WtpXIgTSs+76hXYM21klC9gW/8iTSSlZ25rlHPPRoaMHgUIwRj8O7+MMM8ML
         DQNGJ2E8lrz26ytCAhJ1JoGOZiaLPotZ4nr3rlJhOvFK1G0Bp7fmpv8sKXQFUrRt/gwA
         PUC24bheLkncn440ASs8IaFYYuOUA8hgavzKn0wjlW2ohTZ29qF9ZnyoFtLTTQwhF4yU
         TZwnJbR2ecTQF8y2/WAZ7cjZuwbhB5uiIQ6y6Ifk8c812/x5h1lij217O6THFsUzljsB
         Kd2w==
X-Forwarded-Encrypted: i=1; AHgh+RrphlH8UGmonfExO+jm57/NLzycqmcohtGr5ZBNxf7LujqgSesHY6nSNeVZ6aOut5K/jJRfLCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySI6cTEhHY0VN4S+xQIGW5gtjFFQSMKfkoFmLFtMr7PZcW6ZMk
	budbTE+zqsZrSmXb1f3hDUYxV6kgiZVLjxQgjWCXC9FsakkNA3Qk5GhK
X-Gm-Gg: AR+sD120gKkwDHyCRdPVldPhn4s/EIgKpKU9ty5C1/8xJRLkry9i/mY2C7CGRAW4lEl
	hyzKRM2fIP7N3CP/flPp99so+wAM2LY5mBdSjVMIqpJYE6JNHwb/J0CcL7I9CdK7LNFU7y6EAVD
	Wr/BYzMd5TUtnMqFXEDXuncO7AE+8fVDyafkNPh3UMYbPQ953Ouoef+/ofjGrIH6u3VF4YmzY39
	eLDIvet219/pXWpgw3ACyZGP3e+QUrJXtEdSEAtjg9b5KRj5A6/a0xaM2zw/7mW/UTDDm/rtOlk
	qXlMQdehX+RC0yuRox97Gm4UWZG5M4KTZ7bQKV/yaq7xyPt8dalC8g2+rHh8zo+R/KUrM5SeIv6
	OW7EFIFcS82P54a03gmscsemPHYBLt73IvPxAc3G1DvEbOymw/vv2dC4RDsp8L8RBNjaNkV2Izn
	7E8G6TQePMsrXr0AyDrnxAAL8EGh/tetYGLZ1RXlsKlks8tQ2kSaVD7OD2g6+zff8l1o44i/IrT
	viEKwchvXQULgL4+ltLFai7XIt6asSNayUpBjaOHSQlEo9pvTUdfIQRTvew6h692sXmvg==
X-Received: by 2002:a05:6000:400e:b0:47f:6f92:84aa with SMTP id ffacd0b85a97d-47fc82149c1mr2185466f8f.53.1785404078438;
        Thu, 30 Jul 2026 02:34:38 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-95.nc.de. [195.14.216.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d985csm4897793f8f.1.2026.07.30.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:34:37 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: [PATCH 0/2] configfs: fix use-after-free of symlink target racing with rmdir
Date: Thu, 30 Jul 2026 11:30:23 +0200
Message-ID: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller reported a slab-use-after-free in config_item_get() when
symlink(2) races with rmdir(2) of the symlink target:

  BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
   configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
   get_target fs/configfs/symlink.c:128 [inline]
   configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185

configfs_symlink() resolves the target with no locks, with the idea
that a hashed dentry means a live config_item. configfs_rmdir() drops
the last reference to the item before the dentry gets unhashed by
d_delete() in vfs_rmdir(), so get_target() could take a reference on
an already freed item.

Patch 2 fixes this by unhashing the dentry in configfs_remove_dir(),
before the item can be freed.  Patch 1 fixes a second lifetime bug in
the same path that the earlier unhashing makes easy to hit: an item
reference does not pin the item's dentry, so create_link() must not
reach the target's configfs_dirent through ->ci_dentry.  The patches
must be applied in this order.

Tested with the syzkaller reproducer, which no longer triggers either
the KASAN report or the s_count warning.

Vasileios Almpanis (2):
  configfs: pin the symlink target's dirent instead of chasing
    ->ci_dentry
  configfs: unhash the dentry before dropping the item in rmdir

 fs/configfs/dir.c     |  9 +++++++++
 fs/configfs/symlink.c | 24 ++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.47.3

