Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E8372044;
	Tue,  2 Jun 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418689; cv=none; b=tiGlS0A/T1w413fI6T8FgOlb3LkBuSrkQ+ndbwHkPO7+d/vFeCIbSnNu6mauXl2sL2yIBfiEmMZ3bACODPgkGrR5og3tKsrTccP+vcziYaJuDcuNDDMys3KSMVT6UtT+hL8Kg9IQkTwazE/uyPFzqTnAs5Pcujpuxxzhe9nJO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418689; c=relaxed/simple;
	bh=oo2x27lcUQVcqYjSrYFhE3+1XqqzBm8a/ui7zmXhwog=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=sJ0aYwLH0EwAlWKoqkOUyTp8EvHlO3/Yyz874Ql9PN+qbACydPF6HfkLHja4bAXTWb70CF1sf8uZMcbVHKdLfhqESEotGaM6t4C5x5trJvSFhLwWwk2ekBmKzzRyEn9dej1m5fk4LeUfyEdvsCBFpy0grY/8YhoF9tN/FdT9+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O90/aGHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O90/aGHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCB71F00893;
	Tue,  2 Jun 2026 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418688;
	bh=oo2x27lcUQVcqYjSrYFhE3+1XqqzBm8a/ui7zmXhwog=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=O90/aGHJ64daGV+28rBxVlGom53cQHtytWyRNF5Zb6myhUJg2wVpxnnh5z7uk2dhh
	 2iNAL+H1WZ9wFReQualHK4U3YjNbYUP4ZgsJbHToLedF5RGOEnk4akhqoS0hJkXDPd
	 Eq1YMdxsfVXB5DZbrPUjPEs4iv9dzZe/yDkXvGkRa8fY+c3pxKXVF3pWUSh4Dn2yL6
	 e89sN9e5XuisOFCGHkIeCypD+HJMzFLjs4iyQPBPlyt8WYY469ms7y9KQM8vciGsvR
	 thEGTXItpEdgpAzNjdp3F0sWt6ABpIkE+H0gcLnNb+hhj4ev9WsnQmC4KhH1q6InJC
	 N3a0Sq+AVk2kw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 18:44:45 +0200
Message-Id: <DIYPR0K2CZW7.254R8K7ONBX5D@kernel.org>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] driver core: enforce device_lock for
 driver_match_device()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <cornelia.huck@de.ibm.com>, <tom.leiming@gmail.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>

On Tue Jun 2, 2026 at 6:08 PM CEST, Runyu Xiao wrote:
> This issue was first flagged by our static analysis tool while auditing
> driver_override match paths, then manually confirmed on Linux v6.18.21.
> We reproduced the race with no-device KCSAN/MSV harnesses across AMBA,
> WMI, RPMSG, VMBUS, VDPA, CDX, CSS, FSL-MC, and PCI. Those reports all
> reduce to the same core-side gap in driver_match_device().

This is all fixed in driver-core-next already, please also see [1] and [2].

> Fix this by introducing driver_match_device_locked(), which guarantees
> holding device_lock(dev) with a scoped guard before entering the bus
> match callback. Convert the two unlocked call sites to this helper, and
> add a device_lock_assert() to driver_match_device() so the contract is
> explicit.

This approach was reverted [3] for the reasons documented in the linked pat=
ch.

Thanks,
Danilo

[1] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.=
org/
[2] https://lore.kernel.org/driver-core/20260324005919.2408620-1-dakr@kerne=
l.org/
[3] https://lore.kernel.org/driver-core/20260302002545.19389-1-dakr@kernel.=
org/
