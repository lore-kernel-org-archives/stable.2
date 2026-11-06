Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957464;
	b=OTA7yGr8T/ZL+0MuGzpFEC8ppMda85DF/Cn4Yl0896AqmwCZ1ORbl83DoL4/IXbE3vGc
	 GndS0yJaRATDFIulxX4Da4keUIG9E9i+X1t+2m4ttcNPBKuEYAYq69GS1ZmjRz5JaMzt8
	 747gyq0oY3/DTWV/aNbfPg6P9mRZJyNFQoHXndsxrjCb+NnP0O0lLlCuxan+RwtoBuiUO
	 3PMuR9lwYU59rtk5LpqytIbfFrAC0ru7HWZZRmay551zcOWwahzEr2V+D76c/ViLE3Hru
	 +uDuJNe7kqUrmOtlSYPmnGJ0ZVuS6vnpQn2EBmFHrfTX8/eeD8EQu1de7Q5vlP5l52A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957464;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=pkMm2Zmil5ok/PO3ra8ZG4X/dksxyZ+uKs/AtX6aAaY=;
	b=Gpe/eqB74EA9U3E6gP0L0yOdXLHrx3KXbQVCtKOTqdf3ENLhKKzganD8s18yKJDXQsP5
	 zDUSpKwJx4LE72/hcKksStnnrtbzG6WDZ3xAMvgI2QbTSLorn+HNSu6c+6IjFAP04DwSB
	 dX8FvDzqchvH6B21FdJ+svs2u/per5ZVBQAGVfH3uYRfdmsyAdGHOraXVknv52kVnrse2
	 VuqyJ42PObHo7UCGTmco1z1rIMiHdvLDwNzPhnfyRWJNXUakNCW1bVyRbdNVL03z9F7lr
	 UcxWyg6vWvbygpa+isacNrrBbRbgjuuoj/yameSrZ9yIflpAeqq7OCm9Zxf7fqnSxNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83686606A33D;
	Fri,  6 Nov 2026 09:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83686606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXZJVQnu1qt21rAA--.5978S2;
	Fri, 06 Nov 2026 17:30:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Fix adapter reference leak in
 i2c_acpi_new_device_by_fwnode()
In-Reply-To: <20260917065743.GZ106095@black.igk.intel.com>
References: <20260916155507.2074970-1-vulab@iscas.ac.cn>
 <20260917065743.GZ106095@black.igk.intel.com>
Date: Fri, 06 Nov 2026 09:31:06 -0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <179395746647.2284678.8559513137457956554@iscas.ac.cn>
X-CM-TRANSID:rQCowABXZJVQnu1qt21rAA--.5978S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUuFy5tryxCF1rCF47CFg_yoW8Wr45p3
	95KrnFk3srur1Iv3409a1UXryru3y5Cw45ArZxX3429ws0g340yrySqa1qgryay393tFWU
	tay8X3Z5Cas0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UMq2NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIDA2rtky8q+gAAsw

Hi Mika,

I am very sorry for replying so late, seven weeks after your review.
You took the time to look at the patch and to ack it the same day, and I
left the thread hanging without a word. There is no good excuse for
that, and I apologize for the delay and for the extra work it caused.

> I don't think this is right. The issue existed already before the move.

You are right. 53f8f7c5cf14 only moved the existing ACPI support code
into a separate file, and I should have traced the history back instead
of stopping at the move. The leak was introduced by 605f8fc22442
("i2c: core: Add new i2c_acpi_new_device helper function"), which added
i2c_acpi_new_device() with the same pattern: the adapter is returned by
i2c_acpi_find_adapter_by_handle() with a reference taken by
bus_find_device(), and the function then returns
i2c_new_device(adapter, info) without dropping that reference. So the
correct tags are:

	Fixes: 605f8fc22442 ("i2c: core: Add new i2c_acpi_new_device helper function")
	Cc: <stable@vger.kernel.org> # v4.12+

While reading up on the thread I also saw that the same fix has since
been submitted by Ma Ke and is now in mainline as a65917d0a22f with the
corrected tag, so there is nothing left for me to resend and I will not
add a duplicate v2 to the list.

This has been an important lesson for me. From now on I will go through
all remaining review comments one by one myself and reply in time, and I
will not send patches in batches that exceed what I can properly follow
up on.

Thank you for your review, for the ack and for your patience.

Best regards,
Wentao Liang

