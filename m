Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3634041E
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075987; cv=none; b=V/s/ybZdaEFejekbp1xr78ZShonQrky+4qYwYwRMsccw+ZsGnucosX6pRFCLtgwKyRPBGAK5tbA2yzEaJslT0wND1bkp7ZiQB5o7SLQqCZkLWWu5YVEarwXuRssI/EYynu6IkGleTNKuXNbyfjbYicSLejWpUhd26seGQi1ZJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075987; c=relaxed/simple;
	bh=n2dvmCT/3n07xYHJSO9W8w5ISYOmXe0c8mPsI26rKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaoOeZLttNcFVoVZ4IIiuKbWQeWX8y5UX3nQ6tnG354i+2aXhwguacEr6fetRuEPQgdJOrIK6ViXVNXuBWXJwrxIlEbeo/OaooKfKM6h60epj6eRwFUNI5FplqtlzBrK70fK6rN8Q04JeGuG/EBMvyAERa2vX1oNS4Z6Uq8tkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVsJ6p7R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVsJ6p7R"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37fa06b39b4so365589a91.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783075986; x=1783680786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiiB25eLMvJ0b3zoud6x0uzpJQH3ljcPlfBdhH5UEnA=;
        b=IVsJ6p7RD3l/lPXkrFezLEAUgJz5KN8wXHcumVo2qkjDfoROeRfI+/KHVITo+lXJt8
         t9MniEWB0ftcrcltPnBofbCLQt6XhcaixwNoMgzrMCQaPNtmVvdEbBo7TLR/QTHKqJP8
         idQvCCXTTgMMCZJGV+L/4pFZMIvVNoks6hJPT4g1IwFTl91IgNX1cKF3Gs6LMnY+5QG/
         LVk17TcbnLlOZpKQ+AVOu8iHBcJn2qEqlhYKEP5uCV0EPYpUquWj5RJXjgxW5QmwLJaw
         MSgXHZWfsgaXNKIW+1alSDnM8+5rNnCJacWwod1UwlYCNw53VMbcuoBwlcarh7tszDLR
         bZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783075986; x=1783680786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiiB25eLMvJ0b3zoud6x0uzpJQH3ljcPlfBdhH5UEnA=;
        b=MW8wasf8NRBV9ZYBWxIJoOHq5aQvMeVF8t1lLt0/4PcDvTL79lMyIs4q6E/vYEFRZu
         iF3f65i2+V62U7MKv8iN6LnSFzA3PjqjsmfbRsH/x0Zu+uWc2ocPuxI7rbzhpV93O3w6
         XvPWNkhArCuXjMoZ9goLX7CwsdgZkWy8jo5kXYNk+3/sQws7GJkSTd0nuiQqTXesjVGS
         uKDmROS3CZpD3VpzQcDtZXzcKDT8nOEXTLeZDM9YRNmzpJliRw+C6Z0XWxnNURllR5ln
         vMin4W32ZjzZiGuGHvflCka0XK8TZTktPLyMJdMvqzW5KlKUA52OYI+KIzXDrq9MmF6C
         cOJg==
X-Gm-Message-State: AOJu0Ywpts+32Q1e1k3+Ib9JeGK/kDjU+okDZZzzkTdOo3aGVALbpSfO
	LeTLnvXPFM+bzEpObHPq25vqGZTqj2791+SIpIFeAZdiIB8IysnI1k/PBd8Udn9J
X-Gm-Gg: AfdE7ckXDO+3eXXLe0vf+mnKhrsTEdDTvTrvB6iLZq4G1gcsP5o6ICvo1ZL1bpd7FXZ
	2kD3Pxxwlqiff5vYKqeFJnbtTnctf4nxnEO3dOxcmvSoskqNSuK3X/zxWhxk6KE139a34sgtx2w
	6Fv88EjHuryBEf3EjyVanRCJdQpNRzCO+KseK55gfKkE/8MaTOQQdUOX7H0Pr4Q1qLdQekdDu/s
	mzl5UXVTAS23Tc+Jxld2eeYcJG+Duu5+sDwCPWiISyjW4TXAOHGYMU3/6dWLaN7fa7b8U+4GoKw
	nUOKtJmg4St+12KxA1nMcEBj740wywALqzxDjjl3GTqImjpY4amRJWNz+SOaLt6JHrPtsy+yQLY
	9R3EvgechvrAQP8buiILuecIziPjNysCQQ9Yvihy1SJAkcRxomi3IMcd7W0UAy4YFxZYLTBzNW1
	Re3CaEYpIQUzTxyc0xmV2IEPjM1DmOS8ol
X-Received: by 2002:a17:90b:1d45:b0:381:21ea:9147 with SMTP id 98e67ed59e1d1-38121ea9ca7mr3137640a91.13.1783075985604;
        Fri, 03 Jul 2026 03:53:05 -0700 (PDT)
Received: from annie-ProLiant-DL380-Gen11.. ([183.107.7.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3812815d3e7sm762765a91.14.2026.07.03.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:53:05 -0700 (PDT)
From: Hyokyung Kim <pulpannie@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH 6.1.y] virtio_net: clamp rss_indir_table_size to VIRTIO_NET_RSS_MAX_TABLE_LEN
Date: Fri,  3 Jul 2026 19:52:56 +0900
Message-ID: <20260703105256.3884798-1-pulpannie@gmail.com>
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

Tested with KASAN + UBSAN under QEMU (guest 6.1.176), using a virtio-net
device that advertises rss_max_indirection_table_length=3D512, i.e. larger
than the driver's 128-entry VIRTIO_NET_RSS_MAX_TABLE_LEN.

Before this patch, virtnet_probe() overflows the fixed indirection_table[]
at boot:

  BUG: KASAN: slab-out-of-bounds in virtnet_probe+0x11a2/0x1580=0D
  Write of size 2 at addr ff11000004130d60 by task swapper/0/1=0D
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.1.176 #1=0D
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014=0D
  Call Trace:=0D
   <TASK>=0D
   dump_stack_lvl+0x37/0x4a=0D
   print_report+0x181/0x49e=0D
   kasan_report+0xc9/0x150=0D
   virtnet_probe+0x11a2/0x1580=0D
   virtio_dev_probe+0x2da/0x470=0D
   really_probe+0x12f/0x390=0D
   __driver_probe_device+0xfa/0x1a0=0D
   driver_probe_device+0x49/0x190=0D
   __driver_attach+0xdd/0x290=0D
   bus_for_each_dev+0xf5/0x150=0D
   bus_add_driver+0x26e/0x2c0=0D
   driver_register+0x10c/0x1a0=0D
   virtio_net_driver_init+0x6c/0x93=0D
   do_one_initcall+0x9e/0x2c0=0D

After this patch the length is clamped, the device still probes, the boot
is clean (no KASAN report), and ethtool -x reports a 128-entry table:

  virtio_net virtio0: rss_max_indirection_table_length=3D512 exceeds max 12=
8, clamping

 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b62b76963137..c840e6a55d86 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3913,6 +3913,12 @@ static int virtnet_probe(struct virtio_device *vdev)
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

