Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910451DDE3;
	Mon, 21 Sep 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029577; cv=none; b=I85EiRuUZ1rf025TOHUq4Vds5g2DnMIyA67vH/3EpKXUeJoN8YJVLbIvTgMmEWcxWJ9YF86dffQ7QJWP5ZLoMxiz1QZY6/VL9XY/g6MVziGTl23Ri8y+YoYRIrksCMQkubH+TEQusXvpC28ghjTKUvGpeVJMgLIG9092cnLr7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029577; c=relaxed/simple;
	bh=Yv5tl/9xomBQKEsb3GwoVPia40mBIRfiEi6dJ9H/VOE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vANnv/kbGe19whiliB1AuTkZVAjQekkHWHC3e4+q6bkf2AkTatYrLRpl5oIjdl9M44ceE66iekQhGX4L/JTqh07OROz+UQir2ZmeO7az5IVAUSdxMk5AS3iRm3KWp7uZLumNbUb8LjAY6S0D1RpoSW4ljH/WufZUWJPtp0bZ1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzZ7IdgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzZ7IdgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832F21F000FF;
	Mon, 21 Sep 2026 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029575;
	bh=j30NcFiL36gEYC0Nk9dFYUMM2g+3L2gHkR4x76TqSgA=;
	h=From:Subject:Date:To:Cc;
	b=KzZ7IdgKAvuGG8wWDT0/Iq9OVRT0kwvpMcwJnQyH1oUb6D3MuIKu1nr+z7N4gymuK
	 cuvy1BJN/55/K5o5fY2vVcMYS8KLM1NmJ+lD7WTEzC1lWi5ElCExYWyR0IFZ5RYVfB
	 6G38aHaOeKJLRyMVNSEJwcQRsjJJbejOl7OjSHK18SxN05SE3xkI0Mu03fWqvYeWw0
	 1cpUsk2GFXJ/8nG/BV0g1jI/Dt0Kt4uE9Zwv3GnfW8Sn2L9bGb023gb1LoVAgG6nhx
	 NkUVE9/skAsqP5tKiqHm04q9D7I5GiTX2+Bp8SZ3WDeY8tdaUMdj/Jk/B8GYU4cLsw
	 XntT1e+PrUCSw==
From: Michael Grzeschik <mgr@kernel.org>
Subject: [PATCH 0/7] usb9pfs: stable fixes
Date: Tue, 22 Sep 2026 00:25:53 +0200
Message-Id: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVhJNK6ilhoO2UskA4iEXdXL
 L+8/O8Cocgk0GQXRDpYeJkTyjwDN/bzQIp9MmCBdWEQ1S7WrEECnySKKmu911gGpyEla6RvSEX
 b/ZbdTuS29wPu+wERSPSXcAAAAA==
X-Change-ID: 20260922-usb9pfsfixes-e3bbdd821fc8
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org, 
 Hyungjung Joo <jhj140711@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=mgr@kernel.org;
 h=from:subject:message-id; bh=Yv5tl/9xomBQKEsb3GwoVPia40mBIRfiEi6dJ9H/VOE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8D5L10QTOdW4gvEifvqaHSNif3qk81kcFmf
 W880qAAhG6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvAwAKCRC/aVhE+XH0
 q3bmEACkJEgBpHkrr70FxdDZ2yfF7EwcdnNSC+7YqOmQbeIZyWkF0p6DXSX/6PrHW+xoAm7QiV7
 vaaAfwVPY3EeZb2LTn9VsJyEryDvmCMkDTRvuUKQQIBdYm93nP3NIdfMB2lM0SYqGBf2VuX+xNb
 c+G0gKiBhjTHq93dpD1V/9s98LpYH0U4gEXcMWpaQkYiHsAQN/NfCWn2DIAIhkVgsT6aEYblI1m
 z1m5pHlGf3fyArP9yPj6mBuDrYb1pdlzz3PsLQuuk2GJH1buL6DCBcIhmrWORLYTVEuUzGtl8Pi
 fJ+X56+lId6eCIrKd94gmpyfROwLYAtDeOjTHlgleONsHKR4l3e4/lq2i7LNT27v8Ix1MOqhVPU
 oRYyWSu+OQM8rTeUt2ZrCr6RbiSX6zell+CZL5ts6WNX/tuco5oTlZql5kfs/pKLUu2uAG/X0wa
 F2s6A7tZC2FSze8aLnul/IXfRbAbVwnBng0k8FnTe7i9VYD+dGWA4i8dfwlnWXTo10vS0OoSmjN
 BRVP/46IOxiqkJJOLM6xrjVighGQ2z/pwePtjmTJ5jZ2kHwGbi7+rpf37naeQicMtCovXJR4RFM
 JCXCKlTR+bnOZZIBFrAVcOS3WyavcTnSHcX2+G2jhwhXQQwyIbgBlmIf5ptvQWpPVcQ0YHuvjLw
 qroMSVbO0ZSSI2Q==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

This is a breakout series with some additional fixes of the
first series of fixes I did sent out earlier this year.

https://lore.kernel.org/all/20260319-9pfixes-v1-0-c977a7433185@pengutronix.de/

It only addresses the stability of the driver and left out
the interface rework. Therefor I put all changes into a new
series beginning as v1.

Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
Hyungjung Joo (1):
      net/9p/usbg: clear stale client pointer on close

Michael Grzeschik (6):
      net/9p/usbg: also disable endpoints on p9_usbg_close
      net/9p/usbg: set client to Disconnected on usb9pfs_disable
      net/9p/usbg: always reset completion when disconnecting
      net/9p/usbg: call disable_usb9pfs() from usb9pfs_disable()
      net/9p/usbg: fix out_req buffer leak in disable_usb9pfs
      net/9p/usbg: remove bogus context initialization in alloc_requests

 net/9p/trans_usbg.c | 80 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 21 deletions(-)
---
base-commit: a170f3dfda02b6ab58bcd1caa1ac5421323a9b45
change-id: 20260922-usb9pfsfixes-e3bbdd821fc8

Best regards,
--  
Michael Grzeschik <mgr@kernel.org>

