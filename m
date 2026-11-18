Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.82.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040558;
	b=4uqDCUfSiQrco0jPmyjdmUitMPLyFRi1/lZOQ8zvdoFcf9klSI+9CWxeCHIFP9SJOcTU
	 1zQs9/9N/7k+QXGA6LI0Xl6XPY38OeJ7Ro1KgMz3PqVzcBedi65RLfPSF34MAA4zD/K96
	 gnzBHZqjx7/5mXLRi/dGm4Mka8HZLyV2cmUKwJVqLMR0TcmB7641qx5MDnJNqL6tI4eH5
	 jiIcvG+L2d/X3Yjt5C9DsdD5K3lnh+YtSoYlv6r74wv7aRvTISLzQSoL9edOUK8SvcPzV
	 P/PJFxuwI+pRB/hX7j0ERqRq30+yMWstFvEQPPcKmuQEL2WZ5+zVPS5xUQlsyJpl9vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040558;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=07Hk40Tpzd0exU21rqFe2WaV4XF0cHbqrd9OCHEx29s=;
	b=Q2LQKmXJtVEapVE5X/mcOBLxo4j+7I7UK3taSsaHsIc0kfSR2D8W9CKS4wErvEMxilf0
	 nDLdBE4LVCyzPMn0+cxaEbjcIcMKBe6yUa7q77cvp8359pSRSJgD8AcJPW5fu9loCu7lp
	 6/AKZ1TKX7zIBBvVO3SO747e0eca3+6WKnQygcQdDA+d0ayDWQm7whfDvxJE457/grEps
	 +6zdpkSpmRYhiMpPusnXzyEmXBeW1R6fb0394PHGn+2DyQhOqZ7Z6rp+I8AnRwEfQRpRR
	 yL1TpykdoDpaRsoto68ajKjpc9IIFLJ/TrKAV5ikdPZPw7dEtY0+48ZkOTN5TYhGDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.pl;
	spf=pass smtp.mailfrom=yahoo.pl;
	dkim=pass header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=A0PNf8EG;
	arc=none smtp.remote-ip=34.2.82.16
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C2606A339
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B8C2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=A0PNf8EG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1795040555; bh=07Hk40Tpzd0exU21rqFe2WaV4XF0cHbqrd9OCHEx29s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=A0PNf8EGpsyGv55j6FXHvQ+iIdclsGLckSUqutiiajr6W29ucpTLWPZJM3bfgwH54QvJc6P0xPeFuwdqGuXSdy7Gsrh2eAcAfZ57Ge9GzPxMAri1mYalZtCF3krgYR10UUityK0ZZ9wuD9NbMG3whKgIqSPuqpJth+QOkbf1RfVuBWQZMdcO9fOB6I6aF/rVpkoXJ2cHzWdl2RdE/2snu526QIBpQfl0I+l9+VCZMpEgqSlZn/Gu7wD8YUnUjGn82T1bdU7Qn2krsa9sHtouXWV5Ix73QigfQBwhXAM6zE8yYyhkENEcr0Sf6sFVJomBwAqHk3jpZmOcmAcrPHM4mQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795040555; bh=ccBSLLeMHNMCOjiTq3s1KL5ikKwzDgI3u7O26Fa7zeO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=L/YNxzC5q/QkFHR6rTeMKVTXhP0uaRsloQw/f9BcmGA5innpu+CMjBNJhuXE0UQJ+7L735lylKRZnu3ICIkRzV+akRIHvJo4gZTidccNF354eR7IQAKSd8Mee1aKVIlx370jXWpbiAABXmgXrE9os0kiK3GaVaL9Gy9tSBgM9XwOdCTComaULdHPIekmaMq8KAoKxJjhKv08qoTl2xvfnHdeL3zDzag3XzkP/Zk/IMOOeywPw0yZFEggGMlUZ5BiMCaUzMv14DddbtAeCQEk03MMP8IEXNeHUjI+FeWCXQzrsQZSfsmhiD4j4RmYPZDkkg5Et0mz2mjj33bvbzjSYg==
X-YMail-OSG: E2zfUyEVM1liH8nrgR03BY6MMlnSLxTZiL4_OBke00d8BKt1HdeSS03_GrfkSqr
 r9GCOc9.sBOLMNOXYZjK4nMOtJmWBHU1ME5YheUvKyHBHSwtGUEgWtG7zaq1c6FNdezLuaLxA.Xp
 Yw3zGp2ZcmWE4pntiPfB6ZobFOYDCIMqSUP4wUrtDIgNZk__QG2cydAdDYWhYr3T4PlPg3Auk7dX
 PecEbRNaDLxXPcSVG3zd6HUWMVCzccr3IJayk6WXtYO9o3dHn_tdKDR5Gp80D3RmuoU.K8bVCkmZ
 78PrrACxbiDFQopx_yZZ_GrMiwfNCeeFyTitneeZB2YBc9WMCfR5bcWhResYxcknauhnxQnCLtdw
 4.b2pZG60ZC7cqM7.z0O.xDbZ4oeaz5hlAUHR2PRCvs.W7K5dAxfv4lJ2XB7QSZxLo3.ozCdRnjv
 K4bVWwWp0PrW.AZizoSKL6OF.i38BScvBNMWv2QZgB0hDqaxfZEuSuvJrRL6LEu8stZk4xvnR9xU
 Q.9EwD2P2eEYILkCucgbeVopluAfte2JWDyuxpgcIJybhhW4JhlH5NY4YGjG.HkheBQq_3ZV23Y2
 A16Tdhu6KTPxT8vtErjJh2d_SGkLehTL53Kd7NMJiw_MugeZgabadCiXUjTn1.b__kzvOnb5.aq0
 Cy3I.lWLr5u5Ob4iWd2_Gj2Fqq6QGHtdUh1JribzK548K7rJO4gjY.kX54bSO4Kr1m7hWIP6OpKy
 GwVJ27xsMtZZzmlS9KOZruP_xpiFx6wh0_7pjrHeaV16YG2qzixnVhV5Yvg4QhoVdRITSLJfA0_6
 YYpCgkPchhWoDVJqNI.tjOmklhaUpp2rDHVvFPIDqqG_HcmpHFJKRp1XN3xbjNwgLbdYWYyF9xGn
 2ZGy1QMoP7XH3rw1ZckxsavCPbkZKCvdGPe2bLAB.IEFM43KKzWD5ch76SobnEFv_4IeAWyPPINe
 2EAy9zNwOoCXDbSVZAw9_hQMreoHCy5ZUXA3pRnNB588xuYx4tDhJIbqqNz.IVEeKS18LvmEU4qd
 bbewjsO2fmBaOaslcOcwG_GJk9jDoG.UxwgiXWgrCtXU88jEOWbdEuMfca6V6bCoejBVS2Qi09bm
 rlFixmrRHH6OLx.5HCbFROnaKTn5qHCtptwJcjKYnBBbIzBxCfbH.pO5eoqg4tPz3t_yiA3u7gRA
 M9.G.KZIgAjOVBb8k0ILs3iTAKp_whkGcQOZDQDWSwQudtq2RjBpaKZzI1sMZwSYpE5lCTsw1F5R
 wmNe9qhYhdL2CpxU5rMOOraG8PEXtnV6wIoT7KbytqlOEG_67J5dIx5oZ_QRYVHAcShuFedKcSSn
 ihZjrob147ay12HRfKgNfv30Lje81TP0woEB0tgAjQQV0rxESgXgjYbuYrx0zD9e9uWKPiaPk1uU
 7e1jIM6SD_W9gmdesHdAgAw2RJ4TnmPBbtSkF8aTdJALodEYNU8hHzSrQ5jjvOYCeVStEiBy_L6W
 maJzYNVU2o_kk1YzXLINJT3Rq3Eo_4AbqI4.v.zHdvJHRtUU.xHbML1f2tOPsa_DK0bn0LeOhYHS
 _dvNJ20Oa6r3BZMAYnrd2ixmV3WaMEIhq9d13prdNmSvBd.By5jTkQ8Gne6ZmWX2WPg_A0fdNcNE
 hVP.Z0PTICyR6z_FxO0FJOsIFguVfYLOWzQNNW.why79tm6W4YQbzC3U1QsnFGV1LSoqGJaVwVY.
 daNdATXaSqglCV4N5f1JIXiWdJmd.XCK61e8yw1arqBmLSksiipY9b0PwC.6LWENZyzksqglRIi5
 dy8buFOCLAMXaULCIBKvBeYc3qbCEEImHI2h2Vd83cOTh7y0GFNhra93jRr9v2dkWoKDw2nEkfFa
 TghEdCMf8BLthrv7BBsVLj9.7Ca.iXaaNDNnQfRDnqf39ZPBhMg.fxfIrDQhIam9Yx2disLL84So
 MPGJ1fAZnFOPI3yf66YMaHDnUHu6mhqjLaom3AnJI23fN1yhruKj2QWazVjAy9bdqiE0AYhB8dHF
 dbeTLLDW6XjqRkM6uaIAJ7m9vOQ--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 0eafbce0-69f4-485d-810c-5d0ee321b30c
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-104 with HTTP; Wed, 18 Nov 2026 22:22:35 +0000
Received: from dip120.lsn.ir2.yahoo.com ([87.248.99.129])
          by hello (SMTP) with SMTP ID 97eb8e7d0ce49dbbcc92550550a7216e;
          Wed, 18 Nov 2026 22:22:33 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Frank Li <Frank.Li@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bcm2835-dma: Add missing of_dma_controller_free()
Date: Wed, 18 Nov 2026 23:22:30 +0100
Message-ID: <20261118222230.123431-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <av3_yVSq9CKqix6o@SMW015318>
References: <av3_yVSq9CKqix6o@SMW015318>
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

On Wed, Nov 18, 2026 at 01:43:05PM -0600, Frank Li wrote:
> On Sun, Nov 15, 2026 at 11:15:15PM +0100, Tomasz Unger wrote:
>> @@ -1027,6 +1029,7 @@ static void bcm2835_dma_remove(struct platform_device *pdev)
>>  {
>>        struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
>>
>> +      of_dma_controller_free(pdev->dev.of_node);
>
> use devm_of_dma_controller_register() to fix this problem

Hi Frank,

Thanks for the review. I tried that, but with only the OF registration
moved to devres, the controller entry is removed after
bcm2835_dma_remove() has returned, i.e. after
dma_async_device_unregister() and bcm2835_dma_free().

In that window bcm2835_dma_xlate() can still be reached through the
node. dma_async_device_unregister() has already freed chan->local and
dropped the last device reference (dma_device_release() does
list_del_rcu(&device->global_node)), while the channels stay on
od->ddev.channels until bcm2835_dma_free(). A client requesting a
channel at that point goes through find_candidate(), dma_chan_get()
fails with -ENODEV and global_node is deleted a second time. The same
applies to the dma_async_device_register() error path in probe.

Doing it right with devres would mean converting the whole teardown:
a devm action for bcm2835_dma_free(), dmaenginem_async_device_register(),
and devm_of_dma_controller_register() last, so that the OF entry is
removed first. That is a larger change, and
devm_of_dma_controller_register() only exists since v7.1, while this
fixes a bug from the original driver and is tagged for stable.

So I would prefer to keep this patch as a minimal fix that backports
cleanly, and send the devres conversion as a separate follow-up.
Would that work for you?

Thanks,
Tomasz
