Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697226;
	b=LBbCfVCYVadwRxIbCrKrUOBAb9qIlI3KltU4OOFwVYTjOyeLtSleuwgqXeqXtUXU7/IQ
	 npSOZyKOsSwQ1ixa/4HBdPfkZ+QBrLZwYAuAX/6BblruL8N6GDOBTyUsWyBfkI4A830Py
	 XigydEt3TvA8/4Od4sGB966NPOH7X8xkXWFixuP4w6CavFqz3PViVUAH2AzmGZZE4H+j6
	 JjnubK2oU+tamu+q3G/Ok2teukp6XYlrm0XEDVxNGT4/w2AJ3HIz/ll6Z8R+hXzlfc2jx
	 r+bIjlAspAqvxXPiifuygplleVfeGGKy3SHKiTCESrDaaE11I369JzRgRbAQPKx5k5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
	b=jYf00t3x7RoGPxuFGELyRcUvZirluStFGWkJDf9YaV73Xua6LfqjmJndvvZbQIf/dKdc
	 VrzxkpVSyFZivMvpbFzGk2+XchUDYZ2EtSZS+TlRCEOxWKfRT+qZFELl0wPoeUT1rtkeQ
	 +pUq/o2a9ffRawHDFYdpc0oNlTDNOZ9LUCmN/SmEZ3OBmmHqrjMD0cB9vv/lame30BKg4
	 edshhCxSM3G2iHwtS3WD2nzzQM4hHbb/f4QjwCYgMZkgqLNAnoz+Th/uIB4MhGXAj+s5N
	 qaVvzmr1mcyr2DqT3senqdJISI99oPEzgIHMNzCQpc+Cju/kv6glzTiZ4csptdgxoKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=EQ7J7XaI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4B606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=EQ7J7XaI
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ad099391dso3371963eaf.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795697225; cv=none;
        d=google.com; s=arc-20260327;
        b=jSXAvdxhjHKjF7MgmBqye/HDS8O81+y+R//9rbXnqBEuMwkYuO9NO4iBZiMuwrxvSF
         iSfYxrR3FqIudA2kIms9b07q+gbTTed22uxKjTYnDGSnnXt1aempJwB3NnzPFTbqDfz6
         n/Vm+c1udknUKPmKYFi0o2J8CO1qJyKmq/mQWNhQZ1KXjJAHj7iZ5aAsBmN9XCVRhLtM
         iguz/xVID/Av/hPpQkX6ehs07u9srl9bu7dseioD9fowlsc2gbeOH/6g+UKMAo9t8ihL
         7Hnz0ZmYKB8PvoUUWvOTA4oDYwWKvzO0PVc1fGnPslPRjl/8QYLU73pI92PAjnXwtz//
         41Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        fh=sT+YvNwG/vKPOxhKneC+nl8L5j4pFoWBDSk4B23t1Y8=;
        b=lEZGRLoVjiDFnY+SLj8xfO+N8RK3kT0+N0VpqQLLWD6z04z8Jt0HKmm/W/JshpdUGs
         dO5XDwYqOLODFK4+CdArIwd36peJ7LcsNzTu3TG00EaR+Ur7xd3cjBsnmrOhoz0s3XLS
         jQJQq8GtNdyWB13AdfDy9HOMLw4Xis6HRVeOkBJJ+WsIaaBgoTRBYNu0uyTt4gsW0VKH
         lAJKDBCcdQeMreZHcH+2DYooVAaJPhGWV4Thb7BdGvOZjG55cDP3FoySkyO7xP+W+OLQ
         kxth0LGR4Qev+B3c5dhUnq5n7lWxKqv7jC6+SSSNvMiNQ6KNU8/Q9GSVm+DCi6bbrQSJ
         7wRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1795697225; x=1796302025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        b=EQ7J7XaIadF3uAn4gbGhDW9T79STu0JpBcKnGDPwJMdcYfp2vzoJ4A3jFOxtwEDQqp
         dojXRykuli4jE+05IotP5k2+v+UoX3fCRGvkQg1TNhJMZWlrqhOPq83sBJicQc4pFHt2
         /cleHU92klXpCLQCARLmfaNbraGAaItzY6T27iQIKsRh6G8Yf0L7y+PYNwhxGG42LuvG
         YqEIdtE5gXippnFoyU8kI+xk6QL+vl8rwIzufLbB1GrLfLqKbuBo8Zek4uVaddpq3xvg
         LuYEULMIbvaKfNsFn1u3pvqDrcI+/vEqpPxHzAIRwIIMCSNRDGj5FS87s4xkEfqOdC85
         wZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697225; x=1796302025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0sDCO1ovM17uMu/VOcrsRpcY05yXe7IWxHNvX+k7W9A=;
        b=e8dy0TfIpmXxQWMx+exsDXBrwaoIuhtmFqSpSHDlh5HveFWQ7aM+L+NEO0aH5NfVud
         cEaaRie7d7Zm5S41AndhJ7suPiau1GNdF5c5bbTaB2tHw3qik+rvGVsjU6JuI7TAdDTZ
         dH9Y+ruteeMxrlQ1Cbxh7d684Hvw8hiwTpzzKOxTpJSy++wbzl5cEgHBhnJAsLXHt3aW
         IeVVb9o01V9kdzQgHbPRKasVgML5G2AA+/9OBYm+NMT3c0c519HlhR2Q51HUdBKbDxDM
         bGkgVhORR183QUQoDOHhtN3RSQfKGFOtxsWQRIM6qU4BIBGKmWWcQYbUDN5ErqPWXH6W
         gX6g==
X-Forwarded-Encrypted: i=1; AL+hErGpH2/qWNxr7+6qdSgqPHiJo9s9trevCYbkvizP7hTRShNe2EAqJzLqfo5gOn6VgMT5ILivL/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z90kTXWZ4wVeOJtbJtgpUmL7162uQBZMBRmOhPeug/flrgyg7/V
	+9rDigoJTWY5hILC7BN/VO9owA3TZ8wpDJ7w2zcQMhBSH0cDu0Dtc6AxrxS4inz8i0x20M2hCq3
	fl2pH1i7Q2bGzPHMe8u6uF0LVCVSfoRcJscs7x7/t3A==
X-Gm-Gg: AZFdTZeBoyIo0cHTUM9d5wJw8XYGATVBDf6QEHRmHdfEkOWcoFHTsCb6/jX6WjKpg5i
	TIsoN2uyw68bvX4uOmw03s9TJfw6vVlGYgSQuFN09ceQgGG5aTryPoz+XdHLqjCjtW8rdVpTVfZ
	nb0XxD3nsHWI2xpjvIfbVHBTe287kEqThMrLGZLAx6TeGhjC3VBOkROpgmHFgn/rVp0ylXv2eJy
	4b6AdisLYq27EgaHlyVlj6iuWkpK8Aiex+y0sEbB4vuGqLRx5Z+64NSJNkFrLVWs0S8rlj0Kr/i
	0ZmOC+1o8YHWq4sR6Y0TbIgUVyJXp+lANj/7o5DUv0S9KHRKWZAzmKwSYiQ+Mm0DnB3g9sCHr6V
	r1CaZDDwVaE2Jiudi3iytGKai3fOHp42zPT0AqFYKPqDcjNA93DEpPlARXPDeB35MQiu1qqUnIm
	CHdoQfDSrNKE/lEzl6ict9y3aynTGNZpSvRJP1O4cirIRvgW9p7n1w8dZRnEpGIesaMP3U+DWa
X-Received: by 2002:a05:6820:55da:20b0:717:da:ba2d with SMTP id
 006d021491bc7-71b3949694fmr12426690eaf.42.1795697225084; Thu, 26 Nov 2026
 04:47:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
 <cd7bd4428398413e16ff214fc46f5d65076757d8.camel@intel.com> <436c641a-9d35-4695-b41f-547c46479a5d@intel.com>
In-Reply-To: <436c641a-9d35-4695-b41f-547c46479a5d@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Thu, 26 Nov 2026 12:46:52 +0000
X-Gm-Features: Aa3M54qbjy628W_XZiCsTaWPDZAxjlqcXQ_RCIdX0UR7G-Q3f0Ja4RKHzIf02Lc
Message-ID: <CAKV3HMNoCbBeyAsH-UHHC2wWm5fE7ps0mo_E3TKJw0Vk47W43g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v4_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On 11/26/2026 5:42 AM, Edgecombe, Rick P wrote:
> I think something went wrong in the send. All I got was the coverletter and it
> looks like lore did too.

Thanks Xiaoyao. Rick, both patches went out with the cover letter and
were addressed to you. Lore has them in linux-coco, kvm and lkml:

https://lore.kernel.org/all/20261125-tdx-guest-quote-poll-v4-1-d89f26854b88@flashbots.net/
https://lore.kernel.org/all/20261125-tdx-guest-quote-poll-v4-2-d89f26854b88@flashbots.net/

Maybe a filter on your side caught them. This pulls the whole series:

  b4 am 20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net

Happy to resend if that is easier.
