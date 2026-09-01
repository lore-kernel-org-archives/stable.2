Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D70483809
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282543; cv=none; b=QmdV5bbEDrvjCdKx1j7mfDCVw3MhiK9NWukADFw4KX0NeYMXl9KNiTqywup5QBZgQ6WY+TCl2Sc2evqkJqS+juAfeDQEQLaDAdU/kUdroyi5UwkJJ4gSJv54WYCaGavToGwgC7Mi09hSNW2MbF8Iy//hpgyPsBgclJn0ipsuaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282543; c=relaxed/simple;
	bh=Q0EerqSgGvmAb1C2z/3u7uYu/BE74lyAF6uYjKyCP+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTJT5Af7+hkunIj74Cu8u0WwKo7Mq68ClhOYuYJtYb5irq0i/AczbdB8roCrzEtGAjkWxjdghoQY3QnHOYrqY18hutqByeDnAmO5beGZRmqucBjSnXF6d6V1thG2oybbYfXFiFSq9lV7thgL/3ToMrSzeQK8F6GwV3uKp//95dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=nrEyMyb6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="nrEyMyb6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86b03b75fecso3805707b3.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788282541; x=1788887341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
        b=nrEyMyb6yloX77BHAqQ9NIsW3Qi7cS5aNddBQPZqrXW9TCaqr9qxVP83JdONRObk9X
         Y83RoBAaegJJ3Hn3QaJEROuo5kqMdlKp99jD3IQH5Va+HCuUWwBKz4pGl0OEQhunOEqi
         Hgq5i5+7IqfWpdg8ISKaJEXM7y/jwyr7jWURem+6uAyWdJxWFTCWZriZJKPkBajPucqC
         yOuUK15dgoN+vZiMuKq7e8UDnADTcrqjPpHzjR6pZ93GBma1qGGSa0Idd5fNYPzCG0W1
         Q+1tGC9juE4Gt5A+uE+NmhxJ4GZ8/u1NTrzQ/Dwect0EiIKPEQ6T847gboHvLBHcezf9
         IkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282541; x=1788887341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
        b=tVOLcNO07A/qwSGTfqXH3Jyt/ZjziGsCHYWvc2ZpvxzIPO1umEmM5SyaIZYScTESeD
         mVZsufyzdSI4LEoqBaMEbEncZR4HsLw0lxICPuIgn4BcpYz6Fes2tKUiNqX6TMeOkoSn
         44qs2TXbfdrmmAd7NJx7ekADRT+iFmQfxbWEl/kMTG0lofm9wUcw6PZzSG7uA65+cQDV
         zWr/bQdwZSGXmUmg9OVrV310mJIRpLY2+sKZEa+8lSl4lKQy+Zlxc897G82kDPklCZvD
         3u/3Oc95W+17npIbkr5l1d5x+vVK62TU+dSBi5+ulNnSjOjHFPn1us2V4zXIOSF/CLBS
         POXw==
X-Forwarded-Encrypted: i=1; AKwUvBw1XeOUL82vATaihI/RZpO4aeQXBml8vMx9o/O36Um3RhdupbT/JWWmGa6Q47OPikpi/MrvGfk=@vger.kernel.org
X-Gm-Message-State: AFuF++nJiVg7F3x7/8zcBmuQyw0C9k0OyKEOws5X2fE41+UON3cZR+dl
	zfvDOyhbB14CUptJ1kHqYyxzWgOTI67/r0+bh8Ll7WjFySx1xezbRHGN3DOaztA+/rvp
X-Gm-Gg: AYBFou00zqvCrz6PbdXbBXUDo5KtHiESMrWByZOCvGVF9g2W10bcDnxSRa03hxwJf3Z
	ZswtVivi/n0U/ABrd6enYpP+ura++agxbjBsiFK+l3jA+tzyQneyTmhymGLkA9bvcfokQqRBkmG
	kcC31wXiSpWeAjDCbC9ETX4CBQGWNrxeE0QS4Lg5ME+z7Eixc9tl/7YMn132wQE+X4YZRbg0yeU
	4V9vbrlzCic8okuaMwBtvbokJOh1VW74b9i1xYWodP4qnIZ4JwhXygJ19zkAB2ASyKKZcEtv9fB
	n3GWtvS4cqD1wIWzDkQ7w+uzLAfqolH75Mf6cUqnWNEq4MkA81CveuzsFJjKZF2kNTP/cYNSSxf
	fz6rPUK4pt4RCuvc9QWO2gRZLyxAzJCgi8ZilJZNvPISUzmNNbuzRdmPtMg0FpFmC6nx+OOcnd5
	ce90y6kc72vBRxnmBXo+t0/bvbM0EBqbHH6i6b35Nb9aUaIT5rsTry05hZiALo5CGHAQJ7ZcYcZ
	me8wJkgL6qXL5b4KyMHqXry7vo/o0jWqqxQYoJ22dyUjagMCvYERH7f2nUjmSbXo+JzuXNzzAwM
	NQ==
X-Received: by 2002:a05:690c:c3f1:b0:81e:98d3:cac7 with SMTP id 00721157ae682-8686f52fe19mr38821267b3.12.1788282539975;
        Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	chriscli@google.com,
	david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	jmoroni@google.com,
	kevin.tian@intel.com,
	kpberry@google.com,
	leon@kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	nicolinc@nvidia.com,
	praan@google.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	viursachi@google.com,
	xuehaohu@google.com
Subject: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Date: Tue,  1 Sep 2026 17:08:47 +0000
Message-ID: <20260901170849.4052816-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

This series address two related issues in scatter-gather mapping,
specifically for the MMIO based dma-buf mapping. The fixes ensure
sgt mapping is correct, and proper for large MMIO regions.

Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
(Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
phys vec to sgt)
https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/

Patch 2 Splits sgl by largest page aligned chunk
(Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/

Changes in v8:
 - Combined the two patches into one unified series to avoid merge
   conflicts.
 - Collected Reviewed-by tag from Leon Romanovsky for Patch 2.

David Hu (2):
  dma-buf: Fix silent overflow for phys vec to sgt
  dma-buf: Split sgl by largest page-aligned chunk

 drivers/dma-buf/dma-buf-mapping.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

