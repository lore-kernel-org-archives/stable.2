Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606107;
	b=1FQpbGxuvGr1PiwV0ESELzPADYN+Vbz1DPnmno4PRIlvhPK4n4AGJskjBauhF+Br6jOl
	 t0Q9CtYo5MKOYEYE4XIpmdLUHAI5elGxBsIkM/AYNNXoxCUZTAbHl7DxIROjUtSSi7IDk
	 j21nUvg5/DSdbo15MCFrJaubJ4F1/Bgm7pFcpx3B0b8Slm8KdZolWNr4tW78McNu+Sam4
	 f53ID3oqJxQ39DWZzCkWiku/ixxG8egjQQWS7klPWp5Y56l02Lpurm094NfF47opWiOsk
	 LmX2VXakGhktxQWEV8AiDA0tbbATbPeb+QEkysflD2X7AEib6wPXXwE6g5rQXE/n1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xhQIHZA6VTVgBZmCBhoLcYFIgrIijG6i5CWFzX2HxMY=;
	b=ShaZ0CwS6Mrk61WoiSUMYKWwqvVy8Osql4Lr1VGfmL0R2FERfdIy7gQeiwes06OVqFO8
	 2z9mfN3fbWppntau7T/bmiFGRHf7MX4MXau/oNKAN4Jyzjk8yUVVlJqtGP3r7UX6hrNmX
	 HEIUG4HJpkwFlspeAoj/zR9OIVmPNfmikh4tQICPd5TEbGs7STdIzvqdupTtYQlIO8qm9
	 EKeO+Z5nRAvPXxEzwZz2r9bPYyx3GArID13LP3p59fb0Wg2eespbt4F4O3rE2Xdz/DNqK
	 JI65gl99fKBR66aRfudjvOezKVb72+G+2qrJvYR/rISRfW1cuDYYYNH7H66/HAHeXMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FOUZSFM5;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD191606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD191606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=FOUZSFM5
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f48c750afcso1734017a34.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794606105; x=1795210905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhQIHZA6VTVgBZmCBhoLcYFIgrIijG6i5CWFzX2HxMY=;
        b=FOUZSFM5S5d1miA7Lxx0Lf6OhSwlwNfuHZ5Jqx01yrOE9LvH+Q8m8252JavLipl0XJ
         uTYk6TJLoTtCBo/+0JEVJWlsti+MY7MO5wFKSWClF2sxYLyaHMZ7P0K40cQ0l1G6QM1R
         SgcPi/Z+Sty77r1hVG6EXHzJoQll7d47WKbik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606105; x=1795210905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhQIHZA6VTVgBZmCBhoLcYFIgrIijG6i5CWFzX2HxMY=;
        b=Cz6uwUDeNMJkTBB/oR49ayfqfxsx8AbxF8233CgAPKojFh9P2fGNBEITbndiNIwSNN
         HvRj3+7QgdHtS/w9viiFtYs/mGMksWgfNjF+8uBXd/KEbKq+310B37WT31+AQwcKFqvV
         UMre2x2fFQKK0tW8UouD/EZZaMrIKPtO6E+cHZvU6IxQ00ZwzQhcJ5Jg97NRUt7CHvuY
         akD65SspjkHfgDoncpZYB1pK/yvBhVnXEktvV6c9gQw4BK9sqBGRldbh30kPAH42Vvbz
         V6466nQof+FsJFbPmuTA2etQOqFLcUtk5hBKAUxwAqZW5ggS9d3urpAu1XXRIRmLR2km
         fFyw==
X-Forwarded-Encrypted: i=1; AL+hErEKmLXZQAXmitcUo857/TDd2GjrrRXUfU7I8P4KlWzcJuYskiqTbfDZ7bFxg9mPG/ZAz8VB/C0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/36iSjpKYeNn1YO1nwbhW5OdjdiAKQZQ211A6hBPMaNsCdBEkO
	SDPpWvlg5S98OZbjWnWKHapC8AJNxomEcsmxlc6edZud/Qzhao9sg7phb9+8CjDJ/9Y=
X-Gm-Gg: AYBFou2XKFHMp2RXtVr/kMKflgcSnoIs5sZBFVSQ6HndHU+SaxC4TuLI9SFUIq3xSMZ
	hzaxrzw4osC0uHoIYE6gb+URuy3jrw99DLZN4BQK0gJKlJccVSl2dsoYNjPHrfo5JrUpCvcqjiK
	4Bab97e/K518L2k9LW9ZwZDfnzAlSvJbAuwdaxxcGa/Lf1ISQM4eMLGvfnHo3vdQ7oZOBF2P1MC
	ej4oXnywHGOl9sDjNCZ0fxF92NZvQeM9UWUnLghYfPt/3jlhX/L9IMbuSAAoGAkl2l8WY5qOjuS
	SgJQeZ3gb+5WfMuJXWkTOCtKl+ZJaU2YzaaMMuKN7ilYdFQDcXP9Cjp6VbZPduqNZRMKqbuMveF
	qGrOvOLDmZfvaSaLn45H3sl5qbJjehOiUbEEsl37uFTq+5FLTkxyiRzH5gCft73VQcQZ0YTRhQC
	Op8OyecPsD1djqETuWh7RXHSUdvOxT7pftGQ2C0TZYxLIgBruByU61vGH1FhSEvaexlEhis8z6w
	b9VAIAYtTghtBqVYR9/Zvi8YtFFchmS6GgT0unZS57N/Jw71HD6UlL0duz6aSTBuJjobgnUqRMP
	t36qD0lAk+mmRC3of15DtB0H0i99nBiSivUpBfw=
X-Received: by 2002:a05:6808:3010:b0:568:1e54:3d74 with SMTP id 5614622812f47-56e64df14ffmr3388527b6e.39.1794606105620;
        Fri, 13 Nov 2026 13:41:45 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm3131199b6e.12.2026.11.13.13.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:41:44 -0800 (PST)
Message-ID: <573f682d-47ee-4e39-80ed-0ddf0da96cdb@linuxfoundation.org>
Date: Fri, 13 Nov 2026 14:41:43 -0700
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
Subject: Re: [PATCH] usbip: Close all listening sockets in request workers
To: raoxu <raoxu@uniontech.com>
Cc: brgl@kernel.org, gregkh@linuxfoundation.org, i@zenithal.me,
 ihadzic@research.bell-labs.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, luiz.von.dentz@intel.com, pengpeng@iscas.ac.cn,
 pmenzel@molgen.mpg.de, shuah@kernel.org, stable@vger.kernel.org,
 valentina.manea.m@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <67b2c06e-0caa-4ba1-89ee-17cb814d173c@linuxfoundation.org>
 <351AC939AD9B6359+20261113023710.1746483-1-raoxu@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <351AC939AD9B6359+20261113023710.1746483-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 19:37, raoxu wrote:
> Hi Shuah,
> 
> Thanks for the review.
> 
> I found this while reviewing the listening socket handling across fork() in
> usbipd.c, and then reproduced the issue with the unmodified usbipd binary on
> two UOS test machines.
> 
> Both machines have usbip 2.0+6.5.10-2 installed, with usbipd located at
> /usr/sbin/usbipd. This package contains the original listener handling.
> 
> I used separate test ports to avoid interfering with the default USB/IP
> service.
> 
> On 10.20.12.188, the reproduction steps were:
> 
> 1. Start usbipd as root with both IPv4 and IPv6 listeners:
> 
>         sudo /usr/sbin/usbipd -d -4 -6 -t 43241
> 
> 2. From a client machine, establish an IPv4 TCP connection and keep it open
>     without sending a USB/IP request:
> 
>         python3 -c 'import socket,time; s=socket.create_connection(("10.20.12.188",43241)); time.sleep(300)'
> 
> 3. Terminate only the main usbipd process with SIGTERM, leaving the worker
>     running.

You removed all the context from the thread :(

In the following path in process_request(), child exits after
handling the pdu - all open fds get closed.

        childpid = fork();
         if (childpid == 0) {
                 close(listenfd);
                 recv_pdu(connfd);
                 exit(0);
         }

How does the problem you are describing happen in the normal
use-case when a child exits after handling the request. If
it doesn't there is no need for this change you are proposing.

thanks,
-- Shuah
