Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919337;
	b=1Zt5jxcMtYA6/4hTt0IFXrST+dPlbIkRy9tPdjLOy+JJ5S2F+SKqayHVcOYzEizjtghz
	 GdBGOfpOgyEKtUQhNIxmNp298pbO99T9TEBKUTo0pezQ6ynJ3mC0juu5TtrIs8UFtLZDy
	 1qSWyLizPox8jLSVQFUPKUNDzKmjAs+X9iNbvk2Topeg6qOf0YRW5cg6SVAJULACQ/Zht
	 byC/CxxRSmsNv/ajQpKc3Unx/FOnkDcnE2nMYChtT8TtKitBY2/G76CDZGQK60Hwgu/bI
	 PfcDPwN1HWNiK8vyrh7nzuXeKE8tv/0pzcXCPuaW7AHsPqWogwnajMO0bbhB9r3z3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+WEBtr/8JSNohNzv89EN8vX89/+poqMMTCUuO0C1p1k=;
	b=cEknsiOv5sHgptJVnGkdZvj/C8xez0Zq4+6kbLYDd+Sb5tzatmYK1hUCEEvYkDUOPQR+
	 WZLqwy36Vs8tIWqtpxvqDk8Nb4NKUcpUsMyGH4UEQQFCrldwgrjnfeZM6QElJeHyn6XyL
	 yO1t73xb7lcxa6262/WIIwC6f9Cd/vMHCCO+25XQ7ObH/5Zw1qa1/ds1QzBQb/wZBYqhg
	 Jw8xlbFFmY7cL4WegZ3wuO81akeIUVdNldYTm6bFj9Qpn2BqEp+ksaJju1f1pErJQ7HL+
	 +v8H8w45inHYRgYFebWqE03ZkSVprn5ewbMRHDD6uVmgYPgDCghDxI+EvVZmBV9gQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Qd/+66R7";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38201606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38201606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qd/+66R7
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9ae391a05so6055885ad.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794919336; x=1795524136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+WEBtr/8JSNohNzv89EN8vX89/+poqMMTCUuO0C1p1k=;
        b=Qd/+66R72ZMBHS1lom8jYTv5vrzgVK6LKwbc1GuEkIjNSDypJIUomLBY+V+EI6Me8I
         AUcn12zu4Q3tdplynPs9zheVUCOaLsjUQg2i49e7a18G6/19FbwvZK+60ohZS/8FkuIk
         I05JhCr70nuvPeHk0xqKZnyAbzpdn5hx5YLWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794919336; x=1795524136;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+WEBtr/8JSNohNzv89EN8vX89/+poqMMTCUuO0C1p1k=;
        b=Wgg0lFQIwgnTCyJ1Wwt3k2yau1qBz+KxuL/YUDhiOChVpAdlGq/LzNDeiUP0TZXTaA
         mIznH7zQoAPJ5mdjHNgkYSeps+UfUQC0ugY53ZSFV9yvNqjMlloR9ZBB6ecmZppybu/P
         B5ssOVRchhB7RRTQZFt0rQBES8zlOuq2sMTX2wlzbDqwUIwQpuCEkiyMgy2Iuf1Ahess
         VrzEx4dgKB/Zoy35E+MvTityVMRKUTF2nSMfjAzLR8qusBmX4EW+JTvKheJBljVbrYKW
         PswCOWHKwiPl9qiyrow5Ah1O6u6tTea8byoDT47W5mJW/4b18ZbHekz7bGNRUr0ko4Zc
         VaiQ==
X-Gm-Message-State: APuU4Z/ptZYSboqV/9X8MF7YOdpUZ+Tw5eF5qgn4MBb9utp76alRMdCq
	IwhJ8hgRsT/xgRWbkGI2ug3RI09Vp1AWXR4MDIoZcbYPJECA0jjFE7fLnZrudZkAuYdyHjHshuH
	1sMEmLEzA
X-Gm-Gg: AZFdTZefQhqqLqWokqtzQqaZVU1UwfUJvvFmoDYfSVd6i32qGF5iBIFuTo8kDJm3luw
	cskr3s1BrT4+xYocM/BlBXAPuTqKSlDp6rVWmvBXV8Y8OTb0Q4p7d7rWpZRAhnV2m9Si9yMB8nl
	FTI1DJSmMY8E5hwJIvD6GFAAVzSdIoSvGbrcFkt6c6kJ/jntMR8TZjrwqFBLblsgmqZYzo2WZ0Y
	OJ+0pCrny/10vbGX7dPzibn9eE1WXaXhHolcwxwSdUXJkMwnsSAG7vYoQ8gdzN+L0Wgjq2e40j0
	IaMlCkepxCULpvSbAyn/p7FFzQZWbMNFX/z/sKlGXCFqOYfAzdMgxnGKy+cLFAR6TnsEcw7OLxW
	6AHD79MH/PTxB/+1Wt4xbjb9HG6PM6Do/6MpI2J/je1Myv1MXIMiVzWGreheAgBbKsjXN4vGaP6
	HV9FV8NknfV9zvvG26VbLuhCjTvXQLVGvyMBQycsQWceq+rZtF7ko4fkUNai10ZkGlRt4ePbT7Y
	rQrybq3TpckvGNryP/JNqcg+0z6vxa6lpnhlkEZPw4mpilw64CAwuMtSvsjNgvWQYelDXwQaM29
	XjCn+kxV/l2m2Oui4mKvJD2dkNdFwR5irvjsVnGx+Cvcm2rsDdN57r+99f9ongwFJc06lA==
X-Received: by 2002:a17:903:2808:b0:2e3:1e9e:fd80 with SMTP id d9443c01a7336-2efd9b2e975mr11463645ad.7.1794919336474;
        Tue, 17 Nov 2026 04:42:16 -0800 (PST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com. [74.125.82.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a85e0fsm14355095ad.56.2026.11.17.04.42.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 04:42:16 -0800 (PST)
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37198ed3727so1039129eec.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:42:15 -0800 (PST)
X-Received: by 2002:a05:701b:4208:10b0:1b3:b3d5:566f with SMTP id
 a92af1059eb24-1b53a3d6f36mr2169749c88.11.1794919334620; Tue, 17 Nov 2026
 04:42:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avxKOmxCBLF+7qdT@jpc00229873>
In-Reply-To: <avxKOmxCBLF+7qdT@jpc00229873>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Nov 2026 13:42:00 +0100
X-Gmail-Original-Message-ID: <CANiDSCuX1+ehTGN=HNuLL9YBTt8tUw6fJ2D1JqfePQGaz+QOzA@mail.gmail.com>
X-Gm-Features: AclHuK-EAX41DbKYbj2e_sh3aVA0w84vlTt-MWboq9nmaiJAZIgb1T5nlgGrxS0
Message-ID: <CANiDSCuX1+ehTGN=HNuLL9YBTt8tUw6fJ2D1JqfePQGaz+QOzA@mail.gmail.com>
Subject: Re: [REGRESSION] 5.15.y, 5.10.y: media: uvcvideo: please backport 5b9c75c794ce
To: Naoki Matsumoto <naoki.matt.matsumoto@sony.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, regressions@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, chenchangcheng <chenchangcheng@kylinos.cn>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Naoki

On Tue, 17 Nov 2026 at 13:36, Naoki Matsumoto
<naoki.matt.matsumoto@sony.com> wrote:
>
> Hi
>
> I use a UVC device of USB3 at v5.15.y. I found the frame rate down with
> the below message after updating stable version.
>
>     uvcvideo 2-3:1.3: UVC non compliance: the max payload
>     transmission size (1729) exceeds the size of the ep max packet (1024).
>     Using the max size.
>
> This message is from by eb6059474e70 ("media: uvcvideo: Fix bandwidth issue for Alcor camera").
>
>     5.15.190: eb6059474e70
>     5.10.241: 3eaf16ff8165
>
> kernel-5.15 supports usb3 of course. This problem is stream->maxpsize is
> not support usb3. Since this function parses it directly, USB 3 support seems
> to have been overlooked. I found the patch at v5.19
>
> Please apply 5b9c75c794ce ("media: uvcvideo: Undup use
> uvc_endpoint_max_bpi() code") to 5.15.y and 5.10.y.
>
> I confirmed that it cherry-picks cleanly and fixes the problem on 5.15.

Thanks a lot for your email. I believe I already asked stable to
cherry-pick this
https://lore.kernel.org/stable/20260323-uvc-backport-bpi-v1-1-5b62c6798ccf@chromium.org/


Sasha, Greg, could you check what happened?

Thanks!
>
> #regzbot introduced: eb6059474e70
>
> Thank you,
> Naoki Matsumoto
>


-- 
Ricardo Ribalda
