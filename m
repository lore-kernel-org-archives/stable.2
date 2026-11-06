Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987695;
	b=WSbvXe+uKvC4kVBupjlZFAXwzMBIgXa/LAvKImB9dTIA85z5HVpsIXj1FYslsGwbqPCY
	 d/KH5HwG7niu0xFKpBOb0GYuj1seMZ23BHVTfeVHSF/3qdqDohm5cqlqJMht74TRY8xA0
	 X0fe/EYFKpXYzw1RysbsttZ2iLpAaZk3h9yOrniTAMGVD5QClUT/Io7I2oFAElgK8dthk
	 CrCyRojL7XFhPlU9WjJDQwSfpsN4ol4fpZ939/9HE3F5J0nazNutI3aOYZT5czxA8HFoB
	 OBLRiWFjJZjmmCXjhD6KH+t2UT0szHaiL1aw9TG7dbAvA55NXUSRPwYCBgCLThoqkvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=mIzptHiQC4YdKDLHWPNLGx8SBpmuCgEvD10hVuSAGoI=;
	b=Quf0R61ihXQQ/ogAGeZ9ozl98/WtVE0hczpbgQakJOaxCmEVvIfIXjCijyWWEDp9gl/l
	 s6GpMv2QHCAtMW+M/1YAioHCljpUgV1ECDF5em9jCkeEbWXY6c69AxJ3ziTFQ9xl7XoPI
	 XawWVRlnSi31VoXrW0o1x2ypJOhmIC/vXwJtUy7Il5WxXSUMElj3GnzFa/FxM3uaDBD9Z
	 VcgImQOt7zwKJf0mfoCDcIWjAPnnVNJVFcANZLbigkEJhbDMFrGccbG1NL8dQ6JrO7J+J
	 D1O+JHAn42p70hELnpSRxcp22LJW/BBsUqErNW+7YA4RxtuR65xKaBGI0qHtt88367A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squebb.ca;
	spf=pass smtp.mailfrom=squebb.ca;
	dkim=pass header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=kYppuM3z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QfrLarG1;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4E606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F4E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=squebb.ca header.i=@squebb.ca header.a=rsa-sha256 header.s=fm1 header.b=kYppuM3z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QfrLarG1
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 622AC7A011F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:54:53 -0500 (EST)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 12:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793987693;
	 x=1794074093; bh=mIzptHiQC4YdKDLHWPNLGx8SBpmuCgEvD10hVuSAGoI=; b=
	kYppuM3zL2R3/Dord83TvrSQbFW4RMws0uvRczGmHn5f+dRlukr+FMtQgLZe2jqe
	OmHDDLndRF6UG0Uq8XS0RN7fCRelrsLm+fEuUiCoQfOD/uSfCm2UxJLIn21C9BgI
	bbc4iItGjKpq88oKWpPyjLtGm48xP9+xQF4zEK/E/TBhmJK8ti+fkxdCxv0gCfus
	KseQTCPIvAtxDfC39bZEXORjZXwE4d9OJyrVtrN9TkWJl2bvzKOf9OSfCJGIUTZ0
	V4g+rlRVmRGXZwdVHjwwtXsHxdpDziID3lklZ2Vh1j8NTXZ/XMXojUyg2p3Fz8n+
	IV9txzQ/AO0ajon4Nj9AtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793987693; x=
	1794074093; bh=mIzptHiQC4YdKDLHWPNLGx8SBpmuCgEvD10hVuSAGoI=; b=Q
	frLarG1TCegiGIlfQ3aww4RmWqx0zQiOzXzEvwhurr7uT7UyX08SkS15QwEI7woO
	p/iAhsIh/fGNZGfvjsOqRY9kEbrfdyMZPPhCWlblGSoDMlp6Dg+6SqC4CHdQgGxw
	N8BJzV0QDYrFbzKp9ON1cicIjUgXtl7sRey26Gs477YgdIqHRXQ71iWD9So5l9lI
	g8a6eDD0PA18KUqLZfjoQV53u0DXOJGGsTEZtXbjnC/8eyONNgoxs7jecWcL9+/3
	uN3C4MK5oSnUwwS5Aqj5XUwW/1iVZygpM2xKoDZvja6GxLerKNl/5LApVvLbFxq6
	9cSW4u7A0bhbh0fr9iAIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793987693; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PqD0IoFg1mtuUtbC09/z7avcKg3OGzUVcfWSd0qnNjRNGhA
	+F9xNyscQN9Yamp1KyCG9KeQ51hpZjQ7/1SJtF6OfM9I+BFa27slO9a2VARSsjbs
	NK0Uv4t8LNcxWgxCY6ojxpyGwYMIv+NlbCoyPSfCgbmj0MaNJoZ1SVdJ+8j4eWbI
	W58RU+GbBW2gfIlwrgS79XbuwjbOAAQUeVtZ6ga0769F/GL9qXucCBeLBlDqPAu+
	TtlSJBUStrOHOSc4Ew038SuJtwVSgkIGzTs+YNuf8az9bhA3iyjXFo9Jk0tu0T8t
	f9qVQkHI0ifNEkCdRE6WrlukW54X23CtmjHkVcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:opmdPiM6ymcvQyVAy1G5ORS7wQnTL/6D9fKqHmzGTzs=:rQMQpxAlKXLw4MzZheW6iokAoDgM+3vycxljMeVkE3o=;
X-ME-Sender: <xms:bBTuas1mMIguK86uHwWGBoQS_vK9zpejkRHoWY9rVX0M6QpjKhrOAg>
    <xme:bBTuah7Hgt_H9iAR0KrSRMqTxtuXqwcyY_5947O3wB7tOrEIWx8cdEor8XCZ9HQ1Y
    JbRHjJltWIwG8kbKCRW5DlBqAxZebUDjLlhmyDiUgLov5GV3AP7b8vg>
X-ME-Proxy-Cause: dmFkZTGQ6HMW7D3zWpp+Pi13TWmK1X+rlTAUEbfB198eJ1/OO5YNAYb0lvz+n7FzUMhhZ1
    7Dds1sCi/l44Xc8AEbm7uaD4Cmpr4iKaVdXipeK8dOvbqeVuRAOtoCmicG/5z8DSWTx3xB
    C+Rt4sDuESPxjprrne0fHxKK9o98AeQw7h8AL8IAt+PLk1hGf7JnsJMBGyVSv4cGFk0T3o
    oTzdxuTAWkD7g159noPAfunr8jVbviAfZvqaNyMYLkX4S/wt+AfTbNlagjofKjDHINAEZz
    NYjJTdDS915bwSF9WFNzhL+Kll33sn173vx+BaG1V+OMdfJKogpxAs1EPtPIhYSn0cJSX9
    DksR96CgeIt7fH7VkycZXO1qyygfnZ+8CIoXx3addLsEt7XI0siATEwWiCP8iZfKHDnLEv
    CqytxdYATiVxMewCm4UNI+gxpVDe5y5da9EjZp7In2xR08CKP3zvyD48AxLblwkC5IAYtb
    HnqdOZKIJ9s1FkjHkMrtvdyODtj6N/nuKroVdm5YxZd+yvect1yldFyHj6WSmz36nXqWyg
    EB27QsAdEc6CAbUUWx9tYu7GHwwxkPcGLCXJpnFFq5n0HCYVxs2tbICg9WFz8Mgn8RC3Sh
    /nXXBvR2B0pTe+cEaQWoGzLC12UsszoEBHrr47ubg041Y8gu63XdqPBCeLUg
X-ME-Proxy: <xmx:bBTuanQj5rKdydAFvBsEZg1ZNW_KsTBkxoynUHkF-SVmZ2cR4mbQ9A>
    <xmx:bBTuatsFVES9zF42X7m98ABEAijZmwwpLU4vAngyNZKiVSsPS1t8Vg>
    <xmx:bBTuahFwbWamm79rTe5II9NphpPjCuP2u5eCadt8X0fM06tjkHtKyw>
    <xmx:bBTuamyzlQ5jSyxYstU7k9snT-r5OiF4y1xemeAc6g8YP6atVty9qw>
    <xmx:bRTuapRgyu8Ynn8-XEXA5sa5TQHMbi9IS253rPLUaCfZvphO925GWebL>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 6BF3B2C00085; Fri,  6 Nov 2026 12:54:52 -0500 (EST)
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
Date: Fri, 06 Nov 2026 12:54:27 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>, kernel@resetko.pl
Cc: "Greg KH" <gregkh@linuxfoundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Daniel Dev" <daniel.dev@noex.uk>,
 stable@vger.kernel.org
Message-Id: <79fec522-e734-4194-bf1d-57b1cb0b67c1@app.fastmail.com>
In-Reply-To: <au4GUwhJz1jxYnqF@black.igk.intel.com>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
 <20261103-ucsi-lenovo-t14g2a-v2-2-e85c659b56a2@resetko.pl>
 <au4GUwhJz1jxYnqF@black.igk.intel.com>
Subject: Re: [PATCH v2 2/2] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Lenovo ThinkPad
 T14 Gen 2a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Nov 6, 2026, at 11:54 AM, Heikki Krogerus wrote:
> On Tue, Nov 03, 2026 at 05:10:21PM +0100, Stanis=C5=82aw Titenko via B=
4 Relay wrote:
>> From: Stanis=C5=82aw Titenko <kernel@resetko.pl>
>>=20
>> The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
>> the firmware leaves the VERSION field of the UCSI mailbox at zero.
>>=20
>> ucsi_register() rejects a zero version with -ENODEV, leaving the
>> system without registered USB Type-C connectors. Without an OPM, the
>> embedded controller does not complete DisplayPort Alternate Mode setup
>> when a USB-C dock or monitor that supplies power is connected after
>> boot, so the display stays dark while USB and charging work.
>>=20
>> Use the zero version quirk for the ThinkPad T14 Gen 2a, matching the
>> two board names of this model (20XK and 20XL).
>
> So is the product family the same?
>
> Could you use DMI_MATCH(DMI_PRODUCT_FAMILY... instead of adding
> separate matches entry for both?
>

The board names are what I recommended - they are pretty safe to guarant=
ee they won't change whereas other fields are less guaranteed (guidance =
given by FW team). It is annoying there are two I know.

FWIW I would rather wait for confirmation from the FW team if they will =
fix this before accepting the quirk. I am still waiting for a reply from=
 them though I'm afraid.

>> Tested on a ThinkPad T14 Gen 2a (20XK) with BIOS 1.33 (R1MET63W):
>> both Type-C connectors register, and plugging and replugging a USB-C
>> monitor with an integrated hub and power delivery brings up
>> DisplayPort Alternate Mode each time.
>>=20
>> Reported-by: Daniel Dev <daniel.dev@noex.uk>
>> Closes: https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge=
_6P2x7Wb6rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5=
DcFnkXB0=3D@noex.uk/
>> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
>> Cc: stable@vger.kernel.org
>> Assisted-by: pi:claude-opus-5-5
>> Signed-off-by: Stanis=C5=82aw Titenko <kernel@resetko.pl>
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
>> ---
>>  drivers/usb/typec/ucsi/ucsi_acpi.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>=20
>> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/u=
csi/ucsi_acpi.c
>> index 47ba0e15b8ba..d752fc7b61ec 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
>> @@ -196,6 +196,22 @@ static const struct dmi_system_id ucsi_acpi_quir=
ks[] =3D {
>>  		},
>>  		.driver_data =3D (void *)&ucsi_zero_version_ops,
>>  	},
>> +	{
>> +		/* Lenovo ThinkPad T14 Gen 2a */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "20XK"),
>> +		},
>> +		.driver_data =3D (void *)&ucsi_zero_version_ops,
>> +	},
>> +	{
>> +		/* Lenovo ThinkPad T14 Gen 2a */
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "20XL"),
>> +		},
>> +		.driver_data =3D (void *)&ucsi_zero_version_ops,
>> +	},
>>  	{
>>  		.matches =3D {
>>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
>>=20
>> --=20
>> 2.56.0
>>=20
>
> --=20
> heikki
