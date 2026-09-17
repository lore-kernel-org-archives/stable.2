Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8C4E3233
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658330; cv=none; b=dWBt9XOgrs9sk2K4QzGgRu1ohvyvrAd172PidsNhDhpPt2OA8rxzDcPlCrdC2r5MohLUNdgUTggWH+O4e/S7WgJfWdb8/mtNfsDdF44MAVr8pgugijJ5QT17lg+1rh47AQT33t8bzG5N4hyCpjX+gn8S+Z+lMyNTTix/MPTLe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658330; c=relaxed/simple;
	bh=ei97T4Navrh7XZYuh9kk6IMlxOtE/I5ajJ7jAqFv5B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9YL7bq+OOLMuki7bLaLSKRAB+FopY+5VBMTv2NaGe27ittK/LfzYSOn54mTWEDvAQDaCyZHAULQqxGSfJm/aLd+h3E6zCbGtnx3PYPRnvSl1LTGK0RFSsanjTKfSUEjY398kFdwnkVOZfpsLuxs7w3rzWwJeEE8Y1A19tjyVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEMx/Zer; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEMx/Zer"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso407825a12.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789658320; x=1790263120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=an16D1BLDmpgdn+H3vzSxv0+HLMXqJ/V96lgL35ts2o=;
        b=HEMx/ZerTPHLwefRMu7XN+F97Wr3CHoygco/2SJvT892+UpFyaHSmd/9EdLOQz3HIk
         eSdpBrMcuGisjBk0XftBS7NfREdc0d8RjFNrcu8cOY3A06RsvYDVRPRSOpDvlFp8+/Bb
         PbsOl6HH9TUKs0lL+ydnaQazegZdsR9mR2j0j2HkY3ghvHnts/N/vLpQ+WxtrpQfIM3q
         jwN7XMWPARuMyKoZcF/p80c/j/KXgnmtao0+meUpukOJGJXeCmwVMNrSM/uXgUabxl8J
         NjoBHk4V4g9xYHgILphtyBKpoE5YoiW+cQlJa41E9OCrRJL4qiRVZNESVnk5+8R4eLIh
         ki8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658320; x=1790263120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=an16D1BLDmpgdn+H3vzSxv0+HLMXqJ/V96lgL35ts2o=;
        b=TJ0RCnRBfcyHNCXFdHVmCYG6+QclHj7Zy+EaLsU0SeEThq9yR/I3U0Ea7f3MyS1yEk
         d2Bl2P8+O/xs/ZkDRq1FV5/DyGLbz9ffNp81nig+8mxLPjMo2vJX/LEGKx3h9TA+Ooa0
         IIhCkitJjbGLS0zcknVmixHbCO48yPd5zue2/KVtEcG3bW+neES+jxpujBrYPNDBXdGf
         Wo6TGW7YOG173PCRVg6Ya8VjsNhK2RyoskW3kYqqQNsa4WvKgbSAW6RxC8e6L3WoFqhw
         iUKybhNOoAo1VejlC7f/Fn0u41HeTDqGAiexsWC/OjXQl5eoK7KUXrpwojQNiB1RB/hz
         dQ+A==
X-Forwarded-Encrypted: i=1; AKwUvBz2zeR2hNCUSWyyepLH9rJojmTUilrCpIyU2PDZTzqF8/ytJwMK5SGGudQxDQgKkut82h+Lhzg=@vger.kernel.org
X-Gm-Message-State: AFuF++n9fG+Rek7FnL9hRJbyKcTViPvMj/+CClv8oxHmC4Mspl5Y/HAW
	VK3CQYUuxCNhPPsGWorFgMIHOZc4VElYl2hteNKBzKLcd/MwNqWyK+zm
X-Gm-Gg: AYBFou25ow/DIR7N9zMfummqnzoLSXndpZkKUv/uZARji6VX6JLWTLGfUWxuG/acBIE
	/twNfR77ZUI1Fgx1Hv5SnB25QHVn7kKA6lPrVC/cwcayEBBcAqac0G8VrDrEKEk7KIS6lB1MYeF
	jhQlMszBWcf5zaA1hF8mnUtmckMrSxo43ghsSEVEUxh/LzH8PZ6k3gGl8qMdbu2/RBx7Y1FpFWE
	A2O/dHPtp1Sj/Rlsrr/yKzHAPbFtImehmLM+qjaDn35HfCiSHTaL0RTr65dKeT/KmMd/pFzzlYe
	fUKtjvtJy1937DJTi/T6AdjMafQfC+nJW//DAts75gmG5hxt4JW3DSxNkflAfROFS1dkYDoFeiL
	/xYo7w3WRHtL7tgA7Js4KEd1JlqY1MvNeRJ8K7/DGFY75PE9TbFNPqRWQiSxeVZj7y/XyyNdOn5
	PySb0niZk83D4orTAvnQXCYRt9M/6mlbivCVE44czxuz2KEOO4xo3UWaD5IySL4YrSbZdbcrEyL
	A==
X-Received: by 2002:a17:90b:5848:b0:39e:3558:f91c with SMTP id 98e67ed59e1d1-39e3558fa60mr9348150a91.24.1789658319683;
        Thu, 17 Sep 2026 08:18:39 -0700 (PDT)
Received: from archlinux ([2402:e280:411b:ec:aa93:b1ec:5a6b:5fce])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3909d02asm1525287a91.0.2026.09.17.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:18:38 -0700 (PDT)
From: Adarsh Das <adarshdas950@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	stable@vger.kernel.org,
	syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com
Subject: Re: [PATCH] kobject: fix uevent socket use-after-free on net namespace delete
Date: Thu, 17 Sep 2026 20:48:30 +0530
Message-ID: <20260917151830.89024-1-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026091756-widen-doozy-399c@gregkh>
References: <2026091756-widen-doozy-399c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry, I wasn't aware of the Assisted-by tag before. Should I send a
V2 with it?

For testing I ran syzbot's C repro with -smp 4 on master, with
multiple parallel instances of the repro. I was able to reproduce
the bug:

  BUG: KASAN: slab-use-after-free in kobject_uevent_env+
  Read of size 8 at addr ffff88800fa7f090 by task kworker/u16:5
  CPU: 3
  Workqueue: ib-unreg-wq ib_unregister_work
  Call Trace:
    kasan_report
    kobject_uevent_env+0xc71/0xd90
    device_del+0x7c7/0xcf0
    disable_device+0x1d2/0x260
    __ib_unregister_device+0x26b/0x400
    ib_unregister_work+0x19/0x30
    worker_thread
    kthread
  Allocated by task 498:
    uevent_net_init+0xe5/0x340
    setup_net
    copy_net_ns
    unshare_nsproxy_namespaces
    ksys_unshare
  Freed by task 63:
    kfree
    ops_undo_list
    cleanup_net
    worker_thread
  The buggy address belongs to the cache kmalloc-32 of size 32

With this patch applied, I ran the same repro repeatedly (including
parallel runs) and did not see the KASAN error anymore.
