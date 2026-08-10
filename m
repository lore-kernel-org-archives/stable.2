Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914103195FD
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401170; cv=none; b=S65a107oTylrcylOPQLeBilebCpb9Px3k9FNueVRzxjlgDjj4ARRSkrMQny/jC5fMESgdT6pPfCuaAQN/bQuT6pcsSp3jZib/prsmj07atwhQEzdm/nTbjeeZxBIkS6+xaibOhPmGO9I31BsUEeN6NGTdYweqm+/ym4eXVB0ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401170; c=relaxed/simple;
	bh=Ut4xeXPIHkP/ZTuqOULeqn9lHhqonacl55jKH6OZGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRE7GsPnpBTFdrPSKFR2OB/0TOBS/xDi5rwd+cNueiuV4hdXdffxj/Vupx3f2jGJoGCJ+quZ2mAbRl4e5ACPcKGzQnYMkKM0nR6HyFRQvVj8lr1teA3yM0zcfycJ1h1bSyegEl5a7iChPBOxu3sFDlKftqm7eDYcrP+jPmaD+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuT7T2Zw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuT7T2Zw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4980dc26022so24446785e9.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786401167; x=1787005967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KujuDXjufsH4fQ0xRNZyj2JY4LmTzir+J1KJ4jS+lJA=;
        b=RuT7T2ZwLNQPenYetKWr8rJ5pQT5JJ0eOBf+HAjTBB8PasKUtZwme6mfvNs5PRbnLe
         QL/QjD8RTohL7azkidFVUJ2Ds8lqO+DGVz62nijJ93NeeCidk28noUwIwGfVVdT4ToNf
         pyO+XOrRzWNvRLOAQoOAh27rrLIGdLnUqtS9gJUb3nrGCLJovozhoeONz4S8kZqDA3dB
         y7rUXIg1YfybEK3kNLlJ1b1GNCWrvNol36ZbgYJbLX3Q32ZqjUkkeKijy4zcseejj34T
         HeLSMaWSRUtfaLzc9BOAR88gr6ReERxkONDIUT5n04vVBfbU5vIV9a2EUeG0eMFdzyul
         W6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786401167; x=1787005967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KujuDXjufsH4fQ0xRNZyj2JY4LmTzir+J1KJ4jS+lJA=;
        b=I/6pzSnFEOAXcjclgqtEqC1HdLYPvRk4UcrrdeoykZqfkzYYICT9jBAFkmAF9p8XrS
         O83TR5THH5+wwE9ZNJLc09ScWUROt7sdOS03IDugg8rIo78ooSUURQ/AVUuBWPe6cyQT
         QtlOHjDcVlAImn4TFAn8h/06M/TYbvK9ZAVCipdqs7cX4cV/avdYHvnj2O+qRv2nXXYr
         it6xJ8uL43bDn6LXCxNxJANpKVfKTjweuiJfiVfFLT8Uh0hSYnAv7fnxqWIps3OlHkz0
         jwZCpAYNzoPmqQAlrkiwDuF3XnTckVjyq0qrn8+zvDCC3RaI+Z+Vl9azNMEiYbB6Zhyn
         r1fg==
X-Forwarded-Encrypted: i=1; AHgh+RoZYpDSsXBDk35OEOep6K/3QHHEyuIfpHivZzcU2ebDLiNvnXZ+tySoc23dOi7fDB5WQ6H4n6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkiWnK+BqeZfDxzRADPCmZl8NKMYVQ6QM0MFd8W5FsL0/sDRb
	oKEwOdjXPwmoF2S/5PLesZEhNww1F0gID5pPC2dnBb3ac45rvU3HJkaH
X-Gm-Gg: AR+sD11BO0bXedUYiChqS1IiUlU4gdrwnvNMNieJy90ggVN8uGMJqG3gw6tZKqUpXx/
	8fhpD0Iqp7LCOgQDTd+OPBdFg7JRsdrcXUxaK9SCJOkYvdxVKCQyAeR9Z0WVX36uF0UT+nh7ix3
	9PYyeKGq8PPHURsbbmfSwROwB0lUBZEW12ifzJxcsmmSMEVJWQm7ho1qf5uAvbKzlGU1ZTI3jmT
	oxDi5F5Gvnb418J1kkTrMFo7XoSJqKvkergPNBQqlzb7LnAXpX34JPV0sAqI5xa5lNbnvPbueGA
	brfkwQwQYhDeXMqvI21dna4xSB2a9dxIZ7QwET4V6IRtN74/55tvHZ7cbvCgxyQsbeEJ+/K5xlE
	3D25EKnV2Xxz21NHdxJuttZuVA6KXPPyYwAIPEdRW+ffWrBp8HiYdSGT8MBBlvw3aIoNNigzE1f
	m0jGTh/RZ1Xfd3yDwRrypGzHK8d/6w3ii+JGlfRFmAt5MT2TfRjYsj2tV16IvU2v5Tnk8BG7xV+
	9qs8hFV8hhMrMpmSanbkJ6RpglhJW1TFuLXbqRVPefLSGCSfLS+Wuwl4SV5B/FWYq6dlYNOeL37
	J0ffoAPJ3F3EDzRkar7d7hmIx+GDLSDiU3ZQ3Km168BNfGq8MRuJNWVlOcz/oUY8vimcjLk=
X-Received: by 2002:a05:600c:8b17:b0:499:726c:50e with SMTP id 5b1f17b1804b1-499727b1011mr49652125e9.14.1786401166552;
        Mon, 10 Aug 2026 15:32:46 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a1e8-7401-316d-6c00-7a9a-8fac.310.pool.telefonica.de. [2a02:3100:a1e8:7401:316d:6c00:7a9a:8fac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995d85254asm153382245e9.1.2026.08.10.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 15:32:45 -0700 (PDT)
Date: Tue, 11 Aug 2026 00:32:44 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs
 individually
Message-ID: <anpRMrGG_54yO6CL@gmail.com>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
 <86mrv2arf2.wl-maz@kernel.org>
 <anYNTW2e3HalTqTk@gmail.com>
 <878q6fplpd.wl-maz@kernel.org>
 <anizGXThM-haqQXU@gmail.com>
 <86v79i9zl7.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v79i9zl7.wl-maz@kernel.org>

On Mon, Aug 10, 2026 at 08:58:12AM +0100, Marc Zyngier wrote:
> > The increment expression of the for loop still runs after an error.
> 
> Yup. Should be fixed with

> +		for (i = 0; !ret && i < S2_MMU_PER_VCPU; i++) {
>  			ret = init_nested_s2_mmu(kvm, &tmp[i]);
> +			if (ret)
> +				break;
> +		}

Yes, that fixes the cleanup issue. I have no other concerns with the patch.

Thanks,
Karl
