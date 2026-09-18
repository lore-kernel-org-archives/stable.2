Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818583AAF73
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722017; cv=none; b=Mk1rkYmhcy51lnIViSx8vjE9Ozg5ZT04315zActhG+piRn2aNR/F5ktPUF9WrOH/ogRi1Ge7rm6p9fkgBmZvkO9jlO0vmnEnL/rZNlk8drdE3f3U6tXZ6CC1u5/zRsmzZ4rmM1x0xdEZ9mAvKhYGROdciAahY3QpcdyGaoxlimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722017; c=relaxed/simple;
	bh=4n1CyRHEyV5SVpfm1JQykNStsTaOrE34HywrL9qCtyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjhMHiOhMKtlgQZfTWN25c4DW5BXaBTssx/AsAGOuZUvcOy2Rsnq2JsLLw0GWnEiKtmcCDtpzBftH/JIegbSaHlHBorDe/of8iiujALfC26kaoWBmDXq4j7B8P6l0CQP/5gZH0xZZxBxPiRN4ZTyU2ERJR7d2P8EfxnozXZmOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=rpOPjNyM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="rpOPjNyM"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 077AC3FB7B
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789722010;
	bh=+mE7Rgj77Vv+ava52jP42JJRVXXS81IMNvL+VWuifv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rpOPjNyMncClO/BdL70KOeh5l6cpCzH1kWINyK2YP6kWQFQ1d3yithr3xRHZYZEwY
	 rjCb3gJipyTG907xKwtLEBYBMHR67Jbyz9ThPS+UgWpu1ecU/hlUymjMLy7LJ20Zt0
	 xyZHV+w3kb530v1gajXkzfv/He2PZYKTai9uId5WvB9zHtIFufLUbdY13/DNmXbpfD
	 nY2Gk1VKQ8DoXv6Hgo8E+quF7ZH1wq5xvPL8xjqFypCaqPo78JeKKrlChgND+8Nkd6
	 a58UK+fe0ah4ByFC5/E7+xQ1o42y38/mJ5qCv8Qbu95+VTmttcJIzEYJMWiQDjKLXD
	 ebVRiRNyg3houy6htSJRIbU4b8q0VnF6ji+z0hk5t0D2MsJW9fO8QCZ3GWBcd0BiVA
	 afiqQlQRf1gSy2L/DGP7NwnYztRRrRHFKFo6V6mBeZb4Rzjzxtt0jGQUC03KntWPMj
	 psYNNT+AJII8MBsSGlZS9gG6cTDIv+5WWGgEW7tP+Z4r02YgVMG7t+Bc6IXBB3QUAs
	 gNvgvF3NcJFHK4d6yrc8q4aOoTs9fGEXbIDo8mr9fbKTE96RHJ9yCkws+nQ91izFhX
	 y4ZBUmmYfARJkD/aTZEYD5kckXkmpBdg5VLJeZHCl1kIQj28vbqtbNb3bp/GLC+jD2
	 +1hvlNViIjJ/7hjS8aDtfntE=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso610830a91.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722008; x=1790326808;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mE7Rgj77Vv+ava52jP42JJRVXXS81IMNvL+VWuifv0=;
        b=mscnfCExOfspPi1j3wcTMGYzi5yvSkdqBL2PVfe4l/xPLcmeDYJjKN0T0b+/DIBZY8
         wUToC3uM4gz0HL1a8zIbgzyPxOI5SYcEddD+oNhgHLV8rgA3tqR0LiZ1nrrrM8uckGzV
         9fG6WyXvoMqTunyJJfrkHbB4sQubFe6CVtCMBhImY6jqYeWZvkpUCnBRrHzUottjCX2J
         AOTziPvl7fn0JBypeoMB8DdgQQN4v3luTh4I6g1N5vjXT7EQ6cssLipQFtQSUCy6Sa8Z
         tkj9AnIPUBuZgcjWhhtSaT2esel4lQYsxLnbwBu2BxIJ7Pv+k3JpfXr7w/h6UN6Cd7fj
         LrSQ==
X-Forwarded-Encrypted: i=1; AKwUvBx78F7GiayA/sLbCuY2s9NS2U7kgnlYioBqBJOKekNQiOG5SuvA3iPljII3QG2Ij/ISsCLS8As=@vger.kernel.org
X-Gm-Message-State: AFuF++nJQYdpReC+QD3QPgjIKu1pMi+YStAwLY7lzr8hNqp7bCcGoIDL
	dJEOwZa5HM7rUh7JqmBCBVvpoCwbF+p5gJDRsF2kxHeAD5W72Jfpk1yvZrwFmuNNIJGfGROcy6+
	LPTT7wwuthAg82cgpRf4c/MWQrTbnkGWTzlxZVdw6bhFyKpZX35FqE4CYulJMnU8Et7B5ffE6Gg
	==
X-Gm-Gg: AYBFou3krlxPQXSokxfGzCgIT3s5KRM/xHkn2EowLWbTJW3LhKpl9Rpzbyk4lrUy4rJ
	dg4izFjDMpVeBvbR9v3reKL46Yt0Yb4CuDUnzGemgkYWsHt3+heW0dsd4/7mk0IvGzdfQYAiO+B
	8h8vljaIi2qyULMI/hDuFXwQQt3zfeKGR77UqX2ePAGmg+ONlkuJNUav0pgt4OcUWcqiyCXqRk3
	aSLc/7cBQzgzO4CDC62tBbGFPTZ/KBsQAzca1jxYHP2Pl/ff9/JZLHWDZ76Rhe60LMNzhQp02Ox
	PNgsYTha9XcmxaH1g51XM2tWl0b47ad92SjbXx5IIPVJXioYchf4gKnzQpP2cg7SD+jolkRxbTd
	lwA0cQWMwiUU2TEM=
X-Received: by 2002:a17:90b:57c5:b0:39e:3554:4d0e with SMTP id 98e67ed59e1d1-39e54c584c7mr7802651a91.1.1789722008394;
        Fri, 18 Sep 2026 02:00:08 -0700 (PDT)
X-Received: by 2002:a17:90b:57c5:b0:39e:3554:4d0e with SMTP id 98e67ed59e1d1-39e54c584c7mr7802548a91.1.1789722007897;
        Fri, 18 Sep 2026 02:00:07 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-39e5a50cd09sm2095690a91.7.2026.09.18.02.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:00:06 -0700 (PDT)
Message-ID: <da2651ff-ecc8-4b7d-b9f3-99f148844ff3@canonical.com>
Date: Fri, 18 Sep 2026 02:00:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
To: Greg KH <greg@kroah.com>
Cc: Ryan Lee <ryan.lee@canonical.com>, Wentao Liang <vulab@iscas.ac.cn>,
 apparmor@lists.ubuntu.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com, stable@vger.kernel.org
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
 <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
 <760b1f31-32f6-44c6-8a5b-991f228a327f@canonical.com>
 <2026091851-recent-ungraded-23eb@gregkh>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <2026091851-recent-ungraded-23eb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/26 01:24, Greg KH wrote:
> On Thu, Sep 17, 2026 at 01:18:20PM -0700, John Johansen wrote:
>> On 9/17/26 12:19, Ryan Lee wrote:
>>> On Thu, Sep 17, 2026 at 11:59 AM Wentao Liang <vulab@iscas.ac.cn> wrote:
>>>>
>>>> The inner block in aa_unix_file_perm() re-declares plabel, shadowing the
>>>> outer variable that is released at the out label. The reference taken by
>>>> aa_get_label_rcu() is thus lost when the block exits, and aa_put_label()
>>>> at out is a no-op on the still NULL outer plabel, leaking one label per
>>>> permission check on a non-filesystem unix socket.
>>>>
>>>> Drop the shadowing declaration so the outer plabel is used and released.
>>>>
>>>> Fixes: 88fec3526e84 ("apparmor: make sure unix socket labeling is correctly updated.")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>>>> ---
>>>>    security/apparmor/af_unix.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
>>>> index fdb4a9f212c3..ecb40cfe7e14 100644
>>>> --- a/security/apparmor/af_unix.c
>>>> +++ b/security/apparmor/af_unix.c
>>>> @@ -758,7 +758,6 @@ int aa_unix_file_perm(const struct cred *subj_cred, struct aa_label *label,
>>>>                              unix_fs_perm(op, request, subj_cred, label,
>>>>                                           is_unix_fs(peer_sk) ? &peer_path : NULL));
>>>>           } else if (!is_sk_fs) {
>>>> -               struct aa_label *plabel;
>>>>                   struct aa_sk_ctx *pctx = aa_sock(peer_sk);
>>>>
>>>>                   rcu_read_lock();
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>
>>> NACK: this exact patch has been proposed before, and unfortunately
>>> exposes an additional latent bug around plabel handling that results
>>> in a use-after-free if the shadowed declaration is removed without
>>> additional fixes.
>>>
>>> I can try to dig out the relevant exchange from the AppArmor mailing
>>> list later, if you'd be interested.
>>>
>> The series Ryan is referring to is in Linus's tree, so you should see the
>> fix rolling out to stable kernels as well soon.
>>
>> 6d25e7b47616c apparmor: fix refcount leak when updating the sk_ctx
>> b1aea2c196077 apparmor: fix race in unix socket mediation when peer_path is used
>> 4483efe4f2151 apparmor: fix shadowing of plabel that prevents cache from being updated
> 
> These are all in stable released kernels already for many weeks, so how
> is any of this still being reported?
> 
> confused,
> I don't know, my guess is either using a distro kernel, or not having updated
to a newer stable kernel. I should not have said "stable", I should have said in
updated kernels.

