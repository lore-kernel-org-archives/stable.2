Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164568;
	b=x5Zka2GQtq1W/l7rmU3/AeWZ65aSo2YJWjK2rDhyg/R2ZVvWVEZkbB70KRrvN9tfUOXp
	 chomtbY+Rz2x644HEro4MCfp3Bo1LndDygjjm2ZZWpem83e93SYhBJQ3P5RDjqQeJgFhN
	 KvJA6VoAeKuQ73EiT3HgxoJmo68kr+/91F7H62s28+6XR4gV4wlH7AnptcWRC4fSXqkvC
	 O/UUaa3Op15Xa0UYOArwq4Tu5WnAroxfBmcR/5KWWDV5kQPa3j8e5jNfukxLnPDU4cBEq
	 MtS/puScpzib79v1EYd/dYxcH0r33fjyAMvIwoTGPthljvao2FFYFq7O6YKSef8TziA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164568;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=5Ir5Ptx6wxJj62zqcl/rkwae7e8ti3xBH2DQczC7hUI=;
	b=jBhmRPpIwiobo47u52b5DoHQBSudQleSuX3zaNmj8w+jDRStcO14xRmr5rs9j5vdVFEG
	 G1WFCnkZgW0jXNlpxVgTGxlJOw8wRt92mn1MiqMP274IMJDo0HTOUbQMMvTZ/eil0xpw8
	 TKH9YauoFHU35d67EbmoSXzL0NgJ2+Wc7p92udnGg72sWqF7+NIXTzHEWg8lyjsSqTdNp
	 IKJlgrD4zNqtWh4GdzcrTLwCW2isGm32C9Qp/O/mTgWF3YROqZHh0/f0cEr8hlBBJC96a
	 QJpr+C2cXeP8vq3tqCnvKhIfdzwCY4R43dyMPrDmDYJhkppbaCR3GQPxkv0fujg5UFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I601Xg6+;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91512606A31E;
	Wed, 28 Oct 2026 05:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91512606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I601Xg6+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5I
	r5Ptx6wxJj62zqcl/rkwae7e8ti3xBH2DQczC7hUI=; b=I601Xg6+bor4TeG2lk
	DzsD1Hrt0PyijJH9C8Y5NgiYNZ2SkTQIHCQ/nVVi+gfJ1SvqABfzQkRC261aqF1d
	OfAwSvp5DbD/wUl++A5jAD9l8VDlSH5l9v2zY7MdT9PiTRHAmdT/AB8QaMAH+n8e
	iRlCLvX6q6Y8ucetmZowjxDVQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3N956hOFq5V9qDQ--.31027S2;
	Wed, 28 Oct 2026 13:13:31 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Armen Baloyan <armenx.baloyan@intel.com>,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Anthony Knapp <anthony.j.knapp@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Max Gurtovoy <maxg@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@nvidia.com>,
	Aurelien Aptel <aaptel@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] nvmet: serialize port attribute updates with enable
Date: Wed, 28 Oct 2026 13:13:29 +0800
Message-Id: <20261028051329.149005-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3N956hOFq5V9qDQ--.31027S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Kw4rZFyUuFyxJr4fZw47urg_yoWktw4xpF
	sxXFy5tr9rKrWIkrnayrWqkry5Cwn7ArZ5X3yUG3sFyw1Fyry3Jws8CasIvFyDtrn2grW5
	Gr4kGFs3ZayYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf0eQUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xtSjGrhhHsUTwAA3F

Port configfs stores check port->enabled before updating address and
transport parameters, but the check and update are not serialized with
nvmet_enable_port().  A concurrent enable can therefore consume a
partially updated address or validate one value and publish another.

Hold nvmet_config_sem for writing across each enabled check and update.
Parse independent input values before taking the semaphore so invalid
input does not unnecessarily block configuration users.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
Fixes: ca2b221d89a8 ("nvmet: introduce new max queue size configuration entry")
Fixes: 0a5a94648627 ("nvmet: introduce new mdts configuration entry")
Fixes: ea52ac1c6605 ("nvmet: add metadata/T10-PI support")
Fixes: 3f123494db72 ("nvmet: make TCP sectype settable via configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/nvme/target/configfs.c | 222 ++++++++++++++++++---------------
 1 file changed, 124 insertions(+), 98 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 8aea64d279c4..8d70cb8ac796 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -83,9 +83,6 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (sysfs_streq(page, nvmet_addr_family[i].name))
 			goto found;
@@ -95,7 +92,11 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	port->disc_addr.adrfam = nvmet_addr_family[i].type;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->disc_addr.adrfam = nvmet_addr_family[i].type;
+	}
 	return count;
 }
 
@@ -120,10 +121,11 @@ static ssize_t nvmet_addr_portid_store(struct config_item *item,
 		return -EINVAL;
 	}
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	port->disc_addr.portid = cpu_to_le16(portid);
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->disc_addr.portid = cpu_to_le16(portid);
+	}
 	return count;
 }
 
@@ -141,17 +143,21 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char traddr[NVMF_TRADDR_SIZE + 1];
 
 	if (count > NVMF_TRADDR_SIZE) {
 		pr_err("Invalid value '%s' for traddr\n", page);
 		return -EINVAL;
 	}
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
+	if (sscanf(page, "%s\n", traddr) != 1)
 		return -EINVAL;
+
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		strscpy(port->disc_addr.traddr, traddr);
+	}
 	return count;
 }
 
@@ -186,12 +192,8 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (sysfs_streq(page, nvmet_addr_treq[i].name))
 			goto found;
@@ -201,22 +203,29 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
-	    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
-		switch (nvmet_addr_treq[i].type) {
-		case NVMF_TREQ_NOT_SPECIFIED:
-			pr_debug("treq '%s' not allowed for TLS1.3\n",
-				 nvmet_addr_treq[i].name);
-			return -EINVAL;
-		case NVMF_TREQ_NOT_REQUIRED:
-			pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
-			break;
-		default:
-			break;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		u8 treq;
+
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		treq = nvmet_port_disc_addr_treq_mask(port);
+		if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
+		    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
+			switch (nvmet_addr_treq[i].type) {
+			case NVMF_TREQ_NOT_SPECIFIED:
+				pr_debug("treq '%s' not allowed for TLS1.3\n",
+					 nvmet_addr_treq[i].name);
+				return -EINVAL;
+			case NVMF_TREQ_NOT_REQUIRED:
+				pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
+				break;
+			default:
+				break;
+			}
 		}
+		treq |= nvmet_addr_treq[i].type;
+		port->disc_addr.treq = treq;
 	}
-	treq |= nvmet_addr_treq[i].type;
-	port->disc_addr.treq = treq;
 	return count;
 }
 
@@ -234,16 +243,20 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char trsvcid[NVMF_TRSVCID_SIZE + 1];
 
 	if (count > NVMF_TRSVCID_SIZE) {
 		pr_err("Invalid value '%s' for trsvcid\n", page);
 		return -EINVAL;
 	}
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
+	if (sscanf(page, "%s\n", trsvcid) != 1)
 		return -EINVAL;
+
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		strscpy(port->disc_addr.trsvcid, trsvcid);
+	}
 	return count;
 }
 
@@ -261,15 +274,18 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int ret;
+	int ret, inline_data_size;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-	ret = kstrtoint(page, 0, &port->inline_data_size);
+	ret = kstrtoint(page, 0, &inline_data_size);
 	if (ret) {
 		pr_err("Invalid value '%s' for inline_data_size\n", page);
 		return -EINVAL;
 	}
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->inline_data_size = inline_data_size;
+	}
 	return count;
 }
 
@@ -287,15 +303,18 @@ static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	int ret;
+	int ret, max_queue_size;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-	ret = kstrtoint(page, 0, &port->max_queue_size);
+	ret = kstrtoint(page, 0, &max_queue_size);
 	if (ret) {
 		pr_err("Invalid value '%s' for max_queue_size\n", page);
 		return -EINVAL;
 	}
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->max_queue_size = max_queue_size;
+	}
 	return count;
 }
 
@@ -314,15 +333,17 @@ static ssize_t nvmet_param_mdts_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int ret, mdts;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
 	ret = kstrtoint(page, 0, &mdts);
 	if (ret || mdts < 0 || mdts > NVMET_MAX_MDTS) {
 		pr_err("Invalid value '%s' for mdts, should be 0-%d\n",
 		       page, NVMET_MAX_MDTS);
 		return -EINVAL;
 	}
-	port->mdts = mdts;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->mdts = mdts;
+	}
 	return count;
 }
 
@@ -346,10 +367,11 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 	if (kstrtobool(page, &val))
 		return -EINVAL;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	port->pi_enable = val;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		port->pi_enable = val;
+	}
 	return count;
 }
 
@@ -389,9 +411,6 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	int i;
 
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (sysfs_streq(page, nvmet_transport[i].name))
 			goto found;
@@ -401,12 +420,16 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	return -EINVAL;
 
 found:
-	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
-	port->disc_addr.trtype = nvmet_transport[i].type;
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
-		nvmet_port_init_tsas_rdma(port);
-	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
-		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+		memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+		port->disc_addr.trtype = nvmet_transport[i].type;
+		if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
+			nvmet_port_init_tsas_rdma(port);
+		else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
+			nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
+	}
 	return count;
 }
 
@@ -468,52 +491,55 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = nvmet_port_disc_addr_treq_mask(port);
-	u8 sectype, qptype;
-
-	if (nvmet_is_port_enabled(port, __func__))
-		return -EACCES;
-
-	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
-		qptype = nvmet_addr_tsas_rdma_store(page);
-		if (qptype == port->disc_addr.tsas.rdma.qptype)
-			return count;
-	} else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
-		sectype = nvmet_addr_tsas_tcp_store(page);
-		if (sectype != NVMF_TCP_SECTYPE_INVALID)
-			goto found;
-	}
 
-	pr_err("Invalid value '%s' for tsas\n", page);
-	return -EINVAL;
+	scoped_guard(rwsem_write, &nvmet_config_sem) {
+		u8 treq = nvmet_port_disc_addr_treq_mask(port);
+		u8 sectype, qptype;
+
+		if (nvmet_is_port_enabled(port, __func__))
+			return -EACCES;
+
+		if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+			qptype = nvmet_addr_tsas_rdma_store(page);
+			if (qptype == port->disc_addr.tsas.rdma.qptype)
+				return count;
+		} else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+			sectype = nvmet_addr_tsas_tcp_store(page);
+			if (sectype != NVMF_TCP_SECTYPE_INVALID)
+				goto found;
+		}
+
+		pr_err("Invalid value '%s' for tsas\n", page);
+		return -EINVAL;
 
 found:
-	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
-			pr_err("TLS is not supported\n");
-			return -EINVAL;
-		}
-		if (!port->keyring) {
-			pr_err("TLS keyring not configured\n");
-			return -EINVAL;
+		if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+			if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+				pr_err("TLS is not supported\n");
+				return -EINVAL;
+			}
+			if (!port->keyring) {
+				pr_err("TLS keyring not configured\n");
+				return -EINVAL;
+			}
 		}
-	}
 
-	nvmet_port_init_tsas_tcp(port, sectype);
-	/*
-	 * If TLS is enabled TREQ should be set to 'required' per default
-	 */
-	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
-
-		if (sc == NVMF_TREQ_NOT_SPECIFIED)
-			treq |= NVMF_TREQ_REQUIRED;
-		else
-			treq |= sc;
-	} else {
-		treq |= NVMF_TREQ_NOT_SPECIFIED;
+		nvmet_port_init_tsas_tcp(port, sectype);
+		/*
+		 * If TLS is enabled TREQ should be set to 'required' per default
+		 */
+		if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+			u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
+
+			if (sc == NVMF_TREQ_NOT_SPECIFIED)
+				treq |= NVMF_TREQ_REQUIRED;
+			else
+				treq |= sc;
+		} else {
+			treq |= NVMF_TREQ_NOT_SPECIFIED;
+		}
+		port->disc_addr.treq = treq;
 	}
-	port->disc_addr.treq = treq;
 	return count;
 }
 
-- 
2.34.1

