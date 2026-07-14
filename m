Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775A37E5F3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064034; cv=pass; b=IbeIin3on2sVWRGvey20yHFANS1mgVTnoEPVKaCKWAyR0WftaKBVhYtlhu7UiUTUup5GGQnnuKo7q6JiEj76uelEZ1xT/dvZ3efX1aF7iATJdDD79wdGu65hghPnJdKxqPrqEPKe2MqRYZcbSP12fqt3yOcBpdA3ssLWkAN1A0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064034; c=relaxed/simple;
	bh=hddCSl8K5yEbYW+RhdQ4nffsoSSo6DwUp+GcNtpnl7k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kTJPCPf1z/s+1oyN62k9LuKkIzx4vhnuOsi0yqRDUCf0gfbCfMY3HOrOvev7U3uwgZA4VSsaRVkI4Z+We8SE80/onpi+jwaMgD/z11Z5SoTiSalZWHDp2tEB3EpA6jTrV/GDfYZQJIzbpzbw/t3MXMKIWAYLfxawVBEVwaokNt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOJQqa1H; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOJQqa1H"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso2922579a12.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784064032; cv=none;
        d=google.com; s=arc-20260327;
        b=hpMoJzfw2/K0fAWeNrfZPxATA4BQTalwQW638QXwZbVxJAfcsgroBx3pPEb7D+KVj3
         mDW9VOcr47RQq+0M47bhi0elI9QTSZ/RXqXKXr2akvtgNbcCM8cdKSniHFzxVXmwXPDL
         YAjmr5vi/eZCEHk/xibzaDTwVqFUOIuFmh1GkVrg5h7XLNAJ+LbeYRBYPmTVmjAXHA17
         ENOVrB3DUFgfq+bAHo7iqSBUxIntxj6HriUGAP+kvJKrpJniulE1rGy1Y576v6vLgRS7
         4QpMNh0rxUlL+xz/+94mf2QJuzmmZVMQAhuVbrJ4scXxga8QK+JOkMxvIAe4rIPGMbmn
         mJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nVWtztErcXTCFQc7KRT5oZ+Lc/OFVJJ7HabIUDmfN1M=;
        fh=Lo0wYNsoVChOlHJtZO4g2Kd1kbo+0tPstRrC4d/jnNs=;
        b=HjWHutHgWAS8eTKz9hivRRbJvgv5GDO7lOwiARj2NkiimzNwYL5QAg7qMW2t8gBKJf
         bUQ7Dwv2q6VlL2p3gSrhXxYT5ZNDoqww+niVRijUw3h7qF1Qo95yMpFYhRoQe+yEWoZr
         1U0SAaWl8w17TGTVh0mSovAk04wNUPt741wcfU/QSeb0ZquSgDkqtzOH1g09D+ko1ml+
         0hnC8a2/yfKo9L+SKqMZ+h3maP3UtRuGH1q5oZ6nIoi+SnXRgqmbL2GRxZCoVNCRKr0S
         gIpgp8oKyvwkKq4sSx/1p+A0pMs7fUtMq6z1SdhcVDQeFCVg+7hicx+ZgaykjMEoPfsT
         4AUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784064032; x=1784668832; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nVWtztErcXTCFQc7KRT5oZ+Lc/OFVJJ7HabIUDmfN1M=;
        b=eOJQqa1HW3C3E0qUlwJmgLD0HVIeVxCj+4ITpFXOS0Y5Gt9uhtCYoK5VzRcEq+RAgE
         KRwbZfH/nZrQdjbHm4Qb2RU/8e5xHYiMiMj6JfjRZvEl5JLKho+ngu2g2crKsXi047wo
         pmUmFFsDUNX6lXX6KTBG/dZPWcc+n52XEjolyz7cKnSQOGjgjUN/cRcciuwiNo2KmnMJ
         /OedpYT1dzqE+E+gRwjbbTxqbSp3uDUdbn0mA/XX2KgFiEp2GNd8mcHaozr/fsTXCIUh
         tvjbukEh1aYx92njDEHNR0qg1m32Q1MOv7g531Q5TWoAGJJMK5y6CNstqUAVJthM2451
         Z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064032; x=1784668832;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nVWtztErcXTCFQc7KRT5oZ+Lc/OFVJJ7HabIUDmfN1M=;
        b=F39LF8m1/Mp5WayQrnHicMEow0+iVLCebZicg11ZRpOR4FKpKQvQ4v3RpKns2RKfsa
         lK+BDvuBB9A4G5ctEYI7QfKb0WC/8LNmAhkjXbhHfOgDcnaFgb/8DEii7hfGYRhIZDo0
         KxylXnWpD8uD2KFfcHGSZ0il0UmmPMqUti/SGPcv6ImHAHQ27lGnHPFbxSXLwOE4JrEB
         LC2mt8rbJIjn/Aaahq9I4KC9ZddUH9C778Co0M1pR6oN/DTQ6jjRUAHaJdDvj4pxolom
         fxoBNJnWiAYEV5Pa7ufGKPP7s9oK39faOK6J01ZNbPcw2N4yZPwsQEfUSKo6MGc8YXVP
         C2GQ==
X-Gm-Message-State: AOJu0YxZ5eskDZpXPRRY34kfiwi8kMJh6g4fOFMGOjEkyo4HqM0jZzif
	vOfO4HA7wFg6u16wFvmq109bujxIoxZjGZm/vO8fqok4ifpBdzcrLTJHwKNQSP4xNuF3nnFC+5P
	fphoRo96nmJSjvDKItMP2fmSlZ22a7YlhYHrw
X-Gm-Gg: AfdE7clfK5jE5zYiO9cKjqRFfXgIzAPCnMAPlGEIi6m4P3oD/3gYggX8DM2JIKBOkIj
	he4cDzbU/cGdrPvZIbSYcIeurV3rX0fAnYCP3F8LJuEy6S8Qw+eIjGM7yzPmLJYTnwX9i5Ql9jK
	vjjDEAl4XPDL8PLvENmRMz7uKnZC8e4YpFKdeyR8YUYs/7x7PSQclAfMzXTYTjx5y4L4ezTO8Qx
	IiXO3pqKxK9800VOk84JOrS2xE4cQmrI6tfUGXWrdh/jDi6OKFlucB/DUvKtiT3EBuk4OcNALBw
	1bmkFdHt
X-Received: by 2002:a05:6402:a502:10b0:69e:1294:36dd with SMTP id
 4fb4d7f45d1cf-69e129439a1mr400580a12.0.1784064031479; Tue, 14 Jul 2026
 14:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chao S <coshi036@gmail.com>
Date: Tue, 14 Jul 2026 17:20:19 -0400
X-Gm-Features: AUfX_mwdXHC84lIfayW2825hY9WbzW5Zgx0wfAfISp3WrzfX02KOKLazvoNoLsU
Message-ID: <CACd_6n3dExLLL8fziY0ha+nDupfb+q45VCbjA7aAYNnj-YkY8g@mail.gmail.com>
Subject: Please backport 49f06cff50a4 ("block: skip sync_blockdev() on
 surprise removal in bdev_mark_dead()") to 6.6.y, 6.12.y, 6.18.y
To: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

Please consider the following mainline commit for the stable trees:

  commit 49f06cff50a4ccf3b7a1a662ceb892b3b21a527a
  Author: Chao Shi <coshi036@gmail.com>
  "block: skip sync_blockdev() on surprise removal in bdev_mark_dead()"

Why it should be applied:
On surprise removal (@surprise == true) the device is already gone, but the
bare block-device path in bdev_mark_dead() (no ->mark_dead holder op) calls
sync_blockdev() unconditionally. It can then hang forever in
folio_wait_writeback() waiting on writeback that can never complete. We hit
this via nvme_reset_work()'s "I/O queues lost" path
(nvme_mark_namespaces_dead -> blk_mark_disk_dead -> bdev_mark_dead(bdev, true)),
which wedges the reset worker and every task serialized behind it -- an
unrecoverable hung-task/DoS (multiple tasks blocked >120s, reproduced several
times under fuzzing). The fix simply skips the futile sync on surprise removal,
matching fs_bdev_mark_dead(); invalidate_bdev() still runs and orderly removal
is unchanged.

Affected versions:
  Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
which first shipped in v6.6 (it dropped the pre-existing !surprise guard from
the bare-bdev path). So the bug is present in v6.6 through the fix.
v7.0+ already
carries the fix, and pre-6.6 trees still have the original guard, so
this is only
needed for the 6.6.y, 6.12.y and 6.18.y stable trees.

The change is a self-contained one-line guard (plus a comment) in
bdev_mark_dead()
and should cherry-pick cleanly onto all three; happy to send adjusted backports
if any tree conflicts.

Thanks,
Chao Shi
