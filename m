Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CC43B6C5
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877594; cv=none; b=Q7BoKj5zjAXrYV4dM5B3zXqgsh25xjP6arAh1XZSO5rZD6FZhGuBE7FFiAFlUyBd6RqhOndCnFYzJVsJQPKY2ZYvzdktH2kTpITxQmIPaY1CUSrEnZxtvdxtvAzEhD4JDVR6WSEKmsdc9SUGjXpH6B4IHKWrfry1nGou8Oq3AYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877594; c=relaxed/simple;
	bh=/8DQzTwgTLijC2ECNXK7PMuHIRZhvXM6dV0bMACsCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S5Fl6w0tWwAT3CS2v/quo7KyEhkamAxrQryEy0EHCovDs7dap2mLGFPy1/v/Zvmvj/ON77qOQBupcwi+jAL3jMdVNIQ5Co61HawN5EagNij7OTdOiV2gwHP3g7xooHlNhoxmRJjCnMqJsmSCkQA3EDhrfTWXLXmMF3XCs5HnZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkGQfY0t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajt4MI7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkGQfY0t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajt4MI7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785877590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XBEFLiJGzT1OCUxcX75MonJY16dYU9oCUCgSXPQ6riM=;
	b=QkGQfY0tQIYRZeqNcdBOfJ/sGBgyRVZuH8tWjyESsUlbm5OrOq52+aKusArSjeP74ltLUC
	aaW9kmSps3aPI7/VyYK55s+gbGwKEROcEe/vsqYjuZWGvI+DzSrZ8/CUbkQQRi9XmgdVXd
	SF36ZpIoI0DetCd9Y8R7WKzg0+bVe0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-7papfVRLNge55hMCbqcl-w-1; Tue, 04 Aug 2026 17:06:29 -0400
X-MC-Unique: 7papfVRLNge55hMCbqcl-w-1
X-Mimecast-MFC-AGG-ID: 7papfVRLNge55hMCbqcl-w_1785877588
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso134395f8f.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785877588; x=1786482388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBEFLiJGzT1OCUxcX75MonJY16dYU9oCUCgSXPQ6riM=;
        b=ajt4MI7p6GUvnTJXTEhBgywNy2LafUuZnqVDQJAs1cRB34RUbzqzpPpI/RFy7eZ6sM
         /mrpgiigyC36Egm0pOR18br5hF2SoaUehbQqv9szwqrlh5HFGp3Ur/EhF1XLPK0kFpYJ
         nMHlpX+6Hp+20PIV+KjY1f+J+pUhZTOAmwWrbpoWI3xW5rsFteAzIWsC2i0yb/Kk6Vm6
         4dp/QZLNogNCb6nYEpjdovEY9qLaPzimHtMifIAHtSlvRyV3PTJ7gxh3Ic85tySEqxPk
         Vm3jl08BZqFw/13/d8KntG8tYlHOlXq/tZ9JQ6GWhkcIEeCjhh859EPkH3m0OVWmQEYq
         wPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877588; x=1786482388;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBEFLiJGzT1OCUxcX75MonJY16dYU9oCUCgSXPQ6riM=;
        b=QRjNBv+lYGI8Cfr1exsZz2Y1mu3t7nFgIG68M6y4H/3IaMs6fNtkNz0Jo/2xlFPgUC
         fNWbUMybBd13fOLFhakDp+m018uFcs7Ys8DVhqzn73ntY6GPZcJ8D6mqjxF078hIuEWg
         9n2TtH+5GdplT8EJhfvSNb3naFiYCqO3Wf3q9kP4Y19qKAVGRl2LmApYDH9OUFaZA0cQ
         cDe9Z7G3fpYM9HFEh97p8gmJq+kdD//aJKja+iJ4ThptLyiV6LR8rPpwCTttA0tWRjq3
         Gr6yhoIwskkO9ksUZZIn9DlAHn2NlhAqTy7AZJ5cjFlmt+MDUATWx3dwMNUlFnKtDGJf
         2D5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIh3xxJLQSqKP86k2W5YSL+LRcD/IxNIKo7pqyaV56B3Xqw96pb8/tTxmJazhaIVSuVmOs95A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84iS03hDF9MhFTMIHtlxkEezIHFx7+PAAlPGh4PF1HKK/THuu
	RUFj/iiCW3kEVplKPXaUSHfFVs3VEamMSQjkcUhy5YnqJzZNXRhM0XPThbdqtxuCI4BRUGZ/I9c
	XkccEm0I1gnb2C9wZZ49rxZMQ507Hg4F23mlBYeWUvDJJ96Q9kcw4XTnDKg==
X-Gm-Gg: AR+sD12xoqoYyhDx4PkQFWp/EN3Y+gnQABypfFISJJdjCXZJU36aAoTI7eiczXrmULH
	kgAa0QPPFxdx1os841ZLGrG0eRdpRYJHrkm21LEZc0XHs9BVl+WteO888Fe5SXq5V5jUcS/Fc7z
	L/EUR3iQ8KYbR34rsaWz2//qUcN3wrw33iQ7xq9+a+sPGaoAOOIzelPzNN/JnKf3mpay65sHmCV
	Z3UKJ+wA31d4O3zrLs9MnkE/P+1y/Dt9R5cJ1AnWrp5kF6BS/YV613OMibRpi+PIwSNWBIJiEXn
	jlzGAmUWG0LnJXFnGoe9q0LYETd7uwFQtddw3MdWtokLgFfBN06TZV8qlu/g6C0gHA926yaXfx/
	CxmGjI3og6yqYY6I2+xqgbA==
X-Received: by 2002:a05:6000:480e:b0:472:3090:d878 with SMTP id ffacd0b85a97d-47fec509a06mr3321433f8f.4.1785877588395;
        Tue, 04 Aug 2026 14:06:28 -0700 (PDT)
X-Received: by 2002:a05:6000:480e:b0:472:3090:d878 with SMTP id ffacd0b85a97d-47fec509a06mr3321388f8f.4.1785877587944;
        Tue, 04 Aug 2026 14:06:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm2985791f8f.33.2026.08.04.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:06:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alhouseenyousef@gmail.com, borntraeger@linux.ibm.com,
	dtatulea@nvidia.com, junvyyang@tencent.com,
	linfeng.sun.dev@gamil.com, linfeng.sun.dev@gmail.com,
	mst@redhat.com, physicalmtea@gmail.com, slf@hdu.edu.cn,
	stable@vger.kernel.org
Subject: [GIT PULL] vhost,vdpa: last minute fixes
Message-ID: <20260804170624-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 42bc45df5905e2b7dccb72adaf7730f66cfbe03f:

  vhost-scsi: reject feature changes after endpoint (2026-08-03 23:08:15 -0400)

----------------------------------------------------------------
vhost,vdpa: last minute fixes

A small number of fixes that seem too important to
wait until the next release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christian Borntraeger (1):
      vdpa/mlx5: Fix buffer length in create_direct_keys()

Jia Jia (2):
      vhost-scsi: flush backend after device ioctls
      vhost-scsi: reject feature changes after endpoint

Jun Yang (1):
      vhost: reset the vring metadata cache on vring reconfiguration

Linfeng Sun (1):
      vhost-scsi: Validate T10 PI scatterlist counts

Linfeng Sun  (1):
      vhost_iotlb: bound map allocation in add_range

Yousef Alhouseen (1):
      vhost/vdpa: reject overflowing PA map page counts on 32-bit

 drivers/vdpa/mlx5/core/mlx5_vdpa.h   |  2 ++
 drivers/vdpa/mlx5/core/mr.c          |  8 ++++--
 drivers/vdpa/mlx5/core/resources.c   | 11 ++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 10 +++++---
 drivers/vdpa/vdpa_user/iova_domain.c | 11 ++++++++-
 drivers/vhost/iotlb.c                | 47 +++++++++++++++++++++++++-----------
 drivers/vhost/scsi.c                 | 20 ++++++++++++++-
 drivers/vhost/vdpa.c                 | 18 ++++++++++++--
 drivers/vhost/vhost.c                | 16 ++++++++++++
 9 files changed, 119 insertions(+), 24 deletions(-)

