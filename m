Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BF242D9D;
	Sun, 28 Jun 2026 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618801; cv=none; b=uw3j3w6YE5gXZpL21vH+yIG2UXLch57cFmVDvVI5HX+eVUmvgaCcCUzBBW3+cs6xScukYtxhkGzWBGnkoP39BKOyhq5Pvtgdy4lkYI/xBmZItsPviv17emS3R4lMzXOYkly8qDTg0cAWe6MilhBs+MrTlGRUdiHBuK2ilnbhlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618801; c=relaxed/simple;
	bh=q55WIu/94elAF8NuvORDojNqFHG4KRi15yUTnwSd6yQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gYjYmmoPZVhvfd0J4NCpiH0bEswmqFkVmAXmxPymeqipf0d+GOsrf7Gt9UKhQJkQbv3WOMTo8iOVYLveL0FmBGVM+JZaoMMAsCUh7Ey/7c3ObtqsFY6iZTzvJAopu2mVW/ElODZgDbA5ny6A/l1yC8Hjkr34+7ZtAUuibqbaHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S7;
	Sun, 28 Jun 2026 11:53:17 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: clocksource: timer-nxp-pit: pit_timer_init:
 cpuhp_setup_state   failure leaks clockevent device
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626121215.34748-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:53:07 +0800
Cc: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <68A5F40A-4FB8-42C5-8C2A-38AD98FBD6B6@iscas.ac.cn>
References: <20260626121215.34748-1-vulab@iscas.ac.cn>
To: daniel.lezcano@kernel.org,
 tglx@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF18tF1fAw48ZrWUury5CFg_yoW8Ary3pr
	40v343tr90gr429r42qF4DXF97C3ZYkrWakFyUt343ZrnxJFyrXF4DtFWUXFyUGrWfAwsI
	vanYya1ruFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0uWLUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2pAiNkdUwAAsg



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:12=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After pit_clockevent_per_cpu_init succeeds (registering a clockevent
>  device and requesting an IRQ), if cpuhp_setup_state subsequently =
fails,
>  the error path only unregisters the clocksource but not the =
clockevent
>  device. This leaves the IRQ handler registered and per-CPU data =
uncleaned
>  before kfree(pit), causing both a resource leak and potential
>  use-after-free.
>=20
> Cc: stable@vger.kernel.org
> Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive =
s32g2 / s32g3 support")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/clocksource/timer-nxp-pit.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-nxp-pit.c =
b/drivers/clocksource/timer-nxp-pit.c
> index bc5157e2ba57..b77966faa112 100644
> --- a/drivers/clocksource/timer-nxp-pit.c
> +++ b/drivers/clocksource/timer-nxp-pit.c
> @@ -329,11 +329,12 @@ static int pit_timer_init(struct device_node =
*np)
> 		ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT =
timer:starting",
> 					pit_clockevent_starting_cpu, =
NULL);
> 		if (ret < 0)
> -			goto out_pit_clocksource_unregister;
> +			goto out_pit_clockevent_unregister;
> 	}
>=20
> 	return 0;
> -
> +out_pit_clockevent_unregister:
> +	pit_clockevent_per_cpu_exit(pit, pit_instances - 1);
> out_pit_clocksource_unregister:
> 	clocksource_unregister(&pit->cs);
> out_pit_module_disable:
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

