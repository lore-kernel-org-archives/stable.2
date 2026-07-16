Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B741431488
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212836; cv=none; b=SFK52XUTMYvQFA8u5fLofUpmF06z5uEKOLPEYh3E61RbqkWELxsiJMOnBS0CqcQnzNhBDmqioC3k2bnEcIVul4A+qtXUZrQ9gazxkMpE3+rV4dzHKxUEcU8lze6cLUTrODMNGC+t61CrXkioASXVQiZ+f+9w1ymT6ZtdDzzJ8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212836; c=relaxed/simple;
	bh=jTPed7eE035vhQ8rlC8ZfmFszbglDwnM4zRLkO9bRZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtqkMIHL+n6TSckVSWk0L5PURWMBbymzt66j2G9639ModgDCpUjZySz7skdwBjP+LfinKJy8hwO5FHfFSXB29NWKfDpA+xLAt/YXNeXAErMKNOT/3O2yASkeuqg94ChQNLPEWO5flE+4j3PLPj7VwFJUJZTJn5lWiUa+ZrasihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8g8IaGv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8g8IaGv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b1710405so37304445e9.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212833; x=1784817633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpcBzLLGhgmpRm2ChWHisnZOSJCjUEDvDGQ4AxFAGiU=;
        b=e8g8IaGv/+dOx/xAX1D9i0IZ6Zc5MgwrnMDSnhurS1H+g5srub9iSnGtEFeALeoNGX
         56T/YAD7mH1ZLD8sxYJlZ9JmPH+TtrC6d4ThTab1+BrRGHQ8pl4frhMByxr+kqrJyx9E
         jqQanBAE2aqZ2NqrT3ejtwdsaErb54DgBqBm3ctB023OToUfqy4v1n2OOKBmbuSOQGmI
         996yiHHFYZpbQWwx6Z8Lpc7cnR43INknYp9zM4uotrAaiG3BwTkubSs+Q8D1/BoqNaGE
         H3gA07L0vj7K/lYo6JJ80BIiVweueNrey20AY1YkOj5aQHDcHueKSHvvLGCgLsZyIvTL
         l1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212833; x=1784817633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpcBzLLGhgmpRm2ChWHisnZOSJCjUEDvDGQ4AxFAGiU=;
        b=qKgF4gLTJbq8ZFAhQxH+Srih+zLL1eN6iuwnjCXznWfw8L2CkTcPSJ5vvYRU5YtxxH
         my38HD8Eu1ax/uXU4KfKVdFE/WGpOmHGUFFbl/vpA8KxM+J0k0AzwVWtLmZJDbmeSxFm
         S1t1FotiYSk4LwoagqUzvOnl0okHSe0DaTZ3ffI8CMi9r2nhh14SlDTGjWO5Tbks7RAp
         S1QC80Yv91Makh8boMwdgB8CjDjnaQNEQAMyX3IrjBYYP1Wd87PcyJp0XGBd+7DkMDij
         Ktt6PPkxryyTHA+QSGtk3nCj6ByZxDH9LZJU6FZM0SsWGpKwMdzquj/l9JfDSOz4TOHu
         +8SQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgpKJU15Dk1/jovJfuo4bSf44XBVhGruVv+AX+rQi6hT2WYk1RyTKjmkXsb7jii7cEMPmv59g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSrwjvHsC6QWN+4KUzL6VVMrBq71i9zV01eV2G8T1BlsuCRpy
	JJSj7E9DJSKVxqAPP8EzHGVABXSW6cl6i3HCT82NPP6lmY/5PTi+maqX
X-Gm-Gg: AfdE7cnaQxmvLbjz5PFAMb5z6vpmkHCoBGEVKAqmBmF9mHHDgy6A8ZALPIUHE1XP2cj
	n6XAZNBWGnWAFpoq1/iSAFYdL7wg4nBQpSi7Fi0IisOvsLVsZnSMMWbiVbzNpkukSG1QfrZxXJJ
	ilBxFyOI4Ou81cgHAu/C+bFEdAY1+NJCAyykBCoRnChODsJsT8NAR2SkEIJOKZsFveTIRO841CH
	ATK2RwPgHM767TI4DJ7XVlID0Ew1GsblfjMo6IorpxfnNobgDNYygqgjYQkZQ+toWDPq67HRILL
	9vTGGJmBPAk5gNPS9TsorVf8FfimzBDyH1qN4/4II+Vq99wMi2rgiU5t0BRdjPW+gjUqH6eARzE
	tVZiuwbsBNJ20dqgbzPiEJ4KBd+Slu9uVHPzCniUn2HfnsaMoz9r+Z7jjXv1JLZh143VkeJKMSJ
	dmvHVALcYXazKQ9EsqEsylfyK1nx+K6zIHO1Ac
X-Received: by 2002:a05:600d:6443:10b0:493:f762:45d4 with SMTP id 5b1f17b1804b1-495158c693bmr120308635e9.2.1784212832541;
        Thu, 16 Jul 2026 07:40:32 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:8529:198:eaf9:708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb7372sm85145815e9.13.2026.07.16.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:40:32 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: reject firmware sections with oversized data
Date: Thu, 16 Jul 2026 16:39:38 +0200
Message-ID: <20260716143939.21903-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In panthor_fw_load_section_entry(), the data size to copy is calculated
without validating it against the allocated section_size:

    section->data.size = hdr.data.end - hdr.data.start;

If a crafted firmware sets data.size larger than the allocated memory,
this could cause a heap buffer overflow in panthor_fw_init_section_mem()

    memcpy(section->mem->kmap, section->data.buf, section->data.size);

Additionally, if the section->data.size exceeds the BO size, could this
memset underflow the size calculation, leading to a massive out-of-bounds
zeroing of kernel memory?

    memset(section->mem->kmap + section->data.size, 0,
           panthor_kernel_bo_size(section->mem) - section->data.size);

Reject section entries whose initial data is larger than the section size.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 986151681b24..a338c4f0a7f5 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -545,6 +545,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	struct panthor_fw_binary_section_entry_hdr hdr;
 	struct panthor_fw_section *section;
 	u32 section_size;
+	u32 data_size;
 	u32 name_len;
 	int ret;
 
@@ -595,6 +596,13 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
+	section_size = hdr.va.end - hdr.va.start;
+	data_size = hdr.data.end - hdr.data.start;
+	if (data_size > section_size) {
+		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
+		return -EINVAL;
+	}
+
 	name_len = iter->size - iter->offset;
 
 	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
@@ -603,7 +611,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 
 	list_add_tail(&section->node, &ptdev->fw->sections);
 	section->flags = hdr.flags;
-	section->data.size = hdr.data.end - hdr.data.start;
+	section->data.size = data_size;
 
 	if (section->data.size > 0) {
 		void *data = drmm_kmalloc(&ptdev->base, section->data.size, GFP_KERNEL);
@@ -626,7 +634,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		section->name = name;
 	}
 
-	section_size = hdr.va.end - hdr.va.start;
 	if (section_size) {
 		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
 		struct panthor_gem_object *bo;
-- 
2.43.0

