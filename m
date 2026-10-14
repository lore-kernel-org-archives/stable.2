Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37132C8B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968901; cv=none; b=TqpzcfiBZuxHX1fvDhskhq4GfCiENVMsl347ZPogIzjxJGZv4F525fkwaktexCKpsW2PqypCFrhZhkxWy5MMCAzlJZUWjMkXNzcfPu2e00Rkqu7PcsEQPcdfF7JdDUWZ2pdJPdK5kLds5K3meFGgw951iJlqaLV/Glclej9zjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968901; c=relaxed/simple;
	bh=GgkD5/b+A3SxwP3Guhdb/9K7teB3cLe9bh9xDObfKco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pxPRHf5NInZQC4mkhxdmvoqcsnBKLsd+Go7OWKGlSuLGJiKxyF/XY9bFtg/87JryY1Wemn/C+VACLQDbZDqzKqJpuAo6Wh0x2aMrw5hymubH5sPTpfa8QxWCoel4tRi7xqK6daMVgwVHy7yBRjyXxqnPHnyxWbW2rn812NNduxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYg27Ynd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYg27Ynd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1af482519so12069835e9.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968898; x=1792573698; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFP4wlkqeiwHJASkq2BzK/mRmO5TvsXZgDOkwgJ4DC0=;
        b=pYg27YndIhHzjyr24TI6OTGl98dUMVVbrVxStP80GL60EDmmD+LMbeL0OWA73XxnCT
         YBo/SkN2wPyMmhiKkRJcTKSXTOMTV4C0CN65QsxEnFoO894PrM9Iw+FAwyVIRD2zXRI6
         nwd4+4DZm+J5NXzEmXl87gTArrur5ni4LYUJrlkwMqGGqWVee7J4NzbdTE3wcVYtoH0M
         G0n5c/SY7SUMDtsp6qjaZLdwUM66Mz2fMYi5fP0dCcmrjSLXYQLAvIZnCNleRLrDpkRt
         vdwsjXgcMasr1RDRd/ThHtniEPWZBIc3DUE280KeJditKM4iYec9tgpdBCMImeu4pWx5
         WHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968898; x=1792573698;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFP4wlkqeiwHJASkq2BzK/mRmO5TvsXZgDOkwgJ4DC0=;
        b=C+Gm9jBG6btYuEl5QPDbofNR3uuJjG9apjvuEOxuZsXTXMR7C2bQ6lfeRvpuLIHaYY
         7QNymlg0BHZIUis6yo+FBK1BoozJLblnYG9rd0sDmD8FQT2cx3fNTy2VXTK44/32GXxb
         Tww8Pw0pBI/Aekds/dYFlvoLmXYf1wj2RJV1WyVqz0xo5ttChN2NUTwcwZdndPRaCsN4
         SlT7g8QnfOfx0UU6nuFWmKIeeL3wJgliiCJfIgFxCZCING8W1BcFZUUFhZaoi6/BiiU/
         pa17fmyFg69qebF/ZanUlFzhsjYUvoIiA84WS5RjA9I4g3uFGI28vxvi1bx8Zbe6RdXx
         30HA==
X-Gm-Message-State: AFq9FYKqDjPc7tug9kT7Yd1kwRHNxeQobe9gclrQ70jjf6siOULl5DmI
	kA6Qcoc0BowK8s+U0GJNNTAwMbMxAWqhCY0UcU2yfXUHMmhCQca0cJFEQL8sqn1d
X-Gm-Gg: AYBFou30AUDFUbSC3u0wn1cEDQicKZY3Py7gAuoEJu10l6DY28V1S5bf8aOBl02VIhE
	Ufm8gTksEWlycDYZqlH3SQRrCYgu/0XYAj8diDB5AwyDLA2+6a4YDFT9nNv4y3HP/uG5CdaKi6a
	lMpFhE7a0+i13zqaCRnHv8TeInZrwoXTovaKfp/5Y3Jf/YK+37swCLYoLxa5m5x38TGE+n30TRD
	8oAZqTSRtzbTp+qvG8g0rcvLnMpcdKvti+zKjQ6wtq0TtcVJjCf2bDBL45tRONmBbCvyzAABbEN
	3Y4TUS3zuhgTKbezAA8ie+O0fw729jSvU2uKy+6eAH/+bSZN298q78+KpP/aZMf4VAjLKxaVLgO
	OuKFMEqNi0kQ02cxK5AWS2dnzdXHDotOaa2z4Kqpd2HfWCyZP3igwddsDb5lMbqYgd8hUGUcCKA
	gAjxCJjSjSQ2rxLu8Wi9CiYBjy+UgutEpyEM0JpGdhqNcGF5glhWTqByesDIFXIDJVBhoCGB/Z7
	ArG4Z7wMi1hBGTAK2c5T0z0k+EoiZogkp9928zrLaO+4XLrkmnaT5YMkAkQyHBJj9BcieDrdF1o
	Ur3+xp7bxftPmsqUuwzaTdTumKhO5UvIg8ffE42cOLEemA==
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a18e4837f2mr287469255e9.5.1791968898211;
        Wed, 14 Oct 2026 02:08:18 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac4f65sm10493054f8f.39.2026.10.14.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:08:16 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:08:15 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org
Subject: Request backport of 1bcf245c837b and 01d16b8afb7a to 6.18.y
Message-ID: <2qz7vt2ycstbsqcvy52sgeuhbfceipsugbthq6yqenoxs4sxs3@qtzxcw74cc62>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable team,

Please consider applying the following commits to 6.18.y:

1bcf245c837b ("PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found")
01d16b8afb7a ("PCI: dwc: Return -EIO from dw_pcie_wait_for_link() if device is not active")

The fix from the upstream commit edb5ca3262e2 ("PCI: dwc: Perform cleanup
in the error path of dw_pcie_resume_noirq()") makes more sense if 
dw_pcie_wait_for_link() can return either -ENODEV or -EIO when a
device is absent or not yet active. The error path can then be skipped as
the link may still come up later. Otherwise, it will return -ETIMEDOUT 
whenever the link does not come up after resuming, and the error path 
will power down the controller. However, the PM core will still resume 
its child devices, resulting in a synchronous external abort.

imx6q-pcie 5f010000.pcie: Phy link never came up
imx6q-pcie 5f010000.pcie: PM: failed to resume noirq: error -110
pc : pci_generic_config_read+0x6c/0xd0
..
pci_power_up+0x54/0x1d8
pci_pm_resume_noirq+0x10c/0x1a0

Seen on a Toradex Apalis iMX8QP with on-module PCIe WiFi.

I also checked 6.12.y, there the same problem exists, but the commits
don't apply due to a context conflict.

Thanks,

Franz
