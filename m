Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E653ECEB;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871504; cv=none; b=iiDePxgLLRX2EC1s6r6Gyo32xjZ/581H12H+MayTg0Nt5rFgqrEZWvhMfnrPIB/Rg2TfxDqM+HzqH/3oSuyaSqjO5xP77JStqGFSoq3THypP9xov2iG9boLNEXX/F0LbowGRZXRZhTK02Ne4H9idzppNpCWM/uo+rRdgZ0mwAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871504; c=relaxed/simple;
	bh=tggSJCl2AdaSwI6K1UKsXMUFn3nfnZ+dlVIx8qMmy08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/2ZBNFrDDgv7dmzDA3N5dmCJNPP94teIKX0PAIVgXiGqz+FGGiwKRWUokIIytbUFUqG7v9pF3MG974KYqJGAbXv1vwyaFOj4qlrVY+9zqy5tWm4BlF7ZPNw2nZZRw5ii/mNwcQ+Euv+DtucNpU0N5oRK+biPEM22hPfLvxZ7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvCSllkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvCSllkj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56667C2BCFB;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788871504;
	bh=tggSJCl2AdaSwI6K1UKsXMUFn3nfnZ+dlVIx8qMmy08=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LvCSllkj2sm2J7JLd9pjsN4toGFiIanibYlRwxG8GRLppF9gcb+Q9E/2lfAUlcAMd
	 CZ2Tqh3jfpZVXNznujApSMNDS8W9gpLjcB5jp9Ct9Wvyo6ZQC9MdB0CGxFHjG6XTne
	 BPyDrS6EnQ9wDYqYk/7jikloDFqQMMvfIE0YVjXhgJEnhaOCoNZSs5/Gjil7A6YpEe
	 0rp387o2TmN1ZzqVs7BmQ1jPJwnuBA4xVDYVJm2aacX9r1A3QSs6skSiwegDEdrvai
	 CQlQNOswOM533J5YZhr8zVl+TPdfEbAOMSkmPvWN9X41qJhm77/1A6akfI9O/cX1VB
	 DAVBVuXNoGOjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8FC79F99;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
Date: Tue, 08 Sep 2026 14:45:01 +0200
Message-Id: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NsQ6DMAxEfwV5rivHAgqd+I+KgQQDXgAlFNEi/
 r0pXTu+O927HYJ4lQD3ZAcvqwadxgh8ScANzdgLahsZmDgnw4xibY/dUtxMiZ1uzzmgdZKlBWd
 kiSEOZy+xOaWPOvKgYZn86/xYzTf96UrK/+lWg4SpFGmeGXJNayrddLm6N9THcXwAEn4yybIAA
 AA=
X-Change-ID: 20260122-ebbg-ft8719-fixups-bce548250b02
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Casey Connolly <casey.connolly@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=tggSJCl2AdaSwI6K1UKsXMUFn3nfnZ+dlVIx8qMmy08=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoANOFJeLQjNYi0kXTpsGdTO+bBpMS+a5Wl0S6
 Nl0RyjUoaiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqADTgAKCRBgAj/E00kg
 ciBnD/wNSFGRfZVkyBhqNF/AkPwW+A9tFaAfw6x8X3yaefweifSqELEDIH87v+L6N1TSxgj32QD
 RNZ6ocaJEAZge4WV6qcvklwSJcWGlwhWFoBDHnIndBbRudUMIkdZkxvIo1htvE9Wn9Gq7GCsCwY
 mhIRGr05Uba06qS+W0SoZt1jt8U+Y0O9N1AOql3NGNv0qRXD63M8cPh2PYBuOFgcu/nQVOrF3m8
 GNB9GKF5dPRjRfjNB7Yp0pUCX+4OrS1opxeRZ4qZi9pin26icIIoMHBqMV+tz7qY+x5eRNJSL5y
 RmNkl2frVAmm4Apapb120L0gG4Rezu9RS/0hC94pRoRAypz4Ku2ZkhJ/7IlDbgEV8yNu4S0zCyg
 WoRACCzChM1NvHTey88xChBgEzsNleOO1GXjqVvzTNkCnFyNuTqIMDBdmhdM0poX/QGKu5Y4dPX
 F2dXB8APaQPmZssiW72lizk5G84nletKZKvHiPRO/y9M4B4pRzyGmw2cQ86Q+XSADb7Hj7HjZlk
 g3r6G1Dt47ugA8YxFSSvqT+CJH+zhTxcc+DbXHn2+Ein+ejEjocHPVGm1NCIrh6RUmvxULnvBOB
 FkHPEFCE+Z1A61t5ROmhpTKdQwRjALU9ow3HIQD40cy5V2cZLJGGWQbZs0Sfrg4hJxyvbBZljdv
 laqYTedl76R230A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Been broken in mainline for some time.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Ignore the disable() errors, as there were ignored before too. (Neil)
- Update the `Split initialization into enable/disable fn` commit
  message. (Neil)
- Replaced the maintainer old email with new, so Joel gets notified
  about this patchset being sent.
- Link to v1: https://patch.msgid.link/20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz

---
Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

David Heidelberg (2):
      drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      drm/panel: ebbg-ft8719: Split initialization into enable/disable fn

 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260122-ebbg-ft8719-fixups-bce548250b02

Best regards,
--  
David Heidelberg <david@ixit.cz>


