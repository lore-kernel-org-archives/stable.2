Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657720;
	b=DNDsNEtJjR6RYaoi959CIhEKna4vvzlt85JmxjbgtQBgVXhPxYlO8tQeLLTmO9gC8urm
	 LtzxuehDRkC3NQXa11ArasoMtLIR+YR3u3902XV9omwH09yXhjFih/SiqDebScs9BbcpI
	 xByyBdYBFushOhP3aEFaQWj3MFKzSJ79Pra34d63BeXYyV2UBU+fvSbnQqsGj0V2yYkvR
	 Ujz3oFM3+6RT3ldSJ5WLVCI5GYQHKdpb+9743iwD8g/HPfH8HODuRe9632l7jnVfL0Yoi
	 r3dn2aIOZByRjdvxbtcDfe+f70g+rTLtTfZoLW0/mYLzOmj2Hpn/9Sv+uVcapqi9lhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ShyQmu0ddnJkdrSZothJXBYQH0ElJQ6+WmuFcfsJFK0=;
	b=mpWVL3lWIJqVlKXBVFfEQPeVfpMMKn+eu1Z1dppJdo78r4vRSjJrDYvzdejt0lbJmo6H
	 1Su06jAY4r+y4AcUnu7V67DXnvlaCVFd2vdXgP2iOxtNXblaLPqiKwb8GXbDSxw5cq4KT
	 6wPlaoBrjHe8zL+k2/Dv6wIiGJv0586S8nTWJQgwVuMQQcDFuGPiNzjD8QoynJf08j/nl
	 ZdobxdnuLeaC6fSpvj2jjqAQ+ptpB8ZqTkNA1KobJinpABNpXde6u/52PphF7qt9iTadR
	 sc032sFhrwKc9Muq1J2VfHiI9O+ttAcy/QGwMgYp00a59SOfen9NUbV9kDHuBa7Vm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQSzxchW;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4A606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DE4A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQSzxchW
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9495d543b91so392288085a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795657719; x=1796262519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShyQmu0ddnJkdrSZothJXBYQH0ElJQ6+WmuFcfsJFK0=;
        b=hQSzxchWLCNm4jB8simRGB8bDBAlY0D9Vh/YLFVYubFLqvvbO5kQsiKwyECCuUcXUh
         OT5CfaXyHJVzxBIEv3CHuZcLcUYu6EbR3hwY4vD0U3mK5jd4FsXR71vidJIRF6FETUgj
         pZO85ubHxTG5dNZtimvzlxV6JFEOoRUctUhcsJnE2p3wkZV5RQ0VzIogJPIuvsOJHSXx
         5cmQh40zbSQXBHJA1Wp3qFYp4fOxIJFfVkm510sE0fsIKh8Y1zLt5cUeS4xjfpD5IChD
         O+3aZmS/IQwM8kpfPQ+Rs2iIIGISCo0A695Awspu82ujSfzWMjm1XeTeewLZapku/tRN
         hbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657719; x=1796262519;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShyQmu0ddnJkdrSZothJXBYQH0ElJQ6+WmuFcfsJFK0=;
        b=wYHpsmxDPIQE156an+PS0uF3UB+CPOJieWXbJ3i9G5HsMCJt/B6hU9sy14an7/M+1x
         YReAwXEgfehPMquDbuF5M3fJtmGNeUvZ5eDBPMJALmuWpgvxU6m6bndcSpLXMoKy731z
         MCyiFyAzcVeVTrkOMVrthO+fJcKmibuPjI8IFTnrOo5+xE5dpCI1IsryehaBwSdPoZmD
         +zuPgG3glxhlZTBWogwlu81Mq7qiCp7vOrHlDa2ggoFFqkvvCttucwPJqoCuXzTGj/IA
         Bnz8IcQCbiXfY2oJ4pQDFb17OyaSf6QgEuBEjYEvO6jMmlJwSO57X8unbPLQeV0wyYIR
         basQ==
X-Forwarded-Encrypted: i=1; AL+hErF62sQQXBE3CtbBmsD/F95gxelifF7aqD6sKW4m0IgBfD+4Q+WAni1ehczv5Uru8RpjDoic83c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q0L6knqvdKuJr79+2gOaD+Uji903jRyYakYkLR5YqHyeqUyjx
	ez4WQHYKUf4P7BcEaOHdNWz/D6HIj7ybJk9mmLn2Gl/ky6j7d1qspd6pNYSrzLy5ll0=
X-Gm-Gg: AZFdTZdZR+cMdnI3YiwlbsvC/eRsnlFPolNa8m6hxtQHuO1m+K/U0C2vyCenfBgeG3U
	xlXWr/LdWHlc9wbEHDjg54ws+iln1XTgHC9gLfjEZVT/m3kQ++06MoyZM7BJattRKM8jVTCDbFL
	U3rzgXyFoGiO2aSQYMVQfD8RGTJt9OddlssO+g3MnraZxSwikSWzoO0l5jm6knZsPnYEBDJhV3f
	4fjiPSpHLsDW00zbSOi+xA0gwXHvi94Q8qUeczPF4s1N/RYzrbe4nK3SJMByKuOaqAcaWuKeZiw
	ti8Rpcf60bmhA7kjOil/QEQsjdEIodpPkcUpWyVUPzZVMlRnWja7BoKFSqLTtxg7XB6/4v9GXuX
	BJwuwmK6BfhNDmF+tgXFEY0iyCx6vS1CoxzQdhUQwNQA+VOco3+4EubqtiVid6nTkN3phZRYgFa
	THZ9k6xkUmPHb3S+MFDEM0xcqUCypcS7yTGHQQXMDotZZstCb1kRMUJp9YZY0BCVh9IGFA0sQaZ
	tfOpNNfGECTOON/1F5R7J4dvk9RwsaZ9HUTm5hZ5+2Dl7MhRNZ7BoUWrpEAKrJlGJgM8AuCuNHU
	khnPxT3TK/aZr//E152xSMW78hVIR9FYh7eY0wxqaCuNCVBU96yP7q8GBV9aARxCfpHYCtM5kNO
	W8k4CpwT0mvzoCB8j/3YzHsvbqH7QnvQm1vJ5pI/C+4d+KjDfTwGU
X-Received: by 2002:a05:620a:454c:b0:93e:c12c:fbcd with SMTP id af79cd13be357-949bac7665amr3259261585a.73.1795657719106;
        Wed, 25 Nov 2026 17:48:39 -0800 (PST)
Received: from ?IPV6:2600:4040:5abf:f200::9dd? ([2600:4040:5abf:f200::9dd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41c105sm1476099385a.39.2026.11.25.17.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:48:38 -0800 (PST)
Message-ID: <3167e5ef-920a-4e1d-ba03-bc928687577c@gmail.com>
Date: Wed, 25 Nov 2026 20:48:37 -0500
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
Subject: Re: [PATCH] firmware: arm_scmi: Don't mark OPPs as turbo without a
 sustained frequency
To: Dale Whinham <daleyo@gmail.com>, Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Dhruva Gole <d-gole@ti.com>,
 Charlie Garner <charlie@akao.au>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261121-sp11-noturbo-v1-1-37e1083cec5b@gmail.com>
 <20261123-eccentric-ludicrous-roadrunner-0a7efe@sudeepholla>
 <CAFcmK8g+Udyp9h24WSEx2RepBA=rZpEQs==1hTi83A+_zF-GOw@mail.gmail.com>
Content-Language: en-US
From: Haipeng Lin <jimmie.lin@gmail.com>
In-Reply-To: <CAFcmK8g+Udyp9h24WSEx2RepBA=rZpEQs==1hTi83A+_zF-GOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 8:04 PM, Dale Whinham wrote:
> On Mon, 23 Nov 2026 at 10:26, Sudeep Holla <sudeep.holla@kernel.org> wrote:
[...]
> 
>> I worked out something very similar as a solution. Anyways does it work
>> if we also add the check for non-zero dom->sustained_perf_level ?
> 
> Haipeng Lin has an X1P machine so hopefully he will be able to confirm
> soon if adding a check for non-zero sustained_perf_level into the
> chain still works.
[...]

Confirmed it works. Tested on Surface Pro 11 (X1P64100) on v7.3.4 tree
with this check

	data.turbo = dom->sustained_freq_khz &&
		     dom->sustained_perf_level &&
		     freq > dom->sustained_freq_khz * 1000UL;

Firmware reports both values as 0 for the two 3-core domains (not just
the frequency). I took a debug print of PERFORMANCE_DOMAIN_ATTRIBUTES

  domain 0: sustained_freq_khz=3417600 sustained_perf_level=12
  domain 1: sustained_freq_khz=0       sustained_perf_level=0
  domain 2: sustained_freq_khz=0       sustained_perf_level=0

With the patch all three cpufreq policies are created (cpus 0-3, 4-6,
7-9), each has the full 710400-3417600 kHz table, no boost freq, boost
disabled. Under load every cluster scaled up to 3417600 and drops back
when idle.

Please feel free to carry the Tested-by in the fixup commit.

Thanks,
Haipeng
