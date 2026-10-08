Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627D3A2551
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486795; cv=none; b=GbyJ4eOppfoP0W6ZG6YfSlH11OQ0w5dxHQXpYi15ZzoZdrdNQ67oTqi4eRqb+LULDymJ40SODnxol4i61zQr8ZFRFwCm5DhZ1pTEKh22eHbdpu4RgFUVz1lzhK+wkDIy3UrwG1WPzCjIhnIxczK7N+GvQqCj6UgP83+wvRzyzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486795; c=relaxed/simple;
	bh=AxXokR9yTnXIXLj9Db4ukgIhemDv2YeEJlYdS2h6TgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY8H2Lo7gCn+Mk9iOeJ3xXdjlvlgRirfJTg+DHgpTxO+Jrip1dIIUnDO5O6wT2wO1YakX6jf544rBESXOYU9xLUeY2xsHE7RpnT0snZbvn3LMB4ZU0e6l/3LGXob9u+EketdBc2SL2D6WrDOzGsQB/1oq6u5RaN3S2u50HQIir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YsJviukk; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YsJviukk"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3141687eec.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486793; x=1792091593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=YsJviukkd+L2i+QOPAEmQWGEy+Qi3sqFfYHjM8kZPNHyxDviGTrrADrgnmRizjkq79
         tKK+sGWtRKhBa9a8nojTQxpHNdvm/yO4ytkNFdWgK/JAtBpj4EN8nKG5A8ZALDzmDdcK
         F6S15GWxjACHApcV91REtCeWtZnOyLoUxypA1E+ENwPcFmyLIWrxdIIHxP7YCfoAT44m
         GREBdiqOYkSd23WbYfI0KPHbUlJeoLmFWZb0jt5KM/RM0gMW612+34Y6jH8Gn6kSVWNB
         LJ4emMEKObjd0wF91sJN8Q2R/ifIjOS6Bg2YRvLlrVZT+VDm9Q2ZjSVxxLtE8NkhkM84
         nT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486793; x=1792091593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=rkcwRSFO7TCpPWPIQIQJPOOrV/z8nG6uB8xODoY0Xu/BM69wCXiyUYCHRHXXkOsQqE
         zHKwJfPQ11mdCqdjocZTWxkKojdQ2EJvwdqTqdVE/j945EBTIv75eYgpddZEGNYppylW
         PacdONQf5Jyck/Nw1zCNnh9E7hYZLLnU+1e/qyHbVjkHVHT2I5kvTrM38oX7Rdh6DEyU
         l/35+MOJ62ZPIXEdotSHkeenfmu69NVHa1aATkAMRkL3hGGgQ3SVyw7W4WfUx71QEqzP
         fVczDx46U1Yg1H/zqeiORokQF5BaysGHBI0Uc4ZLPenSzJEbaf0D6Bs5hrRXIZVXzqmV
         qABg==
X-Gm-Message-State: AFq9FYLZLPKOVCdD9/Q9/RHszcjOD35fYO7Dflt77mkrvEmiAhfA2weY
	U1QdO5pqgQvw+phwRrCyFO1bqH/E93z97kAl6eb0O22iLjomZijfms8lyMFsdomSqF+z0GNFIm0
	bUx56k9yx9w==
X-Gm-Gg: AYBFou3cEPJ8eIs6dSwynQQLUtQjDsaezdBV98tk3YL0rM05LGzhnchw0BkkxxEB8dV
	uUhKj6pn6TGgexQWKD0Ix+kalVSJFYRnFHIz3kS4bbS0iEo1jnmP7zpKWENDM1UnlMQgqOV96eZ
	Uw5JJFlqNUeHcXDaPtyZwCCxm+QXOBJg5U0x6mlSoAwnb5OEsCZ1ZQ82ikX4qvDzjMG7L7jTQ3v
	0EfM/iNBbjEIFCaUwD/pqNTDfzgRbH9GhZGaaZS4pqMss6ARDA4HCEDcKVCqk7nHiPmI7elJzPy
	UV/gK9kCmlRr0cTQZfnbGWzQrnTIqji+j6ASG8ODwF6FKtSUe6dr9JP2a9JnFpCigo8MJcHFnEb
	c4AwIlUY3/x0wrbJQjXVoIv735idMcWeKtR4W3hJlaGAOT93DLRW+t93br+h6Dti/GwzVs7dPQM
	EIpg9J5wnrXrlekk8642a4LMGojSzSko1Vs5lT65HTcmxjLLChvV3O0hhcR2H5Pgl7gA/2r0rnV
	9MezwC9/T+cpkriyRrd/eHxixhvyilFrr/1am9xV0fb7CSb4R8E7q4I6aMgtTAbWVRK+gnjqy9X
	h8/qlQ==
X-Received: by 2002:a05:7301:c8a:b0:351:7ec0:cd4e with SMTP id 5a478bee46e88-3517ec0ce24mr3629562eec.41.1791486792986;
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Thu,  8 Oct 2026 15:13:03 -0400
Message-ID: <20261008191309.98263-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21976. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. fbdev: hyperv_fb: Simplify hvfb_putmem
  2. fbdev: hyperv_fb: Allow graceful removal of framebuffer

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
