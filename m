Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285942;
	b=zfatgftwlp/cZFSqtYTrbE/+3bY+/EEAtwlghKu8gDKnxAwcI6771La+8qNjf0F6vHK+
	 ++e00SnUfUMUjIpW7LxgVjY+4mkxjy3iMyRsdoNn2wVKVQDAH6OZP7mIMLSdwlQoBRhyG
	 /sNyMaXz7zVV9KKrvpS3OiQtLDFrgkJQh3alg08xl3xzWQ948M+dQsIq+oEdVS/r2gRRj
	 th+vH/JS0vrfP4uGC5SuoM0N5ujt5SznvQF9KoIRha9kugG2u1NhO9vNmrQXc9hJ0IX6s
	 hHlgMxhBoj2p5yn9E2sLkkmzYsAVPK2FPzAFV+W/bMMYN0ltCofJ5Go/CeyR2y5xLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
	b=h+GS97XnoYAIkl7DAsaf1VJ7SU7+2f2Eed+7/ww0gRkBcKVgqeW+EyjJ5tKWMC2Eksnh
	 C/umOXqJFvB2xvwnBo8q7zJkdIxaeY7vlmkqyRVp41PYXNusmqHTUXflkTJpyy5m2rziU
	 gYgvjuQ53avgqW7twd4qmP47tl+feRpR9WB6oyrgtCcJOomSRUw04sbumswDAAL1bRGw0
	 OyjdG5Bm4LJFwoZAJErd4gCDtmE4Pivlugqv9ER+eZbOrZGQatcT07NJPMCjjQgNLC6c4
	 kb7//s036j8GJYOEdHQ6gXgTKit+yx3WwloUNWPOvgKyyAg6XHspmBWbLDyi7wWCvNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEkVXSPm;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4E3606A323
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4E3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEkVXSPm
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so20046655e9.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285940; x=1793890740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
        b=uEkVXSPmhnvCFI1L4+2+0k0KbwiX2lUGRnEl5UdcX5B5WerVThw0gKpk+7OXuT4NsS
         dagdzhqNEWgvTbQ88qQwx1SFzHT0gt/cznkFBxFJ05P78rx8TYrq019QxvsbwxyYb3fS
         R5Wo7p08Z4QA4sPa4k9vTNir8pltgp5IQJ5EaXkKWwRy2xkq/xZ76ZWJWmKrUvyUVMFh
         0hR92+Cn5TK7Ve9V7To7Swd3LDWmeMwVhKlYHwatOhuixMjkxa1rVwdc45hwH/HLqTc3
         xpHJHo/LS7XWKaeeX0zcVtSL0Y4fNEDBpUaVBuVz1tuZ8Hmtxp0Y+z60Urhdkpup+q1k
         NXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285940; x=1793890740;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1NlihvaJXejrTDGGOl3Hof38A7ldhULq/AQA3ZMnok=;
        b=vWpLnzJ5TIkvbBxIsH/fmoOjZobQaOrf4OL1KQdmhOgcaNzuaYpjEMVvRhD02Gwqx8
         Cz5vb8sdWIC+eVwzc1f899eM9rrTchP/o9hY0p9gAl+DwQaRlqy/SFiBnX4gQv5QUeGn
         LWmQA3bBXqeDPtyV+uV2EreKDWgsT+FxMgW2G1wm9ioUPSJeEHMhFSTU8N2FRsILBCrh
         CB/4j0A+Vp6p/wDAEyULiKOTBhxOTORSOE3M6jSOnd6Q7M+egn9TpwEcSHIu6G02YFN4
         sBpmTRi/XBatc1yhIoXVrYnFE4k1FkraEXfU7JwWtqeII3GtbCrK789E28EIaH0Aqu3J
         O4Qw==
X-Forwarded-Encrypted: i=1; AKwUvBzQayAZX+svllZ3K/784ekfO54XzrmwbCCDEhHB7n482coAXeI3ucvWy4+4gFdmHpb5412Vtbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsRCodTcQoN7K1KvzkzqPA+pCVMgdB/PY8rb13zhx6tKCb5AMH
	LUbZxjz31qVkRRCayJIbFLGMDzEZJ/5SdWqUWMk/Iso366ofvY0QD36l
X-Gm-Gg: AYBFou2Elra+tZC83qRXMDqKbhlzefkWXpPp8qIvjItKbu/bl9Kbdm/tSTodkvIzbJw
	BBcbisijTbHB0hErPzYq75ZjMzr2bvnXhLVrPww5x3xoRPfshLw+4vPP+f2wcezBXZ444AWMvTQ
	gu2VNXgL6bXexHHPexkK0u8EUTnWQPP6ck0SCIUfQgD8cSvvJ2QZuMNHiZ8bhiIUDc5YKQlNUmQ
	bp/AZdnjQKJZhjD42q+qi/dTtMaXbMvi60Kp0D6YKeV45HTdpV86tiPdygWFNvfXoMY7ZBzEASG
	URQIGh4W1bvJUvolAjEIUWe3CBknvmnhjfB4bBnIsRXRXKnDQNruG+B7ljkIXK0edQuPi8ruV5C
	Sj1tUz+XLfxF3ENtGN8Ayb9Qt6/GoIQk82pk/u/klX9j30R4/hLZdk+80iVFiSGaGRvAmhQA+tR
	sn2mOoCVmPhBUUhEwj5cNYf2X3kjTnwj3Z1298WUT+Z6gO+DV9R0Mok/WrvuRnBH6XNfzK5HJeI
	hUhHGouCtNIaFPPxQEWLJm/CGvsRvKzqDm3RxtqEdkmhGmAfF6FGxrA3o/gUwHK58BEwgEtqTuY
	n7OdTmhBOLNt2AMqgWAwGPBa4jA=
X-Received: by 2002:a05:600c:37c3:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a9674e63d7mr123124135e9.26.1793285939996;
        Thu, 29 Oct 2026 07:58:59 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm70941745e9.14.2026.10.29.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:58:59 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abini <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netdevsim: reject port addition and clean up ports after a failed reload
Date: Thu, 29 Oct 2026 17:58:34 +0300
Message-ID: <20261029145844.231018-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
can be added via new_port after a failed reload.  nsim_dev_reload_destroy()
returns early in that state, leaving them behind.  nsim_drv_remove() then
hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free.

Block port creation with -EIO when reload has failed, and delete any
leftover ports on the early-return path as a safety net.

Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=88435e204734072bf39a
Cc: stable@vger.kernel.org
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Tested with syzbot C reproducer.
 drivers/net/netdevsim/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index feb88ccbbced..61f0824ce4d3 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
 {
 	struct devlink *devlink = priv_to_devlink(nsim_dev);

-	if (devlink_is_reload_failed(devlink))
+	if (devlink_is_reload_failed(devlink)) {
+		nsim_dev_port_del_all(nsim_dev);
 		return;
+	}
 	debugfs_remove(nsim_dev->take_snapshot);

 	if (nsim_dev_get_vfs(nsim_dev)) {
@@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
 	int err;

 	devl_lock(priv_to_devlink(nsim_dev));
-	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
+	if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
+		err = -EIO;
+	else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
 		err = -EEXIST;
 	else
 		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);
--
2.56.0

