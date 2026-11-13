Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582951;
	b=GHz+IcMEuakOeO/XuGChykrMDhGOYN9EEQgM/uotkv6IiALu6L7LmiKxZ1i50gqh36EI
	 LJoLvAgvyDS9rnDykH9f2xijIlUH9tHaKaagzfTq42EO/pEY6xS3K5iMNwUAeQ/FCG1YT
	 npRYtU3q0qaNjlH5u5f1KLg4jrhipTvCrhYtinUYuwFTd6yL0WJukezdZ0pRY3bTC2B9S
	 Pe8KjFVDKDjGdC7RAp+gUY5hdQHP9PpR+ePGzh9R8N9wZS+d87wWuzzZSVcfHLRtaTuBF
	 5SFwURo6xtkae5F4RbhEgPzYlCDZ9XJEfs5kSnvX9Ew3bjhO0gnARhivcLmmNpbH6RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
	b=3IGXMmC7C1sDO//8pjcJ5JP0glIiAHJmUvWqqPWSni/JuYTxI+E2K0j+d4PWlvR2n2V8
	 x/5AsH4hUhBciIrdcdYR8qxkH5J5C/E6buaPTTZNGd9VuDGyCMXjK2OXbN4HkPEHgujyb
	 wmZ0XOLEKYkZBoyTDDYMk2RNqXCHozAspVzElc7soJ4JscZ+3141dDLBNTsYe7bpD3r8C
	 iEd3bj8xy1FeBTu/nsfyyCi1u+btbDDdXjuuObjrd6Wh8udTRmRe+37ZPfLEBYly78i3V
	 oslcksyHS6BWgVDLXJUjGhtP9FRLla5qQttvXMx32oIKN1U2P8VDaqTEsE+XnbEvQ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YK37+uqO;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88882606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88882606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YK37+uqO
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so1584125f8f.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582950; x=1795187750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
        b=YK37+uqOIExWt6SEWEpNPNJi1YLCKu29di/qyfZKUEYBz3CWhdwJlkttYPW+Mq6DKn
         7UBFA3Oyo4yaCQ3V2ccqGJ9Iq7IvQk47WL45MAkOheXuvPrjmSVrupIiHS+Wufls7MpV
         ZbowRGChbGgbZxy2IHzig8u8hk30TVJldWTpCXOQQSMQghSUqwYWTmd0UIzDFfw+GgnC
         khg1U3qiQ728D03f7VfQRizVVarpVgeGXA1prFs1v3KmHF7qs4R5tieQS03B5zmh3Zkt
         no2wx1T4hf8I2NTZ9UuB5DOpqMGUSd1MI3al6D8P5o3wAdiz4MtziK64BFV76M0+HfJX
         Jbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582950; x=1795187750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
        b=zyi43esjLDha3OoQo+8s5jHsYtIvXIHKNq0WP3txI0uqyYkBeU3RE02w6tV03rYJWW
         isgoBfyKDRkVmm5N3/5V820bI25eUJkI2O7i4tq8HZzIxDzdILiKCx9TSFwFTWXVCXIr
         yTbyuxCtYNiz2KMG+IoJRWzoCYcyjdxqeF0UUAR80xFkpQ/JvtAfuQOC95X9pMuDXYEj
         EAz4EWtfve2Wx0Jg/AXx9jvlRvFsADqj0hHVzG+brG7RLfTT/tGWZcLUeR2Synvz5RKp
         mIUizQF8IOiW1jguiXRoG3LIHCc1SYjnNus08zSOAmVH12cCFHUdBr2GIYeCmTwzXmVm
         MpfQ==
X-Forwarded-Encrypted: i=1; AL+hErHpwUEw3WSrNAXwxwMbwoSfV7ZMMlYt96HZZn8r0h9XyeswJA1Ry5PJ4MgXefIQW5FqpEF1rhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XyvE3HRwxyr23/wxXbeLOfwCgjvg17PE2pQZcAMgrUJ8/AIfB
	9OVFSI54efcnZ9P3LWAxOrmi63GNp3oHrvA3v1Bn4X7IGhy52qzAPSJr
X-Gm-Gg: AYBFou3xC1wmWseefYCKEIjpnDmfah1+WbujQ7n55kKRmDftlPmP2KlQ2Mih9vxbgBz
	Fk23cjygZMOGeJ6wMONxeY3dTpY6dQQYDMdcla8jTLUXCOwvCZ/7AHDQM0mSBhPRYFbKcV+/3e7
	PldQWW2z4OIZXIKp4bAYHikQbGouE9OWDqALqMrmJi1cGbxIM4lCQHFdYJ5p7stuZSj88V1Qd+v
	2ocb7co+wzwokFBy9hpn59r9mCmEunqMx8miINBS/as3iVEnZ0ShZTHnp/MXIU1EankEgVhZvbx
	xSmzp/uFHY3Ve+/bncs8DVzTWuLqu/iUWQL11vbCnNqYBRC86W4OIjbXIcxUf1NoLnzknCIkiCP
	oaiX35R9JRR/2RAZXh7XpCyZP3zp8qqUzVbF485NhQHndPk0ugMrDg2KaKLJ6BtpzntTsf5iE9W
	hHgJXCPJSralDZvURXSHHrZWeiyRCRQTWMLVFWEQf9/vCtEY040AQrD9RynNNQZj2VkOxkqWYFP
	M0/osjsSTzrPMjVb1PY5ivTgS8xtqOW5NLbxsmkIRuUAcsB/Auzf6bRkSUjQtUBx8itqoylAzMV
	3/7DPR3R2lToAQ/qRJQdyRrqMIESB9lU/0A1GOzXplIKL9Q9245Sxg==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr5563052f8f.13.1794582949657;
        Fri, 13 Nov 2026 07:15:49 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm5971522f8f.28.2026.11.13.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:15:49 -0800 (PST)
Date: Fri, 13 Nov 2026 16:15:44 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261113.a61c6a4b7c9f@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
 <20261113.hij1gi7Ees1A@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113.hij1gi7Ees1A@digikod.net>

On Fri, Nov 13, 2026 at 12:25:07AM +0100, Mickaël Salaün wrote:
> Good. Please add erratum 5 in this patch with abi-4.h .

Done, will send that with V3.

–Günther
