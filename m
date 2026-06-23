Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E53845C4
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224357; cv=none; b=gr9H8Nu10XW979i7+JV3hRwThZHzDO/ZXJzvF5SxS98WlZSigrRmYLjfiNUVmGqBCm/ZHOdSDGEVkjdPcaPtBdkJB/LpKKNfSLcjX+omtg9N3e1s19pvsbvXwuGFbivNFhHKcHtBRgw1DGmzwJsmxFwuct0cyxmqG8Hm0ffKpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224357; c=relaxed/simple;
	bh=HJcckcb1tmwcKra1TI77JdVCL++FTLRkdVJg+FBYLAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZi/JXrWNE0TCyS8BGAMGbMJOd9RpK95AIYFpfu9kovME0EdJ+r7VeZOzvUDzpbZiitSn2aTYYRAo3o6nHbCkCcRXBz3tf46hVYw3b7CWm4zWTm29q6dgs85kIi0Xom25RvSN0RgJkaf0oFWW/inpN6Yvtf5Nl/VoZ0P/hgTwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLphn3Uz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLphn3Uz"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-399735e64d7so63942281fa.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782224354; x=1782829154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9l5vPuFiQ6HlKIilyz6JJBZ99660cgcQoT5otos/iI4=;
        b=DLphn3Uzpl9cROgJ8X9/68XvbpAPQ3jlS54AV0UXIwU2uod7wfSeEFRw1HBR2fQ6ZR
         oWAG3m5v8abo4+ZJLgjqDDdiSqBTOVS388IZ3hyIcFldEdjIqxMq/fOg0ign9zrJ9LLj
         2xda4EdxZ2c4bPpc4O89jDy0bX6yAM9BZU0jMg2+xDbe77CNNJmuAqu82EqxjltqEUh1
         JhVRjYWkLgS1+V+JvQtfCdUPUKB/V+AMTgY9x0CvBVRucZupvHu03Uvkv1ghZiKg1okc
         74SPZiW0e38IO0QYFsvG0UoLZXGPPsKVu5SdrPq9XRvmxjsn8jByAMrnN9sh9P+nchqA
         RkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224354; x=1782829154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l5vPuFiQ6HlKIilyz6JJBZ99660cgcQoT5otos/iI4=;
        b=frMVBdfx1xuNyhm2i6xkFO5Gi39IhVX9atn0YkOh1mulBiNRsYhClKZ6pVUXYSehFp
         xrzf3LxypTDqxsk/wTNJ0CRWl9iRfQBPGrnorKaO0sf3VszHzqcsXnfDAFhsxJXZOs3w
         C40BgIu9J8uJnqmSfx3JbAr7s0jaFQrf4mVrAv8WmyOYqobbWRPDA3rChnsT9xmUw9fG
         PoyyJI8KpAftve2ggl8DF3X5+QyKYcq63lg/UfK5G4Y7hQsR8geBtbMT5AF0NXzIdamj
         P978DIBtRRx56ZCLK5ruP7/L51BUy48dPqcYyAvBAwnj5O5eFhq7KTfuTRbAFQDrBXzH
         V89g==
X-Gm-Message-State: AOJu0Yw4RuXDUdZair4PKGkmqXRmBNdhEwJzsCDNz9L5nfqv+DKCmp/1
	lTvsjaPxaDOh/rG4B8ETK33Dur/SE+BsNgkHpTHaNZ8yMsokiV80f1HwkYM8+KLA
X-Gm-Gg: AfdE7cne/iI0HHJuLG2/i3J/pJFu/w1vHdDBxmfp/kCIabVxxb4YA7nHJAZ3XjJbkGU
	Fv0pZdmm+s7G2+J1nteGru4qFodH5Er9gVYGqtZk3mQc7Uhnqep2ErHbNvwPOMA85E7Mb+dObJu
	ZJ9wRVPUgc9VJuTNor/tGVzkxFjLGCZJIwDaaygueDLrUTrzZJjrUDX8lNByJrvcaKsjjTLtRKn
	kjx7YH+5QvSr7YY8PKpHRWCSN6kajKpeebyfiRkcIXYlkBW4veQMj93xFukPJH4Bc2Hes/XnimG
	sdWIVT1EkKEE92zQR3zSi7H0bSJ89lj1sAnm5Y6aw/b4c1A1EpI+IsyUPww+6BdkVYre+gIaXA8
	ygb4D0vEMHhoBr396FNu5el75WBeWz32rTjsmlnOY1OcWIffq4l8K8585rZTs+/EHRxlc/Hy4eN
	u26/tpywfe5LJNedcD7tq1TlRryVAK142JPI8uGh8ppV0Fo8wY6C+A1lANVQlm0Fy27i96c5Qvf
	CrRgJPfn4HpPEtWgeuEyWnr5IaXd/cN1578PmBZ4B0VfHt4XgpAKMocQw94dJ8uUL6kWvAwtvx/
	B4f2rMIbHjJgBwa3DXhPX6TiwqywHjjUv0DexeAHJakhoCZMTqr+
X-Received: by 2002:a2e:a5cb:0:b0:396:7079:5e3b with SMTP id 38308e7fff4ca-3998bbfb36amr48813331fa.1.1782224353683;
        Tue, 23 Jun 2026 07:19:13 -0700 (PDT)
Received: from ghostnode.. ([185.213.154.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afeb521sm25437181fa.18.2026.06.23.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:19:12 -0700 (PDT)
From: pomzm67@gmail.com
To: stable@vger.kernel.org
Cc: selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	eddie.wai@broadcom.com,
	somnath.kotur@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	devesh.sharma@broadcom.com,
	dledford@redhat.com,
	gregkh@linuxfoundation.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
Subject: Please backport f6b079629bec ("RDMA/bnxt_re: zero shared page before exposing to userspace") to stable
Date: Tue, 23 Jun 2026 16:17:59 +0200
Message-ID: <20260623141759.1231452-1-pomzm67@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>

Hi,

Could the following upstream commit be queued for the active stable
trees? It does not carry a Cc: stable tag and does not appear to have
been picked up by AUTOSEL.

  commit f6b079629becfa977f9c51fe53ad2e6dcc55ef44
  ("RDMA/bnxt_re: zero shared page before exposing to userspace")

It fixes a kernel-memory information leak: bnxt_re_alloc_ucontext()
allocates uctx->shpg with __get_free_page() (no __GFP_ZERO) and then
maps the whole page into userspace via vm_insert_page() under
BNXT_RE_MMAP_SH_PAGE. The driver writes only 4 bytes (a u32 AVID) to
the page, so the remaining 4092 bytes of stale kernel memory are
exposed to any user with access to /dev/infiniband/uverbsX (typically
rdma group membership).

It carries:

  Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")

so every kernel from 4.10 onwards is affected. Please apply to the
6.6, 6.12 and 7.0 stable trees (and any other active trees you deem
appropriate).

Thanks,
Lord Ulf Henrik Holmberg (Defensify)
