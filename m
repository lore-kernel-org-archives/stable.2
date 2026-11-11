Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389117;
	b=xBQF9xQ9b9TcOtWmEmxkxRh30x7a7vqLdPAeXZlQXFmpHRbeA2SQni/jvAf0PzsEYVHg
	 Cm9bKuliqM3GUSDcFI4OFVQt275I1mmSVWGvpWXzYjkCFm/HBJQaXrix6EHew+R12E5rx
	 ZIpHinl3NKDJI4/gzYROz311kgjG9fj/0FKh0WiJGircD9ma0hjXh/O499YmhzT/yG/Hz
	 GBB9qs6NT5ANLdk5xtzyiPH/EDlv8vruIHN/rQg0jkCX5YLwqO9l0JVHLeD3bkiu3Rac+
	 SafIAO/hSCaDIWTUvVyKBidVpFk/msTqC4l92jZeTi7aM7wrxHWT7qHBFMeW0pHpWHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389117;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t72sNJnqelVxW7tMNBYj3QYeSiG1gsHJgNsNyONTGQU=;
	b=iFRXxcUNwJnyEtYTYo6HrnOcrctu17mt3vKG4K+nN0mYAmlmBCLDmMYKHuXcpC0cWFgw
	 j6t5rDCflmvHumD3aefcodmqNRA5mvZNCU7spWgWlHBRNtMs8tJrbO3xqMqBN4A7NcQhi
	 yhX0IoA0cj4ISoSlJJzgKI9jeM6pfNNKCl1vDXzjwtobPp5h27JQ5QwGjbjp2qAxsyDE8
	 UAZwrLOp65cJVYnpUPrINR8F67vT0Vj/ICPvYUPc5lmpSUi2L5SdLWVdcfSOZFPTDr39O
	 3m/Lm8KiYCNsvGYakCrtaW75IGwH53CsvVi5jUB7suOanXtWEwd+aOFj0oZ/XRbJ8nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaeyeong.cc;
	spf=pass smtp.mailfrom=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=VYKYLJoG;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84B60A2614;
	Wed, 11 Nov 2026 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B84B60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaeyeong.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=VYKYLJoG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
	s=protonmail2; t=1794389112; x=1794648312;
	bh=t72sNJnqelVxW7tMNBYj3QYeSiG1gsHJgNsNyONTGQU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VYKYLJoGs3E/auiB0+FO4ZRYLj6Lq2h0dYavcsa0ek+t/6D0dnrIjexZBRbzco+/c
	 mF9etL0kq2xTvQa3yIUojd4LGpAiHNWOkINCjxfwC6nfbf23jx4yX8x/hvoNen7220
	 UIBMkWp+0oZOXcJeVED23mUN4iuWpzbTIaIYmHZ69t3augZ++Ie4UGxSOjBZPHtHLd
	 2VEaLBYtq4ENb5YyG6H469eJ7o9eV9CXuWedVHlTVOUGeC5XN9xqov8EPeuUXXvmXQ
	 kW/kJNMvODwiJRVlyecJnUASJ0WbkMo77I+wor6elw//MvI05hGtTdNFCoeKZBFTnX
	 Phq9z+P073zOQ==
Date: Wed, 11 Nov 2026 09:25:09 +0000
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, linux-rdma@vger.kernel.org
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Shiraz Saleem <shiraz.saleem@intel.com>, Mustafa Ismail <mustafa.ismail@intel.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] RDMA/irdma: publish APBVT entries after hardware setup
Message-ID: <20261111092505.3121847-1-lee@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 2d1eaac3c5fc578784f218339f59e76562d0a354
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

irdma_add_apbvt() inserts a new entry into apbvt_hash_tbl before
sending the CQP command that creates the hardware entry. If the command
fails, the entry is freed without being removed from the hash table. A
later lookup of the same port traverses the freed entry.

Removing the entry on failure is not sufficient because another thread
can find it and increment use_cnt while the CQP command is in progress.

Serialize APBVT additions and publish new entries only after the hardware
command succeeds. Since the allocation no longer runs under apbvt_lock,
use GFP_KERNEL.

The issue was found by static analysis and confirmed with a KASAN
reproducer that forces the CQP failure and retries the same port.

BUG: KASAN: slab-use-after-free in irdma_add_apbvt+0xa0/0x280 [irdma]
Read of size 2 at addr ffff8880092d10d4 by task insmod/72

Call Trace:
 irdma_add_apbvt+0xa0/0x280 [irdma]
 init_module+0x232/0xff0 [irdma_apbvt_repro]
 do_one_initcall+0x13d/0x340

Allocated by task 72:
 irdma_add_apbvt+0xda/0x280 [irdma]
 init_module+0x210/0xff0 [irdma_apbvt_repro]

Freed by task 72:
 kfree+0x155/0x470
 irdma_add_apbvt+0x1e9/0x280 [irdma]
 init_module+0x210/0xff0 [irdma_apbvt_repro]

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitio=
ns")
Cc: stable@vger.kernel.org
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 drivers/infiniband/hw/irdma/cm.c |  1 +
 drivers/infiniband/hw/irdma/cm.h |  3 ++-
 drivers/infiniband/hw/irdma/hw.c | 28 ++++++++++++++++------------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma=
/cm.c
index 91c0e7298283..bc30e465c670 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3281,6 +3281,7 @@ int irdma_setup_cm_core(struct irdma_device *iwdev, u=
8 rdma_ver)
 =09spin_lock_init(&cm_core->ht_lock);
 =09spin_lock_init(&cm_core->listen_list_lock);
 =09spin_lock_init(&cm_core->apbvt_lock);
+=09mutex_init(&cm_core->apbvt_add_mutex);
 =09switch (rdma_ver) {
 =09case IRDMA_GEN_1:
 =09=09cm_core->form_cm_frame =3D irdma_form_uda_cm_frame;
diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma=
/cm.h
index 48ee285cf745..6c5f4335f09d 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -357,7 +357,8 @@ struct irdma_cm_core {
 =09struct workqueue_struct *event_wq;
 =09spinlock_t ht_lock; /* protect CM node (active side) list */
 =09spinlock_t listen_list_lock; /* protect listener list */
-=09spinlock_t apbvt_lock; /*serialize apbvt add/del entries*/
+=09spinlock_t apbvt_lock; /* serialize APBVT entry access */
+=09struct mutex apbvt_add_mutex; /* serialize APBVT hardware adds */
 =09u64 stats_nodes_created;
 =09u64 stats_nodes_destroyed;
 =09u64 stats_listen_created;
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma=
/hw.c
index c345cc654256..23ad18167607 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -2474,29 +2474,33 @@ struct irdma_apbvt_entry *irdma_add_apbvt(struct ir=
dma_device *iwdev, u16 port)
 =09struct irdma_apbvt_entry *entry;
 =09unsigned long flags;
=20
+=09mutex_lock(&cm_core->apbvt_add_mutex);
 =09spin_lock_irqsave(&cm_core->apbvt_lock, flags);
 =09entry =3D irdma_lookup_apbvt_entry(cm_core, port);
-=09if (entry) {
-=09=09spin_unlock_irqrestore(&cm_core->apbvt_lock, flags);
-=09=09return entry;
-=09}
+=09spin_unlock_irqrestore(&cm_core->apbvt_lock, flags);
+=09if (entry)
+=09=09goto out;
=20
-=09entry =3D kzalloc_obj(*entry, GFP_ATOMIC);
-=09if (!entry) {
-=09=09spin_unlock_irqrestore(&cm_core->apbvt_lock, flags);
-=09=09return NULL;
-=09}
+=09entry =3D kzalloc_obj(*entry, GFP_KERNEL);
+=09if (!entry)
+=09=09goto out;
=20
 =09entry->port =3D port;
 =09entry->use_cnt =3D 1;
-=09hash_add(cm_core->apbvt_hash_tbl, &entry->hlist, entry->port);
-=09spin_unlock_irqrestore(&cm_core->apbvt_lock, flags);
=20
 =09if (irdma_cqp_manage_apbvt_cmd(iwdev, port, true)) {
 =09=09kfree(entry);
-=09=09return NULL;
+=09=09entry =3D NULL;
+=09=09goto out;
 =09}
=20
+=09spin_lock_irqsave(&cm_core->apbvt_lock, flags);
+=09hash_add(cm_core->apbvt_hash_tbl, &entry->hlist, entry->port);
+=09spin_unlock_irqrestore(&cm_core->apbvt_lock, flags);
+
+out:
+=09mutex_unlock(&cm_core->apbvt_add_mutex);
+
 =09return entry;
 }
=20
--=20
2.43.0


