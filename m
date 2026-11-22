Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353660;
	b=RBXR7naMXOVQAZ6PeMIpgR92MfstNQxLExpqeZNnVWj81+tgozO0vUSXYVFolhAJnknD
	 KGgmoMtyEyOoBaO6OIiQbXvcxsA3np34xc34OjLJkXdx7zc31YRE/xsWAHEaZuHQo+O+t
	 TK/tWkHoBDxUIy6OMzKiX8vPrzunkvFjEsqTG5Hcb/oReeoInnC9UfaXIWuE5hP23jx45
	 J58rBC+kyRuSvI5PuQKg+Y5+uweTzDlvWPMT0ytJFBft04CvJowW7ICxkDGFhQitgTI66
	 LBCUazZE3sx+J4HksRoYC8T7qcd5QL1tIRpLFpdRCMO8poRgVsz24+cVIBLe/+R7hYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353660;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	b=2usK7qRVzaHVyAEyZQYVrO/lUALdrkSux3/Kvxb34w2Wh0mQ7GdtBBA7gTPbZ3y1BS2z
	 Yp0HPj9OYakInXJR53VAsZ/lYvHJjDH/mteQG6/AvBww7mSfDs6LpXSfv8kJzcgAZlddI
	 K4af3whCgQ+ImligzxTNIuh1rI9nE+xiTcaJwVPtwTVIVa7lRcx5+J2EjOOv6BIKi8imF
	 RLLvcxd5CdgfjRpGk6jILcLKhtGdYPDPNbFAektW2NLdFah8C5hiaEZAPhAtGLXZ0+Xo8
	 VBAJ/HP9jF5CcBeKPb/k3qU7oAxub/ydTDBnly3drCQqdGn8jfkNWu17CX8KTnKuSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4D606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D4D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795353654; x=1795612854;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rpoke7kIbufv5EUE+v6QP9RKHaLv9d1qKHGkUFy0dbwBonBukYa4BaGXbmrm8WNVk
	 m3uZZVey1t5mFukibLbam0SOEw8fBIt9sylsw0uynTm0vxf+RwueirbLJyiaScBMAl
	 HVux3Ir16vSZ+lRQkEZ6T7U23zaAoORLPgu+3vJEFhv6hHMyWEOLoQMbvKLOLikTzQ
	 LNmBXVTBRkdMVelcTB6RDEZpUzWwV3HA6hxJ+jdK7l8ie/oa6t1e6mvHjCFdz0J90y
	 Ut6Rj2s11nbcT9bZcjbP5JHte8w3FaHTm9YqSHy9So6y5/tbfcchZf+3aj+EubmQJ+
	 XmD2bDeMu9Eew==
Date: Sun, 22 Nov 2026 13:20:46 +0000
To: Tjerk Kusters <tkusters@aweta.nl>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen <sven.auhagen@voleatech.de>, Richard Cochran <richardcochran@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
From: Tore Sinding Bekkedal <toresbe@protonmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, stable@vger.kernel.org, Piotr Kwapulinski <piotr.kwapulinski@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Nowlin <alexander.nowlin@intel.com>
Subject: Re: [PATCH net v7 2/3] igb: only strip Rx timestamp header on the first buffer of a frame
Message-ID: <d1cec124-8685-4be9-ae70-1142e3be4f88@protonmail.com>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl> <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
Feedback-ID: 21125876:user:proton
X-Pm-Message-ID: 687ed69b38c3864e14592e27266a6843882b0919
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
Content-Transfer-Encoding: quoted-printable

On 11/20/26 12:10 PM, Tjerk Kusters wrote:
> This is easily triggered by a GigE Vision camera streaming dark frames
> (mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
Mostly commenting to make this thread searchable -
We ran into it on a Ceph cluster: Proxmox VE hosts (kernel
6.14.8-2-pve) with Intel I350 ports in an LACP bond at MTU 9000.

Enabling chrony's "hwtimestamp *" put the ports in HWTSTAMP_FILTER_ALL,=20
after which jumbo frames arrived 32 bytes short (tcpdump: "total length=20
9000 > length 8968") and were dropped. Small packets were unaffected, so=20
  Ceph heartbeats kept passing while OSD traffic stalled, reporting=20
laggy PGs and slow ops.

Note that removing hwtimestamp from chrony.conf and restarting chrony=20
did not clear it; the ports stayed in HWTSTAMP_FILTER_ALL (using ethtool=20
-T") until the filter was explicitly set back to NONE.

Thanks for the fix.

