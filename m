Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793573451;
	b=TksaTZq0IIydzWmHgSB/qi6IOexlPxWQ3uCVyXTyinVG5qLXZhKPSfP2NFh3BGfqK1wo
	 tUPnaPK+IWLXmNss5S42pwrdheGgCg+BGHNiWK/f0Z12VAnuKG9gbAKndUBo0/9KdQLo7
	 a5PEe4dkYsIvQ+LWBEtYcbK/nrpBpRzeT6mJ9iJnCeITAk68eLf+b3OBuXKFGjaRMYgED
	 fWuFXWIQH+PTWFwxCyp/5y674sRvVW0uGg+o5wZD/4jGgNXBPBYBVDgPl/7rUOl5u9XCO
	 126dXqdKu5l3EXt/P5L5dT/LG/OVfbyf7iKfLDBRGt8mAIvQN04b3HMCd9PQRdc0u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573451;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Y0qvq6mmMLgTfpxELoghMFTbhqnb2nmeoC+hPsWafsY=;
	b=btpgtFP6SVHW6Px0G3BFN31DJCqOx0oa/7cYJNuAswommLPhSwwnWkwKDBO847WQrG7o
	 F7ZdMTxNDcd4qtFmtsJQWPo3H+XzKDcUCBxdu7uiiikdjgqmomgCX2EeRXH6jh/609ieP
	 3NZpIZt4riyOUkoaSRTsdna+HRC4ZRiNPAoi5Hc2Qf+sGb/G9rbotZrmA8CaiJ9/SB9+D
	 ojnMcEOCveOAaOGi7UZLR8zjGWk7P1mDqm3hfXERC9Gzjp93xCrim9Boz1lYkjRoqn2Ii
	 j5ZfKk08PxPoZeWFV5xll8S5h+n4W06fmK38cqCFAtIKbz6mIJtVjXFwlovVV+mmstA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=lTkm1dFE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O3G8MzPt;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D681606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 22:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D681606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm3 header.b=lTkm1dFE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=O3G8MzPt
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1457D7A01C5
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:50:49 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Sun, 01 Nov 2026 17:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793573448;
	 x=1793659848; bh=Y0qvq6mmMLgTfpxELoghMFTbhqnb2nmeoC+hPsWafsY=; b=
	lTkm1dFEizaTZ/AGpa6zxjy6SPQmIMWJj6mzMbOYl6EWjCSSbHytQZed7uVxK7kJ
	nr/clt36gCe2DWVu/Id0ZmLTjTafZikPuTDe/57uDKjvJxUTmlKr4TvTa3By4iro
	4BPeVKvkS/6MGmwbsW84zEfKwATJMQjlVEDLtz11GVTEn4E6vmxpNiCfCzR8Oukl
	ikR9dLxrQcHLQyrn4KuyiO920/5UpxxPugi6YjMXmBHG1RL4Nn1RSSDua/TzTsCl
	DxX/kdzzg9/eiyt4i0c+iq0VIj1srhPTyLPDU8F59Y+9e1jl00FKWG25zWZus1Xs
	EZkxAFdde1J2XAk1XwFU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793573448; x=
	1793659848; bh=Y0qvq6mmMLgTfpxELoghMFTbhqnb2nmeoC+hPsWafsY=; b=O
	3G8MzPtlWB6Luxqh7Y/OlUo/HeBlLkyrvwBLGICreCc8iF/mj9mcXoRPI4/kyBFC
	vISiqkERWV7W89Ga2MSRaOdaEs70QDiCVVHvA8H5HLovQZEH/SuJ/rrbpmLKkcQG
	xNyLIKSUjq+BDaAckaPw6n4uu5srd//UVYsndgXgLbKHe7ySxMVZ4eBSyYUTQzev
	ZhDJT1pu1MXdV1hD9iPIHBU4Q9h1R0tX+r0ro/rKyJGDy5evIG253fN+9YG1pXNw
	THA/H1RfGhpkrBfnS5J8m5BhDQCYQvEao4AAMuxNp02sya66gho2SuRtskUzcLux
	4K7+X4VFcTBnkl6UdYKIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793573448; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iY5lmYKuhXXd9tRGmYbOsErg+KfLmy9p29W4C/uQkKneNAb
	xKQSXY6UKK0QJaIWKrtDTBa1SOTeetF7f1kb9yvmXTIC1A6PskoXNNB6uZPkzX/7
	UKFM+XerwYTgeNyqkQUzF6u5Tx0HfBEGBC/3m4+Tj35F2yCmQpc2BnZqLQQDFDlt
	3G9bIy3Zy19acDwR3VTqnveZGAQr0lpoS3joCNB44lpHRWcW0Bv2fkmftcztalCO
	oTIbdI08CJmb9X2xaI7VGg1HN/DxKs6cM8cY/2n/g9UhbiHV5sMg6bSIkaNG3wI2
	/4nRUbkaP4B2dfuGxqEwaLPRfEZgLSaC+O8XVzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:h1r7H1JmIfKs7ynKY6TwBeMNMKAvDQv09HIHvnvOfX0=:XruLzfUNKPyOXJRr85//uKUxn9BcK/EXau0HHFWfJxo=;
X-ME-Sender: <xms:R8Lnakzn82T8yz7mB-5eDN02nrgUjlImqj0EDaHSuLpiXCwksgNo3Q>
    <xme:R8LnajGXRhuAH6XOZMwFvaScZdFQkk_-KUSEH3kVwC1hKDzTyE2bOU14vj_U9Ltct
    Y2X2MqHCwCYc2tiu-axhrrGZh3_GEifjUgHI7siMAJ4AfzADzilSTDI>
X-ME-Proxy-Cause: dmFkZTFhUdMH7Nnrx9Bw1Nr4mn/JQ1i/DNqh8HAW2MnBgUaKdagA+LJo+7SK1W3NY8aKJ/
    2BiXK4wA186bBde+9EXRCVCdxaBMobjctDZ5ibYacY7jGUko/ulxToRAH7UJNKzWw0TO2M
    qz6RHR2ZtLDoMzKKun+jEP7M8bbMV7upnPMU8iHqcfdl0S2jERJ1crS57OKVya+OQkywHC
    Cxp0TskD+1mqkTHm27iebRu4QTiLbPKp7IXi4aQlfe/nTXNW5iY0ZUxMvbdN3yVu8hAYH3
    iusBLKW7iPRMjxL5BK+iirsDnWbADeGQ55OQf/drmXTIigpZUriEEhEGl3NnFIKOBuDDXG
    B8AzAlGxxUDLOmMy6unXETyYJjLhQVei56+6w1jkYYfL6za5ntBUHvL9slAV1REnyEnVBc
    nZfKu+GRIgWHeU7yw/10dZCCT2tZ787ITQBEl9+XA7khTXv1+IK8b2GcB52qGPwlI0qxos
    PYdFFZueH83NLSbeVK7Sn2SP+lp7H+0ZSWA1yTAIOo2JHTmtqADaaYG32x4CJqPGqcwe+5
    Jj3c5VoPbPQ1NCLXoc1yWP+apNTDgNAlsZVRchwm/mcnrWsehoYWybA0Ad2Shlef6Y8JEv
    vozuE6IeXKTJ2/4JysXtmO/AWux4GkVnKNuSkUfWSNaNr1V1IwUoqUAsFhNw
X-ME-Proxy: <xmx:R8LnaqvsSn-60AWTcfEja23CPkP1VL6IEZLeoFX86-SU9G8oLqiIYw>
    <xmx:R8LnakYcuQhyuT_YSH1h_uzmb7yLKlEqBbpC4SQ1APjryYQjMaO9Lw>
    <xmx:R8LnaqAdQEySL8B24lQkRrMurqf6WjwS8K4zliaEDiru34ls41z8QA>
    <xmx:R8Lnak8TDDPDOMdROg9mjtdEuEXrwWy5Qn9Y73TAJGUEO4A0hYor2Q>
    <xmx:SMLnatc0APAyOsELPl4NTI7a0HcNPawCrmoU-mMQQWTimCRnEcocIHwc>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 6F6372C00082; Sun,  1 Nov 2026 17:50:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Aq9FyiwXssPF
Date: Sun, 01 Nov 2026 17:50:27 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: kernel@resetko.pl, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Greg KH" <gregkh@linuxfoundation.org>, "Guenter Roeck" <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Daniel Dev" <daniel.dev@noex.uk>, stable@vger.kernel.org
Message-Id: <8d0c94b6-8fd0-4fde-8af5-ade15e142a0e@app.fastmail.com>
In-Reply-To: <20261031-ucsi-lenovo-t14g2a-v1-1-183751e63c02@resetko.pl>
References: <20261031-ucsi-lenovo-t14g2a-v1-1-183751e63c02@resetko.pl>
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on Lenovo ThinkPad T14 Gen
 2a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stanislaw,

On Sat, Oct 31, 2026, at 5:40 PM, Stanis=C5=82aw Titenko via B4 Relay wr=
ote:
> From: Stanis=C5=82aw Titenko <kernel@resetko.pl>
>
> The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
> the firmware leaves the VERSION field of the UCSI mailbox at zero.
>
> ucsi_register() rejects a zero version with -ENODEV, leaving the
> system without registered USB Type-C connectors. Without an OPM, the
> embedded controller does not complete DisplayPort Alternate Mode setup
> when a USB-C dock or monitor that supplies power is connected after
> boot, so the display stays dark while USB and charging work.
>
> The mailbox uses the 48-byte UCSI 1.x layout, and the PPM works
> correctly when UCSI 1.0 is assumed.
>
> Add a DMI-specific UCSI operation for the ThinkPad T14 Gen 2a that
> substitutes UCSI 1.0 only when firmware reports a zero version.
> Preserve any valid non-zero firmware version.
>
> Tested on a ThinkPad T14 Gen 2a with BIOS 1.33 (R1MET63W): both
> Type-C connectors register, and plugging and replugging a USB-C
> monitor with an integrated hub and power delivery brings up
> DisplayPort Alternate Mode each time.
>
> Reported-by: Daniel Dev <daniel.dev@noex.uk>
> Closes:=20
> https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge_6P2x7Wb6=
rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5DcFnkXB0=3D=
@noex.uk/
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org
> Assisted-by: pi:claude-opus-5-5
> Signed-off-by: Stanis=C5=82aw Titenko <kernel@resetko.pl>

This platform was Linux certified so let me see if I can get the FW team=
 to look at it (it is an older platform, but it looks like it's still un=
der support)
I don't have this HW myself, so I'll need to ask the team in Japan to re=
produce the issue. My personal preference would be to try and get the FW=
 fixed first and do the quirk if for some reason that isn't possible.

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 34=20
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c=20
> b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 5697ccc24ec3..33747e24353f 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -148,6 +148,33 @@ static const struct ucsi_operations ucsi_acer_ops=20
> =3D {
>  	.async_control =3D ucsi_acpi_async_control
>  };
>=20
> +static int ucsi_lenovo_read_version(struct ucsi *ucsi, u16 *version)
> +{
> +	struct ucsi_acpi *ua =3D ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	ret =3D ucsi_acpi_read_version(ucsi, version);
> +	if (ret)
> +		return ret;
> +
> +	if (!*version) {
> +		dev_warn(ua->dev, "UCSI version is zero, assuming 1.0\n");
> +		*version =3D UCSI_VERSION_1_0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ucsi_operations ucsi_lenovo_ops =3D {
> +	.read_version =3D ucsi_lenovo_read_version,
> +	.read_cci =3D ucsi_acpi_read_cci,
> +	.poll_cci =3D ucsi_acpi_poll_cci,
> +	.read_message_in =3D ucsi_acpi_read_message_in,
> +	.write_message_out =3D ucsi_acpi_write_message_out,
> +	.sync_control =3D ucsi_sync_control_common,
> +	.async_control =3D ucsi_acpi_async_control
> +};
> +
>  static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command, u32=
 *cci,
>  				  void *val, size_t len, void *msg_out,
>  				  size_t msg_out_size)
> @@ -196,6 +223,13 @@ static const struct dmi_system_id ucsi_acpi_quirk=
s[] =3D {
>  		},
>  		.driver_data =3D (void *)&ucsi_acer_ops,
>  	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 2a"),
> +		},
> +		.driver_data =3D (void *)&ucsi_lenovo_ops,
> +	},
>  	{
>  		.matches =3D {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
>

1) Couldn't you just reuse the ucsi_acer_ops quirk?

2) Better to use DMI_BOARD_NAME for the DMI match. For the T14 G2 AMD th=
ere are two possible matches - "20XK" and "20XL".

Thanks
Mark
