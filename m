Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528944;
	b=1TfXbuRIUs42rz/Q5RkuehDZg7JWs8XCDQT2pew4iak+bxhCNgSaFe5BJ057FL/gtfbA
	 VJPwRRfdtPcWK7jICgyuLPVOX9RYCLqmoh0uBCqDkMjzb6JyJBc/yxlOMfzJFI9qTDVw4
	 wr/Ce88PJYemsJC1L1X1ciD492tSuXZUQp3+4mTKwtZLyLuMhGvE48yFUT9sycAa2f1Ra
	 xwT0l9eF7mzMEjud5vI2ew52lCIBbGi5Tvvdrr6g02i5CQeT6SNC8po6YrTOD+TF/NyyM
	 Ld0h4bS6t+PFx4f/EMUAHqKEypCclTtdHl/awrIuYbk4cjjuay02CfAdRQK7+Ag39PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528944;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=GENSQeNWNIKZx0VytaVvE7AxDqBFnF08lo9NVw6ZAsw=;
	b=i9wnXs6GWDB1azvpmPuyY8v1NQVkTTq7YK4gL4P1xVnpMX4qxQ6kZ9Pjig9lFSn/yKbk
	 0DWzik17deuVG8xjft9875pywtVtjhruXbDXnF43ar/56hnW/TrEBT2M4xu4D+jf+2SmF
	 Zxvqw2w0ZuedXcWfyyngzBMntjR3zrG55vs7KRVCNZNCBVbPkiF7NjNhjdt3wIbQhahqx
	 QKKFNJ++2OgcFf+hxuR55Jv5slIUuSSllArjplS/rOPsT9EPrsTmPiu5n8b39XaAs7bm5
	 7nJAYVBVU/9/Z8qGPwCTxFViiFKSJ0hYO8Byn6aiqaLTBb4XAv6wCJhU5w8z3IDKYpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=HNmIbd2U;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54118606A680;
	Tue, 24 Nov 2026 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=HNmIbd2U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GENSQeNWNIKZx0VytaVvE7AxDqBFnF08lo9NVw6ZAsw=;
	t=1795528943; x=1796738543; b=HNmIbd2UHXm6gSloO/o7vbnK636nqBFZqLc5JnYx1dEZJdp
	HWwad41Hy4MK9MRptOFuf2vQRCWUme0IKO4xH8jkPoq4NCPWgW7qZ0N4JiYMTnLH9SCl6mvJhT++a
	NuUKYwYtbGHwXH9MLnOG41R0LuClNucGv5sK00P+P3Nr9Mw5mt1t+icecSRZ6cj5tW41Gj9VzfUnU
	bdE2csLmYsmbioLHBtVjEaKIMiJJf85KI9r7ETNWBSvOOUnKeqOvmlavIn4TfusjbaEYGEZ52xuEN
	OqFQzdvli2gVfRwDHCpf8XSqQ62Yu/ywPEDYWE/uZ8QJVjHDuSmIw83xPtPwbKiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xVr6A-0000000CLPg-1jlO;
	Tue, 24 Nov 2026 15:02:18 +0100
Message-ID: <ac39fb1720fc03069317f8a74aa0f34d86db2e30.camel@sipsolutions.net>
Subject: Re: [PATCH wireless 1/2] wifi: mac80211: do not copy the mesh RSN
 IE twice into the beacon
From: Johannes Berg <johannes@sipsolutions.net>
To: Piyus Kedia <piyus@iiitd.ac.in>, linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kapil Vaswani
	 <kapil@presceralabs.ai>, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 15:02:16 +0100
In-Reply-To: <20261124003526.78471-2-piyus@iiitd.ac.in>
References: <20261124003526.78471-1-piyus@iiitd.ac.in>
	 <20261124003526.78471-2-piyus@iiitd.ac.in>
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

On Tue, 2026-11-24 at 06:05 +0530, Piyus Kedia wrote:
> ieee80211_mesh_build_beacon() budgets the user's extra IE blob once:
>=20
> 	tail_len =3D ... +
> 		   ifmsh->ie_len;
>=20
> 	bcn =3D kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
>=20
> but two of the builders that fill the tail draw from that blob.
> mesh_add_vendor_ies() emits everything from the first vendor IE to the
> end of it:
>=20
> 	offset =3D ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);
>=20
> 	if (offset < ifmsh->ie_len) {
> 		len =3D ifmsh->ie_len - offset;
> 		data =3D ifmsh->ie + offset;
> 		...
> 		skb_put_data(skb, data, len);
>=20
> while mesh_add_rsn_ie() searches the whole blob:
>=20
> 	data =3D cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, ifmsh->ie_len);
>=20
> A blob that begins with a vendor IE therefore has its RSN IE emitted
> twice - once inside the verbatim vendor range, once on its own - and the
> tail copy runs past the allocation:
>=20
>   BUG: KASAN: slab-out-of-bounds in ieee80211_mesh_build_beacon+0xe3f
>   Write of size 479 at addr ffff88805ca1887b by task syz-executor
>    __asan_memcpy
>    ieee80211_mesh_build_beacon          net/mac80211/mesh.c:1110
>    ieee80211_start_mesh                 net/mac80211/mesh.c:1187
>    ieee80211_join_mesh                  net/mac80211/cfg.c:3330
>    rdev_join_mesh
>    __cfg80211_join_mesh                 net/wireless/mesh.c:214
>    nl80211_join_mesh                    net/wireless/nl80211.c:15399
>=20
> One NL80211_CMD_JOIN_MESH carrying such an NL80211_ATTR_IE is enough.
>=20
> Confine the RSN search to the non-vendor part of the blob, so the two
> builders cover disjoint ranges and their total cannot exceed the single
> ifmsh->ie_len the beacon was sized with.  The blob reaches us having pass=
ed
> validate_ie_attr(), which walks the element chain and requires it to end
> exactly at the end of the attribute, so the split returns an element
> boundary that is not past ifmsh->ie_len.
>=20
> An RSN IE placed behind a vendor IE is still emitted, as part of that
> verbatim vendor range; nothing that a well-formed configuration sends is
> dropped.
>=20
> How this was found: by AI-driven fuzzing built on top of syzkaller.  Its
> analysis was checked by hand against the code, the fault was reproduced o=
n
> net.git main under KASAN, and the patched kernel is clean on the same
> reproducer with ordinary secure-mesh beacons unaffected.
>=20

Please write a better commit message. This is *mostly* just stating the
obvious, as LLMs always do.

johannes
