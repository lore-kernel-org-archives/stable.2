Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370383;
	b=UTngwR8+NZHLY2wYuUPFaL5yEWwAUDLzAcAzlSU3HUq4yhQSmfm8ocR6FL+bMcmEQfPS
	 teJmGPi8BZWOSM3o1B5+z17+OOaYLdJEqPzi8V4AR2+nVsUP8pS6SeFi2VqMW/zXOeTTE
	 NOd+mZu0MRuOm2xbiJRbsL4cDGrQCPDxoUdxwnEWmCpotOQq7T5Ddp5ylxICbJ+w+ZJ/c
	 xWYbAujx2dnhwjIjQtisPlK6DgTkQTX3cduahqszaRc9PHklHXj5y6uKg3NGGVuX1pHgS
	 oON3Ic4owhioH9AWnLJ7WGt0rF3HglDV+W7JUDoWU2oe6al4pZgo4MJqkWENtBFgwIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ff4jSj/cKfylzuF7GrEwDeEsXTeM/Jo8CpbIJyNJYCo=;
	b=HRXBPUTC57RIS7LWz1ZkHMkp2pN1o7ZAHrsE23DrZtcRPaef6AYL8eF4rMkYyMc0Rp5d
	 AvMyMh5l5Cg8np6+/tyHy9PIWyL4f9PPJYAgUXp5Qo+H5xQGOPG+JCzpD/umZD5I9J9iY
	 +bEd8kGxDgHwJ/e5Xls6qGqSfu8EahadmEMBxv5Uih+bzNesfJI0eW5tOFqetkFuxqTx7
	 oTkIBK+q4EhD58MyhWbPoG+oRUJlFhOBNMqsU4C9LGS/71VRzPbFVd/kt+8pUPbVYfoJK
	 U43Dy/seT3YN5BBVkx7KkEbBRAqjoF4igcmiIsmv6aieitTakTWbvfSStja3agM06kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aeiniqvk;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD06606A33B
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD06606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aeiniqvk
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2494467f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370381; x=1795975181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ff4jSj/cKfylzuF7GrEwDeEsXTeM/Jo8CpbIJyNJYCo=;
        b=AeiniqvkKWpAB1kr0/DQMkGYNw3mSNQTHLJN7Nmmnw22EpV8DjXlHk78Ro+gc6X+7y
         bEyu5oIdU7dUS+fES7gIzEEN6ZJZF6JBRg56z38NNpose9TpXxQdI7chH2eFpd6diarg
         QiKGWPzCTn9db8KVTamosYxJbANj6u5w1st0I2V07KAHZrabhXrGFidbJKqQmp6tiwuM
         4TdSeD2pwGkDRvD4D5n1g5zJ0c4jwTj1TbWDExzlsu3FERwRdmm9BRNpdodH1OSO2+7h
         P/Cns9UV69qvUotDqPTlooPiDGppd312bOvhOiy6VqbPjogz+/01Vpi5QZHE5jZyUuc7
         nwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370381; x=1795975181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ff4jSj/cKfylzuF7GrEwDeEsXTeM/Jo8CpbIJyNJYCo=;
        b=OdWUg3Hdg340Q1N12JVWbWDYBXGaKCXDvadfYGwyVDIk+kHB+eji96AAyKHqMPvN9D
         GrhLsVby6lraXu1FG5dWv6SgeM0jBowokuVXyXk3ndhMPuvpUJ39n7dCcGJRgcKeC6Pa
         VU60CpCNGy/6+DirzIXyj4oycQVOkAN9rSz/whFEaPCociXc7RcngPtpevi0zWGNl6wv
         rX3wNgxWY+N7B2qiHuDqB1tpLyMn3R7gHpW/01njiBrqxmCjVGXzgrFaD+IxMtB5OzZ9
         7jCZz7QPbsGkC29dPkhR1TTt8lxjU7R3G+/dsGDHc9SmZY7Xx0S9PGhqypT6X6nCxTSj
         sDBw==
X-Forwarded-Encrypted: i=1; AL+hErHmhsQRM+mNRTVhn/r6a6kkqUrgFWkmmS2IjllQ69h6N/SVpuoaSUkjgSJy16JFtUnNlK3WLfo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p+8wC2CEVrRZ0xIl29QdS7ca7ptPUMNSD26+S66ChucaEdiPs
	CpXQFEbTHQvkOzQlNOtK+j9WeqqVZPV/X5brJzUEo2SdUpL4mLQJGqDw
X-Gm-Gg: AZFdTZddqDi6eSwti6krDpRltjB8syFZAMyadEIz3EXIk8hh9ByJ2PgRgP67m6IZ8/1
	toeRpOecsI1EIWYZXU9k96MbIhEje4GSbbSaA8QJRm+gFB57wQRMJ5QxsqxNdXqvUhY03uZYUPz
	WCACVbQNFJop465wzSCFv6hSlVbpv016crGVnlx1GbtT7mtbcFWaGmPmA7I5dswHUH/bGclHsyr
	VXiGQKTEEZeJSa6H5i2QhhRioTqHfAjhxqZ9/n8PUuh3DgoKg6rqOmSJVsAn4sQNu9np36hZsmc
	6lIbH+bAwkNGZOWbCYUErPgluFvV5QMkJVaKaHvcj7uvKJi9Wad9712jcFaetUgjQrZC747krlh
	LDoLq4QlYSfEtR7HJBMtJKyN2tWLiz1/pA8ZTBmoMvEZLnYGzwgPWAdeSo3bNeyE5LhAMfIdCy5
	uLTaKaEj5KUt5inPupkUvfqslrkybgewSCqnMU2tPSoUMDY1OFv5WZLY9mPvIubEKeTEqpDrWu/
	pCz3DHrQVSU9zrmn9ru3Sz8DsL/thh49GhycAkKNkPX+aPGf2Nyf+fGta99fFll92ahqkA2mrin
	zLa//T2U5XWgzXKiaUcF4R6o6+UVUvi+sBIp08w+jEPrFRHVGyJCSoX2TpM7KDrvGjqlWAOC6BG
	dQw==
X-Received: by 2002:a05:6000:26ca:b0:492:3176:3d64 with SMTP id ffacd0b85a97d-4abad5ac748mr18217584f8f.8.1795370381218;
        Sun, 22 Nov 2026 09:59:41 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm17464646f8f.32.2026.11.22.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:59:40 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shichao Lai <shichaorai@gmail.com>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: alauda: track media_initialized per port
Date: Sun, 22 Nov 2026 22:58:05 +0500
Message-ID: <20261122175805.2955-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac19e630-f96a-4144-88dc-e3f22091c7bb@rowland.harvard.edu>
References: <ac19e630-f96a-4144-88dc-e3f22091c7bb@rowland.harvard.edu>
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

On Sun, Nov 22, 2026 at 09:53:25AM -0500, Alan Stern wrote:
> I asked because when syzbot tests a patch successfully, it provides a
> Tested-by: tag and asks to have the tag included in the final patch
> submission -- but you didn't do this.  Did you run the reproducer
> locally, without using the bot?

Yes, I ran the syzbot C reproducer locally in QEMU without using syzbot.
I also just tried sending "#syz test" to syzbot, and it replied that
patch testing via "#syz test" is currently disabled:

  Patch testing via #syz test is temporarily disabled.
  See https://github.com/google/syzkaller/issues/8122 for details.

Also, while checking lore.kernel.org, I noticed that syzbot previously
posted a similar AI-generated patch from Aleksandr Nogikh on 2026-08-28
that never received a reply. Please let me know if you prefer taking
that earlier patch instead, or if this submission looks good to you.

Regards,
Arbab
