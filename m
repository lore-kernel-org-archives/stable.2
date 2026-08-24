Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85232E12E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600937; cv=none; b=a/2OyhvXPXPUagXLu49/jPjv+4yZg0yZef5SYq7Qjof2XJhwq0/RE7w9GbCood9IGuRXT5cX1WcmvmyihimRDC25WLUrmX4pkqvD45vu+QPd7lB/2SLKQKBYNT3iFDe1PgfdRa/UsdIHGdNWLL49BPpGWfUwJzP7SY6393Hxd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600937; c=relaxed/simple;
	bh=jG6rlCttz4zfS3cypQxsfUVtISfDgjFUmP9l8ju5kvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaiDLY24sxvS1Vdi+K3HNCcOhygGpYZti7ZvmCrkTvbyiD4S35iSjCxQ26TWZUiYetSLZo/yHFk4ifYvWL9r1C/FqmtNUXb2q1sDxpQn9O32UMxMfJ5l+9TtIKDztS0VDrYVzEXIHMv9yNLTUinHzdfieOiPm7v4Inxdog/x2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o2JNh/tk; arc=none smtp.client-ip=66.163.184.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o2JNh/tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787600935; bh=jG6rlCttz4zfS3cypQxsfUVtISfDgjFUmP9l8ju5kvc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=o2JNh/tkMEsZR3KFM89u9wI+CApx6x2wRY9G3zUHlXDqR4EAbyyiV+7gGVvsd2yxw+KeqFV41nDWIEQJ9Z3mkiXZ7umC/HXYnY4ugKM+XO05AM3NbAubY2sG/JErHJo4fI0oyHToALfPxwr8xz2ZiX+3utwTwpceK3RhSiyGePr926ybb+9wjbkQ4BQVSGciYUvWPwPiNclw8hZKm/7Hl6LefZiybS8K+Jl5zcyddKlRQKUfzGsqR0Ce7OYjcZh4lXMlA9GHHFD/MxaO5ysiOpXxOcBS7fhalYY7/MVgzY9P51absr/R/uD+TXg1kpmvEtmjDGrltsyfUxRrQ+hVcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787600935; bh=2hPAeluHvJ0H6/F9PQzlnD891uV4YY+ZM2lSgOSqI/E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dIrSfFAjB63vDEX7SA7Wen4KsqKvJ/ErRmbAah1npLaXTeMMaJV99AN2ydXrh2VHxayoTBJapGF4RVfOPLA6oILY8Oh2Zdi2AUiaWD1n6IucXC5HQmsUuIzPfrGOw/4KYp32X3m69NY+yl+OTz7kFzSYb7fPtr8Omuef3NzLqfFZbSkUJqtk5a0eGgeRONzNOFkRq9OcO9eiMQz+dbsDiOsVlIs73uCTMg4MFG+ZF/kPl7rAIWPQEXXj7HIYSKJtSZASV1DxVbrrnYLTONuMuUj/w/glUPdWhvn/47n3j2pXd+qGA2iaS8tnKw5MVmztu6LfkU+5Tde0zObKD8Kckw==
X-YMail-OSG: .0qRR40VM1nMzXmVXcFsRGNO4RmEkFhJGKHG.FzpWuBs68wqW8KVKs9MOYkYp7T
 OiMYBV_yd4C_6whhR9derhmCAEOk3oqs4HDjnSJF8ywermGOOihRjGcOep6rWtkNsmOg0CqV2mB2
 OwKY10qyMFbTX.Upx6yTlQ0qKHeguRhf8fNQ1TtE0c_BfibyTQlFZPT5GSmfYCUAfzfuLLExdWrs
 UPHXf8jZ3lpAutznWhVAzcclm9moR72ol7n5klbawAydrjeJYGthuna26qNAQZCrNRjbGjhHvsNa
 B5p8nmh5OgJfIoacTRHE3IeKPPzPp25HxwUkEoKund_qaUeaB2ypNBtsUmHwMEdhcUCYWHMYopLc
 59tdfx24OQOiXlKaLvw1CG6OwvsaXxQfslhtfdJSlxEVO_vWXC3ZIamo.VCxxtlq.MJZ_F1Tezfm
 1zvacVOIMw7iy9oFW0V8epAH19ZXGy4Gk.G5bnuUoqjZNCZr2RHMBjyjFz4sxVUb1KnQtMt0_pkV
 FTpyj7DdrCF0h3T80T0d3zO8.2za.s8MstHHyG_1RSy1ctJwVHScsReQ5ZGucoxGJLYvamAstDEw
 TjokSAD82Z.xDbRhnqycBea9gNplnSKuvTvO_Kkqt.gbNBw9yOB0n1QuO4pLmrs7_fvgONYKDG34
 BigX0kolobw.YMx6vH6Z7YhyOQMKkVl23HTACyEsSt0U.tys7ZSwMG2puTvmF1i_NNqj_KvGi21Q
 Yfk.l8svbcF3LN5mjIG4uck6Hz.DJXC.acPJlUVinLfMNdBvPzjKbqF4u331ljWHbSbWgcL17XJX
 .5vVhBapn2vVzDNrNlFNFAHUX0tYAKDiabipKsN4NPgvRCXYCfhJblPQgd.d9tR7ESDaa7xDGqIe
 sWJ3s6Zs9RXtHac9fevdKaBVAZmtHKSh0mMwvtiEtz7guAzFeg1Sa1BSdJQfUWH7yYTyVwxnWsE9
 aa0fXKWYc5iOkj7rgsXHc309dhWW07SNF564tGAR9PkBlEm_J9iRf267Dr4I4cM8Ge6jua2ANwCw
 GmKhWkmHXMkU5QLftB01JZpkFaRA_ua42AhJS_c94fjYsj_4FCmPf2wio.ZGvBk6adnjE5V6ViEm
 J0vu2bi1aAE8jlC9IWB5yf2W8j_g07UQNKEjsaGZt2i3RsI.Q5G6lag3ARrIRZc5Hrj5zarUPB2y
 z6F5jyxVsf5.WY4IuxvDHPZhFc8ndf3e71kpR45YytIYk.aKAt.RDy1Ti6Q0D34zDKrkr_azLxVd
 EZP19BT27QZK9AOlr3jtOxmTfvHc7i7raxq0W2S6KAL3FB7aQEvQS6wbIkuykAbOCZSfR6xuWUci
 XBk5WG0o_UE6QpW.HsVy6OJMgfUGVPSLiQEIkkTpW50dI5CFWzaw0xc2QGJf_hY.y.EZucusD4kp
 4Z3HHdZPMRBFroZ3c4lHHt2ABlW7tZ8XFk0hxxCsBgsPQI5_aBhULgoIOJhjhhihqFrjB7se8qyh
 4ATjbcE9eun3HVJPpa0pTW6WbcPYqW4pnD_3c9SCp6NBHx8R4zrwjmDSeEmoz_XLo0viIQEF1toJ
 b.NIP26BQ7x60DHqGBcOTMGpRFB8pRowhYAt1H1vyo5Bjv5Z9scX9ieGTiikJqh07C2QOlhfhc.Q
 AWVlvkQNnKJoN7xjt8UHFNiJXr40zGjOLwx43SmtD8sQyhYeEwbwQsbI1_TePtpw4.Af85g4wbp.
 liVRFDAEFLFAW9T6L5YZNqZFH9JZxHdfRLDINPN2qQtl7BU9Xvuxy6D_meWT8ZupEtBpPlHGJTRL
 epdXkHnVqKFMPVlld33H0HJy8ZXaZOFJgdHnXLqDqJev4Pqkhj3Ir2QIYg0Ue3d0bNr8ubczqe4R
 MMBP9oYU4A7XwWmmVXruBlE.ZQRBcx6qakPmWUMzOBqpdllj.G03gOaiBNpODz1YgqK3PZZwiG8G
 nG0DFBxBj1pWP2VZsuHxZCh0YcnozHM_SAsJmLggpbP9MD1pGPCvmEzkOi5Fo1wAxeIWkptEAID8
 ejsF5vkX5349M8fuqo4_NA8iZsUPtsivsU4BDnTbdymGptlc2E79325by90ssFjz4HN6eWTzouvi
 E3ftrUS7Mpwk1BGrGAmi7efNJfEbpF_bDNykNz7i7IbGRe39IbawdZ13TPpW9h1QrjNqgmXaVlbu
 J6saY3ceEuVSYyqnb2t0iTpAxcOzGHoMbmTwNdSSgaL8MCPlyKlHLUQ5PZekcgozv1qyNteQl_fs
 hLMqJbDJ2v2iKtHSepY0QHkilz9I7sOCDHoJKVAd2W2GnCoRcSsQUpGynMTTiU6i7UGbe32KijF5
 yTfJZeTAdNfu40bpbYMviU9YemCEjoc6flJgY2nP.ZA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 3ffb26c4-2b83-4bfc-aaaa-fb382edc7209
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Aug 2026 19:48:55 +0000
Received: by hermes--production-ir2-cddf86dcf-rfhhn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8051616196a71b1caf318bbe8a22d6b1;
          Mon, 24 Aug 2026 19:06:23 +0000 (UTC)
Message-ID: <8a3f22a7-43ec-469a-a1a7-3a073c24854c@yahoo.com>
Date: Mon, 24 Aug 2026 21:06:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Jie Luo <jie.luo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Stanislaw Pal <kuncy7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260730191353.557494-1-kuncy7@gmail.com>
 <aeeeebf9-dbd4-4f57-847a-5f495b3236a2@oss.qualcomm.com>
 <20260803091003.15285-1-kuncy7@gmail.com>
 <8af46926-fecc-4396-973e-2290ae285998@oss.qualcomm.com>
 <cd5a25ed-76a3-4f1f-b924-06bb685ff426@oss.qualcomm.com>
 <181944c2-2484-4384-9c91-45cc87f31955@oss.qualcomm.com>
 <8286b42e-0314-477b-ac2e-4b410a97d833@yahoo.com>
 <f8b9192f-fe88-4a8e-86f0-6e2c33ed3f31@oss.qualcomm.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <f8b9192f-fe88-4a8e-86f0-6e2c33ed3f31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Thu, Aug 20, 2026 at 01:39:52PM +0800, Jie Luo wrote:
> As far as I understand, there is no expectation that the CMN PLL
> registers need to be accessed after the CMN PLL driver has finished
> loading on IPQ5018.
>
> Could we identify which module is blocked after the CMN PLL driver probe
> completes?

I don't have a captured trace to point to — this was found through
code inspection, not a reproduced hang on hardware, and I'd rather
say that plainly than overstate it.

That said, "no expectation of post-probe access" isn't something CCF
enforces. debugfs (clk_summary and similar) can read back rate/state
for any registered clk at any time regardless of whether a formal
consumer exists, and nothing stops a future driver — including a
possible upstream UNIPHY driver — from calling clk_get_rate() or
clk_round_rate() on this provider later. Leaving the AHB/SYS
interface gated while the provider is still registered and
advertised as active seems fragile on those grounds alone, even
without a concrete stack trace in hand today.

If anyone on this thread has access to IPQ5018 hardware and can
force autosuspend then read back clk_summary for this provider,
that would settle it either way — I don't currently have access
to test this myself.

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

