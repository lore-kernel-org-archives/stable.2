Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62D3F4DC5
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181140; cv=none; b=M1rbov8HunVUhWTT2RV0butjIsSuhVa/s9uFQh3oAxHbaK0jF4v5z4Jdmxk9D7CDDK0kYmHgUJbq15OErgA1DTPLX5PgMZPBpI8Wo0lZgjU9zNei8BgwYpkOOKpvh6TtTgVZop8xjPxNvlMw+2pD9jBqkyySjXqxwe74O4NI884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181140; c=relaxed/simple;
	bh=5jAwKvcQVAYHQgGBdOtHn5dcMMi9Yqbb8REDi0+fask=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mbD0wGU20NN9WMoeOcQholWeqHTUcb9ewcabuCG50KUeAJfPJkEAW9Ztqx4D9KFcnaKaTcAImPz50u7D9Gxrg9WetrIQaTvKtZTN8Phsm5wT+iqGfIT606bG53eOkwUY73jjYoopiZpKrWqFz2xHc48OGLY2h0gRinZAylQxOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7q9MN0f; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7q9MN0f"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9638d15f871so2566635241.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181135; x=1781785935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGPUMpfdaDQCNkNjTMnCmLU/jdnRUY0BJXqb4atgwFI=;
        b=X7q9MN0frNfh5Do4XeEoxBux4ykD7skkI7f2pljGpOoeD98xIKatArR3IHBBRnJwZ7
         m3gyS28pPcsgjgSdKs4+YcVXYdmzdwhfOW/CN7u8Dzt39gGeXL/t04mP2b3yQGUTpPi0
         +gpmIl3jh7UHhibSKzvBj8hmXl8zCOVi39ryOM922EyqmrKZMVWbAJ1r2Wjm4EIZHa3Q
         AG8yb3jsNjL0AkZ4E7cR7jazyPRIbU2S770xCUB+8dK5hni6NmMJzNAygofAtuPtJqRK
         bi10g754xtWupfkxaANM49DovnPwuzRbamKcYAbyMMctg+Tw1FDXB4wIeLYaUYR9g+qv
         Uc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181135; x=1781785935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGPUMpfdaDQCNkNjTMnCmLU/jdnRUY0BJXqb4atgwFI=;
        b=Gcdo9UXXTqWiPRsmm8f16hioNgz7sFp6LBk48vHmBvR0u6TRAsi/Lse0/uyBd2/YF7
         KwAmax/WFKNPH/8/ciJBCnKs27aZ3WFQz3Yvl48JeHlB7ch7VZMzmRMlfssu8H1J7NYz
         O//gAbp2Ln06N3Imxt9f3JVWH7b/RtcJX15bPsR5KmIdWgdRDLeb5PE3v51unsGn4wAi
         VvDK59DLsvMGU2tumaaLDJjDfyqxSo6HWzHENEugH8BXbmTFJOMl+PLeZsWVIqzD3vqi
         KZeZZX5ByJNp4q1bm0Kyb3blQoodtHN9Xz+1iY8vrY3d7CZ6COzxRRQ6yVkKkFtldgaI
         pAqg==
X-Forwarded-Encrypted: i=1; AFNElJ+gRVw6m7f4JtmDS2LBopRyln36r4hFVQ7ZjJVYycJz6Wr7x4joQvLS8nMLWfKoeaU+mUmWjDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1117ZrXsrQJ0L52y7HjHua3nwwQ/apiQaBzgULX3RXGF8DMUv
	E/anWaG4GMTM6baW9q1At2SRE8G6hwKb9QPADOJfmEMs376kHBlypujO
X-Gm-Gg: Acq92OFjU0wtLulVheoOq2ONLtP7WsvczsYe/Ve8MNqkOBgNER6kB3vzKpmHT1anKQT
	JcQ621/9a2rpebyv+LDd+IxeFiON5vQFiRGr1o4PzTk3tWXYaqXl4Nnalfi3mQUwuJuLUe9dbv/
	sW6Ft1jg+HLA/adSjr0PrUwxhvtGBXBqco3uCMLLwj8Fd1AZpXIJPcrscFIJBMMhlZFC0l9t76D
	rohkyfxUV/JagScHrW8j22WP0Vp/tWP85txNDvOYhIDMqnUjeBUICH7H3Rt+NDAcvVhYPT6Mj0X
	cyNGVyvaZxN0uteXDM7b/RdgEpeG0XS3mLwh17GhK3kK3equK/QGqdAThJIkXZdy7nr+TJOJkTU
	GCBSFJMBxJoPrvxKJZLNQDaIX9UPGu/l/CyofF3VFqlbQ/Kccz7ZHr9fbn+yuVDlZq1cYjb+iCP
	VXqO66ABGoyfOmp1dJMXpPzK0sLjTRwoksnjKrpW/BCNWfJ2c04/O0hOobRiYYffYShZ2N/IVRG
	RvuFcU53dJwV5w1FZXdzEsNlw5bsoXh0bBWdt56Pw==
X-Received: by 2002:a05:6102:442c:b0:6c2:e290:cc75 with SMTP id ada2fe7eead31-71d5989b9demr795299137.4.1781181135386;
        Thu, 11 Jun 2026 05:32:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160b02f758sm171220685a.36.2026.06.11.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:32:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] xen/scsiback: fix command-tag handling on pre-completion error paths
Date: Thu, 11 Jun 2026 08:30:44 -0400
Message-ID: <20260611123046.2323342-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

scsiback_get_pend_req() hands a pvSCSI frontend request a session tag and
a zeroed se_cmd.  Two error paths that run before the command completes
through the target core mishandle that command and leak (or, in one case,
underflow) the tag.

Impact: a pvSCSI guest can exhaust a LUN's per-session command tag pool,
stopping the LUN, via crafted ring requests; for the first case the
refcount underflow also panics the host under panic_on_warn.

Patch 1 fixes scsiback_do_cmd_fn(): on a failed grant map and on an
unknown request type the never-initialised command (cmd_kref == 0) is
freed with transport_generic_free_cmd(), which underflows the zero
refcount and leaks the tag.

Patch 2 fixes scsiback_device_action(): when target_submit_tmr() fails the
err: path frees nothing.  transport_generic_free_cmd() cannot be used there
either, since the command is initialised by then and se_tmr_req has already
been freed on one error sub-path.

Both paths go through one helper that returns just the tag.

Patch 1's underflow was reproduced on a Xen dom0 (guest to host, with a
panic_on_warn host panic); with the series applied the same request is
handled with no underflow.

Michael Bommarito (2):
  xen/scsiback: free unsubmitted command instead of double-putting it
  xen/scsiback: free the command tag on the TMR submit-failure path

 drivers/xen/xen-scsiback.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

