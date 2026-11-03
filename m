Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719647;
	b=x0SzrWrRPnrWZ9XkQ2yL7SAbZuw8bcodCHZ4RJOVuReYKCXgPwLYpK1HlgwAv4+CvSbh
	 o9DS57pmaAEknSouNM5+Z34Qh9ltr1jLexatxiIWiILVdJZn2Dd/Kl07TERngnD6RMBsL
	 8SfodoOHxsABeycgsBpfins2LFaJ7eaMJJbrygqHNzYpO6oiBvwg/Xx/c+ox5LD6O/OVC
	 DFMR1JjwhzHl50WKezMWItzNKbee/rgllPIVg+2lyiI6Dureel/2Lvgl12O5SVvZBjwA5
	 bx4Wz7V1JOHiAzq4KCz1vFq0vmYi8E4zzzlahvHfUO8bwxrwddetBiHgAHxPmounubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TefUIXXlEMj5cJFFQ7uazOLXteD1gLPFTJrdl5Us/To=;
	b=BLBzxFuOMSctEYk9u/gF69qK3Y3oGmMVM/d70GrZ3fB6Y77pL8+/N3x/qLYJ+1r9AL8i
	 uwwFDknHdCxUPu7Vm4Sw7xQ+iAh/3nc7sFG1nOrj8aTDVvAK3OYatBq9sm5nDnRxaSs6/
	 OAhcvsjEjrPSvO5xzH6lmUHQJN9c1fPigdowuo4Lar2Or8qnxooFKzlJ0KsN3xcnVkQWU
	 fx6PJ79w7/shEBBJHi78i/0VPEqvyEAsjUP+6F0y2JMaCM79w1CIE2T6Oi6nHAEexzc3i
	 b0TjH2Lq6T8dZDDEn4P/soYrdEaUm9YRS5nRF13fhOdbYKm/kp+figkuZKTGt6gBrqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+6z3ZBL;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AC606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A02AC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+6z3ZBL
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso17852155e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793719645; x=1794324445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TefUIXXlEMj5cJFFQ7uazOLXteD1gLPFTJrdl5Us/To=;
        b=V+6z3ZBLKk82QKKtTa6ihXRrYIm3LM3PrY0Za1A4R4W1/EcMtKYB1U1s3+59MrOxYc
         uRplbE9bqrWlFz4UhTKmuTXApu3+8rtVrywH0mjD8otCSaT34BkUI8a6TGEDmhClGf92
         SWj4d41oojfr3oPKLa59ylMfiZmEIv+S6SL4T8drMDhZgaAl65vqCRS5rHcO0qzysTnG
         xeL9KHuZhnm/APUS+g6hFVN4rICM++ouQpbuwhzoIQ8enoL3xfpq917r5938aIW7SCxK
         SfMvPygU90r2MqszREvjU6JF9UPVS1zPY76BqPxWOfeqfttuj0zXB+sNICY1HoFqpuSe
         0NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719645; x=1794324445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TefUIXXlEMj5cJFFQ7uazOLXteD1gLPFTJrdl5Us/To=;
        b=w3MARd8SoI9fzAhVcU+K6gH8p8yMZ2FNVD2SqlLqe5MJhLZ6zshS7mmRdh0iuqXFvr
         uTWgithUNsO1brxTNIPYeLDotMnnaG1L6ZbtvGRQ9FddVAvfL2Fr/qKBrVABD6HwcC2l
         DH5fC2Ox+RMyhEVnaBpz5GNpdkc6kASKlbIxXVktaMVLuR2mfOSUPHWr3EjNlIJis+y6
         RNELiJ4TP7nB8bfbviecgc4Hw7yCkq4qvNeZEVd7l3bZiPpRc7WPa3m5od3AzegN5ssO
         YEUrMMLHHm52LkvxuFkvZpBe6HqBS/LNdul1A8r0Fpxq1clSJ7+TrWikZkXpHqdBPVBA
         qXIg==
X-Forwarded-Encrypted: i=1; AKwUvBzJwJWa1TKptalTyqKg2YHj4rU9yahltLl/dmRZaLWq8uO8H4DVUs/s6k5ebtNzbqj/oOxUkyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ID1lJVbEcB7ciajeOhD9sPLHN4qYVelU/D1MdvU3+GrEzhRhM
	ZXtfFJIowvWNbzp4LFxsCCngCSG0YlyoAXD8XSCBqE535ReuK52q9sPF
X-Gm-Gg: AYBFou1BLkvWuGxAOCkYpSRAqmKysEI5ZZuVpWfpQdokR0Cu0/w2KoKMP71EzbL2IHh
	d+KKQsqtAgrJ+gcOoiYOYAAwK8xFnem3EY/W/Auz1aKCgTaN4KFUa1Y1wvcRb+36h5GWzl1etJn
	1Ml4e1ajauC02QMnAKQ3MBb0E/m1P3zRngihs57mOzXYlDGeZzaEVkoAvqGjfdIsP8p/uLWGFAq
	xOZKp/f5ZGyLycqhnrKXvOFE+nNM2rzDh0PxXiEx64NserKWKYoSycY1CmbPBGWST/MnZTDsZ0j
	YL5wuyrs9DMGzvXjnrwHmkoJFIYrLC1Lw+p8omkAFgSbVkNmXhqy1Kor8teGypsnQFhOpCgBkrq
	gjLXDVESUM2VBiPitbAItChL56njor5L+UaPn1MdqzQEUnRIaaVTnSoQ5EqL7YmV/aCy5wiwRhN
	b6kogx8r6n48BiRQLQHccPvgLiZNopw0hRFib3EA7D/olePmOQfL95TZg7XWPT5Fq/wMwO//w+R
	luaziesb4yzyxyHCanrT9oLgIBA5n5HAqyo7wvrOlfww1YbqqgDu/D588ARsr9ECdqPtrPTHBfC
	QlXul7N7Mkf9vn+V73SirwsTRtEVBkSIQNJWQ1DBHw0+TKgayxZ35zLVP1OMqrBF3b7Xy1+H
X-Received: by 2002:a05:600c:a293:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ac17d19a54mr202178165e9.2.1793719644922;
        Tue, 03 Nov 2026 07:27:24 -0800 (PST)
Received: from Termis-ROG-FLOW-Z13 ([2001:16a2:4495:e600:87e0:1189:3df6:ff07])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa481a45sm60171945e9.7.2026.11.03.07.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:27:24 -0800 (PST)
From: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
To: Caspar Adriani <caspar.adriani@proton.me>
Cc: Bin Du <bin.du@amd.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Benjamin Chan <benjamin.chan@amd.com>,
	King Li <King.Li@amd.com>,
	Yifei Gao <gyf161023@gmail.com>,
	Sultan Alsawaf <sultan@kerneltoast.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Subject: Re: [PATCH] media: amd: isp4: fix self-deadlock in isp4sd_start_stream() error path
Date: Tue,  3 Nov 2026 18:27:07 +0300
Message-ID: <20261103152707.90152-1-saif.elden.hatim@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
References: <20261028-isp4-start-stream-deadlock-v1-1-babd80273148@proton.me>
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

Tested on an ASUS ROG Flow Z13 (GZ302EA) with v7.2.10 and an
out-of-tree setup in which the OV13B10 streams (NV12 1920x1080), with
this patch applied on top of my two isp4 fixes [1]:

- stream with the format set: 90 frames;
- stop, then stream again without setting the format: VIDIOC_STREAMON
  returns -EINVAL after "fail to get out prop" and "fail to setup
  output", v4l2-ctl exits and no task is left blocked;
- stream with the format set again: 90 frames.

No hung task, oops or WARN in the kernel log. I did not run the
sequence without the patch on this setup.

Tested-by: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>

[1] https://lore.kernel.org/all/20261026182442.229869-1-saif.elden.hatim@gmail.com/

Regards,
Seifelden
