Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739681;
	b=Wl/uyDwyz0fjDCQxHYYA3aI8oD64QojF6S0FPLzBHWP5u4MLZxZQ26UChEd/C6hP5OPr
	 qcjjNC1osnEOz3O6iToiyus8XMpibTKu92wpJSKcILTNtpP6hj7baqtGqt5ramv8dxnFH
	 RX6f/+P7hH4ByUY0QYbupKpfpzFHLaU/jbiiSqJwS1C7em6cs5tt8opnQRsxxKdcWAwkk
	 QvtnXWNXpAkRv774TtAmIaTMllWoA1YRrG17r9LVo+JzX10/ISFdtGCJKPxKmabnsKQBq
	 MSpTI1iIxjKDvpaVuG34M8i9S7KG9iyIQZY+hcnNaqN6alH1UPl97XEchGe3nMwz8ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739681;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=UxLK7bEGjfkMqxlP1HJ5La/tP438DtL+DH1p4KN3J0s=;
	b=YHDpbzHlWuEZbF6K+7DEzFhFvsR47inZA8durUqijRAv/LC+7a9Rp/GggUdCrvGetme6
	 tG4sn0XHiSQ0L3oILb33GJGkXgmlyf7Np6NqF4m9kYdtrGgzWYEhlnMz7X8WOSZLk7jRf
	 NVpUvUBrtfx8QIKd5X8YwINzvyy+tmzZlQebNQTcfaYOnJASBvwWjoMOtfFITADzom7zI
	 kU6QC6yh2EwO6GRtgs7phU1myLAg/4FqAMrdmc7m9dCkMvEik4Cle09ewk4bIq4X4xZVw
	 d3Jj0CD8bh0anCabp3DFGiNYKlr+TAh09HBLVrhqOAC8xNffsFyGHA1nxGPuSwIg23A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Rx7pqdVk;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60175606A31E;
	Fri, 27 Nov 2026 00:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60175606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Rx7pqdVk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795739678;
	bh=UxLK7bEGjfkMqxlP1HJ5La/tP438DtL+DH1p4KN3J0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Rx7pqdVkj0ocJelprcXaH823psQ1knCRA4MNRSWCEsup440aoNYQlf3OJLzN6oTbt
	 /kYZepCmQUxh0vNqeqyx6mBHA53XsmoDbB4l//L97o6hRHlzaconxazSY9WiWgLoQl
	 dSzqkV4kdVjZsnCk91ItkyyX5KdkloRIN21Mp45FYvo+DubVk6YzwWG0o+8XHNt+Ic
	 hNkd8ZdJoUfpGRwLQTNlyTTUvZloB4p+E69ETrbEaOPG88S662Ydvh1omG7KdHkVdB
	 iq8I0ISJMOlAqVKxP6nrwPmuBDk/NShCFP6mWnFBp1TOIahmx6LUAzxJexksz03Hrx
	 VLNEZfOR0YQ5A==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7922017E085F;
	Fri, 27 Nov 2026 01:34:36 +0100 (CET)
Message-ID: <d40e63eac201d9517c008d559a32b2cef9cc6137.camel@collabora.com>
Subject: Re: [PATCH v2 1/9] media: chips-media: wave5: Ensure Atomic Access
 to src_buf list
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 19:34:33 -0500
In-Reply-To: <20261109052853.110-2-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-2-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lviUndxDktS7N+jzCjqk"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-lviUndxDktS7N+jzCjqk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Brandon Brnich <b-brnich@ti.com>
>=20
> feed_lock was introduced in decoder performance improvements. This was
> used to ensure atomic access to the driver's avail_src_buf list during
> fill_ringbuffer, streamoff_output, and buf_queue. While this protected
> the drivers available src bufs, the v4l2_m2m_src_bufs were not being
> protected at driver level. Three separate threads have access to remove
> buffers: start_decode fail path, streamoff_output, and finish_decode.
>=20
> In streamoff_output(), replace the inst_src_buf_remove() loop with
> list_for_each_entry_safe(). inst_src_buf_remove() takes feed_lock
> itself, so calling it while streamoff_output() holds feed_lock would
> take the same mutex twice and deadlock. Unlink each entry with
> list_del_init() directly instead.
>=20
> In wave5_handle_src_buffer(), feed_lock does not serialize against
> v4l2_m2m_buf_queue(), which buf_queue calls after dropping feed_lock and
> which adds to the ready queue under rdy_spinlock only. Walking the ready
> queue with v4l2_m2m_for_each_src_buf_safe() therefore races with
> VIDIOC_QBUF. The loop only ever looks at the head of the queue, so peek
> it with v4l2_m2m_next_src_buf(), which takes rdy_spinlock, instead.
>=20
> Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of d=
ecoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-lviUndxDktS7N+jzCjqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjQGQAKCRDZQZRRKWBy
9IZ5AP98Z3GvX2FF3bIELxWZnxpqmQtWHS3t3ye/G0lPEqghNAEA5WsLbWgQohCz
tDSNAwYifK9be/W0sS9UARcbIXX73gw=
=fkGs
-----END PGP SIGNATURE-----

--=-lviUndxDktS7N+jzCjqk--
