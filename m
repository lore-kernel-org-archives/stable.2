Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF535C692
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923623; cv=pass; b=Nfd166BZ+sz3eEDrPT0Xl6phWoPj0uvqp38WiECOJNwsrGD9C3ZIidXS+mtluX+2/8dZai1FIbzKGank7D+IpMtO/L5Pl6xPWhpA/EjoDQHubnhr8jNY4NTH6jghgAuhCGxxM+yOcajwDaBBcqxg7OjtGHdrQgyqIcwBAFYFbVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923623; c=relaxed/simple;
	bh=FOYRk6VydLS9eMfMxZB7qHkZwQsdY1XIXbZky0pHTu4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YNa5ZyVA3QDjV8c9civoj5Dtfv1zy4/YdoBjxC6u/KTxvvby3mdQEi23Waujov3brO48HGQJnkWeW1A+FWbQZgs4FgJUddgoTwV428FPbDfD5aDnkrFcdMPziKrPbNKkQxhjGEk55J9xxuEuLqXojaOKJokhUxVxXb44dv45Zv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtBs1ge8; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtBs1ge8"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso25650685ad.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 10:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789923621; cv=none;
        d=google.com; s=arc-20260327;
        b=rzYtQRMbvf3GEFubc9i7enebaj+2EeXQ+rhvCd61MrTH3eGhdq7/JUv6ELhaesHTdD
         kKq+LiuIcvRB9JqsA9xWkNDBOiCsnLgU6HaUZJ+bL5E6gLy5FiltMh2PyPQQx15ZCOJP
         WDUBc9RBhSqi8GtJpX8CyUeKwFTVFk75szbNWQRsvzWj/g88OdacJ/XqlH/Yh93MMCwy
         ufq0jsnaKiKia/66apBpdCUbQYGAvF1NXC91RtDLyr8cjtXgiL8zQWMoRONRs+VJlUa1
         BW5CgX9YM0wLWiceR4fMqe5cFrcgcaJyVwzkjidlNa9bVZMvmsdNcHjCsZGs8oGMvunl
         tWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FZ6/bzlAkxVd+iCIF2oqKZ8IZif6Hsv3IteV35pkCVU=;
        fh=is1yUKMMFdiuiRgzVIfAouTKr/i1sCw2pDD/7G3Z8mM=;
        b=YKfwwYwag0KuIzsmtXWJ4OJOCuNadM9xdymr75yGzuHEx8x6K+XbtPZHzDQUN3Aris
         yvLf7PlY8WhDW2G79GB1U+n6k2bRlIAd4J0+dtk9X4Wa04wUDt+ePrP1yH8Hw+mpRvK0
         Q9LcP9gF8yGihR2N3UPqCy2SgTKLxTJAZ+7+wAzuKE1LHib/mxMWE+2R4w/ZiTM71sIJ
         mHhm2+RqEA/KZp0LSUs7uo2NVhx6UisdpDJZrgiFGTVlZrlWHNU7SpPcE9vcEaS5ADc+
         fWrMvAuXM0O7MzwKSQVT01lftzz4YYB56Fkw1DcFhPVbI/6wbVy1FHozxgfXNgR2VKS/
         V2kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923621; x=1790528421; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZ6/bzlAkxVd+iCIF2oqKZ8IZif6Hsv3IteV35pkCVU=;
        b=CtBs1ge8N8802K2qiSwPviTbPLjS0zS/KdYhOtjlXc88KDZXemc8xY1fN8360RQUy/
         pI9pscfZgZECIQOasRCtOKPTCMoqfgyJRR0lqRKQehh8M+QPCDyb3uPJrRljlPaiRFlf
         1nGQzkXlePz0QNbxzuK3aaXOl2Wv02bmcsAd4opP5+P5sUiHmzxjFjvQlnnSYwC6ctlr
         geWtfr26HZM+OWTUo34ll9VnsVDYw2DMLgy6EQk8t9A35eRZbsrYKto8UUZqvDFi1U35
         7Io/sSo3/ldm0Wz38E0mf/9qpn4chmgbR6bAPvcQodyg2VFU79P4qcA0Yldxg2Ia48oo
         E1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923621; x=1790528421;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FZ6/bzlAkxVd+iCIF2oqKZ8IZif6Hsv3IteV35pkCVU=;
        b=LnIeYIshS/PXc2R6S+grYqFcmAAXDFfqtPnCu3DZCgrhq0i0GmouYmXDzaxXRD4N6h
         w9Eqm2VcsOtbF1vSG+C73UrTBizJiIKXs+7/3gi1dvd2jXnQvHgQG2twVu3nAPzz8Gui
         Ws3s1tpzxq9t6uAtiOgi0POBj14uTSN1luGRjylhrI2Mu/pnManqSz2YR+hPxeGg2nLq
         hLfALdLH4/rMTQhtMdMMxVC8t/wt5VVtGF4UMwYRHJNs0r34+kyCTZR/uGfehuCSsvsV
         nnbxBrGE8orlix75RyT4zflZqGWjH6YJgldwy64TR7K+zOsoj31Zy7BKzfNuggJsSxOw
         8TuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqVW8OdgLKBN90RORGEJTWT2svg7lI8XFmVytN5fXm/Jz+yU40MQasBDHGdZ+lAPooTzlqV24=@vger.kernel.org
X-Gm-Message-State: AFuF++mGRuimH7fsF2ovV0vYQvoXBN0x8yOa42rns0jtQ6rndpv+fElM
	Z0biQo8brGnAbOO7Z+cgkIFk4/yVbWlk2pRXtpOVVB3ymNkSrYLHcFH9N/1d6d0F4qc+Hqu51dN
	tjvgDQoqXUu06tC63XFrmEHPUD+jm9lk=
X-Gm-Gg: AYBFou0hNw6/M0tLtEBTDH/nMON26JksdBZ7t/nvxIkSTUF4xKL2Sk8h/zr56h2z9Pq
	UUqvkWK9FF1waHXKugoJxSDmG9CzOYP06UlcE0fv3F5nsPmsOrEivV+H0pTqUqqOVrxfgeOwWQT
	kjO7O3+XDC495/iEZJlyofVajLEyAjUSuEQm3IMyYgnCvyhdZAZJfqaldJj92v27fc8Qr2RPl4n
	AyJDc5wG9UMLulTbA4oUDZTFkxDQ3yUyWF0CO8eSxZJpd01nFdBp0DvHV+HgmXefCfrFbNhjmyg
	iE9ur21C8vlKYSELUsJCD4LF/FkS7XNyTs4c/1WHpQ3QfCO1Nrg3
X-Received: by 2002:a17:902:f545:b0:2df:3f0f:d65 with SMTP id
 d9443c01a7336-2df3f0f0e1bmr26183525ad.22.1789923621367; Sun, 20 Sep 2026
 10:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olzhas <marat.olzhasss@gmail.com>
Date: Sun, 20 Sep 2026 22:00:07 +0500
X-Gm-Features: AcwNN1XtjfcG1A3vuRXuZwWNFiaCVgATiKsMbPLyoi8g9WObhx_BLl_2Vjqsho8
Message-ID: <CANzgjV0YWUX6=ZGTbn4KEKqQmVhsZTsDPeRf0Nfq=YFT1eoPzA@mail.gmail.com>
Subject: [REGRESSION] pinctrl-amd: Don't clear S4 wake bits at probe causes
 power off to reboot AMD Ryzen laptop
To: "mario.limonciello@amd.com" <mario.limonciello@amd.com>, linusw@kernel.org
Cc: linux-gpio@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

I am experiencing a regression on my laptop where attempting to power
off the machine results in an immediate reboot instead of a shutdown.

The last known good kernel is v7.1.7, while v7.1.8 is the first known
bad release.

I bisected the regression across 9 kernel builds and identified the
following commit as the first bad commit:

a7c855969b1a ("pinctrl-amd: Don't clear S4 wake bits at probe")

With this commit present, running:

    systemctl poweroff

causes the laptop to power off and then immediately power back on.

I reverted this specific commit on top of v7.3.0-rc3 and the issue is
completely resolved. The laptop now powers off correctly and remains
off.

Hardware:
- Laptop: Chuwi CoreBook Plus 16
- DMI board vendor: Default string
- DMI board name: Default string
- DMI BIOS version: AB8139_S_2C_V00.01_007
- DMI BIOS date: 2025-08-05
- CPU reported by the system: AMD Ryzen 5 7430U with Radeon Graphics
- The CPU/hardware appears to correspond to Ryzen 5 5500U / Lucienne
  silicon, although I am not certain whether this is relevant.

Software:
- Distribution: Arch Linux
- Last known good: v7.1.7
- First known bad: v7.1.8
- Current test kernel: v7.3.0-rc3 with a7c855969b1a reverted

I have verified the fix by booting the reverted kernel and testing
poweroff successfully.

Since the DMI board strings are generic ("Default string"), I would be
happy to provide an ACPI dump, dmesg output, kernel configuration,
bisect log, or perform additional testing if needed.

I suspect this may be related to an S4 wake source left enabled by the
firmware, but I have not identified the exact wake source yet.

Best regards,
Olzhas Marat

#regzbot introduced: a7c855969b1a
