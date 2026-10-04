Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB905175A6B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093742; cv=none; b=e9OgBgMke4lYYPJZlCEbSBzfgi6GWEd7uMYusYohsN0Qaa31+kyKEqrZp4ZIJjkNOAZF5pissZ9GGURL7MMiSOnb+b5mkcBjPJXbPAJBOf3xgptGu6idCp0KeWBc5O5q9kMuvh/hkx7/My5DCJjTJTmP/Qrcf038zyW0ln1l61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093742; c=relaxed/simple;
	bh=MrZM1fuqy59R1SiQ//tw2gC/QW3wBRMI9xhn7nRK87s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj7HXGJokUm2/SWL145KBGjLaOfJwuieVN7BT5reh+LxnueNTdNYaJyR1ArtscFS3xhVAXeBmji6wug1WTYjlOpHAHnxv6/Hv6XCVAaIZKJolCzXGM+L3jo8gN1QOFToQIW3zWaL4zpZeVlaQqlMY887Me7DKoSTa05kAVifRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq8txJ/2; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq8txJ/2"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1059538eec.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791093740; x=1791698540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zw3spXruW5eAr/BaWFnAydpO0+AS612TDMLy0c5P4Rg=;
        b=Hq8txJ/29AGnohleRIX/g6+wcywCzjrNZlUIqVR2sZnQrdtBTO+YwgA2KyKFDPk7j9
         kkyVfO7CPdu8edwxhdixs3O+NN/VY8su9Bh3E7GTqQrwAC66HkI71bjwNAGUCAqfGE9x
         j+BI25sEK1ccGivZM2wSCYuOLUpxskHrJoyPpxYu0BAJmCQXHlKLXdw0c0Fhc0qp8H8w
         xTdQKit92YQ8EZGZ0C9TeafNxrZOwe4kw3b2XXirwytBdEJt2vpmapuVnZhyfoEDsfCH
         BVeakReLGN0TqjAtH4fBoZ3n/6ESstvOowqLo+7DFU/VdFch6341GDtRNXKZc6tVzxFV
         MLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791093740; x=1791698540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zw3spXruW5eAr/BaWFnAydpO0+AS612TDMLy0c5P4Rg=;
        b=L6eMsGXDbvFocW/MrtrubzpkyGDO+etu7ZyXiK0WYoJ/MUwlSgkIzpAadA+lHFVChn
         ypuTXy44rhtfx7drcziJdJIg+1Kh6QwiMtv7NZrIQFUfV3UMCQe/6SXa6FzBy0EmeUxp
         YI66b18cZBu/nQltIhPOhXRQpxNuUaPhegC7cZrpMHaVb+tb/pvGQ035Gpe6NaW2tBAs
         FHytNH4Th454ylODSLdp8/OD3JrG2RpJRTYOVgMxmpXMJTymopw0YrBk7pZZekODd8b6
         8TBHckQsZOEK9njcleQ48D93uaQZlGG21GPAg1zFdiXpHWcK0QB8X5z8MKHaISzw8VRm
         rwRg==
X-Forwarded-Encrypted: i=1; AKwUvBynEgtG40b7CXm0qnXHmtKhxsk0f/QOiDdOma4uaLZfsv9Su+mrrWN01XKpFW+CSvs3SMeigfw=@vger.kernel.org
X-Gm-Message-State: AFuF++lXK5AV/F0HUY3/afvhcCRZu7B6dl825ux6CggucIWd4e3IqDnq
	nbuBNIqb9gaX3+VQGsLSUNxnHTd6omwzKbKqUHuCFOmsbFsAr/lNMlpf
X-Gm-Gg: AYBFou3l0YPYbE3Ekcu0+M25GTPtTPfhFPXbLgi9mvhGmLJHxgVqriclyVFQqRZYbPM
	tOF+nMG1djFdWizu6KHjuoVtaKh6e48H3d81UBfqNcTRrYQ33nAL4yAAJ2iRAbkdWSY4uIEKF2Z
	3sYKBJ+qh4fznRxUFDlNq7tOStoiiNA6//zFU4piO6aC1EPCR6kCpyopLywbLdLPOu21zqpxfRP
	EwH7lr9HWPJcdbw/ghZDB/lldQaq9m5Wrrltzz0B8qVtTNdwFg593fnf2D+nUHQe5lts4dvkEcN
	Dm4p+tHdXKg7dDMGigQuou36dAXcUP/IM5KQxhlBTauYsYDpA+0kCzo54FM323rZe6izgOMhBKU
	YRmL27UQ47rZPfqyTAM3BxFyodFwshnUOSDs05aID+xrt7QGeHwYnAbL9MtuGfzo0wlcn/mXkrC
	L1k75pl2LRX7e+bwdoB3ugx1NkvnfjZlcD2k/u1a/mxYdJuV3om0+y2gsYCTKBLRAd3D1p66lgE
	UxNy8K7NkXseGCLgW1oMSc=
X-Received: by 2002:a05:7022:b88e:b0:14a:fe37:cdf0 with SMTP id a92af1059eb24-14f5d5b661bmr9362314c88.45.1791093739832;
        Sat, 03 Oct 2026 23:02:19 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35128156e6esm1952256eec.20.2026.10.03.23.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 23:02:19 -0700 (PDT)
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
	syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] md/raid5: set conf->mddev before the first setup_conf() error path
Date: Sun,  4 Oct 2026 11:32:03 +0530
Message-ID: <20261004060203.1379-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_conf() starts with log_exit(), which falls through to
raid5_has_ppl() when conf->log is NULL:

	static inline void log_exit(struct r5conf *conf)
	{
		if (conf->log)
			r5l_exit_log(conf);
		else if (raid5_has_ppl(conf))
			ppl_exit_log(conf);
	}

raid5_has_ppl() reads conf->mddev->flags. setup_conf() only assigns
conf->mddev after bioset_init(), but five of its error paths -- the
pending_data, alloc_thread_groups(), conf->disks, extra_page and
bioset_init() failures -- jump to "abort:" before that, and abort: calls
free_conf(). conf comes from kzalloc, so conf->mddev is still NULL and
free_conf() dereferences it:

	BUG: KASAN: null-ptr-deref in raid5_has_ppl drivers/md/raid5-log.h:54 [inline]
	BUG: KASAN: null-ptr-deref in log_exit drivers/md/raid5-log.h:128 [inline]
	BUG: KASAN: null-ptr-deref in free_conf+0x81/0x5d0 drivers/md/raid5.c:7549
	Read of size 8 at addr 0000000000000028 by task syz.3.20/5681
	Call Trace:
	 <TASK>
	 free_conf+0x81/0x5d0 drivers/md/raid5.c:7549
	 setup_conf+0x1720/0x2ad0 drivers/md/raid5.c:7885
	 raid5_run+0x8cc/0x2560 drivers/md/raid5.c:8129
	 md_run+0xc3d/0x1cd0 drivers/md/md.c:6779
	 do_md_run+0x35/0x720 drivers/md/md.c:6880
	 array_state_store+0x958/0xe90 drivers/md/md.c:-1
	 </TASK>

The faulting address is offsetof(struct mddev, flags).

conf->mddev is a back pointer that is constant for the lifetime of the
conf and does not depend on anything computed in between, so assign it
as soon as the conf is allocated. Nothing between the allocation and the
old assignment reads conf->mddev -- alloc_thread_groups() takes the conf
but never looks at its mddev, and the rdev_for_each() loop walks the
mddev argument directly.

All five paths are allocation failures, so this needs memory pressure or
fault injection to hit, which is how syzbot found it.

Reported-by: syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=270624bb31d478afe62e
Fixes: ff875738edd4 ("raid5: separate header for log functions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 drivers/md/raid5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b91545ce090d..f98d3bdd3484 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7675,6 +7675,9 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	if (conf == NULL)
 		goto abort;
 
+	/* free_conf() dereferences this, so set it before the first goto */
+	conf->mddev = mddev;
+
 #if PAGE_SIZE != DEFAULT_STRIPE_SIZE
 	conf->stripe_size = DEFAULT_STRIPE_SIZE;
 	conf->stripe_shift = ilog2(DEFAULT_STRIPE_SIZE) - 9;
@@ -7743,7 +7746,6 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	ret = bioset_init(&conf->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		goto abort;
-	conf->mddev = mddev;
 
 	ret = -ENOMEM;
 	conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL);
-- 
2.55.0.windows.5

