Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597745;
	b=N5fwmPlwnotbJxb9Chw7TPwiF8SaXyF28avSh5iDRuefQPNJd/0Yf4/YcOArkyrvzxvN
	 WEeGE4m9B4Rq7XP5zyWfsIuSFFAO+l8hOvCPCHfUwws7a8YaDtoSN11IB65FnrgwWrU1n
	 ka44zTXOlDAbha/foXfTs3XObl0R3wbUCqZTHjzJwYIFeX/9/3xFYxa4QF2k1B9LxRrfv
	 Ke4SuyuL9LcBtgJdKcZ5d+9FQq+yDwzdgI6s+vfenTgpcKPuWlKE7kAo+sS2whNuFRBkc
	 5Odq40DLNhBoTGaTWIGojmQ6MxlxI80cjYQQcEb2JMKF5l8qEtPH4M+yIH/5kHIfPcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zDM85Bt0G9740LbOXzzdtljiTuHAbG1Qc7sd7beOOUU=;
	b=ffi9HZVRdP2afxKQ0ujxb4tv7inaLM4Mr6XM9ApFHniNYOOKiiVXwNLLepO+/v8BdqQ9
	 veJkog08Vy1Y0Rp158U4MAXVlO0Ec4RhPfDnwb5IiYMeGXap4n03KxIKZP+1xXQ5EZKqQ
	 37eA8DWiiy8NZzRcNrJ3bThRkDaQP2w5dF/MkNPFIhOGqddXvppRM2sf3bcOgVmROgeI9
	 Kn1gnX4mFslRo7dNzlvtaqSxb4GNYdq2JfrOtl6P87/yqOWkfqgWzp1W0JvSeXKe8WHOL
	 ZfIo8uxGDasjyUNJXXfsaEs7sGMpw1gX76PnWUrPRavdBtNRLHyoadNpm4/x87ZH9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A4N/QRYq";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE46606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE46606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4N/QRYq
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so894281e0c.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793597744; x=1794202544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDM85Bt0G9740LbOXzzdtljiTuHAbG1Qc7sd7beOOUU=;
        b=A4N/QRYqxlmQUQM5NgraP6GtrDSTm5Or9yyQBbLE1y0EFL5fmfZFmL4XAsqgixxqOU
         Ix6w/+ya8D//KuqhA6Fc/4MG5fWXv+bW3mclul2wBczLziXY9BulzeqVH/OfhGUxPdWH
         JiKpz+q2gzRVgT6i46fwaVTrMOVxcUkksWXdq4XfRR7Wi1k5o9aXp7lzUKjZ0/WUTIQn
         h1J82d8SRY+jnFXgIywW1GX6Nh7Z3+6j3Dov7SioaLQ0ayeMPzoTQlUrMWtCQR9eQWb8
         kfZ0oDCAjcaqlQ7mhR/CUM7tRK78EtxJSV9FhpxGkdU1KHjrXUASil3wFLk09Z/oLSOe
         XWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597744; x=1794202544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDM85Bt0G9740LbOXzzdtljiTuHAbG1Qc7sd7beOOUU=;
        b=JQTtEsn3dIlEmoSfcjogLABq0vx2Z07+/26oV0evV4ZtLeH/QmO3+boq/3kwz9Adq+
         JIp294MiLrkWYdf88JmUFVTsT2DhC0HBxv3iODxFvNLzn73tHnk1E72z4XffOUVIQ+3S
         t4XxndmH3YK3T/osj1BVKiz4FOjWOe3DFcXdR4IRCcp1CNf+gDLoy2wGzquU8JfV7uR/
         /dTpfQ2zX+LAXopDDJuRytOk7WFC6/yIeUHeJmyvRlWhfdvo/MAgqWzn5K9xD9Wz3aCr
         1FworXziO3K5pkofIQenMOcz7xzqwdHhAmhz+KUkz5gORRy+rMZ7tNzZj4KIu+er9k6X
         RB+A==
X-Forwarded-Encrypted: i=1; AKwUvBzO+JycCHBuFeTplZmkzvT600Orm0OPRtNgA2FfVICAzsphIVr96sfn21nPhA4J4uqrlV3OOLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DqfRVOwv11pH9jgxgzuUZyrEE3sYqei0coXAsTPTZAM2yhS3K
	VkgfGvFU+zBVlF62PKCILtf2wD84AKWSg+zOjdbtlN51xifOsQ9vqxZd
X-Gm-Gg: AYBFou1un0upXxey9Tc/BZj62qHOxjXQ2GZHbqIjWoVkpK8Gw9yenwWeqbNGqtEF7Gn
	VRljMOFkz1W5qOUC5QH89dcSQcdG7plItMKve+J5l6Dob+j/Ovf+XbQbuiLITVOdNeWvlNG2bev
	BEVZW/zR8dY7Rtd6/EilxVo4lqONINvBSy5Ek53dYO1eT0ZEa3YBJPrEHv+829NN7v0y2NQQ2SE
	kStHM3dygGDouzHHG1Ak4zT3eDG2ysvGAsjAj2AXGs8AyDM9p/WHGyIaTyhNn7B7R50ziXN7CX8
	bHbmNido0y43Eh+ggbQy+ecYx6q0XNvDqhxm5ZkHoIhKbWXpP5cpk3G/nkvjaJXNzxBFeJ1qud+
	xjMj61V3kZb23z9P0WKEQIsQmI54soNdIZMCNUVmYsq5HRKIMh/cPV9XNVI5vtfMA4NS5f+MsqO
	DZxeXxdGC7I+zEDOhf7paOjZbKVgKrKt6WtVpt3LF+Lhaj3BQqtsK8jlSUaN4YpvJlB1444Iw1H
	Mze8aElKkD5Ja4UN6LLcviNghm/UqdiZrbdiMSSzAK+XjZl0H3FVPEWunMOBJxVE/xxswyPd+j6
	Wo6XIGDc0XvJHSxwP9Kn7p688oI1j+cRaNmGBw==
X-Received: by 2002:a05:6122:310b:b0:5ea:cd4f:8494 with SMTP id 71dfb90a1353d-5ec6897bcc7mr3560315e0c.16.1793597743759;
        Sun, 01 Nov 2026 21:35:43 -0800 (PST)
Received: from bridge.. ([2804:14d:ba6b:8339:72cc:e44:b5d6:98cb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c4cbabsm9395668e0c.11.2026.11.01.21.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:35:42 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmc: Fix S2D message ID on Rembrandt
Date: Mon,  2 Nov 2026 02:35:02 -0300
Message-ID: <20261102053503.102598-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Commit 382fe403dc31 ("platform/x86/amd/pmc: Add STB support for AMD
Desktop variants") added S2D message ID 0x9B for Granite Ridge (family
1Ah, model 44h), but only checks the model. Rembrandt is family 19h,
model 44h and goes through the same AMD_CPU_ID_YC case, so it sends 0x9B
instead of 0xBE. The firmware then reports a telemetry size of 1 instead
of 0x100000 and amd_stb_s2d_init() fails with -EIO.

amd_stb_update_args() already checks for Zen 5 before using the Granite
Ridge registers. Do the same for the message ID.

Fixes: 382fe403dc31 ("platform/x86/amd/pmc: Add STB support for AMD Desktop variants")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Tested on a Lenovo IdeaPad Slim 3 15ARP10 (Ryzen 7 7735HS), with this
    driver built out of tree for a 7.0 kernel. The size query returns 1 with
    0x9B and 0x100000 with 0xBE. This laptop's firmware then reports S2D
    address 0, so init still ends in -ENXIO here and I couldn't test an
    actual STB dump.
    
    Based on v7.4-rc1. Found in my own boot logs.

 drivers/platform/x86/amd/pmc/mp1_stb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 8a33e75b71c3..af9ecec532f0 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -266,7 +266,7 @@ static bool amd_is_stb_supported(struct amd_pmc_dev *dev)
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
-		if (boot_cpu_data.x86_model == 0x44)
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5) && boot_cpu_data.x86_model == 0x44)
 			dev->stb_arg.s2d_msg_id = 0x9B;
 		else
 			dev->stb_arg.s2d_msg_id = 0xBE;
-- 
2.43.0

