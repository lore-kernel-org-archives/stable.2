Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F74DE706
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231326; cv=none; b=uK6fkj726kEb8oVudA7wj+rk+HMlw4oz1KmzPIlnkRSUEdi/GXUn6bTiBrOqo+iQqKgsHFTtdrteqOrOxPxPJLTBiZ9OIB9ZaJelnGlb1Ay/UwPeVnbgjQ8/7Q7XD+XTkNhOkiR2BhWjAKqvEthEDhov6Zjp1zrqZ4lmG7f4RwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231326; c=relaxed/simple;
	bh=PsxZfXvHhjPTT7xVmNsmNg17aOdYlA6JQ4QoJ8wnTfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=arcUMDv7MsH+Q/2ZNEj/HInIG7jFPJyUMFgel66KsUzzcT9lDP1D3GRmCaSF9hg5NHRIOlL1EP7dN/KjGuslJZFWEoGg5Qi/IHPFybQ1TGe63HrU2MewVVTgPxJqT0+BNfelrayV+pQedk0OfCBNTGbvaXrgzQ4BsmGzoA4o0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FHv4h20S; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FHv4h20S"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so962811a12.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 13:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231321; x=1791836121;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PsxZfXvHhjPTT7xVmNsmNg17aOdYlA6JQ4QoJ8wnTfo=;
        b=Vue1CUwVQPCkfqsHNzf8TtgeWYALWXnJq63uBNzx++LAPaqAaivStzVjI6kT5hs2+s
         Bbj/Mow+abaz8W+eHmg/qv/IEEOmpmnrJ/LII5qM01Mo/trespIv54eYJ2+1a3x02/l/
         k8SQ5ZxT6l4F5pLQyXsnboHeOVa9yhZ3zOpNPTDzfPYdGtz+VhZJ57xClc+Y70kfVRsq
         JJLQhguO2mXBQSdyaQVNtqStIPhK79L8xLQsVjKcJ0hJSo5UmQeQQQtvJ3f8U3NoZX32
         qInOoUgv89aPvk0vObQ7GEkPFr+JNbbsQkBYjGz6BMdqbCmiWKalEbnYWUcW1GaXrKBY
         qRfw==
X-Forwarded-Encrypted: i=1; AKwUvBxsIRBLa3JXUvhaFKQ9U6Rp3arEjm2KygbEwabm9VLwsJtW4f/1wP63Arj0yD0NHrg7RchyqDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxRt9Xhbm6PincVal+q2NzftOp0JHvkaJPg0onf0k+aeLaYrfF
	MIhLetHtt+XMUQDxAebywqoNF8dhkh/U96CUEeCqkqKGap6yB1QETHBKXrfkvlJi0ZyLL+d5Se5
	1Av1pp+P3hUgmVNWzapgWMbJncV0vKau44S/lR3DR9gJnWHdq6J2IiVhVZnLSk3J/zQeZoEFBlA
	KsAJz+1epRZb75IRt1DEZ4b63gdyBVMS0hUexlfQ7F3z40IZeWgWb3x93U76NEElPjMwPZ1X7cu
	YFYMehzP6Ym3rkl
X-Gm-Gg: AYBFou0M5sGCBUxIZ0xqECkAbWWbb+xM/b2MnFHHtK1uUaPgoD1i8r+92EkzIHZxeJA
	hIBjIpvFgTCtTRP/hPiVU8wwwmBV55qiTvky/67V73cugBeyL1N1zm9V5HmlZReXdIoeCp7s6hz
	twf9QuAwYUil+bLDIe8+9FnKub0wpKyPa99WHWyydWAw3clt1V2vjHysRQYWrMmE7UN/G3p7ZGq
	uKowWbFvyIQu8a7VlcRW3+n2KqT4KMjo0jTbjbu40ljXI0TxFHpjztfpHd15KhIVr/llNLW8/Fp
	ngY2ap2wZpzFJZDLDl7ETjNGIzspoGvGO4mheWMgDx5FzQR2kw3TTe2q3GKJdLpszqYiSnSZPDH
	tTOyJEuxgrsCzUBIgGeTIijIMkrTInSZT1Z/KrT0Dp25jxVeso2St9oWgRrkeOYg4Zw4AWqX64G
	eBcciEhpVq6k4yU19RLE7s5M4eFSvlj9GBCz5N8/hqFaI=
X-Received: by 2002:a17:90b:3809:b0:3a4:7938:844d with SMTP id 98e67ed59e1d1-3a78775259bmr7151316a91.64.1791231320815;
        Mon, 05 Oct 2026 13:15:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a81107a385sm438108a91.2.2026.10.05.13.15.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:15:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cbf2fd504so429053685a.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791231319; x=1791836119; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PsxZfXvHhjPTT7xVmNsmNg17aOdYlA6JQ4QoJ8wnTfo=;
        b=FHv4h20SKzQAxQrtpj+ZS71JXQxYtCHoFsEEnbk9QkL4JBjYdEOnWfcfuxwuA/4bZ+
         7UEpdmNLtDOTOi1fdhciMFqFmxacRlc+2Gq1utQ7mGgEZprzgDsk2jrpknyLSv4U+OF0
         FpEJDtKHnntCSkUG9Y4d6FQv23mT+ZKLJEDPM=
X-Forwarded-Encrypted: i=1; AKwUvBweUyI+H305bvPSeWH1s/OQb7k6EkZMSW4pbFZJJEYu1BFwOGu3oMrahsInSFLvEwwMMxGwv9g=@vger.kernel.org
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93e510fc7admr1406612785a.66.1791231319064;
        Mon, 05 Oct 2026 13:15:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4413:b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93e510fc7admr1406606785a.66.1791231318460;
        Mon, 05 Oct 2026 13:15:18 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2c96f4sm949911185a.43.2026.10.05.13.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 13:16:18 -0700
Message-Id: <DLX6J39ZERYJ.377I7R20BGISX@broadcom.com>
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>, <zack.rusin@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>,
 <dri-devel@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
 <20261003163851.2257947-1-qwe.aldo@gmail.com>
In-Reply-To: <20261003163851.2257947-1-qwe.aldo@gmail.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,
I see you are using qemu for virtualization. That is not something we test =
and
support, can you recreate this bug and do the fix on vmware workstation
instead?
Also please do an igt run to make sure there are no regressions with your f=
ix.

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

