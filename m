Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57D1E1A17
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584678; cv=none; b=AcToM3/LjuTpyb3mm9bAmShQqVtrox7FhQwEdtI8UwFP+8ID6xfYsEmUUww5Sh2k/cyzVnDcdhmnnYl6h3I7Z7528aDWh4h3yCfAMB3N2EPggrPaXMKjY5ovbVZEborRcQ7UDRBy+RKiuwhUEENB7LhiBfzboZdgyF0Zw4doUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584678; c=relaxed/simple;
	bh=IpYAzFxHcdQAns7dLGmxjqP9LAC5I3ODedDhQjuHNfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYsYEJIp/A/nBKkYnbjcTwEc9eFn6w+Sm/zFSNqvY68194hg/tpnWRGxaIecAK2GGyqf5nZNTOhuDUKsCCyzDG2MsXkBJy+ZgLgkv27cGk4GOFXWP9RokSk3T6Hj+xJcWCmEgv2VxeIWY6K1iySufs/iyHZvNDxw38I8jeIRbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1YSRklr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1YSRklr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1031409f8f.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785584674; x=1786189474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PC1Ejus+MdBDGbZJkDKqwUV4T/oWh+GHHv2bOjHRb0A=;
        b=c1YSRklrcH/hoPEQRUC5U3xSp6nrnAkPDCEIQkurZMNiyjeU+cVu9MrrTljcte8Zj+
         JMEg5SB2AaICYvGBe41w12tK78UDp5y4KbmgNbDC7WtzxEE2CwGUkUA5kEauuFLt8R6M
         wJjdMDZhNHnvXTFzdibLwzWpUAf94VZog8+7kjJo2MTKmRKOMw1YOaO19p1J5U0Ys4uE
         x7vy5SsOUmrV4NFbRmh7MUunw5RSSh84onDWwY6WXnE0vZjjm7yx0ZXlDIhIROf7AnUT
         Nc1wA1EH5vB/Iu3AmbpsTyeaObfwmG2Mu3Q3YodFdyQZ/JhkXMpcKVEmlNf/0lGivQuL
         zRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785584674; x=1786189474;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PC1Ejus+MdBDGbZJkDKqwUV4T/oWh+GHHv2bOjHRb0A=;
        b=F/stBG63Ljv8o2bk55Ody5i1DMplvh6nUPa+nEgx0CiD1RogPVF3G9AZXx8RSUZQ14
         3UbW5UCJEYU9mMczf7OkDsIsgq/3kl2rFhhmIbH73lrpC3AVdEol5LNZjsPtapciUM3Y
         Y1Z0DDFnZqUff1mtu9WBBIxRbZytjGCUKcpHPnDFGXMCvr0kFRQkilh4ag4lLS/2afVt
         nC73TlXj80kyu9Oc9BUrym2h3M1oNjtAJiHrQ0ocp3ss6h6BRMcJbUTM3NfJqCXVqI9f
         +yz/yLVb4nKd6T3MWmGw3ffkn+cuwYrGJSIckvvJ3Vx500CCjZq6urjTfrFlBMQMdsiL
         lEvQ==
X-Forwarded-Encrypted: i=1; AHgh+RosOgjtnGt3TGSnhhLy3C/eErxuV66Fk6ZmwLhCSNL/n4NOzu0GZGPtVHR/Hsb/T5fmnq/8YY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jxPq7qjTzgAtIC0gRRLiMlJ1PvymjglvnprKH69pIaeUPu2R
	vQbNq9/Wk2Kf0DNHM6wLs6DomNPOP8D4QmkqhClI7x44thFfB693j7Ol
X-Gm-Gg: AR+sD13xYQPwOWJA9CLhVmgJijYW2W2zJpSpPZ+Zr+D8b35hiu73D92M2tPGT2fNsON
	/m9j9Eax1I7kgVeRFMzeWFxSJDyEsPcoCSM7LYPbQ7KwAx3F0Dwi3n3VEaS5xCUiwoMVb1ucrBE
	YbIjFWKnE9YRDV8bmXyfd4c4ihkt+SitJ0F/aAnzZpdUXJ+RFxRd48F4Xoq4XBy0olPv0l3IXmo
	LmGAdhviJMyw1paonhfB2tXFWmkkQLvPZ0UPy0NIpSindtkrKUXBZW0PUHjvMyAabFq0mmANd2g
	zbSS93BMp/dicGEBHjJBKyGOxVcG8Enqc29uw8mWZl9tQjFf/7DEel+0F1VZ3XI/ftOcoSBNPIj
	1N0o7m7UUCT96ffyuib0FwMkxYnbxLggmMb61jxiz2PJEdOrRKelHv/rsxdT7kpJWcCLQfJfXqL
	JgCRuW/S4nxiT7jKoKg7AXb6PaKAmtMpoJcl+ZDWaBchQ0R9HrjC5h05SwnEULazubqA8MDQQ6I
	sxTx1WxqK0In7bQ+XAz9OZNGw==
X-Received: by 2002:a05:6000:2284:b0:47f:93b9:d071 with SMTP id ffacd0b85a97d-47fd72c68b8mr6844535f8f.19.1785584673805;
        Sat, 01 Aug 2026 04:44:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91bfsm15461523f8f.15.2026.08.01.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 04:44:33 -0700 (PDT)
Date: Sat, 1 Aug 2026 12:44:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 Omar Avelar <omar.avelar@intel.com>, stable@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
Message-ID: <20260801124429.45d03af7@pumpkin>
In-Reply-To: <20260708211435.402426-1-chang.seok.bae@intel.com>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jul 2026 21:14:35 +0000
"Chang S. Bae" <chang.seok.bae@intel.com> wrote:

> Omar reported this broad concern to me, when resolving a separate issue
> with his custom module. CONFIG_X86_NATIVE_CPU=y allows builds to
> opportunistically emit APX instructions when the build host supports APX
> since commit:
> 
>   ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> 
> The kernel is not yet prepared to use APX internally. For example, there
> is no context-switch support for general in-kernel use of the extended
> GPRs.

Isn't this a just a big compiler bug?

Much like when AVX support was added, -march-native needs to check that the
operating system is saving the registers not that the cpu supports them.

I'd have thought that would be true even if the code is actually destined
to be part of a different kernel - the compiler doesn't really know what
the code is being compiler for.

	David
