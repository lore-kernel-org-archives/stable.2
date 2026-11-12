Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460935;
	b=rvoXS9kVO0/msLMsByOHUpqOMAfBbu13lJ5I04ZH7ExFIZAqeBuY3m3oPmk4/Lf7SJ2S
	 D+Wur9FwhCveY1FOPZWSarE/6cQyYOR5qoom6e4vtjdpwUnR7UJEzBdJ4LRtJo6IgXYKh
	 ev31W5Ya9zLKBSP//417nQqsJ8rLSGAarSo00zaCXVPI8VWY4dLK73iiMv0zIYlu5XVT9
	 8zDVPfR4x3WboB8JHlw6pJIyrbwvFvzR7ZWPWhzvYWDRdflVeu0yhERZ4a09WYBBsnYwr
	 qjl87lS0Vw14GjyCaFJkfwtkk038Af0UZcV9BLQ5N79qc4mX9IpairbuUsoeC/gLYSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
	b=Xp85wPFjWSSUEGij6kFXLMlfStKPEKRuuGPkwNaS7rfH+AKxsD8gLvxTW3bHtd+HE7FF
	 QQsznCRLRz5Gw5w5qwBTjVkPkHLsLUnIwYHE2hrZwN/90W6aUNFghcVpb/JjpToAI5g+n
	 vX9mhPl6ViFOOoDWdfkBe+WvQvjJ+N2FYYgmdYLy6lnUxUGdxKSaNF4zyiGBgS7INl7Wy
	 Jgxi5JogQDDHtgoy9Xn7pJ9O3pzuWmewzyxBHvNQesK8Q/jbD7hi/K7bRLqj1o8VTxDrb
	 nJAOxhIj5rSJg/Q6QMOkJw9BgPoH2TEMiZUrZlzXZdRp/KjcqzIC4+ZPKxkLEkg77Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eyvD7j/7";
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18095606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18095606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyvD7j/7
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2b8cf037so343476985a.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794460933; x=1795065733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=eyvD7j/7GP//UsvMrOm0nhkwnqG5mMKw2OYHo4hgzwLwQfXdKabVriJGWT1HxKeXNz
         sfxjnKjMrhmXIcNtdSeQczcTiL2CSEeIgQFRAkz8lGwfL3GGEh2UwBoM7gaCFeItaQQ4
         bcY1MPUwRciFPDYTeTnQreRAeY1Pmfwfk9xJmnNy7fBDrQiKHp6Ul6UYGAcR2WSjnSnP
         xSSti1CqcDSmI/GKgczNTyjPx2xGIuRRu07giKAU+sd0ElQr8G2Impbg45ySoAffBSfR
         uDhLwuCDZd9Dytg84ltCLZhI3vNGE820+dIkyFUeUhtKVP5j1sZy20rnT5PrZ+XcFpYn
         eY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460933; x=1795065733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=ndCwSjULcikEv6ZgRHjSxos9uMDTVIR6UGvCK5m0dnVptWlR/GHJaCn8cdV61wWo7f
         5iNJ9dChRPcqB04nwOXaVixMAr0msIJyRa2Tl4tQNd9Y+p75a+ULBdDdYqMPGXRcgweL
         eRBUo+Msy8IOlfbgiG15DtyiDxSRCfpxncBLAPZTsm+PuJk5+eHzkLbLv1petfFhPdHN
         rMZYueD6jtIzoB0VAASbd6PzXGaUump7ZSVZz1c2HTymWLbduFZI9pNgm3wEptHF8i7x
         fG8qS86FR8Ir35/ZqpZ2osqMVNqUr6xXxrnJW9+xE693hRcgj5i/1FfsHeD2C7jpIfZs
         KHuQ==
X-Forwarded-Encrypted: i=1; AL+hErGJTOG8MLHBMUzGk9xDlBdREWwuiir4+pLxn500Sw4k8P1HVHn6CioHftP7mhqujQ+x/ur5vho=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QH5J70jV4S1DwQpUM8rIcNjF31Cfu1y/rpolUQABAP7wwoRRr
	jYv9HIcZ8Y6h6ohuxjAPw6QzKD6ni2aI1z6aLllmthiMVdxfJENo9/7m
X-Gm-Gg: AYBFou2qzIzmJlNm9H5Y2BAeRkFV67dRiY/1fkrKcD6zHx52aAI48K9JUffWhE8aTZO
	SK+y0+FQzn3NLe/LaWLp2EAxf1tKZWRepL86rACd5YG6DDXFgldSgkZc8Vk4Bm+I5A/3oKRjpyr
	Zrd2+zAIzuoHwbc6eef3idgtSuHAocf7BOwCFexGhGpR7c4vx5kluLl8FpIgAzSMeIOZRjczjsC
	dd62rU3uXeRo75o00ol5eXqdWt2/Z/oWA7FQwLfFTr9jdknb58gEdHcJO1Ba8mjabjrldqZt1fJ
	XqYQgzAhJdncYXie0aZaD7t1RgJGmCGiqp339P8KfwdngpgXe+UCf/++atmujn76Er2Fw/FKLkT
	vd2Bzq0e8nb31HuHpiknDgiLTbwDTcvirf/QKB8nWAw8FJys4rNWuS7lQ1oZhIx+bhRh/2eNuI2
	OyvNr4dlNsGzG34dqqbALMh3+N5pKtwoMemn2KInoFoyjZDYAJah0SuxjcUvljD0Rd4bjtx28N5
	UV8Dp+nty43LnnEo7STIMB8rqdsAhY9Szfv2l/c7uXGiYiFR/W5KUUwfp1OfFiBzGRBbTGeQy4c
	1yIsIUfMn6YwbXKSQ7vcir/91EU5a2Xz7tnqG3Fn/fyubZ01l7Ov
X-Received: by 2002:a05:620a:4693:b0:93b:d7a3:45cf with SMTP id af79cd13be357-947affc2972mr765476985a.56.1794460932899;
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f03ca6548sm37340956d6.9.2026.11.11.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: Don't use request timeouts on virtiofs
Date: Thu, 12 Nov 2026 00:21:50 -0500
Message-ID: <20261112052208.1248312-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtiofs cannot abort a request once it has been added to a virtqueue,
because the device owns its buffers until it returns them on the used
ring. This is why virtiofs sets no_control and no_force_umount; see
commit 15c8e72e88e0 ("fuse: allow skipping control interface and
forced unmount"), which says that "virtio-fs does not support aborting
requests which are being processed".

The request timeout added by commit 0f6439f61a6e ("fuse: add
kernel-enforced timeout option for requests") aborts them anyway. When
a request takes longer than the timeout, fuse_check_timeout() calls
fuse_chan_abort(), which moves the requests on each virtqueue's
fpq->processing list to its end list and ends them, so they are freed.
The device can then still write the reply into the freed request and
its pages, and virtio_fs_requests_done_work() later gets the freed
request back from virtqueue_get_buf().

The timeout is armed when the server sets FUSE_REQUEST_TIMEOUT in its
INIT reply, or when the fs.fuse.default_request_timeout or
fs.fuse.max_request_timeout sysctl is set, for example for other FUSE
mounts on the same system. A slow host is then enough to hit it.

Don't arm the request timeout, and don't offer FUSE_REQUEST_TIMEOUT, on
connections that set no_force_umount.

Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
I used no_force_umount to tell these connections apart, since virtiofs
sets it for the same reason. A separate flag would work as well if you
prefer that.

Tested on x86_64 under KVM, on top of v7.4-rc1 (6628e7d4c6b2) with KASAN
enabled, using QEMU's vhost-user-fs-pci and the C virtiofsd from QEMU 6.2:

  1. In the guest, set fs.fuse.default_request_timeout=15 and mount
     virtiofs.
  2. On the host, stop virtiofsd with SIGSTOP.
  3. In the guest, cat a file on the mount.
  4. After 50 seconds, resume virtiofsd with SIGCONT.

Without this patch, the cat fails with ECONNABORTED after about 26
seconds. Once virtiofsd resumes, the guest reports:

  BUG: KASAN: slab-use-after-free in virtio_fs_requests_done_work+0x7be/0xbc0
  Read of size 8 at addr ffff888005176020 by task kworker/1:1/29
  Workqueue: events virtio_fs_requests_done_work
  ...
  Allocated by task 81:
   fuse_request_alloc+0x19/0x200
   fuse_get_req+0x153/0x2d0
   fuse_chan_send+0x4cf/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Freed by task 81:
   kmem_cache_free+0xbc/0x3e0
   fuse_chan_send+0x4af/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Oops: general protection fault, probably for non-canonical address 0xe012fc11a000000a
  RIP: 0010:virtio_fs_requests_done_work+0x25a/0xbc0

Setting fs.fuse.max_request_timeout=15 instead gives the same result.
With this patch, under either sysctl, the cat waits until virtiofsd
resumes and then returns the file contents, and the mount keeps working.

I could not test the FUSE_REQUEST_TIMEOUT part, because this virtiofsd
does not know about flags2.

The tests above were run with help from an AI agent.

 fs/fuse/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed..f1aae9b5475c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1451,7 +1451,14 @@ static void process_init_reply(struct fuse_args *args, int error)
 			fc->no_flock = 1;
 		}
 
-		fuse_init_server_timeout(fc->chan, timeout);
+		/*
+		 * A request timeout aborts the connection, which ends the
+		 * requests that are still in flight. A transport that cannot
+		 * take back requests it has handed to the device, such as
+		 * virtiofs, sets no_force_umount for the same reason.
+		 */
+		if (!fc->no_force_umount)
+			fuse_init_server_timeout(fc->chan, timeout);
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
@@ -1502,8 +1509,10 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
+	/* See process_init_reply() */
+	if (!fm->fc->no_force_umount)
+		flags |= FUSE_REQUEST_TIMEOUT;
 #ifdef CONFIG_FUSE_VDAX
 	if (fm->fc->vdax)
 		flags |= FUSE_MAP_ALIGNMENT;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

