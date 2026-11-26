Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714458;
	b=TC1NJfInz82vutKoldCk7UcWSfE/VRz2spjvkbh5vlox7qMQRodSXBGvV4RyjO5t3MPo
	 LSmjGpt53buyUboYfwQZic0yCdr8qTHq589OFXgHyb8JNgFTYC5BBGsDKEDRmBFqapZ14
	 vV7b0E6FeaHRuRoM5/PHuLhO3wBOrB/6eY8D732W1pkrh/nFX1W61Pc1MR0T+9PJ+Mzp3
	 9O7gw1VpEMVSCbDS+iSZ5Z8rwv2EG8e1bl6jMR9OkS6K8D4TjQZgG+aMGpA6huSABawUx
	 QwtTgx1gzJmqXlN5AZc9u42J5YDEDUvCQyVHJhtRovDNICFCgO2rMuDYwODJGlZYTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714458;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=ZrHQ5khre1DkrWkgBl9aumcO/ImQop/ZVlpMoHp+2ZY=;
	b=diri8U1L66gT7kbSpoFien/o/ps//hFZvF7a3DY3daCZkLlh7+fWsopEYQGwErjR9vWM
	 EGUtMrn5R62mobYmWdHtL9CKLfwnJcaq41h/UH3kWClJJ1lZW2XnRn6oCPqUxo/KBDHPB
	 KM0lLh134UhQ5rcHKhFqGwrPZg+OVmSPmTYQ+RFvfOryZkET2PdOB8ZIiE0jhltcLWRgO
	 qONEGbqVfkdCM65U5QbQC+VqFSpRg/meLAP3pmcKm12AQMzpvp8y/CPRuej7YgjrHUJJw
	 IqtYBCCge4k+IgxQQN7BRHPrTOXdMSO099lv2tMIfXHQFMm/egO9NwGTaL5wlhnohgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LiNpPB8r;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C28606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C28606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LiNpPB8r
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 519101A1815;
	Thu, 26 Nov 2026 17:34:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CF9560558;
	Thu, 26 Nov 2026 17:34:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C44511E69167;
	Thu, 26 Nov 2026 18:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795714450; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZrHQ5khre1DkrWkgBl9aumcO/ImQop/ZVlpMoHp+2ZY=;
	b=LiNpPB8rzaiL3I26xFGiYwy68pXAoVR02F9+RM0KIpyaJMIHeeYsiSUPpB0DMzF+4sUMzU
	B8+kUMtUjA+SXx3blvFrN+gpGOnJYPcIoT0iWu3+NYuBzcq4uy705tvd9t5NpVdYXJndos
	JOVY/fibGjnUbBA0FxVERZHdtVDTERlq4EznI1eMYMXyssEZ6nq4UtC+r7zP0EgMtdJlNX
	aUUhsZxzfz4F/21h1AIJtFndntA1dykSM9eTFTO62z9o4O53X5ghju7qHSa2sTfGXPw1ql
	lb3b/zYuxjDgedKCdJkUQVEvkL7QrE4he5tww7EGraxMYuMXHlw7OIAd9ECgVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Arseniy Krasnov <AVKrasnov@sberdevices.ru>,  Boris
 Brezillon <bbrezillon@kernel.org>,  Kyle Roeschley
 <kyle.roeschley@ni.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: macronix: serialize OTP access
 with NAND operations
In-Reply-To: <CADvTj4q79XR9ymtzBHr7TUc+TnuoB2R-sUa+BWOCS1u7UTEUkA@mail.gmail.com>
	(James Hilliard's message of "Tue, 24 Nov 2026 09:10:06 -0700")
References: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
	<20261122-submit-rawnand-operation-locking-v1-v2-1-030bc867f0c7@gmail.com>
	<87a4mys2ia.fsf@bootlin.com>
	<CADvTj4q79XR9ymtzBHr7TUc+TnuoB2R-sUa+BWOCS1u7UTEUkA@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 26 Nov 2026 18:34:05 +0100
Message-ID: <87y0afv6nm.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 24/11/2026 at 09:10:06 -07, James Hilliard <james.hilliard1@gmail.com> w=
rote:

> On Tue, Nov 24, 2026 at 7:55=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>>
>> > OTP I/O can also run while the chip is suspended.
>>
>> Really? Where does that come from?
>
> I was referring to chip->suspended in nand_base.c. nand_suspend() sets
> that flag even when the chip has no suspend hook. Normal NAND I/O waits
> for resume in nand_get_device(), but MTD calls the Macronix user-OTP
> read and write callbacks directly, bypassing that check.
>
> I haven't observed OTP I/O during system suspend. Userspace is normally
> frozen before device suspend, and the Macronix driver doesn't install
> its deep-power-down hook on the MX30LFxG18AC parts.
>
>>
>> [...]
>>
>> > --- a/drivers/mtd/nand/raw/nand_base.c
>> > +++ b/drivers/mtd/nand/raw/nand_base.c
>> > @@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
>> >   *
>> >   * Release chip lock and wake up anyone waiting on the device.
>> >   */
>> > -static void nand_release_device(struct nand_chip *chip)
>> > +void nand_release_device(struct nand_chip *chip)
>>
>> You export a core helper...
>>
>> >  {
>> >       /* Release the controller and the chip */
>> >       mutex_unlock(&chip->controller->lock);
>> > @@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, =
loff_t ofs)
>> >   *
>> >   * Lock the device and its controller for exclusive access
>> >   */
>> > -static void nand_get_device(struct nand_chip *chip)
>> > +void nand_get_device(struct nand_chip *chip)
>> >  {
>> >       /* Wait until the device is resumed. */
>> >       while (1) {
>> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/r=
aw/nand_macronix.c
>> > index 16847f28b19d..d7f5a9e7c240 100644
>> > --- a/drivers/mtd/nand/raw/nand_macronix.c
>> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
>> > @@ -380,6 +380,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd=
_info *mtd,
>> >       int ret, cleanup_ret;
>> >
>> >       nand =3D mtd_to_nand(mtd);
>> > +     nand_get_device(nand);
>>
>> ...and you use it across the entire OTP operation...
>
> The race doesn't require suspend: an ordinary page read on the same
> chip can issue its command after the OTP callback has enabled OTP mode
> and before it restores normal mode. Locking each command separately
> would still leave that window open.

?

You are using nand_get_device()/nand_release_device(), I am not
disputing that choice. You are using them in each and every otp op
implementation, which does not make any sense. It does not matter if
there is a single user for now.

>> >       nand_select_target(nand, 0);
>> >
>> >       ret =3D macronix_30lfxg18ac_otp_enable(nand);
>> > @@ -426,6 +427,7 @@ static int __macronix_30lfxg18ac_rw_otp(struct mtd=
_info *mtd,
>> >                       write ? "write" : "read");
>> >
>> >       nand_deselect_target(nand);
>> > +     nand_release_device(nand);
>> >
>> >       return ret ? ret : cleanup_ret;
>> >  }
>>
>> ...and in the commit log you mention:
>>
>> > Make the existing NAND serialization helpers available within the raw
>> > NAND core and hold them across the entire OTP transaction
>>
>> Why are you doing the serialization in one vendor driver then? Aren't
>> all the vendors affected by the exact same issue? Why isn't taking the
>> lock once for all in the core a better idea?
>
> Macronix is the only in-tree raw NAND manufacturer that installs MTD
> user-OTP read and write callbacks.

That's not a reason, we don't want the race to re-open every time
someone adds new OTP ops, right?

> Both use the same helper, so taking
> the locks there covers both paths without changing the interface.

You wouldn't be "changing the interface" whatever that actually means.

> A core wrapper could take the chip and controller locks around a
> manufacturer's OTP callback, much as nand_lock() does for
> chip->ops.lock_area. That would give future implementations the same
> locking, but it would mean adding raw NAND OTP hooks where MTD currently
> calls the one implementation directly. Is that the approach you had in
> mind?

That penultimate sentence does not mean anything, you should really
write your own answers. Anyway, I think the answer I should give here is
"yes".
