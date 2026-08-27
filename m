Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F23368B7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807385; cv=none; b=bq2CUijRFp/0XuOOov/aqO7nRu+IIZ2117H+grCI09nugKGJnT2VwvLxe0mgJzagrppg6VQZ1A5KkwxW7lJG3KbEfCxsbzr6t5teaELTEhFadkieKuUBB8wxXQXcV72hsbDmp97zT6srXX4Bb3e/OEKIm4czYeLXN66IU+Y9XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807385; c=relaxed/simple;
	bh=6omL23lJxDKzkICqDYDEGlfVYv+4KkkRM+ZmzAJY2mY=;
	h=References:In-Reply-To:Content-Type:Content-Disposition:Cc:
	 Subject:Message-Id:From:Date:Mime-Version:To; b=ZzG/zZBXkTTw5QBbz3OVA+VpAvhOYWv9KDcq4sIZehRfgBU6j6NMdkE7uyZQJhOWU5GV/hYrM9Bx1+8FdreYn3ALVdIP37WujjzBJ5XTCFAtzu/hBD+mkzxRp9fBQfiHkZftGubifjz/qwHuAuDZWydF1GRU4qBXaJvMfpdKvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=3KffcCBL; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="3KffcCBL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787807376; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6omL23lJxDKzkICqDYDEGlfVYv+4KkkRM+ZmzAJY2mY=;
 b=3KffcCBL9A2EkfsmVtODocLxFrT7L7qIY9fZ/eZM/5LLb+X/snoZM+LtvoqfcSfklr/LOC
 egPUD936O17TGAjr5jJ3ExPH9D36r6Auvgt08rJn++mfBLouAU6KB9ErTj6MjbizyTPpYA
 HfZ3Y+vB/5BRr/P5g4cgIE6UjmTh7MIPOCsKd+/kmSmIim/908GZKqa9wKHzx96JGUSQ1w
 ILFECkj/FWN81DS7ktTWJF+84UXKBvnRi3RSQ/SUcHi6k4j2fybFJncBvPMsD5EDWv70ez
 n2UtV7PcyjVKVWdXZoh7ESAnQtXGypC7sVqvUS56ZcZ00+Xsnq3CFVufop+0ZA==
X-Original-From: Shengzhuo Wei <me@cherr.cc>
References: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc> <2026082727-hacker-flaky-2578@gregkh>
In-Reply-To: <2026082727-hacker-flaky-2578@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Cc: "Shengzhuo Wei" <me@cherr.cc>, <sre@kernel.org>, <kees@kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Andras Domokos" <andras.domokos@nokia.com>, 
	"Carlos Chinea" <carlos.chinea@nokia.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
Message-Id: <ao_Gi6O2VQw7RUQd@pve>
Received: from pve ([111.40.58.243]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 13:09:33 +0800
X-Lms-Return-Path: <lba+26a8fc68e+761686+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: quoted-printable
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 27 Aug 2026 13:09:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Greg KH" <gregkh@linuxfoundation.org>

On 2026-08-27 06:48, Greg KH wrote:

> You now have 2 reference counts for the same structure, which is not how
> to handle this at all :(
>=20
> Please either make the cdev be a pointer, or use the correct cdev api
> for handling this type of common problem.

Right, adding the kref on top of the embedded cdev was the wrong call.
Thanks for catching it.

I'd like to go with the pointer option, because of how this driver is
structured: one hsc_client_data serves 16 minor numbers through a
single cdev_add(&cl_data->cdev, hsc_dev, HSC_DEVS), and cdev_device_add()
pairs one cdev with one struct device, so switching to it would mean
inventing 16 device objects for no other purpose.

With a dynamically allocated cdev (cdev_alloc() in probe, cdev_del() in
remove), the kobject reference that chrdev_open() already takes on the
cdev would keep the containing object alive until the last file
descriptor is closed, and the final release would go through the cdev's
kobject release callback instead of a hand-written kref =E2=80=94 no second
reference count anywhere.

Does that sound like the right direction to you? If so I'll send a v2
along those lines.

Regards,
Shengzhuo
