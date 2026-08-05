Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD040B6E5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957925; cv=none; b=Lv5T6vgIwslqKG1oKdjBZWyi/lxkD811kEkOFWRlr9PSxwAsQxCSsLZ7bL2jRW9Qj4txxWdUkeOq2tikYNvVttSSJ2vcVva+vWKLrdousSWGFDv0lKReTAuwlED6j/qhpHl3aZKa094NNcq2s8f7zENOxj0INlxOOaT4fWElv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957925; c=relaxed/simple;
	bh=872nyeUESCO50cOAqgj+xeiSzSDWlRs5vEPZkhvRpG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSV6yhe6GYOV3kSgxdszdV7phhDy1R8hJeuyhiIHDf9Xv4NzOwTFBfRLApcjghSypdkYdPilmFN0LkYYCAMNM0yqgIkbBxPi1twGe1NOIu9s2CmJPIJG61CsoGdH19lVEbnOR2wrh35VQ7n4RBR0bi4uoIQNOd7HB8ADxYOuiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lHFoOP/A; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lHFoOP/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785957910; bh=gy12VoKrlG0xMwQZvi1jCEXapKjeFbH48ffdim5dqmw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lHFoOP/AaIjVAUsSQJfCc57lABrOafvqvle88eYqTPFbpS8AXiKXnkRH7IF746qhwNJ6m0Cq5kqcmMWNn9BU7Jr08+63OHb4XO1ujS2jnF6AdqhvPq6oqKwMQzcterthRHJnv00+nhNZBwsOTRwhqPsvNvQctSoILNki2gBQPoPpHI2WUhm3OuNUb44W3ZhHyVx7FooIqGvFunV7s5R/iYv6X4AE9dyGinAc5EXEtt6yFVott+oy8Bschbk8YriIN8DaxtxayA9xddMsB8tyoXyvtrIMHnHEI+kL/8cPobYRgDn2cSvlRhRxqWNizZmTaNyV2puGfFBprGf1E556Ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785957910; bh=Z/ZKObohFQjTRiAZIJHRFUxPeSsduyrIa7PoFSssGQp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LS/ZyLF04AtiqA+qSvfHJ4HvI3S2kfOQxxq0Z7jIX1Oqf3zWNnsAp7yajc3JlsMppnvsTfy04/M+JUZ2S3tZ88k7AzEterudYyQL5sbb+/Mc4ZRWFmfV5C19NOJQWa51uiEDkB+xnHZ+uOmNXDXQZP3WF9YY4R8Z+0EJgXMNSSPKeRsPVs2jiiT5zMJOrefnqkuUwQsS8RX+ilFsKEgK3G8BruomeEKa0DEVCtCHzUMZcrebAnMpLT8bKpU3UjvL43z8HEnyfsdWQOlMlmer7cRHWd0BEhjKxqkkEwRVT7aH0SP2tQRvo5bInZ1IvxJMtiH/V9C+/2yqv64ge0ZNMA==
X-YMail-OSG: S9zU1VkVM1ml_ypGr9R6Wd4DvNmfgpG8lvLFpRPKelrhP0fWCV6Ur6ZweDKmJU6
 zF62ssO9llyfHJWpDg8yGMiVxwTza4hLwTj4FFeE5BQKRMJFdEiOJADx1ldjqoUQvE_lgVvqgtHp
 MPdjjAjmGXaE5WHWIQ9a9MM8p_1XEtWD.TdgpdB7wP4lZZZAiI_RAo4LUdgWQ5VsOELQVL7.WD4d
 xNAZQbK.e2LNhkemps0lMeM5tif9FDTSR4ew0cxD33TDUT9zT4Xzo8YsVQSR20bs9HrDdqWEXaco
 HqhhHUXPfBPGyEh.yKARCNpihYhnoVW13G6kXqtZoPhssttjLQ3rxNOzBIeNNF71FtypK0v9A6op
 oxkp8FMkRAvE8c1yzWxFiUCWb5AEvlrABLAJpQ2.jaVurqTmEUNS9uSNxKx7oX4GToCvcoYEmnLh
 4Pt5MkZiTL0ewAlHzZzF6o5hezJlKzRkeaM7gaqUwoEkU1.5.adxB9BLA9XkSLf80w6osO_XDbmM
 va_Ip5gBemEs3H8tfhgeh_lRDXXqRQxJlODPlP8OE2ivevauR1ZDo6y1MkFPC0LgiJL4wDaNYFTv
 AEFnJuFzWStJPNnTvlL2EsAXqBR4WjpVTqKINSlXdYSymWzPy7bS33Y4KMa2cVXdXp9RLw2zEr45
 ZQNnJMrNEErn.z8IMjWObh4b8MbVCrGL8NajC0Zlr8adxj2_vOs71U8Lbkp9XVGNL9s9Giv7vjED
 KqkRUSm8JoltIWAsP10tsYTj_M1gdEANg5t_thLUCrF7Kwb8j_Vvm5zxG8BYSLXb64F5jWI2AuC.
 p_LE_bt_igrMrPF2GwersntYgn5sRazIhTCCoi8S7.z.tbtVnZOrq4lFmqce4gTleC8HlSB2ycTJ
 4SY.cKuIgcp4zDLkRIJPlxySL3fr8XlYRrDyCN.jocqMHBfcQfsnpd3zoORJ6WPPxf76Nn9bZIKK
 cTbfdyxKwP7VOtJ6PatHrv66av6o4dSy_IAGeGQhrgJSyqvs7rSpK90SsOYgfnegb5lpOfKOdhD0
 I0p.MYfrwT6C0MmHbfOXBfA06Zs57NS4549WndgV86qwbF1Nc8T9S03RHOwZHIgRGQ_GOM1Ilg3x
 qwVwnsBbPOi_ZD2Cyvvlzk8X0nvoXU3vaunrH8Nz9EOsaK0KW_Sbb08F208efE6ZpoqK6qRgIjNZ
 ZkDTAjQBqOSCzAO68QiV78A21a_Pg93NiaDt4XdEyvbytRuaFa9h82n5vqM02lj5aUZrgQcG9EGR
 W_biV_IKZgyBpAXOjwJfgWGSCQAlGQ6zIIYLUPfvUIA5qIyzlkC_m1aDuSJb5KG3sZtJuwwpYYyB
 JRuP1AGIQj3cuJ.T7qCN3phO5cZKT0rIDjA3vunKROJDWvQ5fiehi45I4D04N8TOVfo67mk0QGPL
 d9W5x3xMLDjpPG_m6dXibjcQl4DvEdiyKLI_.uOpCyoGG8C1QJU0HHLlKQQcLiznlmQOgBMKRFez
 oo0oUdTwO2Re1A38pJCDjJT.xd5kykOAKVsVYlQ_dxqI.x.s1bY1YPESRPdS3cakwx0_dcfBqStX
 M5LK_H7dQ1Bjg9btGberZFbIIesXNOsvpzLjUYjHDgQwd9Xa29a35o3VkZdvSbvKKztpmDVFkHIq
 4zXqq5UNa8C9Jt1BQYGyXf0bi1BaMCfa3ykPujt_MYhnbUtqZj750rIcyv6vKhrAHrjQDNNh0FPS
 Dz3Bmgv2x87ReUGicHY1X1ncxxHqsGFkQ7ZTNLHkQhTgoVAPEYzZdqH5fWG3eGQbmwh5HBSmtg5f
 eSY5iPJ1eTj62Yu9plQSqDTuT666z7xT4.kFSTUhqkO3bNQj5RmpUV2b.WzVsCulNYam4chXs4cI
 8mOmkUGcHMoA0KP4vzrGA.te.1S5yYZcUMEgZXuzXkwZlry6ljvPuwz6Nb0Bi4rn2.pdg9BP2aaP
 o3NLF1fHbthwNZcx7Txn70Gw5FGpyCJILVFiRFfE3qzGr_5fLSKsCdrMorfhd.8nL9vMTanBnZcP
 uL1u_5bvd5B_alDhOf3LOmWKc6Pu.tprfeGstQHrN0.LLruD6Obsmc6PEM2RUM7G71luefz2pZv9
 v6MdOPivNj.foAPq1OaF.pSCtgdOVr5pX9suyezUTRQZ4_1hkkLV1E4cC5NIFAtqAUpzQFQzmLlk
 WFJtHOfADsGveKCOBp8oXqZ0SFYocD8_7ec30p9qYcjyrZdHfTi6V7J2jtlc3jKeZQBZaN1W_bZW
 xEiuBV68FI5rHSwekEUSCkZ0pdAo_JprNWmJ3TnkcjTtWdbSs_WG5iT0EfNCsNCBcZ.KNkNxQ4th
 CQV8seaKDLAA60SH3Bp3Yl4eO.mb2PUs-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c239a0af-6752-41cd-a9bd-1cf70436465a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2026 19:25:10 +0000
Received: by hermes--production-ir2-676cb4d88b-8kpjt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 33776572d402f77734bd94cd7cf6c2ba;
          Wed, 05 Aug 2026 18:53:51 +0000 (UTC)
Message-ID: <97efcff3-c625-412d-800e-ccf8215f86b3@yahoo.com>
Date: Wed, 5 Aug 2026 20:53:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Stanislaw Pal <kuncy7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Jie Luo <jie.luo@oss.qualcomm.com>, Brian Masney <bmasney@redhat.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260730191353.557494-1-kuncy7@gmail.com>
 <20260804115359.16633-1-kuncy7@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260804115359.16633-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/4/2026 1:53 PM, Stanislaw Pal wrote:
> The probe function takes a runtime PM reference to enable the GCC AHB &
> SYS clocks of the CMN PLL block, registers the clocks, and then drops
> the reference, letting pm_clk gate both clocks a few milliseconds after
> probe has returned. The clock ops access the CMN PLL registers without
> a runtime PM reference of their own, and on IPQ5018 gating the CMN
> block bus clocks makes the SoC hang on a subsequent bus access: boards
> died silently within milliseconds of the CMN PLL probe, up to a 100%
> reproducible boot loop, depending on binary layout (micro-timing).
> 
> Take a devres-managed runtime PM reference in probe, so the bus clocks
> stay enabled for as long as the driver is bound and the reference is
> released again on unbind.
> 
> Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ 

[...]

> +	/*
> +	 * The clock ops access the CMN PLL registers without taking a
> +	 * runtime PM reference of their own, and on IPQ5018 gating the CMN
> +	 * block AHB & SYS clocks after probe hangs the SoC on a subsequent
> +	 * bus access. Hold a reference for as long as the driver is bound
> +	 * so that the bus clocks stay enabled.
> +	 */
> +	ret = devm_pm_runtime_get_noresume(dev);
> +	if (ret)
> +		return ret;
> +
>  	/* Register CMN PLL clock and fixed rate output clocks. */
>  	ret = ipq_cmn_pll_register_clks(pdev);
>  	pm_runtime_put(dev);

Does this error path leak a runtime PM reference?

devm_pm_runtime_get_noresume() returns before reaching the unconditional pm_runtime_put(dev) further down. If it fails, the earlier pm_runtime_resume_and_get(dev) reference is never released, leaving the usage count elevated permanently — probe returning an error means there's no matching remove() to clean it up.

Suggested fix:

ret = devm_pm_runtime_get_noresume(dev);
if (ret) {
	pm_runtime_put(dev);
	return ret;
}


This failure mode is rare (devm_pm_runtime_get_noresume() only fails on devres allocation failure, and undoes its own get internally in that case), but the code as written still leaves the earlier reference unbalanced on this path.

Mieczyslaw Nalewaj
