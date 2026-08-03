Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804D3B27F7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747304; cv=none; b=Df/TnqwLoh5XaAXxJv+kuHD7DANts1S96V/3kEVjU/e+cs85X1olAYcET1HsJVm6qFOSGx5qYJxlvHT2L84ZamfT9tuXXtPhkx9IQQmES7jjB+6gik/vxBt5VQa2cH5ZLR5XZuvl7qdV/TpG1Sy/AQYrLFqlKdh4fMuPeq7jhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747304; c=relaxed/simple;
	bh=AV0pToG9zNPBiZyyn1M9cI3XYMude2xTH+l+24aft2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns3HHRh7pWuVt4r7ksxdM4l8/8FVpjkq0BuNSf09ARvqQcWjhcHiEbokOGoipAjOqOsMFsFUZiP0KHMtJ9Vaabdh/brIlSPmUxzpSVXEe/LDJ9JGxNPXLp/KWLSaQoLqHCyVU5S8CnOmbCs1Fu2OoCpPtaD1JJKR966nX430j4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HP4JwJ9s; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HP4JwJ9s"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so1145491e0c.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 01:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747302; x=1786352102;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6QujGCeTnnZ3aprREzL53swawys0bVa+jOxZyTHDqDc=;
        b=lxDIWUdUXswWMxGNgrh7Yo7Hc5/iouhxU2Nyf/Z9u/nL+/SG4xXqbg597CdlzKxZB6
         oUnd9AT0QImAfk/kJZqUpAyixyDLUmNoqgppY12/2OI9IXshHdVPfHvbAicVXhtezxEU
         OPYvH5MLwysj3m4DlGKdeDOjvSRHuh2NqnPXqaZV5WKAYxm9ATB9BCthNptBexXdNriD
         G2nBp1rDqw80uXMZWjSMaHCU3VCPpFD2Bvd87hy1Tqo53xiBEuYx6ymiCFvZ0dvo8QtA
         H9CJN2kMpxPbsi93zYeljwgwk/ixW31sBY5R71cfERh6qI4mms0DkEpQgWpfAujtMRQr
         VSVg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/q2WDxcunpL70PGnnBtFNWWZGEG2pFJs/oZESmPISSafiqa7jyafVSY9OHvdfXgfWKyFPaZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhg72RQg0STxjXzpfT/Ay9tZB5AnIcoXrA1J0sMEnfbqg/s/80
	kMhywtBjkbkcbGQoMSNg5Ui3hXz92op1dfHXCPSIspYUsXQH/6ixWTKTEbYFTrbXPtvUZLI6ROm
	+qsypNKY8knvjRtFzDbAKYz6FGRMlZHHKuGT1J2pr7oaxywmqP03oEZMGYEcwYGmD6e0spxQ5M1
	YTKzOE4cjzGQmQxqLVFcMWkeYL82ihsUJma6OwWOSg1ypwCGFbGnQ8OTzPpHvFZOL6WUKUhJiGT
	kR5YrjioLQASeBqUQ==
X-Gm-Gg: AR+sD10mhGS6mDdin8z0s/KMYJjHlFRB4Bx8j+sfP8L+aQB1jXoNnCXGvMhjGST6Z3e
	+6UEEIfIFhuib0+rYc88bBiYH+sOC9D+mWVGX1VvTE2KtEe0gXsgJLraHkMzMpJRwbzHw4/bDuq
	Gyqi/Wx9HMg6wSkwX2S+h2ywtqYXsuHVQaXdxb+Epzq5l10s5nLb7tniJvHCjRbidpZ7R477yWL
	j+OP2FIaZ0f0sjBSHXBo1NvxMm2S3wGelsNPF8vJKRUrMM4Teuch7uOo4a/sH5gYHNzdL6rZAyR
	9rK1liBwY3NUAaa4+CWVDd/Px21Gi4wR9TWmVy1K0PALMYImXri3q13cNBkW7GQzLF9Nk7tAqVo
	VZqEywms92wc0jY0R78QnbVCa6uyl27UWiTYsT5FNpOXkAuJzIU9nFGCQ23OpHGpYkCZFBgnmd9
	Iv8PyqFwz+DzRiaY0PqWfumQNGHQyv41gZa5dbCSM=
X-Received: by 2002:a05:6122:32c5:b0:5c2:8ba1:1c2 with SMTP id 71dfb90a1353d-5c387825762mr2265867e0c.10.1785747301915;
        Mon, 03 Aug 2026 01:55:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-977e69538b3sm492123241.5.2026.08.03.01.55.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:55:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so31567541cf.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785747300; x=1786352100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6QujGCeTnnZ3aprREzL53swawys0bVa+jOxZyTHDqDc=;
        b=HP4JwJ9slPbJzazz6ZHBq5LNStXE1n/NmJCVdRqB/8vLAc/TuiZ3MZILwZDpTZimHb
         VvU92eWn71N59v7l1mzKqkBJzxLuNaW5aMX75nzJU70yzy3QPgZdI+DBchiG8G6j5XfH
         cjB5e4dHQoEWtdJRcZf1gykr0LKCckYxEszmY=
X-Forwarded-Encrypted: i=1; AHgh+RohtxzEMzmHX1YFMe3hhtpGtDGQsiBYmzQeVvG2YLgfR8CjN97VciFL5jC7Y4KnxFQs1jv6x54=@vger.kernel.org
X-Received: by 2002:ac8:5fcb:0:b0:51c:e14:87ae with SMTP id d75a77b69052e-52b5686a056mr179473371cf.34.1785747300364;
        Mon, 03 Aug 2026 01:55:00 -0700 (PDT)
X-Received: by 2002:ac8:5fcb:0:b0:51c:e14:87ae with SMTP id d75a77b69052e-52b5686a056mr179473231cf.34.1785747299954;
        Mon, 03 Aug 2026 01:54:59 -0700 (PDT)
Received: from [10.176.2.103] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434a2400sm70190036d6.18.2026.08.03.01.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 01:54:59 -0700 (PDT)
Message-ID: <c5aad785-8d7d-4015-a3c9-1f70f2a69579@broadcom.com>
Date: Mon, 3 Aug 2026 10:54:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in
 brcmf_sdio_read_control()
To: Johannes Berg <johannes@sipsolutions.net>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
 <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
 <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c2589f1c-c754-4282-815b-df64f0250623@broadcom.com>
 <e628d43a4aca1763cafcde41338cf7a34fe57d6c.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <e628d43a4aca1763cafcde41338cf7a34fe57d6c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 03/08/2026 10:35, Johannes Berg wrote:
> On Mon, 2026-08-03 at 10:21 +0200, Arend van Spriel wrote:
>>>
>>> I looked at moving the vfree() to the done: label, but the code also
>>> gets there in the success path to wakeup waiters. In the success path
>>> the buf is stored for further processing so it should not be freed.
> 
> Hah, my bad, sorry!
> 
>>> Maybe better to do:
>>>
>>>          spin_unlock_bh(&bus->rxctl_lock);
>>>          brcmf_sdio_dcmd_resp_wake(bus);
>>>          return;
>>>
>>> fail:
>>>          vfree(buf);
>>>          /* Awake any waiters */
>>>          brcmf_sdio_dcmd_resp_wake(bus);
>>> }
>> Actually it turns out brcmf_sdio_read_control() is only called once so
>> the brcmf_sdio_dcmd_resp_wake() can be taken outside the function.
> 
> Or just something like this?
> 
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -1827,15 +1827,17 @@ brcmf_sdio_read_control(struct brcmf_sdio *bus, u8 *hdr, uint len, uint doff)
>          if (bus->rxctl) {
>                  brcmf_err("last control frame is being processed.\n");
>                  spin_unlock_bh(&bus->rxctl_lock);
> -               vfree(buf);
>                  goto done;
>          }
>          bus->rxctl = buf + doff;
>          bus->rxctl_orig = buf;
>          bus->rxlen = len - doff;
>          spin_unlock_bh(&bus->rxctl_lock);
> +       /* buffer is queued */
> +       buf = NULL;
>   
>   done:
> +       vfree(buf);
>          /* Awake any waiters */
>          brcmf_sdio_dcmd_resp_wake(bus);
>   }
> 
> 
> It's already using vmalloc() so seems it wouldn't care that much about
> calling vfree(NULL) on the success path?
True. And yes, the existing vfree() should go, but I figured that goes 
without saying so I did not mention that. I am fine with your proposal, 
but I guess the author will have to submit a v2 patch, right?

Gr. AvS
