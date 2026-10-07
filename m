Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7834041C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408461; cv=none; b=DXFQUxy4LeM0a1vLnyzgocHbsXJjmRxwh2B4LrZp4Ev9/R1AUM/HTQhneeci9CmtESp6TP7lnS6cs1Onp990E6snoLJYD9F7FtdnZvV4J7fLj939pO8EEHoLbn9IzF1VGGe8dNl0lcyqckdEXafR5YlGEfVMn3TSgfJbzEjntzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408461; c=relaxed/simple;
	bh=a5rLoGhEHqlxmRZ/JOfMOOp0jB6HErznintsx8K7+PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sED4BUuVXX52WX3JjZBcxATPooW9haYEdCRjmOzJS/TjdWz/JJ/+VJFhqVR2GPLjoU66e4ZDubZPsAyBeTHl8h4FPyTruurdLqewMwNX1LTtUovginkHGOSdD4leKvAi/V/wjk2xSL+IHvG2T1WKoUpiIeALAokRl5YAzWmnYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmamRnqW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmamRnqW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so20705135e9.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791408459; x=1792013259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Co0U3IIGvGBciCjtD7Ot3o1hC8jdmJVyR340U2yvkE4=;
        b=hmamRnqWbH8+KVCerjdFjFuO6DXdncC0AfbGh5HemT+3VQzMC0ir9nwOpD/0X1SSqp
         y3kEXWZp54HZKNLlzEds/ayMEAResmmftTYAmMMsdYmHV1jJuQ1Z/bf+n1YnTnoPytOU
         85ou+9F4WbGOavKGqPzSX+4thJ77B+uC3gfQhBgjiMqs720r9/woU2+7YQbzyr8uZk/p
         RCBwtvvvnJRjDauEztXJVXzx1+YdDQhTxHVZ0/uqRh9YdZ69Oz8vaIgfrdJLif9u6qyw
         OFSWBLlO0QdLM3KE2gs6ZVRKixRGQXv0i0PvrBs4yD0OjCpZyvRM9aWpipH+EIUHvQ8U
         7+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408459; x=1792013259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Co0U3IIGvGBciCjtD7Ot3o1hC8jdmJVyR340U2yvkE4=;
        b=vwKSqV/BvudjGyoduvj16YNdnlr6znsQl/UGtZ2EthwVJmOYXPP4Urhd5fCPGt4vjS
         jUb/v8Mz8pSIRudOE5WENRupEdG5L3RoyKcnp6DDmGsKf0v0Z62jcP4QF3wcN9gKuRfN
         7AO04p/pwwiS/oOF8mVNNj6cKXYWbnYy2b9EwS4Cs4Z9d0tce9nRO8ypo48mes5OI+Kt
         wdm9OmqXsdTRON6xjnHZ7z53o6WxEqZSz0jE/nLLBIJQSDRipQIeh69p3UYRgdi24GT/
         t0c5v+7BAQCxQfzEckbW95fZRe/ICoPzyRjQjK/DjEZg5Y91ffxawRgZT25JR2lo2N9I
         byJw==
X-Forwarded-Encrypted: i=1; AKwUvBzrbPj1iEhOKgC0EWEe6pvByrwb2XdSZYdeviNs6CALInNkB/Y3gmMF2KPZYEpXlcASrPXgLFw=@vger.kernel.org
X-Gm-Message-State: AFuF++lcKexN2A3NE+79qwgv85+ORp/Hy9P8mI1ZmnS3nP9MRKVXXz+W
	6ub7ONG2vpykXG6WtJ5xybjHJzP7khVKMfVcIfjHMuCoYj26gscdLQs=
X-Gm-Gg: AYBFou1nD1gAD3R+m69ut1igPwQ7ltOflyytJ9f71kDzDgC+8ei6RpwOihNkpQlUBR+
	NA+6AOmq4dfmJNGeXdGbSViWd6e9/HoHHJx/vLor1HW8ytkXkh2mtbC2DpRRfUk/zMFkdq8w8g1
	B3v3DDCJEmNxi38WJNvo0A+RHV5en/rLWNwK63LlPMaWg1y8YVtzmLJtn1thfx8pP4GcHtv+TLO
	jK3u2uA4TZaJkRroKl6KOX6Tfc1z8pI0PouPh49ESztXLG9UrRskdLEWBJVKMvrdG2a5IShgqn1
	ZN8EOvqFgKBYkMzek4IFb7rGBF8RJJN67m1Al1vF/VliEvyd2vlte7A+rEu11LcRP7bLNmNZuWd
	YACvrkmDEUj0UXSxpdBMhpDnRydmiilV6m49Fx76Ep+JVSYu2ITRgqyr7+AmHZcKlhLwtaPnI2f
	lQzzjnay5yXCaiepgpiFFOpPhZV9WvI3mBDvlkxYo=
X-Received: by 2002:a05:600c:540f:b0:49e:6249:268b with SMTP id 5b1f17b1804b1-4a180648fe6mr64635805e9.32.1791408458681;
        Wed, 07 Oct 2026 14:27:38 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843cb261sm20466395e9.3.2026.10.07.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:27:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Moni Shoua <monis@mellanox.com>,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] RDMA/rxe: Fix TOCTOU races on mmap'd send queue
Date: Wed,  7 Oct 2026 21:27:35 +0000
Message-ID: <20261007212737.1989004-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The rxe driver maps the send queue into userspace via mmap. Both the
requester and completer process Work Queue Entries (WQEs) directly from
this shared buffer without first copying them to kernel memory. This
allows userspace to modify WQE fields concurrently, causing inconsistent
state in the kernel.

This series fixes both paths:
  - Patch 1/2: requester (rxe_req.c) - copy WQE before processing,
    with WRITE_ONCE per-field writeback
  - Patch 2/2: completer (rxe_comp.c) - same treatment, with reuse
    across multi-packet operations to preserve DMA progress

This is the send-path counterpart to the receive-path fixes:
  - commit 22b8fbded65b8 ("RDMA/rxe: Fix TOCTOU heap overflow in
    get_srq_wqe")
  - commit d6ab440240a04 ("RDMA/rxe: Copy WQE to local buffer in
    non-SRQ receive path")

Changes since v2:
  - Replaced bulk memcpy() writeback with targeted WRITE_ONCE() for
    individual fields and smp_store_release() for state transitions,
    avoiding the tearing risk of bulk memcpy on the shared queue
  - Added smp_load_acquire() in the completer to pair with the
    requester's smp_store_release() for state ordering

Changes since v1:
  - Same as v2 changes (v2 only covered patch 2/2)

Tristan Madani (2):
  RDMA/rxe: copy send WQE to kernel buffer before processing
  RDMA/rxe: copy send WQE to kernel buffer in completer path

 drivers/infiniband/sw/rxe/rxe_comp.c  | 58 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_req.c   | 61 +++++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 12 ++++++
 3 files changed, 119 insertions(+), 12 deletions(-)

-- 
2.39.5
