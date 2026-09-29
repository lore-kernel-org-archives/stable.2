Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31333403ED
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726074; cv=none; b=Q0JRAML4cKlCmImDisbJa3PgYu3/42dyOBi3kZztRMwDi4AwzZnEr6KN0c4MPVUngx7Senpo34nE7EMsnnZULVvZeXNrtJ50+ahCaiLF1rRCKRPplyKnZJOFMESUx4KvwkQZVJb6OM0nxLpUsiNWHxSwkVS3dBjew4IxCCC4T8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726074; c=relaxed/simple;
	bh=chwdOE8qd1fjsktwegfYdNwCdSb2Xug6heoW9prIwHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qfEx5b45J8/kK80uyeOJIsv4O5aBNenrFyJ8AeSvRrjlWW9hysKQhDehFilR8SX2PpQrm0m/a/3LLTwnAdoJcwxhyMJ3cW0iWxssU6T7Gp2WsKS0DGqi7moGR0Lt/4pzjqwjo0n7yV3I9QC0fJrp9rKzl90SNEDtRjr35e/kH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRaSwvTo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRaSwvTo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso25103805e9.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790726071; x=1791330871; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J42GTqlEQ125xUGDakZWJHRN1MJ9s09iVMsl0+Q4Mko=;
        b=VRaSwvToydKQgYAiXnot5Vz1+2RCwEVHX0hzBYTzJUG2LNEnzX5bJorfCnuI+K2wn+
         U1R50zP735zJgvp/B7yJhPQkmNez6YKXF3zdb8v7Ym52XfNmvno9sLfff4KUbO985RaT
         DkMJOsMkIzu+U0jq8Hw+t46rpsrSCS7BmZqcQH0SyQuaRgXKWEjiQ7pXnLRB791ZJJEr
         5uZESZq9QrojCs0oNgFhhkiK0zkrV/isn0Wxus851DHIJojMNMB1n1EXHJ2cs06frXXp
         UhzdInJqlYOeC5V7IfA7NQSk87MkVmFLsXed9ECd/Mtg/b2+iVdOWYM1ZNBJadx7vjjs
         N+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790726071; x=1791330871;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J42GTqlEQ125xUGDakZWJHRN1MJ9s09iVMsl0+Q4Mko=;
        b=feiMcnLIX1nSL2n1tCjgB+RSYcK8vpRpUMO4f9TdbATYkp8QzlyLUeo99j6JOjHe6k
         qIFvha07ptTveou58mq8528UmmeFc6YhmvVxOLvqHKiuHHp/gaq6FkS38FcikhUFPXxk
         On8g4qUOxz2oap79FSwGH5xV+MOQlgq3mPlpL9jah5xOq4i0lkJ/KK/SmLWqITzUQ9Ck
         qkeBAB2w5JG1FZIrzs34bDjIvhADa7Ml81a+H62wE933ctWM9+pzwxmQIVmDSK1fez9p
         BkKlPDP2FygeKhpISWtkpYAPacl8+XuLNbNNg10tDYZcw52gC8iDdttqbyagtUenDTJR
         d8/w==
X-Forwarded-Encrypted: i=1; AKwUvBxexrCi/YeEjIecT9fBAPwd7ZQZne4nQMZQ7iwF6QzqF+0yU7QBNIriPv78fmMfCfh0GhJJpcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYILEsrepTjPlkfblDVU1Pj4hK7inaQpqEGEsRkppGaziImHOAUV
	Duy+2N6IVR+N1Yj9maDurILZfxzMLMctWE22ZFrz9j2sHJKTyh8IzyLRtsUYLF/vbdg=
X-Gm-Gg: AYBFou3JLLQY1mfa7HwCZIJxruCkubSiuDPCeodp7FKZv/q3oF4iNM4WQu632kNiwJk
	NHhv5G1BZt2ZJ0gcKbjyL6Ysm/dqHyM2NG104MCDPOdMpF53cllfXzE8c+ABOJ5rgh3saPZ8y3z
	Ew5nJRuJqZpiGjVzDhAoKV+0qUOR3sBvH1FBQ4+XjBffRJLEAi7fDKkStzeFN13o5D2WRO/W3aZ
	tt3b1nFRLw8ivLp9EJuf+hzzz8ftFM9iiOTgNsh7V1xx5AOJoSyVROgm6n0lJ9ySrxOwAHqQ8rr
	bU1Nyw5zocfMwNdMq//1IpHBZxeBAAYmRQoB6z6cuKJNDV3G4ZdZS1bAhS9OrZyDg2AEZZABlmD
	57n+9GK2MaCUdkWem8WhwWoFx2Ng9x6GCnlAw34Qs8BQDeJwdn4Qg2351CPVv2QKh/hjis95Foi
	mQqJCwpiYe4un9iRD+aK7A4RHDg8/iytrgJRCGn47nU/5aPzLrroGns4zQn8bybZ+I5bjeQQaz5
	HyPd5ANKti1ba1LTnKrAvIeg7rlKH7sUKRb6G4Ca5DnXRz4WwNuSDYFxVwxaE1EQxzu6A==
X-Received: by 2002:adf:e00b:0:10b0:48a:efc9:a076 with SMTP id ffacd0b85a97d-48afe9c39f1mr969364f8f.49.1790726070845;
        Tue, 29 Sep 2026 16:54:30 -0700 (PDT)
Received: from localhost ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe6c1260sm2324232f8f.33.2026.09.29.16.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 16:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 00:54:29 +0100
Message-Id: <DLS7EVJTZBPK.1C862CKBRDBV@linaro.org>
Cc: "Alim Akhtar" <alim.akhtar@samsung.com>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 2/2] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260828-exynos-pmu-cpuhp-idle-fixes-v2-0-06bce6107bd6@linaro.org> <20260828-exynos-pmu-cpuhp-idle-fixes-v2-2-06bce6107bd6@linaro.org> <dbdfebba-aa6b-4ea9-b4d6-5e0ef63d8716@kernel.org>
In-Reply-To: <dbdfebba-aa6b-4ea9-b4d6-5e0ef63d8716@kernel.org>

On Mon Sep 7, 2026 at 11:09 AM BST, Krzysztof Kozlowski wrote:
> On 28/08/2026 07:36, Alexey Klimov wrote:
>>  void __iomem *pmu_base_addr;
>> @@ -407,6 +409,17 @@ static struct notifier_block exynos_cpupm_reboot_nb=
 =3D {
>>  	.notifier_call =3D exynos_cpupm_reboot_notifier,
>>  };
>> =20
>> +static void destroy_cpuhp_and_cpuidle(void)
>> +{
>> +	cpu_pm_unregister_notifier(&gs101_cpu_pm_notifier);
>> +	unregister_reboot_notifier(&exynos_cpupm_reboot_nb);
>> +
>> +	if (pmu_context->cpuhp_prepare_state !=3D CPUHP_INVALID)
>> +		cpuhp_remove_state(pmu_context->cpuhp_prepare_state);
>> +	if (pmu_context->cpuhp_online_state !=3D CPUHP_INVALID)
>> +		cpuhp_remove_state(pmu_context->cpuhp_online_state);
>> +}
>
> cleanup follows the setup usually, so this function should be after
> setup_cpuhp_and_cpuidle().

Thanks. I sent new version where this is updated.

>> +
>>  static int setup_cpuhp_and_cpuidle(struct device *dev)
>>  {
>>  	struct device_node *intr_gen_node __free(device_node) =3D
>> @@ -458,16 +471,46 @@ static int setup_cpuhp_and_cpuidle(struct device *=
dev)
>>  		gs101_cpuhp_pmu_online(cpu);
>> =20
>>  	/* register CPU hotplug callbacks */
>> -	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,	"soc/exynos-pmu:prepare",
>> -			  gs101_cpuhp_pmu_online, NULL);
>> +	pmu_context->cpuhp_prepare_state =3D CPUHP_INVALID;
>> +	pmu_context->cpuhp_online_state =3D CPUHP_INVALID;
>> +
>> +	ret =3D cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "soc/exynos-pmu:prepar=
e",
>> +				gs101_cpuhp_pmu_online, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pmu_context->cpuhp_prepare_state =3D ret;
>> +
>> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/exynos-pmu:online"=
,
>> +				NULL, gs101_cpuhp_pmu_offline);
>> +	if (ret < 0)
>> +		goto clean_cpuhp_states;
>
> You have only one state to clean here, no? Error paths must be specific
> - clean only what's needed, not a catch-all with if-checks.

Heh, I thought it will more readable that way. Yes, one state.
I reworked this error path in new version v3 that I sent.

Thanks,
Alexey
