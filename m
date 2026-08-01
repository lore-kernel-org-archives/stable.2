Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B20345EAB
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568181; cv=pass; b=R2yCv0Q7bDWreiRa0i1IGfq1aL6KeKItWWJglKYOrMZN1QCX75J4HfzEylzMU82SMv7ZIDCrE85chqye8q6aP/ookmcKlhosDmeQoC40yNbcUzGEkz2gTlTHq800iu2c5826wdeVdjRpUXd6iJenWPYJuVzMpFLKyQoe9hmhOEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568181; c=relaxed/simple;
	bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYMPxZKPk7WgPRTVTR6MqgV202TBp5Ogbdo5jDv6LBekz5fB0aLVIzD6KV62yZvIfq6wckj+o3hN8hKMCKvafv0NdenvvW4ypsBR3DR+Mao1rKazHpmeSI7buhUjpUqwumHqoHCISYCtjG6ii44gfEuDRLltmS8wbAkztrXNPHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbZ/nbBu; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbZ/nbBu"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69848c9462aso288034a12.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 00:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785568179; cv=none;
        d=google.com; s=arc-20260327;
        b=Vits5kL7ic3x0qKwr1POdXo7wDq6p/ZcMa1zx1bG8YgUVPBk41qkajrRWDjB/QBSVF
         qKJdWQluf4ueBnXrohddF/g/SjFe4kPNAff7mXpvAkLS55N6aReZ2VhI+gYfn8E9OG8U
         qox+gHkSa+MrR5MR41hM8A6ZiesqQZQ8fFpB1BUns3dMf7fZXLW9te8/LK/Ep4u4FxTt
         zl84YFppgoa9Rndpip/mefZqF7cTVpCprbBh+XJ4OebBo94llelMX3+pRHESJ8RlWSoT
         2uSVlMsgwTksDPhWSdnxMAWXkBNkgK7o4Ibo94XQhlkDkczO2zlrR1yikne3sVmruJ12
         z/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        fh=kGtlxGUcbb50IiQQpm8KhGRFT4uhN1sLOH82eDfP20U=;
        b=bj0IrJM1raWOEPycZiyjBcLBx2ozvwXfnNcpBi+TS8d2kX2T2b37h1HadsWsOQv4Bf
         AyuMrAUsuNNScX7pWCloXrC8qEgqfJRV+vVC8MDSNssWggXPVuPo1kfIJtXKi6dLkD69
         EAjA7tjO/kFghnhWw+tlldGmS2niVd2ZDQgDdU9LOCaB6G8KHpqjh4FUir8hbP2Vj1QF
         N4dHanyVGDI3Ly/rsYKNj4juY/Sx+Q0wqQBt5IB0nR9Jt6GyfKPx0+xwsZHyo65F5Tqd
         GunbFrmsP2xaszjpAnEG20HVumnZNSX9ceMB0HgxcSO2Jbd4q9o5zK1iiKvjkmot0z4/
         eJyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785568179; x=1786172979; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        b=NbZ/nbBu1y50qgiqWf3daONzVPV/aQ2PfFZxQsHZUkPq7900zEI29RzYOrD5FUuBrp
         Boi6gOkVBmdv24qW9EhRk8WJjQTRGGKiaFPteRtgxcEkqD9OTHpxO0e+5ru8F8eGXqdN
         VHXWGpwPDHFmyTKVIvlEAufxy3dl+7I9URK9L8yNZk3cruz89xN+bC3KdwOUOIpo8Q9u
         rlxnfebTRWfJynwMdzQYApF8VIXb3hu2mUxS+rhEy0dVfcp6qdCNSTpZMeWKwBB96L1h
         wt7/8YV6MdzeU8nFw2WAdxBmOGMJC5yuaEhnNR6bs3/2zUujDF/P4gWij5cT49je+Uhx
         LyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785568179; x=1786172979;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        b=j7CMMz+wfEBLLj9M9dQOkUcw+IfYDO0bjNu0P1n3brj0WzrIOaSjH98QWv9IFvkn/b
         J+EErxlKxTizK5hS8CrQYv/VxnxCyMn66/QVl2IKi2IIlnLnqC6TS1pzAQpvbGowtJOx
         +SJDabkE0YfrjuxcKyanTUC5b1GUtz6Nd4YnuEfDyk767nNUMefn3xuyYmJFH/yLOQEZ
         LmXs2Q36SWA9uNC5u9gpD+se5b9OMJf2MyBhEl29yUvey8ZwbJOAcaRdtqW1BeE1hmVR
         ZMoOLmxTaCfSX2GC1Mhi3mjXy9Q5WO1f0x/+SWYxMqXzteU/sk33ZOtktUQSxgOqtzaP
         +61Q==
X-Forwarded-Encrypted: i=1; AHgh+RrPNqaUzbf1zKQAnoROZqd9N++MRihl21/4KZTD0iFDlo++anbWmwVQNwxipV2KXwGSn4rD5TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14lutELLMR8dIIXe8vZM+KU9AYMJtZR7e/OdBDk4+mY7fstLn
	qSyfL2B4xvvHFCMFxRs3FnUxnA+O2RCanulTbbnFCH9tYRDjQkFoL0kRWXJXckAQ4hoi1JnCYuk
	HX6bUcOmDm7xSHmVtwhSWpmGaHL0NiDI=
X-Gm-Gg: AR+sD10crOl6eEhlJt0n89lDNYF41CnEPUTvGJ9cs3SC+x0obnyW+c2vVWdWX63YW97
	Sb6pyhurZsVmF0sUivbJtL9LoFWByrtIi0zFpZ8MGgmV54RamchFYXSEsuq7+IuINFRAcw5Aruj
	a4qkyS5yjSXPVpyNY3E4oar+IKBJjlxehyF3QgIW2N3JpTB7qVSgF4Fz0v9BYssH3u3hv5d1LUN
	LGRoSuusWyUR5c+Fw0snZt2Diafyhp9hFtzyN91OmohdRdJJ9JU2wFxgrVKXWybrEs1rJ4sU6K+
	qulz27hA2u6pqkFCVMZgE0gReKLcrgL1SGHJtWT6Mh+CnrOFY/qtP1FFtRKP1yNIBYCzp1Sokw=
	=
X-Received: by 2002:a05:6402:3225:b0:69c:794d:4866 with SMTP id
 4fb4d7f45d1cf-6a0a7cfa5ecmr1146962a12.4.1785568178487; Sat, 01 Aug 2026
 00:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730092331.2069741-1-nicoyip.dev@gmail.com> <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
In-Reply-To: <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 15:09:27 +0800
X-Gm-Features: AUfX_mxuzcrXs9LVaK8RQ1P98mW6v5EMpHWj4MnqI6Wi_83WEfb4xA_oCB8RnfM
Message-ID: <CAAo+4rVpfTkGL39Od6NM03bOCoeJZ5dt2R6bWR+M52-Z7FP4rw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for your review. I have sent a v2 to ensure
hci_clear_event_filter_sync() is called first. But I have not got a
clear way to solve the issue without iterating the list twice, so I
just add a bail out when num_entries == 0 to skip the second
iteration. Let me know if the patch should be further refined.

Best,
Chengfeng
