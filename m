Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437873;
	b=xhqIA0RU5/4IhuE04vaDXEURWkJZL9nEc3Am6m/qakZ++gwjtwx4VJU2mGoyhA4VGh+z
	 9NFcJCAnpXAbiHcmJqZFphhwpFhNmYiHyG94ekGh0CusEF6qzSndmggdStI7xqeEDfkFZ
	 QLaoKy5vGk9zciZ0Yb7HxWJeTLz5IOF6PSqRymIv3O4HbvjjDyzNXFVEBf3YKU+RhwQxG
	 GLEV53WrzCMacKfgSn5o6+WFA3Hz9UoM/+cKZo3UUwbFKR+AWqr/of8eH0Ds8cMZnt9lE
	 a1e4xXqwGflHC7HZAJAjLOsoMqJHSQpH2a+LZsRziPGVzJcptAWlMI5hnpmxS2IRcNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437873;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=0b+/w/Gu7/81yyJrjZNFubpzFxZIbcXJGpm7HBlFaXw=;
	b=niphla4tyijouyBnJuVAoV+XeMCj+DRvCPApsxyZXZO54eAUhL3DCv11b83B0agQ5pMT
	 usvVcyxyKXfWfHDTRLGluQRcwTshCkt4XsbaG6bngbVtPUw99dlm5A/Gio5KUn7HxQp1P
	 io/iWRScPSAKeGpwvEMgrSzU1GoS46szdz+H+FTgcI6M/meSQwW2pmfqJiuaMSOu4yB+/
	 c8ExWOyrcGncVvCrHyaD2RKRKKU0+2jDXCcG/ZZ4EvCSRhjFDT+5O3jVdWlhN3onuys/V
	 nN/WiK5OKh0pJETyy8ID3wjyo6vbT4O876DOZQlrCbtn5lSaikAmyLa22PXB5nLmcPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=S37Ksspv;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA9606A31F;
	Mon, 23 Nov 2026 12:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CA9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=S37Ksspv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795437870; x=1795697070;
	bh=0b+/w/Gu7/81yyJrjZNFubpzFxZIbcXJGpm7HBlFaXw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S37Ksspv6FMqeI67YJdulvHnqRcN/UI+pKp65mZ2bogVh145crzoixmMolgKrQa9E
	 idfpE8XCqH4Oe46Ca3wc7PTRyNXcMpYk+7EcxYOHuoP67Ro4kDMs16RlVcuznuAXri
	 vyd+J6WYYaFs3ZxbZmv+WQhG0Eo+VxGI8OMhlzFdowGQQ7gPy2zewf3eIwa4F00WC/
	 jP1Mk99FKjYHZ/TWzqZtBa6lZCbOSb/zLCW9drubMU5p4HWvsFOhcNXDaiMoigAhJk
	 RSyjKz2kTFpzIQ72gY/HPuY4mPtf7WrTfJHADbY5WjhOySyWgussHw6cQcCeQF1kc+
	 BrHvEwPM3y98g==
Date: Mon, 23 Nov 2026 12:44:24 +0000
To: Eugenio Perez Martin <eperezma@redhat.com>
From: fadouse <fadouse@pm.me>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Linfeng Sun <linfeng.sun.dev@gmail.com>, Fang Xieyan <fangxy@xiaopeng.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
Message-ID: <uD642sRa0jdIPD2nCoKzjJDfS2fpCefT340JqjRvOUyFkoXpwNAAabmjwSltui9-PD1DNwFJrw0xrsZqbYKJ5x3fraz9Wv46l3OrkBVA3vc=@pm.me>
In-Reply-To: <CAJaqyWdOF3LVF+WHaGw8gimULaCunRkuLnKAhciB7HWpYhnm9w@mail.gmail.com>
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me> <CAJaqyWdOF3LVF+WHaGw8gimULaCunRkuLnKAhciB7HWpYhnm9w@mail.gmail.com>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: bafe6e04ebbed8c7cdd7426462ae83353df9de95
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------58b4c18d041a1900b7efe55bc7f3f43ca00cda905f3a1cbf8a2befe5d918f9b7"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------58b4c18d041a1900b7efe55bc7f3f43ca00cda905f3a1cbf8a2befe5d918f9b7
Content-Type: multipart/mixed;boundary=---------------------d069c3b756c1c87bc344816b0df5f7b0

-----------------------d069c3b756c1c87bc344816b0df5f7b0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Eugenio,

> Although I'm ok with the proposed patch as hardening or optimization,
> this sounds more like a bug in get_rx_bufs. Where are the memory
> addresses for these pieces stored if there are no more buffers in the
> virtqueue? Or is it able to loop through the vq?

Yes =E2=80=94 get_rx_bufs() loops around the same virtqueue when a
non-conforming guest advances avail->idx while earlier descriptors are
still in flight.  handle_rx() passes quota =3D UIO_MAXIOV (1024) for
mergeable RX, and each vhost_get_vq_desc_n() call appends the
translated buffer addresses into vq->iov (also sized to UIO_MAXIOV).
Because vhost_get_avail_idx() compares avail_idx against
vq->last_avail_idx rather than vq->last_used_idx, it rejects only when

  (u16)(avail_idx - vq->last_avail_idx) > vq->num

so the guest can reuse the 32 ring slots mid-packet and get_rx_bufs()
appends those addresses again into vq->iov[32..63], returning
headcount =3D 64.

Bounding get_rx_bufs() (e.g. capping its quota against vq->num, or
checking in-flight descriptors more broadly) is certainly worth
looking at separately, while keeping the mask in
vhost_add_used_n_in_order() keeps the dirty-logging cursor consistent
with the publishing loop from commit e244725e86be.  If you think a
follow-up check in get_rx_bufs() makes sense, I'm happy to look into
that as a separate patch.

> Can you post the reproducer? Even better if it is integrated in
> tools/virtio/vhost_net_test.c.

I just posted the standalone C reproducer in my reply to Jiaming in
this thread.  Note that tools/virtio/vhost_net_test.c drives the ring
through the conforming vring_new_virtqueue() / virtqueue_add_inbuf()
API, whereas reproducing this requires a raw vring advancing avail->idx
past last_used_idx + vq->num with VIRTIO_F_IN_ORDER |
VIRTIO_NET_F_MRG_RXBUF | VHOST_F_LOG_ALL and VHOST_VRING_F_LOG set in
VHOST_SET_VRING_ADDR.  If you'd still like a raw-vring test case added
under tools/virtio/, I'm happy to include it in a v2 (along with fixing
the minor 262 -> 260 byte used-ring size typo in the commit message).

Thanks,
YanXin
-----------------------d069c3b756c1c87bc344816b0df5f7b0
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me - 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me - 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYVV1T01SWUpLd1lCQkFI
YVJ3OEJBUWRBdG5ZbFN6SFRMSEEySXp1TkUxQXk4SnJLVUN4NmhQKy8KdGM0TERYQ25yZXpOSFda
aFpHOTFjMlZBY0cwdWJXVWdQR1poWkc5MWMyVkFjRzB1YldVK3dzQVJCQk1XCkNnQ0RCWUpwUzQ0
eEF3c0pCd2tRdVoxZ3QrWG0yWFJGRkFBQUFBQUFIQUFnYzJGc2RFQnViM1JoZEdsdgpibk11YjNC
bGJuQm5jR3B6TG05eVp6bTBCcDNlRVhSV2tuSWdDbFd3dmR4Wm1vMVhuVmI2RmthalhUVk0KMUIv
akF4VUtDQVFXQUFJQkFoa0JBcHNEQWg0QkZpRUVtVWhhbzNaL0FuQkk0TEJZdVoxZ3QrWG0yWFFB
CkFMcTJBUUQ3OEs2cGVkU1gzbGROeXFkM09IMXVNak8zdjdMWU1oTytsN2NuU0xXckVBRCtPQ1Nx
MTFTZQphS29ic1ZHckxlalRNc21Nc1BCOGpueGZpZDNoQ04rcGV3VE9PQVJwUzQ0eEVnb3JCZ0VF
QVpkVkFRVUIKQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRmJFbTZZcVhYMmoydjJpS0RzUU1E
QVFnSHdyNEVHQllLCkFIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBQUJ3QUlITmhiSFJB
Ym05MFlYUnBiMjV6TG05dwpaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnN5bjc5
TkZwTnFrSHoraXpwSUxCblVnS2IKREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6
UWdEL2NJSjA4OUprbm9nVHM2dnZRWitKCjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNT
OGFoNWRCWVphOUwrSHFqYkRtZVNnRG81OHVTeAoraVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------d069c3b756c1c87bc344816b0df5f7b0--

--------58b4c18d041a1900b7efe55bc7f3f43ca00cda905f3a1cbf8a2befe5d918f9b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wrsEARYKAG0FgmsENRsJELmdYLfl5tl0RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdj965l96TGsIIKmmxQU32Zw/dVnWCzLdb8YQz0
Gr3K8RYhBJlIWqN2fwJwSOCwWLmdYLfl5tl0AAD7hQD/fwtoieRvuhRodIxq
IWCsEyxpCrl4gXWSL/hGE2HK77gBAPyNdErgg+xso5um/oMKGA/E16dhYy4H
l2dwd5UCXaEH
=1GBE
-----END PGP SIGNATURE-----


--------58b4c18d041a1900b7efe55bc7f3f43ca00cda905f3a1cbf8a2befe5d918f9b7--

