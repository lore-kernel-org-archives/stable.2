Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669181;
	b=TmMdwebkgYZN0ciiWfFNeRyQcfEaWnAduaQIuGdOF3jjFu7s23JNVIcr/i/dU7eF4Ayv
	 woQsopdKCcW/m2H+5rAvjoVnv6gGx3EmorwSC9TwLTD1Bosu+543iPI+I15I7ipnUnocV
	 mGkZz5HzZvLKygb/kMtuAiuRw/tHMtN0g5cyl7oreeMQTVdt4JvdroF+tKdZR17PwZoCk
	 ugGsSItW6z8ZjE7KFdpUtKvK8Ak6neqAmBvxe9UAuiuH6s/hJQeVBB1EaUEHtIsKDJn0d
	 thjJQf0bR5H8KFEQmbJysCNrRupJsQf+kJ0N33/SOHrjuo9ucO597aD5Oh3SWuzlIyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
	b=00LnJikYBwoBb/UrSAt1v2R5XAr6yZ1FWLn5VqacvzF29ES+VUX7h5wLB4cECAVgFklO
	 oDLmpOYXm9SY7trFRkj4sXP4aWxYkyokO7e693gcu43Xd34fuRsVFz+NEnLgWyQIKzTU8
	 FHwH4wGKXYzpKYxurgXqqZe2RES0jNygJWQU8efO9VLvfDmtGQDj0Y1/nWjimecrlB5lC
	 Bw15gKUI4VWsUfri8LFvpGTjgYI36kP5JL3YNDCnC5wbhlIULtvoX5zxu9K9Vg5d1FUCs
	 bVjzpygQL+P+5GZqV83Pj8UUuYKmVI0KN1oYu0E1bCHHbGyYHOlMXfKvrzjmafDPP+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1z09xs+;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E038606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E038606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1z09xs+
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3724107a91.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669181; x=1796273981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
        b=L1z09xs+l6yotNjMoqY+4OnbwTKue1rlBTJL74KHEvHu5gxCUa6rWoKN0TBHkzjItk
         pkdeWwdmpchcAbPf2UTu/oC/H+4uEyRl4HFmiTJ+U43xXkPQxAeP0gWkps9bBK6s3E7U
         GIw0jMeC74HEoJp2d4QjVj/caCEtIoOecjfJZEVtslVz+p/HXKQSgCFIAZ4blsUluy6R
         kIRZHUuUWVXJg01pCxzpMWgcAokcsroMjmSrpGTiyKjwxPOOufwNDCRJxe1Rx6YZ5tPt
         ZYTEX1wWvsR6/ossvz8czGlw/I4VRCtGc/p/BoviCxTDB/hzdy6J8b3XtS2pPza9I6za
         XG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669181; x=1796273981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+nJHVRosiUPbQF5ndFjmNHYck9oE5omsocbkDSOO/o=;
        b=Gpy4vueaa3ItZHEGwBW6tbsB9Mo+50dPQvLSVWQ2J+F0gM+Nsd1fwkBk42G13R5912
         iVsfQC/HKQVcvXsuG33BjBFyNELuOJ0UIWuz/MMYMwlFjOcLH5nPcFRD4oA67o0gt8hX
         SZjTbDTugzwsnJ+MEH7wbwVVvbtfcMfgdaWuNcEA3hMPQcyw/yaOqOPwvOigauqTpalt
         RrfQTk68+eDCFlkhWm1BqSLiAqgRhwDJ62LFV6KZMWI0gACds8Rt1AmYz97NZn2d64gP
         08M1M9qNAh0YFCjDsYx3rhwTj7lyihvebezRRqJMCp3oPry91U4lyiVr402/BxEbdKk2
         j/rw==
X-Forwarded-Encrypted: i=1; AL+hErGi51ibCUy/z3n+sRImpgNJ6nx6oUdYq2FbCB15DITGqOVkqBxOZ11e0U3w2eBm+pyicY8deN4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SvseEXRCTp/J7GF87AOVWWolcFvINBl/2G+aTjmyqLtFWeaFe
	LyZu1Pw+GpnOu2hbgOG+50Ln0qybFmZtcyCLH1WnJuyVn+E2vlsDizzt
X-Gm-Gg: AZFdTZcRtTNBVVq01vDi5HWVMTXZVCmJHr28lAlBmCdd1ieqDyiELXDHVD3YncQ3FTV
	s4jAprMfdt+bsMLZuQJq7UTMrpIcxAghGqSHPSLCsVb8dDT0glxvU9vzZOpZESeQyfzzJvEzfHh
	KYZdZeiJiqF2QuJpLsBcUTZlb8omwThTrgBvVfd2VOJY5Jlq2+SP9qfXQeEB89IIq2csG18i8Uk
	qWbHs5pVAP40o3yEc1mQ4ukhOz2oJPk4HeDAvUxNJUVjGMW2ehKLzgWuoFDTDH+8qrhtQtaUCom
	CKMGtXoQE1qGqzrYoygtDn8k9RTyGRf9QAAKBeLT70LU2W8F0dOwA1KMopayyGUHkJ4C5Rk+E+P
	35CJ325mC7mDKXHEZnY1OZ9pxP5OGlnfVIUi+R6I3zzUN11H61FZERGmJVuMbR5D+MxyPUk98x5
	oUXidS17X91NbRS8PsmZvHjo/fcJJ0tYTJ5W/ZcZ/w+YQkFrG2yuVYPaXUVLrycgzRGSA4bs5XM
	faIQgKaALHGhD0+D+vco0cFRztEnNGXNIq+51V45dQcNoXH3hI68X9ADnKLikFYMLVWYx36cFjq
	e4Xh/3OK30QjGaYxw65yJjKed5Dh/duow8xSm7R68W3VsOv6kG1b6YY3wPFOIfwJsEGtZbGAAlj
	Ef4+tZUp9fge1Om0IaXeS2M+eyEHzHDZvi4lFhSiatIqAS87Ug2iF0PEX8b7Av/ivmzyLsJ6DCX
	UVzFH0Fhv1W0IxPIin7RIYi60=
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr12803039a91.38.1795669180620;
        Wed, 25 Nov 2026 20:59:40 -0800 (PST)
Received: from kapoor ([149.40.62.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm30661677a91.8.2026.11.25.20.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:40 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 10:29:28 +0530
Message-ID: <20261126045928.518052-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126041911.55827-1-zhiqizhangg@gmail.com>
References: <20261126041911.55827-1-zhiqizhangg@gmail.com>
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

On Thu, Nov 26, 2026 at 12:19:11PM +0800, Zhiqi Zhang wrote:
> Accept only the fixed 28-byte PMS7003 data payload and make the checksum
> helper reject any other length before deriving the checksum offset.

The out-of-bounds read for lengths below PMS7003_CHECKSUM_LENGTH is
real, but 28 is not the only valid length here.

pms7003_do_cmd() waits on frame_ready after every command, not only
CMD_READ_PASSIVE. The replies to CMD_WAKEUP, CMD_ENTER_PASSIVE_MODE and
CMD_SLEEP are short frames with a data length of 4, so with this patch
they are dropped and probe waits the full PMS7003_TIMEOUT and fails
with -ETIMEDOUT. The driver also binds to "plantower,pms3003", whose
measurement frames have a data length of 20, so reads on that part
would never complete either.

>  		num = get_unaligned_be16(buf + 2);
> -		if (num <= PMS7003_MAX_DATA_LENGTH) {
> +		if (num == PMS7003_MAX_DATA_LENGTH) {

Keeping the upper bound and adding a lower one should be enough to
close the bug without dropping valid frames:

		if (num >= PMS7003_CHECKSUM_LENGTH &&
		    num <= PMS7003_MAX_DATA_LENGTH) {

With that, the extra check in pms7003_frame_is_okay() is no longer
needed, since a completed frame can't be shorter than the checksum.

The commit message point about shorter frames passing the checksum and
leaving stale PM values would then need a different fix, e.g. checking
the length in pms7003_read_raw() / the trigger handler where the PM
fields are read, so it is probably better as a separate patch.

Thanks,
Arnav
