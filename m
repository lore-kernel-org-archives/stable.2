Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA42701B6;
	Sat, 27 Jun 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782560583; cv=none; b=DsxnidJCn4j6BXIuIRmajWHz/k4UZwqB1TgiODK3sWOTCOFFEMy/eIuwS7R2CDbLhgG+i+vwVv8ND4vdmsITxLkTQ2Sr6xTabvh9fRgKissb0i9uXRSHeJehVhSQLVIQ0qcCNshe2uUl11Lg1LS/rgyxukUAlPJ+3TpETyI2GZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782560583; c=relaxed/simple;
	bh=3mxVq99yn4aKKaOcgRV5QwjAvgoJvrPCMvbXndaxFD8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W1zV783pXQoca0GYJI3I2v5aqdn5S9+no4M8d29rt7W+IkR7JI9GRSRCgPPOO6GHIoQGyYLiEkdvBnL1S2BRQECq6dehTyggPfNQmtnUXcASG8WdPQ4aFCEl5Kj8gZnEAHchX1ZhSVIB+7B3fC7DPTOnlynU9UCgOyosf/jdupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowABnPJM2tz9qzg4MFg--.4997S2;
	Sat, 27 Jun 2026 19:42:47 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: clk/samsung: exynos_clkout_probe: success path leaks
 parent clock   references from of_clk_get_by_name
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <2026062612-twiddling-lagged-62ac@gregkh>
Date: Sat, 27 Jun 2026 19:42:36 +0800
Cc: krzk@kernel.org,
 s.nawrocki@samsung.com,
 cw00.choi@samsung.com,
 mturquette@baylibre.com,
 sboyd@kernel.org,
 alim.akhtar@samsung.com,
 bmasney@redhat.com,
 linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10D15C29-89E4-4A0B-BB89-F03A86963DDA@iscas.ac.cn>
References: <20260626120135.34173-1-vulab@iscas.ac.cn>
 <2026062612-twiddling-lagged-62ac@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:rQCowABnPJM2tz9qzg4MFg--.4997S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF15AryxWw4DJFWUZFWrKrg_yoW8WFyfpF
	WfKay3AFsxJr1Iya1IkF1rCFWxA3yrKFW5Wr15ua4xuFn8WF1IqryqgFs8ZFy7J3yvk3ya
	qr4UKFyUK3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2R6wDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcLA2o-mHs6iQAAsN



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:24=EF=BC=8CGreg KH =
<gregkh@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jun 26, 2026 at 08:01:35PM +0800, WenTao Liang wrote:
>> of_clk_get_by_name() acquires clock references stored in the local
>>  parents[] array. All error paths correctly release these via the =
clks_put
>>  label, but the success path returns 0 without releasing the parent
>>  references. The references were only needed to obtain clock names =
for
>>  registration and are permanently leaked after probe completes.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: 9484f2cb8332 ("clk: samsung: exynos-clkout: convert to module =
driver")
>> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
>> ---
>> drivers/clk/samsung/clk-exynos-clkout.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>=20
> For all of these, you are not using the normal kernel style, which =
means
> a LLM is generating them, which implies that you did not properly
> document what tool found/fixed all of these.  So please go back and =
fix
> them all up and resend them properly, after telling the
> maintainers/developers that the originals should be ignored.
>=20
> thanks,
>=20
> greg k-h



Thank you for the review and guidance. I understand the issues now.

I will:
1. Study the proper kernel coding style
2. If using any automated tools, document them properly in the commit
   message
3. Fix all the patches following the correct style
4. Send a v2 series with proper version history
5. Inform all maintainers that the original patches should be ignored

I apologize for the inconvenience and will ensure future submissions
follow all kernel submission guidelines properly.

Regards,

WenTao Liang=

