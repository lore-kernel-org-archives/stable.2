Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826146;
	b=IFIxmL4o+nANz/wKVuJ5u6IwMZ3sWYLdXYeAKF40LFBebFL5CdjFC0PN9Rlqo/HRG7c2
	 4/0Yx+aLgLPySbNwddTgGZq1AEQsdjXXOz4ZS1ItlsNeHfECB6ZmPnweWyy5W7zRiLppv
	 NnhOpG/+XJLo1M9Y468R4FVzLQ2I/pl5MJptRSDdZ/aRGv0SZFhCb6u2tlvPYhNvxZA9M
	 5TLmWeoc0TL8X1aFt+y5mIlgm8KkzIaP8LGyILvhWst4Ycw5GJTJsGM+YFjPQIPyYAWYv
	 CcoXQjDVHd04t+oR3YlWfn+T3PfaiSkND+eOWYbddM7Va+uA3COdeI5873jKp/Tqjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KMA5H3z/JHuLYGUoJ76C0iDMQ/JZICXwreWYx+RrBRs=;
	b=sGYf1Ga+C9A2ys88H8CpdqudAKfxqOqUwIq7wmBmcPpMYK98Uu6EyoXdWKsjxiJfPlnM
	 KsuzKdIi2rQXkm/95evB6dAuTBXZP42aJwVPY1SbWMBZ9LBdrp6gSUxUskLbwG1hVksYe
	 X8hr7gdCv4MpW04S6lKTAVBZnYiqtCCvuhmVM3/58Pl87iWfRLpTtfBpK10yvb/qrV+fT
	 SKvL0lsdyDk7MGHK9zAfIBtzuggTEz9K0l8jr9QL1JaL+P6CJiBtjEO6xGgqcp4SDAuvJ
	 cnT2JqIO4PZCdixbIMeBowXW85Bsa7URJ+agQ83VEHuB2+Pd3yzMGiYWCuG/0dvSKGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Z0oNxpDV;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDA606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Z0oNxpDV
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df160bb9cso228677f8f.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794826145; x=1795430945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KMA5H3z/JHuLYGUoJ76C0iDMQ/JZICXwreWYx+RrBRs=;
        b=Z0oNxpDV/EoClaHONU2qCEYmqbb6z2XqMWrVdN6vqMvCG7+qY0piKybhFO4IUNGjZz
         unDgGBVcxpcS8JEKhA34G5l4MfxlzgV3q4Hh4WDKhl/fc2Sp5aIxc7xCtvuUa4yCFm/4
         UkmgJF/Q95JtHzK85BCRVlorHco7QOrmy52WMmM97DyCsSR2yWH90ZB31CxZRx+05yUF
         0FmeHTXBYuBsCilykoEa6Cmo4ERFJF5WtT7HlKFcemg8KUNwaVf7z8Y0z8k5otq9HnBn
         zuqDI+I2Hb+iWZd8BXtlQNhdU3tRKV6YLGUWA9yQq+1KDnIYdIUU6ocRV1/5SxBiaCD8
         OOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826145; x=1795430945;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMA5H3z/JHuLYGUoJ76C0iDMQ/JZICXwreWYx+RrBRs=;
        b=t7xJ5JHcTphiBkUPA2qujGgE9ApDprFAyGILe+1lzIGXY0GIlIroLgZla/KyyzZeP2
         KMTaKvpx41A95VxZKKkV/aR8Sg+kRSlUwdxZ+qCUj0JrWMDKJdFd6CDYxSMUcIm8xC27
         0DWMBpDUBAAm5XUqEowxu0Yw1a5TxLlNl2N2e48ECTqu7V1XuGjgXp8Tb+63qboK/iTA
         uC6hlufDCx4bueYA1j7BnhcqCPimBqp5VxwLL2jOic3DfNCCZNTFl9rRDgjzx3F2qbow
         nEVhvJQNLfazfZCmuUe+tCDjibUFvDoS0AYCKPRMN+eKa54JnUd9QL6vcCZ7BGocN7pI
         wmzQ==
X-Forwarded-Encrypted: i=1; AL+hErGlfVhS18aJRT2j7a8XyjVdPo2xPndL8M+IbChbQ/zrSFpeJDNEZPZbyh1YkyqhIMcLkKCexyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AL+huBixsWO+ue7Smm5yxAx4p1ZKhB6JstiGT6K/mX702hX21
	yvzQeZDCBv7mZpHLEnLUk5gJZLIDAFiqTtWsxG4q+oNTFYUD3GYj7MXe3StDAiCfsLfCOnsHGqC
	5joCcAKw=
X-Gm-Gg: AZFdTZc4zR47ckdin8mHtAKmsVqJIPD8M57VtdGu3vCXWsEVYx2731tzKnOtEFpGfJr
	juqNNWnlJ8X5bJehlak4fEQuB2J5rJzPJP0PAhg11xS5p64Scx68L1U0Ku5DST43RPSE4ftTdq6
	lOqnCcbWZL/o3Fwr9VGI/TL9FcLkIJTugma6ftApkeQh0MXh/xEVD1desb6COmf3RvNPTZOUwMM
	G+YXtUeP9NWHgCwqzbKC7LXGoC5OWmu0eGqNc/sgzyFyNMCYKNVeLdZkri8V5p9Q+S0+n7jfwcB
	lgiFZNYlThmvZpDPyj89cwYhbQu5LtwlRScY38eMCsDHYRzj2ByJhXb6KYKujDxe0Lj3eeE+W7+
	+Uicfq4L7SsRzT0zyS/ALJxvaG5DJUVbo6JgnCy+WgYXj/Z4TvtkCKPZ3JJSB29PfqOo2qNlSxI
	y562VgBOutmpTf2OFbhKcdiYFO9Kw3pYnQn9x9FgI0N95QwoEhuLNMaUwcMxpesM+LNIzivFJM1
	0XzrcOF1PUPjG+iooRCErERObsmtJH46qA7xOlX7uvs7f0a1fpaoY1GGWEypGCS++TIzRmbd3zH
	emN5c4ocy4wE+WdqtToUHQXS
X-Received: by 2002:a05:6000:2a8a:b0:490:540:f95f with SMTP id ffacd0b85a97d-49c71e3e3f0mr17969899f8f.5.1794826144746;
        Mon, 16 Nov 2026 02:49:04 -0800 (PST)
Received: from mordecai ([2001:1ae9:6037:1b01:4005:7ef3:2241:3a83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm21431640f8f.9.2026.11.16.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:49:04 -0800 (PST)
Date: Mon, 16 Nov 2026 11:49:02 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrea Mattiazzo <amattiazzo@suse.de>,
 cve@kernel.org, stable@vger.kernel.org
Subject: Re: 098bcea71b8d security relevant
Message-ID: <20261116114902.561ada6f@mordecai>
In-Reply-To: <2026111606-uneaten-passport-9d89@gregkh>
References: <c78fbc1b-b190-4111-a6a8-f456b5c85a51@suse.de>
	<2026111326-acre-backhand-a1d5@gregkh>
	<20261113202510.2107c905@mordecai>
	<2026111303-colonial-wrongly-7d9c@gregkh>
	<20261114062419.GBavf-kxerE_YDukB7@fat_crate.local>
	<20261116094133.4aa496f0@mordecai>
	<2026111606-uneaten-passport-9d89@gregkh>
Organization: SUSE LINUX
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.53; x86_64-suse-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 10:54:47 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Nov 16, 2026 at 09:41:33AM +0100, Petr Tesarik wrote:
> > On Fri, 13 Nov 2026 22:24:19 -0800
> > Borislav Petkov <bp@alien8.de> wrote:
> >   
> > > On Fri, Nov 13, 2026 at 02:30:48PM -0500, Greg KH wrote:  
> > > > System configurations do not seem to meet the cve.org definition of
> > > > vulnerability, right?    
> > > 
> > > Yah, a system without any microcode loaded by the BIOS is not the common
> > > situation but rather an exception.  
> > 
> > One of the systems used by SUSE Performance Team boots the kernel
> > without applying any microcode patch first. We assumed that the
> > microcode from early initrd was applied in that case, but it was
> > applied only to BSP, leaving all other CPUs unpatched.
> > 
> > Thank you for explaining to me that failing to apply a security fix
> > (i.e. failing to load the available microcode update) is not security
> > relevant, because the admin should know better and update their BIOS
> > instead.  
> 
> I'm not saying it is not security relevant, only that it does not match
> the definition of what cve.org considers a vulnerability and so is
> allowed to have a CVE id assigned to.  Many such security things like
> this fall into this category, as you know.
> 
> > I still do not like the fact that the Linux kernel then lies about the
> > vulnerability status under /sys/devices/system/cpu/vulnerabilities/,
> > because those files are based solely on data from BSP;
> > cpu_show_common() contains:
> > 
> > 	if (!boot_cpu_has_bug(bug))
> > 		return sysfs_emit(buf, "Not affected\n");
> > 
> > This gives the admin a false sense of security, but I agree it can be
> > perceived as a configuration issue: The admin should not rely on that
> > data, because they can simply check /proc/cpuinfo to see for themselves
> > that all APs actually do not have any microcode applied to them, and
> > then go read AMD errata to understand which CPU vulnerabilities are
> > mitigated with a microcode update.  
> 
> So is this bug not fixed?  If so, it probably should be.

It is fixed with 098bcea71b8d (by correctly updating the AP microcode).
I guess the commit should be included in stable branches even if it is
not a security fix.

Petr T
