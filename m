Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD54DA9C3;
	Mon, 12 Oct 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839285; cv=none; b=FeneDIF3Ige8kRu6T23cbZsXvPZ1RQTZIaFrH2WKuuLtioFLuysk0nj0iTKZ6DH9eAyckDp0NulBAWNUNRndo4z9pYA2fVMbb2rr5gYF2A4anAMvqHI6dakFZt7UIaY66Y8roHDWexd1m9m1bhTZc7p8ACdS5cdHVp+6vHJ/wVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839285; c=relaxed/simple;
	bh=iDxnN/dn6G8HsM6+QbNItwfWeuseJkCvDPoC25LAkrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbq1rahnJDI4lce2GlrXwQFx+r/Pol21IXnmb5Vy6DYlwl/iuRIWFRwXbRBDJMbDRRYOo1XNA005KafhzHtkOw5XxBMSSHrIN0nZ1J3SUsy85qdslw+sacrw6bJZfdwpuxE9SjIYlRtu6Ss9LLTu2rqK+NUeo3Ph6hJZixirfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=oD/kDVAm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="oD/kDVAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791839260; x=1792444060; i=deller@gmx.de;
	bh=1OOL8M/3sc++4OIcz8+DDUfZHmoCqVeZM2Cl3DkBRsA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oD/kDVAmCqqeGZWomX9iaUxRUBABL6TVxsJSdg3gwBaGCAKNUJ2FZMrnIHTzBpim
	 827TogP8x73LP90dYWcQEJ1oK7okd9279ouKeVfRUy/wHbzkCLmHhem1rF40/nvq9
	 xkdbXf7AQSUvs0BxjCi4V2SI1cnxTulfanNoRPOAAQhOoCqArWX163SNYqOxcmejF
	 0D60r/NdmPmlqHpYwiBdY6L7AmlBwVVb1oF8D+sFJajXOAl/n8pbFYJT40NbXaaWu
	 dSzz76JJMS0DSCKA0ezMSd/dxIhW7D+aBWOWu71gGe/bkAn9MnnLMtqo0fzr5ngli
	 thRLle0wXE64u9o4Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1xPCwu2OJs-004VpR; Mon, 12
 Oct 2026 23:07:40 +0200
Message-ID: <fd60a2c8-e4e4-4599-8453-78c3c0e96936@gmx.de>
Date: Mon, 12 Oct 2026 23:07:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] fbdev: fixup callers which ignore errors from
 fb_deferred_io_init()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Steve Glendinning <steve.glendinning@smsc.com>, stable@vger.kernel.org
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
 <as0PDmzYL5Bc2NrR@gremlin>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <as0PDmzYL5Bc2NrR@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ryABwZUmPUcfSt/4ydOXRnINRTRrBFo9IKCyP49JVq1Q7Mw0UNi
 g7w7sIv4HVx0tmEGf9zkFbx4A5Lf+tIbwx8QDbqQiYi/sLRpLz1D0JN8dIbvpJNE7HnqhG8
 GcCAr+nN2kXvyw/GjiEjC7yNSkbopnv9YlwdDYZlUJ1y5/Rfu3Tt+jjnc6oOVi1D6LNCp5Q
 fmdCbihDNl5yP76IGfL5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4IhYGWA2u68=;INdTFgTDDj6tFeioNwNFdrFwZTj
 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

Hi Lorenzo,

On 10/12/26 18:48, Lorenzo Stoakes (ARM) wrote:
> On Sat, Sep 26, 2026 at 02:16:58PM +0100, Lorenzo Stoakes (ARM) wrote:
>> Commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct=
")
>> converted fb_deferred_io_init() from a void function to one returning a=
n
>> error value.
>>
>> However a number of callers don't seem to have been apprised of the fac=
t
>> and continue to treat it like a void function.
>>
>> This is problematic, as upon allocation failure, struct
>> fb_info->fbdefio_state is NULL.
>>
>> That means when a subsequent operation is performed upon the driver, fo=
r
>> instance opening the file, a NULL pointer dereference occurs.
>>
>> Update all of the remaining drivers which fail to check this to do so.
>>
>> This issue was discovered as part of a separate series which updated lo=
gic
>> belonging to ssd1307fb.
>>
>> Also fix up a separate issue with a BUG_ON() occurring on allocation
>> failure for udlfb and smcufx.
>>
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> ---
>> Lorenzo Stoakes (ARM) (6):
>>        fbdev: ssd1307fb: check for fb_deferred_io_init() error
>>        fbdev: xen-fbfront: check for fb_deferred_io_init() error
>>        HID: picoLCD: check for fb_deferred_io_init() error
>>        fbdev: udlfb: check for fb_deferred_io_init() error
>>        fbdev: smscufx: check for fb_deferred_io_init() error
>>        fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error
>=20
> Ping on this!

Thank you for those patches!
I've applied them now to the fbdev/for-next git tree.

> I know timing is awful given a. the insane volume this cycle and b. LPC,
> but these are fairly mechanical things so should be relatively
> straightforward.
Yes, but still I hesitate to push it for 7.3, as it seems quite unlikely
that a normal installation will run into this memory leak.
So, I think this can wait for 7.4-rc1, right?

Helge
