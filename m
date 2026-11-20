Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137240;
	b=oqcKc7MjNkPDARwvwyXlTvjDoc4J/ORAnA1njUzn3MWuM3qZCtcEkdZA758nfb6MjKWv
	 UyHhGzISsyHjYrrTNe6+taAU9yNyvcV0NeNZaFbw/Mq4mOtCYy2a4AOwo31A1cyN68dJ6
	 lL9rHyW61u6YDMaCov3/mzM9/v4WFc7b9Z0yJ9pSaS3UFUjuOopzpwJwFOM1sbFV4GLUT
	 HNv5VgfCpqZGHcbgNloXnB1CFS5N+uv0hnKtrDfYiuc1eLWGUa3neYv3DM6G5HkADoAHW
	 CwoGBbtHdHPZlM6+2mCiSw0b7SX8s7LDL6KZZeTPHJ+g6iUdAcbv76o5XDL0W+UPTcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137240;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=HfFmTD93AmzLXjBxMJMXbbhoXoQeeqI1OmZpl0U3+58=;
	b=s60wPjMjEPjnOwq7pJMV2pJt8DT/HDTkcbSs6lqfLbWsPJ0XM57QEnQ3F9ZWRE2ceC+N
	 IkXsioykXPw1Szr2ZSbeXQjUYo5vE/SxHtl7Pt5kDaVFV9F7zoMnubZMfvx5kMgsxn77J
	 D7I1u+98pLhp9RzULaaK0y0ChozmX4OIFnVEeOFO9esqWifnyjTpvISlUJ3NeHJM5YVc5
	 ZjRk5b3ZqjBWH/C5HxAZdHD5g2qfq9GZlDpG2AJOgItAMCLyEpvysNWD/a7AGln+n3sBe
	 TCfLe7ldwaH0nV4ua46R453JFYn9lX6FWVc+HipwPZt7HoCtuYrfUidbWu5cKIqzfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=hziTyOFA;
	arc=none smtp.remote-ip=210.130.202.132
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79F606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA79F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=hziTyOFA
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1795137214;x=1796346814;bh=6HAzXKtgiCp5qng+rXKY92jtPSjWl0A0K65auUq6EtE=;b=hzi
	TyOFA4DCeeHGerjJbKgU17fDYoatB7d98/5MGJApOmmEJn6HdeySlaTkO8RIpAlgsvcYnvtPbG8h/
	FIppSK0TwJy618BnUL/6QHf1AExZzYN1fmx/8ftYYDwNvEpZjRkI9prDStsxRgwkROSi8Qo67PjlR
	YbUceYQoHtCdBdfrt4hUqtU3SzlIpQuX3TG6xkO37J/tsWAJG0V45iRsggyUcJXzni6tuKEpFOgaw
	APMkVpJOPFHsl6y614xevmbYv5cPB5Rd1gKo/fVnm1Bl+j30z8bVIeaDDNh22fXtgp+985DFGUBN4
	/D/Zf4bFa6ye20P+Sm+a5pBvQ4Q9tqg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6AK1DX4E1797958; Fri, 20 Nov 2026 10:13:33 +0900
X-Iguazu-Qid: 2rWh7O15B01fmpPQhB
X-Iguazu-QSIG: v=2; s=1; t=1795137213; q=2rWh7O15B01fmpPQhB; m=hlkWbseMAAnJH7U0Bt2MxDF+l2/fFuTBcHJeMKjVgHg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jVy5T2K5Qz4vym; Fri, 20 Nov 2026 10:13:33 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Miaoqian Lin <linmq006@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y] remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init
Date: Fri, 20 Nov 2026 10:13:16 +0900
X-TSB-HOP2: ON
Message-Id: <1795137196-10506-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Miaoqian Lin <linmq006@gmail.com>

commit 61afafe8b938bc74841cf4b1a73dd08b9d287c5a upstream.

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.
This function has two paths missing of_node_put().

Fixes: 6e962bfe56b9 ("remoteproc: imx_rproc: add missing of_node_put")
Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220512045558.7142-1-linmq006@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/remoteproc/imx_rproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 373fce8b9106..95b17eaa216e 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -290,9 +290,12 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		if (!node)
 			continue;
 		/* Not map vdevbuffer, vdevring region */
-		if (!strncmp(node->name, "vdev", strlen("vdev")))
+		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
+			of_node_put(node);
 			continue;
+		}
 		err = of_address_to_resource(node, 0, &res);
+		of_node_put(node);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
 			return err;
-- 
2.55.0


