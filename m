Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779031;
	b=xJdw9REZxNmDeYX6VucWxmmFIeKP26Eyvb78JdlwB5IbcoMf7s6QuWMeL77qe6UlN+V1
	 iCCMYvjntJqtyyBJQTGZn7GyTKh8WXXAJjz8f/7nuBTZ9W7UsYr4scoEkvirBRL2gFgy8
	 oPi2+B4PXSwLpzdcbIGwz0SddD2mR3BOx/PqlCZOfC4h+ZNk1dSLZL1l5CLqI+GE2hvMS
	 910Y316BWbPVa61A/pA12sC0w8MRv8vo9uC4Zj1+Jttd6p9/DdWxukjWHqcrMRNKysP+/
	 OPW1lPwpX8xw/JDnw9G6I6w9IT4wm5iavOvUWfvKq/Kt6VFLa6G+GDKmqCDncj6QNug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779031;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=nCwGiOd8hJ9lsm9zd9APzwl1orNzZ96lhx39DLEgSJU=;
	b=jsVN4iMLmGim/tXKnEymbM2MT6g4AEAvfq94DlTFIOAojOzU8IuC+q5rUzfEiAQTHevl
	 wpl5o/Wo5BR5EtnhzGxQ1He7Uhn9aqQgYyktdDILHiE5fHZVGQT3mskVkO3H35ER3qewY
	 fmLXQOkM34EPh5be11rxF9IFGZlJZmyojrZvM5i0OYCWv5ug6S0vgTD4EcxRJkCah8lcU
	 0vXbKMjUJ8gXyapHiyoyywkEuSDOgVJmXjzTe++gktFLzI80QQKWf3duURcfhc7UgnSAo
	 /1LpZAjCsD5jqkGJfePsBXE+gzvgkCztmUguvP5z4LumjB85bRwWVmue/wuvhQf1Ivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=RYoa7wJG;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06D606A31A;
	Fri, 23 Oct 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=RYoa7wJG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nCwGiOd8hJ9lsm9zd9APzwl1orNzZ96lhx39DLEgSJU=;
	t=1792779029; x=1793988629; b=RYoa7wJGo0Friipk99RshCsyUK4rle08p/68bKjmGzU4/EO
	WcF4OTCjall1YOz6UNc+nn47qFYGa6sJiT/bvhDG145ZlhbQnEpV32JFNlrEY6FnIvmL1prdJ0vFn
	V7XFIVLLZYZTxRlI/7GxYuHgdU65DvXvrff3j/4Eijz81lG2v9xERG7F+RTzhWfny+3sCv+14YF8Z
	ehluy1xUAEGJUUhH9Zf8ykk31JN1rxJVX5M0fdobWYFaSNwULZ/TmJwMTvYI28keVJtT1P9hqqYKb
	4+TFaHHRJU/7SWo2kcc0jk7+YNcmC+SVSAY5fEqlaQSqd9lmaRZC+IIQ/tVyk2RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xKJid-00000007qtA-2vP5;
	Fri, 23 Oct 2026 20:10:20 +0200
Message-ID: <c49badd916f72b505cce70ff68df6ab2e776654c.camel@sipsolutions.net>
Subject: Re: [REGRESSION] mac80211_hwsim: CCMP frames dropped on fast-xmit
 (WARNING in ccmp_encrypt_skb, net/mac80211/wpa.c:462)
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Lo=EFc?= KASSEL <loic.kassel@gmail.com>
Cc: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>, Rohan Dutta
	 <quic_drohan@quicinc.com>, linux-wireless@vger.kernel.org, 
	regressions@lists.linux.dev, Felix Fietkau <nbd@nbd.name>, 
	stable@vger.kernel.org
Date: Fri, 23 Oct 2026 20:10:18 +0200
In-Reply-To: <CAAzpgGddO8H3EVb-WhXEeiCeoV97NuV0G22UZcHmyi0QZLwcMg@mail.gmail.com> (sfid-20261023_200901_018882_A00C194E)
References: 
	<CAAzpgGfrHpQZQ8iaH5fqZHzk5tTx39+jGvGkVXxhYFkp-A_bQg@mail.gmail.com>
	 <CAAzpgGeAaOjPdiVOmeY7xZqEymyh4BfhESwAvTzczvqj+YuNHw@mail.gmail.com>
	 <CAAzpgGddO8H3EVb-WhXEeiCeoV97NuV0G22UZcHmyi0QZLwcMg@mail.gmail.com>
	 (sfid-20261023_200901_018882_A00C194E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-10-23 at 20:08 +0200, Lo=C3=AFc KASSEL wrote:
>=20
> 6832075ed4ef has no Fixes: tag, so as far as I can tell it will not be
> picked up for stable. The problem was introduced in 7.1 by a536be923191
> ("wifi: mac80211: Fix AAD/Nonce computation for management frames with
> MLO"), which made mac80211_hwsim encrypt CCMP/GCMP frames itself, so
> 7.1, 7.2 and 7.3 are affected. Could it be considered for stable ?

It's hwsim only, I'm not considering that for stable at all.

johannes
