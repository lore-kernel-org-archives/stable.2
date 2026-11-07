Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794045980;
	b=q3TxZwdRsw6B0Zza/G+ckEmSVbrA5Sv36xh/kpuaWllmIvtJQ5+6LWKLfz5IPQN2uwqA
	 4V/GsGNZ4gM+ZQWjbkv7e4Dq4z8z/gpw5ACD2m07D1a7nVOXfueFQKbtOB/dRz46AK1w/
	 zxsh0Mu3SI781/J+Rj/20zPBtdZ7PkJvYCrbtwXQlLzkGV34YCEk1Nwd/kd9bSzNKLVdC
	 ZtCleExGIKRfFZeLNbTrZkkKM1ed1WfVyUpXhh5nUAg7acHe2lYgXjpYyVP2uGFFNSjSy
	 XdxfZUxx0kyM6XVFSlgWzDs9X/gRRgfgpXdp6Ms0V+DN2nFw15K+YJhIyqqyAhLd/dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045980;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bCerr+Z00LP4frO9T0gK5dDmzJIA0ndilU27xwPav5Y=;
	b=2nD2ni0NjMptF7K3jgucWj9CqrXmoG99D6aMwBWgZP0rRXG1l1P9qjLXHc9CSwGbhWtK
	 Su2GSuigtSKZjhFC+JhUuMZoUmDBG6J9h30KbgtQfcrWggCDu//u0vCVvJDwE/dRkUeDq
	 yWcxxjlO+V8338xhOQE6Dgn4fUGRfp0mNAZ9kAWrox3pTGMpcp/k5mxXX8rWdL1O7xbS2
	 NAQo+xreaRZSFaK+0u1XzlJKH7fcWESOIhLQsbhEvAa4p1ZskkQUSSkyrUqYcpa3uHdJH
	 WAOnbGorKLPIWKYsPbpaVgggvHKsxAGCW8mbiGhlWNb9G0HQAegAfakJpJK05HkT/iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi9Nw6ci;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAB606A32C;
	Sat,  7 Nov 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pi9Nw6ci
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794045979;
	b=Qr9KRYOpo0BnzOAUh/keG8FF9wQuSVBVUlCtABCrb/d15MD+d02IHX5nutP/FLeM0AbR
	 XwSjnmo/V7BPEOUR/LHfKdOd0G5/S5fRcBcDobisRNsLgupNqDsw8unhPL3EuTyjw5saY
	 7kdwnQyTwjUchv8WvPFb1X1y4lMxRy2YT4XePRNXPMKQv6mwsqlI2dF7j0HZZLu2F+zCu
	 nlBb6QJobn1DE78qF8Mm+GW1Btxllr0i3gBUAaLcNXky2MUxPC08Fkb9cIxOedZWC8COM
	 09oIo53YAIcLO01zRxPe6VvyfNiDY+8AwnnY8RLqO4IV3tMbtiZ8rINHkYZs7apr5NA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794045979;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=bCerr+Z00LP4frO9T0gK5dDmzJIA0ndilU27xwPav5Y=;
	b=yUO0utFlINnHOWOnIBYDClULjL5/f1H+iu6rK8YRETRow97UxzG0WRluMiWghz6HSG2f
	 S979jQPS1Xf3mZdSSaJ6Yi5ks6J2DCFgyU6XEItjOXpC05XfYSy1N9FmAQtoCi+GvOK9t
	 oKxaw/nihncVyCij7rh80TuFlf87ydZKN48X4r/WhMCLFAO3nR3Uhk2YKIw37NB2kd9j9
	 H+fcrSIs0SVgDOWgHzoOUsmHZ2/lJQn1099t3a6AzmZqEg09HM2Y/hu4jb/GWMp1mzHZC
	 gouezQa4NmFl/DrsQqMGSU3M3B8EaVVKq2Cy6K/YZnt3isx6YnUGMXBh8CngacVoOrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5434B1F008A1;
	Sat,  7 Nov 2026 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045979;
	bh=bCerr+Z00LP4frO9T0gK5dDmzJIA0ndilU27xwPav5Y=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Pi9Nw6ci7z1e9bSSeYUey6YoSDHF7Rf4K/ZrIm1QDTBBH0wmqN54C9nCsU4+9hj+O
	 RrOWdJ7WbDeO3PDZz5NUA1Jq0xfco4czc2laBPmYBgxEHwoApBIM66iUSmmILGwju1
	 K/v+MRU/PN/KT970FtY03vMb8BwcIk33gfgLYB3Cxc8MSSNtjH8DAiw8h5Zh5E1v9R
	 shyCfLyKzNCa3yJPyDgLos4G8ikthh6m/h5BkmVD7KCZDuntJveqSSbkg3jGcNG3uj
	 uBnJqkXyo1ilN8KsCGY91X7WC+b5qd/OxSOChCvPiFxwre70tt7D8ifnjLeP7EmdV6
	 yna43pvLPmNJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D1E9347B2F;
	Sat,  7 Nov 2026 10:06:18 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 10:06:17 +0000
Subject: [PATCH] usb: typec: tipd: assign partner identity to persistent
 memory
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-tipd-stack-uaf-fix-v1-1-efcb517924ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIABj47moC/x2MSQqAMAwAvyI5G2jc9SviobSpBkGlVRGKf7d4n
 IGZCIG9cIAhi+D5liD7loDyDMyit5lRbGIoVNEQqRZPOSyGU5sVL+3QyYO2pKpTdW8UtZDCw3P
 S/3Sc3vcDewcuVmQAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>, 
 Hector Martin <marcan@marcan.st>
Cc: Neal Gompa <neal@gompa.dev>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicole Mazzuca <nicole@streganil.no>, 
 stable@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>, 
 asahi@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794045978; l=2080;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=11jWNoNyYcLtaaM1fNLvBsJPDBw5EU5pTtOvCfnWMwo=;
 b=G8zeiNyKG6OsjYAWHxwP2e7A8a0o4EJnDAxqrHOhnh3417IfBii0p81xO2n0aHm5VtGC5oEU+
 uFXHj/X3vdEB84NUrq78FxoXHyWuPOrJIdBMg3CrPlL7H6qxZF9Q4MH
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Reeves <michael.reeves077@gmail.com>

cd321x_update_work() passes a pointer to a local stack variable
(&st.partner_identity) to typec_register_partner(). The Type-C core
caches this pointer, leading to a stack-use-after-free and a kernel
Oops when accessed later (e.g., via get_pd_product_type()).

Fix this by copying the identity to the heap-allocated cd321x struct
and passing a pointer to that persistent memory instead. Move up
the assignment to cd321x->cur_partner_identity, so this works.

Reported-by: Nicole Mazzuca <nicole@streganil.no>
Closes: https://github.com/AsahiLinux/linux/issues/668
Fixes: 82432bbfb9e8 ("usb: typec: tipd: Handle mode transitions for CD321x")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
Cc: Nicole Mazzuca <nicole@streganil.no>
Cc: asahi@lists.linux.dev
---
 drivers/usb/typec/tipd/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 02539378ffed..dce0aa8be5e0 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -855,8 +855,10 @@ static void cd321x_update_work(struct work_struct *work)
 		desc.usb_pd = is_pd;
 		desc.accessory = TYPEC_ACCESSORY_NONE; /* XXX: handle accessories */
 
-		if (desc.usb_pd)
-			desc.identity = &st.partner_identity;
+		if (desc.usb_pd) {
+			cd321x->cur_partner_identity = st.partner_identity;
+			desc.identity = &cd321x->cur_partner_identity;
+		}
 
 		tps->partner = typec_register_partner(tps->port, &desc);
 		if (IS_ERR(tps->partner)) {
@@ -864,10 +866,8 @@ static void cd321x_update_work(struct work_struct *work)
 			return;
 		}
 
-		if (desc.identity) {
+		if (desc.identity)
 			typec_partner_set_identity(tps->partner);
-			cd321x->cur_partner_identity = st.partner_identity;
-		}
 	}
 
 	/* Update the TypeC MUX/PHY state */

---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261107-tipd-stack-uaf-fix-d3148059c017

Best regards,
-- 
Michael Reeves <michael.reeves077@gmail.com>


