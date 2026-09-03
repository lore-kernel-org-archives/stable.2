Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC430D3EF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422674; cv=none; b=tk4Zm1Plv8pdw7dTdN5aYwPb5dDP116KWdUpOwWK190eOjHE9rmu3dRyMDh+UZBG1HStaTSvrCJ7z6Ac1xYUR+FQqDRCgaIbH/JqBWvYKgW33A90jmjMjtJHg/tAEyUeLyuKbFam0Ev7tBhzv2rNBsyxC1s3et9T5XPUBq7qaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422674; c=relaxed/simple;
	bh=JB61utejtiG6pU4NAgVxmPQQ0gSCYttUdB7PP9ZViH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3KKDKbG2OUI+uhkrCNYxktOOZHWX7DiVhbZSUmnZ50dWb3dh50hiEFdQSHtZ1LDbh7iFB6iuudwBczGWtINXlNCVUiUhUG71uterDTZHDJ0WLQSpOVOcSmWMX6cz7Lu5GtmIywUEGS/B26pLm16+3uPqVk0/1oeRiu9WKDicqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IiKbbUsw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IiKbbUsw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EEFCA1A197F;
	Thu,  3 Sep 2026 08:04:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBF8E602B8;
	Thu,  3 Sep 2026 08:04:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 000AE11C79ED7;
	Thu,  3 Sep 2026 10:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788422663; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mKTESKF9DSQSLmk9LEWoM19Dn7BVERBm41zRt3vprfA=;
	b=IiKbbUsw7JlI0jWEs0tlb0SndLv/vE3JlKggJdZjMbz3y6xezeu6km4NodLHOHo0l+4pff
	ykXTJFJecVezFq6S3q+z85HL85ZC67Izq4vrdPO9rZSsA4cP8E1as/m3+kSTDLOjqJGfsM
	nS8XFmqq6Mg2HRyrvLWF4NyQunBRQwhsBIyj6QWMLTscebpR3wT2Piy/HXxd9Yr5+x7yL+
	u/bH6d7CvqnXOcOHklmcuRESuIJMOAg8xQ2gsR4txBfWkFcRBkQBI3rdSwFFHSRhe3awPs
	YWJBkJLgim6PQGaoZQLH3+d2cFmxYO94iCdBzh7sdvS51ZJPdfRNv2/pmEYXaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: henrymei <ljp1205831794@gmail.com>
Cc: linux-mtd@lists.infradead.org,  richard@nod.at,  vigneshr@ti.com,
  linux-kernel@vger.kernel.org,  Aohan Mei <henrymei@tencent.com>,
  TencentOS Corvus AI <corvus@tencent.com>,  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: inftl: validate MediaHeader partition geometry
 before allocating tables
In-Reply-To: <20260902124044.3942821-1-henrymei@tencent.com> (henrymei's
	message of "Wed, 2 Sep 2026 20:40:19 +0800")
References: <20260902124044.3942821-1-henrymei@tencent.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 10:04:18 +0200
Message-ID: <87h5k67ocd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Henry,

On 02/09/2026 at 20:40:19 +08, henrymei <ljp1205831794@gmail.com> wrote:

> From: Aohan Mei <henrymei@tencent.com>
>
> find_boot_record() trusts the on-flash INFTL MediaHeader partition
> fields without validating their relationship to each other or to the
> device geometry.
>
> The sanity check
>
> 	if ((ip->lastUnit - ip->firstUnit + 1) < ip->virtualUnits)
>
> is evaluated in unsigned 32-bit arithmetic.  With lastUnit < firstUnit

lastUnit < firstUnit? Did you even read that sentence?

Sorry but, no.

Thanks,
Miqu=C3=A8l
