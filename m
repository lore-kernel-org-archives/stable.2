Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577150;
	b=gT2Z+X4RK0HSCYuRGoHqha1x5E969cgow01yWdUod2SpMFz0F1Fto3F2/qDgP26iA+9Z
	 4G6YVzXG0ysPjGqXNNrTJ9YFV6W+g4wa0kK0tuME4+WICULzhEywSMFGC2GnqtG0p7B4H
	 lWjMH2GTsZw774AJxye7RBQEzWutWMDmphOupckbVRD9FBhxA2jBOWGLhqCPEgPZ1wfh5
	 kQ1DSjuLLRq6+0ePRMLx1J9uYJJyrvrugmEMmPVRIkHsfeKFzzYuFEHB0YyTPjwmoJ3SG
	 GJgjex4TxiVnnjsw/J3GcHhsvzWpNLxax4C5EzWqXF/afaiHZHMl5Zo/x9ApHIg8Smg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=L0sJrg3ZtOtV8HOj6gQCGIEhMo8dzQwv33n2YrOIPas=;
	b=2Z2Qz1DM2DP8fwvtutNCowCkaQ63n7A/N4An/NCDzyQSfGeUyjEc/OrCCxpDYZ3T65nQ
	 iuIfR65atfZsnd8zdzNrKO11FMrRz86xWXzMX8W4nM5FqRaZrzc8tXMo7w6ZkJLDEmEde
	 oRqnfJfiskvYAHGsAiyev0zbsvnqgBs973cH8rC8lUeGgi28hfhZybh+yFGhGYrpXkgXO
	 f2sf/oP7VBib4OrXQXjw26FE2BdGocGLtf5lmIG+Lb5VJkZ4edRtNCDxi/PzsvC4I7rZv
	 vD9l2uBrAQDjc0HuavH+EgjP/JkFAyqhleLrIZCJENJl2LLOCa0NYxO0YOKKNrznSWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EA24NqMT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8B606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B8B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EA24NqMT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so15254045e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794577148; x=1795181948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0sJrg3ZtOtV8HOj6gQCGIEhMo8dzQwv33n2YrOIPas=;
        b=EA24NqMTSR60J7rvsFb1NlgbP+jAPqepccgcLn24Q8Hnzp89aIFHCpUOjQhS0Thfoe
         Ftpvhnkf2gxM8C1WxLs7hMwVTVh1zvNolaVtvJFH9xDGb/NlE01g7t/2bb19nlePHRmB
         5fAugY3AxMKr9yBfmGuBowPx5yQp8h9s9P8pdVbMoH08Tq5MokCDAixE6Qpt/W3sFH2h
         muyoPQpoIsAc8fKqETTAv4LDhxbuuYattc2OkPCAbHfxYIY4eM33u8ht45p5HIvpm2g/
         XcHcI0jWfgHVllAYFweLFqjyz/x3RehD2KNRSKrZHZvou967aJUJDwCvpE9yk8tHWsWy
         TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577148; x=1795181948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0sJrg3ZtOtV8HOj6gQCGIEhMo8dzQwv33n2YrOIPas=;
        b=YYMhyaJos3tkPzy73awW18sBrd30hPNGGVQw3oq8+hg2aYMLvnHwDRTJEhCNWW/W5t
         i9csGiXMId274yER84PZoaX81qHcaNBmn4NtJe8ahtcervfb/mL3Z1ly6W1AAkRn5jzV
         4MZyg8U1RgZcCicSDfJwBqIkFI7g0RaeJJ8XzQIVA7RVEdj9iQcbZq9vhimBlYiuUM54
         36C2eL2l7TwlVjDJO5U/9TiRTjTDiqJ2kBoiUlBb7ES97buIG83e+PdPtNUpl+wLMPk5
         ZshMGKoCtirZPP08key0IShI6ZdEx/++5LQk3q43+wvYrPdQXYLzY4c+3Tpl+X7H6KkN
         S2NQ==
X-Gm-Message-State: APuU4Z+0FsJSoEKO8vFobXbGCbDMaCGK2PdRUPbAUU0bnqMMNDNbxnaO
	EaNQZOT6WzOWrAake6MSuniZlNTMtyBjPRWiaIIV+bzMqJcNkQ7kUMVy
X-Gm-Gg: AYBFou0EAbD1pFVHMf82xbybuuTG72OQwGnGuqXuJOcXZmu2khDx0dLCmolen7dhyEb
	k2OQaV+ZyeS+sXf48PddpQmiI3xj9e3Dfu4N3oyXKs8TgppMhU5kONwu3kzscleOk8VeQf+Nu2A
	X59tvMOKvkSmZV0PdQHCUJoV5NH8WYkvl4r7Fs/90AoizCxiVqTWV/uupUg9N6hTBgcshizcs15
	FaROB7bb4I179ZT+o9WKUuWaF/7vD0X761qUstp3zZm8Z1MIXeUMp8AFg+WQN7F8AtjaBnAF7Ni
	DIIu6eHZOqvqpO6im6b7MlXSxaJuXTLyjCdnFn25Va2u6yp0Um6pYSW/K81aa1xmBprtZR6yrBW
	mZpj3+hj9D3dC4LUHbjUfNAFTf6W9mpRiKM8ylZqS81DMPnCEY4E7CD9JIGHSK7TTdA/pGaQz9G
	WyzVPx5ft8qDPcT4EGfj9ik49XUd1YtCcqedGo/r+LFs54ZCSVmokjqBWquDfKslHlhGfyBquLU
	tIsC+rqu/+y2QuGOMdFPBW72dPy0MxV0w/ewV+ewkQUsPolQ3rx2BLw4k184oTDky/qeTaWCXkZ
	gH5EK1JiHOzN5wpmx7fUThatA/LxsCu17HiHl6j72NM6dZkil/57P49Bh0M6S5D2dJ6YLRXmJii
	rnw6P3IxcwGfrB3GtzWgMYGbdu2z078HxMEkk/nt8zAS/WKzgs6/kfERwyIRRN7wf7kFH9HjvLz
	3WTJHD7g==
X-Received: by 2002:a05:600c:83c5:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4bb55a23b36mr53365565e9.2.1794577147740;
        Fri, 13 Nov 2026 05:39:07 -0800 (PST)
Received: from eagle.home.marco.cx ([2a02:908:176:3bde:60be:5a22:21ba:7b7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da11c5sm4890894f8f.54.2026.11.13.05.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:39:07 -0800 (PST)
Date: Fri, 13 Nov 2026 14:39:06 +0100
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [6.18.y] Request: 10a47fb67340 ("tools: linux/types.h: Add
 128-bit integer types for arm64 UAPI structures")
Message-ID: <avcSVAn5Q724e-yp@eagle.home.marco.cx>
References: <avT46huKpXTv09GB@eagle.home.marco.cx>
 <daily-reply-2026-11-12-4571868778@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daily-reply-2026-11-12-4571868778@kernel.org>

On Thu, Nov 12, 2026 at 09:33:22PM +0100, Sasha Levin wrote:
> What breaks on 6.18.y without it? If it is the resolve_btfids build against
> distro uapi headers, please say so and we can look again.

Yes, that is exactly it.

I build 6.18.y natively (with CONFIG_DEBUG_INFO_BTF=y) on arm64
(Arch Linux ARM). Since the distro updated its kernel headers
to 7.3, the build fails in resolve_btfids with this error:

  /usr/include/asm/sigcontext.h:81:9: error: unknown type name '__u128'

The kernel tree itself does not use __u128, but the newer system headers
do, and the old tools/include/linux/types.h does not define it. With
10a47fb67340 applied, 6.18.63 builds again without issues.

Debian 13 ships 7.3 headers too, so other arm64 users will probably run
into the same thing.

Thanks,
Marco

