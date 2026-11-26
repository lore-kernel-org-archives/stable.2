Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702924;
	b=i6Jky8Klf3l419pUt1etd7cqdpwXvqGYRVfJdiNRQf7BwO0zogu6behtPp0kjbjExkNW
	 BrYF3s9MytZ1J/qs8GCvu+dCDOFNFB+C8ZvQOzGGSmM/lwTPlZO9DLO7u3Rg3xJj4tBEx
	 Cj1m6KhebEaYHfcdNyTNDe5475Q6DHZoXnyOs2it+VSFAfSOUm4i2U4vQL+FJ7Jx0viti
	 QRp+7jHcKIRX4m4NepSRkgmUZlPXM/i8DQEEWs3GV4ZN6ZAa/Lv7D535ftnBZFSKm+wpd
	 3TYoYO0LKNEYKfanYkc3S/DUH6xA1tV9jYssfm4ya6SNWuZHiDjP+sT2I3RmJ7S1cfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702924;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=OvVAZTz69zThPSa7hVXEpLXSovgpYtvS4X1sc02ssSE=;
	b=Yjaer3rpCVh7T2fZ75CjWzWdmNK4ccTjHbJjrA+Y6rvrG4DEYw4Ldpv0pyAP0jc82OHz
	 +17SpmMtRdahUvN8M63B02YsnozzLsH0rWCQZS43HPrARo/W/aBTwb06n26v827FybjsA
	 kBj5qR5qKKxcyFndrh+fPOMaiBHNlJfZ8T5mHUfZS2iDEGHe+bqvJ6dozfdmOqEVwg8d7
	 f66Rha5rUj6A/Tt38cRo1VIlH3yQ/IXkVcdCwDzhGsxX+t1WPCqdTDHIJaE5yjPAvtGdS
	 tvTkfRTzrbxqf2F2w0jgS3TEOP1fksOX0cG60i8PuXZNbkmfnju/CoC2Vg36X07/JpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aoiNvRcF;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9242606A332;
	Thu, 26 Nov 2026 14:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9242606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aoiNvRcF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3CEC14E417A5;
	Thu, 26 Nov 2026 14:22:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12490604ED;
	Thu, 26 Nov 2026 14:22:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E40EE11E68014;
	Thu, 26 Nov 2026 15:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795702917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OvVAZTz69zThPSa7hVXEpLXSovgpYtvS4X1sc02ssSE=;
	b=aoiNvRcF7GPO1yOrbbUy+hL+m8rUvoytuvmFiBT5vnJYRMObC6UfTH103FpcKeZR1yVX7k
	95I57pM030VNwcOYTIv0fXoLgoMK8CzmqBQyOrFDhqfBkDCMQxy5w9H0oGM23ITRIZ4y0e
	K9cckRyHdEX4xPC4iVInYC01liObmgSJALbXyN+HgM59fDbakqFs/NRcfKEZbmaMkYqLho
	hYz4dPbVQTsHFmMUCRGaZn5u8hFDNy6+f9PeZY5UGIBW/clPHiQ1HcZ2wnenJeTIPzMbi4
	dLSTpFpP29mZclQ0zhx6YLTpMIWMhlvpi9fWSFFO6u9ZCg/JZ2NwuF69ekBw/Q==
Message-ID: <79b852d7-13b6-4535-915f-21c992e2ae67@bootlin.com>
Date: Thu, 26 Nov 2026 15:21:50 +0100
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
Subject: Re: [PATCH v6 03/10] i2c: cgbc: Use real I2C bus names
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 stable@vger.kernel.org
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-3-bb070ad3e9aa@bootlin.com>
 <awg2_PLCeNgio_bp@zenone.zhora.eu>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <awg2_PLCeNgio_bp@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/26/26 2:41 PM, Andi Shyti wrote:
> Hi Thomas,
> 
> On Tue, Nov 17, 2026 at 10:47:43AM +0100, Thomas Richard (congatec GmbH) wrote:
>> The adapter names described the expected purpose of the buses ("General
>> Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
>> rather than their actual names on the Board Controller.
>>
>> Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
>> the naming used by Congatec.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
>> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> 
> BTW, do we really need the Fixes tag here and the Cc stable?
Not really, I can remove them.

Best Regards,
Thomas
