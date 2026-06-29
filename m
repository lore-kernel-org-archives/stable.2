Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068323FFACC
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735832; cv=none; b=dvkD5pLaZQ3jPXXWTNfSZvYLO1War97IYx3SAFrdw2ldZuWcTLirf5a/Z48n+TpOtbUBI4r08chpkrWPh5VteoiE4YJO0ohTwnWAfjfCJsmeRoNAJXumPD1GyO3VcaexnbmHog4nX4KXy/UoASn3/2YImCUiiNKllQ+U/KE7xqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735832; c=relaxed/simple;
	bh=JiweOcpD2gpG/D1UI6s63Lm84Lx/AQcHh2xZgunNp4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhG+L1VEyhOJD3RxDueG9A/mdg13XtGb8leu/uj+7r0hgi1FtTz3mXwJ8ctjuBqw31hz6fgbFSxAXWFJ9MkDI2cc/uvD13G6bGvG4woC51pxtgXiUHfqtd3JhyN6ApxEsl9Utk3v43dYV4BqpcWZHUFnfsSzDhgDe1RmLXIAUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=A8zoHkA2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="A8zoHkA2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso5881291a12.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782735829; x=1783340629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c42ikaiQsX4R+I2gt7m3Uhxc5QLT/t1/qPY6OMkStPw=;
        b=A8zoHkA2gd+dw7bz2EaMOpGNULqy3f/dq6uWhXmOlktNLWm5FeqC3PpkAMWQQ+Zb2U
         tFTnWzMHlN3VjOFU5QWdMpl6cAITVfGDXp2Nu+z7QQ3D5WxEKSUpzzk95Owkz/xWQ+z4
         7MquCn+Q4NhIaY45VknAtk9g8rUrH2m8WlZV8okOutHUoIrqOyFjvefn4CIWPkNvkxSU
         rrTkJUWOhOm8/x1Sd4HB0PJ4+7deHg+hpYzf1hjlC4BrGfFUzlcP7jaiA7b5fqdRbing
         C2LeDFwgk8DI9MV+tmgN0wTxS6BcaP4Z4QMJW7LX0cuPlaoYZG6Ju6LS5YqSr3SuT06H
         9GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782735829; x=1783340629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c42ikaiQsX4R+I2gt7m3Uhxc5QLT/t1/qPY6OMkStPw=;
        b=bMkR8Sulo1LJXgk0Qur1JQTa5ky5ZvrocPz+rzaW/lqQZle0vmt3aOsBn+UgrEB565
         7h1XFEzGlmueNOPX0zJl39K7jaVEONPR1cnVHm7J/TPg//x8KzzJYlkVNPKB3N5Q19zt
         VFWJQac5tJMbtYD/YQpiwbjQ1bdMwA2hSCF6aQbO+N4zy5NjfGMWDV0xk3MUqIPzsIYp
         IYwxchwkd+sTAVkWjQ2/SG8mKv7EXf2GMHxNv0O+Ai05NpfD3opxrtpcYSiF526NnPVb
         5Omqu+RN9yD2XvXp08nEgP5FrBD0EN1A/CHkjMhjHm3bGB/joFRF6qxnmJap0aA60UHW
         JZ3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrzYBoTBYP2X9cvxFIa+/emBmM+Wu6z/5i8zYq0vtiy96NruNCTM7YwpiGtJxaWb98CaNMdep4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNcGqlvba5m6tSpjoXbABZ5ZZUsZOb4YGK8db+DnIxm17Xe4c
	bJ3LwZkRXqjZ/sUi9uTMJJv8DWr1Gnmax4hAgB1aixwPQ4mOxoK5Vz3L11PjSBoDiIka
X-Gm-Gg: AfdE7ckecKt/OD2scZ/NAHFmABHkUN8QEIEwrsmWL6PmfURk8LOXG05Hjw/mEK4KNWB
	mvx16gJAfxD74cHsRqIoTjskqzJw1Jvw3OU+woMrckQagGL70yZV+XbME1dOi65FFZIkerUJYvo
	YJfPkPTumTaa27Y0iZEPQPg7DP160iuTOV2ThXXORTs/8ozJVEP20lJH7vrb4xx0rI3DFxgSlzk
	b/Gun1SoTXIesMzZRmZWk05qnyRtRxxWtSJf9odFhzxs4clvx8C3fAN8p68PYDazv29rcmKHhw2
	hCmLUq47/1s1EsxkrxyTJCNpgnofOLFMpLMbnpQSc8LitSBLic+5puITvbSZ3Q8HXRmVg4Fkpy1
	dZ/b00AqvxT9GQ4ih5f+sellXCovxT5toBcJHjSQDrbEQ8k2IIlWec4OpH1dO48EKKfn/khNarP
	RLzG+EBEESjgZCqc+IcX1ml+kbvZZemyf1fzwvfo5HWXmL6Q==
X-Received: by 2002:a17:907:d26:b0:c12:45fc:c25 with SMTP id a640c23a62f3a-c1245fc3060mr292629466b.17.1782735828774;
        Mon, 29 Jun 2026 05:23:48 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1256c8c643sm233359466b.52.2026.06.29.05.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:23:48 -0700 (PDT)
Message-ID: <edfa1b87-a28c-40ca-85ca-e11ac3482518@bynar.io>
Date: Mon, 29 Jun 2026 13:23:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] nfc: nci: fix uninit-value in the RF
 discover/activated NTF handlers
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260626090301.2139500-1-sam@bynar.io>
 <9f73948f-7045-4ef3-bc8c-731fde943c1e@ixit.cz>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <9f73948f-7045-4ef3-bc8c-731fde943c1e@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2026 19:41, David Heidelberg wrote:
>> Assisted-by: Bynario AI
> 
> Hello Samuel,
> 
> the fix look good, may I ask you to follow the Assisted-by syntax as requested in [1]?
> 
> Thank you
> David
> 
> [1] https://docs.kernel.org/process/coding-assistants.html

Hey David,

The :MODEL_VERSION was omitted as we use a range of different models and versions in our pipeline, making it hard to attribute to a single model/version. As for the AGENT_NAME, in this instance, would the correct syntax be to remove the spacing here (e.g. Bynario-AI)?

Once clarified, I'll submit a new patch with the correct syntax.

Thanks,
Sam


