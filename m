Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3A4DE732;
	Fri,  9 Oct 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549255; cv=none; b=clROX5HFAHVbLRo4CRIFw3VHostw+EoGOWudh2tR35ge+tEP43oTXuJeyC937OzpNSFk8aTMWAb1W0KkFUBnyaFvbWY11NCBLhINYFqRdV9DL30UQxC6UcKUyiBAxt8e2ko56xLj2w6NCnp+Ty5D9NmoLdC0aMs/LVrCRHM2OHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549255; c=relaxed/simple;
	bh=f4A0lM8jFg7mEUGM5hNXUYT7e2wOXndrALIGBoHvbgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azQKK4UZouThHo+/ya+rdfa0ATea8H/pSfQtk4JwlbduVZB6ygwzgp7LSAYwVd2HV6QV1EhvC4R9EUiiMxY9LjVHRKcvp1IvnYCjX9ayOyRt4UOxkfbD/HBuC4T+oRaxLErajB46Dle97tNCm2vDbHnk3PK90QHJTpitB6IROj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF3ODmiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF3ODmiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9551F000FF;
	Fri,  9 Oct 2026 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549249;
	bh=F3N4AREHVW72/gOFd3n7FAXhLVCZ7MZgfWmss94xEbs=;
	h=From:To:Cc:Subject:Date;
	b=BF3ODmiXV98TtGz96HQO/R/2UgoCwVGx23wEjWFG+1qlxYZch5ULE2EmEdjUbaHdk
	 7yEMai2NEHvVMlfQYyxzm8H5CIns6qq8kfZ3g20t8brRqnUPmwFhb8xIC7VSPA4Pbt
	 JmH1xHyEnQewVaJ5Gh87ohyUyyPdDPq81bJ5m7yTurYT4XvkivZRjtGKKuvdKVaMZV
	 G3CpCiI/QQ4KZRDFF6O09oKmvqEHoT0sxu96hnhOTH/jCtMMqwonXegiFBCFYqDcfg
	 uvjusJEqw1i9uADDv6CH/giQsLQKiPHWvdANAhl9ce7pFfrn78QapGTZMRPoZpYQ6d
	 u0PayJNb80TLg==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xF9nb-00000001wzR-2lhc;
	Fri, 09 Oct 2026 14:34:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>
Subject: [PATCH] USB: serial: sierra: fix urb leak on write completion
Date: Fri,  9 Oct 2026 14:33:59 +0200
Message-ID: <20261009123359.465071-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken by usb_anchor_urb() also on
successful submission of delayed write URBs during runtime resume to
prevent them from leaking on completion.

Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/20260916165352.2085480-1-vulab@iscas.ac.cn
Cc: stable@vger.kernel.org	# 2.6.32
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/sierra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 6e443aacae07..f2cc7f364d20 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -972,12 +972,13 @@ static int sierra_submit_delayed_urbs(struct usb_serial_port *port)
 			intfdata->in_flight--;
 			usb_unanchor_urb(urb);
 			kfree(urb->transfer_buffer);
-			usb_free_urb(urb);
 
 			spin_lock(&portdata->lock);
 			portdata->outstanding_urbs--;
 			spin_unlock(&portdata->lock);
 		}
+
+		usb_put_urb(urb);
 	}
 
 	if (ec)
-- 
2.55.0

