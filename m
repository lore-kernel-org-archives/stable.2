Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F73AB28F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275254; cv=none; b=d6hd8qUsqJR1no5ojzS5J0rn8KmLNKsmeKB3KG6mLy5SvNWgzBrXdLAnCHPsmdEUw7FJQNtlhhGlk561cHbstkw/jM0zJTXOZQ8Sp3yF+BqC0bbXLpcWtKoT4YaLcpIxOaSkPFAjMj5AGDkB2KEC22J/JAH0jOSxzW/piXZXAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275254; c=relaxed/simple;
	bh=AhTSB+hX8DW5/UqPj/kPlDv4TilOhsZezix19Q9Y0hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBum2dushufF/GsoS8FmTTI4aqToSKMJBqUmmqzcAIVGmC1tj3QsM2NVNdASxkTLVNNWDUN0RtPLxG2H1oQV78P47yucOl+CY0gUCyrQ86wp95HYl2w2A6oBaZ4BXJS0Ni51b2esmZrOW5hpfAPILoSHU/OqVkUnk8Q1OsJSKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YWnPD1cK; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YWnPD1cK"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e4e37788cso23553185a.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275252; x=1791880052;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aO7ZMNOXH20rZFoB1a96CWPC5jLhbhIpE9Whu53E080=;
        b=PEenGqLCOPGfeImH87COk9hVzlHSBfyiz77Dm22f1xD9dBJQ58IwXoEOmDUNXteHoS
         0hBTZjDJ0VGM7SfhIxr1w5ZyUrYsZZreWVD+8fgSbHYH9R1qlvL46NNI7nXrOG032azy
         PCMQCo4g0BYi1OtVuoPX2dJmH+S5K5hOWTV08uF4WokY/+O08rBOK70L/M2EYPG240P8
         VGLzHzwui2FAmvWfibWmPo4ZVCFlVwccmj+UNaUaPe2xkw2cmUFsM/NzwLEu1yBl0NaR
         lKiPh8vnHWGowM2rSP7x2pOzKLLMBDWUjv1vno/vNwnk2nmIdX5ZWskurJzpwCcFkRwE
         GUZw==
X-Forwarded-Encrypted: i=1; AKwUvBy+XJhILCVS2XVL3+zbqmnFN0qxKajfLusVZdSExigUdkV7hfvb4EdUv45tkRpsQMr62cuo5fU=@vger.kernel.org
X-Gm-Message-State: AFuF++mG3nv9T8LSkYg/Jb2NACLELj+ROLhtbKdDwbXuh0mswI3MhrA7
	Kz9iWZQ6+rlJ/MTxClV7w0MksnNSa1Qp1GbObxibt9mZLMz4yheGGlN1cF/w5HK562Ienu0aEZW
	ArTl7GEKmg/Yiv2HCWlCe3CIw/G48A3fXZ67JQiedTxYw6wxhor60bdXjMXhAgaPyzo/3xwszu3
	tAasfwCmzFA58uJ1s9qAzhks/CaEIAWf9Ta4ABsNsWRW/rMOKxLSAA2LVXjz2bjv0qGOOYAsSnq
	GZhvjSVxoMY//dTtQ==
X-Gm-Gg: AYBFou38KXkAr993FpNukxI2KdGpkwQCclOOOZCGVstTwggGdgzkcgSvW13wmp+4Ml9
	aNUeYODHYeR6Bi15L/EDSbypSBCNIedXmMwtqPnZ9FJacc5SlQCMqKbjc39DMsQ+SBlcSs4dGfA
	qcoUXGspaHA2ymAWhxO9u99r2HfZMbR74irEGPR9Cs4bX7hZeC6/9wQdRN3exznLZwuS+H0JuBe
	V/JC7Or6x14szG2INsUxMk6ONDFGVx6fZUsOmjcvWLRPihl8Fkr2jhbJTHfbxIpMeIlkAPqJqqm
	1cLkRcCBb7iiI2BbqINE+HCoEfq/KPeHLl41K5X5a4Rmf+z1GATBDdPhxsVfGl8JE5OhtuWZM03
	JcAvrZH5zi/Pjok/lr38yZABwgWBBUyG2oRxGNV30V45dq4CuiEhUGQY3esKhPS5BxtxYTRGaWH
	JZb6Hgvy+i3ykbVTscIkiPWs3B0xkKtEACyfZv7Uuu+g==
X-Received: by 2002:a05:620a:46a0:b0:93e:5060:f929 with SMTP id af79cd13be357-93e8f31c384mr134455985a.19.1791275251861;
        Tue, 06 Oct 2026 01:27:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93cca03cdd2sm494531685a.1.2026.10.06.01.27.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 01:27:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3510562ef98so3410752eec.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791275250; x=1791880050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aO7ZMNOXH20rZFoB1a96CWPC5jLhbhIpE9Whu53E080=;
        b=YWnPD1cKKv+BA9qxVUDRvhJ12vc39zoc3nN2jC2KGqTtbX3crNdvFDVFXuJuHyaZ+O
         CQtpD0ZDauOFIfP/CwEKHoxGLdMEgvN7n7qi6SZ3n+lMTIkHjF0vgiREXyPi320/R+OH
         xiuqZ/rh8pyH1DGqoQapZvMzn2kBEix92aqlE=
X-Forwarded-Encrypted: i=1; AKwUvBy+cjY90jra26bTHQg5J/AguqjQoaSgg/eL4JFjT+sN+CTnJxYfWGnGqFVlD6XqA4OnuxK5Cbo=@vger.kernel.org
X-Received: by 2002:a05:7022:288:b0:143:4d12:396d with SMTP id a92af1059eb24-15ec7b02b1dmr978949c88.26.1791275250345;
        Tue, 06 Oct 2026 01:27:30 -0700 (PDT)
X-Received: by 2002:a05:7022:288:b0:143:4d12:396d with SMTP id a92af1059eb24-15ec7b02b1dmr978913c88.26.1791275249521;
        Tue, 06 Oct 2026 01:27:29 -0700 (PDT)
Received: from [10.176.3.41] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm5335442c88.10.2026.10.06.01.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 01:27:28 -0700 (PDT)
Message-ID: <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
Date: Tue, 6 Oct 2026 10:27:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-wireless@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
 <asR1TaKQJlPFqEvR@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <asR1TaKQJlPFqEvR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 06/10/2026 06:18, Karl Mehltretter wrote:
> On Sun, Oct 04, 2026 at 05:29:10AM +0100, Arend van Spriel wrote:
>> Is there an opportunity to reuse/refactor brcmf_sdio_prec_enq() rather than
>> adding a separate brcmf_sdio_prec_enq_irqoff() helper? For example, passing
>> a can_evict parameter:
>>
> 
> Thanks for the review!
> 
> Sharing the helper with a can_evict argument is cleaner.
> 
> One queue user does not hold txq_lock: brcmf_fws_bus_txq_cleanup()
> dequeues through brcmu_pktq_pdeq_match().
> 
> Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
> without txq_lock.

This is an observation unrelated to the patch, right? You mentioned in 
the patch it only covers fcmode=0, right?

> I combined the helpers, but kept brcmu_pktq_penq() for normal calls.
Sure.

Regards,
Arend
