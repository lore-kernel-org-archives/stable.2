Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F024C14E2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217228; cv=none; b=W8ZB17tlfpu9OreDhsO57JgjD/vjiTkHednuXO49cYE2emIoPlSqwxz53V6epsvzEmNRE/T4Wbs40SkuhLY8YDbJAm9qFPnyU/Eel2iZgO5p1+V5U0rzgeDyjRBWKCSBAnBTVyA/tB0gp8/DswtC/nv9WcrBbRBbAwIOuLUWwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217228; c=relaxed/simple;
	bh=O9lBSXMX8ZJn6NCV7Qo+OyrqttL2Cz+ZVuV4r4U4v7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BrThC+JxutttY2ICbelcU9yEcPuyNAF17CEymlc2YzYH8HBdAjL2uHcnDd9BYMNKRUzyjTOpkJM7asAt+GRcavfq0f4d+j/5h+ZI9qpUkfDI6uRCGGH4oyaUDV2tw/m27M6rH//xL4zdJ6D/hzBCPjIVnDTzgFZFb4a4NG6vc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=mIgou8xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9ahTLT0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="mIgou8xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9ahTLT0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 351ED1400192
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:20:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 12:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1791217224; x=1791303624; bh=7fMFCyfAKjqs4FLoFtn1JpAUKI3aqzrN
	/pKxZJGObMQ=; b=mIgou8xmRmQnWl1jG2bYSBVWn5upPWkEFbyGutYEjl5wadYH
	4FHLz2titj2IMGoyV0KV1h1hdvPX2xvGf9b5IrDASAT5WYHepCHnB2aHDhdYclLu
	v+0hmMlweoI2PTFmA+iKG1U1opfeuTgh07OvOV2VhVxFxvBMMlGHdzdnGotDTioT
	FO7XZpGFcg931e1Bb+hhf5yYhNicElYEteA48EgBbI3GBubQEsv9374cJKj9HXJ1
	0Iufk+knAMgDZvWoz0NrYfnEWo7rNgfsskNF3QjWsaKNgFB6Pllt90TALwOMV1Ts
	ZrTA0njpkikg67lztwbMncDYusJhLQSiaaFeOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791217224; x=
	1791303624; bh=7fMFCyfAKjqs4FLoFtn1JpAUKI3aqzrN/pKxZJGObMQ=; b=A
	9ahTLT0YDH561qtE/GIYgQ+NSbR5rJR0pQl+EnOvX690+Cr9N7XESXE1PK8EY4Kj
	m1iTIA4aahWpdlZI3UhIfGw4Arjugokc27nNq6bIzH4kulfcKaEcMawGMqLxAmKz
	OrzOqzRP4AbJiQNGS3euz1eaypFDooCgRzpdr8TTN4/uDvb0sFop50gmtAxIFa//
	mFLlT/R7UfSCpFvpxp/gVFk4WgIGTH3nlJHFqsuftMNsNIUfmgIMMttdq3QAI7Ee
	OVxTJh02Rie51Q1iz7+uqxA0XhI9GoERN0cZuGxURmVz9jS+SGvFsBG8JrzpGC+v
	Dl8Ouf52epzsJefcsnPsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791217224; d=alistair23.me;
	mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CMCMoY4xdbxZh/R9bjZuBTJYZ7+5IsvQ4diRuv8ge01umfb
	jGoOu+VzKK5A9tzm2y2JVciB7HPDStZAkj5jFOCYp5F4pA1q9IDpee6bO9jowySx
	7/tAyCkoPF3fxxpjJMK/dl8Q6PCtIxtYL+dNl21q/21fxs17frnnMkS6dlXjEwUq
	Oq/dKfUiVprpHal//ekgaEx0O2Mev89HHGFHwUq12OzhkYBSioJdQomcS6uPPV2l
	jD1xdU7zJlQpR8gIulK6lompGKO7Mgb7iiOzfJ2fjxbMEbpLTE10V2wsjYRWAC6L
	ocZv9vO/xZv0KLZdhMGxcyRTpMcjIUW1FaHJVvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Ym0n0XQ7xg5cI/IqpJPTITJX+PX/w+HnRNia046nXas=:O9lBSXMX8ZJn6NCV7Qo+OyrqttL2Cz+ZVuV4r4U4v7w=;
X-ME-Sender: <xms:SM7Dar7ievLkTtpdlDBGpuKCO1fCLQ8MFhg4KE_puh6pQuVJQNzttA>
    <xme:SM7Dar1dYQABq6kh58KEo5z2Ys1ZTmqyVBDRhMvNt8W3XfCGciGUHq2CB_uLWjZNw
    R8MEm3OO5qz-2zwnIIAVZLS3h9Wvykw3nWQ2WF02qgUAPGCORQkGv4>
X-ME-Received: <xmr:SM7Dahcu8QHq9AyB_CaaBg6XR76Jpl6WgBAzCLquTc7ZDbaglInN0NWW8osjQXg31E0i>
X-ME-Proxy-Cause: dmFkZTG2GWtYYlVMtomge/gx37ag7n9csUJSdjArruSeSXk4B76Is1uGN33Q4siC5LZeA/
    gpym4yBZDbw9thPZ3JMFMRVZHbf0TzGnowwyAEDzdUvCCoXHDrd6+yB9fkPXr3nEzG8UOq
    UhELnnypi/+b+WK0xiakK7QQEZp3Cqksc8fxvd6Frio6YW/guM4cEGVhJIOpZm9r3/6tWW
    mdZyuWylNVbnxUf78cgJTlbQgBQq6FGYBPucqr4ZzHIYLy+5mDL4xwcJL7JemuFHrTzFxz
    D/+63kw+u/7B3bpa1h6Bl55RGIZPZXDZAdC4hj3NLY40iT/y0Ha1yhZoNtpCCJtXMZwxSU
    XJ5GwoLuJX+ONXYoMoLrWjxYcb1D4zT4SwWbt7ytyRkWoUrRviWDmswzkPLvNKqWM3yyQM
    3y/iEK8bbQtPswvk6NMLsd70x5e9hLvlmhOZQRGh3Di8US7pVOsKMO/5vQV73UUdicblwt
    cqF7/Flx+NSv06H+Wx8JocLHjOLCPE0GjejPDh3jiFxW71vvWTuoobYMDa3T4G2TBJkF4T
    nGxLX5J1HXu9cwfvw9zzIm881uFC1ibN/dd+g/RHfFCaMb2oKlakb8s8VFuTVhknGyKq0p
    GwOtxGa/dh8d4jCuX0J3suzTt4n7D0G5oEhKyG0Aqm+5gAW044LEgtlVWShA
X-ME-Proxy: <xmx:SM7DahdOG_GLINh14KzgXm6l3tIjj0tAVvaPhmTm9YlDFnIe9m7LrA>
    <xmx:SM7DaszFQAvBS3U-t0QgsRUaR5bU4kfTrhPxtQK795lWctFTRDek-g>
    <xmx:SM7Dag_uCMtBYB2d_oOfAgvTupMx8BDw4NRdvL7Iu05ZEnX_pQAZ5w>
    <xmx:SM7DasiqNziRHLqQGinGgGIxZPQhZ7bghcWeFjPWROlMLAnz7kBWig>
    <xmx:SM7DarIal5lvns-HZNW50xcxkCG2YuGL0_AXXE5osmr9goCqgdzkhFcT>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:20:23 -0400 (EDT)
Message-ID: <53f642cf76a2b6c405bebd254afc6d37255af749.camel@alistair23.me>
Subject: Re: [PATCH v2] PCI/DOE: Fix double free of a duplicate feature's
 sysfs name
From: Alistair <alistair@alistair23.me>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, bhelgaas@google.com
Cc: jic23@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Tue, 06 Oct 2026 02:20:22 +1000
In-Reply-To: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
References: <20261003102221.59894-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-10-03 at 19:22 +0900, Donggeun Yoo wrote:
> When a DOE feature is reported twice, sysfs_add_file_to_group() fails
> with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
> frees that attribute's name, but leaves the pointer in place.
> pci_doe_sysfs_feature_remove() frees every name again when the device
> is removed, or when a later feature fails to register, so the name is
> freed twice:
>=20
> =C2=A0 BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b=
0
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 kfree+0x11a/0x420
> =C2=A0=C2=A0 pci_doe_sysfs_feature_remove+0x117/0x1b0
> =C2=A0=C2=A0 pci_doe_sysfs_teardown+0x90/0xf0
> =C2=A0=C2=A0 pci_remove_bus_device+0x128/0x2e0
> =C2=A0=C2=A0 pci_stop_and_remove_bus_device_locked+0x1d/0x30
> =C2=A0=C2=A0 remove_store+0xd2/0xf0
>=20
> Clear the pointer after freeing the name.
>=20
> Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
> Cc: stable@vger.kernel.org
> Suggested-by: Alistair Francis <alistair@alistair23.me>
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> Changes in v2:
> - Keep freeing the duplicate's name in
> pci_doe_sysfs_feature_populate()
> =C2=A0 and clear the pointer, instead of leaving it to
> =C2=A0 pci_doe_sysfs_feature_remove() (Alistair Francis)
>=20
> v1:
> https://lore.kernel.org/all/20260928035035.252394-1-donggeunyoo.kernel@gm=
ail.com/
>=20
> Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
> reports its CDAT feature once, so a test-only change either registers
> its DOE capability as a second mailbox or inserts the feature N extra
> times into one:
>=20
> =C2=A0 case=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 befor=
e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after
> =C2=A0 no duplicate, remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 no duplicate, a name fails at probe=C2=A0=C2=A0=C2=A0 no report=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 two mailboxes, remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 double free=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 no report
> =C2=A0 two mailboxes, 3 remove/rescan cycles=C2=A0 3 double frees=C2=A0=
=C2=A0 no report
> =C2=A0 3 duplicates in one mailbox, remove=C2=A0=C2=A0=C2=A0 3 double fre=
es=C2=A0=C2=A0 no report
> =C2=A0 2 duplicates, a later name fails,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 =
double frees=C2=A0=C2=A0 no report
> =C2=A0=C2=A0=C2=A0 probed twice
>=20
> The doe_features listing is the same before and after in every case.
>=20
> =C2=A0drivers/pci/doe.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index ac95b1d2d9997..6b5d9ba8e9697 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -208,8 +208,9 @@ static int pci_doe_sysfs_feature_populate(struct
> pci_dev *pdev,
> =C2=A0				pci_warn(pdev, "Failed adding %s to
> sysfs group\n",
> =C2=A0					 attrs[i].attr.name);
> =C2=A0				goto fail;
> -			} else
> -				kfree(attrs[i].attr.name);
> +			}
> +			kfree(attrs[i].attr.name);
> +			attrs[i].attr.name =3D NULL;
> =C2=A0		}
> =C2=A0	}
> =C2=A0
