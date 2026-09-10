Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816226A1AC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029230; cv=none; b=s4vOKAaeyHbWl7YClQlHJ0RenxkCJy5K4w42zprWYGdpjP/Xd9AIQBZAJYTaEThPmKyVm9JJTubfZA4pMkcQhCzxBl3IELU4W/sRmhJeuSG/tAT8IxWTeuOlXqeJdb8jxjQMnr+ZUw7YFJ1CXnz1ege0EJ81vLs5W9B6NVPhcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029230; c=relaxed/simple;
	bh=HhQAnu7am8lcan+rEXFRV1oJg16AJp0jaoM8Z9/hRGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l510QRtWA861b8EjO/9gZ73ZDDxGWidWhJQTUeuY9C/5BAv9t60uxwjVql49RfNs21YN+Qf9AIo+HDGfTELc2hbTBYg7RShnViAK5+gi96TR5bqorA2A90vjp62ifniWiaW3MOUwWHWS4KAI/KX7tQVpOIqeBidO7blHFdwGPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JiunYuQ4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JiunYuQ4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so85897955e9.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789029226; x=1789634026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzZhRaUvpfNvfJeOcUe7YmDm/dB9ckW/oQNsKe9IOfA=;
        b=JiunYuQ4liDD937BhXd5a09tfOrYolYtaB5Rnh5uTGXZu5/PT+SAVvYx/1XNdn/jtc
         a8GbrlxlAOkdbzi9Z08tuVMQN5JpLxm8GGLGIpc/1Dtwo4nwUFl915ERAqiRpqfX1Gp0
         YylBGHNnamqT5GgSxrBkOdvJI7G5yDx1oCPEAOWA9dOM0ZpTqK4X8pavphCNLN3Iw/DU
         i1MesVB4IO0xPi796QAlx9ig5vPc/H+YZmO3aL5qGnSoL0/3Kno5rdTWboLMPb2zJ/1I
         vgs4mveLRQxdiK4XU5QrG3/gz/7njVYCm2aSprTaWE/xB/fTptGfayxBllfWy6iYuWP5
         5jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029226; x=1789634026;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzZhRaUvpfNvfJeOcUe7YmDm/dB9ckW/oQNsKe9IOfA=;
        b=X99LDBGrYMviYan2Ez6QAodzZmbROodFLnT1EqMLpIzs1Yx6RIFa94M3NVz6pmhFFK
         H7ESs/jLwpRjwUhYx2KA5gZxveCDRI/WZd1SCX58RDMxjlkXNKx6nRmKsqlCrNb5zHNw
         Kxaq2eZuHFBZPmRM8NkwVT9VsSVHJ08E/Qfd9TdDCvRcexusjiwykyQaJBK8G1+fl6C8
         URo32b6SOo2Bhm3ibT93/wvjIgC7XSYTgxPPGuGpGaTDcusJlVNQSgAP0okjai9R4vc9
         7WEESwLeTTNj/2U1tReS85887XvLFlitmtrlAaKrsTRjS/qDfWyhU+UT1PXkjtXUS0Jm
         Yvkw==
X-Forwarded-Encrypted: i=1; AKwUvByXHpMSVAUvYvhSPXpQxm5zJHSKnZUOlb83n+bz+15s1znZ0iH5gFNZWGV848NSI6Jh7f8Rijg=@vger.kernel.org
X-Gm-Message-State: AFuF++kGsg5ooPo0uBpk3zfdJTevataoxKbjOIbxIWHT+uDWRKXOg8Iz
	9GUvz3IOESMdK1VhLw9LfLRmud3uFIiWw4X8IqT8XCiLGShNUEwcBYWn8ifSI767XN5F50Z4oN2
	lau5Y
X-Gm-Gg: AYBFou1Xk07ray2M0Imj2f+XjiZbyAbH8vqrRACqt0w7W3UCz/IqbxFK+Rs67ZNZV+2
	ItOXQ4BQAX9tJR/mUQNy3oPkrYRYcPbF1cmS/1D2mCD/pO9R1b8xnfGTHTpe/PAd6juyqRPadqU
	7/9eZRgdrRlOUD4jCUJsAVZ7VE+zgFY+qoymFO1DvjFyB5QnDmafaWBXwW4HLGBAXIBYR0/+lrm
	9mKtzA90vRwEJXwgx5o81oRgm8EvTINwykZXTVPUavalbDPTJw4ZU9V+7P5Mv1uYz8hADxBjybx
	AhfDLy/xo+2CDifAofO7poxVfZXndYxhEvHLr2Qqy+/R0Ird/2EaoiSAf9UZVI+Hsj6BDVdKlAX
	m4C+/BqAlkxm+gDgc6/RDQNuBHF5BZRSJ30To+WPX5xN+/YviAAet6wtGWWvDVFAPxikdj3VH1J
	FmuJd4/WCe9E6ali8LmlOA2ZcaUXoUi9D9nYWLQgDfGuOr0CeeCmXvHrJljQF5e+nSUSEa5syfX
	YK6Hh3+4ng9xPIS9orXkGhu/683YSIQoL5BdDQr
X-Received: by 2002:a05:600c:354a:b0:49c:fc6e:8cb6 with SMTP id 5b1f17b1804b1-49cfc6e8f48mr375853355e9.26.1789029226295;
        Thu, 10 Sep 2026 01:33:46 -0700 (PDT)
Received: from ?IPV6:2001:a61:135f:1c01:4928:2da:9a39:bb64? ([2001:a61:135f:1c01:4928:2da:9a39:bb64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm43282065f8f.19.2026.09.10.01.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:33:45 -0700 (PDT)
Message-ID: <c0006a9c-7cc1-49a4-8226-2f4e5333a4e4@suse.com>
Date: Thu, 10 Sep 2026 10:33:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: dc395x: sync the waiting_timer before freeing the
 host
To: Fan Wu <fanwu01@zju.edu.cn>, Ali Akcaagac <aliakc@web.de>,
 Jamie Lenehan <lenehan@twibble.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260810055028.119525-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260810055028.119525-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.08.26 07:50, Fan Wu wrote:
> The waiting_timer callback re-arms itself and takes the host lock.
> adapter_uninit() currently stops it with timer_delete(), which does not
> wait for a callback already running on another CPU. The final
> scsi_host_put() that frees the host (and the host lock the callback
> dereferences) runs right after adapter_uninit(), so a concurrent or just
> re-armed callback can fire after the free, leaving a potential
> use-after-free window.
> 
> Replace timer_delete() with timer_shutdown_sync() and move it after
> free_irq(), outside the host-lock section. This waits for a running
> callback and prevents it from re-arming, while avoiding the self-deadlock
> that would result from syncing a callback blocked on the lock we still
> hold.

Thank you for the patch. It raises a question, though. Do you want
the timers to fire after the adapter has already ceased to function?

	Regards
		Oliver

