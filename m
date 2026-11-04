Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817963;
	b=XqRX+5ZR0zIK/X7D9XUY+JJY7ZS1pUUQscoVHXfUu6KK/gb2eUTRl+b8YUrsELZ1SHrK
	 eXrns7ywuSds7Qzm9TgkwdM/dQHAPmIF02TrSJdgnIwsNpp3vj8f8ntkY/GaXxr0JhwUv
	 cRqTzqtoAA5HsYLf+Vx0aAXlS5yHy+Cwc9g2ACbWwqYWzSx/dqVlgQ75fJ38pw0wT5ekI
	 qqGUC+9xd3kL6pglHkg5IBUQfCYnYRSU/+VcM5x+zy56ZKAPQ3daMxZciJpB8N9OehVwI
	 G/VT9DRGLQ6qUpJyDfOo56XDi80i1fmhgJqTBmpp9ZZ6p/fqYBUmt27DuCcX6FqrRHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nqWygjB4JG7NSBHpOz713BnlMKlP4sfn/CuveiDDwh8=;
	b=ebmOrSnLhDZkmBNNcVGFlz2Fh/nLd3hbTSokikokMSLxofomaGgDZ5nSjdQy8trOkbEq
	 YqcZX0PmX4MTSqUBGoEy47OewknleObXeIN9cWwfpoHVs6MvBI8NsMmv89PhODPLhkNvU
	 +xGwZ/RH4/dSEzVpQ6ERPj2UZQcUnW+ws5GVBmmxR+QHLdt0WFrYwIIx2jhu4eds2iPSm
	 4T7MELtA3rS7DbYwzDOqFldmTHE181Zk8dQqamWI7aZ6x5+ZaAxQ1uW0OfQihZ/sWeHdY
	 FNkxDt+SWF6aaKKIcWr/9koP5EaDDbDt5gYQ12OYS2iWNydXq3YyO2AYlpENKAxKMNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyNF8nNd;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980ED606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyNF8nNd
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso7279525e9.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817961; x=1794422761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nqWygjB4JG7NSBHpOz713BnlMKlP4sfn/CuveiDDwh8=;
        b=PyNF8nNd39XownyPdNwIKIUCUGOPxzGbsjTctjyXhGR2i4UGM25iCo3E9Ne8a08AfL
         QeTvblDtWqmAfM4rz8Gd/mGl9/BZ22yI5fPc4fyqHBoySSs2zY51Mx6f/kMqABgYYk0m
         Rh4ni1wWjQlfqE4pKmLFkXnpqLa1/b7EgFpExrQ083RUam3BYabWNW8O6Ejqh9tOAAJU
         eWjm/dI3GRLkIn4LTDZ2RDnPI2cmuNuP8Q9RlCjK2+gPXs73w9UaSh+RD99xggPnjgSL
         GTkCln7N/ej4HVG3cmpixClwdCCU8JEgLJX2gTH9Rx0aEqi8I7EOoSWQ7JCE9eU2ThlT
         O/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817961; x=1794422761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqWygjB4JG7NSBHpOz713BnlMKlP4sfn/CuveiDDwh8=;
        b=Xiu5sFVZfylQg+oev5wFnt+lvbpmQM1n/kEki+MP2ChIdGM5FSsWrCEdfTWdi4v5lI
         StRi/EqMB8+FYWFjs5cZPqNlEyG2aVMo5yMjix/yGU6TAQyX1kimR7GZjaI0zuf/pask
         f9Iq5So2cjph8HwlmwoDpztm5dsSUX5GP6Aws7mFSZbduvC07kLZXRFjnMaI8uTCr1BP
         etIf56fh4Seac4ty43Kdx5QUVv14PehA4NhxDDzoGya5yeXt+n7eJVz5shrU8qxTE6Ax
         x2zFvf1zkihMHHQo++ii/AhHqIyXootd+wNuHbrE9yY6wuGsYJwb3LrwQflYlv/T9ETy
         0zUw==
X-Forwarded-Encrypted: i=1; AKwUvBxeTC2XOawSok4hYs2DSHm9bQRWYvGeNL8szoj2mluJ5NiXwBxDLoqVmFXWH4GPT/X+QskB6tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZniccXjUS+4+MVJfqi4m061jSx/Cky/ZE2eTBaQVq7Yx/FS/V
	zl9Vd41fav/1g7iMvdC6qHtZeENBam9y+ktw4BvBbEWRT0E/TbJT+Nmd
X-Gm-Gg: AYBFou2eHGNSfYlICGFGkX+vpj4c1xzJwjw5498BZiE84YrN53onXvPvWgnWskPHcIg
	o8OzFu1opO0G5vZYut9v8ccib9G2CsR+7Mw2AjtmDDyDqhwWn0VenK5VVbuXsWkXgODtppISMRd
	7WyL50nB16OCKYMUvAx3kABHSxISDzyYDpxh/mNbuE1pkDTp8W5sqe+l275yKLwnHixDyGRoigN
	VJZVAy7BHujNFUBSJXQ/7joOglDPqJTCE8ti/oKuxy9c2q5xoOmQo9BgSZgocQr4H0AJlOyHac6
	TYXf0IQcWz4XY1+D5mLZN5cbYhYj3gzz+SDswsRHTnHpoaMu0YsMPZvmeosK5zz14JD4RgYIVQo
	0cZg2trIDofvKfoqvgBJLGTr97wfGtulAxAg1Okcll3AwdMWBPfW1a5b3RFoDDkTs2d5DJIOa7B
	UAVgGsojcbPya+Xxd2hzGlTKg1G59AQEHKoZTMA9RRvL23dv0CoBPA5i6WdHoWdzgT370bWlDGw
	QqNQqLzqFU1nVnfpRjZnvh6OrCUwd/aL6yOgDI3IFiFoM8W0LGLpHzLlxWE//BCmzzxDfcZ4f0d
	5ZxtHZZHOxDBgmvVoU1PXjn73lSevbHT6Ef9ff7kDmFpIIqaZxpLBFXCr+t8WY55xxbUdWuyqZy
	Pl1Iz6upA4Rb6dg==
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ac14ec873emr370310855e9.4.1793817960966;
        Wed, 04 Nov 2026 10:46:00 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba0f3sm3126655e9.9.2026.11.04.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:46:00 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 6.6 0/2] ovl: backports of fixes that failed to apply
Date: Wed,  4 Nov 2026 19:45:57 +0100
Message-ID: <20261104184559.3630145-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Greg,

These are backports of two overlayfs fixes from ovl-fixes-7.3 that
failed to apply to the 6.6 and 6.1 stable trees:

  65bf000962a3 ("ovl: take a snapshot of the name for copy up")
  4f61ff2ebfb3 ("ovl: use the pinned upper dir in ovl_fix_origin()")

The same backports are expected to apply cleanly to 6.6 and 6.1, so
please apply this series to both trees. The upstream commits are
already queued for 6.18 and 6.12.

The patches do not depend on each other and can be applied in any order.

Thanks,
Amir.

Chris Mason (2):
  ovl: take a snapshot of the name for copy up
  ovl: use the pinned upper dir in ovl_fix_origin()

 fs/overlayfs/copy_up.c   | 16 ++++++++++++++--
 fs/overlayfs/namei.c     |  6 ++++--
 fs/overlayfs/overlayfs.h |  6 ++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

-- 
backport
