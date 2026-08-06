Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCFC43B4B2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011881; cv=none; b=tJW38O4uLrlUvf41rDk1g0hoeZiI8Z4m38nXDQXwN3fu2IbM1gpb0GQcT9PPKGtcHPu+i8g2sbi6oLkRLXX46pBd04IXL6Y6hMqMI4GwfOWvKVtmNQQMIgTo7uBr1dqnffetuEMXjR/8xE44JZZQTreyzokKFDP09v9vjVC/QrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011881; c=relaxed/simple;
	bh=Y/BfzcHBW1+/hTfe8NWTi/nlFyz3lih/XK9O4ky6nXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ0DvKDPbAXu8aB6qg/yK1c4t1ArSaGntD1+bA+Bc/zPkYpgZfTdD2CTjgVUO1B+zt6lGEjhe674+LH1eRC6jWZaNxgsOK9RCJ3zgbDAAi4IK4bB01BW3fJAg0LQpdd0sVmxmNNzrXIh47mE0c2/dhuTa+Qg2r2LMzJp+oOJf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJX5unF+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJX5unF+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472326ca506so1369952f8f.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786011878; x=1786616678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ufo/CJ3ncCi7FHgGFSyE4mS7SJGms4hMqbby60EAfSo=;
        b=vJX5unF+o+L9Usnc99MdKQh4Zsp+lQ4ru1UyOoK98FsV0FqMmqf5gFqv5h+bYV5F2K
         GDVnM2uu7CPu9Dlx8iBfbun2T3G3Y8sBWdifVWM+bics8QewLZ16Hgyg1G11sSdzi9QF
         ZxVsyQ3Cqbs29GuftgkjO3PC+ZaqhvztBrWhw8LC5drldcQzE06EBWktd2lGKlrQfp7E
         hWhuNtRBB3eP0dahzW7VgdGNFpkGW8f/2b6dOMlXqnjYWdpvJzCSiFBw3n99xnc9mxB5
         ZQZv8z/HDFJVWoS2hxL9r1w2dyj7yf3M1heYh1rYPfEjoJBmQIFmAfq4OPkw9M3V5v4s
         scEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011878; x=1786616678;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ufo/CJ3ncCi7FHgGFSyE4mS7SJGms4hMqbby60EAfSo=;
        b=QftJk84A81dsbFrLyeckywq3MKClbSGnVBnkL0G/Fp2bTsg3oYM7V1ey+uhPMPWFV7
         I8RSzPH44WFx0bZUIHoJVlbgN6WKZpOx0YO7/l1E2papdvu/gFvXR18DObaXUxCgYxFB
         vXKTYyZYGghjuAtX93f1tUUOedGwaZ3Uh08AfymEOZfbYjWon/MkGQPT6pWGF3FnWhQ8
         moGIhffVf6ijJEHbHVUZ3nj5rgD//uvM6lIoEeC4MS04BGFRGgOl6VbSVZ1HA9GqciDk
         EsegBKIzAJdarBrj8pCTgqzfMC/g+02a8pNaXCH/GFq1djRKnRR6mVsLeRcFy+s9Cqvs
         e9+A==
X-Forwarded-Encrypted: i=1; AHgh+RqYMgrSkonHcMH+dwVRr7k4nJGmOKtSD0oTxgoYI1ETZeRu68FpimMmZ3k8VnGAcvY6E7de1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdxs/tqpCglX1X+cYN0b1z2kTXCC0PLtEKLpbn+j5a+eXSMKhJ
	0UWt/nBowE86oQtbHTRhL/ahNhPrI0+o6rLcpiS5g4mFd2biiDOp4171+/g2AhyB+8o=
X-Gm-Gg: AR+sD10/cJ6aAYFo6gOummSdid/L0N4y52Hep7x8inqAn/jJpJQg6S0CkIvjENmDWuS
	QDP9yVGrcVEtmQ94nlpmUKFIAM1JhTkEqRg0Us2sucmNU0oiOpxQ5yV9bMZXHspxpMsk/K04KDx
	rtKIVfW/+8hcMXqCLdIRxGe+yIwzKLXEht2hI4PttZIkKUX2Xsnsn74Kah3ixh4ipEeLl8FzsFA
	NLA4OkUSaust+5lq7Jf6WvvDhp7w0FYX/IUnDL8XB6/VmsXnPjmuwCul+xvLs5/JNfKNjBP6USY
	c2bxxyvbCDu2W+AxyNazCjzGDjwo52YqA5mioy0BOckz3tRtH/HMwtBwGaiBx5VtUgGzssnH5Mu
	mv79gJcEmHAgUXHOZsC9zMmkp+nCraz7NwRmXRDCPrK1Zu5WUyxGf0QF1CB2dWPo9y9LE5LwnJy
	BHsL/2FnRBxVVdmlfBK5MNc3I69yV37+dJOvDHkJce8Nc5wIa2O89bkOLL56be28WVfyl1swdbQ
	g==
X-Received: by 2002:a5d:6a4e:0:b0:47f:8fc9:6eaa with SMTP id ffacd0b85a97d-47fec4edc2amr17986324f8f.8.1786011878436;
        Thu, 06 Aug 2026 03:24:38 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.115.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250cfsm5060906f8f.28.2026.08.06.03.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:24:38 -0700 (PDT)
Message-ID: <72b267c5-6490-453a-9900-b196d1cfc5f8@linaro.org>
Date: Thu, 6 Aug 2026 11:24:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Krzysztof Kozlowski <krzk@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
 Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <futJwsC0VjGSkjrB5PP9T0jBOVgWADaDAYyRRp-OZifaKPNtjcnnA59QJaQTdqYTeayZk9jY6e1jOfun71Yp5Q==@protonmail.internalid>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <689580d1-8169-41cf-a954-927e10135700@kernel.org>
 <d0983bf7-a708-46ff-9f86-f94fb6a92ba7@oss.qualcomm.com>
 <d6ffacaf-7f83-42be-a3cf-40ce00810ca9@linaro.org>
 <Ia82wa4IJDPkQZpTCt4MDMqtq1VGZ7DqIaJFNvV0MjaT3jjWrbD_iBs8RU7pqrIz-ZTMSK2irncUv7-PZ-fvkg==@protonmail.internalid>
 <8130900b-c9f2-4f5a-80f1-1e8567ee1b72@oss.qualcomm.com>
 <f252d83f-e0e7-4061-8da8-d2650f1beadf@kernel.org>
 <ea0f1777-4615-415c-86d2-2a792ea42b3e@linaro.org>
 <41163185-09e8-47b5-9ece-c6503cb48920@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <41163185-09e8-47b5-9ece-c6503cb48920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 11:14, Krzysztof Kozlowski wrote:
> On 06/08/2026 12:07, Bryan O'Donoghue wrote:
>> I tend to think - absent an obvious an immediately applicable fix these
>> two drivers must be marked BROKEN, the alternative is to apply Daniel's
>> fix and then live with the results for the bindings.
>>
>> Since the DT schema change is still under debate - what alternative is
>> there ?
>>
>> I'm not far off sending that patch now myself because I'm not seeing
>> urgency on fixing this and TBH that's pissing me off.
>>
>> As a user of a system, I expect resonsible and honest behaviour wrt to
>> bugs, not architecture astronauty while my system can still reset
>> despite perfectly functional fixes being available.
>>
>> Great you want to do sub-nodes in DT. Not great, that's not agreed yet,
>> even more not great - the venus stuff isn't even on the list.
>>
>> Please indicate what should be done for -stable this week else both of
>> these drivers need to be marked BROKEN.
> 
> Nothing should be done for stable. Or rather: you can do whatever you
> wish for the stable, because we discuss here mainline, not stable kernel.
> 
> There is no problem here "devices running stable kernel are affected"
> which we are solving.
> 
> The only problem we are solving is "devices running mainline kernel are
> affected". Fix this one and stable will follow.
> 
> Best regards,
> Krzysztof

Yes -master.

My issue is how long this will take. Several kernel cycles and the 
debate is ongoing.

Daneil's fix has not been applied which means the replicable system bug 
is out there in the wild, not addressed.

Daniel's fix could have been applied and rolled out to all users in 
mainline and consequently stable.

Instead another architectural level fix is still under discussion, which 
is of no value to end users whose systems can reset in the meantime.

Its just not responsible behaviour. So I feel both of these drivers need 
to be marked as BROKEN unless/until a fix lands.

I'm hoping the vidc team will come up with something else.

---
bod
