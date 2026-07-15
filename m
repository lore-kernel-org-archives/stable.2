Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869C3655ED;
	Wed, 15 Jul 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085840; cv=none; b=Xjx2trGU3fGEANeyHSCKmjHGEGmChlEaj8U6IbdYobsVPv/O0YcYKD13mG1zPsSDnCVAXH1vivp2yfnfVRKb8V/BNnlwZwgRa4NVl17s3Gyn4mfKdcu78/p/4l6vUIJ8hePoQ6Hb9iZcnWSusC5EervXLrDl9nVQ/cmmXPN6LkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085840; c=relaxed/simple;
	bh=XLWRLtrarHBQnKUHNoSPGQePR+GNNJjY2jAcX6E6fTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJCQt4Y0BZcmiVIxtmTN4ZaFQQT5dbU9mFyQZk2DlgTRe8R0Lop5vz/kQ+fE/E3uyeWtA/qnL41qdowuxoVfyUtWmWQnmOyG4Zo3Fq+Za3iHjym5y8uJ4SC+G0dFlixZoQnYC+x8rWE9D+G/skk5R3wvoVoaPX0ZsIOueJkl/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jII5BIJ5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jII5BIJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784085835;
	bh=YFnYNXhGRn1jDH2k6Osbkyxy71RMq9U1pB7B6ANqqvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jII5BIJ5psAegctVrJdvqCjjq4lznxyxQp969yvZL5+zpIMISBiZ1jkgWQS9/b4as
	 LrY5/VY/w27w5vt/lRj6NFiIJRyCfDhTEi4CtG+H1f2XjTcSZWocXf6SIudi0f3LzK
	 ls5IfacRNXLe0hMstyya1jnf6jy0h0Q37YFAFg972ntp5O50lGYMEoyP86mYWhjCIj
	 ZL2TnmfMG9Smtm3mLwPboeG1tlC8wEa8JegIlCqd/UmcC8UP8y9YweUFMHUBknBb2E
	 prKDyjOO9boq5vMM/rTRcA9YmjJDeAg6/nfIlnqVb9cMjPUjY2enlwQJ0p9xlwXAEE
	 9UrNUryVhRuGw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F12C655A4;
	Wed, 15 Jul 2026 11:23:53 +0800 (AWST)
Message-ID: <1a69cae2f078e24726bfdef5ee2e6575759c8dda.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] mctp: serial: reject zero-length frames to prevent
 rx buffer overflow
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Doruk Tan Ozturk <doruk@0sec.ai>, matt@codeconstruct.com.au, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 11:23:53 +0800
In-Reply-To: <20260714130348.72716-1-doruk@0sec.ai>
References: <20260714130348.72716-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Doruk,

Thanks for the report. The analysis looks solid, but I do have a
recommendation for a different fix. One comment inline too.

> The MCTP serial receive state machine reads a frame length byte in
> mctp_serial_push_header() case 2 and validates it upper-bound-only:
>=20
> 	if (c > MCTP_SERIAL_FRAME_MTU) {
> 		dev->rxstate =3D STATE_ERR;
> 	} else {
> 		dev->rxlen =3D c;
> 		dev->rxpos =3D 0;
> 		dev->rxstate =3D STATE_DATA;
> 		...
> 	}
>=20
> A length of zero passes this check, so rxlen is set to 0 and the state
> machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
> incoming byte is stored and rxpos incremented before the terminator is
> tested:
>=20
> 	dev->rxbuf[dev->rxpos] =3D c;
> 	dev->rxpos++;
> 	dev->rxstate =3D STATE_DATA;
> 	if (dev->rxpos =3D=3D dev->rxlen) {
> 		dev->rxpos =3D 0;
> 		dev->rxstate =3D STATE_TRAILER;
> 	}
>=20
> With rxlen =3D=3D 0 the "rxpos =3D=3D rxlen" terminator can never fire (r=
xpos is
> already 1 on the first data byte), so subsequent bytes are written past
> the end of the fixed 74-byte rxbuf, which is the last member of the
> netdev private area. Every following data byte is an attacker-controlled
> 1-byte out-of-bounds heap write, and the overflow continues until a
> frame (0x7e) or escape byte resets the parser -- effectively unbounded.
>=20
> Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
> discipline and bring the resulting mctpserialN netdev up, after which
> the bytes arrive via the tty receive path.
>=20
> Reject a zero-length frame in the header parser, matching the existing
> upper-bound rejection.
>=20
> KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes:
>=20
> =C2=A0 UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c=
:370
> =C2=A0 index 74 is out of range for type 'u8 [74]'
> =C2=A0 BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
> =C2=A0 Write of size 1 at addr ... by task kworker/u16:0
> =C2=A0=C2=A0 mctp_serial_tty_receive_buf
> =C2=A0=C2=A0 tty_ldisc_receive_buf
> =C2=A0=C2=A0 flush_to_ldisc
> =C2=A0 Allocated by task 152:
> =C2=A0=C2=A0 alloc_netdev_mqs
> =C2=A0=C2=A0 mctp_serial_open
>=20
> Found by 0sec (https://0sec.ai).
> Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec

I assume this needs to be in the Assisted-by format.

> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> =C2=A0drivers/net/mctp/mctp-serial.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-seria=
l.c
> index 26c9a33fd636..1e3d285c0500 100644
> --- a/drivers/net/mctp/mctp-serial.c
> +++ b/drivers/net/mctp/mctp-serial.c
> @@ -313,7 +313,7 @@ static void mctp_serial_push_header(struct mctp_seria=
l *dev, u8 c)
> =C2=A0		}
> =C2=A0		break;
> =C2=A0	case 2:
> -		if (c > MCTP_SERIAL_FRAME_MTU) {
> +		if (c =3D=3D 0 || c > MCTP_SERIAL_FRAME_MTU) {
> =C2=A0			dev->rxstate =3D STATE_ERR;
> =C2=A0		} else {
> =C2=A0			dev->rxlen =3D c;

We probably want to advance directly to STATE_TRAILER instead, in order
to consume the trailer and framing bytes for cases when it's a
legitimate (although somewhat useless) zero-length frame.

Perhaps:

--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -318,7 +318,7 @@ static void mctp_serial_push_header(struct mctp_serial =
*dev, u8 c)
                } else {
                        dev->rxlen =3D c;
                        dev->rxpos =3D 0;
-                       dev->rxstate =3D STATE_DATA;
+                       dev->rxstate =3D c > 0 ? STATE_DATA : STATE_TRAILER=
;
                        dev->rxfcs =3D crc_ccitt_byte(dev->rxfcs, c);
                }
                break;

We'll still land in STATE_ERROR on incorrect framing, but just during
trailer parse instead.

We could then add an early error path rather than creating a zero-length
skb (which then gets rejected by the MCTP core), but that would be best
done separately.

Cheers,


Jeremy
