Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0935C6A5
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375499; cv=none; b=IDd8FQEyaIs1uddfaL/IJ8xn22csD1PjG/VN/V8YOAg4CLzGDJvgttNxLRLNV+TB5jEE/o9u0LJvnagcU9wlvbXCgW8E5gltrqJAALG8MxEgaMcLXBLsyE3hqhDylbTorm90Xd75DDQyGNRHiMKIWyjSW0gpDIE/P9lRweB1rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375499; c=relaxed/simple;
	bh=yxzwj7kj/0mVkRV9upaErvtPrafiX8Fq4udSHZDZcZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv4NzrYCmXxr/CwWbI4xPj5LsEFZLg6UScsPlp2P0bnwn59qgi9Z2qGrZIWVnw7AMiz/W+JBUQXpFRpKNw0uIF680t0kUU5uWIahOWTYi3g92cUc5smUVn5yKUW7FHIwGO8e/KjJqjuHmKAuELd5pNO3tloqkpZAmjh10DryekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbOPq4Cx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbOPq4Cx"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc149372c14so1879054a12.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789375497; x=1789980297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OR7fP4bd0gC35uG1gm8oegHQErfRKha3ncQTYMaVg3c=;
        b=XbOPq4CxpPYcacml93pPafPbrCtIKrSkRj0qD4kM/FhTG1JQbppkJW+yopKYbk3xN6
         lDu25M+TFbtr0e5LGGey2CdpT1GfN/CTS30UYsG+bup2uE1EivZAlYmqjSm3yeEc05kb
         vlTAeilAe3qmQ7o0cQA+GYokuhHdAspQQ5EV7c00/myyYvL1OznpkQ1Hqb5kpu5VuMez
         qlYh89Px92UfFyOD9ExkQ6IOLIQ/e7GOwMaprO+22RLVaip4ZXc/1vWDOob2btNeC653
         xavopw2XjaxnxtOs5fwficnxTRmoIJn1vgNrFVbYG9mTdZEnIj0JklRaV6emMKxcRtjq
         Oipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375497; x=1789980297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OR7fP4bd0gC35uG1gm8oegHQErfRKha3ncQTYMaVg3c=;
        b=gejE0mtpKiXmugXV+J1YY0LJeNFXl9WJxc2N9htRnBtwf1LeOefDs5FvruvKxR2NTX
         rAR+qYuNFlHx4YN5Iyic25+ERaNlFWJwRDpwOC4nY3E1J9FTUJoyEJNg51dMtiaqGw5e
         AP1W30kbGqDacBJQf47rINDmW0cnqZTseEubStMp2EP0dgoniXXQY1vOCOlZ/klZgTt/
         uVuuIwxOwbWUstx3tZC8LoBqBMFdUhuzkXeTyDyVr/0Zo/kk8mr0M8iuYoYlC11fc6oh
         qSnf+kBDM8gBEpy3yuOAyG0e+tpOJdsLWRT8V0jt/68TRD50vBFlSGX5joGALEE1serZ
         AN1g==
X-Forwarded-Encrypted: i=1; AKwUvBwaZCAz/z3BExbGSn7ADhd8nxCmf503BqpR478skwr/zQUY54BNDHNmyaNACE0eCEBv0S25O6A=@vger.kernel.org
X-Gm-Message-State: AFuF++mBl8U12RXqXyjAmo8XAO+KBy64Vvajk8GQHj1VKLjLvbu85up5
	I+9gKzVNmCTmQm6KtlCZgY9ztyaVLI+PUuxLE2bhnUWM3NGM8xSA2Ebg
X-Gm-Gg: AYBFou3MfMaRCWsTr2BJTkSEhgj/TuAmqa185HUdIhTHKo98rVEszUTY/OOd7Fj7YGL
	//KzVeBStQCMPpCRRzPeYDdrk5Eb85i1CX2HiKOxfEEdDTngSJgAtnF67t/bt6lmOicKdyxL0oj
	2S/wxDx9CwflpDUrAW4/3Zfq9Kn5w8UvT+Q5tb0w7m+eBqW50UhhlAaZYB80icNqppdjx/TrO4K
	T5h09Gm+2bf+1yhGaDem7gyTXqx7UQq0CVTbGvYvzPWodwsninxVSnCmn9BWgVnzOOYWa8eV1uH
	PMGYS8vxVuhhxy/JTx9ULDJmHXLxdNWjvlYVdMvelmFyredClN9id+25gq3jt7NnCjVlN4wedEO
	a7p95austrCVag7QeutSEvikdjM0FkvTosrEUNc2avlPOkTawpnXnTeU1Kz/TF6Upa+e78m94CQ
	KOhdAWVyrvopFUua/lfXBvtxaZ5CybEhfGx0GwUms20ZznMW0O+mlQeA==
X-Received: by 2002:a17:90a:d2cf:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39debf86d29mr3926198a91.2.1789375496577;
        Mon, 14 Sep 2026 01:44:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm21128646a91.14.2026.09.14.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:44:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: fsi: fix device node reference leak on remove
Date: Mon, 14 Sep 2026 16:44:43 +0800
Message-ID: <20260914084443.1664635-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsi_i2c_find_port_of_node() returns a referenced device_node for each
port. When an adapter is registered successfully, the node is stored in
port->adapter.dev.of_node and the reference remains held for the
lifetime of the port.

fsi_i2c_remove() deletes the adapter and frees the port, but does not
drop this device_node reference. As a result, each registered port
leaks a device_node reference when the driver is removed.

Save the node pointer before calling i2c_del_adapter(), since
i2c_del_adapter() clears the adapter device structure, and release the
reference with of_node_put() afterwards.

This issue was found by manual code inspection.

Fixes: 095561f476ab ("i2c: fsi: Create busses for all ports")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-fsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index b2dc5ae1d0e4..0c022e79ddbf 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -748,8 +748,11 @@ static void fsi_i2c_remove(struct fsi_device *fsi_dev)
 	struct fsi_i2c_port *port, *tmp;
 
 	list_for_each_entry_safe(port, tmp, &i2c->ports, list) {
+		struct device_node *np = port->adapter.dev.of_node;
+
 		list_del(&port->list);
 		i2c_del_adapter(&port->adapter);
+		of_node_put(np);
 		kfree(port);
 	}
 }
-- 
2.43.0

