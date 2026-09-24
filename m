Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C2396B9A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260404; cv=none; b=nnbzzjT5CRQfi5OR35zBlVtezZVqddYnGx4IfZ43YG4+uIVVByxX5UldCvLkvVWbYVeQM6xvcec8fy5EyLDSV80E/i+5RpQDdOnPH9b5pBzCbi+QRZy5ScG8Vy2C1QbGl2XbIShTO8rnDxoP9Zn5WdZ1g/mCos87QCUI0OfNaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260404; c=relaxed/simple;
	bh=9q2JkCpKEO3wCjhTU1a0AcGdNAyPRupPf32Qf9TbdDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7prkU0+2/9Ki5bZcf1aE0regs/b0XLFFz/aR29mm5Axv1uLcmUKpOkfu3wI9HganDoU4r9ut7JaLqD3gv3bpcctBSPFMBRxrVid5WbgWL+fsXCgU5GFWQy6aoojl7VV86zpqAOgCKYleU/ZGcfhIWcHIcSnlnck6Z4V223fVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T633RDub; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T633RDub"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so1731619f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790260398; x=1790865198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FuCnYdBtAj16EPbx5vQ5K1jaX4oAM2pn2a2TsN4AS8=;
        b=T633RDubM1aRw77hpI3j/zDa5OUm/+9/E2b1tz8fBTNFfuYQihu7OmZoWHecl7yybs
         x0nmI8DBstKHBIDk78MyQiFqf/I5unV0s1y7iiQFYZhnfEne9N2YY6TOO8vcuxQVfycZ
         IGixaiY/jNIbYd5HWph+NGn0J3mNr0x+em/0WlsydstONt3h2KGAPpcW3RUu3BrGIVXA
         358zq3R+JBzEGoVLdE+U5oLHJpHQEvRxqKv/4O9EPn90lu5bgXa1nZlR55QTkVsiGsyh
         Ija6tWFqcT9P0n+lBRbYSV8lzizLQV2ywbKmQx2JPbBhPoafbBOkZetcJCYpdtdzmXu8
         6pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260398; x=1790865198;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+FuCnYdBtAj16EPbx5vQ5K1jaX4oAM2pn2a2TsN4AS8=;
        b=uPk29UOdte69HSyd6jubsto/MjS2Ues6f1Gjwzs5PTJL3z8dXM0C55kisqpBtGeWpw
         3mNMcY5hvGKs5voHz3GNpFNSWHdR+31pdRTnyzuYehl04KzH/uAM2iBjpa2+jw9gQOww
         tWeHy5YxtFnzSx3tz5sckbFsb6GXMP/mqGWKOnEzzL3Cvp320pZWEcDfAgRmSMrANVom
         hLr6QJzRdLBomyHF3lhRDPA4wT3OzkfcRsM3aqCpTNuGqjnSJaJP5LhkEs5l4K1Q1Dgg
         oygBUuUupVgg2OrYE5J1b3ZVTynOKNnlmxG9VIUGXH2IpRnXvzjAp4nP2f2hR1Z01Ea1
         b6jw==
X-Forwarded-Encrypted: i=1; AKwUvBxDYM5by39k812hZAKYeuZxPc8dQ3o1Vx3doCaabaMT61hL6mS0wr57lxAuXKK1Lbst7wGc/yg=@vger.kernel.org
X-Gm-Message-State: AFuF++mbzPK5m01/e0ScPzeEG3vALT0GEqjj3kp23zepgObhZHgCf/1j
	+nn9vtubYc9r8Rii4VVBlp2TIVpbpoAQPFTY58JoITNSE3zz5vtdHSEvtjwThg4xpr0=
X-Gm-Gg: AYBFou30NFCOw8tNMulTSWdaE4tj9PqFhFSdJmxMRzrUuV9LSPUFIQKt3DNPFQyw7Qw
	zS3+di9JTsdbcm/D2anMTObaIoIJQ2G5V8y/YXfRI9yFarLPf6Avi2QB+x+eQDpBIVx/XM3x/bu
	FCtcoo3zk5bnLvPFdsoAl0tVcB1WA3AmZFs15VycLjuaAEp7nToe3GK47kpVusISCOG+R96jby6
	QA3iprTKToQWUnIY7qG3tEsJ4yHZl3/X2mGXAV+95t2uTEuVQIftJjAAoh7Mful2KHWQySbX5LY
	Q/eFjgUpW8LxQyDz1fbqcL9A2fZiEESAt5PzBMJgP3x8BkO+6p66fBJbTkHJhHPFolsT7GKEFC8
	1FRZyKmRf7emQeo/uy7h0dmg1C3bSrQB6O3vGul+ZW3elPS/52YeyjgIPekR6iny6xy8EG13Ml8
	rjO9y1PlZ5/nAaF04fidfpRuDEX+FlRvxrtzXAiCAvUfrXJO1Qvv3nltmynnFAVs9vdcyhJNeq0
	V5KAY4U95pzOzJ+NYiq0jmsAZpfbjBKwGs=
X-Received: by 2002:a05:6000:2204:b0:487:2387:7c9 with SMTP id ffacd0b85a97d-488717202f9mr4525726f8f.14.1790260397919;
        Thu, 24 Sep 2026 07:33:17 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684862a3sm13918500f8f.7.2026.09.24.07.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:33:17 -0700 (PDT)
Message-ID: <8f07e4cf-a3be-4f43-8efe-e7ae4709c3d8@suse.com>
Date: Thu, 24 Sep 2026 16:33:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: serialize lookup_or_create_module_kobject()
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260918100712.3124994-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 12:07 PM, Jiakai Xu wrote:
> lookup_or_create_module_kobject() first looks up the module kobject with
> kset_find_obj() and, if not found, creates a new one with
> kobject_init_and_add().  The function is called at runtime from
> module_add_driver() since commit f95bbfe18512 ("drivers: base: handle
> module_kobject creation"), which means two concurrent driver
> registrations for the same built-in module name can both miss the
> lookup and race to create the same kobject.
> 
> The loser of the race gets -EEXIST from kobject_init_and_add() and its
> kobject is removed from module_kset by kobject_add_internal() before
> the failure is reported.  The error path then calls kobject_put(),
> which invokes module_kobj_release(), but that only completes
> ->kobj_completion and never frees the dynamically allocated
> module_kobject, leaking it (96 bytes) along with the object having been
> detached from the kset.

The patch fixes the module_kobject leak in this specific race condition,
but not in cases when kobject_init_and_add() (or sysfs_create_file())
fails for another reason. Do you plan to address that separately?

> 
> This is triggerable by unprivileged users, e.g. by concurrently issuing
> the RAW_IOCTL_INIT ioctl of the raw-gadget driver, which registers the
> "raw_gadget" driver on the gadget bus:

Nit: The device registration is done by the USB_RAW_IOCTL_RUN ioctl +
I believe the raw-gadget device node should default to root-only (0600).

-- 
Thanks,
Petr
