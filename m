Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FA364EB6
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226792; cv=none; b=KIr8mry42U5KQmZTt6x/pq5L12LLPBS1JtiDSlYXpyZhyLcgmLXFANuM/Qoghz9oDc1XxdNHvEKr6UjnM4fDFx8KA+hgmE9L71RlFMCpwqPFRXgcprgnKNMPFKod6joMEzOFHPLpOozFfl+SQXpFZGT4jzXZIM2ptV3AWldQhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226792; c=relaxed/simple;
	bh=P9GZKua27kHk87nOoDuIx986vLiN96klWW2v6y0Vzbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZquaZMlZAqa5wdHz+y/u1xJgRmYoCTocZaMFrVxGl1H0PmcJ/xh5x8Cklj0G1dfU6AQUrto2CGD5A4jPAU0fNWxi5gaRcBqdiyr0OR3eogq4Hul/L0Fm7oJ4Fz9/QZPvZ23lV8ZiQHJPjlCRRb1FZMb5B9ZIhjXKT2qqpV6mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JeMuVF/W; arc=none smtp.client-ip=66.163.189.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JeMuVF/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786226784; bh=x4Exd5dUVZzZ1h6YcswkbFiEUHTp13+PB7/Hv0TP+HA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JeMuVF/WBpTFcVirDOJrOXdqYGaU2o1ur8teOOz/14n9mFjn4tJiAjwLQ3RlRgf1wVh4lAUkaLzXLa2e7Dq28axDlgCBymSD3WX2ZAz9k4G8A9XWuUjuqztkpCHL9ThArY8gu49jgsdKSQA5fzmGPG1V0IdN+zjhs4jkm78UxK1ybZEDQvBN7uBFN8gvUTpX5aXgTUzzWbBpbfEbMv83NqtsTSm2SFSvvHUQaORno3GsSdk69pldV27wbVayD34sXyf9AJWVKSTGKkyyghHAR/dkpDFg3gPUp7ZE9p+TqNdJt4No0jY8MlKfwXOtzY4Z7+QdZsBOMARn6vaxPMF3uQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786226784; bh=rIOpyWQTzMssRh6wkxwGSNMEWoT5m/zZos7E+pa/Pwh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QP73lFrdKMx+ueVpf3/VCpZWlxv6q8eucZnSUfkMtgImaYN9O7XvWQO+SrPimCWT7SG6zpFGxL/snVJTmb096DOjcw9mEWev4Oq6YtifvFESERVxAI0xmMhHph52lBDm6klCr0gW4Smx4uApDNZc2EKDj/88lBCm8w2HTxiRXPE4bqdFySKMaXdqQO1eFgwOQQDnmIAwqeSVoIsgNi9LQOehW3h2ASCBQyPIATrJlH61XO3pUtehWZxywhM53KU5CjmsV4XuFcvqwo3tz6GDPk5nkMqppxc7FDwChoYWLXI6lbMPTzVKIusowM/KMBx5qnS9fgs7kGiuXPNrDYEDIA==
X-YMail-OSG: qwBOUr0VM1kRmTXYKP8BIo2gfVQZwq8EcGaOEWPgQjdCXlCuonQd3.Oas1jmRdN
 BuByy4mhgTPyDJVviPvMIVeQfHP3pBvwKyuYv.od0eZSJv55HPYoC5ofRmxc5Nzjr0YF0dM_LwP5
 ltzuuW1Vmi00Ki51ikMSMybo4IVgq5pHPbCyhQv9oY9oQGKI6CsXaAhZzG.jc_c5LQh.QX2r0zox
 wEeCo2K6O1GQVzELFYqLgyLI6eDKo8Z4.qm3B1mOv8w.AKF45FA_AH1QBB7JzLFr763SAlnhTz0F
 L4_FamyRbQ0KWnQSj8ARxVES0oyszLXEF9BoTvM2bdGT0.RhEMHHfWJTfbFWrREytRXYOJK4JYXe
 WFFtRlIpUIt_Vu8w_u51yamEW3tHSmo8areeo4sDjElZArFMsGMQ7.Votn7b6ShTXosnwwxp67Xt
 y.27cnz0qLRrN2_PdDHLzgZQjRTnIcw9MPb0ATmlHc7jBkdF1MMokmOguxil98fDGcSRyZAg4vvI
 PPGtcoDgh_f3y0EuUohPRV65vr5XbLA_83G.hWFLTPwgAVzbOmz7nWjRjXQ_3V8j8kDJnvZesTlL
 H6kO43uo8hLsBWMrLqFPoiq7HqAa8fQht_JuAb0lZ0k.mRqzJl9Y1hIhh6KDtC7MXvAibVYzlRTr
 JDNVs5_BlviU4MI0BRIhJSQwGcRe_Q32l3n3sWXnYJk8VRBP2R_u30QcqOo1SuTgu_0b1FUd.xxv
 yA3ZLKgfIxVnvlNpoa0tAt2F8kOGaQbJwQZj.fujS0_G76Sek3Et59jBkjf2du7SDt9vRbI16RrQ
 RUQdrUERJBY4O77TeboWfZVLA0.6fzA5ClTV2qiSdPHo8on777nrYH0qmVFKP5AGpqn2ePFOpkFJ
 d2dU4R0iau.b75F8vs83H0.T7ERW.jWQ19t82Aq.RjvyKUhud88KZXaSiKOhCLYeWtQXCvnKAYU0
 SgUVkhKqQW8BDx0XDpI6ALq7u8D5SRpCnQZ1vHbvuEEaQx_HZ1ryYl7bjnsYFbvt9cIHVHG9HgGU
 HuLCaXpzHv_jUUYLaZCLcA4iiHtRoj3HnVFlCZ4z6C5MB8yxqIZ.kjtORK7cG1EjfzTQLwUq197o
 eTvQMbDGuk0sbqdNKsCKHJuqz5GsChSUAEKtFlmxzBmhCUW61D39IdCRlSOKdOmO58Y23.qcxduq
 Cl6J.TVGy70pX488DSixJIjLBYz9gv8QLKXcNBuAKQznuGVIrKTThG67K.aNm_yKKqvbDvqxmiGi
 lCD.0xzaip_Ao1RD7LaJ9tgBCYPKGs7kPl9SfqH7Txy1VixdWLqtA9rAvJZmUW6NLMwDjRgvvUc5
 S54bXPRwxJs8Xi2Dh2BbPtVTp5WoBckYQAjhauHTbc78JjQToWGsgJi89I3nS0HPhx3eaKF4X_OH
 i6Vqd9pBXexN3ZYRmBrXW7aYNphaH39ChEnKupI9qYsmJ.oHJaY4rbZTZkLTBYL_WBTkuiuccuG8
 PZyIJqlXgWiQjR7.4SWmil74diThmDaMUKIveMtB_80NLcWFNDxDN8n7RrpmgTb6ZfroNe07Gy9b
 LqQ1ORYHnI7LVHdQBrsJ.XxnAGS_5J9cbwx1uJZjNVwklRDI5FFFxZNVf0ABOcdgBnF9KJOv026g
 5xeWARGldU.mpW83ip6mZZqLgNJA1abbKsw2i4MwKN4oQz7wcuWrmNVufOalxSwT3UG894pQVPS3
 8VvxeVjRva73Rw8Ff9H1h416VT060n5tCu1L7AUmebhLiX_wDbBPP2H1WF3NeG1FOJqCvr0wxbHE
 CX9UCvx472pen8HsG9OHIwR11DSkShTabDusMQUGpbExS3TUGXYhIhavRnOOuViqgp66JtKH.Awz
 SCqwkYMXyEfcT7cIQTb8o.VXY5x7QmXzwUaJ.yhNWIth4dZbd2vxS77qTro1Vrb7w2zaIIulKWLj
 yGpdB8u7TQmcPxe62bM5cwZSD_HB3lBwXwn4JUtoZ6qjnH5.C4UJIURyAry4wqFD1H5eGikccJ7S
 sdhdNcFbrN33IZCgnOUJRT7ksm3yvOy043jnE1CUHtVUqqbY3foxP1gJTa7HKMBzZUSm54e8vC6k
 5hm9i1umFVhHQnf3qjO6Yd_I7p5.UivovU_w2qIA5kSAHfR5in3XMqVMJEoCHqi4hkmBPxIqOa4a
 kjU6nTJH9R_IHyyA488uBtKdjOthmUNzuI9VDa6ISRJxXoPkDtCs4RC7loo_nD0Zj7tdvj0uY8az
 t2Rw29fHJ2qrBm0dBg4gZU0Y56c9_z1WSxctqdgNkfvrTiBY8cd032oroWnfuXtWEnmB.l3ZdO8V
 wA9qpI5whXKY9VjTaLiJ86cP_KgVTdMiOMw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e3a40ec4-6b56-49ed-8126-18c88621383f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 8 Aug 2026 22:06:24 +0000
Received: by hermes--production-ir2-cddf86dcf-dn8m5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 523dfebdc042a695eef441963409944f;
          Sat, 08 Aug 2026 21:45:44 +0000 (UTC)
Message-ID: <fdc4410c-18f3-4f34-8519-deb37862477c@yahoo.com>
Date: Sat, 8 Aug 2026 23:45:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Jie Luo <jie.luo@oss.qualcomm.com>, Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <1dc44e5e-7787-47f7-938f-1ac0676d96d2@oss.qualcomm.com>
 <20260805081240.11497-1-kuncy7@gmail.com>
 <7913cc81-5531-42ac-a85c-fb873e439a07@oss.qualcomm.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <7913cc81-5531-42ac-a85c-fb873e439a07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/6/2026 4:33 AM, Jie Luo wrote:
> 
> 
> On 8/5/2026 4:12 PM, Stanislaw Pal wrote:
>> On 8/5/2026 Jie Luo wrote:
>>> Is there any use case that requires accessing the CMN PLL registers when
>>> no downstream consumer is active? If not, I don't think a fix is needed
>>> here. As you may have observed, debugfs clk_summary can still display
>>> the clock rate correctly even when there is no downstream consumer and
>>> the AHB and SYS clocks are disabled.
>>
>> The clk_summary observation does not show what it seems to show, and I
>> have to correct my own previous mail on the same point: this driver does
>> not set CLK_GET_RATE_NOCACHE, and clk_core_get_rate_recalc() only calls
>> .recalc_rate for clocks that have that flag. So clk_summary (and
>> clk_get_rate()) return the rate cached at registration time, when probe
>> still held the bus clocks enabled - no register access happens at all.
>> It displaying correct rates with the clocks gated is exactly the cached
>> value; it says nothing about whether an actual access would survive.
>>
>> As for the use case: on IPQ5018 it is booting the SoC. With the clocks
>> gated after probe, boards hang within milliseconds - 100% reproducible
>> on some builds, before userspace exists, with no consumer anywhere - and
>> the only variable that changes the outcome is holding this reference.
>> That is also why I do not think moving runtime PM references into the
>> clk ops would help this platform: by your own argument nothing calls the
>> ops at that point, yet the SoC still dies. Whatever the fatal access is
>> - a CCF path we have not pinned down, or something else in the same
>> clock domain - the platform demonstrably does not survive the gate
>> itself.
> 
> Once the CMN PLL module has been loaded, there should be no further need
> to access its registers during normal operation. The CMN PLL provides
> fixed-rate clocks, and its output clocks should be initialized and
> operating at the correct fixed rates after the module is loaded for the
> IPQ5018 platform.
> 
> Regarding the hang issue you mentioned, it should not be related to the
> inability to access the CMN PLL registers. The actual root cause of the
> hang should be investigated separately.
> 
Following along here - just want to make sure this doesn't get lost:
Stanislaw pointed out earlier that clk_summary can't actually be used
as evidence here, since this driver doesn't set CLK_GET_RATE_NOCACHE
and so never reads the registers live; it just returns the cached
registration-time rate. That seems like a fairly load-bearing point
for the discussion and I haven't seen it addressed yet.

Given the hang is reportedly 100% reproducible pre-userspace, is there
a concrete next step to root-cause it, or is v3 the right call for now
with a follow-up tracked separately?

