Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D053E16B9
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434187; cv=none; b=hBbeFckqzMRiviCSCObf/GGufW3AjQpllhMt/8GfhFRhVk/UhikMdUqTcvoNBFpU/N3KCFc4wlodI/5MB1a6rzn4AyRULN7kt5h6K2QLg6Q0hybnKDQw66vzZqymE7A+6E2nL5epITpSbh/zsM4vKie8T58jp+bgaN4ii3Kj7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434187; c=relaxed/simple;
	bh=O4ei2s9gZuecLamrTdJFFCxcBL+em9k63fiNXCLXqzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0FEMa6sHf0+PzcIi3FH6FTq862LSIcccVmK1FvQt8onp9anaXwVNqbgOUjeyxjOYIgElpi4UVLCRDOJsplXcIoDcGfixl8zWW3iaeziwMDLvl49PNrpzPA8drV3cAp1XRo0nPUc1ZH/OBKoiolSH7NyPEYS0BbiwjISYgYi88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qp2Ww90z; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp2Ww90z"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso8311325ad.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790434185; x=1791038985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxnEwlfneT94G2UrKcochh8UCTOdTS8Fzu8EtUevf3s=;
        b=qp2Ww90zkqywzHPDhgrZqLYZkkjgVFTs+7wMumtGuxSvnBFuqfPm720+/gaLeoUafx
         HyWcc21HV02Wzl1EgDsXLDuGYvmK2GPqtAsjZF+iZuZNlLr83yiWoUDtIpVrzSHPgYAv
         qP7LlLOxtl7Ax0rWyw10zj10FYEdtDCs+QRFm7CxrcHWAofs4ydb64b5O9IQG38FPeMo
         h3Sq2sXVHxncoEsy4AngWZx7s/O4AyRvMkp013z39bZkXx8Ib7Qh51Cf/ztWpPR7eGHN
         5AXo4ripakkqKWH6F8zKWj+3Q5U4MMErlObyMnmFtjP8i8JA7MU4ARTb2IWXRjw7yVL3
         ehTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790434185; x=1791038985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxnEwlfneT94G2UrKcochh8UCTOdTS8Fzu8EtUevf3s=;
        b=DZW63n3t9aWI5CLamEdB/ZOMeFk8c0PTcie3b4CzGJfw/OxBIfm1MTyZ09QD/eYf9t
         wBPlqZaeDIxsdEZSiyPeUpygEwYKXkZ3DtdSdagCjSURO+NblNzfNR2+QoPOEQ9Unr02
         ZsVwGR74oadV6VvRcinK0WjC/W+B929JQ1q8WkJorkM9BdTmTKvjggttSK9b7x+U1uk5
         ZB++kg+5tg2f33z8K2hy1KpvqIcvpofau8ok3JE0bC4WRoDePXnW6ZAfRWUgGzudDRcB
         53PfTWRjAIUA7ElBhH/6SsodAmI3H9cnO1X5rPvhDivWl4UQ4PcHMMCQgoDlY5ntHx19
         qwNw==
X-Forwarded-Encrypted: i=1; AKwUvBy6DF20/jago2Npj+w1qNF4kf9wl7O5JCRFTRXwtUxMf5LUqdrTjnr1600goR3lC/JJAWPrpQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqMLNA6b6ARjv5TzLOK4V/JijRLgfEdzA35Reof0vGOcF0ms1w
	j0XaJPieTfowmNBP2edz3zfkVNTQNsRpgMrtC2cpgKMmyCjtyfEnSu4E
X-Gm-Gg: AYBFou3eUDMsV2eVkAs1aPSdkywsA6c5mpHPRbrW1oiaukJltRiBO0/S8TRUt4tG5nf
	+pVqFVtL6v0KrjGQ9zNCM+x7hWalwFya6bZ02fD/+k+1MDZGkm6zdaZOzki/gE5EUA3y8AuPlv4
	6c4EzV6qyyNA/OHrWMWzTa3YIhga14nxz+8h86MjnmBbrBxhYqk9Jm9CcNrXh65wKDq3D9BAzYC
	p6EH1Bu3uXTkt4XY/KEmlhexV0raWYxD2EbfAKtxxv7ZXAPEiIJAjq6jMV4WUloysFftmNQvvtB
	CQhY5y8mDpkgAoPcaby/OhiymKOfdDjK5H4/fuh3pghQ4I3O2oTYGRMKeLy/Z6KlYfP4vjztYgQ
	HAN4V6wxGMsyWyLlukMaPdiiYB9jvqsh2PxKHh3n/+Ugk3HwhrgYbGw99+gPkRoESSUoMzDLEd1
	/kGfD+6FyiXPvDM0O98fgA+B+qhRIJp9Xegl3g+5XwqqqPujW3RbJSiuJvC40lYGSBQlH4n11df
	eAOFXp8aRub1h7B
X-Received: by 2002:a17:90b:3d92:b0:3a0:f0a1:b460 with SMTP id 98e67ed59e1d1-3a0f0a1b954mr748138a91.66.1790434185508;
        Sat, 26 Sep 2026 07:49:45 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:a00e:c90a:972a:c5a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm10105011a91.10.2026.09.26.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:49:45 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+89f5f8143d8e62af2b61@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nfc: port100: cancel a stale out URB before sending a command
Date: Sat, 26 Sep 2026 21:49:40 +0700
Message-ID: <20260926144940.14412-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port100_send_frame_async() reuses dev->out_urb for every command. It
assumes that once the device has ACKed and answered a command, the out
URB of that command has completed. A device can answer without ever
consuming the OUT transfer, leaving the URB queued. The next command
then resubmits an active URB and trips the "URB submitted while active"
warning in usb_submit_urb(), e.g. from port100_probe() when it sends
SET_COMMAND_TYPE right after GET_COMMAND_TYPE.

Kill the out URB before submitting it again, as port100_send_ack()
already does.

Reported-by: syzbot+89f5f8143d8e62af2b61@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=89f5f8143d8e62af2b61
Fixes: 0347a6ab300a ("NFC: port100: Commands mechanism implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/nfc/port100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index b613f5e2fd57..5fad6444fe3a 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -780,6 +780,9 @@ static int port100_send_frame_async(struct port100 *dev,
 	print_hex_dump_debug("PORT100 TX: ", DUMP_PREFIX_NONE, 16, 1,
 			     out->data, out->len, false);
 
+	/* The device may answer without consuming the previous frame. */
+	usb_kill_urb(dev->out_urb);
+
 	rc = usb_submit_urb(dev->out_urb, GFP_KERNEL);
 	if (rc)
 		goto exit;
-- 
2.43.0

