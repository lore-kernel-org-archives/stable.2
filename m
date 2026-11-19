Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060925;
	b=yIu+9TFQXoS+gq0rrPVGI+IqZ4m7ngrL1liURu01EMMIaVPADkRmu3vZ9Fvi3+Ww+vOt
	 PaVro0FiJSHsIdpav6I7GBZn4nLhpe89sdfA/0yek3xmKiTkSAtmikaWJOfGWNj6qor80
	 s17a+BQLSw8WtCiZjoEh5K4FWg2Tv58Uy/7S8NA4hAjORrBrnuSX5Bh9CwglocYgybs49
	 /5mdPgAaC6mrRyTUJMlBQs4DXPBEK66OE/IZsSuNYsEAlx8x0CgZP9Ky4VfbosCWdgcgd
	 MQWznlRIDUP4V1N3iIFXVc7zDpgFFNvmYtRSW+nmsbbEv6yCDgL+zgiBv46nvo2Wq8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ki+hym5xBnLUsLIUPy9cHW9nYAaIrxILlRLJC6d61Q4=;
	b=jUjqWeF6qMPJPE9meo7MlNGJXE9wQSzCKnhcjZdMxNRpMROeq3yWG926zA3q1H0SE9ij
	 3mE1C46Ko8L0b4WwrpNCiVgdab9nbBmoOszYxlAg/IZIKV0UEwEXNfDfzSPbBehlKncS0
	 zIH40o0e1u2OHOFMwGcRgpBw++6Z0ReyoCRIP0hO87JuAVkMu01CUw53d0bpq5HIv9OzY
	 qfqW9rJmS6QjnH/zlmNXafhGbYIkjuOYvjzq5Oj24TDmboJwbZoXYZawWOEX5ulgulu6m
	 Zov50t2g/vpRUrQ3caNFhTLTSMb8mWqiDMNS64wf68HZYcdEX22zjc0McsvOXszCHnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YhBGpxNL;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D7606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE1D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YhBGpxNL
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-71b2862dbeeso219351eaf.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795060924; x=1795665724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ki+hym5xBnLUsLIUPy9cHW9nYAaIrxILlRLJC6d61Q4=;
        b=YhBGpxNLOS65RBwZNOx35XebtNQustjfOo9inRNweNvTqgNnl7g1XXs2Gic+Z+ZZJa
         BPzBkbQintn+wN81KAlk1T/Gkv7oYnoav65I0tImgcgL/Ed4nW0ptb502FMzsOtKCdb8
         g+qgRBISkIFyNkZu3MtVjmArSPJQ0DmEZZL+CbPTgFYO3/CLXQX5Kt9rK5LEN5jdeTyj
         mK5Hta1lq78vTSLehnS5Lj3rqmxGbzQNZpKkbgs8wPgqouv9ie0RlFnQX56L0ikhVLu4
         zMTgo2vr2I53eabkOhPc2DUXOGkJDS9Y05lgQPahHwUSNCBIAnNek94k9iJcdPmILs5/
         xX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060924; x=1795665724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ki+hym5xBnLUsLIUPy9cHW9nYAaIrxILlRLJC6d61Q4=;
        b=Og4cwfXoQPz6k4B0T/uZK8nv2mTJL/wh+Ca8/3WyfWw8IoAC/JcQH3A/JyDTlu48sB
         x3c3x0wf8xhDkM1Xty7RG3eVM00NgmtqwoMcf/lNtYe+YEkWnimZBHZKG88F/lpXsdFz
         q7DTHzA6eSG6brNSp5wsQeUfMqH58snCmEzl4cQeGtr0HBgvBXFLXtz4aLQt5ySmC2tE
         XcATM/xs/NqVJsa3nkK5k2dxT8OIZj/kCU03YGUDeCHOYcp4rNBxyf1vqvpPVJkg0bx5
         Z/AlIkBSCVs1LhdH8l+g1uOaz7u4rPOrd3zMWFzLfZ8OPSoVznuw3mUcvStJ8QgTyvIL
         aC9Q==
X-Forwarded-Encrypted: i=1; AL+hErGASnobPo3bxKvbtIkrSFnclI8p8IUzJ4oqoFtRoxTp1BSHYK6DgL4+1WdGYEQeScbwk5JbD0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e0S+rmKljtWC48eFkwKkhuaMsOwjT8uAVeoZzoZgGGLjLUsfx
	WPsjlL/LloMY8n9BpdnOKQrT+Xr3vXOPbCDZa4UHoWyqdMc//22302of
X-Gm-Gg: AYBFou0IvFOa8DzRErTVChuAFZPW/Dgp74PuS3SKexyfnBS90V5CPihQCECJvI2weTB
	XJsyC4qabdIpl6Kbh9FB9LENdCa3hPsjTQP03w/FaVOBneWR3miVtI9yWWqAGVuOYQkvyDVuwS4
	zTIBy2a9GLld2jXONESKSWDcDxcjPbvNKUUkXsRfhGcA2DHlP//tMyLEwGEVGUg8vTe3V2Hvz70
	GqlWwj/1cT1DrCc11HJOXm5rdx0cJG2oFXvc2d2hgabB/epAjk0olDfeOjw9q7u/5LuQduUMNgt
	m5U70wNbcRAOgGUwZMW/nMQlHsbkEX1ZiYhvtbXucrRVJOfkVx2aF7unWFT5e1F0fOigLxrduj1
	92DFORYEBU2Hw++KXLGbHDPL5Zo4Op7wCkKxYmWhoxqXF8rukyOV5uhL9kx9fsiyedeFYRZcm0t
	fg1Y0N6yBWBcvFSkTNZJkr8jMzS3vd6ZKL/CrEVWxNfxPkTTv6GtJhE4sPImelAUEcrWGeqiL8g
	e5/f4CMLxbq0BBJB2FdKfRFZn/ItCDEJCMRLBScTlk6jnsNqEmOtnRUD7z9qshi46W1XpQzytR9
	jSitmifB+KmtbwmLhXlAVsvjBmYnnarVsfuhuzwaREM0Zjeomav9jLXatj0tQykXttt4+GZYuEV
	OCVaswISlasq0
X-Received: by 2002:a05:6820:338e:20b0:71b:188a:319d with SMTP id 006d021491bc7-71b188a3436mr2906072eaf.53.1795060923744;
        Wed, 18 Nov 2026 20:02:03 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b744126dfdsm4163497fac.10.2026.11.18.20.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 20:02:02 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Yuyang Huang <sigefriedhyy@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net v2] net: zero the tail of ha->addr when allocating address list entries
Date: Thu, 19 Nov 2026 12:01:52 +0800
Message-ID: <20261119040153.158372-1-bsdhenrymartin@gmail.com>
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
addr_len bytes of ha->addr.  The dump paths emit each entry using the
current dev->addr_len, so an entry that was created with a smaller
addr_len is dumped with uninitialized tail bytes.

dev->addr_len can grow after the entry was created: tun's TUNSETLINK
changes a device from ARPHRD_NONE (addr_len 0) to ARPHRD_IP6GRE
(addr_len 16).  On v7.4-rc3, with 64 entries armed on a down tun device
and the link type then set to ARPHRD_IP6GRE, RTM_GETMULTICAST returned
16 bytes per entry of which 37 were non-zero and 21 started with a
kernel heap pointer (e.g. 0xffff8188_04857ee0); /proc/net/dev_mcast
exposed the same bytes.  This discloses stale heap contents to readers
of those interfaces.

Allocate with kzalloc(), so the tail is always zeroed and a dump can
only emit bytes that were written or zeroed at creation.  This also
makes the explicit ha->sync_cnt = 0 initialization redundant.

Cc: stable@vger.kernel.org
Fixes: a748ee242681 ("net: move address list functions to a separate file")
Link: https://lists.openwall.net/linux-kernel/2026/09/10/320
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
---
v1 -> v2:
 - allocate with kzalloc() and drop the manual ha->sync_cnt = 0, as
   suggested by Eric Dumazet and Daniel Machon
 - add the runtime observation to the changelog

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

