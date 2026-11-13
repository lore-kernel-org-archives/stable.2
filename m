Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599514;
	b=laIJUenFwk1Qhtg2szE31S4jLHejHuTfsg3rbv/BbHBB4aZb28DpN0T2sIFKvmhoc+qL
	 82j8aB9dthIDopXWWqZQqpuXNL8mce4qXh3PVSKpoWP2PEqdgYoxFjEyVkozgQInYRPlU
	 TDgW/3Jn3BWr+4ZK/9OIaRc+8Tudg7aYkdtd/P9kqnyIcnf7AO0Kg8zKC/YXSvpcsmTy6
	 cpb2kOi9wQK0ucbX09R2SUX1q3o4vN76VYO00GDqUvxie9DFYn0URMhc+pYX7AxgLP/J3
	 a4Stf+kbAqFEek9nCpKAouB2KWrLEZcD1dRebAqwQhmdqGeNlYSxcMhsW8WgTeumDsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599514;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=8ECM7h8v3szvfUHrUOczJsK+T30L8LfIMVGsWq1/EAQ=;
	b=pA0ceVfomP9ce0aPgl0J37lHZOuNxuBPSpzQJ/yKJ8x86ZnL7NPNPaTDcF3qH7GTii4/
	 H3EdjIzX86Rn6grJNzFEJqMjKIxLkF9SPqV8t0m9ETwbSrM3E7WAXOFYaBPVRb8jkmWPr
	 uyabYU2IIbz8vEBDxEK6YJ6LsfjfUC03E5vFhlxGg5k4Zf2wRF75c2USWBUOvT7+cDIw9
	 bBIkjUMOiGq4G/mH6+OdJyuiao3R2QJD5e9AVehHkdFlFXACtBeNKX2c41qH4aDWQjfM7
	 hleV05Rpcf2QQesSCnQE3gglcLnYPJX+DRa6Ga3uTmFAQl4nAJ9La+j+6qiTQjMewog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TKv4CrLO;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDD606A327;
	Fri, 13 Nov 2026 19:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68CDD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TKv4CrLO
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C56AD1A1651;
	Fri, 13 Nov 2026 19:51:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BBBB60015;
	Fri, 13 Nov 2026 19:51:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2294911BC03F6;
	Fri, 13 Nov 2026 20:51:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794599506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8ECM7h8v3szvfUHrUOczJsK+T30L8LfIMVGsWq1/EAQ=;
	b=TKv4CrLOPU1pxDCGtU47n42Fa/M0lGNnyJBNXUrj6YqXfiD7pfP3K9J7hfbuJCz5mV5Kpi
	tCd+qVpYYtDYk7SbDgfswEYzfZ1Y6fiKuqSGFWxl8Ni2KCY3EYS2aThqwnREjhb6ar2l0B
	yeWdNl5tT0/8VlzwMv1AO6nPU3JrAAyTIzc/AZsEUw29ZoTsOc7Kd3f/zSg2S4bmAER21/
	x93OnbaZFlnpU71JTltYjNioZjTRDvVL/Gl9/93EOIjWQXXyRKlvbXTbt8ycUMleyRqIUs
	4hWyH/gKm1sFlCJSXJ77z7wlaWgkKuIP7OuetY/Y0aSZ7+E3/4aZK1V2RGpVuA==
Message-ID: <c9d26395-93f8-4e63-9cd0-586ce913931b@bootlin.com>
Date: Fri, 13 Nov 2026 20:51:44 +0100
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
Subject: Re: [PATCH v5 0/9] Congatec Board Controller: Add storage devices
 support
To: Lee Jones <lee@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
 <20261113194450.GM6323@joneslee-macbookpro.roam.internal>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20261113194450.GM6323@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/13/26 8:44 PM, Lee Jones wrote:
> On Tue, 03 Nov 2026, Thomas Richard (congatec GmbH) wrote:
> 
>> In this v5, I re-ordered a bit the patches to fix I2C bus names first.
>> I also made an error message more user friendly.
>>
>> Lee, this series conflicts with some other ongoing patches series:
>> - mfd: Assorted resource lifetime, teardown, and error-handling fixes [1]
>> - mfd: Constify mfd_cell arrays [2]
>>
>> To make your life easier I rebased this series on top of them. Please let
>> me know if you want to proceed in an other way. 
> 
> I think these are all applied now - less my I2C patch, which you are
> free to collect.
> 
> I'm ready to apply this set.
> 
> Does this have to go in as a set or are the MFD patches orthogonal?

They have to go in a set because of the switch to PLATFORM_DEVID_AUTO
and plateform data usage.

Best Regards,
Thomas
