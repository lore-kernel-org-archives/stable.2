Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B237E302;
	Thu,  6 Aug 2026 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786057611; cv=pass; b=mXfFUr8OIwUinLZFpOS/S0Vwyz7EOgA6J3fQexazoEwYZ8QCnprGze6y16Ya64TrVugsgQ0+EH0lAINH4RtrmwuekKpimyS6qW2KdX2ot04detR8YgW6ur55yi6EgrF6vqkURh/IBgPsp0vtrCBrI142NDFpzN6LWVkAfgKgpaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786057611; c=relaxed/simple;
	bh=4VFdMeL0Q1iLXS0ppEA9YcpAJ/Buxdfv7nk6kCQXc8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYlpw/JcjKdeZDTx1Z13TwR39aBkqdov7TR04dgdqjBLt91wbOuxuzbEE7PhisuOJb/xwwD+w6r94wnQ4JcfUgGBDojaC8XrgKM5DnHBbbMyaQlYOCXReFLKIM09UPPYaK/McpmatU/6WMVyfrdLtJmkOZdrl/EtH57pEoRsc6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=BQtk3gVc; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="BQtk3gVc"
ARC-Seal: i=1; a=rsa-sha256; t=1786057596; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SQzAxlt01CXlR0JVyn5FdH6011b+y8CEAqQ3Sa/d/T8BPx8iZbOyiCxsKdTpELP9AmKIXXqESF1+qjlo1wim8KXqgaK0wt3phaAQh5cf5VqCDma7d/a7XKe2TjnA4mPLM6Ac7l480/4mkK/EnTsrPlY9FFNHLT6sOcFI3AWMqtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786057596; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jIUSmgLwkyaNvInWihWhEoJ7HU5IwMrbhrej7hyF8r0=; 
	b=HUGm+cM/GIIbRgNGNTYB/Ufi3VdZYSGE7xDrEfB46iMoYsNJ3sYO0MphmQ2DF4jY1atRL+ay991qTSQaE3gUXmdXGuVcfINE01U6e8cc9Q9s6pCK3Txk5jctcb8c4KPfCm0hNDYRMoI5NlO7DuETS+ztok/Yt9P9Kfgzj4uMU9E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786057596;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jIUSmgLwkyaNvInWihWhEoJ7HU5IwMrbhrej7hyF8r0=;
	b=BQtk3gVc280nvlppkN+xgnSv4TqOgfUxCKwxxcA/Z4fbbbA5UxiumaXFH/AP5gIO
	jlT3kuJxex7KvaLJ6WOcV7ZOHon9RQV6JNcSJWxbMrF54s1XeTcl2udmEtZv1oN3oXm
	IGKbGfaVYVEsTmTre74IfrlBNw8c/uN1Tw98rFRE=
Received: by mx.zoho.eu with SMTPS id 17860575940434.719431756601921;
	Fri, 7 Aug 2026 01:06:34 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Pauli Virtanen <pav@iki.fi>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: zero the sockaddr before returning it in getname
Date: Thu,  6 Aug 2026 23:06:21 +0000
Message-ID: <20260806230621.10105-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

iso_sock_getname() fills a struct sockaddr_iso in place and returns its
size without clearing it first, so bytes it does not write are copied to
user space from the kernel stack. The getsockname(2) and getpeername(2)
paths both run through do_getsockname(), which hands getname() an
uninitialized sockaddr_storage on the stack and copies back up to the
number of bytes getname() returns, so the driver has to initialize every
byte it accounts for.

Two ranges are left uninitialized:

  - struct sockaddr_iso is 10 bytes but only 9 are written (family,
    iso_bdaddr, iso_bdaddr_type), leaking the trailing pad byte on every
    call.

  - for a broadcast peer (BIS_LINK or PA_LINK) the returned length grows
    by sizeof(struct sockaddr_iso_bc), but only bc_sid, bc_num_bis and
    bc_bis are filled; bc_bdaddr and bc_bdaddr_type, the first 7 bytes of
    that structure, are never written.

An unprivileged process can open a BTPROTO_ISO socket and reach the pad
leak with getsockname(); the broadcast leak needs an established BIS/PA
connection. l2cap and rfcomm already memset their sockaddr in getname
for the same reason; do the same here.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: 0a766a0affb5 ("Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 net/bluetooth/iso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a461c8a4efed..e5b2168e8819 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1536,6 +1536,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
+	memset(sa, 0, sizeof(struct sockaddr_iso));
 	addr->sa_family = AF_BLUETOOTH;
 
 	if (peer) {
@@ -1546,6 +1547,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
 		if (hcon && (hcon->type == BIS_LINK || hcon->type == PA_LINK)) {
+			memset(sa->iso_bc, 0, sizeof(struct sockaddr_iso_bc));
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
-- 
2.55.0

