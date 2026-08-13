Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DC3E49D9;
	Thu, 13 Aug 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641624; cv=none; b=ALAt5usCjebKX4DqiviMHgcJENWFpY40F54VaE9ig745BdPDVoK60hsN4ZoZH7LkS/I/0KF7wtmC01LG/XCr030WfUom+mhc3ggY6/WjFGWT0yiTjT0u3UENMDKNYykZNNP7ZkRPqeIQjrnMaTz9MWj+JUz4eNscGo23Jvk9yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641624; c=relaxed/simple;
	bh=gPF20lBUTfWowRPUaCbUzpH+o91/NSADtbsPUJB+mQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4cV4n8+vbrcC7Tcx8ulVBvUZ6ekk6FJm4dO71231QSKtDK6T5YzwqNNTHb2mvw1sSiTvNz+egXckmYF/VfCnSGzD9j9zz5H9yvPZzCyF6kIXi5L9vATuo1gOCIIs6rRCqfBThcicIljIn3SCdJ2ZwwlaoFIFE0DyXcSmqhE5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QEJ9051v; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QEJ9051v"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 102B24E4120C;
	Thu, 13 Aug 2026 17:20:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D685C5FF0B;
	Thu, 13 Aug 2026 17:20:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5BE511C4E21A;
	Thu, 13 Aug 2026 19:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786641614; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gPF20lBUTfWowRPUaCbUzpH+o91/NSADtbsPUJB+mQI=;
	b=QEJ9051vxTgV+mzzjEJVOCeRmwxhuQ6J12DnZWl57XwWTUTfZpNZJHwmhMa/TsoD0bMMoj
	Aq6VaXFt65fMurYTOM4DsXmaUc+SRu+2nb60Qyzyh2wLuotsIRiKRkWZwCRb9yjEMxGGBi
	t/jOc53/U6pWBOy4VeLy1TWd8ehO1A1hudD+5YDJmmTuNBi7DhmCIGc2J+A2TCFAQD7ggC
	/5UmTJOL43Uto6+neOO13l5beJPI8YoRRXsq2adfzPQF1n7syraukHnvSBjA/rQYz0RB7s
	qU/h+eiwjhhzEn1Rm15LP/+UtMadgU9QYx8FW1CJnYELHboF0Wi8BnLjOXqNTQ==
Message-ID: <c36a39d2-f5b8-4290-a482-54696f810ab0@bootlin.com>
Date: Thu, 13 Aug 2026 19:20:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Congatec Board Controller: Add storage devices
 support
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 8/11/26 6:15 PM, Thomas Richard (congatec GmbH) wrote:
> Second iteration and nothing fancy, I just fixed a typo in CGBC BIOS EEPROM
> label, and added a patch to make cgbc_devs (MFD cells) const in MFD driver.
Please ignore this version. Following the discussion with Lee on
hard-coding the cell ID, I'm finally preparing a new version of this
series which switches to PLATFORM_DEVID_AUTO before to add the virtual
bus and virtual storage devices support.

Also IMO having the i2c_board_info struct in the I2C bus driver is a bit
odd. The I2C devices topology on the virtual bus can be different,
depending the Board Controller. I think this complexity shall be handled
on MFD side.

At the end I should have a more generic I2C bus driver, and
platform_data will be used to pass all parameters (including I2C devices
to register on the I2C bus) to the I2C bus driver.

Best Regards,
Thomas
