Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03231280D
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809238; cv=none; b=Zg63UYHWCbYq/xnqpmTHD4PU4b8K/QE0HnZ8Xr2yPzYFdjhxGcgr7x9CgWTq2HBkcDO3NSUa4C1muiC9pMI0mavSKoChjSV3B8nEENIIqQJ6NIkNvn8Fei27KDH0jzQtcjD+g8m9ty+gDnhYP0xsD/ERZOwnNfRXckOjS+vy57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809238; c=relaxed/simple;
	bh=tLX7VagiGPQZT0CJWsOme76ONLvdwlHLsZqlwPuSE7s=;
	h=Content-Type:From:Mime-Version:References:To:Date:Message-Id:
	 Content-Disposition:Cc:Subject:In-Reply-To; b=f3fqCpE0AT2IXmR1PcxqtJJczpmCa4AStIjk25UAp9BB82+qZrrUQSCppUj37rMyg1pWXuqLtQ58roUJnsfqJ/SCzHPzBltLhaOJRi21ToFt2SENnjVDlDLD9nm5EYPxVHveYHiPXfYZhpWGgLPuF+JYUAaVgtrXpD2Z70Q11VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=sV/qbmQa; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="sV/qbmQa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787809230; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i27CaKZfZyWUBCpBIRIKbtAM47QkhzorktPq8WncJXU=;
 b=sV/qbmQaLFCnXmpEIN6/wZm64BQCwYEE6wwm0GnWm2bfFojZukDXWJkoszqVR3BR8ni99N
 6/hO1iAyrsTLDfE2Xy3EVC5gZkX83uNu7mKULMwPsuhyPIWjf0mcPvMorvVDi/VXvcPT2l
 0mbQ+h43tclWoLL1MBFaQ1+dolfjm8HALb4gIgrfbhlN8YBJIt4jDOsMR68LUb/TVuBnko
 zDnx52FJ2pe0HUs8R/WMwflfndDOrFkXcPl59/zkkfq1ARdAtqn49tMb3qxR+854IWDLYM
 DaXtbQv0ZlxIhmVJ+B7AusUAiTGkVhw4B6gvRL7J3A/1TSDvifyGYjoJbE02WQ==
Content-Type: text/plain; charset=UTF-8
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc> <2026082727-hacker-flaky-2578@gregkh> <ao_Gi6O2VQw7RUQd@pve> <2026082735-unbend-laborer-ec4f@gregkh>
To: "Greg KH" <gregkh@linuxfoundation.org>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a8fcdcc+9d5755+vger.kernel.org+me@cherr.cc>
Received: from pve ([111.42.148.163]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 13:40:27 +0800
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:40:25 +0800
Message-Id: <ao_NyQWCKIDQr_5a@pve>
Content-Disposition: inline
Cc: "Shengzhuo Wei" <me@cherr.cc>, <sre@kernel.org>, <kees@kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Andras Domokos" <andras.domokos@nokia.com>, 
	"Carlos Chinea" <carlos.chinea@nokia.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
In-Reply-To: <2026082735-unbend-laborer-ec4f@gregkh>

On 2026-08-27 07:15, Greg KH wrote:

> I'll defer to the hsi maintainers as to what they wish to do here.
>=20
> Also, how do you remove a hsi device from the system?  Is this on a
> dynamic bus?  For some reason I didn't think that was possible.

Yes, HSI is a regular driver-model bus (hsi_bus_type in
drivers/hsi/hsi_core.c): sysfs unbind and module unload reach
hsc_remove(), and omap_ssi's own remove() cascades into it through
hsi_port_unregister_clients(). I verified the unbind path in QEMU
while auditing the sibling cmt_speech driver, which has the same bug
and whose fix I'll post separately.

Thanks for the review, by the way =E2=80=94 the second refcount was wrong a=
nd
I've withdrawn that approach. For the v2 I'm planning to follow mei's
pattern: an embedded struct device in hsc_client_data as the release
anchor, a cdev_alloc()'ed cdev attached with cdev_set_parent(), the
minor number resolving the container at open, and a device reference
taken in open and dropped in release. One reference count, the
device's; the 16 minors keep sharing one cdev, so userspace sees no
change.

I'll wait for Sebastian's decision on the preferred shape before
sending it.
