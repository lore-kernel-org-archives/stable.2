Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436022;
	b=1CrEk/CE+V6p9U6RsSj80ONUKoMcUCRSCnfCXwe/fAmL95El118423IP9HPZjr0wmdGZ
	 FuZPT76eON/3mCIAGIE6kkDFPzpePHNSK1BEQZ/168MvvrYfu6LNxHWxoEa00chyA2D9H
	 zvFSk17qJK9aHr9isGBcCxHch4lzJs74fQgkp19N6SPoGY+PXDLk3JTkJ5Hqwz2vaa8Q6
	 BCnkqqqW00SseqqHmSqlT1L6uAbivv+Bn8Zxb9dNKhPga7CYFAOBKTZod32sjA3VK9+qH
	 /lc2jJy3dknu6onVWrs07GVV/TfGt8cBdUxuTaprl7nUT3OWHKZjPaUq2KyCBShQG+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uZh81Patjg5SXBTd35jRhp7Z8jCjOHuf1P6cwMNCRTo=;
	b=E2SNXhPdSlrz7w23+DF8f8jZtmL8AoV46B0WxC5wxbiJEjuCqJud/bga6ceKZGyLo+l3
	 SM4YMwosLENb71iDKH/4bwrMi/AT/m7PHrPj0yrL9MxBVSDFf7kfsDVMiKZ8mCHQslzRm
	 TQbky0OVDAwr9UbclTEmEwYVB57mtAdkak+yG7J4PeS3M5JboDpoOm9gLllHtCpWA/Ggr
	 XrhQQphz5ANr1xoyw7+1TYTWIQrbpJ+JSUt3M/0T6Gzt5onxQnpj/B0hLvG8xX6L3zyFD
	 QkX/TyFsCxixXjIzOfGrlbWL3TInT+Q8qE4+UqKI5pchE1zm6zS4wzdRectGapgllzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQ8uRzpp;
	arc=none smtp.remote-ip=74.125.231.73
Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2A606A32C
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A2A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQ8uRzpp
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-47bd4bcc3e2so1256466fac.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795436021; x=1796040821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZh81Patjg5SXBTd35jRhp7Z8jCjOHuf1P6cwMNCRTo=;
        b=GQ8uRzppCrSAFj/ldXPJN9BOk6XTK11npre3CPqjqxUgfrTJ7bXESlWjA0Do4oOC2X
         jBFq36MStqMpQ14eg3YmnN5Q+s0VQKsJSPsE8HR/LFIMXy9ztBSztLC/LUx73FuPfk0u
         1IY8ZtqzeXWt8DqHwm0px+gkjtQfNgjKQVFzt7uJLo94dZJxXLo8IhubauZfFhYtulK2
         P7kZ5ZGJyxHZab3/GJ+dKUnBy3Wq5i7lqHOen33RODD03/Vu2c5OK3frDRWHrYSVEt0+
         2U/eFWqu9dfv1n4dOxqFqiZZ2boqUkI5aXafVvUok2o/HjJcw5h05Yejeq3s1Nd4Svvw
         4I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795436021; x=1796040821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZh81Patjg5SXBTd35jRhp7Z8jCjOHuf1P6cwMNCRTo=;
        b=OXnSlftc7lJY04MRADgGW8g/9uFQoMcFYioz36U7ucL69vUDsEgF4Qo+YC5YavheyS
         uhFerl45UXm/KoOvDlV0QWnDSyZqSqp2eIQQGHILydOkorH/SDUIZE5ENmPJxX76DRwe
         Ujr6UvaVS/XrgQYZKN9qwZI5pIPHJxbHa/xYtaZS07L+L73xgXLcY38Saj4dh4PC+5fP
         EytLKgdKmG/oNfExFz2atquQIxwSHbkQXk2bUGGr9BDhMlLt0TYvYzqhEhsQzjiFp9eJ
         8qWHCbwwXTo0sZALHygt8oJ9Et0JC0jsd6g7Gz2GCNLoEqukveQzPQ1c87/zn6zzRLSt
         XwYw==
X-Forwarded-Encrypted: i=1; AL+hErFggyka1wrD9Vn1g3yOYhEWiY5PSNxgHO/jg73MeiY4ieQs9Cu3nRKfsx/jNbmUiUxvWOQHFBY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gVVy57pdNp5jpE7AM30px/OK9zacwxDT3P2d2LUIbsHuEmVc/
	QKEZYWNjl10D4kQC6k38KXpYxkI7vc9zEqmIeKNa8ITE0yASQIxccxEX
X-Gm-Gg: AZFdTZd/CtwRlP6RTZBhRemIVkDtcbWg6UvjeiDmyEtRXFjlljlrPIxaspywpsK2tas
	SWlVOE5hglgH8J63PVJQE+1iAO6cDpaRm882mjBT40b5xNUWmyBxIvILYc1lf8cNVWRj4xx2O2Y
	vML8A822YlEc8y6zFZ78GHB66IEoxAbrzo14n0Q79ALspuksVHpOZQE+mlDEt6Wg68NEzf2Bo9S
	Gs5ZH9MafRFKv0zI7X8qYUWhNTiAFouPpt/fIgadMVeeWbWTPWGcuPOgfE54W7/z1qISuYjAjda
	+olbhknY4aF03Uer2Q3E/DlinDXG5WFho5RACm3gpeQJQQexRpd9aAXGmiraIJJjcyxXA6VzfhO
	8zsp6DIOjp/zVg2YmvlK0UEiQGYbNE6DkqmmG6d5fGPKpvRZY1H7eFS2hVqpMGSa53RN/DDZhLo
	bb1+8BUsShWcOIUBqXrKCXpKE7eS9nGX0BUD3qPPngZ1xj72ih7rD76Lj7h35EP3HUsRG6MMZh2
	NAJgqQrfT740NNg7+6zvX+TxIbcCpfGtx2AW4/fsEJcDSQ5H0tDx/9ZviQE9KoKEEnWTh9r97OY
	gJOGzkJcX0X3eaLwvVwYZ4c9sRMWguHQ/p1UsDTpvMaagp8fzDSItKfMRA+QYTMzGfZo
X-Received: by 2002:a05:6870:1764:b0:475:e2e9:4f54 with SMTP id 586e51a60fabf-4bc8540032dmr9275570fac.34.1795436020855;
        Mon, 23 Nov 2026 04:13:40 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm10063431fac.0.2026.11.23.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:13:39 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	sdf.kernel@gmail.com,
	nicolas.dichtel@6wind.com,
	sigefriedhyy@gmail.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v3] net: zero the tail of ha->addr when allocating address list entries
Date: Mon, 23 Nov 2026 20:13:25 +0800
Message-ID: <20261123121325.3137049-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hw_addr_create() allocates entries with kmalloc() and initializes only
addr_len bytes of ha->addr, but the dump paths emit each entry using the
current dev->addr_len, so an entry created with a smaller addr_len is
dumped with an uninitialized tail.

dev->addr_len can grow at runtime and nothing flushes the lists.  While
addr_len is 0 every addition collapses into one node, because
__hw_addr_add_ex() compares zero bytes, so the test adds one zero-length
multicast entry to each of 64 tun devices and switches them to
ARPHRD_IP6GRE (addr_len 16).  RTM_GETMULTICAST then returned 64 entries
of 16 bytes, 37 with non-zero bytes and 21 starting with a kernel heap
pointer (e.g. 0xffff8188_04857ee0).  tun has to flush dev->uc and
dev->mc in TUNSETLINK as well, which is a separate patch; qmi_wwan raw
IP mode and the HDLC attach/detach paths change addr_len in the same
way, so tun is not the only case.

Allocate with kzalloc() so the tail is zeroed at creation; the explicit
ha->sync_cnt = 0 then becomes redundant.

Found by an automated static analysis scan (Tencent CodeBuddy Security)
and triggered at runtime on v7.4-rc3 as an unprivileged user.

Cc: stable@vger.kernel.org
Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Link: https://lore.kernel.org/netdev/20261116024056.1274402-1-bsdhenrymartin@gmail.com/
Link: https://lore.kernel.org/netdev/20261118125443.1137177-1-edumazet@kernel.org/
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2 -> v3:
 - describe the test setup accurately: one entry on each of 64 tun
   devices, since all additions collapse into one node while addr_len
   is 0
 - point Fixes: at cca8ea3b05c9, which made the leak reachable from tun
 - link to v1 instead of the earlier review thread, and link to the
   companion tun patch
 - note that other drivers change addr_len without flushing the lists
 - state how the issue was found

 net/core/dev_addr_lists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d827cc21867b..9613c8a9ed7f 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -96,7 +96,7 @@ __hw_addr_create(const unsigned char *addr, int addr_len,
 	alloc_size = sizeof(*ha);
 	if (alloc_size < L1_CACHE_BYTES)
 		alloc_size = L1_CACHE_BYTES;
-	ha = kmalloc(alloc_size, GFP_ATOMIC);
+	ha = kzalloc(alloc_size, GFP_ATOMIC);
 	if (!ha)
 		return NULL;
 	memcpy(ha->addr, addr, addr_len);
@@ -104,7 +104,6 @@ __hw_addr_create(const unsigned char *addr, int addr_len,
 	ha->refcount = 1;
 	ha->global_use = global;
 	ha->synced = sync ? 1 : 0;
-	ha->sync_cnt = 0;
 
 	return ha;
 }
-- 
2.43.7

