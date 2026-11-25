Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598436;
	b=s04raXp/4OKRLc7UdM3hQzacGrVvs0UdranGk3UOr/KQ4d2CoOl8w7OLRuYLONnWU5sY
	 D39aWA7s7WLiV/6Qh+4J0ObT6+8GWJUFHLz302WGZXCT9cV+lvZUlU/zkaG9gcJlVWYrB
	 O2GQhpc2XuKiaMCFixVEm/evfr1iqK9Hd4OARzh44V2yHUglChKrW8/klN3yZn3Yu1TFF
	 grDTdU3WNjU9Ri/fxzCjKzQMLjbCxK3bmGLnHYxGo2nH2jN0A2QifDRnaFciS+EixVM48
	 eypfsOK2ujLXtDExeIiGWrG6AfYB7We2XI4l1PSRG7TplTJIVUxXChH4GD/hxn70HCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598436;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iMaWcrtMHiGOzwYE2hAYk1HTEq1eOwZhbrsN12QXlG0=;
	b=couLSv3qmjW1j2ylvEOk4x7O54jgJZv2AVA3H/lzU9Vw8WLszjZZQejX04aBMRwduhl3
	 osGS+8FJUwHPAVsNlxCfUjppZSVXZ1KJOK7HKm61HdV7BkrrUMPAYEWo8EKIYYlyS1nBI
	 bfTkXR+LjpVYQ3PWkq8/ZR0TX9AtOnHtM1K8Kn0BmZgFD9P26MZ+9oMzuqesayXqYO3m3
	 f/Yu6q0U6FyZlmxAlbx3NsBoj+x+1aimxo+GSmpeKhYXZHG+/l4aAHVL9s/FVmLBhhFxN
	 9L2L0VRGFw7RXanUXMJ8BtwCqL8G31xMOZojerLWwhcNU5KZiSK5zCDoS0JZQAVwtww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bmdEoiNU;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC606A693
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AAC606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bmdEoiNU
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9FB93F784
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795598433;
	bh=iMaWcrtMHiGOzwYE2hAYk1HTEq1eOwZhbrsN12QXlG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=bmdEoiNU62TyikbyheoVTn4mP3H5hKQsAtmVNWl/2pOWlq5Kb+wKhlzXqZhx/pgcK
	 yEBk1wbhDvSQsGlpIOyNhjWiNjinE+sssHHNyTVocdywG0i9uyRyzdQOWs54NN5P67
	 HLQ/fdHDhegVPDSFOlrz+q2nJQQSS5ajVyvniMGEJ8J3Lab5yDPuckjqfQcYUEUbz4
	 ht6kv0k6u5gCG8eaII31E6FAfx40zjW6L4Mu5amfcac7Bp2eNBc+Zo+2q5oiGj5Y15
	 /l6A6fDkxQ8OkX4rs1vLhBHpVt615exyJxKfDw9TaVMV6WDDbAoIdF8wdZsONVjRcT
	 MI/07DgjMCeYS16qOfLxpm8xTTQ1j5BomDT7RmYy6kOTvVU0ziudRFysSlXSOnYASc
	 snxdKcRlWrOldIPg4cDsg1ey3GEzeab/5JoJYnwpET30HHQPwIERP5/gFSFBYMLdpE
	 69cZTYjzjQWQ1+DoSgA9N4Ii37zMHSFM0XE+YPghXK7DRSxD2Q+SJ+M1LjEjUVzZWH
	 /w1IXQFTffNHZONilHfuNEcL4Rvkv8k3u5RXmZex+aJ49o9YkFVnmkmmaRsqmvElHt
	 kqAgJwscr188idfB69pSmi94KZ55AFW3mUO9twNW6IDmRi8EZSJvqI40j2k/EYgNcc
	 g3h4Sl0mtZC+/79IkmnDqyx8=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f03a137f6aso48880105ad.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598432; x=1796203232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMaWcrtMHiGOzwYE2hAYk1HTEq1eOwZhbrsN12QXlG0=;
        b=kTG7gob+q+l1VJTq/rruTwMC7pPiIa5Eb8ymcogNuucmsQiw6cywYp76+9mXHai4w2
         tr70vqKxRjf4DF/cb5g+6LwYik6zvG1lBDKubfqO8GKRtcOnj/bzk8nteSXtaorHkMot
         hRYLVp/N07aAKsV/TyG3KLpRfg44ViRhVLIH7YWkZrrmvTAtvUoLP9Kepo4JFMdLuwtb
         KAhklW9QpTcaFP4rFbPHSh5CpDb0SfnAWHZfP/9kAwY0I23OvqXXxicvXWxd46tjG9XT
         JV4eOoKDHhOi8hb81d/eAa0a42WdGS8NJdZ3OAyarN8WzdCTcI5yM5h3JW9MFnyE7421
         LPBQ==
X-Forwarded-Encrypted: i=1; AL+hErF7q8I0QE5PpTuGt1Pc7lbBkNxhdEh1ZG9+UwOL7eea6OOBFNCVl5llTjY0zVPC0WvJHUru6S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jnf12xSNfoUQxh9eL/MnMziSwBpfNkFWfRTKZYE6uduy2QclP
	8vZ02njO38xmKXG+Pv5ZJ8+ZCugeWdfiryiUNGJpFgpfFSG4mA40SPbUIxP5eeh+ugxpnPA1Xj3
	naYghG8Tts9w4bI/u2fqtSLmkul7aE6giUVx4L4qYHkIYU7lzpO1Lf601gB0qA8t4XdecGw/Zww
	==
X-Gm-Gg: AZFdTZcW4J6yBFjGZUf3zfA3a6Qvs4kc53LYqRgEJn2Vzi4D9lF3MgBoHjLeeZ+96fM
	Wyz5ltAH5QjmKV+eBdTGOU65tEyb4A9j0UI4GFYszfyNHBkq1H7rx1qV9grg3OPx9PmiefxW43n
	eJc0q6eG/ouTMH6aLWvN7SRupdtRSH+sftCGznCDQAloF6tc99YH0hTyoFH4g81ILqonpYkvVz/
	daNu0Bzi/1J53yhjArbv7sD8SZwxXENGC+Q/xqBAUj3o4fqCMZ9mamJjZVlWXBsnDcBjKVy2E2l
	kSzUKCflft2yUJ9hmekX69GupIS+S49P685i036y9nYWR/XDsz7H7XNh0TEbY8rUYiD5rHPm6DG
	JC3uWzn71VktpUXfUa6FZzXp49YgCldsQ8IWDGgJkRpuqExZtjpxIBv7nSlcJapmIZpipL0Q4UD
	6y/2LSCQKsrgNFcDpwMrvZenFuC2RbDQ==
X-Received: by 2002:a17:902:cec5:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2f03f1bece2mr190850695ad.53.1795598432247;
        Wed, 25 Nov 2026 01:20:32 -0800 (PST)
X-Received: by 2002:a17:902:cec5:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2f03f1bece2mr190850545ad.53.1795598431880;
        Wed, 25 Nov 2026 01:20:31 -0800 (PST)
Received: from resolute-linux.lxd (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f099a4d875sm42673685ad.37.2026.11.25.01.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:20:30 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-usb@vger.kernel.org,
	Aristo Chen <aristo.chen@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: gadget: udc: do not fail bind when the UDC has no pullup callback
Date: Wed, 25 Nov 2026 09:05:30 +0000
Message-ID: <20261125092004.15562-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125092004.15562-1-aristo.chen@canonical.com>
References: <20261125092004.15562-1-aristo.chen@canonical.com>
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

Commit 0ea39e030a80 ("usb: gadget: udc: Handle gadget_connect failure
during bind operation") made gadget_bind_driver() fail when
usb_udc_connect_control_locked() returns an error. Before that commit
the return value was ignored.

usb_gadget_connect_locked() and usb_gadget_disconnect_locked() return
-EOPNOTSUPP when the UDC driver has no pullup callback. So since that
commit, no gadget driver can bind to such a UDC. max3420_udc,
fotg210-udc, fsl_qe_udc, goku_udc and snps_udc_core have no pullup
callback.

The core cannot control the pullup of such a UDC, so there is nothing
for it to do in this step. Skip the step during bind when there is no
pullup callback. If the step runs and returns an error, the bind still
fails, which is what the commit above wanted.

I do not have hardware for any of these drivers. I found the problem
with a KUnit test under User Mode Linux that emulates a MAX3420 on a
fake SPI controller. There the bind failed with -EOPNOTSUPP:

  udc spi0.0: failed to start max3420-kunit: -95

With this patch the bind works and the emulated controller answers
SETUP packets. I did not test on hardware or with the other drivers.

This patch and the test were written with an AI coding assistant.

Fixes: 0ea39e030a80 ("usb: gadget: udc: Handle gadget_connect failure during bind operation")
Cc: stable@vger.kernel.org
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/usb/gadget/udc/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 577bc15f61a1..aa6226666eb5 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1680,9 +1680,12 @@ static int gadget_bind_driver(struct device *dev)
 	}
 	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
-	ret = usb_udc_connect_control_locked(udc);
-	if (ret)
-		goto err_connect_control;
+	/* Without a pullup callback the core cannot control the pullup */
+	if (gadget->ops->pullup) {
+		ret = usb_udc_connect_control_locked(udc);
+		if (ret)
+			goto err_connect_control;
+	}
 
 	mutex_unlock(&udc->connect_lock);
 
-- 
2.53.0

