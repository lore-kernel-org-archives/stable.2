Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306009;
	b=CJjmc1T4TUM7R1q+rO7HNWKzx8ZnGnrt+DFTHJ3CfDHwFf4t1SuXqe+71c+CHdxJD0Ej
	 XwOkqYECIcCfAe7S3sbsa/iB+Fq+Bo9pTB+0pbz72p6YXMkcNh2t0P147YECjsVO5HpZg
	 jF3cmyv8Xmug9zIh8x7edCyFVWv/EItvDk0ampcmrUJxUNDCJRoBpdPLQiy+o4THBnW3l
	 gKwb4E3u8wDN3UhxZ6RgzIVwujxqqWeSNGKdtbcR1VJ7crvD2xE19IxCGm5oB/FYEep5f
	 tci66+HIc+UqZvjWB9bHefg4Dr/D2LcSe4732cJMggSMVuVt1neLfrFdM+d28f2cVHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=1nHo9LSuLUSo1ctkTfXz3MdvvMC6Xb44b3d2+BYjEH0=;
	b=Oyy6njp+WjbhVmC6zMOaU/daBELetbR/H4LLgOOBrMVy5loS85opmTJYuwbBcsppW+Ar
	 mY6qukNgDHEOIcdKrEu6vHKNCvXiDHhqQTufC+8pv7Q4Wca4loS8vz+wW5+lkxnlGS6DV
	 j1fCkgfGZ9H9dWjnVPPmAQ7MQsc/BKiWKt5J7ZyclI/uLmAGS6YJFUczzbiOZ1jaR6cOZ
	 yVT8BN6Gx5M6rdfl755rrVfNhCgrDTnJHtSb5BSC3KQb1L2vC+58EO2Wee3Iatf+cCBDh
	 u0dOS4OLx11lYVExXQfk4So4YY3dwvH606ZZcM3INKL+e54urquI4xLMWVJ8SSlnZVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="oyMZl/rb";
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66550606A338
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66550606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oyMZl/rb
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0592d4539so3155381b3a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306008; x=1793910808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nHo9LSuLUSo1ctkTfXz3MdvvMC6Xb44b3d2+BYjEH0=;
        b=oyMZl/rbfnscD/YU3wgziViiSLRMb8xd1veh6EaqUzMYD9xiVIHELeMsFxFRYOXbp+
         BJs0hY01nzVj5nlQcbkPq4YqRpCuXaVNIhQnW+vaX8apZk6GsrmPzjQ4maFFmL+qxkvx
         Q1QaHkYkVNQ0KP+kbY2o95HmV9d5R7WrA0AloSPhos9GSaMl9Mxvl4SPo1LPErbyaQLk
         HbTm9rar216088rz5nvPuT7+V9bxAp2BwI/qGJvrXq0pf030BdbZQ5vTAVGtY3wHpQqV
         eJMvJ0k9WjuO12XHkqR/wZL5Gk9wyoxg1gp2jDdCpJKbFXwphtWmMrwqpAdiC8RUpTHX
         3cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306008; x=1793910808;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nHo9LSuLUSo1ctkTfXz3MdvvMC6Xb44b3d2+BYjEH0=;
        b=py2lxBeCEoJvh3dRlvm4QrH2joaMoX7feyCAeere0mJOMxa+Ms5Y4K4IqvVo3Ocl85
         ii2FY7yUPQWFj5II7gCv0rU4RMhFrJeeEB3vR26XhEHGoGO95mHSAitTDKUEGx60oYjv
         9JX5bzODW7VZSHpyqE0z336lUTg9NM0GEeuKfVkA6k98N0uXsjJAtVl17dhwMmkF+85m
         fDhN7GOTa0zfCzsfK/1Z2NE7HhI6+NWvUzL0oSMgs/gHD6bt6dZ9IZqW3S7Iqj43uA2n
         vqeUZ60H/WhVPPexDHk8SQAt2ZgTAG3o3oSYu+In2qA6yuiBmQTTp73g/5P50QhwDQdh
         RmaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5dilpWIKy+3JQnGH17GSegZd2EgAWWz7Yz7h+sUMaItFpZmO4LeeVGOS1DwrVJ9p1Rz9BpLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFuA8nhuMJpmw+ZrsBRZEqBx7GTkE4ZERkFCqYD+EhfUlQpU38
	1OPKTnBSOZfU9fI0eKhXbj1Zj9azpbfsTqil2JjWNlI0gM/XeuyqE33isP8/lS2A4yZ43LZ8n2q
	ww+r+S8N52tkWfA==
X-Received: from pgcgn23-n1.prod.google.com ([2002:a05:6a02:6a17:10b0:cd6:db2:b293])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7345:b0:3de:8ee8:8323 with SMTP id adf61e73a8af0-3e928956a7cmr407720637.29.1793306008350;
 Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:21 +0000
In-Reply-To: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029203324.1637772-3-dmatlack@google.com>
Subject: [PATCH 2/5] vfio/pci: Annotate lockless accesses to vdev->sriov_active
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() and WRITE_ONCE() to annotate the read of
vdev->sriov_active in vfio_pci_set_power_state() and the lockless write
that clears it in vfio_pci_core_sriov_configure().

vfio_pci_core_sriov_configure() intentionally clears sriov_active
without holding memory_lock, so the write can race with the read in
vfio_pci_set_power_state() (which runs under memory_lock). The race
itself is benign, at worst it results in a spurious -EBUSY while the
device stays in D0, but the accesses should be marked to prevent the
compiler from tearing or otherwise optimizing them and to document the
intentional data race (e.g. for KCSAN).

The write that sets sriov_active is done under memory_lock and is
serialized against the lockless write by device_lock, so it does not
need to be annotated.

Fixes: 40ef3edf151e ("vfio/pci: Use a private flag to prevent power state change with VFs")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 95aee6b7cbb3..9a62797e50bc 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -332,7 +332,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (state > PCI_D0 && vdev->sriov_active)
+	if (state > PCI_D0 && READ_ONCE(vdev->sriov_active))
 		return -EBUSY;
 
 	if (vdev->needs_pm_restore) {
@@ -2396,7 +2396,7 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	 * state transition would at most result in an -EBUSY, leaving the
 	 * device in PCI_D0.
 	 */
-	vdev->sriov_active = false;
+	WRITE_ONCE(vdev->sriov_active, false);
 
 	mutex_lock(&vfio_pci_sriov_pfs_mutex);
 	list_del_init(&vdev->sriov_pfs_item);
-- 
2.56.0.317.g454f8302e1-goog

