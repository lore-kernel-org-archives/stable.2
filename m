Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47134D9F67
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731829; cv=none; b=PYoAxKr5SEfOYnpFI20d2J7LIenyP1Yj3ZD5v1vWj/YYSdCNjxnAlqtlQ5atFNyPxc+qXZ/+1n8S4AHzIv+VSVyJG5TcrkEnBKJ7MrYNBs2gQYohP2vPyWxW06zDcpA+eCnJL20ga8sfpeofH+PfPsNjza02PLjHC/3aCbo1Fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731829; c=relaxed/simple;
	bh=O0OEtypMq54rxogZfM3UcR62WCFrWh4lapIYJp+uHnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQBtPXGJuYK/eop0y59HsbmWADDfS4LjqcXyVT1Kc9K4wgm7At131FYqJ1DJkEyKmC5e8k5M/XbEmyY/u/N9sFE1Y6fuJuMmYPho11e71h/k0PpGX3+6q0BuokCEdeM41Ir2qkEPiaTEJbrK09gimyinM3mQL64cqLliBeVb8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOsiKaA+; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOsiKaA+"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8686f46e4adso571288b3a.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731827; x=1790336627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1EVpGe5SDF/ZJpxR+ovxzDRHCXm4vVTGo/7vHZ+L1Y=;
        b=rOsiKaA+rBEZwd5JMDFanQ5FkGbbcfs3IMyJjjnqhlMEiH6K78An1iSF3PdDjLLLhx
         sAmRN2auaiLGm/TRBnVeNIUA8/dpVODzi7W1DVRlYp/sPrev9eojnWBiwWjmCcYxN3I7
         qWpyBbVIXWHSC/6WHbHMkyoIzQ4jV6BZCfg/CgGpXlBeqQWDg/ayt8VfonO57731qXKN
         NjXgT/qFxlvm9abfv5OYSx50QtzxiPpDB/jbZ0BvKwpAkH2G/Y0v42wnsMHcR8L1zBAw
         uJ4Hm8vkHRHNBs3EH56f0gQ6AD2zyi9o91qfHtcCqWL12bZp8fOXn6oPSx973zX31T1N
         pqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731827; x=1790336627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J1EVpGe5SDF/ZJpxR+ovxzDRHCXm4vVTGo/7vHZ+L1Y=;
        b=s/V7FoaA9Ks6i7vGPhvIW/2oqVpqN8Z8AWrbJltTl9BD2GuRmsyxfBUAty8Jov6ggj
         VoeqOUqM5oXpchJRx+WOKcJH2zfyzPQnS4XG7LEqiRVZ5ENunzPOcveaJrKSP9nbx3A9
         VhBlOaJPLwcRcYkh9wcVd/MOvguNiVoXUfuJ2Ke99DoO9qjwEF2OACRZ9xu9Xqaj8Exk
         c8sxxksZvynKekeHQvbBSefLMW/TzeeA0cglOrwjAR7vTU2na0dQhZNHL1JiHkZ1h8eB
         qCH1i0N+flB9KSBS65jXdPmeDRNIufBtzvcjV5nyeMYEmHK0NdwoDVfOBV0thQKbiLQO
         2JBQ==
X-Forwarded-Encrypted: i=1; AKwUvBziVuoTHVRCIsp6nUXpSG4e6W/Y8pKMoPkJ2XhQMyE9d583jd/Bcs2KPgLj+e2/LN+DCIpQNA4=@vger.kernel.org
X-Gm-Message-State: AFuF++mQdmQBj6IzV7iV6aHhJWPmHCQJCJ4CaCf/xTFsKhyRwh56bPUy
	U86y013lnMhQJjK3PTXshHbJi1igh9EQ6ZkI+MLlEXd3le960maD1Mxw
X-Gm-Gg: AYBFou0LnG6t9ygRPWHkdtP4uL1K9uLleYSLX1gMzK7Rfw2drdyginYx/LOQeB4R3GR
	pO6DnGO6Lns8TFQ3EPRaUKdv+Z9JbVn4Kf105V8nJ2Ba9feIlcroH1KtbLQXS8zZmMQHLPx5S4O
	RqUaM9PXHwiewy2+/an6ZIuFr1u1LvJC8fgcov/uMM5RsnY2iu2bjrr7kTrgVnH/Pn5WMzUh4T1
	DS3edXm3cHF4PEsfJjyynPpQGgTb2YP7mzmQIR2UfvQQ9pr2eu1+cMttj6ey44S2fASQopQYvmt
	KPEG0mKKLWGpIloc70MEHwzfzvy3h8mOZYGyajG0XE9Z8hRs3FeWWTHOGTk0zY9/qW7tY+Jtpgj
	bY+Is+Ja9Ow0BazUGAqgvEZZz4g+PYSSsLSFzyHFeHG83ufmvY1/c28LvoosxkvgzjnrrYGZw0P
	t1I0jK023ur6dvMHseokaiKRGvSoJZ+xG8oHBQxD7aiLHDgccTO7Jc/S2g3vUE56CkpeVFhF8T9
	W+g9rrH0tw=
X-Received: by 2002:a05:6a20:3d07:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3dd8c48ee7amr5158956637.25.1789731827040;
        Fri, 18 Sep 2026 04:43:47 -0700 (PDT)
Received: from 73ebd4c7787b ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c284ac724sm4794739eec.2.2026.09.18.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:43:46 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] net: netdev-genl: add missing uns-admin-perm flag to BIND_TX operation
Date: Fri, 18 Sep 2026 19:43:29 +0800
Message-ID: <20260918114329.3659849-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918114329.3659849-1-ndaugoing@gmail.com>
References: <20260918114329.3659849-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NETDEV_CMD_BIND_RX operation correctly carries GENL_UNS_ADMIN_PERM
(uns-admin-perm in the YAML spec), requiring CAP_NET_ADMIN within the
caller's network namespace before a process may bind a DMA-BUF to a net
device's RX queues.

The companion NETDEV_CMD_BIND_TX operation for netmem TX support was
merged without any permission flag in both the YAML specification
(Documentation/netlink/specs/netdev.yaml) and the generated C code
(net/core/netdev-genl-gen.c).  As a result, any unprivileged local
process can invoke BIND_TX to bind an arbitrary DMA-BUF file descriptor
to the TX path of a netmem-TX-capable device, bypassing the access
control that protects the equivalent RX operation.

Fix by adding the uns-admin-perm flag to the bind-tx entry in the YAML
spec and the corresponding GENL_UNS_ADMIN_PERM flag to the generated
ops table, making BIND_TX consistent with BIND_RX.

Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 Documentation/netlink/specs/netdev.yaml | 1 +
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3e3f03bd5c29..3e38ffc39219 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -851,6 +851,7 @@ operations:
       name: bind-tx
       doc: Bind dmabuf to netdev for TX
       attribute-set: dmabuf
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index f83790341eae..e243fba64312 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -241,7 +241,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_tx_doit,
 		.policy		= netdev_bind_tx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_QUEUE_CREATE,
-- 
2.53.0

