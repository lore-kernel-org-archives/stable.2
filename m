Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C54503EF
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582926; cv=none; b=tcUW/ByEKKOmW5OS39JlSoKPQJpnLuppTFw+5FEWK0NENqXzRmm+tPx9iyuV7goO3htf7l1eJWoUICYSw8W391SsxJxFXmHhliXliWsrcMvAvVJ8Z/sYiDy8uf3cOW16XBruKI837Br2M5ruxKrx33PxZlSOEpcb4Dua6U/nYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582926; c=relaxed/simple;
	bh=vc4tVWraCoz0CbNQWRQODMon6/OGvck+5dLnEhy8jUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pg/pi1g55yX5INEm1w7Pgp5zZbUXPj4Zq6BtMz/mcm4grPFkS5sNpIGEQX6kSsUn35/JyNraIKyTWgnT+dzdfImOvj4PRfxQLF/6qwTRPbFk6myDMUXbn0X4cfDNOlrnly7/Nc6SqOSEPLlZEnAIhy6wm0xjGQHnUKkoJqZ5OlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=luGNx0M8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="luGNx0M8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 435B84E41089;
	Mon, 28 Sep 2026 08:08:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16545601BD;
	Mon, 28 Sep 2026 08:08:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 842E0102F1E84;
	Mon, 28 Sep 2026 10:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=X0zB5xt9Jhbn01HLQxanXCNeawIfYRuNFsI9KjMMzWQ=;
	b=luGNx0M8bCby9+sE2M9AGTigy+BYWHu3HBqIB2yBZymiZsOTOMeQVqYrB+eo20BIzYy98s
	Wm4Qe3C6EHcFNwv16OyHfZ24niD3bbIF6ctpksb7GaORLwdQ2hhbVnSppaWuX5l7yF7Roi
	82eu3rYJGCWezNPs6O2rljdavMItLAt7e1ansumf0Upqtrv0touQ1rRcznZimqXUYNR6Ql
	XW0Kl3Wjfovz+S3TJ5F3ST/VyyT43rtFj76dWu4eQzi2Z549t23Wz97dWBvqrAWTpWFver
	FMIpvo4TKkPcFU85vzMz6gG7Z6PRr6vCiVsd/mxS9x+x6f6yH2B5NhN+z1NbYg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: [PATCH 5.10.y v2 0/3] net: preserve skb_end_offset() in
 skb_unclone_keeptruesize()
Date: Mon, 28 Sep 2026 10:08:29 +0200
Message-Id: <20260928-cve-2022-49142-v2-0-227dee37e858@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf8Xs2ZLuphTw5H8YDrQuUqPUtNhIC
 P9uwbPHN5mZt0Dk4DjC6bBA4OSi82MGOh7ADt14Y+GumYEkadmQEjaxyEBCNahIVKUpta6pq1B
 BHr0C9+6zH16gLFAWM7S/PL7Nne20vW3NwcXJh3k3J9z7/yQJhRTS9NzpWllEczbeTw83FtY/o
 V3X9QvZ5DaSyAAAAA==
X-Change-ID: 20260924-cve-2022-49142-75b56682a714
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Marco Elver <elver@google.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Benjamin Robin <benjamin.robin@bootlin.com>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 syzbot <syzkaller@googlegroups.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790582913; l=908;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=vc4tVWraCoz0CbNQWRQODMon6/OGvck+5dLnEhy8jUs=;
 b=3iRF0mpWWLejSjyFDPTCkIj1lhmPnWMm6Nrv0MOBQ94y/jiTHAns2lDT1FzzXdTuToZmIHyE7
 NyehP0O7jWvCN/jRqUOaR0JJcfNmU7djZeeh8VqcgBYK7uBjzvc8uZB
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

I backported two other patches to make the series apply cleanly.

Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
Changes in v2:
- Added Signed-off-by tag
- Link to v1: https://patch.msgid.link/20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com

---
Eric Dumazet (3):
      net: add and use skb_unclone_keeptruesize() helper
      net: add skb_set_end_offset() helper
      net: preserve skb_end_offset() in skb_unclone_keeptruesize()

 include/linux/skbuff.h | 26 ++++++++++++++++++++
 net/core/skbuff.c      | 65 +++++++++++++++++++++++++++++---------------------
 net/ipv4/tcp_output.c  |  6 ++---
 3 files changed, 67 insertions(+), 30 deletions(-)
---
base-commit: 1797d8bf8d0c2e74defad605d14e3553d43a3caf
change-id: 20260924-cve-2022-49142-75b56682a714

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

