Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7D41D125;
	Sun, 27 Sep 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528409; cv=none; b=ppKgArbwOc66SSdHyZnZ3JFcEPmOgR+BOFWa/RWysQyKuRQl7qu15xV+LaEHNgpksC8iq5OaMiYKN085F3yedVm7SmmA++o8pHW5NmTrqlN4EVLd4arqI/61OxGr3aGcoCmyulW+G/0X53JLadBYM/3RlcatIk90Cd9w4BBVvG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528409; c=relaxed/simple;
	bh=sG5OmntsyQY2kGG1RL/Mk3RTQOOCAyi5JOZOM3WSASU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RhdEqG9qJ+pfpacWKfvZ0oieziH5j4n9tqzDNgQB7IXjTcpFY4nVBq37Qlg8PXLguarMA5WkbtCBNDdBEc++hDypwuBMspDlH5fiDNVLXgNYVHcQLcMBpkh9tyGIP1uPVCBifd1PPxvM5YJ9yGFDUVuyHCt853jcfaO3kWLmh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkrAKeup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkrAKeup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFF1F000FF;
	Sun, 27 Sep 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528407;
	bh=pig8rHiI3gmS1VE5nWeQKVUAxumenyXFLI/BlsZUFV8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=QkrAKeupWsSokXmcfGZlH1waDtv2HQGQ2Dwn09VAhiNsuYCFY7ggrbQIcIbESIsfU
	 DlBuqxB5XDkZV9dkRkcz5FbVNvnoey5mDZJrAHkU6V4zy11Z7UdBm+wCEUY7jXMJQ7
	 HGNago4SfCatPlqjFVUWNV8pUdVRhJrXQfGIZDbOJ4N4knN2liCowcIkrHgbhwzbFe
	 n3Kzm6CP9hTP2E+Y6AgdxXTakQjRnGOfiMjr0SuFeN7Au85i8l05hDzblbWCxgVq8R
	 R/Co6JUnjIhCEFuRgUUGluSzzJ8g/EYpqhZSyr0VGWS3gnOU/Sq2vdtOZfmfh+lQwr
	 18TPGAONa7T6w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 19:00:04 +0200
Message-Id: <DLQ9CHM33ZFK.3HZOB0LIGXGVT@kernel.org>
Subject: Re: [PATCH v4 1/2] debugfs: fix use-after-free in
 debugfs_read_file_str()
Cc: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>, <rafael@kernel.org>,
 <johan@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "sashiko . dev"
 <sashiko-bot@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
 <20260926195844.1296333-1-qwe.aldo@gmail.com>
 <20260926195844.1296333-2-qwe.aldo@gmail.com>
 <2026092720-sandblast-heroism-30c8@gregkh>
In-Reply-To: <2026092720-sandblast-heroism-30c8@gregkh>

On Sun Sep 27, 2026 at 6:37 PM CEST, Greg KH wrote:
> This is probably not right, don't do loops like this.  Either fail or
> succeed, don't loop.

Please see [1], where I listed a couple of alternatives (e.g. use GFP_NOWAI=
T and
accept allocation failures).  I'm not very opinionated about which of the
options we use, but GFP_ATOMIC seems wrong for this.

> Again, let's see the real use case here, what is hitting this in
> userspace today and what debugfs kernel files are causing it?

Not sure if this was hit in the field, but in any case, the reader lacks th=
e RCU
read-side critical section required by the writer's reclamation.

As mentioned in [1], there is also a separate caller-side race in SoundWire=
 [2]:
nothing prevents a concurrent write from freeing the string while
request_firmware() is using it.

This is also why I think the API is a bit of a footgun. Fixing the debugfs
reader won't address these caller-side accesses; something like the synchro=
nized
accessors suggested in [1] could address the broader API issue.

Thanks,
Danilo

[1] https://lore.kernel.org/driver-core/DLPDB44JJRGJ.3K6JNS746M7QC@kernel.o=
rg/
[2] https://elixir.bootlin.com/linux/v7.2.7/source/drivers/soundwire/debugf=
s.c#L268
