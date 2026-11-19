Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089730;
	b=sQigPvWCvT1f9brnLvyoP1RBowTSkE+GLUfGPc+ZFUgRsxV4QAuqmmJYkiSnY+yh+mMB
	 oXjme/X1HwVsuCulkM9hrKvLUHfTqCz1u+UoOcGMLkB5n7iTQzTgMEgbwGuLUrmjjllRO
	 nq3aWHLWS2yKSvhal7afAj1vgH6xvI/JlQVfQpicnMAmPTX07nyreYMnMf+1HomGCXHm2
	 o7LyZT4GZ22ZKXEF8e6mHFvJoxGwoJB3MBIRl7ccyAZPelot44D0L0YgA3mn1xsvYN3XY
	 4dlmGxZJh69M6dqErIaftko4bncEoX8ZZGeCz+1Prnrt2rTkNogNOW1g2wwa7Ja2Chw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YDlJsIuJa8MwyVI77eR0NYxBTdSV7whURuYWldxSt9A=;
	b=mPbkDl/dXLep3YPHhyn7fvXiuDWVC4Q9OfXqc4Npm2uSKw8BLKMWmr+RvNXpxwWsa+vt
	 ZyTiGyaWYx8OLx83vXMIw05AS2hi9ACLL4Pp2R0nwo6IIBnVlXcnyn6WjeHzOkOYirAg/
	 Gz+G9zisZt8+lMThH016RjBIiefdlDcKMB/fUKA1ekJDZZLgMpMgJLhDkSTSuKQxYKIi9
	 m2yVswrufwPiV2rDtkCmfA1Kc0sT2TqshnotWSbijZ2jmbKOwzG6AvMdT7dkIC1uw5eEV
	 69HTkdPpGGUPZEsUdL7ebNCUbDcVqTEc0JJ5AEKGzrbRxdGEPamYzITXg+Dvd4to0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Eb0C3IE7;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C43606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C43606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Eb0C3IE7
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so340828566b.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795089728; x=1795694528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDlJsIuJa8MwyVI77eR0NYxBTdSV7whURuYWldxSt9A=;
        b=Eb0C3IE7Of1VIKzNdNSGAOURqf8msysubyZ4D3mUOKBa21Nte6ajs+0hjfqUo3HK49
         353mGW2WAtSElXUQfEidnbvMCjNgjo+DInnv5D0d408r61rtefnWre427aq3+0wcbaq8
         uXbPV1GqCFuSxqu8iPFJfsOFefSPhdWmc3Kr5KKPqVXMJDxEsr0DwSaaNupN1OJolglO
         /JwS/ts6UZ/zBjB4Gu7YplVzylCT7MAUB9YB0FOEU+EWA7O/F4sWItKxI/5xQxWOwOkk
         ssQd2ldyicJJTHX6n4av0B4bkuEvPJ3vfIi0o80rvw16+kFi9rC7+zIGA0S26Xuz+7Ps
         Rz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089728; x=1795694528;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDlJsIuJa8MwyVI77eR0NYxBTdSV7whURuYWldxSt9A=;
        b=QtR68ycCB1VzwQ5FuVzorNtWf2SvEp0kkbzDuqKna4kDI3joFgITVGmyzYMkTxzLKc
         LO9jCENc2yc2QLVH64Em5mSG/dPHHVDiLCrowhGwJqgTgUxGqdX4CSD+Rw0aX1pWa0uy
         LiPXOou38POeVELC3sFLkUTJ+hw5vXznA3dMwuPCqXzbP6ozQTY5fynIQgrMzUyTOrYo
         f/Xc9mpnVjPlQDQkVU1gj737VKDcih7/QeiT2lz/KBBMak6WQvdnQlE1PCaZtXeYmRHq
         IEJArI46vIo0HcZOlSi9NHpcqpCpVqLna6UKgwv5tC1S8ArGDFe2Y6u+k/GPxBm/K87a
         u5Cw==
X-Gm-Message-State: APuU4Z/vN9Qi5/X4pqEapz4XrjGJBYWHKuCEtGwYskTeDXS5C1pk2nid
	/HWXtvZTCW3F9mtPNwxZPW+9BMyI9vGr91WaffqehqbFwqFqkFDUdnkTgK8c3lGz09BxcMMdhrZ
	hSJRN
X-Gm-Gg: AYBFou0FTKC5xRpz+BqltBJdxG2OxLOgJECB5Hyh6d6g5tX5t3YRwGlHBr8r/m3C3wU
	UIfdOzsio5NKEOHKFd/lHCF9VFS5aKrAY2Um3yhfdLzT7vbvT22f/yH5deiagVKU0FIGYTN+9qU
	GM4gcaXDZ63Ir7mTfgjUs19dlpNfJOV/t2b0X/dlInM2jwWYwX4MaMfcFaY27Wh3xqaudBDPlbk
	67hgg7uDPOyn1bUCR/OFVosRhVgzOnBEkhKSj2D1Ymwpw5UQeIBfp4GfoR/dMyUDuew8VSQ0mdL
	Tyt+qxLMhUGm2AwM4sk5rHQRpfy2wVDk+BuCZfDwfnyqKUjG7ISUc+2WD21kwI3XrpywBbw6rMO
	5QSYUsnXsFqZMBfwTqyB3cb1Gcs229S8UGHrE2cuto7qQzHU7aqLmKhS5JZbk+mMqz2vHo51E4E
	C8PPn6xQkjeDFv0cziwnGy4+rCAtCcBqSdi4gyXAkg7YPJVV4TJt2woDzkgjXalIZvawt9nTNjo
	3O+HlTeIRGwVvs4iIXln3sqRqqG4EtkYzJcMu0EDxOfkTiKpAS0gGuqnPj2fAYeXbEgiAlhmOcw
	RPXdAVrJr/VGDIYK1UqKmmG4PaWy+qOGFvk1khnKzoFwb7mfv1POiv+8aps2t5sPivZrQYlwZpo
	z/fCiPo31BCgt9w==
X-Received: by 2002:a17:907:d40d:b0:c50:5275:fb97 with SMTP id a640c23a62f3a-c510e5843e6mr491548666b.47.1795089727668;
        Thu, 19 Nov 2026 04:02:07 -0800 (PST)
Received: from ?IPV6:2001:a61:13e6:9f01:eee3:1629:f0cc:42a? ([2001:a61:13e6:9f01:eee3:1629:f0cc:42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65683d5a2sm10686055f8f.43.2026.11.19.04.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:02:07 -0800 (PST)
Message-ID: <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
Date: Thu, 19 Nov 2026 13:02:06 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data
 into sense_buffer
To: Alexandre Becholey <alex@becholey.ch>, Oliver Neukum <oliver@neukum.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org
References: <20261119084526.535901-1-alex@becholey.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261119084526.535901-1-alex@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.26 09:45, Alexandre Becholey wrote:
  
> The special case is not needed: for the error handler's own REQUEST
> SENSE, scsi_eh_prep_cmnd() already points the data buffer at
> sense_buffer with at most SCSI_SENSE_BUFFERSIZE. Handle REQUEST SENSE
> like every other data-in command.
Hi,

thank you for looking at this, but this fix seems to not take an
approach I can approve. Where sense_buffer is pointed to is
internal to the SCSI layer. We cannot use that in an LLD.

If you think that LLDs should not use sense_buffer then the clean
solution is to remove it from struct scsi_cmnd.

	Regards
		Oliver

NACKED-BY: Oliver Neukum <oneukum@suse.com>
