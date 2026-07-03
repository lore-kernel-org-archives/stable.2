Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989223B8124
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075898; cv=none; b=F7KUQB/fYOXvAVh6xQkpzFFnSaRXrTJqY5LOIQ9b67/YsjSrUTCAr29rt+5k/PsbqeNuu5CRWFJ+oaElcc8O7rlu0SrhobMlviQRVPwwv+NfvaQyLmESKAf39HpsOOcdWmXXBA++WZe/VbVgJMavTzCC0tJvJzd6smO8DeqsJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075898; c=relaxed/simple;
	bh=R+43hLrsbYtEmXKZRIczZev7SexoajOmJrYYrv4Eho0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqw1U640+pzuxx/+/CJ0Sd/96qzLKTLejmbVQJCcTM3k+K6PzO4QyW1al/0/pSRCFwjWCKnwTLH9aMU7pSWnvj/79MQCJKndlHy88hNs54XVsC97QneXNfYmv1agS7hzL2Bl3seXXcy+wopvCnXTLv3q7YhTP6QckSDUvwaZqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEUdDEnI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEUdDEnI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c8017e981fso4284305ad.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783075896; x=1783680696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NILBCMIew3AReLpwbZCMTaqfSDHcfQHMLWRpawpzhng=;
        b=XEUdDEnIFyQVxIAd9gRc5OnkWbqN5zAB8uPTVe9k1ONP/eJQQ9j4dXz5Btzra9LWj9
         qCLK4i28fAQfSIv0HbGg85FKAMA+GplrXxvZ9xlJVElkUGKm+xIL4JhfyHOHRYTDMdq0
         2tOjW/FK4VGhJg5brU7LW1HXwyEoA78Nhhs8MBJl616eAyUs7XjxDp4Xw+kqhrX6bTMB
         1iAiW857UMe7GEenfgL8E+KV3blIM1YWF16aKxAtezbLIg8MmSdbquGlDmcgc0o7Ey1+
         t3pXhjEM7TR7OfPjBN5Zvnc0Xtj+SPMXjRTVZPz+DOFrl3EBS6cu5nASzlktonJ01PZg
         c7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783075896; x=1783680696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NILBCMIew3AReLpwbZCMTaqfSDHcfQHMLWRpawpzhng=;
        b=IXlXFQvLz+EDE7ZUffLckuBDwpPWcbRaNIVh1xhns/7ogV7xn+hYMbJat8Ue18TYSs
         bLBxdKpfolhmaEb6pKGv1ludNtaCl7Jx5D//bZFdWespb9flmOnbLZjyzXsnu5F+ctOy
         WwC9yQmXn8fNsNAf6n0jam1lWR9BFm7iU6Ny2ABQ56apEpkYDjcverFbMttlH/0uh/rc
         tVMPeYXH+JndEcXVov6wxjP91iLGCyd4VuwWPhz6esoc6xXLazoyCURAyCLLYQtCqdoQ
         NomY5HhVFGMq20cHRtlpjhksYbiPGSRUKZ05wNMF1tiVOa2I0zR32kJ2ea1Y7mSqY+Mo
         KTnA==
X-Gm-Message-State: AOJu0YxAkhhqutkBzejGGZ4q1W2Ui1KjmRdoHcX3d8CetvGUT0b7gXrZ
	Pd3Yh/Gkmky0yJi5l+Bh9C/4II3ZEwO8S6EKAjd/IhaQwKnwjtFMCOOO6x219bmP
X-Gm-Gg: AfdE7cl7LSXpHrmsYlYjgudsgNA3rY4TsZ4CgGVGaH5LcZiqW+2wUqmcQ/WQX4RgDEe
	y9jUJyfrVXWZq9O6X9xYUJpWCGwQYHkxC6kMi9HLL0CoVDj+TCmxUbmIxV5J50FxSUF4k+jw6yZ
	a7bYrilcqsPYaTu/LanWxwYCTaRgGTpAxq3nk1r4dEVuBtsSQOPw1xgJ71ZVJd2Vrh+Rcc+UUmb
	Ym3QtSBwKrnACHeoW4NLWN1XaCPXH76AoCQYtkg/xIckRQqLZYxa3Wmx269uV2Ci2jqbLAttxK0
	ZCQ6BShqV2jaZOtdQnqSybBD2BdfHV2bQxvF2HLylRqswWjftlxsJe2dVBcR7lSI1mQ+DGBallS
	y3//D/gJyhQTXS0y5vdqBFC5CQ69jvNupFe110kLQq5m3Yf1/yA3aV7xyidHI4Mht/Diss4ZXhA
	eQ1sbVV+HWWUsznWVL91ZW5COjZaBYXL+x
X-Received: by 2002:a17:903:22d0:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2ca9112c9ddmr90768265ad.3.1783075895637;
        Fri, 03 Jul 2026 03:51:35 -0700 (PDT)
Received: from annie-ProLiant-DL380-Gen11.. ([183.107.7.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765810sm7594245ad.53.2026.07.03.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:51:35 -0700 (PDT)
From: Hyokyung Kim <pulpannie@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH 6.6.y] virtio_net: clamp rss_indir_table_size to VIRTIO_NET_RSS_MAX_TABLE_LEN
Date: Fri,  3 Jul 2026 19:50:59 +0900
Message-ID: <20260703105059.3821189-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <stable-reply-item007-virtio-rss-20260630181642@kernel.org>
References: <stable-reply-item007-virtio-rss-20260630181642@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

virtnet_probe() reads rss_max_indirection_table_length from the device
config space into vi->rss_indir_table_size and later uses it as the
number of entries to write into the fixed-size 128-entry indirection
table in struct virtio_net_ctrl_rss (in virtnet_init_default_rss(), and
again in virtnet_set_rxfh()/virtnet_get_rxfh()), without validating it
against VIRTIO_NET_RSS_MAX_TABLE_LEN. A malicious or buggy device can
report a length larger than 128 and overflow the array, corrupting
adjacent slab memory. This is reachable at probe time, before the
interface is brought up.

This was fixed upstream by commit 86a48a00efdf ("virtio_net: Support
dynamic rss indirection table size"), which reworks the driver to
allocate the indirection table dynamically. However that change is too
large to backport to stable. Instead, clamp the device-advertised length
to VIRTIO_NET_RSS_MAX_TABLE_LEN: this solves the overflow with minimal
changes.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---

Hi Sasha,

You asked for a tested backport of 86a48a00efdf to 6.6.y and 6.1.y.
While preparing it I found the code does not backport cleanly (there
are many lines needed to change). To minimize the risks of introducing
new bugs, instead I added a small 6-line bounds check on the length the
driver reads from the buggy or malicious device. Sending one patch per
tree.

Tested with KASAN + UBSAN under QEMU (guest 6.6.143), using a virtio-net
device that advertises rss_max_indirection_table_length=3D512, i.e. larger
than the driver's 128-entry VIRTIO_NET_RSS_MAX_TABLE_LEN.

Before this patch, virtnet_probe() overflows the fixed indirection_table[]
at boot:

  BUG: KASAN: slab-out-of-bounds in virtnet_probe+0x136e/0x1520=0D
  Write of size 2 at addr ff11000003384168 by task swapper/0/1=0D
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.143 #2=0D
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014=0D
  Call Trace:=0D
   <TASK>=0D
   dump_stack_lvl+0x36/0x50=0D
   print_report+0xcf/0x670=0D
   kasan_report+0xc7/0x100=0D
   virtnet_probe+0x136e/0x1520=0D
   virtio_dev_probe+0x2da/0x470=0D
   really_probe+0x12f/0x420=0D
   __driver_probe_device+0xf8/0x1e0=0D
   driver_probe_device+0x49/0x190=0D
   __driver_attach+0xdd/0x290=0D
   bus_for_each_dev+0xde/0x140=0D
   bus_add_driver+0x14a/0x2e0=0D
   driver_register+0x9b/0x1c0=0D
   virtio_net_driver_init+0x89/0xb0=0D
   do_one_initcall+0x9e/0x2d0=0D

After this patch the length is clamped, the device still probes, the boot
is clean (no KASAN report), and ethtool -x reports a 128-entry table:

  virtio_net virtio0: rss_max_indirection_table_length=3D512 exceeds max 12=
8, clamping

 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 33f61922c139..ec07e289f0c8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4587,6 +4587,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->rss_indir_table_size =3D
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+		if (vi->rss_indir_table_size > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+			dev_warn(&vdev->dev,
+				 "rss_max_indirection_table_length=3D%u exceeds max %u, clamping\n",
+				 vi->rss_indir_table_size, VIRTIO_NET_RSS_MAX_TABLE_LEN);
+			vi->rss_indir_table_size =3D VIRTIO_NET_RSS_MAX_TABLE_LEN;
+		}
 	}
=20
 	if (vi->has_rss || vi->has_rss_hash_report) {
--=20
2.43.0

