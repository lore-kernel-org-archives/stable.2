Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742854;
	b=euEHoep4JoRQcqobC/F1US32yaq1abzsQifKNahds/jaGYcT0Jc+aA+qAx279TDDNaOT
	 DLZYCJ0rHQEEBU2bxnEzsqbO40ic5OMU+gpUVsJNSyKyE46ry9wZ88ZnHnKFVhyAVA+/e
	 i+2CBj3wniNOmwSIJz3zdJMifEskAErJbX2TDbtDI2siDZflDR+pu/SZWUxA4hH1d9f0U
	 LQVBiWxHUJo67ZeBn9IvBlTlHKaXqvUYL8ywcOYFkZIquno7ExynyH6TnVlo3mgljGdyy
	 jOhNMx8dTaeYnMX666TkmXRrXPVXyvr9O7jwGkBhgACvXDAzCtdH4s7XPiwweuvHLcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742854;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=hdgX1iMSKVKnh/Mxu48+QFDNokLMugndHgnih4Ql3oU=;
	b=ISdZDpR4schpcc+M3f9uR6CTFY4mz0AxHOvWm9MrkUJi6gTEoxeIRjj0Vm62dZD+kexX
	 fX6pQfiTzOM7ciaU8VkD2/R9bvD38QSRA8cZefl6Q08gMIetG2apRxPymIHRW7jl7necM
	 XxmMzJa/Y7NZpGgBT0zh6N85vT6S/9hoJ0WX79hhWcfodnIj0z3ke4v02j8BXTTUfbNq8
	 GpaWEoq/LprPNWJezWHULPGYelOcxy3W6v1gSlgqDOlUSia+5kmoD0POCF9cf7YIsWjZM
	 xyQZz7ui8sEobcpk+Ys07pBWPd01/M+tgmrveb24zSejWq5MZZPud/7s+D51NcXiGJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ksw5E0df;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B02606A31C;
	Fri, 27 Nov 2026 01:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ksw5E0df
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795742851;
	bh=XZqSUTuW2bTPxCNamalpT3kg2C1Eyn0CxPPVJQRoNzE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ksw5E0dfRFH9qantqIKVK6v9mdQ3hy+F9XB2PQ0JLl709W8sLZbVZZ4jCDBBokMqH
	 oy6go8m6e892txhE8OEzpBnBevuCUYtWr6fDv9GIM9ekREJkKYRDmuSwbSmZ+XPB7l
	 vTEV/P5EbQlN6mj2qXp0PkUTGC8R1h10fZPEccBZblVVHXy3972ksnsNrwqFwP1vxW
	 5eQqFUQmMDKgeIqwa/7SXl3cZ6kvXzm/P1QbLtKqx/hEvUASCOvX/cXSpEcWcbfqBm
	 IdVZm1wy5R7pxjxISBlZl/NRl2+cD7s7y8vcbhSQU8ldG/hirrvJUI5p64YmM2ILkJ
	 9/S3/ZjXdS1/g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47C3217E07B5;
	Fri, 27 Nov 2026 02:27:30 +0100 (CET)
Message-ID: <af92d9c302242d8470ee86ed5ede787b8a45f092.camel@collabora.com>
Subject: Re: [PATCH v2 8/9] media: chips-media: wave5: restore the display
 flags after a flush
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 20:27:28 -0500
In-Reply-To: <20261109052853.110-9-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-9-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-Ml90ovTqf9+evYPR6K14"
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

--=-Ml90ovTqf9+evYPR6K14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> Flushing an instance clears the display flags, so every frame buffer look=
s
> free again -- including the ones userspace is still holding.
> streamoff_output() marks only the buffers that happen to be queued when i=
t
> runs, and userspace clears those as it re-queues them, so the buffers it
> kept end up unmarked.
>=20
> The next pictures are then decoded straight into buffers the application
> owns. finish_decode() cannot find them in the queue and warns:
>=20
>   wave5_vpu_dec_finish_decode: invalid display frame index N
>=20
> A trace of the flags across a seek shows it plainly: at streamoff the fla=
gs
> are 0x73, only the two queued buffers are marked again, userspace re-queu=
es
> five of seven buffers and the flags reach 0 -- and the two it kept are
> decoded into 8 and 12 ms later.
>=20
> Re-establish the flags once the flush is done, from the buffers' own
> states: mark everything the driver does not own, hand back only what it
> does.
>=20
> Derive that from the vb2 buffers rather than from the m2m ready queue. Th=
e
> earlier per-buffer loops walked that list with v4l2_m2m_for_each_dst_buf(=
),
> which takes no lock, while the interrupt thread unlinks entries from it i=
n
> v4l2_m2m_dst_buf_remove_by_idx(); walking it here oopsed on a poisoned li=
st
> pointer:
>=20
>   Unable to handle kernel paging request at virtual address
>   deacfffffffffcd8
>   pc : streamoff_output+0xe4/0x294 [wave5]
>   Call trace:
>    streamoff_output+0xe4/0x294 [wave5]
>    wave5_vpu_dec_stop_streaming+0x244/0x2b4 [wave5]
>    __vb2_queue_cancel+0x30/0x278 [videobuf2_common]
>=20
> Indexing the vb2 queue directly avoids the list entirely.
>=20
> With a flushing seek every 2 s for 180 s through glimagesink, three runs
> each: 4, 4, 4 of those warnings before and 0, 0, 0 after, with no oops.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Tested-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++++++++++----
>  1 file changed, 60 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index e351a86528bd..102c07979d08 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1087,6 +1087,45 @@ static int wave5_vpu_dec_queue_setup(struct vb2_qu=
eue *q, unsigned int *num_buff
>  =09return 0;
>  }
> =20
> +/*
> + * Re-establish the display flags from the buffers' own states: the VPU =
may only
> + * write into a frame buffer the driver owns. Everything else -- above a=
ll the
> + * buffers userspace is holding -- has to stay marked.
> + *
> + * Walk the vb2 buffers rather than the m2m ready queue. That list is mo=
dified
> + * from the interrupt thread (v4l2_m2m_dst_buf_remove_by_idx() in
> + * finish_decode()) and v4l2_m2m_for_each_dst_buf() takes no lock, so it=
erating
> + * it here can land on an entry that was just unlinked.
> + */
> +static void wave5_dec_sync_disp_flags(struct vpu_instance *inst, bool ma=
rk_all)
> +{
> +=09struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
> +=09struct vb2_queue *dst_vq =3D v4l2_m2m_get_dst_vq(m2m_ctx);
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < vb2_get_num_buffers(dst_vq); i++) {
> +=09=09struct vb2_buffer *vb =3D vb2_get_buffer(dst_vq, i);
> +=09=09bool driver_owns;
> +=09=09int ret;
> +
> +=09=09if (!vb)
> +=09=09=09continue;
> +
> +=09=09driver_owns =3D !mark_all &&
> +=09=09=09      (vb->state =3D=3D VB2_BUF_STATE_QUEUED ||
> +=09=09=09       vb->state =3D=3D VB2_BUF_STATE_ACTIVE);

Its unclear, inside the framework the driver only owns the ACTIVE buffer, a=
re
you sure you wanted to call this owned?

> +
> +=09=09if (driver_owns)
> +=09=09=09ret =3D wave5_vpu_dec_clr_disp_flag(inst, vb->index);
> +=09=09else
> +=09=09=09ret =3D wave5_vpu_dec_set_disp_flag(inst, vb->index);
> +=09=09if (ret)
> +=09=09=09dev_dbg(inst->dev->dev,
> +=09=09=09=09"%s: %s display flag of buf index: %u, fail: %d\n",
> +=09=09=09=09__func__, driver_owns ? "Clearing" : "Setting", i, ret);
> +=09}
> +}
> +
>  static int wave5_prepare_fb(struct vpu_instance *inst)
>  {
>  =09int linear_num;
> @@ -1541,7 +1580,6 @@ static int streamoff_output(struct vb2_queue *q)
>  =09int ret;
>  =09dma_addr_t new_rd_ptr;
>  =09struct dec_output_info dec_info;
> -=09unsigned int i;
>  =09struct vpu_src_buffer *vpu_buf, *tmp;
> =20
>  =09inst->retry =3D false;
> @@ -1550,14 +1588,6 @@ static int streamoff_output(struct vb2_queue *q)
>  =09list_for_each_entry_safe(vpu_buf, tmp, &inst->avail_src_bufs, list)
>  =09=09list_del_init(&vpu_buf->list);
> =20
> -=09for (i =3D 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
> -=09=09ret =3D wave5_vpu_dec_set_disp_flag(inst, i);
> -=09=09if (ret)
> -=09=09=09dev_dbg(inst->dev->dev,
> -=09=09=09=09"%s: Setting display flag of buf index: %u, fail: %d\n",
> -=09=09=09=09__func__, i, ret);
> -=09}
> -
>  =09while ((buf =3D v4l2_m2m_src_buf_remove(m2m_ctx))) {
>  =09=09dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4u | index %4=
u\n",
>  =09=09=09__func__, buf->vb2_buf.type, buf->vb2_buf.index);
> @@ -1574,6 +1604,20 @@ static int streamoff_output(struct vb2_queue *q)
>  =09if (ret)
>  =09=09return ret;
> =20
> +=09/*
> +=09 * The flush clears the display flags, so every frame buffer now look=
s
> +=09 * free -- including the ones userspace is still holding. Only the
> +=09 * buffers that happened to be queued when the flush ran were marked
> +=09 * again, and userspace clears those as it re-queues them, which leav=
es
> +=09 * the ones it kept unmarked: the next pictures are decoded straight
> +=09 * into buffers the application owns and finish_decode() cannot find
> +=09 * them in the queue any more.
> +=09 *
> +=09 * Mark everything, then hand back just what is queued, the same way
> +=09 * wave5_prepare_fb() establishes the flags in the first place.
> +=09 */

This is very long and unsual, can you find a way to simply say what you wan=
t to
achieve? Someone will rafactor the code someday (hopefully) and this will
eventually be outdated.

> +=09wave5_dec_sync_disp_flags(inst, false);
> +
>  =09/* Reset the ring buffer information */
>  =09new_rd_ptr =3D wave5_vpu_dec_get_rd_ptr(inst);
>  =09inst->last_rd_ptr =3D new_rd_ptr;
> @@ -1614,16 +1658,15 @@ static int streamoff_capture(struct vb2_queue *q)
>  =09struct vpu_instance *inst =3D vb2_get_drv_priv(q);
>  =09struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>  =09struct vb2_v4l2_buffer *buf;
> -=09unsigned int i;
>  =09int ret =3D 0;
> =20
> -=09for (i =3D 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
> -=09=09ret =3D wave5_vpu_dec_set_disp_flag(inst, i);
> -=09=09if (ret)
> -=09=09=09dev_dbg(inst->dev->dev,
> -=09=09=09=09"%s: Setting display flag of buf index: %u, fail: %d\n",
> -=09=09=09=09__func__, i, ret);
> -=09}
> +=09/*
> +=09 * Every CAPTURE buffer is about to go back to userspace, so none of =
them
> +=09 * may be decoded into until it is queued again. wave5_prepare_fb() o=
nly
> +=09 * re-establishes the flags on the INIT_SEQ -> PIC_RUN transition, wh=
ich a
> +=09 * plain streamoff/streamon of this queue does not go through.
> +=09 */
> +=09wave5_dec_sync_disp_flags(inst, true);
> =20
>  =09while ((buf =3D v4l2_m2m_dst_buf_remove(m2m_ctx))) {
>  =09=09u32 plane;

Nicolas

--=-Ml90ovTqf9+evYPR6K14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjcgAAKCRDZQZRRKWBy
9IePAQD7AMY0KmN9vwzelJFIhBYgxn3SQKf7T8oibDH9uDlEdgD/RrvAANhCcC3E
3uZuKc4tf25NVebhqvpuKkz+ua8SjA8=
=KsyU
-----END PGP SIGNATURE-----

--=-Ml90ovTqf9+evYPR6K14--
