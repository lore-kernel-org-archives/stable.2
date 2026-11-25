Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.203.187.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604671;
	b=J+JfbpN0Td9TWar8z1nQaqio2+E70UuCHVc/YQFv04Zz2gBAyCGcAc+d8bCBd85gb+Hz
	 l2ArSW9n8tvCvEHKVYScgIZSSa9QpB9MIxuWz8eBSIUZLrC4oDuzsUFwlxuJOyDeGW2py
	 9H6MBDK+Qw5/Jj5ARWxgr2PVqNlMsnzVFpg0ykIK72iknz4xF2mhgGm9l7XFHM2uX1l/E
	 4L/K/NPvVH0e0HYt3E0unFbHMXip6LhjW6Qmy1lKO8neIluS/soyav4w6TCR9jD+6Jkrl
	 x+1nGw5u2I+0Iu+VBujgeL0/OYmCxBk2/sKmvRQqQSVWEwHGuaD2sw0alUVup2MpIlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604671;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Auth-ID:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Classification-ID;
	bh=/1Gj7IvUx7FrAw+gzFpkzUkO9qKuI1oLpxyzvSDSlY8=;
	b=4aYU44qaO88xk7dFyMs/MRY2qQtYswc4LCjIBc3GdnDlY3HaY72fhFKHg5r9exsjhoLu
	 EBKJrw4zcsz9+/snZkdjWFNJWWD6rsaS7ppArxb/29arripxnL7ZPYKEWSnAq2aDc2rqF
	 P7E5jq+TlQZVRQXGxrh6gHF/n2riwkVpykEI+UyDPjcS7Ygehq0669s0296HDyjhX+PYx
	 nUbkeZGdMXbE0RhGwViawb5ubvcJqrSOB6cYhIPRztmvTQbg0sR0wup5KQhzQpIG3ljbX
	 oxDZj/NfBcLdMtvr0tKwk5dPijPJwIWNQyDbr7ji5AUdDwcl97SBzJglSr3RACZEtSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.a=rsa-sha256 header.s=feedback header.b=O3qDekBG;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b="pvMcd/VG";
	arc=none smtp.remote-ip=173.203.187.105
Received: from smtp105.iad3a.emailsrvr.com (smtp105.iad3a.emailsrvr.com [173.203.187.105])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745E606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C745E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.a=rsa-sha256 header.s=feedback header.b=O3qDekBG;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=pvMcd/VG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
	s=feedback; t=1795604664;
	bh=+o4lQOUcnLmB5xQaJEIxUTKlNZk9WL8bxXIwWjtgWjU=;
	h=From:To:Subject:Date:From;
	b=O3qDekBGDXm3UMWK3Gtes/EILPlTq7J33jbvEeGoRTTopAFyC+YycUGyRipBF60+q
	 FnYbZnOL4QmVvbUC1hpaEMpU3+wU+rfxTVRdg5zsbqL3LoSKRn8IwatIcK5IABhLFn
	 pijaYPzsJkS+qeP/xnkWCa20PL/abO3Zo8w7U5Yg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1795604664;
	bh=+o4lQOUcnLmB5xQaJEIxUTKlNZk9WL8bxXIwWjtgWjU=;
	h=From:To:Subject:Date:From;
	b=pvMcd/VGTpvXL8ZVkv3SHZU5s4JnIbkygrmbbv63cy/uWq1slMH42FqwNjPkWubgs
	 p2PWlNUcTszW1YV+FB+qsmJ/8pcE7LXxvIKDveoYHsvxRgzPb1pAh/WtA0oiOMxoSP
	 kcDWk7lracTJ8eP1GZEMId7a4kqDuV2kDBQimPm0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 910CA54B5;
	Wed, 25 Nov 2026 06:04:23 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jeehoon Kim <Wlgns2756@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: adv_pci1710: prevent NULL deref in command test
Date: Wed, 25 Nov 2026 11:04:06 +0000
Message-ID: <20261125110406.70945-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b6340151-2788-41bd-b58a-8a5cec7d917a-1-1

From: Jeehoon Kim <Wlgns2756@gmail.com>

The COMEDI_CMDTEST ioctl permits a NULL channel list: do_cmdtest_ioctl()
only loads and validates the channel list when the user-supplied pointer
is non-NULL, otherwise it calls the subdevice's ->do_cmdtest() handler
with cmd->chanlist == NULL (and cmd->chanlist_len still bounded only by
len_chanlist).

pci1710_ai_cmdtest() calls pci1710_ai_check_chanlist() unconditionally in
step 5, and that helper dereferences cmd->chanlist[0] on its first lines
(CR_CHAN()/CR_AREF()). A user issuing COMEDI_CMDTEST with a NULL chanlist
pointer therefore triggers a NULL pointer dereference.

Every other comedi driver guards the step 5 check with
"if (cmd->chanlist && cmd->chanlist_len > 0)"; adv_pci1710 was missed.
Add the same guard.

Signed-off-by: Jeehoon Kim <Wlgns2756@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Fixes: 56556577d9c4 ("staging: comedi: adv_pci1710: don't check the chanlist twice")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/adv_pci1710.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
index fc749241da416..aa0e56df4d368 100644
--- a/drivers/comedi/drivers/adv_pci1710.c
+++ b/drivers/comedi/drivers/adv_pci1710.c
@@ -621,9 +621,9 @@ static int pci1710_ai_cmdtest(struct comedi_device *dev,
 	if (err)
 		return 4;
 
-	/* Step 5: check channel list */
-
-	err |= pci1710_ai_check_chanlist(dev, s, cmd);
+	/* Step 5: check channel list if it exists */
+	if (cmd->chanlist && cmd->chanlist_len > 0)
+		err |= pci1710_ai_check_chanlist(dev, s, cmd);
 
 	if (err)
 		return 5;
-- 
2.53.0

