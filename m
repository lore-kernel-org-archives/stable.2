Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94E3749F4
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787546505; cv=none; b=UDA8OqmOzuUi7i5ww43UNyUV/Ucs3e3tVIuLM68MWjpxgPUiwp+tUSjEkpjLc6vzWx0iKttpKzZlEfnXS9uai0UMNDScj+NfdIU8zUoD7lmHMvSzA3NbjgOcsiCiG8OFevfdagDU/pPr+FCRXvPmVS5yqFTm9dYx1nJ8TqDxR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787546505; c=relaxed/simple;
	bh=Qp/Qo50gT+ULoYvMdbBWvICXZmTPOc/Gxpuj7vBLL2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5sl7yWycocQnWjHhdQc1vhzBW3I8j1ahRdi2kB+IWvbODVlqJNUzSsBLUN7ecIQro0onoDjOeWcZP8fw1VWFP/8qj7WRHnAUBc6mqw6cHeVheo8LeoIX02CE9R5zyoOaiCSfDYqvWKEAtKvKz/wbvQyPCcG6YA+M8vf7VRVoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frhXAyrk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frhXAyrk"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2300861a91.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 21:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787546504; x=1788151304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qp/Qo50gT+ULoYvMdbBWvICXZmTPOc/Gxpuj7vBLL2A=;
        b=frhXAyrkD2B0+vox8lN4kVYFXdQUQzMh1DcyqiFSPsyMloguXJX567r0imziVkcmjg
         y6cJZIuU00GaLWDjsr4RQsLE7ZGU6/KU5McNTyzlXr/BxgYEYdWi0LmSbVT6BOuFNzF2
         Pq/+94c5GA6B1/MTqSFyjPOVklCH8BPJLJnh6hSFoMS2vJBagqrTQlNAYeg/qLtMNIVL
         YRlWWfKpDoe727CZZv8N6z30z4CilH2CQRVeqS2MFf7mDxco8GoCKzzOU90ZlFv7Oj8R
         GpSvBmSPtpjQDsGMi0r7wTnUmzOsfyv2ZAMZQxtQy26d0EHx0V5mYlVH1QH7Cd+VXCcl
         eeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787546504; x=1788151304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qp/Qo50gT+ULoYvMdbBWvICXZmTPOc/Gxpuj7vBLL2A=;
        b=gCOsYvJXyNOlQ37e5FIFulSY8M8oD1fTxsOsa+Vab8DTfA7ZHWo0IyJFzsxlBlGdYN
         +4Syd18YDaBwM1MuuLZq/Nzdq4f1SirdtRx3/v+F+/RWnb5+XZeejxSwV1yESaP3XrtF
         KBxhZH8VPTLLre9gZimbJmCz2eH81sluiWr6KZfhb/nRw1cKFoI5uMkuh3FCtCZdaZ0e
         QEUGMmgKjOnG7a7EeSiN0Ws2JkjReWnI7NSr90QqIq8zQ1dEi8qRvJlonNlzGKUm/s+d
         FOiIlsX3DeB2NFqzrgAKW02FZKnyBTwpKpepNK8px3O5bc8UTVdQs6aPUOcG2VSYL8aE
         xJmw==
X-Forwarded-Encrypted: i=1; AHgh+RqzjINHMpl80ah7SDc2XaCp4yjW0ZtgMmmYO2jcdotoMAGgjDMXw6XQbclCFESViJgxbPefuRc=@vger.kernel.org
X-Gm-Message-State: AFuF++mH4meCpOQ0h0UFAE9otdMdk9WgOpcNfEUVxStC9QzJ8y56QqWy
	Uk+3s3caXSvFfz2f9GuUM+vhpEC2XHHH/iRbmxFiHUg3+d7Pj9cuyczY
X-Gm-Gg: AR+sD115UndR/yMwq3vWnIaP1Nz9FPxPjcI7mA/WkGiUlznGAS8mH8UGarF8Xyek0Pd
	x3f4IAPYr5tZe4yahNOFKji1bXzRbZPlWrZhikrdgCc9/6OYWtOI5CEF+sUHwEl4dJ214UrYI4h
	jsFgNlocRaAkbQn2nCdhO/OkqsVcOIKxdcVxT1oOks61FiS9FxXjlkZxNpQdYsDyvdrsHBDHr/Z
	lPmUSRal99sbWrwbIQBpSncVwIXP4vXdKRizoV15KgPBB2aNFwGnhmQzPy2b1gB/CRBRYIhYWSn
	BHWeb0Id1jfFYXsbHmhA7gzoNVEgeugE3rGCOWfuvqaVj0nljiwfhmiI2ywJEALcTHfc2eLDC/X
	5oKmC2J+x5C18Z9C9Jgl77Z/PjpHw92cb/epWHJKKKZUHA0wkJm4TPTJqru2RGrQnIguYJH2iQA
	0dBHsVcsz4o+JYQOpQK26dikraCntIvVi1PmT2H3pxEKc/vkdk6JaMkVYBtDrUV8qzGDENShG1H
	TC6THqmE7QTmA==
X-Received: by 2002:a17:90b:4a82:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395dee5610fmr24191059a91.2.1787546503376;
        Sun, 23 Aug 2026 21:41:43 -0700 (PDT)
Received: from ML-GYSUBT565.ECARX.COM.CN ([101.47.164.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a4e5ecsm8584132a91.16.2026.08.23.21.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 21:41:42 -0700 (PDT)
From: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached knode_driver
Date: Mon, 24 Aug 2026 12:41:38 +0800
Message-Id: <20260824044138.42965-1-khiemtranzo532001@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In-Reply-To: <DKU2J83B6IX6.2CG1WOB66WC39@kernel.org>
References: <DKU2J83B6IX6.2CG1WOB66WC39@kernel.org>

On Fri, Aug 21, 2026 at 03:54:44AM +0200, Danilo Krummrich wrote:
> usb_driver_claim_interface() is the only callsite in the kernel that
> does set dev->driver without a subsequent device_bind_driver().

Small correction, I think there are a few more. usb_port
(drivers/usb/core/port.c:782) sets dev->driver before device_register(),
and usb_port_driver has no ->match and no ->probe, so it depends entirely
on the __device_attach() dev->driver path to get bound. ccwgroup
(drivers/s390/cio/ccwgroup.c:385) and pata_parport
(drivers/ata/pata_parport/pata_parport.c:515) do the same. So that path
doesn't look USB-claim-specific, and if we ever want to remove it,
usb_port would need a ->match() first.

For the root cause, what about this: in usb_driver_claim_interface(),
when the interface isn't registered yet, just don't set dev->driver --
record the claim on struct usb_interface instead. Then, once the
interface gets added in usb_set_configuration(), bind it explicitly with
device_bind_driver(). That skips ->probe, which is exactly what
usb_audio's claim-now-bind-later needs, and it also attaches
knode_driver so teardown is safe. The __device_attach() path can stay
for w1/ccwgroup/pata_parport.

Does that sound reasonable?
