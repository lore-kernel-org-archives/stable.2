Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48804B53FD;
	Thu, 24 Sep 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281386; cv=none; b=ky/tEHZdqPaRTOW2GpWtmvSQaiov77kAe627uHIbTkApRU/KSCtPz/j/phr8ecDNmiAo1RXMJjROALQEcYSx33rsUpKfRD5v9G3Eml9YgiT2qOPPivuKCJfVA2WuKYJTqaECs0hOab6q1H1qJkD+j4Xe5usSZ/u4AHwCxVZtDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281386; c=relaxed/simple;
	bh=DG4/JC2yQl/yudwx9CEAJ2szViywAi4MSaaVut8TaYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ghhvZXevEgCN9MwkdJIwbrgl/naNxawytdXNI4yWBvYgbNK85XRDeh5i59lgbxUl9lb8J+nx2ozJnwPFA4d079/pMcJ08sc2hJmZ6aMEK3eumg74qYJ9eKpIhjbupgTryXjByxam45XQWnNMK0Opze7olYyI1Q6ywl5YXscq0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dbxuM/N4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dbxuM/N4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC4A91A1007;
	Thu, 24 Sep 2026 20:23:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 97AB560738;
	Thu, 24 Sep 2026 20:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3AC9103290CA;
	Thu, 24 Sep 2026 22:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790281378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fa6Gg0qJE+U990tz2t717JRwoVprlww61vWO4kxSzRs=;
	b=dbxuM/N4ejppQ/Bcgc8rcjUe86thO4T7WnlKalC0oxnkHCGbNeHxI+cqM1l1zQl9soHQJ2
	tyjAZcM/xMEFHRTjCLu2aOtyYsRZ+M8/KgV8XkNVc9ys4VGQRS9GUUTFItPjGSfT8CTd8L
	U6Md75rSqM9mvYIONUAZIqfXnxmr+LTnI0Gv0E7RKteh8SBY3lNTh/HRbJb7HR4aDyVc+s
	arnpijUZOoWrrfIv0Re4Rq5LaZL8lp7HFyVDd+AprOf/EtMBGQkcO/HawRjLHRSPF0SztQ
	Tcu2Xa1Fw2mvDgs2QRW9BTQFx3sT+zVuuwvZqLFLjGYnKbgOzgAPm84JKCISrw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: [PATCH 5.10.y 0/3] net: preserve skb_end_offset() in
 skb_unclone_keeptruesize()
Date: Thu, 24 Sep 2026 22:22:41 +0200
Message-Id: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJu2mL+CrGA5RV1wOQVomG8
 O5WOX6TzL8iS1LJOFUrkiyadRoL7KFCvHfjTUiHYrDhYFp2FBehAibXWsfU+N6HcOSusQ7lNCe
 56vsfPMPX1tQfXPY9v/qHxOevhm37AsDQDDR6AAAA
X-Change-ID: 20260924-cve-2022-49142-75b56682a714
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Marco Elver <elver@google.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Benjamin Robin <benjamin.robin@bootlin.com>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 syzbot <syzkaller@googlegroups.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790281368; l=764;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=DG4/JC2yQl/yudwx9CEAJ2szViywAi4MSaaVut8TaYM=;
 b=k8cYsXhFHaztfJXdSGgzE6f02bFM2G30xJRtO+OEG5/kYQIeNQ8IoOWrZX79UyYryH/2nQqV+
 bzViCY5wqmWDqk6MkAsU2PgpuAKzed3NaGGTaVdJPbsEB0Gr3nmIiCm
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

I backported two other patches to make the series apply cleanly.

Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
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

