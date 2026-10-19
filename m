Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77D409623
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413976; cv=none; b=K1/SPSe6plKelwUO4XR3cl9ztrVNwdpBzeVI7UCYyADSJoZIlzrv/vtQRCQmWOFh7Uz8dhq9ABGPd8o7qQj0eBKIBdrph7I/tVAPZxQ/Cxr6jQ/irBvUWY+B7Wz/gQV4gey8Lx1gNnEwGffe7nbaGIipWAyHR5t3BM/AwNaZz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413976; c=relaxed/simple;
	bh=xp+A0hKQQq1H22UYXD4AcfOE21QDOyZZTRzwG+3a2Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgsQ1mmOZLmMti9HK81rf7nc5USuqq/NjxfEEhO1WLrWwuCljIPTKy6xXpRRPRDSpyqwP5GspMmAtn4yCelHoSVHpINCEsk65cQ/nEdLuChNfH/AFZD7UIb5d3Dqgu8hZuOj6R/RHBYyXV36el7Rw/YQJHWNn/vExszVfGKQJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVQV2mMC; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVQV2mMC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15354aa70e8so1067490c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792413974; x=1793018774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucqImzYK4TndSlhXSWzG/Thctz6staWsP5DajBsvrOg=;
        b=CVQV2mMCXKl92EJaX/fW4ZHE6QUrVtOXkhA/GHdGi2IWovUF0190v8M9d0KGdeZGHB
         eekmpm8AEuRdDw6xqp/uSU+phHXCpoENQZErq68hm3nzFbEqRe4VM1bvxRFmyVy1+zUu
         1FRX1pQ5BNj9uD84giznYCgaXMkC1p4KSqRxGpV7D1GnJJlmDca9G6OW6OoMKHoBHI7d
         nOhYxSaF79ZghbIU8dhpPXV9C7winPJYX51s1SRJcixd14K5n6PyqZgxB0rAT00WIedi
         ZSOFvs2W3B3jf0DCKK+E59W/divgwKks6Gbleg02+nq9AzC3MwfZeau1nLndORls+eu0
         QQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413974; x=1793018774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucqImzYK4TndSlhXSWzG/Thctz6staWsP5DajBsvrOg=;
        b=XxgNdtfShkQsg8iF1Ub5qiKAdEB4r9kciGCuEjuv9Pif4yHNJ5APcfPTJmWIY9U7L5
         2jRRKGgjrx1OWge5u9v5uz3rn7nC8Cx+4fKpVct11WNKolVcXkP1iLAQrPqYvClc+1PL
         3UeOrYlGKTzbd85i/LwB0JMTm2iwzn36DrNvrgH82LpsTc0h2QYpHoxHmD1NE5JxuH3o
         YrJTyR67slGWp+0itQdIpXphuLEoSurMYdHo8YvLfwUo2qXUt+PZYNaMhRPjfFj5gVMy
         kGo8oSUrHauVjyMq4BrlpdUKQ3igNehPGPNfo5F7TU194exdqIf8FYtiENiEfE6GK8sD
         jxNg==
X-Forwarded-Encrypted: i=1; AKwUvBz2JQuR6CAK0LmtwstQTFbNdRce6KV6/Gktb3uhgCK4U5yMi9lViwQlLtvx1nD5NJdQ/lCOzV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkQ7060PhNMhcKNqPHmGoWVKyOSZkTyPgm9wlCHLnaRjJDQuj7
	qdvxlqd4Ocs2qkMEh2WPYfMTPk9KN+NN4Vpg3gzd9wwOD/KI9DcZ6qCw
X-Gm-Gg: AYBFou3jNLl5vi7RXdC7NDwEvXKwfERKzJkt2LkJYGgZjPquC0rZnAtxiYl9RKe78Pg
	aJdcmh/oV9tHI581aUFrpZQ0D31NzeBdOWHh/UDJGY2tPsq9+r4qjW/Xmo8aT2E5fRoHkI1GBBT
	YPOwA00gQcyCOjRsY07iOXC4mbL3gAHHtR+3GCNz38Wb4hHqiaSCA/62HUR4SFa1w6iBdB9E1qQ
	k6XJPFD69n3JRvlvqSMdESu2JJ066/S8/2k1KlkC//Ct1vmx/Tvl+Bm5KR2nAmituZ2hnHP7oo3
	zbpPqmsbY81qtAQ1WMfTPeMK4O0ElqxonzyVCQsN4SGL6A7ErTMeqYTMHFAsUmIQLze2MqPln1Z
	g6QuDyF4fl1NU/+4Y+TzEjsCCO505w0bBJuUx14HBCafl/kkFw/T27El7zI4yjouasFxBaH7K4i
	YMAfos0qbIM8OlClYpj7gs/Pi8tVY837juNqE0Wr4SIwCgWPc/GlUwm4ORvtGWT15WBf/nYsskp
	f99feyp6UuC
X-Received: by 2002:a05:701b:2906:b0:141:4a06:ad6f with SMTP id a92af1059eb24-1851238b5f2mr11785078c88.8.1792413974419;
        Mon, 19 Oct 2026 05:46:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa3ebsm25845295c88.8.2026.10.19.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:46:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 05:46:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ximing Zhang <xzhangjr@gmail.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (coretemp) Fix handling of isolated SMT siblings
Message-ID: <cfcbef9e-82bd-4685-85cb-25d17f2483e4@roeck-us.net>
References: <20261016-codex-coretemp-housekeeping-v1-1-96618c5676b2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016-codex-coretemp-housekeeping-v1-1-96618c5676b2@gmail.com>

On Fri, Oct 16, 2026 at 12:36:37PM +0400, Ximing Zhang wrote:
> From: Ximing Zhang <xzhangjr@gmail.com>
> 
> Commit 0f8b916bc5b5 ("hwmon: (coretemp) avoid RDMSR interrupts to
> isolated CPUs") prevents create_core_data() from creating temperature
> data for an isolated CPU. coretemp_cpu_online(), however, still adds
> that CPU to pdata->cpumask.
> 
> When an isolated SMT thread is processed before a housekeeping sibling,
> the mask makes coretemp_cpu_online() believe that the core is already
> represented. The housekeeping sibling then gets no temperature
> attributes. Package attributes are similarly not retried when the first
> CPU processed in a die is isolated.
> 
> The mask is also used to select a replacement CPU when a sensor target
> goes offline. Including isolated CPUs permits the driver to retarget a
> sensor to one, causing subsequent sysfs reads to send an RDMSR IPI to an
> isolated CPU.
> 
> Keep isolated CPUs out of pdata->cpumask by moving the housekeeping check
> to coretemp_cpu_online(). Sensor creation is then deferred to an eligible
> CPU, and hotplug replacement targets remain on housekeeping CPUs.
> 
> Tested on an Intel Core i7-10510U running 6.18.50-3-cachyos-lts, with
> nohz_full=1 on CPU 1 and its housekeeping SMT sibling on CPU 5. The stock
> driver omitted Core 1 after module load and retained its readable sensor
> after CPU 5 was offlined. The patched driver exposed Core 1, removed it
> when CPU 5 went offline, and restored it when CPU 5 returned.
> 
> Fixes: 0f8b916bc5b5 ("hwmon: (coretemp) avoid RDMSR interrupts to isolated CPUs")
> Cc: stable@vger.kernel.org
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Ximing Zhang <xzhangjr@gmail.com>
> Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>

Applied.

Thanks,
Guenter
