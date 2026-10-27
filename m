Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113771;
	b=feICj9OwiCx8r0745y+MiuoEuc7M+iKaQlQcYp0fSwcIHdY/dZBpe7XhwwR8fieDcg0T
	 i1R4xcjH1LD3x2iOBY/v15u6fL3FV2qZqcn7WO7rdqoNVCNe+BE4LGlSD3wARe6cvxrsX
	 AyseSSk16BH432Z+0kI3OQuq8dUei/LvNzBovyHCnrGgBTrQl3xskb/n0Zoak2NHTeZoA
	 VrYn97F8XZwoM4hwdgXJZxVExyNWdTEFz+/dou1VpNOfEBlDhoJzGNNdGx87m1OrmBlM+
	 AJrdvIpuexMUVKlP79v/UtKlk3jQ+X/vtt2WJv4SSYlckBqLtwWt0k97hCw1nE58wJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bNcskWWrObU6xyaHbWvG80GKO/ps3fkYEC50TXpqK7g=;
	b=cXZBCW+8syRY09PfYblnayXY7ahX1kw1ivrrWYmX1s/mlo3rH3WsdFuavi265xUaU93E
	 xqKTBoPnQU6DQnFE7X7zGuFfncOXTZTWjAZr1JEORD+p5FD3+icW058z8ecdDHuYiJbwb
	 HvKs7f85Pq/oNUSz7DD9y6wWiZMs0/1nIrbM+Ov1XATfEtfR+s/D0gDssXUwHnRc06rqc
	 QG/tn91YwMXk1ijqVzbW09aAJW82PAf0fJEa97O5XsiI2z+AIPfA8NZC2xQ5cBIMdCVeE
	 ZrORpqqWwobC9dPOerhdKBn3YpI9lnyzcBBvKzDIbj7Q1x/WhCc+fOlWZarf35F5A2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLf38993;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FD606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE6FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qLf38993
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e942864693so22607415ad.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113770; x=1793718570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNcskWWrObU6xyaHbWvG80GKO/ps3fkYEC50TXpqK7g=;
        b=qLf38993ZdVcRqJfR/ZyaGYo0s9QaMq6TX16I3tpkTZQiYBIVkRgYW65IJyndUFfV+
         hMbe4m2vc/7cNL43gVOwLyN2QRkBoIFlv6oI5E0N1mRccaVli5tiUR0b9w6gGheTeAli
         q/o2I6+QobFt+OJJ1kn5GjmY9y9R7hC4kEmUC7lPzNgliE8cNsEYK7top1KTdi51aDY3
         25ilmlEInj5SKUZW/5lFzWrlVaXY+LvNbvWg9hJVCOFMCmVf8XRBv97Y7rG6g+OWcSuC
         5DIXmFNib7uoUqrBTBaOp02MF71gI/7tWDVjl0Jg/Xb/8P8AQM/aCSHsNFhigjw7V454
         s/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113770; x=1793718570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNcskWWrObU6xyaHbWvG80GKO/ps3fkYEC50TXpqK7g=;
        b=qm4vmIhWivJjPdvcPeSiFvDXCPKy5mp8D8DJGZR2p8+32+eCN2s80yG7dBlRWiTX3n
         hvsMxPVyr72huflIvxoNtFw5Nx682O8qUXYP5CQIR1ErViJDo+Cg5dz5+SbuX0TL8GNf
         eDAgCLO6dHg+G02tHBUeaFUGSNMewlDSUQdGBJV/YAD/HxZD7I3JUxmWoJCp26paJbzI
         Kc/iKUfXtNOn2vQSZhqjWIiSQWQ8WgcjtQPVC5dzTyG/V8IpzxL8uEph10DeUjR7cXTj
         MssK/SkGTN+zhrHbd6dqIhFT3rPozSKr4lYhUjEiRUjLaQ8mpIvG1Wj2cPKCa+yZrDPe
         qQPA==
X-Forwarded-Encrypted: i=1; AKwUvBztHM3LLLzrwHn7cchkMzvt1Ul61QU8FzjOShFOaH40laVNd1aAToHjzPhdPYtnYHnu4B7xdzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXnpilWLXZCpL09wk719CW424VODOdpdWeU/BL/ZVRGjab9lfh
	qX531tuGPAigYtxWN+o9EM5DR68DRfAW8V9vBHYL1yTJE6S2pmwx/0s+MUW0+LLFfUc=
X-Gm-Gg: AYBFou1md0Got5gDh/CEbu+wlzmmaFgap/y7LgN6I19n237jRXzg/gzHnX+jLzcP6Z+
	CaRNl2RF9ArolJPEqSnpEhXqPc2J/Ds+rEHE+U9NkHMvh5XR2ZC8OdmwJHPn70bU9v0nzCZYpYe
	FVhM9rlSRd7m3jSmPbz17eWa3MyflT19sMlRrme7zc92zsR95hGQLeOc9yCnX45+JtJtk2Ws4R7
	y3NyZBcO62uOA2O8FZG8Y4Y9QMFFJYjpmgDe/XGUb9tupdMamOGnnP4y92o5uf7CDoqPZoOB9RF
	EqOD/9ovt0BeQspFIRLFZuMmegaxdOFtUksmpgBvwGV97dnM+PVOFRDH9JC0wlKOh9JZiHqshN9
	SU8uKx2VpYvn2fhKTybf5JjWHnlC6u4kxmcU8ZS5PaQ07AUx2tkxiw27CPLPBaQaXcmak0CnXJv
	5WHJphprsuNYXXyLbv4nxhkun/srrfEfXRt/aK3mm4UpPsop1lUmx7vbnZ54YdkK2hjm293bcm0
	/VbauBCCeJn72Kg5vvD7g8OraKZn6BtG0fk2wZvGFf2QAG+7GRKmvkxTKQPWyyP8iLfNp0DSLhJ
	XcqPfDJUP6HumeEvE4blzevvFS0=
X-Received: by 2002:a17:903:390b:b0:2e6:24da:a4b8 with SMTP id d9443c01a7336-2ea9c83f978mr88983565ad.38.1793113770023;
        Tue, 27 Oct 2026 08:09:30 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae64549dfsm11334995ad.4.2026.10.27.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:09:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Olof Johansson <olof@lixom.net>,
	Desmond Yan <desmond.yan@broadcom.com>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] misc: bcm-vk: fix DMA allocation memory leak
Date: Tue, 27 Oct 2026 23:09:21 +0800
Message-ID: <20261027150921.137189-1-lgs201920130244@gmail.com>
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

bcm_vk_dma_alloc() leaks dma->pages and pinned user-page references
when page pinning or coherent SG allocation fails. DMA mapping
failures can also leave the SG list and earlier mappings unreleased,
as bcm_vk_sg_alloc() skips the partially initialized slot.

This issue was found by our static analysis tool under development.

Fixes: 111d746bb476 ("misc: bcm-vk: add VK messaging support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk_sg.c | 43 +++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_sg.c b/drivers/misc/bcm-vk/bcm_vk_sg.c
index 8662bb865129..b237a5332b7f 100644
--- a/drivers/misc/bcm-vk/bcm_vk_sg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_sg.c
@@ -78,7 +78,8 @@ static int bcm_vk_dma_alloc(struct device *dev,
 		dma->nr_pages = (err >= 0) ? err : 0;
 		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
 			err, dma->nr_pages);
-		return err < 0 ? err : -EINVAL;
+		err = err < 0 ? err : -EINVAL;
+		goto err_pages;
 	}
 
 	/* Max size of sg list is 1 per mapped page + fields at start */
@@ -90,8 +91,10 @@ static int bcm_vk_dma_alloc(struct device *dev,
 					 dma->sglen,
 					 &dma->handle,
 					 GFP_KERNEL);
-	if (!dma->sglist)
-		return -ENOMEM;
+	if (!dma->sglist) {
+		err = -ENOMEM;
+		goto err_pages;
+	}
 
 	dma->sglist[SGLIST_NUM_SG] = 0;
 	dma->sglist[SGLIST_TOTALSIZE] = vkdata->size;
@@ -108,8 +111,8 @@ static int bcm_vk_dma_alloc(struct device *dev,
 			       dma->direction);
 	transfer_size = size;
 	if (unlikely(dma_mapping_error(dev, sg_addr))) {
-		__free_page(dma->pages[0]);
-		return -EIO;
+		err = -EIO;
+		goto err_sglist;
 	}
 
 	for (i = 1; i < dma->nr_pages; i++) {
@@ -121,8 +124,8 @@ static int bcm_vk_dma_alloc(struct device *dev,
 				    size,
 				    dma->direction);
 		if (unlikely(dma_mapping_error(dev, addr))) {
-			__free_page(dma->pages[i]);
-			return -EIO;
+			err = -EIO;
+			goto err_unmap;
 		}
 
 		/*
@@ -167,6 +170,32 @@ static int bcm_vk_dma_alloc(struct device *dev,
 #endif
 
 	return 0;
+
+err_unmap:
+	/*
+	 * Unmap completed SG entries and the in-progress DMA range,
+	 * which has not been written to the SG list yet.
+	 */
+	sgdata = (struct _vk_data *)&dma->sglist[SGLIST_VKDATA_START];
+	for (i = 0; i < dma->sglist[SGLIST_NUM_SG]; i++) {
+		size = sgdata[i].size;
+		addr = get_unaligned(&sgdata[i].address);
+		dma_unmap_page(dev, addr, size, dma->direction);
+	}
+	dma_unmap_page(dev, sg_addr, transfer_size, dma->direction);
+
+err_sglist:
+	dma_free_coherent(dev, dma->sglen, dma->sglist, dma->handle);
+
+err_pages:
+	for (i = 0; i < dma->nr_pages; i++)
+		put_page(dma->pages[i]);
+	kfree(dma->pages);
+	dma->pages = NULL;
+	dma->sglist = NULL;
+	dma->sglen = 0;
+	dma->nr_pages = 0;
+	return err;
 }
 
 int bcm_vk_sg_alloc(struct device *dev,
-- 
2.43.0

