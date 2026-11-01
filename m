Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499252;
	b=2EsHOIWtQuBhWfOjJrnLHaEytWwp3DrQcdu86F90fWy7OV8a5ClLGBeByp0zgZcCOyS9
	 qyJfBMo1gKemghqTG597xODbpNN6YY5NmkCkD1WN8yWJFRGCxj0vstEX/xF/GOA2QKbDE
	 LhpGM9gLf4HuhXQ1UEzroz15S2CT8ZENES2lozJP+87/aNS8MMqGSRIN0a9L50Amwzp1J
	 jaG1uL1WGz1i+pxnbvNX7GfR+HOMfMvoiCRq2V2f2tEEuceftx9aa88npmGjqz5gNCCbt
	 bqD58ZQ1mZtlVFT2aTWzVLkai5ifE25LNQPPxy96JA//O/5LjvStcLqWeA79ienpW0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
	b=X0ZgXkwxC6MHy0DzKPWTgCrrKvs/Pf6HoGC4TQ1PPEerD1cfSMTd0ikA4Rrpye3WwfWC
	 PqaC+5H7OMyJTiBR0nzwuMvF4qwM4rqiepp2P62rE8VrLCSpOyQWs/FqlzKdVF16aZQVR
	 zHm1dLCrJ6XcFmEHjwBnkpOeQ2spE3DfjJOgvk2bdZPIeL3VaR3CrJDfMboOj7rGFSCoz
	 hQHpu8cvcl3sRofCRaFXEcOcSLOOSjs7eWZit/8MHuZkAJ2VSPz92uIyHq1lRwFbAy812
	 OwDq6u8v+1v4EjGQXDwMOWndMD4HAY6OB2vZbP/pXMQe03DbGZo/Ugdt0W3s/BWkodA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="H/L+nA9j";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1539606A330
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1539606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H/L+nA9j
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-945ae2daa3eso39846285a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499238; x=1794104038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
        b=H/L+nA9jNizIm/iixoLRh1fmKt4I7O+jnIUupPKcZ/0xeRQEkk9svkGxMoN6A+8+Eo
         F8N34TrsvjwnymM2DpnGBCCWXp7hpqDpb4Af+Nj2BQRyOx3PbIAXiYrJ+yzKE7C3rRwj
         gIvMYNIBFusvovNyfROiuFl3AQG2m6xvwikiJdU1F4ZG5DoXZmqINu2F8DHiok5GTU6S
         1Jnm45OspMEHCl2fFapGV7BT9v8L5lw5MnIbM9jKybmAwuAwB5SRr0yOEhD7O8OgBbYN
         awMKxVAL6++0JEY5JinhPTKHctCI0LPTbyEavcuwa3NdazWQRTgVqiit/991KsZr6pQE
         7/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499238; x=1794104038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
        b=ybWTbGJkF+SRx11jq8G0p1zrnd6kl7VPCjDb9GhfR6Lqyjt1p7weqQ3RBFGB+wyMTB
         le14cxy3mre713B7IVnvIZLS9qjcRCPeUR8NshWzrpZTQiUGKD65tqUkL1VzucaLvnM+
         qJyaC/frx0SVAVGCMigcpIJV3dccGabKlc6D37gPqlBrYnaa93DCN+AZC/dp9lAQnxTZ
         lSCrw4KimUhRaGZM5mp2A8X7LkyK2DLSPfUYjGnQK3aCIdUHr66hh7N7w72NXfZgaNT8
         TDJ7ML979rtNybuHu9YrKtkzaamFSKhlhGBz2jjHxP0/pYws9kGF/tNlhEMoblPoYDD7
         Y7jQ==
X-Forwarded-Encrypted: i=1; AKwUvBzO4ZrlI9DoKXN7vK30N3tk3/w22DRdRfYr3WNIQi7PKQB8QJQqVY58WZVOwvWqMYfGFW0quJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLL2yKhSDxkDA8kWHbdc2xbRxCAEHpvnfFbgl7zkCg1PA806aun
	4sbGGPnnBq6jTWsfENUPB8CkIqwHq6x7djlWCoEaFXinzvYnWmda81CSVRw7CGRWmUc=
X-Gm-Gg: AYBFou1U9EfMag5HFkJ7CugCF681WPqYVvWrQkch5zrSpsHSofXNaiWf+Q2x8WJTwOi
	uQOPNz66C4OuC9GDVGiBWLtzJUsPMn3AU4kvDyh/N7gOEDtt4ymgoQn8N2lIJ4mXUc8vE5l/JrI
	rpeQcRuzjg8fF8djmcf1k0sHPUufJDi+zuyu81jGHliAFeU4JwJN4Sc4H3NhsKrUnO8/wow9jyp
	rRz8xwCQiuLkjev37vKn5AwymeTACu/T9bR1SA8SirWH5rIFOtXhkyQJ2g9a1+zZTtNAmQydo0C
	diWJXqdgDbxtWs90hJfZxRy5mWs9We1rj8ww+4/HmiB7KrKX73Lk0eHSp0vxFYXrB4KiapMLnVk
	TlfuEHq9I9iDw6tPA8QgFCanaIhkz219FzUPVzweF4DXe95n+VT3dCzN4iT8V3NtHjpbUKKsOPD
	sSNVk1GIIWJtAvHf4Nm9gUnCIT7MRCYI3wUjOBK5KbWT1TYocu5DlOazW2M+kfEpH4SuMg1g/FM
	mqnLvvNxC8PJqRXF1Rky3gsfkeSh6xHBbDDFGtEWDiOK/NMgNInsHd2uJJ1WSAq9ARUr6R0eZ5L
	aomOhXXWGywahaB6RlnMky6PQuMsJQ4WY27iGAJ7i9QZQOtfoXjkeDrsXCGlC+vO8P6GqgELy7p
	AJ6/f525Ysw==
X-Received: by 2002:a05:620a:45a5:b0:93e:e175:ee92 with SMTP id af79cd13be357-9442175ae0emr1102271485a.39.1793499238054;
        Sat, 31 Oct 2026 19:13:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:57 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Sat, 31 Oct 2026 22:13:35 -0400
Message-ID: <20261101021340.2251928-8-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

__next_zones_zonelist() tests a slot's zone for NULL, then reads the
slot again to look up the zone's node. Offlining a zone's last block
rebuilds the zonelists in place, so the second read can return the
terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it.
With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
nodemask allocation between the reads while the node's last movable
block goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/mmzone.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580..65880396f104 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;
-- 
2.56.0

