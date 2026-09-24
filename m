Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E848592F
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286553; cv=pass; b=ANMifdiCdRCBKSI6XQDROAcUAS7qUsEa1GQeTtIE1Ui73ItMEiU9VyesUiK6ze9qmh/QZ+UNZq/uq1YHaOkXpIFTtZfV2VDD9RzMMgvTDS7OvHxw72fRZUEVZ+HPDGfKHAUFISKhfGcFdLgl7EE3YUahxFGkUHQWCuvdBqMemfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286553; c=relaxed/simple;
	bh=TCCbAICDWR19TnUzl01zmd9m7fi4SdDKlnltiF2/v7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CxWt5tv3X1Jn9r4aVuD7mbqVLdB9RkjQuf1KBqChO2GRRLlJMORsG8jBNFEcdLwSeuv5Ew8jgvJnW9YL6C/4YvCIS9FvKDbIMPnXYVX/hSQ2kMpNjPmnpKqTPqqXPVQyRk3tvjG/v5bTXOV5cx98KXym4xDFkrquHWuUe1NQ3uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipwh7OT8; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipwh7OT8"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so395289a12.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286550; cv=none;
        d=google.com; s=arc-20260327;
        b=W47RbeCOmwPqKfZPqMRnUXkaNhv3vmtintZELK6gGGhn6Y5WbYGtf019AXnA04j6tx
         CU/abw9FqPTSHil8oQzjNz8vO5UOSA+ZuvTFVv5/COUgjFWFjTBLdly69rLRXNn3/6Ye
         oRrrFCzCuFEAS1t2uYHzXK5wApoB4LxZevfyIRcY1Ip9cyCqxoE8k4YkzbeGfBMLeP/3
         M7V+JH7IHa5MgHsQvhlt8jowPsfanfSwh1oUUYDL31kGPDdvtI6yNKS3RwR+gfRfIgnW
         2ITRiI9qkfXCNNvYKCCx4ZEtjML8BJxQ7ueLvThKpDzgRCzEJuVJYth+hcVoyMrfzSgc
         KHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=d+iT0ll470CyEirfOqyWHR0qj8lIbwjV9NYAht2tV/g=;
        fh=6wdJvlpeY8Kl2x+eP1NrTLvzXne7YgkavqK8SvFX46o=;
        b=kSm/dSwhHgkDTvxFDPLSOhKVIRG31gQSsGzzsYblaM/Kqpj6E4I66MH9p34buDX89S
         Lduo/LDwHhLsjDzz3LqnObDrLSA54a20ZpkmrTwsJNqD81vgEt5iupjQYnWh0pbeCSsc
         fN2FtozVr++UaDFiuSDZkCO8Pm/NGGDObxCZpGWaLOsH6EO5MtyjlUXMIkxrWhF59fTy
         mTj80jxFox8sjjgtNXPh/i0lL9lsK3i99j2WXw0fdyccbUHWNcWRLlgmH0VsjOCR6qkj
         wTj736X94MFQisE0XKyBVuORbIr8i9jKJcoigrdFnwq5w3+LNEzM9vm9c8PLMSjLp6La
         6FYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286550; x=1790891350; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d+iT0ll470CyEirfOqyWHR0qj8lIbwjV9NYAht2tV/g=;
        b=Ipwh7OT8X5p1zNbtTYrFOv8mssPaXUVA8oNG7rxZtSbkBCnlbyEKsxrrIK1acYPRtR
         30Kg6pfq2BNOqN01DtP0x9qFiFNtWVmJXHl9WXfN8tZLc5tDS7khpIA1fEHYEvIX1csb
         5wlrt83z77anyWBZkUGFMO3ese6zHgbgMscTBD8h3Xm0Unqsp9mzGHg0BbKl9b1eItM8
         hO7kqds3Mbp5QFVXnPsvNL9AkI7DxxK7AAS6d5icV3pefOvAn4VRhrDT+eu7at+2IGk9
         vEWfo5uCmlnbC/A31a8BPTSZrMUSEBjSB9vRgg0uy/N6k04/bk3618PPmaAsvLH49oXw
         63KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286550; x=1790891350;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d+iT0ll470CyEirfOqyWHR0qj8lIbwjV9NYAht2tV/g=;
        b=fnNhRDqi6wNT561Nbu17AOVqLnnq+uyT6SC7i+BPNtR2IJ+xfjjGW2NSODviJNqMpd
         YWQzgLBn5ZGUB/rKYlShZv7E9U0gTPNjRVLUlvejVKI6O95FMWkslwg9oVOk44UVZH6O
         y5K86Q2E+/bLXAZ0Tq+aPb7T3NANMHW7gemMFQSViAGXNIMkYh2WCj8gN+dtCZzhQZg2
         LPkucK73KSlvL9rQfWkz+1l8WAmdImXL27YwbJdBbOX2gXKIKYPXWpbRziMmdw3ku3QT
         yQLcNdPYcS9CmTLuu7uqg+X8lL3Z7vWQTXLlbYpTY0CrYuu0sEF7OIf4puTvC6fAP5tc
         BxdA==
X-Forwarded-Encrypted: i=1; AKwUvBx+dxrOsjkC8FnQ0TXFsc1msPrjwKRNqsc7kQO915voW38s9fA/GmEeZf+m0MaBe+N95sDRvkI=@vger.kernel.org
X-Gm-Message-State: AFuF++mWslrpk19V35E/27LgjUDgPVCOEnqUQQ+dl80zEZ64t+dV9soo
	IZ2hpcunLZEwo0+dHosQ23yv4Y1ymYXfFbMo3+aazI0kvD9Eb3qjU8ERNgLM38cUxc4pqSD+SDx
	/n40sYihi3wRrcdW5P+MaTrPlQkHY+g==
X-Gm-Gg: AYBFou2y7IpF3vjtx3Z88eSNrloVEOvqQqpT3mY6F8rK5cwkPYpTAq1rBddpnOpRZSL
	wzvgiprrzC181PsPYZmgZzmz6s9ZcZOb6W0XsbjfqQewtJGgAdpIzI3XC8XBXyrcmHtjMjQ9W4c
	YotN3gHukLCM71Ki6D6QiF05qGVKz0Jjoy0WbxH/XIhMEt1cmug9jXE1EDqLh+kRA2D/1w4AB2Q
	lSMAsj5k/zSK7Ui7t/S+HunQvTi9VpM2tOwpzzF7TMyyHm2EQpPW6XG4hjub3/plW05KRXZpKTf
	P64cHwUZnSjAOHYllMcdAukTwfGtSNxZqD7pOfBSE5inIrZqk+IV7a5t4Fb1v07QTTeWlKqgz3b
	IWDzW1dzj6YEQcg+zVtq4zvQeE/VyRYd3v03CpPbLNgYBTiriKbhCceJqVq4G7Iir
X-Received: by 2002:a17:906:730e:b0:c29:f5d5:5a91 with SMTP id
 a640c23a62f3a-c2ac23ec161mr338520866b.27.1790286549925; Thu, 24 Sep 2026
 14:49:09 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 14:49:08 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 14:49:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 14:49:08 -0700
X-Gm-Features: AclHuK-ifE8Wx3X7PnhgGIrI4SsuY9g5qXNEZVUc3M1mKA7E9YdCoPUOmRTEtYI
Message-ID: <CAGEsz8HmUoQq7XLr5ZN7diWt-sWYoUwYd400vpq5jYEDEB7_vQ@mail.gmail.com>
Subject: [PATCH v2 0/2] media: amphion: fix VPU core lifetime during teardown
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vpu_core_unregister() releases the message FIFO buffer and VPU reference
before draining queued message work. An open video instance can also keep
a pointer to devm-allocated core state while sysfs unbind removes the core
or its parent.

The first patch drains message work before releasing core state. The
second prevents manual unbind on both platform drivers and warns if core
removal encounters a live instance.

Changes in v2:
- Move vpu_core_put_vpu() after the work drain.
- Keep runtime PM and mailbox teardown unchanged.
- Address sysfs unbind in a separate patch.

Myeonghun Pak (2):
  media: amphion: drain message work before releasing core state
  media: amphion: prevent unbind while video instances are open

 drivers/media/platform/amphion/vpu_core.c | 18 +++++++++++-------
 drivers/media/platform/amphion/vpu_drv.c  |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.53.0
