Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F2447805
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969666; cv=none; b=PC80fp0mdrhbhKRNy+kCfPyfVzvMzJYZT1CfCMQ4yUBqBOBRjUZOVVSt5MdgdrxaxLyF8BFm8USftZ/K7EVF13HEfGXQYu1hcbY9NqpjM4ygtLxH3qpckJQYiyGd1AJYP9L5ZqVXQKSKYdf+qXIO0+vDqjA+xCophRo5OgVKcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969666; c=relaxed/simple;
	bh=Rpc3GO4+UP1CHtIfgBK47jOXKC7qTbuFu6HBwt4WZ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7VDw6gWN5FHUowg0yU6M+qlGaGpERJZqkaCLMWMJZVwfdAhxCSiCVsPq49zjpLb7gik9zM1ZgkOFxAijD8Mt31z6nYKXCsnU8CvYuM+k5+L0O/Z7B9fg5wCMb4QsVHIvP27P4BYkLVolQYcoPGMKfegK6RKXtG28lvvUqO3XD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DT9Zx0IB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DT9Zx0IB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so6447065e9.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791969662; x=1792574462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyNMPvZIEMwn3spMNOwO+2v61MNWwL1mBLifJHjtoWY=;
        b=DT9Zx0IBufXfkL251NXbgBb5YlsSOGQwY+xRoHEFTf4ZEZ9qA9FzkYBXmALqwOzS4P
         Qy/6snrp/OjE6XmBT2T4A1EsGOmTqS0u75imTIirp7YeJax7EDQmahgKD0SojH5tWAMg
         vRtgdGL4L1k2o89mTK5GFxPIzZ26CgnxVJX8CteDAo46xZolXHPaMITBE5dnOgWXiOHS
         3/ClCvktlRsg7Zet15h9f9q+T0BONV4mJdzxkIUJOm/DqPknCV2oNrAQWLw+LUPgG/Ps
         VmQjTaWyM6aZNcPY67yhsacBgj/p1ouHCasS22c965ZxzxOW3pp6jplsvJbsAbh9RK2Q
         7Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791969662; x=1792574462;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyNMPvZIEMwn3spMNOwO+2v61MNWwL1mBLifJHjtoWY=;
        b=xE36S5enK9/n5FKNq579gT9TVewlcffuiFSFrZp7Uav8gPE0DI+BBH7bBsqylVxM0M
         V4O+I6mMiVq97KU0AEvFtYQ0L/s9KWTolKbI7D1bQH6Ienuswr2/Zh4godDSxiwGVQWj
         SdMtOHP11XpXOk0/41ETME3kNDIFFraPeLLHTK3YZNv55SYsF0BLTFhIrzk40p15TdHh
         utlkta5hIZCBGE/w1SCjdH9ePq2OT/dkXdCOm5VkFLnDlLts6KkPjUv1VZ3A2L4ZPgjG
         WlRMC2/VjA5goPXHxuWKOygqf0hh15ZheJ/YBXlBGBhpSLuUR6vJnC3u5i6xhI088G5l
         oBEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEgrKDf0pYbnWgpPxZklV1ha3T4QJUjzkVc1robZ0UfdJjBqLjX1mH6zAFqL+7o0uula1YwrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyAJRKEgv+xaTizks394ExwBnohMG0Bm19ScnVqSqDwLkx3VPi
	iAsgcO0DNliFiZIOQpgFJqJMsoULEfFr0Lb3+36CxLq+ZBjKWRuDfevFu0snCKTzlc4=
X-Gm-Gg: AYBFou02PESxyMfmrX8OXqVvzmwsY14yaEdNbB/0uTnLDIkVtP29N3pjeITVt5JATRI
	chh8pDSpIGRpgacL0CKrkona+Yd1b6WPuQfUytebRzrx6R+WAdAPA651ZIsSRnoRWiVEudlUuAk
	V/cdSiTX3a4dPf6HFmiO+voR8OGgYuQp08eCX9G8rviC27+RNu6iCacmcONFswuanqEx9Q09aby
	pjjQxbD5sOjiwUKhdodElkTXjYFq1Gga+O03zh/k5QHdH+sm3z2WBegBLyEdxZgXnB9omUN05lW
	zFrrxznfFEtogLVRrLYPrkkVD0/NalJAb2FV9pfscDaL6fkDwS7eCHVM1toSJT7SQf9cQwcRsiT
	/qinVDiTpcBxDDlNFvVgZpgmBZjUYWcYjBjjS7zyA0erkNMjDo3pmuTE7ZFsUpNKRdRPHrYKApR
	N+WwTZUYilkKOytCn3i9UXR1g2WpxjrZVKIMqhZwLsqOSyxVkmZcBUdwKhKwig88EVjAP+TaxaA
	s9TX+FT2Ta4idEoA06GrcHxwwU+edmsnUi1rupqXywm12SkQeqCzJlptrJne1JaJoKJqjvmzkt/
	ekdtjSHJmt20YslQxXMyDpJetVnpHhzMVduNDlrh
X-Received: by 2002:a05:600c:3b2a:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a18e4aca94mr281842445e9.12.1791969661826;
        Wed, 14 Oct 2026 02:21:01 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm617261045e9.9.2026.10.14.02.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:21:01 -0700 (PDT)
Message-ID: <6ebcb36b-8d0a-43cc-a47a-5b4a8af02833@suse.com>
Date: Wed, 14 Oct 2026 11:20:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: module_param: Fix potentially incorrect access
 of `SetOnce<T>`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org, atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org, ardalan@uci.edu,
 zhiyunq@cs.ucr.edu, dzueck@uci.edu
References: <cover.1789426258.git.pgovind2@uci.edu>
 <20260923203145.18714-1-pgovind2@uci.edu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923203145.18714-1-pgovind2@uci.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 10:31 PM, Priya Bala Govindasamy wrote:
> The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
> But the Rust module macro in rust/macros/module.rs initializes `arg` with
> `#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
> not a `SetOnce<T>`.
> 
> ModuleParamAccess<T> has default Rust layout but `set_param` accesses its
> first field SetOnce<T> assuming it to be at offset 0. This is not
> guaranteed by Rust and could cause type confusion leading to data
> corruption.
> 
> Fix this by casting `kernel_param.arg` to `ModuleParamAccess<T>` and
> then accessing the `value: SetOnce<T>` field.
> 
> Fixes: 0b08fc292842 ("rust: introduce module_param module")
> Cc: stable@vger.kernel.org
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>

I've queued the patch (v2) on modules-next for v7.4-rc1.

-- 
Thanks,
Petr
