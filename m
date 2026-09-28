Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22253CAE60
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621957; cv=pass; b=eYH3siH7CtJ14D+pqRM0B9bNbzU036vnDyyZswpQ3qvxlyeu4NhFvOkIMMy5oUro8cxyu425tH1fHLndhrjLVx+9gktB1ys6ynpwZxnSOF7FCaUAtB4bXiJLBhFNkfvzW4ROqL60aTRKNGZEHVPBK3vcKz3Q3Os7Iqh3z8Mvojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621957; c=relaxed/simple;
	bh=38U1s8GZuYMNUAkuLxbkuCyOG+w/gVbAI7eJbWfyuKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l+UU7VQ+qKsGoEKdriHlSeQLT1S84j1rv8s6JLbQBYyc/ytmkl7NRNdc3uG3AXzKUO705SBW5gcXGpnLEp5e3L5m/1fx0Uumo1JhcdjK5XdfSZ1jb5Bk4j1cVFhvCv6Llt59ZSTARY4mdA/rM9H5yC6MUsJwsnQ2L6PWNrafUrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkVMQ9Cn; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkVMQ9Cn"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8f80e3f72so1852881e87.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790621951; cv=none;
        d=google.com; s=arc-20260327;
        b=f0r641Ir8VKEPW2yHfGxxw7psLfrFiHEcKqlUQ4LB4A83cQWd2OEaVUa4AWHiA2Kt+
         YedIPrGsgLfbKDPn98QtXoJpww3ryEaKJMLerV0IGcpmbzi4ECyKs3DZLqvlPpxFVlik
         pxkzK7wSK0aF3GzPK6DG73/RA0ntUdj5Og0W2asCaF/1eE/hEcNu7UzYAPQMxx1qSx81
         PW/3bQIu7TEe+JbOBE93FVgDAwu+H4rK9EfgCrW5czO85Y9RUduzjb4ivQ1KQFJkvPb+
         IxTwlqx7nihcWfxekCmuPuFqHO7Cp/L9xnJRW0FJ/xbDSP2aaNdP/0+bGWN5qEkWO/41
         0www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        fh=UrhO8iqon2ZSKygK/7guwXF2fGgpl67Npd15my0teo4=;
        b=FiQQq6LquXlRv6C52nP6i58DcS7H+leUd/aKyz7pA/zaykEFLuu1Iw6ZkxManJpVeO
         9ls5cfJwPb1KazC23COHaQwr8T/xfl7odthqTETRAZvIPBUtgUN/6BojEp4WG2A3JDyF
         CKZ5Sof4hoCY+mRqSfSrRmu4/Cu5IPRBOgfKXXZP0jlL2rFH90krxAs4PG7neeSzzmWu
         Tx3m4kSNmz6UuETwuO88B8uqhrB1EY39z0Rv1RXWqVNKqbuDC2Ezcls0VCvi7KZ5/u1h
         9wmfONRiM77B5a/9oKdcrIHBDg/EJN+1eLXgHw4Rbj8i8rthrYJ9OM46Mw3gTw7ZeDHI
         4uxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621951; x=1791226751; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=ZkVMQ9Cn4o+jeVoWjjCwmq9CPcWR7/mF9yEG7Ns8vm6qxN6Zxr+3S2CeeJ376BXJtz
         GVXAUUQC4m9e5XNrwD3kDMHErMmhNwdXdhjazklqN4PdGNuPuk5BjCf3IriVDoTMLJEx
         YedorAfXg4T0qn6IGn3W4qmJpR7e2meojy9B53opjP7/4gbT2zvFH0vZ4ovTuE5/0owt
         by/DTUHfyIoqxLiBI86H8+MjOqF2ySzbHzAQ4QmIBaPyzkHysb1yUPMCvKOpXOEWIdtP
         fWttTVU2sH5IF9JhWLDO1iSE6HlySw/mVz+kv66d15ZLkztjyHkh9Oo3fh9BKIXMlNCP
         oWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621951; x=1791226751;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JJn4UyQhX96Z2Uxh80LSoGTD5a8DL5VMxaJOGjyTlhs=;
        b=kGs/wU+aFEki0TO2IPHrwPxGkI2UTdqM01hUIa2r+EdZJ02ewbAsL+HjwN429zP9Lt
         v6Cc111inyY/dJqHYgHYpa9OHReazFOaOVE8OX7XJdAivW5XtX4ClKUhHoa6bC7GMETL
         qBKM42KIWxmwTgTPKHHil4vunR14GfGOfx/yE20RJhhGTW2PTtHT76A2nbl9K32R5JtE
         wI+csvTo5yj/p0Yrj358gmVnfymhCFi2+LG1GSp/s9zZPob88YE48iU6D7vyTtmJwA4v
         hOaBAU7dVUTwHbY5qsc/0umelHea5w4+0a/WazdgfKpWdZ/PMJlBUPHCl1x6caBiZyH3
         FZ3g==
X-Forwarded-Encrypted: i=1; AKwUvBw7F9IKdSsoh7ncMfwdvI9CREPPMxLqxBxevOAT2z9dkfUVBlCbOy4bDmpFGmhNjKTaiCyucNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCq/rn3sk0u12DKstSvabny37sCAwpYhWNwmLCG1hTEbRKVaPP
	lbCuiUoBnXqng1VCC9/uLShJJ8EnJewZn1N9SvuPR3MzVX56zIP2pA1KoxdU1uuF1t7fVlweWGQ
	QeLUa3BdIty2gF9yJB+2OVChmJGAWZqs=
X-Gm-Gg: AYBFou11qdxsmvONfdXtPU0IAyKZ/ZuaZLOObNrI1oLDGvBN3h8c0q6WieHHUAdY2cF
	+QsMXZdmaMUucW/w0Sm+AkIwE+Xif76m/9RVQj3YCducWM+EPCwhY8djN8igO0R2cm0eBiH6gTm
	BAo+mJcP/6Krxr1Zqumhy2g13nRfBYhACTaF+Q9AWQ5EqZGOJYMUYyb/mePL3DmIqv9f7chBHj8
	dVbC+dznOJ8DWJtN2xJA90hDHLUlu5wNsuoTcKLUTiswOVrUtwu41OhEjC5rqkPUHlMME+Gt0oL
	dbAScpuDnbuc/mwtWFZA/K9iXrB1HMnsOIdoHUf5LdBLzXs9+yzXKR/2iR6m2Xh7V9qgjCKIgTT
	owwLZol4Yfpkz
X-Received: by 2002:a05:6512:a87:b0:5ae:bd5e:95f7 with SMTP id
 2adb3069b0e04-5b8df0d42dfmr4907670e87.4.1790621950890; Mon, 28 Sep 2026
 11:59:10 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 11:59:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Mon, 28 Sep 2026 11:59:09 -0700
X-Google-Sender-Auth: bfjEdBcSXwRUi8bLWiPkOvkvDYo
X-Gm-Features: AclHuK8baSSkZv-tT7IrQBt-8uVkNNdEXmB5RveGyZwqKIXYr-qkBIj5G0AoAGo
Message-ID: <CAANnmVAicVNhy8fMUaFJ_N+b4DnbwpYi1MOL4yMVisix1WCX4w@mail.gmail.com>
Subject: [PATCH] net: ncsi: clamp filter table counts in GP response handling
To: netdev@vger.kernel.org, sam@mendozajonas.com
Cc: fercerpav@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	gwshan@linux.vnet.ibm.com, joel@jms.id.au, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ncsi_rsp_handler_gp() iterates over the MAC address and VLAN filter
tables using the counts from the Get Parameters response itself,
rsp->mac_cnt and rsp->vlan_cnt.  The arrays it writes into, however,
were allocated by the Get Controller Capabilities handler from the
independent rsp->uc_cnt, rsp->mc_cnt, rsp->mixed_cnt and rsp->vlan_cnt
fields.

A malicious or buggy NCSI device can therefore report contradictory
counts in the two responses - for example a GC response advertising
a single unicast address filter followed by a GP response with
mac_cnt = 255.  The GP handler then memcpy()s 255 MAC addresses into
the 6-byte kzalloc()ed buffer, a heap out-of-bounds write of roughly
1.5KB of device-controlled data, and the same applies to vlan_cnt
versus the vids[] array.

The loop indices are additionally used as bit numbers for
set_bit()/clear_bit() on the u64 filter bitmaps, so any count larger
than 64 writes out-of-bounds bits into struct ncsi_channel.

Clamp both loops to the number of entries actually allocated for the
channel and to the capacity of the bitmap word, mirroring the
validation the SVF and SMA handlers already apply to their indices.

Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..fa1ed405dfbb 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -883,7 +883,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
-	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
+	for (i = 0; i < rsp->mac_cnt &&
+	     i < ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed &&
+	     i < sizeof(ncmf->bitmap) * 8; i++, pdata += 6) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
@@ -898,7 +900,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
-	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
+	for (i = 0; i < rsp->vlan_cnt && i < ncvf->n_vids &&
+	     i < sizeof(ncvf->bitmap) * 8; i++, pdata += 2) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
-- 
2.47.3
