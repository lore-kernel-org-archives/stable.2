Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8163FD14D;
	Mon,  6 Jul 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338448; cv=none; b=oHmO7gFUS069vXaWMwgSxN6CUDFv/KVx0cEkw4x9YVrFeFNkB3L6dR/xfMEhxg+E4Ryu2Q1nfjFPt/warc3PSBeTH/jwrBy4To9UKJB5yeCJC0IDCh+BdZbtXSkT4wLxK09o9wxl+svcI65wueUW12egMo06x5yK2x5FI9pVC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338448; c=relaxed/simple;
	bh=w/+dOqGuQIuH0grBXnx/cqJx/6F3mIWhizKWONFKFLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u23RtAaQZ6w/f+jPl71ygXD4HRbRU5/4DrlifTw3XFOpgSrXUct/S/6l4lmILapPyqr5pIvpKbrcXhBL7dyxqDBhBEJ+5Hr9ASt/cn0BnwJ0YgMKQgsDZn++tWzNKSfwIvXZq8ega8Qs1qiX2pmK/5K0N1YzdtfA2BgCC6A2jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J9E2wZkW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J9E2wZkW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w/+dOqGuQIuH0grBXnx/cqJx/6F3mIWhizKWONFKFLk=;
	t=1783338446; x=1784548046; b=J9E2wZkWOGarCKXCAlfFvQEi+z06jNg/avWr7glReGXQN+f
	KQPfyE6UWUdcTWsH0i8/ufG1Ed+do5OXuVEwlBf6VKy+vlEnCVANxtBW3MmeGcvY7K939AWVDhuMU
	4VfdMm7uVzMK754JX2pNa/frTy1qi0fZe3jg3Gi7/UbB6r4nvSjRthiLjcZi8nO0eeaVQuxgNJ7IT
	00Ud9ACWk3UveFLmxhyzMLJnkYMSyNah3KfHLIrafIBUaIlvQUfgYyQ/8269b0dWu7v8cyj4BFPjx
	WKhGNz2/vetbkeq8gL2S3/eT5PbngKSrRkI39XZIb8CFFJbB7MlkBST0hXCxp7Lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghnH-0000000DNfF-2SFk;
	Mon, 06 Jul 2026 13:47:23 +0200
Message-ID: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in
 ieee80211_register_hw()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dawei Feng <dawei.feng@seu.edu.cn>, jeff.johnson@oss.qualcomm.com
Cc: jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org, zilin@seu.edu.cn
Date: Mon, 06 Jul 2026 13:47:22 +0200
In-Reply-To: <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
References: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
	 <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-06-09 at 15:40 +0800, Dawei Feng wrote:
>=20
> Zilin is the discoverer of this bug. We are in the same research group,
> and he actively participated in reviewing this patch.=20

Reported-by? Reviewed-by?

> To better align with the kernel submission guidelines, I will add a
> "Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
> contributions. Would this be acceptable?

If he did development, I guess?

Anyway you didn't do that for v2, so please resend after you figure out
what you want :-)

johannes
