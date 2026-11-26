Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696800;
	b=1EgT/hIlE/6wQKFtED5x2mp0gT9QAufnQUnbIQ7mD19JEiOzW+7f5tOLB+pc8m8ODUZJ
	 dijnuYqsFRedeEZBb1+QtafBm/Drfw/IQa6x+ylukkeFeO8XJIkbUFDfHonpZEq5F9rC8
	 pDd4+419bsJ2Cx/xz5TqHM3ZbWfngT8tZjsyASvk86cI10f2qxiBiyuBL2Zudvluw/45U
	 dmv+iIx9c/WXpNGcTNH6kCh47xRhq+KNcEfuxMzFqb/BHMRS3XjKxaf3NY0x2ShbDBUl3
	 fcnGjkfTE4YD/csHcj0jorHqDSOFpJcWenSfUGdk+y4pYDg06AuxHY5cjm7PdkFC3bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qPUA0tYF2NIjDvPMT86AcZAvNEU+x6KNl319uLJ1Bcg=;
	b=RtMp+HIWZAeblAGMfPX5U2YVW0Sl83qAFwvpcvGAk1dViFgI51BKPqE4xgAt1zV0zlSZ
	 DPYnoDDOh3cNum1nJ377GAPNVvNeq8JSmZMu+k0RnNXjaqQufpT9VFqNGLQEGzxhhFCbd
	 ZaiJB8ZwwR9uIcNhczapjCHobxaEZhGANhWzwr8A1mJrn4OEPEs+22/gOstpGC7LGPGq5
	 PGW4Pqjsh2Yl44DZpyD/HRuV9mQCvEBkQinFdhWGu15rpkCj4/3GmzcOrEjBcJCA0BFfF
	 pTB4Zyo7/FLzY6vOx1HesVYxAwoGwlxoL0VkbcHUFi0Ps0KWwfcPs9ywhQ489YubHcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eC13GFd+;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9F606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBD9F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eC13GFd+
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e47347279so4237553f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795696798; x=1796301598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPUA0tYF2NIjDvPMT86AcZAvNEU+x6KNl319uLJ1Bcg=;
        b=eC13GFd+lh9YmREtdvxdIs3d045300VCGk5Z6VNPVPLmJaQqzgl0iZUWXvN7NGtNaj
         VzRWt+IWvRybMPlDjq2p2vdwUmZeCF7lSUu6P9FwTqAMb2PN5/MLpFQFgAepxn+yHiFK
         U984yq48QQhGQnJ67BuP7XSHIlN3E9cutOBDiNEnMrUyuYDV+Cnhn/FcIC1QYerKaaxd
         NrLShtNhEx8QJcAz/SICrs8Dj1vDt3+rENF017R1MZqWWm4Emf6KhqMQT63TLP2vb4Ui
         5CymRLIVXYIBhhHC4vjlJP4UcQaQpkxMzfX4bSIWCi0Faha0Oz2/GAgzxDjo7XjYZD5g
         /Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696798; x=1796301598;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPUA0tYF2NIjDvPMT86AcZAvNEU+x6KNl319uLJ1Bcg=;
        b=CWsZTWJiSnxw5XKijTLUiG3Tkjr6WIs0KlwW8qDHveW39/5wew07h8mOxMdTIXrKHP
         tZXvICfBpdIS5/0T2EuqtclOHifYPZAEIK0cHqWfLFm3RVczs+ZCxWRudd3TD0Hp0ES6
         Cxz6JoDSjpDyyUT7mwJRGMl/APm8sYWU1ro7FeqiVE2LNWJaAdXaMJ9Tbu3xD59rMXDe
         Ak+CEvqtU85MQLXrmD387NOIYGL7BElkK32wClFYpURVyeHbtOqB3jMBVDU8BSs61yvT
         cjdhYhxaKMGhnhTBpTu1yxuyf03UbDopVBEkvKh5jIGR7XABs1Mdi1lq0DoFFWqt7vXU
         8tYg==
X-Forwarded-Encrypted: i=1; AL+hErHFxWmRI3Was3RdlJpNXDZQKdN0FXLedE8n2567s025yjytXA9seICBH8FeXY7I0eDlYejPej8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E/tLZgL61dDs7tVA1EGESvZP6hibFDvRDh7X/2kCx+aaiZGdI
	axmLHefPnroGFagxuzzYxICTy7IrRUktuf13xat1AajY8YaGlqJGvQIpSJ4Qq0qLFrY=
X-Gm-Gg: AZFdTZeGXuxkaK8OmLHsKD+AKWSIkD4VSyzt7KajVtxAUo/dlbY7qw5ZxdnLVHOEDgc
	mlAIF71+DWjiQT/ugwFG7RuCGMkpKzAsyI/MAikprm5eCN1BJBm4F/cEwvxhYjp19DscJKLqf1l
	gbr3eDSs8elWhIj3UkM64157l2leEXkF0m/mq2JQPmhmZgLERfSfQPZLMlnuFKYnI1sZB7TZ7yF
	k/b4qPzpQ5kaYnm+/B5pU9jvNuGSMnLMTydUvD3t3IlLVzBwtxAGzVI4HbrqoEPR0lwFCm/8zAs
	zeNvkKfmBxcKBHM3Fzs0H7XvH3Hr1LaRVDTqgTA7y+NCc9sbOetHmHhigv9Q4PZS3p/a/QsRdM4
	5Aa5tdkFldMql2WaP7Hjpw6D3uMKxF/hmhosTi4pQKpVly44Qkr9PLKzopHqbsk5QUIB4PtBlNC
	HgA4IhEZwuixjqdY9gzBxcpD/bXXMbYnTOQyWI/abKlcMvmW9ccAgE9bTQb3eqoGcgA3fGfejF2
	kbAmrKJlJ1V3dhZfZT+iTx0/0++HnUp7SDUQNGF0zVQe7zUVXm5Y45iisR540hZOGwRBGKbDMsf
	bhpiGFVRd/+dFrZG0bAVrqmFvGvE/icWJOm3cZeOmXrLtHuxV9UwNd9dBOBLtgnqobM74BOr
X-Received: by 2002:a05:600c:6708:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb88940848mr371708535e9.33.1795696798313;
        Thu, 26 Nov 2026 04:39:58 -0800 (PST)
Received: from ?IPV6:2001:a61:134d:4f01:7bde:22fe:61b7:119e? ([2001:a61:134d:4f01:7bde:22fe:61b7:119e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm41018184f8f.16.2026.11.26.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 04:39:58 -0800 (PST)
Message-ID: <fba67984-e3e9-492e-b512-180c257ecf11@suse.com>
Date: Thu, 26 Nov 2026 13:39:57 +0100
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
Subject: Re: [PATCH v2] usb: image: microtek: limit REQUEST SENSE transfer to
 the sense buffer
To: Alexandre Becholey <alex@becholey.ch>, Oliver Neukum <oliver@neukum.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
 stable@vger.kernel.org
References: <20261126122151.414230-1-alex@becholey.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261126122151.414230-1-alex@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.11.26 13:22, Alexandre Becholey wrote:
> mts_command_done() receives the data phase of a REQUEST SENSE into
> srb->sense_buffer (SCSI_SENSE_BUFFERSIZE, 96 bytes), but with the
> length of the command's own data buffer. A REQUEST SENSE sent through
> SG_IO, allowed on a read-only /dev/sgN without any capability, can have
> a much larger buffer (252 bytes with sg_requests), and a device that
> returns that much writes past the end of the sense buffer.
> 
> Limit the transfer to SCSI_SENSE_BUFFERSIZE.
> 
> The bug was found, and the reproducer and this fix were written, by AI
> agents (Claude Mythos and Claude Opus models). The analysis and the
> patch were reviewed by a human.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Becholey <alex@becholey.ch>
Acked-by: Oliver Neukum <oneukum@suse.com>

