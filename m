Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC370D61
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029141; cv=none; b=Lo2UROcbXP1E7S58BP0FfvFeZQ6i9RlmmDrNRCQut6Z0UvsStbMHYdnFg6RtSSYNsnCxgIue0CDpQLDiP4PaWB/HY48FkwMfer6Z2AqshkgUewyj6/25RxTAQxIiA0GEmgHGiH2PpbKssqypnWKp4PD7EGUZSmRzRDYdV52LpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029141; c=relaxed/simple;
	bh=KP2iHaL/44s57MvPvmwfua7vwBb/vSPDJ59vz0bCga0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EwFzG8KSRFF2Tq5z1sY7uOdrLT0O+jeBqRAGVqoUUwKgARfCqko5IEk3xErG+iqmSeZuQNIg1vSLCf56LeA+yaUy3aZ8hEE1KsaWczJQfFdHWDGdR2P39VW474zqZb4hxoDSZb6gSSSPFaEvgjEyAktjsOWfIwFc9KnBHUw4SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm934V+C; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm934V+C"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so4553066eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792029139; x=1792633939; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=glf3wPsStHsKi3TlEqw1dZgM8u514rgSxUDeGdh5Ugc=;
        b=qm934V+CtW9rd/Y9vMifc/pQ2hKkxJeV9wtiqMHuf+loPeUvpwTemCYSeSZbZaUz6t
         ml6le4ZR/CW+uX2hFPxPFHzYJKPA6dtKb7vhgxT68b9fe8Osnkrf1Hrpo2ial8UlHoX7
         Qd7p3JFSCzy7RCacnjBLscaZd30f0+exR5rL+srhw45X6Q3HyOiF0GCwtZFhr/YFtRnu
         2kEEhpQVpgHorAbW6jA4BAYG6rHjz3R/4iIa4xyGSIrubfVFjE3sXUbfL8KXICuX0g+w
         Mn2Air1qC6BNOON7XvOpbrwJ07k8BlCEDNUYFtcL/PvIkKpXB3Rf22/VMZpDcKwiduI8
         Rbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029139; x=1792633939;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=glf3wPsStHsKi3TlEqw1dZgM8u514rgSxUDeGdh5Ugc=;
        b=s5KbVVBNt/+0WZLKH8ehKlgseOAtkaux8oyORJ4CvVy81V+LiYr8GayhhRu4KLzpbb
         ribp/quDq/tTLRELTVDhMx4GNTGgMrNWf+6F3FvCitWDAW3f/KvFz1z1tfEicx73MkC8
         SVcFVtxVn0EoF4kp8W9EwIcABuncPhXI3Psa+OhYuZTXzk8uq6YvOkFOkAedgEAlEEB/
         S3IhYL7lVxR90pHyNgATbw2/ByG6ikzcQndoIg57xatNoKel7+qdbaLg7507C7t6/owb
         pogj4ZH1VuNpEJgoDMeLspvkyJ7002wv+cz4KCdLYWK/4zIWoFmjC+D2XllCHYO8lGTJ
         hboQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9kH+P3p7e0oOgdVa78NcKH6Yx9IcymhsOD7PEEU6+2QpvIhY81gtIyhDh13vkU+KF5AQY33E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwH4pH/34VzBT/P4H6JsNxZQ8Hm52Wgxw3m/qYlw1nZFGUvPhZ
	I6IGjdDOzxUk8A3bqA9DPsRWichaUOyZ//vKaIyWM1xD9ZbeDR0D3DG1
X-Gm-Gg: AYBFou0BKliXDooTy74PQwhfyw7Oif085MgALj7EewXyiRT2H1z/uP3yYzCfmtA3mGf
	5D/uqz5iwCm9m4u/HsTF2MQP2l0b27GKGgqwdtQjxPAo691S5ITAKPprXi5IHWSeLtCEGbYFj4f
	HNjhUXau/kDyXbzRXbXPNydbPWTbUg39UxIAdFZ/Wu5VJ5oVz0uVVcYIij0ON6xwIQ+RlYW1sro
	3DjlOaVgBKrjo2xoO8ih6JJnsBJpPQBKEu+JnR6jvDPl3FKYnPx4vpxNGzt2eCExffIWOzQXpCI
	wy74lOWgEvl5AcNle7aIke/wjxGv7w06JkBo7scFT8wdeDvhMmMMQVKZPzK3xPV9xkVPf7vhI48
	ZC7P11BCAmqwrMffy88adj8BNb57ipi4thLL4CPjKOidX/eiURKwMSV73Orq7wPNyouzLP+zS13
	WjFzSvud/roRAfwkxfH5UCtAzuTFsdLPXKthSSBzFXlbmvjel2pKHyqIa8iUcu+4pyTddGFzLC8
	bDy
X-Received: by 2002:a05:7022:150e:b0:163:bee9:b250 with SMTP id a92af1059eb24-16a5ef287c9mr26663841c88.22.1792029138518;
        Wed, 14 Oct 2026 18:52:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm50647870c88.2.2026.10.14.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:52:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] block: skip quiescing the queue for the default
 elevator
Date: Thu, 15 Oct 2026 09:52:14 +0800
Message-Id: <20261015-bug-block-elevator-init-quiesce-v2-0-505a2b0b1c07@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4x0GoC/4WNQQ6CMBBFr0K6dkxbLIor72FYtGWAidBqC42Gc
 HcrF3D5fvLfW1nEQBjZtVhZwESRvMsgDwWzg3Y9ArWZmeSy4nXJwSw9mNHbB+CISc8+ADma4bV
 kjUUoVXsuu9qcKtmybHkG7Oi9F+5N5oFi/nz2YBK/dXcLzsVfdxIgQNmL6jRHq2pz6ydN49H6i
 TXbtn0BVfHvPc4AAAA=
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Setting the default elevator of a new disk quiesces the queue, so every
disk added with a default elevator waits for an RCU grace period. Patch
1 skips the quiesce there, which brings START_DEV of a single-queue ublk
device from 7.74ms to 0.68ms at p50. Patch 2 renames a misleading label
in elevator_switch().

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add Reviewed-by from Ming Lei and Nilay Shroff to patch 1.
- Rename out_unfreeze to out_unquiesce in a separate patch 2 (Nilay).
- Rebase onto for-7.4/block.

v1: https://lore.kernel.org/r/20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com

---
Qiliang Yuan (2):
      block: don't quiesce the queue when setting the default elevator
      block: rename the out_unfreeze label in elevator_switch()

 block/elevator.c | 11 +++++++----
 block/elevator.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: 0f6b042f9a13968c4cd6cde1a70a7b242009ef46
change-id: 20260930-bug-block-elevator-init-quiesce-35d73f9b462d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

