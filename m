Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021974;
	b=G41pINhZB398SjansCxNuCNsOYn2iwCX6Eik2Mlh3yL91C5yGW7LfZ1vg0ykXPJ0LPV1
	 RHFIWtFwWDetA0j66KDEsELrw6BGBDUCd3O464GLPpk7r/kV63hZEmaR9YPQOJAJXwR/O
	 yRQPUvwsGiXxDaaDkYWvxRTsK2/qA+FchuKIvQT+1dqwshJHdhBYpwI4vAuSgTTTuZUjr
	 oblDNAnsQk/lDt/uVun47MKMRfdAujmK6/Or+FVbiK8m902k7180AL6BrtZh7JjUu5XZi
	 3a/QEq9N7417pO9YL51SoFfsHXDp/HtZn8I9+400emxdrMa4m3ptb+gT/B5FkyyJz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Upxleu5PclylbFkFy5/TUrklY/Ium3UhTzAwysVorX4=;
	b=w6BG1iZXZ7xzr2T3z5IChtCkRa3Vx04bebUrrKFEO1ULpx0UKEioNJajYmYyCWV5o1Mt
	 vdYZT6GD9h4hpfR22+h5460qeWMrP3DoTOLqd3wJFdr5sBelThdhxNrtfSAqc9djPefBf
	 KNhEsi6IuxVO3bYbtpUdsZIUPCIIDY5je9mYt0nBsH6OHKoWJBTWQMgprv+Od7kw834vl
	 c5kpx2e94mRJcxcmBA9e4U2Cz1zeeZxM5l3fpGmB2+B8HkX4kA+peh6bXCKXtnab5kh3l
	 rPQzMgJG940eDZ2aEzW8qbXq9esdtIZbdA9h+7z9my8xAw0IFh/KRLahRpRWY3EL4KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwyF0PXC;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F92606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F92606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwyF0PXC
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49355a50d11so115385f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795021972; x=1795626772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Upxleu5PclylbFkFy5/TUrklY/Ium3UhTzAwysVorX4=;
        b=nwyF0PXCU31oETZBnYGqmuIzowi1kcnE7reNVwGl9PO/qyDB3t+CJ2Wztk18Z6gOLW
         P4Sjf+5tzcKPI/NNskflPr4CXvhoRSFCQIV+bf+ZfgWpzcL5uS7elC1nXdbw4Fp+neiH
         a9/1wMDnr2VlcXUyR2ijr5A3WnCBQjqGAAzZ2Px5kZy6x5OhVHwYC9ct8VslWOBun6fd
         wUblKds6rHuPyygs9ToMQ2pfslUHSwib8ck+xrtqZyCSGnxG3aLOiZiuhY5/ZTWgi0UR
         aLxMRA1WfU1BfRlEemvDHjRP5A7B5jpFWBtDbo3gPvvkM/D7PVv/dKYDHwkanwlwAXSF
         U+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021972; x=1795626772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Upxleu5PclylbFkFy5/TUrklY/Ium3UhTzAwysVorX4=;
        b=FS8FWvsCEYqeA3/mijCgh8lyNlQwjruoKCl2gs7/uJrYlBPO2j8eAd+/dD5Tu2yE8y
         HnRwyctoA4dADWpeTHey4vsCFhvtGHm+aTuMNfc3tva2r5o0EFgR8wbHuorK1lKMv3cg
         m2Kc+fI0pwmoHeTFP+KKGhlfangF7WOIhza6dr6yhpyB/y6GaFR9yuEccCf5+6DoyQpZ
         iACY8tVI0rOxm0EoXNuqCfdo7QYCtYeBJot3HOyoAgNvIzzkqYRkKdyolRqxVccMey11
         56iqwAGZAn1fK8/NRME2AX7RHxSPX6CU7WT/PAbSZTzNQIdBSfKlo/gZdjtsfYjRegnn
         uduQ==
X-Forwarded-Encrypted: i=1; AL+hErEyGDGJQZSuHbTo0pcG4N7dAGiywrXSrIo2I+uTxbEhFCsob629qqWpWZdV8fDi8rqC4VU7ZIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OiBBkBgEK7/lproxLYIwMPoi53pLsH/9l3HUsc+Drx3CvGEye
	bcQ41rNOMsqsWwPlTgq17Nw4Q5Yj1NszidZX8ZlaX412gcZGYazpkNRu
X-Gm-Gg: AZFdTZdovgGUkWwZfMhTH7Bb9AT3MazibxlMG8EKYpAtl2uS8oHklATgbYK9a8ESyku
	gJ/BaM7bD5urZHHfoI0spQm+QUbtF86+uzJ7/p104tavSJEilkOLX9u5mRCmvX/MVIn2qzAshYP
	nZmzjBooQD1neAiIomvV2Ee/wcSYrVjs3z5Hf+s0aj8OKEYRGtm6BNCmgd1R418wV6uZdkW26Ir
	zSWFtJqSNfaCIfq8g4ADZGXqBOsvam0x1cyps7woj23lE/zvDiyMm8EwiME5LGfS8iBcI5aJt5z
	YHLwmDi1a+MIhraxI8ejUtmj4YZIzsYHrZn5ACb1EAddYUM3t3jX1IAf1M8MAN40HDBK15W2mKy
	u35J7xBeJLvytrQuAGmvLOvuT06VJFnD4+07vYbHeiDHE7h22EU3gj1HiMFs9K5sPt3sUg/awz0
	03krYMmds8VyX1sx5Z5aO7RxsHfRlUrO3+9U1SdJRrLwiTrHuZ0aWuzza7z4gTLxnUuSTIPTEDa
	AF+DnzI6xe0+QAcaiRLMW1Em2/DokhhwGS2hxWL6W3x6cbU58o9RbPazXFaIlNe77ZVOeyWf3AI
	LD9ta1tS0RvWvvHcziWP6NH2Qsy8p9jz2JPvb9S7vkeGvu+8uqFxZFw7dAIBcp08kd4Q+jU=
X-Received: by 2002:a05:6000:2405:b0:4a8:eed3:770 with SMTP id ffacd0b85a97d-4a8eed3127amr182443f8f.4.1795021972366;
        Wed, 18 Nov 2026 09:12:52 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6573baa9fsm6313344f8f.57.2026.11.18.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:12:51 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: mwalle@kernel.org
Cc: miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	vigneshr@ti.com,
	takahiro.kuwano@infineon.com,
	tudor.ambarus@linaro.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spi-nor: take the flash lock around spi_nor_restore()
Date: Wed, 18 Nov 2026 19:12:35 +0200
Message-Id: <20261118171235.3886698-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org>
References: <20261029210153.3986211-1-itai.handler@gmail.com> <DMYDITU0H48Z.2LA5KF2TFNUY2@kernel.org>
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

On Wed Nov 18, 2026 at 2:33 PM CET, Michael Walle wrote:
>> +	if (!ret && nor->shutdown) {
>> +		spi_nor_unlock_and_unprep(nor);
>> +		return -ESHUTDOWN;
>
> This will be propagated to userspace, correct? Not sure this is a
> valid error code outside of sockets. Maybe EIO?

Yes, it reaches user space, e.g. through the MTD char device. v6
returns -EIO, which is also what the CFI drivers return once they have
reset the flash for a reboot.

>> +static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len);
>> +
>
> Please avoid forward declarations and move the functions.

Done.

>> +	ret = spi_nor_prep_and_lock(nor);
>> +	if (ret == -ESHUTDOWN)
>
> This is actually really hard to follow. It's tested for even before
> it is set down below. Also probably wont work with an EIO return
> code. See more below

Agreed. v6 tests the flag instead.

>> +	if (!ret) {
>> +		nor->shutdown = true;
>
> Why don't you set the flag unconditionally?

No good reason. v6 sets it unconditionally. When the lock could not be
taken, another operation can then read the flag at the same time, so
v6 uses WRITE_ONCE() and READ_ONCE() for it.

> So why don't you just keep spi_nor_restore() and just add the
> locking there?
>
> What about the following:

v6 does that, as in your sketch, except that it tests the flag before
taking the lock. Your order works too, since spi_nor_prep_and_lock()
fails for a restored flash and releases the lock again, but testing
first does not rely on that. Only spi_nor_restore() sets the flag, and
it runs from ->shutdown() and ->remove(), which the driver core
serializes with the device lock, so that test needs no lock.

One more change in v6: spi_nor_remove() restored the flash before
mtd_device_unregister(), so with the flag, the unregister could no
longer write back data, e.g. mtdblock's cache. v6 unregisters first.

>> + * @shutdown:		the flash was restored, refuse further operations
>
> shutdown only covers some of its meaning, it might also just get
> unbinded etc. So what about 'restored'?

Renamed to "restored".

v6 is out now.

Thanks,
Itai
