Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194240098A
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611991; cv=none; b=Z59j4jhq8oRkFxapRx1j1JQRXbOgxTh67IQlBRUIHgULr/6jLDBUM6V+0QvfHbyL2uFAWQr5FRzS5WYQFJmb6Prrsam3/GEmPYX5au44YfvMa29wI2E4jx0QJ74AqNbKpIEsBo9EY7FkofhBzx23NYi4JPleQtypWRfBGk1+DW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611991; c=relaxed/simple;
	bh=fZVaZ7TjMrKw7+i2lbImOkpXxSg4IUmytFvvhSuahqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNsOUGL3fXo5odjQ3sggwNoTZCiZQeGl+E2Lr6enGiuw7JXUcHIZMnrhaJO1jdMaxnNTz7JUs/LAszCg923GvSwGRefnum3PJWyU8h7utpN/7qIT5OU6ZMHcBxGRu2bQcewa2oRozmR8KIb8wWECuMq7cxFo2mdaqmBebRtJEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Enfym+/z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y25KmcrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Enfym+/z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y25KmcrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786611988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
	b=Enfym+/zhasvYjxu8+9TSBYeqO1C8OK0cQrwrhjGMcpJGSKp/BnzHvoD1MAN/zP2qoBLLn
	he2WyT+GOY2MVP5kU/0egPhlz2iPXUOVI8eDt3N3JbJJ3shmeJcBLFNRH1+r9t85683Mf2
	T12R+aWtdWsevbBMJpqQ6mNM5d376nw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-xomBc1DlOGazBZm-SFQxiQ-1; Thu, 13 Aug 2026 05:06:26 -0400
X-MC-Unique: xomBc1DlOGazBZm-SFQxiQ-1
X-Mimecast-MFC-AGG-ID: xomBc1DlOGazBZm-SFQxiQ_1786611985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso1398950f8f.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786611985; x=1787216785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=Y25KmcrEbPrKqaM41MtTogq9QEbFTjLISnEHcpgYhWx+5QXirB5IvxGrzXfxGNcLMM
         EaJDM8JX37dvRMT7gaqn2p5xQ2YI1Iaz0Q6T2NhTeVfJ+wXyZ0cyrghbtfkMUWYOsoTG
         epJS8LZ3RY34EwZ5G3o3XXjXGdQzM2EXI36AcNKzeQxuzg5lJSRzQS6khzWc1q/OA8vp
         9xe+0L5Nrk/bzeYRaZ+TnSec6cMDremv4yS6yBjfRr2wpJYjYyg1WEzK5ze9Y9Lf1mXK
         MPdrNXG1aPacmLzDaFZlUVaBTEO4n6xukCMuuzP8GK2b/fDF0YCZRN5YL9sAQs5d1++p
         r6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611985; x=1787216785;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=rKjyzXw7gn+fJ/Hrw3b6pR73HzTkEW6Pk0jhWBfjEuS0f5/WiDzMkgJFkG9H++Qsxi
         Z/WdK96bUDkFHsg2OdHArB+/ARBDAdc4KKftm88mpte/nkmhWRrMhFVAVp/8Km6MxAJh
         hz98fsGzqEzq8ObVBckg9wiW2FCeT5F9osihrav5Z8ne2s1+/ZuJNNFrjTvGuriHGVl7
         uSvLKHLbjbZ3wl4HYGgz25KHXEOSKoHwg7TT72xO/uCqHGSTSq3+HzuXKgASfxihFjfV
         Z2nhcWQMzWFSvXdqVWEg/FpkfGRRhfNGXs6HdNOa6WmCo642XHaw2UdojwpyXVGC7y3N
         gk1w==
X-Gm-Message-State: AOJu0YwhYZzTbN8rTcVbvcbAiS0GdUkXzF8qMvd4v+pWKZ9vWvaZYWkz
	des7EkmATjxFJ84fjGlarJm2sW5aBM2X9ax9tGtDOZwGARpgBhMEur+kpc6KnUzUKVxEvRQEvYg
	vBKG7OtsiM6/0oLc2ysSqP3CfLsoLZuxSsqqx/3jLZ2wQz44/MBsnm8G5jw==
X-Gm-Gg: AR+sD13I8ttYHBS5G39rcPOKPqjiR63Gw7PuCGQ3B9C7/XlPhXMv4MsNV7lj0EP8WoM
	DNFqlJW/Ey0L5ozr28CAFRMtXQz4g2wkDI9sRqbluEtwBy/RMyvIbqmXLJIXJSyk2ZbC2hspJm6
	Rm5dPViN9SF4sYDIWKK+KOG3m3gsNX4+WFwFJ65QjaEYULzvOlFgiwDqZ0BTFPv3WwmUOM2e1Z0
	4Y/CFZ0+JxMKJi6/ltWncssiZIDoXpU7pCKk/m2EP1cmmZYMJfbR507TPe0m0/SirNSmO2Ku1m6
	9BBGKaGZkha3D2kqej08JnhFs9KAytILsU3zRnBR8rhi3jSTksYXYe1yNOQX3VYRCEAnO8t/cGU
	imJegdY7/Uk6bArDiCDdJsFGIefHt+l9X51b7opaQl6La4T7xWfMwT0bJ34X64oBA0Yo4XlG/br
	E=
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799166f8f.28.1786611985346;
        Thu, 13 Aug 2026 02:06:25 -0700 (PDT)
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799073f8f.28.1786611984862;
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6119566f8f.6.2026.08.13.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Message-ID: <0c4e75f9-f7ce-41c9-aef9-a3b3b474c695@redhat.com>
Date: Thu, 13 Aug 2026 11:06:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org
References: <20260809094418.901607-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 11:44 AM, Jamal Hadi Salim wrote:
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=1).
> 
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
> 
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specific device")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
I understand that Jakub prefers going with this patch (with a correct
fixes tag), so waiting for such tag landing here ;)

/P

