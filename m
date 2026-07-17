Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B8146D5A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247885; cv=none; b=DOmMxcHC/ytHiF/3B/NdE933ge/oyuUqDqglSGCyO5S05H0vMJSiDOzAnsXDyf204OIX/XT5VHnIxjqy6qqRJSJ0+gl58bdxG9yAxHQ0ui9CuKDauCs/o1l8BXqFYJhw8EACKFrryfWNlrtXp5TclxMJb7CZhBX+WQJnORf/Jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247885; c=relaxed/simple;
	bh=cdCr0MkoZXXDY6+4oOu7E8hYSXKiQaFOn3x7nj2N1lU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IiLcBTXBwSTbrSxj1i9bIm2PCSgBoJ+ZE2HdgPQTWUTngVQgFU5ZAVNVbVPXMnb8rzT46Hw7y8YiyBHzy7L2jta5uAJkh0UPEU+O/K5yJ8FIvdfptLlNM6ZMRanKtZEbkqGkdn74oR5bsu4T4qaWcb/tpMu8btyBcrd+Tbhp1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQPutjqN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQPutjqN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8894570b58so2920474a12.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784247882; x=1784852682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YNf9hW6w/Xci92rbeL0bZAjWiyrFwINX6SeGZd4Qiuk=;
        b=BQPutjqN+lnz8HRsfdbD/dAB15x5zU+yJ8GP1bDM4xcjdfZ7kzMpvw9B2Aknyni9n6
         WVotBCNcasIjLvBmwC/nN7cXcd5QPpSasWFgCXDAP3npSSK/x72Wt2uQC/8AsUT6/vrR
         1343UUN9F4Ibom7cgol2iVr3HNUvXqaqhQCa+yY6CYeRqArg0z1yOZnbbtmoXycN2hH2
         AGdlTRw+PIcRcAoY7QVUvU5c4B3tX6Cn5oA2In44vq7W/YHtoazEfY1xO4lbYW6NaeXt
         EtRSeY8L0n3qi8qPnHCnVP/Imh2hH7LEYQdg+vddNMCW6sCvYkuyA2gfOtILdqcpIkf6
         qYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247882; x=1784852682;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YNf9hW6w/Xci92rbeL0bZAjWiyrFwINX6SeGZd4Qiuk=;
        b=rXnEr/reYYWYeQFpgYTKBtEO44sQZbOAS/4YmRxLD+4tBB56dnlKRNmtspY+tCDIdi
         /h6yo9WPfRpKsgvrZPkulIhls+cafh4EfnNb3tBEQEwqCNP1vCM33yNF+/Vdl1b15NxF
         So3dVePZfgowKSNNFy8TBX1mt5OTZjZHelTNUKyaaC5O3uMYKdGPF23c3Dt+3wPPo5Hp
         AmlWp7N4gzS6sC4j9LzS+UvJ3nf4oFK1tCS0qxPaNFzgpsBl/R/4MFVqSJs5/oCq1fOz
         qvyL9J6YRCi5EhaiV7U0l0SZiR4vKpwN8/w681FTPcNDdyKEwoeU8BzwlJ6BfjYX1xUD
         pB9w==
X-Forwarded-Encrypted: i=1; AHgh+RrEGaTjH/ZXGU9ZiYoLtwNgZzrYc7H2VzcmhkkI0pmqMcYSfZzKPtGmBHgU50oCl+zjfALy+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmhI1SyNdqkjVNQEvjpc0Pg401k+9cMKKEsRrBqYp9MXtJ/Vu
	23r0Q+vaHJ6nFwaSoBrfuX5YX44BMO4lptNtx45murg0T0CJBYLjIaDSeB2/LjQ9jqVJyKwlKgX
	XbA==
X-Received: from pgbfe6.prod.google.com ([2002:a05:6a02:2886:b0:c85:6deb:ee45])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d4c:b0:3bf:b0b8:58b5
 with SMTP id adf61e73a8af0-3c3ada18310mr197568637.36.1784247881450; Thu, 16
 Jul 2026 17:24:41 -0700 (PDT)
Date: Fri, 17 Jul 2026 00:22:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717002311.681748-1-linkl@google.com>
Subject: [PATCH v2 0/2] virtio_balloon: fix Use-After-Free bugs during PM freeze
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series addresses a class of Use-After-Free vulnerabilities
in the virtio_balloon driver that can occur during system power management
freeze (e.g., suspend or hibernation).

The core issue is a lifecycle mismatch: when the system enters freeze,
virtballoon_freeze() resets the virtio device and deletes its virtqueues.
However, several asynchronous or event-driven components of the driver and
related subsystems (Free Page Reporting and Shrinker) remain registered
and active. If they trigger during the freeze/suspend process, they
attempt to access the now-deleted virtqueues, causing kernel crashes
(General Protection Faults or UAF).

To fix this:
1. Migrate Free Page Reporting to use the system_freezable_wq, ensuring
   its worker is frozen before driver freeze callbacks run. (Suggested
   by David Hildenbrand).
2. Avoid shrinker execution while the device is suspended by adding a
   suspended flag to struct virtio_balloon. Wrap lockless reads of this
   flag in READ_ONCE() and writes in WRITE_ONCE() to prevent data races and
   KCSAN warnings.

Note: The OOM notifier (virtio_balloon_oom_notify) is also registered, but
since the PM core disables the OOM killer (via oom_killer_disable()) during
freeze_processes() before device drivers are frozen, it cannot trigger
while the device is frozen. Thus, it does not require a fix.

Testing:
I have verified these fixes using Google=E2=80=99s virtualization infrastru=
cture by
running continuous suspend/resume iterations (40+ cycles) while=20
churning memory using stress-ng (stress-ng --vm 4 --vm-bytes 60% --timeout =
1)
to constantly create free pages for the buddy allocator. We also set the
page_reporting_order parameter to 0 to make the page reporting worker
highly sensitive, forcing it to pick up any 4K free pages. This=20
confirmed that the UAF crashes are no longer reproducible.

RFC: https://lore.kernel.org/r/20260709224330.946683-1-linkl@google.com
---
RFC -> v2:
- Switched page reporting fix from unregister/re-register in driver to
  using system_freezable_wq in mm/page_reporting.c, which avoids complex
  restore rollback logic for that component.
- Switched shrinker fix from unregister/re-register to using a simple
  suspended boolean flag to avoid complex rollback logic. Wrap its reads
  and writes with READ_ONCE()/WRITE_ONCE() to prevent KCSAN data race
  warnings.
- Dropped OOM notifier fix since it's already protected by the PM core's
  oom_killer_disable().

Link Lin (2):
  mm/page_reporting: use system_freezable_wq to fix UAF during suspend
  virtio_balloon: avoid shrinker execution during PM suspend

 drivers/virtio/virtio_balloon.c | 49 +++++++++++++++++++++++++++------
 mm/page_reporting.c             |  6 ++--
 2 files changed, 45 insertions(+), 10 deletions(-)
--=20
2.55.0.229.g6434b31f56-goog

