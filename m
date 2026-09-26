Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CF37F748
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452169; cv=none; b=S3CF5KN/tdH98xNL3abv7ecq1yXLJGTCqVxyQcEWjRIxmXlOnG/5dFwUWE/jbQw2lfKGZV5CM61RyS8QZ+8gzOntkoUJzZGa96Il0MH8gpaOhb4UCgGfaaiZBus0ltHFOMPBRaUvVxHKmxsU4ce55J1+8rIn4WnEnI7s5ZyY7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452169; c=relaxed/simple;
	bh=/DePFCEtObnLIzGyGVncSOC3Te/jkUfVOEKHBPWr07w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5sGTu7/F73UK1CRc/TH+zZ4qNfuLzjGjiwB0Gs3+JkhLsvcFVHhOuVlaYWXdVRISi9eSg2SBJmeovo6QskKEHJsoo8+96dbj9/9j/c8t2rJur1rLCAe1f9fBpUEivFWPGkiSx1fi16E+8eENxnoO702LE3hzltPiil+qZl9n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d/hPTyT1; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d/hPTyT1"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso8702075e9.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790452165; x=1791056965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DePFCEtObnLIzGyGVncSOC3Te/jkUfVOEKHBPWr07w=;
        b=d/hPTyT1+1vOyCgAJJUGe4lMmZl5bq1zRgOIrjH81Aw87tMs6Q2d/xlMplTucUvA+O
         Ps0dFGOOCSFM36fmwNmF8W5dpimIRQPuCshXz+nDK7/fjOl2OMCbNXQaDpXMlrMpqm4E
         mtq63JMfPeizK0m/LqgxDQed2hveLCXZcMDtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452165; x=1791056965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DePFCEtObnLIzGyGVncSOC3Te/jkUfVOEKHBPWr07w=;
        b=t04d4mea1jGzCVeTft6KAL715Shex87v4m6eUwBeXbAP1fyE82OWY5D9X74P6HKCg4
         tuTSltNfi/FC5MIGeuE/xzf3oJ4TH4KIiaYyLKRaYw7lAAAIweCFfwvt9gGjQQzEJu6d
         z0hYqe9DfCLSAdIK2lc8JHzGjZ7yLi5lpn9ln0sR2/tq9fH74QC5zvltZ8iE2J9tWlrf
         F2rM2rQXlr0MYQAVetT56P5YTVLW14mo8bXztMA52NM111NM3gPpNokX+LstiLXM1fy5
         o3hwZFGeeHWSA5DqJYGeNzhHOhbxXgXmoFU+M5bJxFi+sIjZoV+cMmVtXCAyxg6ya3K5
         AHCA==
X-Forwarded-Encrypted: i=1; AKwUvBwv/9YA1Qv9Qfojj+IwOMqaNWsO0V+ZqrDPDrz8qEw7c6fVuQYBRHS4sVicTp12DSyUpaK3mj8=@vger.kernel.org
X-Gm-Message-State: AFuF++nGuVB2kr8HgZ3WHM7v/hOVSq268q7uY3c2DPFYe/dbNPVGlpuw
	D25D2ct/CNEXwWLIJIc0zuB/0iM0RnGjNnalMezQ2c/iH850jl77Q59YgCfgiDr7Tfo=
X-Gm-Gg: AYBFou1+EDFuO3cSAVStAqQOWxIDJVMZOOiyTIC19AVW1xmKWcyGoSIrgS5NObYX5gV
	gOsmJ1oBrk/v83VNz+xO3ViRZYtFS0rtfHyXYnja1YFB1FHQtk7bVKOLsqgSaMGOsMqdUiex9lY
	ZYzLl8U+PDnxwqYaaL53T3k9T/Sm5sYS6vOQ/XpL/GxWJkzAgYaVhbQqvwPOzVz1zlb72oxbGO3
	EE2ph5g9a18GzpRgx1tJQgEc9to38DFBCyipaEJgm8oYLpn5GYVen9dGSfMyFPif9aClS8NE9Wx
	NHLYpPiS/PToj7SVGzlI8AXVGGQYcBRkddKaRzp1O3sn3PCxWOoaC819gTbLmEUXoFo4SfciMhk
	kG4W7U3Mirs9OxsBjL/t5f0aARhJXW3niiBaGcjRwo8sUDeB/uM7Gi7IJUDb/iFiddWqIpinTNF
	yCnLss2BX9g/JOG0jRyXLsRtANLupjJ/ASl9TB/ISq7zYD4W7OyeWGQQuDANgtqe7Xc2MM5dhiC
	L1DfXWIJmwlJFSHKDgzWCAPOMssaVtjTYiYVKcR0cKErBGX3kUC9z35pQ==
X-Received: by 2002:a05:600c:609a:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49ff06b2db4mr107860355e9.2.1790452165483;
        Sat, 26 Sep 2026 12:49:25 -0700 (PDT)
Received: from [10.188.205.27] (cust-west-par-46-193-1-237.cust.wifirst.net. [46.193.1.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35fb05sm17547635f8f.20.2026.09.26.12.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 12:49:24 -0700 (PDT)
Message-ID: <eeb557fb-7ae5-42f6-8167-83c3828169ef@linuxfoundation.org>
Date: Sat, 26 Sep 2026 13:49:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in
 favor of drivers_probe
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, i@zenithal.me, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org,
 syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
 valentina.manea.m@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20260811160541.29461-1-jeffinphilip14@gmail.com>
 <20260820101800.14650-1-jeffinphilip14@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260820101800.14650-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 04:18, Jeffin Philip wrote:
> On Tue, 11 Aug 2026 21:35:39 +0530, Jeffin Philip wrote:
>> do_rebind, which sleeps normally gets a mutex lock. However, it does not
>> or should I say, cannot check for null udev between spin lock dropped in
>> rebind_store and entering do_rebind. This is a potential race window
>> already. So, even if we check for null udev under spinlock, we cannot do
>> it outside. Regarding do_rebind, it is called during stub_device_rebind,
>> but that function is called during module exit when all files are removed.
>> So, do_rebind is not designed to work in a concurrent environment in the
>> first place.
>>
>> We have a safer function that can already do what do_rebind does,
>> drivers_probe. So, we use drivers_probe to rebind the device rather than
>> use rebind_store.
>>
>> usbip tool references this function immediately after the device is unbound,
>> which is safe for the tool itself but since we opted for drivers_probe, fix
>> it by using drivers_probe rather than rebind_store after unbinding device
>> which is more safer.
>>
>> Tested and working in both userspace via the tool and manually echoing
>> the busid in the related nodes. rebind node is still left active with a
>> warning to use drivers_probe upon encountering rebind_store.

I want to know your test setup. Can you reproduce this with usbip host and
running bind command from the tool?

Also send me the error messages.

thanks,
-- Shuah
