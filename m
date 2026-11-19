Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046519;
	b=YOYe+AKix/4NVVBFT32xAppWc8nHcHlI7ohBAy7g07zAgwOsLjt59v0REUl1df3rODkG
	 EQOk1BD2d1COZw9rayX8Q0iIiR5zDRPbfW+nRlhvbulNfJyPQ40PXnMEBP1PsV7ZSRvei
	 pDby8PDd0xbXWPXvLo99dZ4iBvqs0JzNQRkJozc/7XC6FxNtxbuMZhF33b8nAVZ8Z95Jm
	 DyZw+EyfQ2SWXMG6LzQ6ZI20KBKKpGB6Sos7LXsrt2mrk3R2T0UtPT2Du5xZP1pGtr5c1
	 zlXmPufwfP/B7YpODzVy/KNz6APRRVDzHTs5JRXbhBH/FzOoNnHiQOaiczLGxiUfD3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
	b=DbS0nsbCiSoANkL8uOr4HNGcEiL9A3XRd0qdDOIJWvxV8HEUgbuIsUBfLg62Qy3yZh0S
	 JAbo+43YoGryoGX4W5fWljUn697uAyzj1/79OoZWWGvFzUUdhYzX7zQPWs5KRRvkj2CXj
	 F/6+94PAp11BHgOjkUeGxV3aHlT4p+7LeEdbWUR5AQdvICtFiMKslipBz5lnJIe7sz6zh
	 2rYOp2qTFTesLmFvUcouve/QwgYav5Iq2c8byWRQ0Df5i2DN8Gi8/cr4hfoYLU9bq0Y6X
	 IyJsgB0JMe90+ETKD9BByh2oCBZEpCw6/ek6dA27yMXspJh5L84HQ+uLbRLdlYzeL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nsRGs9Ga;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECB60A261A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CECB60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nsRGs9Ga
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-547ae874949so2097777b6e.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046518; x=1795651318; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
        b=nsRGs9GaEnVL8fDz7RDR30xI5x0zjXluUYy96pdI+goVmdQ/rT3JwxAmAhoLV7IDji
         FS84Q+VArgYKbMS6JeL5lnSR17EEK/kS8NluDXXIf5fdaK0K5/O4hA4LhOdIVwsQHusy
         tNa0z0tp7R9qIDPlxXbE45AY95n18rw2FY54ZBHmWxHVQHEbSMqXosjNYqECUWKhjng1
         Kb1rirxYgDO2Sg1zDFL9Ma0uNUMmPJH1ugn6x0cPwmpaRO8Db8iomGD0Tv/c0yl7CPah
         rIaMJ6cz4p4Hm9pWzg/iaGIZtw3bj5dZUCnbxRPsamBCwXb0jav8YU19AMB2vkXnm1rD
         hQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046518; x=1795651318;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w7Woz9FOzyEI61pXAlfURrfx9J9JG5qwKCh+RDSinsc=;
        b=wcEfz3VX3tVCZ3cHh8RPY78WAptInwfNO4dpyppCi/UoTQX2O+VscIs0d8sA6xjlx3
         ZgUGBafhQVSairlH3Z5baqQW5D/ITIbIilKAugYz+OFfSCVe5FXbDN37sNpEZ4MFkxX5
         tN48xqcjMEzuZseRX3QY43Qp1G1x9xHKfqleF0x8qvmLPdxW5wI9JuJPV7z8WJ4CbWJb
         q4tKIL9zxdhyFXHnHP4gZKOfpJd1AZi0PbMGMawwyzoHR+gshZ+2ysX3XApzMhwa/Cui
         XP/X1yAP9yFN7hsfvaxxdeuaT4UHjiWMDREKPBLnqcQ9yglDfvAzM36m9LT8MS1Ilkh1
         TqIw==
X-Forwarded-Encrypted: i=1; AL+hErFeaEnFn9v98sIdJ9BeHvF3XIyfjKmwqBG8gpmrl0IB7NU3b3fyZJzLJ+PEohrPMOZtdEQuh5I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RMMTwVx+4ULjxEZKs6fl4B1zl70g5EFZDUaMRaEsQc7keqgWI
	nZ0B8dM5YdlcbBmbI3b4QiW34bD/J2IXvgytOrmPmE+trgOmlyO/8aEHvVZ9XBEpAT5kagv2uiE
	OoiXtB6I9LqkRFg==
X-Received: from ioi14-n1.prod.google.com ([2002:a05:6602:c64e:10b0:9ca:d7a7:e72f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:518b:b0:4f5:d3bf:edf3 with SMTP id 5614622812f47-57742b303c1mr4468950b6e.59.1795046518039;
 Wed, 18 Nov 2026 16:01:58 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:44 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-3-dmatlack@google.com>
Subject: [PATCH v2 2/8] vfio/pci: Annotate lockless accesses to vdev->sriov_active
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() and WRITE_ONCE() to annotate the read of
vdev->sriov_active in vfio_pci_set_power_state() and the lockless write
that clears it in vfio_pci_core_sriov_configure().

vfio_pci_core_sriov_configure() intentionally clears sriov_active
without holding memory_lock, so the write can race with the read in
vfio_pci_set_power_state() (which runs under memory_lock). The race is
benign: at worst it causes a spurious -EBUSY while the device stays in
D0. Mark the accesses anyway to document the intentional data race and
avoid KCSAN reports.

The write that sets sriov_active is done under memory_lock and is
serialized against the lockless write by device_lock, so it does not
need to be annotated.

Fixes: 40ef3edf151e ("vfio/pci: Use a private flag to prevent power state change with VFs")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4289ec9bc32f..511dcb49d2f6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -329,7 +329,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (state > PCI_D0 && vdev->sriov_active)
+	if (state > PCI_D0 && READ_ONCE(vdev->sriov_active))
 		return -EBUSY;
 
 	if (vdev->needs_pm_restore) {
@@ -2393,7 +2393,7 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 	 * state transition would at most result in an -EBUSY, leaving the
 	 * device in PCI_D0.
 	 */
-	vdev->sriov_active = false;
+	WRITE_ONCE(vdev->sriov_active, false);
 
 	mutex_lock(&vfio_pci_sriov_pfs_mutex);
 	list_del_init(&vdev->sriov_pfs_item);
-- 
2.56.1.708.g77570a6a1d-goog

