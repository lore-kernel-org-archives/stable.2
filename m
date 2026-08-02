Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A293B960F
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684181; cv=none; b=H6QQ2UzSMvxnyyaBBfE2T/wQY9goHPHDwjGz8Flnqy6GSEmbTf2xy89O/WZrxFMyqVmBF+yjtXYC8d5ERDaa6wgjH3rRAB7ALitIVG8psPPiHyxHDnVYRqiOUsrG7JLpwhZubUYk2piM7o6tYf9+TTCGNuXkmjYDHcM98ojbaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684181; c=relaxed/simple;
	bh=yEy2DCNdJA/I7Pl94OowDCOEAR1CJ0sdHmR8slgOib0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KGcJvIt/I8SkxkLaNGG0UFUvJPtYG8CMDYvDk4mscIgRDpZKYdZ0wIPBQ7pvTHAQiEdCtaaMzwtkp42o5BpCKzeiBkZVSZQU2U0Qz1gfJrS89bAa+YL6pJ+0vtP5gI2c/WZjm0aHBacpgx0QpdNs387DQkvUJyd3ekoExRw2L80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsNajbIt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsNajbIt"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso2744564b3a.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684180; x=1786288980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hd5PlWgRxgIJLaDM2acSHPFR2qhyClwTJqROSBY7RIs=;
        b=dsNajbItFT+eJSKTraYmSELD7V8k0zR3yLeYVkWclX4K1HlN9kEqIHBnyR3pzKwaqz
         d1izWy2FuHE/+KItT8IVK3CnchbpNXsbBtg9pwekiNAePACMrvGEkGemioh7UElzmm8v
         0dlMJDYIX8dWJbOF3untvIJ8n06wT5b/oHf3BNd3EYgckYZqFdClytkVPJTvWW8bcOGb
         zsbF0fXwXqyk4cEAiniL4zO1cumH6sc/xv2FR29vy5L3jYrFU8400WO8UvLP+jgjRelJ
         ZC8gCMBo41yk4kW+JNLIGQgPKTYTh9orMiV0bEpF0w8hpG64SVTU6CopTCqH9hLRZejs
         BMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684180; x=1786288980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hd5PlWgRxgIJLaDM2acSHPFR2qhyClwTJqROSBY7RIs=;
        b=fmZKVTio11j6UYKKTGC3RnbjMHKRg7/WUAvbvXNqRzX1g+IDf7vR3AXkVPQGIyZ0fg
         ab4ug5o4HfHBJf/Y41nZFqrlhc+X0w+O12qaPsqmtuC4mLm9lL1xJLNl6vvzWWkCG/NY
         e26ye9SqNOe9whE3A3UM8cfiIjXMrzlcmAQv8rXhKUsrDxTOFRvHD/Yk39Av7U+/JBMX
         RUTIyNAYs4P5N1kCpAPF+LJSgpZsG57kLGn3/Y9Ki6OxR2csRnafezllaHR2Wv9gmgvQ
         H/UfOz0cC3Nvq2bAP75GMkXKBvzU7Tls3/Xa0RwcV2lUvschBdrWPhirJkPK5I/IlrKi
         ulxw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5aB30J/nYWqQ1MiYLLf7BMlp3AKl5a2JcYzqyIjPYpR8QQpopsFpj7bGUw3p4Fcd+MFDPbJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVnhI6cUvLQqR1Mqa1X0DMtMpjIj1nqHMFiDxDKWNvTyCphNN
	TcHHCdYJcZihTE1oFNyrJ/RRKHMVZCC4F1ZSA/kweJTvF8AA0OEKXOWaGYLM9O9wqpg=
X-Gm-Gg: AR+sD11sL9nsThk1WK89k+H2CbYslFuM5aKbCGxB16LGCkNFm2ZOW8dxvdWVdJIrRIj
	rPFXLAtoFjAz7Nsf0bP3JaH/bDuZrMKIh12X47kL2Zm0qyUxeMNptWbfcX01j1PRXLqwQeijsc9
	hl5HVbR6ohbALDeaDkTW7/B+Ydia7ESjhsivUvDJ/2JcXO+zi11DvCOcfZof79xv7ek6QqIwLgA
	FAjshAahnY7nx+95QyqQ6OttV1Qt0JkMpIsfnZlsuZEKjS0YAhqr1CRtUasMIQgm2poTNy7Nj9t
	Nkzhvm9La0NIccJFQyHOcQdYYUd53Mdoyo9goYnMP9qs/AXCgPju7vy3AavWtXuRZp+IozXSDJg
	lhOfxwPEUgu87/C8GFzxs4/cF5lYo31/Zi5SISVMA/IkO/B/hRcVOQCbn2fNarXMQokf0cbY/re
	mZudh9h3mWlv+9q3ApNMzQWRmXbkIKzxe628+SGppPkE1xH4RpMMlYmcFZT4T6sjWoSeRAjnPdh
	u1UAAWe7/GnkLGn1rCVJCabamcGmBj/1pVgyWw6DeP8wg==
X-Received: by 2002:a05:6a00:2d25:b0:848:469b:3d19 with SMTP id d2e1a72fcca58-84ee4881d3emr6073405b3a.29.1785684179816;
        Sun, 02 Aug 2026 08:22:59 -0700 (PDT)
Received: from chcpu15.cse.ust.hk (191host116.mobilenet.cse.ust.hk. [143.89.191.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7a243sm2573001b3a.24.2026.08.02.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:22:58 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <mgr@kernel.org>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH] net/9p/usbg: clear stale request context after abort
Date: Sun,  2 Aug 2026 23:21:48 +0800
Message-Id: <20260802152148.810390-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

usb9pfs_clear_tx() serializes access to the active TX request with
usb9pfs->lock, but leaves in_req->context pointing at the request after
p9_client_cb() drops the transport reference.  A later teardown path can
therefore retrieve the same request after it has been freed:

  CPU 0 (p9_usbg_close)        CPU 1 (usb9pfs_disable)
  lock(usb9pfs->lock)
  req = in_req->context
  p9_client_cb(client, req)
    p9_req_put(client, req)
  unlock(usb9pfs->lock)
  request reaches zero refs
    kmem_cache_free(req)
                                lock(usb9pfs->lock)
                                req = in_req->context
                                read req->t_err

The lock orders the two callbacks, but cannot protect a pointer that
remains published after its reference has been released.  KASAN reported:

  BUG: KASAN: slab-use-after-free in usb9pfs_clear_tx+0x166/0x1b0
  Read of size 4 at addr ffff88810e7420f4 by task poc/94
  Call Trace:
   usb9pfs_clear_tx+0x166/0x1b0
   usb9pfs_disable+0x1d/0x30
   reset_config+0x9d/0x200
   __composite_disconnect+0xa7/0x140
  Allocated by task 93:
   kmem_cache_alloc_noprof+0x141/0x370
   p9_tag_alloc+0x8f/0x5b0
   p9_client_prepare_req+0xff/0x350
   p9_client_rpc+0x1a5/0xac0
  Freed by task 0:
   slab_free_after_rcu_debug+0xa6/0x1e0
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   kmem_cache_free+0x1db/0x3d0
   p9_req_put+0x164/0x1f0
   usb9pfs_clear_tx+0x120/0x1b0
   p9_usbg_close+0x7e/0x150

Clear in_req->context after the callback while still holding the lock.
This matches the consume-and-clear pattern in usb9pfs_tx_complete(), so
subsequent teardown calls return without touching the released request.
The existing callback and error ordering remain unchanged.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
 net/9p/trans_usbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..9a83dff6f3dd 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -439,6 +439,7 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 		req->t_err = -ECONNRESET;
 
 	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	usb9pfs->in_req->context = NULL;
 }
 
 static void p9_usbg_close(struct p9_client *client)
-- 
2.43.0

