Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469995;
	b=I+TQwi628fZ4iLNJUMf7dd1UbIrb3vhZ2L8i6C8rodlfkfOznqOHFd9nftaaM5k+PdpY
	 QdyAc6FfqUEx8F7BS/K5Wf548vgs0Z8IPIgLK2/miIk5No6YEG6hJzDgAA0snBL4V7zQU
	 pxbO/9GpDd2igg/16I81cfAn+mlDcazS9J7k2ozH2knLx7avjDCRlB2NhhAGHEildR14i
	 Q5GcBkUgvPyJ5vRrCLiJdosXDNY+nMzGmZNc6jhYlhN+prTQD0yKeuOWjcn2D22pz1lL3
	 cINKGrheuJyN6STAzn3ErRY5H44QAKNbnhfpprBAeNI8XdUC86jBBwIq9oxVpcJ1mGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
	b=T6Nssr9Tn4UxNINYaJr19nUAZsigs9FezDCUaOXjLB6DWKF1SYD8JaUhLul9Pbvp6UrQ
	 k7vdX8LtwK3uaVMKfs6GJcIXnyZAba4rcvyiatmdoMxRlTC0dGc9INKPKvabNHdusAXYR
	 vfFk+o/VVZlPbLQ96IKy9phrELPuzIlNfKvfjeMWkYOGSPqxu5JwgP1jvkG+qZGAbLHS7
	 mT+l7inMEDCmBGoMx83GbFLtMOCeDuDW6rrM+JE1qwNDc2VKN1P6mUHL8snMylMqnAjj2
	 G6BPeBSGmZ2oAYqju6whsLsAc7A2BfxS8u41/qwoPvMaQcuCjxioAYJsXw9DORt0p6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fXBFAZ+S;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14710606A326
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 21:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14710606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fXBFAZ+S
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-716c0217635so4601496eaf.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795469993; x=1796074793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
        b=fXBFAZ+SVNzrG0yNXlS5/astelhy8/7yExaD1VmjcQ/XUyvNUu1eVWiJcwCBEkZXil
         pvfTo2USrfgCS1UKDAE0ulZz3mWt8/qptFeyhQ08FcVGBGrZ/NwO5ZAVXUJBjdy1JIup
         8CVMKQdD9cu/v+EUCIDLEhTu4uMFB6gAtRCFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795469993; x=1796074793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+PDPXDESs/b1ufFkIbKI7h6YPsn4ue61XHoi6R8yv0=;
        b=1UifsOy4XnWoJjlRMRdDteTztJQOqQWqjPlwI/lAdiSc6E7vrTIziEnZD99TD7u+i1
         fmlPuGyosH50iYCkiRuObKm8QtoTf2BQEUFgXPCSj5+P/p1kwqx+ypAZuEvJIUtdKZ6Y
         zSOO0JNnwKJ0nuty5YNPf3Chucy/n90z+gCN2C+AMpSc/M3tz+GyJOiXy5d4rrAGXDWc
         WEXEPFU9DKQPrnf0LmaasWKfcUETIrzQy3elsRTJMcoKA1vKYU8482Q+DeRL0WuSH4eL
         qZE5iwbwsrwIcq9Btpnm8nDdGG7VJ/sen35TCxhAXfRS8DkO1WGxajL6yVSfKPVWwJYe
         u+sA==
X-Forwarded-Encrypted: i=1; AL+hErFdVCrPPZehGLSK2LJWWOfxRaqedXpCjfJMDzL12BIR8mBVniylU+lky0KSTmODtoWd3s/Nvio=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/go7tCKReM0/fGx5jqRhQMYH34X2MKC6GpW3dcdbbWBbqij1j
	wFJP0YcSt9lwYLBRl+iJopR/oQf3xuqGdVy2Wu/WnnMAYNK3hZSMyl6BcmJI8sKtCj9oSsUwrrR
	+WqtVT7A=
X-Gm-Gg: AZFdTZdjQbisJrhkxcPN9wdHyLGcTTnxa3wJjdXWpuKmX9YqXrgZqCn3cEwOV/32gYG
	TXPvdcTslXYXTl3PBY+KRr523RyXc2lLhzhJPR9VZvh3fw85Mv5E9NzWTsK3p0wd0DPZ6rHKjpr
	5/zIFvuuwl7dTZ7V+TGpZu75VRkTVbCyIPG9OJvfgB+BwAvhG4tf+FlHxURkXGwAPBpqx5rTSdk
	PlP67a4t3rbR9Oi7T95tFV8wnELf1V/BP+fyU+9I0bDovY79u/GTBB/chc4a5R4WyhQII/NqCKI
	iB6x3PZjzZYNU0+2kcSR1iyNGYGy3xHdWCpeIOJnCSop6RtTkX9Er2/71kH2byfrFKvU8dmLU6Z
	pRrJQKgHleuKH3ck968ivl3/2Z6QCsXpNLTECYASCVJDD4I685fXC3agtloLPw5Cwcm1UPGc1fb
	K1YqECvDylQZ004cWH6Hze662gKqON6Ehc5mBkWjsZ0fEocTD9y1jH9oS5mV0ANSLZQuv7kjZzE
	/J6BOg/aobwX9CiEcrUF/gEtjaQz9lGvZT6DRKi6jV8mi7PmlTYHz9QWomrYL+5FP8dBYESldhM
	Jake0ddQQ460qIFFMgtxckhNsI6I5Ep/CXyJsw==
X-Received: by 2002:a05:6820:4515:b0:716:bf4e:4558 with SMTP id 006d021491bc7-71b394f4d53mr7216089eaf.20.1795469992803;
        Mon, 23 Nov 2026 13:39:52 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380bdff9sm8213426eaf.11.2026.11.23.13.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:39:51 -0800 (PST)
Message-ID: <b4e4fa4a-2763-42da-ae9f-3ae65132f678@linuxfoundation.org>
Date: Mon, 23 Nov 2026 14:39:48 -0700
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
Subject: Re: [PATCH v4] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261120-cpupower-freq-set-use-after-free-v4-1-928675d53a23@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261120-cpupower-freq-set-use-after-free-v4-1-928675d53a23@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 15:17, Lukas Beckmann wrote:
> do_new_policy() directly fills the unset fields of new_pol from the
> current CPU's policy. This is problematic because do_new_policy() is
> called with the same new_pol for multiple CPUs by do_one_cpu() in the
> slow path. This results in stale values in new_pol being applied
> (starting from the second CPU that should be changed), and even a
> use-after-free (for the governor string).
> 
> Fix this by building the target policy from new_pol and the current
> policy in do_new_policy() instead of filling the missing values into
> new_pol.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
Applied to my cpupower branch for next PR to PM maintainer.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
