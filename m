Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826393;
	b=u79zdv/7jbZEbxgWS3KPYYc7FqDv9zfmHdnOi2MkF+D74ce2yu9cvpX1V4ZfsEvkIDTB
	 dMuMBkRxAFe6J7eusrv4xTVl2cSx7JQasv7fBvv5LSZRcK5htPDAe8bil7ivVarCybZ/U
	 ib9EFg+V3BhppMmFJxY/xwcBBk2mWGdE5rclEN26h8GrzmjcL8JaVvq6SmgRcYa4o7yjx
	 3gtCZpojqLYQYXD5y2fgWRp4uMkFtnhEYAhv4e5vj0H3U1rf9HhNY464AMjLnKFhp71Fn
	 IMtjasnHN9YE3JUIrjKCHNx/0I2eYX2FRAIDGovmkXl0mf3OFVgSlotLKkceGj2VFPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
	b=ET1gdTzexeLJ9vsGr1nzX3F5vRA0noS2Db6lBgVLSfiEdO7zQ+TdgnZ/Ykl20glbj02v
	 aH6xHWXARMdNhJ5/F6mtA749GokYQW9GVvNmgaloYVzM6oEq9fSxomb0fuGiA/5gOoAsf
	 NFw+Lra/g8/UN4rK8DRHqbPLJv6zz/2TcS7WpXNVv6Fghp5yED2v9HkqaBP/MGDZ88uSL
	 gDoGM33ANYCoQp6tlkvJuWLyooT5tBnz8uNB3G5cVEdff84SV7BcTaZHmo9vbIEqWyOT7
	 A54DD1v+Fdc2zJoFebRpIvJtOa1SFqJll7wsjjzvaQ6l4xL+oDvxIe5dDeJ9e5nzQAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMUofNYN;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5060A2621
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC5060A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMUofNYN
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-862b9c2e78aso616113a34.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826392; x=1795431192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
        b=fMUofNYN7W1CyGO7ZvAF2FWAa2qYJcu4r4eowj57uVHPp3ByNFlMHPfRkGCA4jU7FN
         O8hbQpzvjUUjro5m8khTqFBV7CSBaumnQz8MsGatmHSRCKKF4NBjtYbD0wIRF/d+EqgD
         XcbcKNluWfhEIjUa81KzsXUH/YE6dCclSHOrbf80Kz/p1DTl+RDjYboCmkbZ61Uvpkjz
         jQhN7nNrRFcYTMTRRiIYOSp55YG80l0Vn+HVQkP0KLb94CjlgMxkAaawwH6TOpIA2QQH
         slKH4k3tzGsiYbMloOdqaa+9deaXiPf3fQp4ettzDL4c7sNL5HaK/ngKNDMTCc9HW4kk
         nXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826392; x=1795431192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
        b=jjCODA2pzKJRlG+pTgXeaUdICX8g5wlQAj3aP49eB+DPV/tohpKnVDkTJDBQzd8KPb
         LKttyFDhS15VbFlVQjRJLlM5qkwP7gdbRQ1+CunCozu3ivyr8/bOoGrLDW4krti8yBCw
         sBHtj9x5AAzVgIvvrFByP2Hl5g0W3ltCV9it7UnyN6uYeJgmwvhZickW4R0B03psBj68
         4nn5VmLPdC/6Eztv7s6YqZLsaHbsC0073FQ2k3vNCaApSXc6jKgN+clsmlKEhPGDiBCG
         FMlu3iAgoUoHUXabz6+ZsoBfZx5ki61TxVTb2vnmih81JmNzbvuVQRNbE8sp1bEnqRup
         IReQ==
X-Forwarded-Encrypted: i=1; AL+hErEKJfxfdFUDVpM/oD6sr2F/FIo7czl6QTtcMvXOhHX+I6dTlVV24RjKXV2XVoBDLp5hvjtYoEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wTwRcavKWnD56zh8ZMWmZtx9WER/SWXogySnNhKTR3pN0p5K7
	LMCcrinCy5YVc1eQJG8BCfxnNKg5i86T3NqjWiYa6UwgvRmxQ8vEYbW4
X-Gm-Gg: AYBFou2yNE6mMDhbjip/2mXmeHz5e1Nb0Mbiu6eEn3uETeTAb/MjGvgZ/i2akJb+meu
	aHKZxF72cjn5VWSqIfkzM+hZ6YwAZVNGX1sdfgBJQfM0cMrBef1mXYD3rcv5CfwXzV33nmvrFmx
	SsdIN+ZD++YBhG0L9ONTaMPrLZAZfatMv84bfy2F3XrS5R4R3HR4a6Js09AeELAskOVvsaJmCJd
	R04UhQNq3MKVm2IoVhWJqP6YMYWZMVHmfXG17zulR9dWhUjA2GM6TsZaBdyYpvGU+jWxtD/yZlZ
	ch3IT71+GTRUceoxRkyfWpJRIyazBHcOe4/jpuLwSHLgIoYFy+XDLWekTJ5sv1/vrOfkiFbj62N
	u6jDtuLi+V8Bclvq44wk1vyWEHoId65wz2W5VVLX/rHMaIfpMeIsa8o00eUF2ZAuNHIPsK6aEL0
	DYwd0Nu21HD9e7o66eFTlOgHUceGMnOnG+evXtlFsBlTqVLXaBWEV1pw7KIRVGjPYUw0Vhf5VDZ
	2fqxp3QHtYBur4u0OSFl1DJHG1B0yfOBqU+lm4a0qTSG5Wm0kV4iLAAUBd776wgVo3n7urOJNkC
	xAjbI8sv9Vp5w2bB0HJzCainC8wcJtoKZ9zCnaXEE1kn0Jk5Ow4w7zQKCMlAjaUp+A8EKMqUOv+
	kaANK6HuvZkGKlZ7qpAT0Ls9QkBgvnDfPrG8RQDS+sWlASfPrefZ45N2dwcjE95tPNsaiHG/4Y4
	7hmkG1a1fLhBgJDNfuwT5kxXX8vlTduSbdb7QamIEIImjljbSiSXc=
X-Received: by 2002:a05:6830:854b:10b0:862:b9dc:183b with SMTP id 46e09a7af769-862b9dc1e62mr2195212a34.27.1794826391709;
        Mon, 16 Nov 2026 02:53:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:34 -0700
Subject: [PATCH v8 6/6] dmaengine: dw: report residue for queued transfers
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-6-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 565d01c9a29a..5a7be765a0c5 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -867,9 +867,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

