Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B954DAFE
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111552; cv=none; b=OSyRiz+rK0UgSmgGTBLYWujPxDls8qfs8cQsCACZ2+8dA0ZGMF5rWb2U2ws+S5aZoV3BAQ6ODKOFwDBjz8FfASUmGbf433ZoG6fm9HlRuQobmJpP1AtveTJkLOO1mTKKQWLcgKPy7950dhM6Hwl7EO4DEkwJyGcXyI6TMKBPLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111552; c=relaxed/simple;
	bh=2+E9WLAhddquoAhrHExJTH/ipVluXO40UC60vRyiwHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd5LNOzOfWPE5tsXpGFMmFAdU40HGPR0XjYLpyFGA48qKvPRWVEoOl7dQThSrG07LWNqi40sc6hOqGLnehH5pxtfcbxhPJzfiFu3TJjnxaZ0rF+kT1yjJR9rOQPEgMInZRGe+COZzocCz370dWqu/pPaT2E652zomYVGV+WkIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ObHwaF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ObHwaF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so2574686d6.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111534; x=1790716334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=e+ObHwaF5irV8lCqiCCfQD+0jvXngq0cWnSJ7DRgHKo8UjBNIm6eXvW2tPIXT6xwtM
         ZbRx/c3Z382fZ37xfKtJCdtx4RP/x5qWVB6SzitNr2swgL1QnILKeKZrR1D6OqQM/JY/
         nSul8fAW2D91nnhcX08DeltgmFw0jh7yboE5LUcAU0rTC/WHH7QCnjZ0Phc+IvO78tDa
         5LxIc8KqPP3gCxmQCBAgtrmbIGixMyyP34jSlwKClHElfzMJVYQhpOOW0vipZM3MuDk4
         cg1hDTsH7gYlLYOk5DE2UEJRV37eh2BLnJkoX4nR1jBVB1LLMguUn4EeCQ6MdVTCCzUv
         gVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111534; x=1790716334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=iTTvGblNJPDq5HBhNlVOYluCT8jPSv4h3efmAzLah68SLqlSZTRwwrhxhn5ghRWuKi
         JOaYGQ52BA+YkDkLikqp/2r/wSbIRTZtG5P8RWUZPGhNJUZKaKrr5SvGW2NWO8f9HUf+
         SlrySi1/INQ1CB6azAbsTtx6mXag35OMkOd7m9IT9wri5Ug2MJhYjwppmGkeonnmI+XI
         VNgFw1l+pPUEYb/9fuxKpQdpSHPkEqXKnRVoVP8+LfnrAPR1nYCBpjS5ocmlCs3Srbwn
         KcQNiY2m+Mjgi0XSRHlybSqNn/YjEur+9HY53MZ+XTP9d5u36QzeDr3Vq1Tkav3mQIjW
         /b7w==
X-Forwarded-Encrypted: i=1; AKwUvBx+vqJUUvqFnPF2G2KkdUdA14HnFsFk2IA9RP14tK2UWytB2+GsfyHKoVY+ExcMwg4jIVM1e7I=@vger.kernel.org
X-Gm-Message-State: AFuF++nPPMvv6N8mjE6H5iVAqZWVAlYfJRo50QeAJP+DdTyoERkHY+8M
	9fl9GIVC/8SqEiVvGndtlOxfWgk7ZxDUXumtohBWFYNuCvKAl6GQK/mM
X-Gm-Gg: AYBFou2NglJqBDKrIi9QBEwRznQB/fm9xkUrj46hnssXEMn8x6LYio5WUd4iZElgkAn
	zve6DsVkGFzZNIaZp1uQlGArc5HiU3fMLQPOl5DMknFN/5FeEeOxS8wJzw3v0y7dT2u3nOTMqid
	L4oFwt5asRri95QGEu2sQ/WysBGj6XDa8Oof8QmDmNqc7GTiiT4aBWK/VA+zcoz1r+qD38Vrlh3
	3UwUb46kdNf4p0b9Vuy/zGPSku7euhcgqTDizY52Iat4RggLQEReMiI5MkWN6HCKh6zZ2FUAPC/
	zXF2csR07wUZNzWHp9odq46uacx7WPtiAed1jywS4hof4iekS4dvGWrvX1plwb4P2rj6yl9PEuF
	TTR7+A5vnHTLzjeCFkdZRPsZjN3iUaz6h+vfnJ/ZzDoXC5uSWNAobwxGZRgG8H6vBlzriv1k+Ne
	5UYKTwI8Jh3XB9v0T8KMHyEjnXvYKNEWvS54M37YLOkvWr0mxSWDJIrFgbjDu44MEDYCf4aXb1h
	BthibTi5SJeWbIWwZmvjw==
X-Received: by 2002:a05:6214:4a88:b0:912:533a:4a43 with SMTP id 6a1803df08f44-9140c3f990dmr12597706d6.32.1790111533845;
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4640c9sm6319316d6.40.2026.09.22.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] virtio_blk: Reset device on probe error paths after DRIVER_OK
Date: Tue, 22 Sep 2026 17:11:41 -0400
Message-ID: <20260922211207.523999-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtblk_probe() marks the device ready before revalidating zones and
adding the disk, and either of those can fail.  The out_cleanup_disk path
they take goes on to delete the virtqueues, but nothing tells the device
to stop first, so it is still live when the rings are freed.

Reset the device at out_cleanup_disk, which is only reachable after
virtio_device_ready().  virtblk_remove() and virtblk_freeze_priv() both
reset before deleting the virtqueues for the same reason.

Fixes: dbb301f91fc8 ("virtio_blk: add error handling support for add_disk()")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9dc..ed97dafebe164 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1547,6 +1547,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return 0;
 
 out_cleanup_disk:
+	virtio_reset_device(vdev);
 	put_disk(vblk->disk);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
-- 
2.43.0

