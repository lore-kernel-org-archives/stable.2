Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71303E1CFB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677698; cv=none; b=gIi4IH+IyFWnSwGNjiXE0gLkCyWZ1NkArSbJRWcxglRK13RjrP3hhMazFzMbY/oEb9561OJtsxpcJLIwCNPOnBJxRXQVKykdqjy0ZGoUgLPgfrnOxsw40dJc2I40ROdo/YlaJ7zWU6LTY4qK3RhubPUvRI8m1GE+vNmQo2tSylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677698; c=relaxed/simple;
	bh=ihV5OQaoP6INSs81OrTckxcfcEXn8Vp2Yb3BUC0Q+Ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QAqdMMy2x3whLLfNgt1Nk9UJp5jNVZkQOqdw23jmMXwL8edZ6SxArCibH6ljxTS901q05ESWyNSN6oYOqk/MYKnFGqN/hBDs5vus9bb48q4qi4AGqp+qVR9G13A9SDog/4A+vc/zn+fPSkP10bTedMUwfpfBFlnKhlf3I5u3K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHK5b4vX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHK5b4vX"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2247600a91.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788677694; x=1789282494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C3R8tPe9lOjKH7p6qWRmtf7FvkJ+tCfMXgIaxL2nfTQ=;
        b=KHK5b4vXZPLdKdm82/aABRkIgKSIsefrvhCfViOHR2LuWjQ3KLV9b7HjMK1v9PqL5D
         VIriafVMFI0+XTo/xdhSbqYjY+0m0jK1bA33aLCIc0RgzNlCtbAenOkFDldj/5XGXimZ
         d2RSEotZsuK6/dNkMwe7UYcFTrSyHt48vOPy+cPojKIniCBqzDhJQAbsyr5PjIuWughH
         j9Oq4N1ZNAejzResRWo/2B9prPZ9N6Uui/6j6LeqqNiUBeRHG7DUkOOV0qtFlofFw33a
         bdCxWWnRqXs0Kf7kwK0ywbFOuwnDvxU/tGbLW7mCA7sNsEJONjwtJkBRfdzL/Iinw4lG
         yfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677694; x=1789282494;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3R8tPe9lOjKH7p6qWRmtf7FvkJ+tCfMXgIaxL2nfTQ=;
        b=i4Roc7vRx1C30tfVzupJh39wpIEAHfDGTSv7fH80lm6om0jTS2J81jhovXKc38LrWI
         0SvV5QsY/SU0XWLwvSBIRZOHuuJa4b3Ay7fBU/3YDdvVn5Zwp7c81mLqlZYkF63IpqNQ
         CLzfi3skWlOYTHALogFnirOXT5jlexiUiQ0AnkWu8XuYPhITDAGqf9nE2VW304J870bZ
         x716Gb2VPMQXWryuZeHtUSbHFpCMO0VJuHh3TOOJq7G5D4proptwG4bJrsqVSC7j10yt
         Li+Qs72FhVc8DwCJ0XFfcR5LEWr9YpJYbwzOsJ6DdZcBBSkUjn0zplXXSmrGDirzF0tf
         /dQg==
X-Forwarded-Encrypted: i=1; AKwUvBzHRk6FRwWCnXWg9RnGBcs/Zu+6OZQJhT+4TOgyBCvftl0Ko+WGanchfT+/jOCclgcGsh1BkIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kPuO2cVq2K8rkxxZLyF1hguPJf7UC9CGGNFmDOnVFEmYnzBHQV
	FZ2Wg/oWwO56MzNqb7R/dKELJ41whYaHzUKB4KYh9ju55ETXoaITofjd
X-Gm-Gg: AYBFou0BtoLfK3tzC8ehjlUjfgmllCY9xaI86Kx4XwJIuCVPKjzlK/Byvqdtu1HDBwS
	8grK/PjP/RimJe60aag32W/bFeBzqX3CSklYKgZMpxdDUxVdzVMOWmbE08nytOMsCWjkZP97jtp
	gMQ112EQRQYfd1zSzZUr844xI5DHD83mJe3Q6Z+RhxfY2CiUJ7D3ZtK+FZhcybpYXrnQxN2X2Kw
	rCQwrIScyieyEkiTU6Am8ssxFxyzCw+qJGQ+ERjUgc1mdDkzS1jwC7LbdzIBju372mkGi+UtkOv
	HMcK1E7/jM0KoFZzloWKqCRMYTsfEv29DRXwJVGC1SzmBLxVT4GLMlFs9jJBJR+q4ijiOMg3FQN
	t+9iWzi3EKnMMbG8FK+DxoAe3DYIPFVC4iR7Cd2LK6g6LT1LhT3IrKSuah0gGykEJtcyuh28ICZ
	JaFG3q/dWv6Ln8qlFViW3IxOle9CXBI57d569rAsPuc9gJh8tU0PMF9+Jl8bTt/a6tLhFdw3tYe
	iffU4IOiH1GLQ==
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr22897521a91.6.1788677694175;
        Sat, 05 Sep 2026 23:54:54 -0700 (PDT)
Received: from [172.29.66.128] ([120.236.174.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm22686761a91.3.2026.09.05.23.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 23:54:53 -0700 (PDT)
Message-ID: <4d101d62-9ccb-4e3c-a7a7-8d0c273f0d69@gmail.com>
Date: Sun, 6 Sep 2026 14:54:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhian Liang <liangzhan5dev@gmail.com>
Subject: Re: [PATCH 1/2] Input: tca8418_keypad - Add devm cleanup to disable
 interrupts on unload
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
 <apvip-xz2GFH96uU@google.com>
In-Reply-To: <apvip-xz2GFH96uU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

The INT output is "active-low interrupt output, open drain structure" (Datasheet §5, pin
table). With the handler gone but hardware still enabled, a key press pulls INT low with nobody to service it.
And the driver requests the IRQ with IRQF_SHARED,

	error = devm_request_threaded_irq(dev, client->irq,
					  NULL, tca8418_irq_handler,
					  IRQF_SHARED | IRQF_ONESHOT,
					  client->name, keypad_data);
	if (error) {
		dev_err(dev, "Unable to claim irq %d; error %d\n",
			client->irq, error);
		return error;
	}

this stuck interrupt is seen by every other device sharing the line, and may trigger "nobody cared" IRQ storms or, in the worst case, cause the kernel to disable the shared IRQ line entirely, breaking unrelated devices.

The same leak happens on driver unbind (I think it's a rare case though).

-- 
Zhian
