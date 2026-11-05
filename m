Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866727;
	b=nvx0SttWE9K0is9hcaX3KT9TIZdkowbEMjrrkTCqA/jUQv73K4MWEyXz7pNFq/1VAbcz
	 OVjGpo4k2kPOBObtnIJbi5Ral89mY7jABFjnFeFQR7o20wNn8qdqS7hVCdLUv1SunDQSN
	 7JTfqcr7T/O2lLvYj1LzoQDLUQGsiaOqG/lsVye59FAwpUDSybpvk7JfOEgHV3FsRvubQ
	 7DGmEp6CL69km/3lE8XMXbs6wDA1JlEnnYvh6VbUVxjl/nABACBCIk3Ugson7+jIEFHO7
	 lXBUav37Yhw7Yov9+YklXEMbK2m6VDHAAue5BSbI9b+L5lqIh85Y7z03Twnd8GjrWAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866727;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
	b=3j7XPDLg+ajvhHC6pQpjJ5gwTqnhOYNTVb2V4oU1G9hvT4fMaZbEosBvjSmhKwGJB2EL
	 pIgcS4eexlq44xHoxBzr0koxzk5QQgU5Knp73uC3/39YS07eZJTtHdC5VFbJU700LS7CL
	 kP94hiPKiMn8I83AMd30at2IMztW2u4gxeOnN9Sv1SJIdEF5BBfeb8JOJE5ksSKDAsxsZ
	 tbwE9/0jxhlmzzUPoGfeHhQ3GAXYcfuex4YK0TGs01aBbOUDB7+34BTIdr695LMv/zE8C
	 eQAtnej9t6X1JyZcUv1DvG0j8BoS4vuFTPd6jWkbayiRr4i2U3eBeUIWNN1tXwXWcMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aaId2nGu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SYUskHBm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51451606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51451606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aaId2nGu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SYUskHBm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
	b=aaId2nGuZNWHy19uozoi1sVXPidBs/wvHXdFkz7JmBwWqcbbETsGZbJssVrhO3t6MclTDb
	+VIwdAxt9u+pcFJcu4zY5KpvJcafzkAtAUuM41mV5nMXpCfO4DVzrZfB4RUPK2hA9US+v0
	C40UdIYTwLXWasnYl4Txocsxeu676Zc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-VfGieyyoNV61HGsHr3WbGQ-1; Thu, 05 Nov 2026 03:18:44 -0500
X-MC-Unique: VfGieyyoNV61HGsHr3WbGQ-1
X-Mimecast-MFC-AGG-ID: VfGieyyoNV61HGsHr3WbGQ_1793866724
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1bd21fb0fso2223005e9.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866723; x=1794471523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
        b=SYUskHBmHv4HPJ3e7/EjHVtvUky6CkIXCmBBYafb0vpInznW8c989ZMnvku8KZ2ICi
         bYiCoWey09yTBybuH1NUnJA2toBVxZux5PigkQ04VFJJFBQDNeCOKwvGNB8bItfp/ZmG
         lzhmSQwEA1mebYZ8PRMBewnz8v34rWWyurQICSSCmHGayDnfuTo7tXGq698gzWVGjb84
         /V4lmODNkVzg2F6dxwEZafmCDYA835mQ41PbpfcmDymA6914LZCF3OQQX1MfFA9Ah5wr
         4LPqF/aVgYII5d/RcAemhoWtgJGwQzRDcAbL2LgTlbwZTb7icxCGZdSlRFriFsYcHHuf
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866723; x=1794471523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMMaHhKFGPel4o9R+b5ZeHtuJGRm5DfNPq77qvI5+Fk=;
        b=KpaD7fd85uDqBlT6i4FBct6kl1eop802KDn/irGOc77jK0Mtdvd0MJ01f6m1E7U216
         j9+MYXeaRXmWqGSWK5+ltfCZ2kSKiUfpWP92czL7xdAK1aPDZSOFqcyfrvZYGToVTxMu
         FF1s00DjYNzs49ipfR+pX4Ce0LqY9vgs7N3TmKwFLMyUoBP15cOepNIsavOAfV6oGq6Q
         Vuus7iPo8FyUfwNnvU7UjnBlp9GxbBZSfJT07sksmBMOzdFY1aGXNJoWwmI8vfVnIXuQ
         04wSRgUeJy7fzrtd2FmJEUf8VFsMw1LYiVpsPP3Xz3j9DNcsx33PUhx7esIPoPPVH26e
         RnDg==
X-Forwarded-Encrypted: i=1; AKwUvByu1vPiKD3HMJzztuc9k6xDtPdYd0jY6qz5syJ+WvKCYH9AFcXuLxo407XwkTrkqfUUPmpDAbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PjQ4zE/N+YsIKZ1lEQsTwBwWOiEHOZRES+bOLyyeaInQHTTS3
	TuOrhpuAt622AyVvc4F1goThD6gE777TwF73MzIrmobzzFH8oI/njHplnwq4sKCtNZl3+Ck5Wio
	ARqAuAmj/Y2TgTY3W1v8quVBFxKGQQcBvPaKNR7vW7vT2EoiA9dF7IchANQ==
X-Gm-Gg: AYBFou3wT2mxir5knM6tCukHkrfABd8zEahnfVaaZ9MwahLwyQNYuliUBGYOz4QRy5m
	8iLw+xQER9Np5l3ZqoVmhNcMCoNdbyqJOcVOCDkBhVuEeMK12Wf9U/BaeGt5Ymc/0caT4cCBu9G
	29jQ13pqCYnNX/qhUTiZBxizKknTSvEqw7uxEKisqgzv32MiB1XJoRp22AwiGy6Qt2EctqNH6yP
	Pt6enbNbFFzEv0c1coJZhYrhajiUm7JLZi+N/1KdQSgofilR+B0a3dzdziZ+CCbYAVAcUoZa538
	2mff+hiARjeslWwVUw5PKyU15aYzngW2/ZDtMSgxscwO9Ri75ivCETjeDbaf7BHpDILcTfl4k+t
	pJscowGxl8n8B5aMIw6H1LcopfOwq1flDDaubZtnJXk7K5bH46kE2QMJUyu6Y0TztAYYPz6uoIx
	cL703AAyBpZ3nLRw==
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr306356115e9.1.1793866723539;
        Thu, 05 Nov 2026 00:18:43 -0800 (PST)
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr306355815e9.1.1793866723106;
        Thu, 05 Nov 2026 00:18:43 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b63863d490sm4513405e9.2.2026.11.05.00.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:42 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 05 Nov 2026 09:18:32 +0100
Subject: [PATCH v3 1/3] clocksource/drivers/nxp-stm: Fix max_delta overflow
 on 64-bit platforms
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
Message-Id: <20261105-nxp-stm-fixes-v3-1-8129b912e74b@redhat.com>
References: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
In-Reply-To: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=1276;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=3tQAzS65C+p+CwI89Nw27cv/4Q7pCmNGpT6liQLCnCM=;
 b=jaRNvqRfj8/W4VNEnG8r/OzoSDqnNebhjk7Le5MPZPZ/1fZnzaB0e9g3Nb/3xrmRC6O+hw35m
 fCu2NAhD8LSCYKJ4rEV4PM5QL7RRiLqTSmrebz0QAFyprAwC68ZJ6nd
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

The NXP STM timer has a 32-bit counter and 32-bit compare registers.
Using ULONG_MAX as the max_delta parameter for
clockevents_config_and_register() is incorrect on 64-bit platforms where
unsigned long is 64 bits, as this exceeds the hardware's capability.

Cap the max_delta to 0x7FFFFFFFU to match the 32-bit compare channel
width, avoiding potential timer event misses or unexpected delays caused
by programming an unreachable compare value.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..ee249fed1b91 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -346,7 +346,7 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	 * minimum ticks = (rate / MICRO) * 2
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, ULONG_MAX);
+					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

