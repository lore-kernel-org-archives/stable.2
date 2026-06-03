Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0625426ECD
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505180; cv=pass; b=p22g4lODHwd49dqUO13sNSNnYDoDdnSbaSOGtZhbWei3Saly2kHPNv/zG12WTlgDucu7gxl1izuzq1ge+aPpKqEG5fh3Qrra4/R3oFRl2bI7Hl1tu9tS7lyASeClj3I7iX19ouAlx5Fh62iKZStyFxJuHBtr3cCxIVm5jOVVfYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505180; c=relaxed/simple;
	bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCkNR1vyyWRbmzjJriZVUNueXVYLIO/H9ity033e2fQrNWUZT4781mdN9NA60Xj+KlekLX96oTFDrccWbM2mDP8hQgcN1JrhJTpM4cqzAOEgJfQ3wkd00a8trzaWHvKwfEsX6l8QUNsAdxcdWANuM52Mz4MCITSVgBSTvdL5Ytc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=g5H2IGOl; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="g5H2IGOl"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842358aaf36so1714666b3a.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 09:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505178; cv=none;
        d=google.com; s=arc-20240605;
        b=HLPGzN6C6OVqU4wJnpQvBJciQi6Dce2dHkvy/6axlSm0tUq2cDMPndfNPrludndNqm
         H07p4D/HvTQLg1EsBpBZOPxsDHw1HoZGMWlnzWjvC8cTaOHfmQnhQyIc0Xu26tJKkPJ3
         9ThRPfDvJKIwj5ztW51OyPkweihBMJQ4tHAMytMdVwcgdKQi5eTe97RRFRYfHmE2GRoD
         HpT6gDPPKOOz7W4tpKg3OJHC6ri79fJS4KVTs9EQFkKvRBTcIrYy/5VPbBIY64UTqrGR
         PkQYrDO9U80cQ+pGSw1lx7fvjlpYDqBnnvhXxe4CfZDARmN2Md4luX9nffVQDc2CzKj0
         UIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        fh=xeDP20VsG2eYVjJd0SCS3agZoqScq8oKt5mk1OAXquY=;
        b=XbF7Y/Tv3qhOb0KE4ouQVotKdh5Z7o188MQhHoT1mtmIGCyw12CPqpvZunJZ6zh/S/
         ID/zWna3YxgcVmSbt3oqlv8+nV8lHXE06j9JOJWpKbOnIWCAyOcDCF4BpMy6o8/iz7+r
         cO99Fuza56jK/J/B46mp5tM2JpV0KMagbIeXEzBLI534yxUrQW4TZtzP7rbAipMMmheI
         xbqcGpF8JxJnYAG/AUS5nzX4gZx+rfAivPGg+ad0WYZo0lg7pF6KIXChAE6/6Kd/xhAp
         LCn90jg1pxIn4ywThNYWbFzkk7bplk33nX9HhL6N8soJu+WUhWlj1h9fmRndoWfEaXKp
         37mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780505178; x=1781109978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        b=g5H2IGOlFEp1b0RLhwnJZF9eCEJ+q5Dx1yXF4vPWLYSFhMU7NSAh5BhhVuSxeogr27
         XoLaaBo/Lm/rHJ+OvTXZSwjLnGKkDEcc9umGylKIWay3Rp+1OWqt8A962+QGj0s6jXbG
         KyV7h632oF8doijMtIcLNqP/xAoURi3Rdz5TIL2FG+7CoYIo+4QO0qC1qiuxhx+bbnmU
         cwkVjfvgvaZu2OHCm5RiI15kq/Iey8FaewGkdgRkqPrCf0XonC8K4q7wxCBeHR0UTxXa
         jDEDNhW8g+tplnXGLgjvH+r34Juh6AHabyqYr+3Yz57Bl2qphRuj8a4LPAbPG0RfXen5
         deHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780505178; x=1781109978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp0RGi5NmaP49iEYxVtxwSOEg/eXQsdxe/qX51EHsAw=;
        b=E6wn03gTF1W5495SnHSkTGOZVrue0UJLTbZbrjouXL95cMW26y3hFSL5r5ObbsSZEa
         2B/67b/XjA/xmMJDZCSGtkkkE9bCqYF61I7kTJol7Xf+Zu5g9rYhZJieLPinisGS4682
         MzUyUjqDhhUiuo9HrHZGgnSZ8v2XZ4dqDXXx6NUv1Q9ZbWqebk2OWqgDKSiDXigCB7oa
         mOjZAez3QTr18ir9cSWe6JMThYe7CG+WUA6d1fIta+lbaq2JGq6z7KEPu1TMSQeiwUnq
         5+3PXC6XO3Qapa9fUtyqsx3teBTmwLwcwZzL9SOHlw/mfhAWb0AtNtZyDloFcvVltjNx
         5hJw==
X-Forwarded-Encrypted: i=1; AFNElJ9OEH+V5uOy9LB4pnWymTa/k/VqQqYtamPm7O/InXprybyO8sBHPeo8xdyZHKKzBqjeGF21FeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoWYDR3TqdFPqX+h2p2IKqu+ALqqsvOdjLMZqeybE7kMJ7r1L
	aY6DZjOH7hUAvxkb06Z+Q24DJaEFmDAhPbB9BGzh1VFuS8PlJoNT0lyd1/zS3K8pPHedT9Q9PUH
	iNVbw5uQf5pDtNjEQr8vWDJvadusGBrWX1CJ79kX+G+Y=
X-Gm-Gg: Acq92OF01/ekA3cdnRvP7kuP3dU6r539JX2OOqHiyuo2kuNo0+nlCMEQLMTw5MdqNH8
	GLkCGFY5fjOmy+x2nQEnhhHjjEgvt4tISYU6ionv6xMmj4LlWGt3jt99E67k1d3h4fJHH6QPXN8
	Ek4a1HUoR/DrF47D3v24F7Q7kKSf3nDx4zykYW/kS5APvBATqBeogDta+k5+MkF8slipw7ZKodD
	eeRvocWhCCdUOIhr31J1hvXyAR6JSMGvm+kow+C3TJ5XX3ZGxCjah48JZf3RJt4c+0tRQXMdY4z
	rQ2U33QJC2XabPlp8xbvvIo0yndUtlW5aOfGdpdevCQt3dTE8u+h/TsTzzJiNdWvO0bwlt19zF9
	VQ5WIrQ==
X-Received: by 2002:a05:6a00:2e88:b0:842:1ffc:55b4 with SMTP id
 d2e1a72fcca58-84284fbcdc1mr4542715b3a.36.1780505178146; Wed, 03 Jun 2026
 09:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603141355.68156-1-doruk@0sec.ai> <2f3ea9d6-a483-427d-bf81-ff26627f4f1c@intel.com>
In-Reply-To: <2f3ea9d6-a483-427d-bf81-ff26627f4f1c@intel.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Wed, 3 Jun 2026 18:46:06 +0200
X-Gm-Features: AVHnY4J6gY9pqDSXMaShzszHsJrbvb7KD7f_CAT036a599QygxqxvS8l2JPk_5A
Message-ID: <CAPdMp1r_fPeqHC9LeEek2+u9JMma_h+qtg=CoGs5Gpp+QL8ivw@mail.gmail.com>
Subject: Re: [PATCH net v2] nfc: digital: clamp SENSF_RES length to the
 destination buffer
To: aleksander.lobakin@intel.com
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 03, 2026 04:28 PM, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
> But I guess it's not needed at all, we can just silently clamp such packets?

I agree, thanks for the review!
Doruk
