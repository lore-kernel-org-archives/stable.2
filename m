Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891394;
	b=i2DSq5UWB1o4GXSt7mdXzIiM5ExtT4pG3i2Yzpg6xjtwqJTxE3G8Cc6EbPgInossSoV2
	 T9ZQISMSad+GaYVS1uK1Saqk1iz/Hygq96JUwdqEL65t+8ghkR8OvjV1hNf6C6xach/ES
	 yOAeWkWXPkqQUpyUxZqjKE7DcebgxTuiVukAdlq1npke0IFjlMl6ljsirt2X8kFsiWj8x
	 uK94zjv7RY1V/hvdKzSbyHGebIHuHba8EgQWkaFHzht8yeuIUOK0SqPOLGyrEGyibnYLB
	 0pIFSk7PNRv8ptqmxEGshSlfB4YpMmFqJdpIBgPXXu+w5m3qMo5o+PFT5VEjcomJlcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891394;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
	b=XPvsPUceT6eJunmN4trzaaxy8bXP0ZQw75GWvVfcU0KC1bXEoIPFFOfiOFMFtzqOmTdz
	 qbcrGYCtP6HcuSyZp3vkvieywbCUfeiLWVM5yh2etbhkQRRDFgdQSX/GVD3WrC4fAjABk
	 +HuRLjhMPDV3VB0a7M7DwwGDh43CUUBIXM/O0rFTrTm+tf5JWnPwfZK+IV+IK19CmkNgr
	 38J0ABRtR46lRHBdyr4Lv6pKpUm4wjCRVmqWjoOzHEYBnizj/SNSFL7M/IGxvxcbIX9Fv
	 +DJCYP3RmLyaSjfV+sC0RNqMs4VfTNvSOfH33JTsQ/59HI7ktaRzlT7L/FcwyDZj8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fs90zJzZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tL9ebwdV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB74606D82A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB74606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fs90zJzZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tL9ebwdV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793891394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
	b=fs90zJzZuafVuQzdsSHJ0cXhmfeAR6y1cdiNB4D1gOAgYeu8h9k/zrK8XPnBXvTPw4pV5X
	aKJVHca414msK15EA86z+gRrdzTCs74z4BlLE6xllYloU69UwsR+SnLDDlNglbToA3Crbw
	ax9GqSqfClJxQFa66vZ0GRJlX42XdkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-e4e4Boi6PXieyqYKU-efjA-1; Thu, 05 Nov 2026 10:09:50 -0500
X-MC-Unique: e4e4Boi6PXieyqYKU-efjA-1
X-Mimecast-MFC-AGG-ID: e4e4Boi6PXieyqYKU-efjA_1793891388
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e00f3929bso515147f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793891388; x=1794496188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
        b=tL9ebwdV7oOdIIQF3HeY+1L3U4EErRkIvwLe2jwArflIR8G0RHn7hYF4F9bqW4Xux4
         drUmhi0vfnVoolkUSrsI5BrlYO6JTAmHbAYtogq0KQHm7t4qbJJEpjnGISoANyNlUiyy
         NZutx5CwYwHYFk7fFnwZiGQDllJTtjI9CkSm8rNE+GlKnnIfn23NK+DYUlbmr9hu9Zwu
         Edqs+I0gDYR0L2uNKVGACgsl4fj6pSh9i62YwEhjnGarJ1lkXRIPXE5xwxHTIEZA784h
         Ni6gxrM8CX9Nen1bwzsn0UdEpkble0uiwT80x4MRMNSQn5cyfn2P2PUYiWSHEB7e9m4j
         kIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891388; x=1794496188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
        b=IEYN6a2iHPiTTqcdCcPeSor8JfNLCEuDnG2e/IiTxEdJxiAc2YsI1uSZ/Zbj/yD1mb
         NdTDLo1RDYaDGhtGqlxkRN1AP5d/5/wu5dgx3UfunMIMklw35fGszlz2tcOHUv/sboao
         XzQVpPjiBUO8V5q72W9XAjgwqpVp70wXeVbnZZAItv7OjQTJuO1TpwaYTAuPBZQP1LcW
         H7LK5EepKv7Kk9Kw3NC/a9Oy419rFPm+qUNWw38AIoko+IelI5Yynz/8f6yeo/MPSrdV
         DAnHjtIPGfxtTLNwxmompNmlqackenr+N4WgKG3TELDOzYrcx1r48G/a2Vcpcj8JrJgh
         gpcw==
X-Forwarded-Encrypted: i=1; AKwUvBz5faOkOrHbjlFcY4kITzLVgWFY/ojrBxRoHh2ZRncaBC2hi3NLP+qhyRKwzVGsjYEWBaVtcv0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ta3ZYInPwg+Ynfdq0qPJTEelhRVOskW3a1VTUlIwQDpRlPHf0
	pyHbzHGA6zJigFrDCGw3jI5uVNdaGKSxp5EHReExNp1FtWQN1bRLFLxM9qxRpZG4xYf3LMLIyev
	C4SI2E5SAqVexawlP4jeZL0mmx+7rE1th3AiMMoyS13O3tXRqDCoUMmi5Zg==
X-Gm-Gg: AYBFou3oeG/xFu0M23qHUgABDO3dPzxOlmXgLjcBkrWLJp6sCPC1zB4fkAu5zVFmHoS
	jBsREfazQBxBcH1hkqU1V1cQvqp+7ipd3dOH5C36hiKIXWRCVUNeqC0joN20Q9kM9eogJOV2r6i
	mnkrx5K2guWcXrEYC6KK5NAwaw+W0bDGdwkUjMmtFc71d81JnAHc1QN0w0AFlLVgRc03as5famU
	qd4iealuZSyjgSKQbevlEry7ot5ARU4pQmYtgbY80x+xRDWQao1r8LwyX7ecRbAR1GhrEJ+npzv
	5azgB2aicTuloFRt+Tf9ad8KbLavjY+i91OYtCnVKalc5Y2ZH/fyiFUkN1eF1S+Vty73YJqFcgp
	9ExL8sYBEt5cpy2uC3gJ4CmkF2KwI60/ktGCC+F3EvIDCsVmW9fdyeVu5/QjtyZj7ID8D3cKWRP
	KVYdfkfQ9Hi8hfSwmGhGs4LFUQKKizWfnCAbGnf89zRUU=
X-Received: by 2002:a05:6000:4552:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-49115c978eamr3205040f8f.13.1793891387706;
        Thu, 05 Nov 2026 07:09:47 -0800 (PST)
X-Received: by 2002:a05:6000:4552:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-49115c978eamr3205007f8f.13.1793891387238;
        Thu, 05 Nov 2026 07:09:47 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm9961340f8f.52.2026.11.05.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:46 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device removal
Date: Thu,  5 Nov 2026 16:09:40 +0100
Message-ID: <20261105150943.86650-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105150943.86650-1-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
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

The virtio_fs object is refcounted via its kobject, so a mount can keep it
alive well beyond the lifetime of the virtio device binding.  The tag
string, however, was allocated with devm_kmalloc() and is therefore freed
by devres_release_all() as soon as the device is unbound, i.e. right after
virtio_fs_remove() returns (see device_unbind_cleanup() in
drivers/base/dd.c).

virtio_fs_get_tree() looks up the instance, takes a kobject reference and
then drops virtio_fs_mutex before doing the sleepable part of the mount
(allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
can complete in that window:

  CPU 0 (mount)                         CPU 1 (remove)
  -------------                         --------------
  virtio_fs_get_tree()
    virtio_fs_find_instance()
    // reference taken, mutex dropped
                                        virtio_fs_remove()
                                          list_del_init(&fs->list);
                                        // driver core unbinds device
                                        // devres frees fs->tag
  virtio_fs_fill_super()
    mutex_lock(&virtio_fs_mutex);
    if (list_empty(&fs->list))
            pr_info(... fs->tag);   <-- use-after-free

The virtio_fs object itself is still valid here, only its tag has been
freed behind its back.

Fix the lifetime mismatch at the source: allocate the tag with kmalloc()
and free it from virtio_fs_ktype_release(), so that it lives exactly as
long as the object embedding it.  All probe error paths already drop the
final kobject reference, so they are covered.  Merely dropping the tag
from the error message would paper over this instance while leaving a
devres pointer embedded in an object that routinely outlives its device.

The other readers of fs->tag are unaffected: tag_show() is fenced off by
the kobject_del() in virtio_fs_remove(), the automatic KOBJ_REMOVE uevent
is emitted from __kobject_del() while the device is still bound, and both
virtio_fs_add_instance() and virtio_fs_find_instance() only walk instances
still on virtio_fs_instances.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: <stable@vger.kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b5ef
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac..ef58bedc3941 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -193,6 +193,7 @@ static void virtio_fs_ktype_release(struct kobject *kobj)
 {
 	struct virtio_fs *vfs = container_of(kobj, struct virtio_fs, kobj);
 
+	kfree(vfs->tag);
 	kfree(vfs->mq_map);
 	kfree(vfs->vqs);
 	kfree(vfs);
@@ -489,7 +490,11 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 	}
 }
 
-/* Read filesystem name from virtio config into fs->tag (must kfree()). */
+/*
+ * Read filesystem name from virtio config into fs->tag.  Freed by
+ * virtio_fs_ktype_release() so that it stays valid for as long as the
+ * virtio_fs object itself, which may outlive the virtio device.
+ */
 static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
@@ -505,7 +510,7 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 		end = &tag_buf[sizeof(tag_buf)];
 
 	len = end - tag_buf;
-	fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
+	fs->tag = kmalloc(len + 1, GFP_KERNEL);
 	if (!fs->tag)
 		return -ENOMEM;
 	memcpy(fs->tag, tag_buf, len);
-- 
2.56.0

