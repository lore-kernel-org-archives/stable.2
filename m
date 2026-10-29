Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265700;
	b=QRkpcXJzPxjidxDWia/yQPsLarkaoqJkLp4p+w+KuXohGIWu1E0Gt0v4rEMTC4ZbHEam
	 MTcqxZuTjeE1lNOO53NAes3rHz33naaeqnqpm45JemlC8rQUfgkWM8o5NqFdT+tXS5evS
	 qVh6cGn/rxvIpqCVXGeLZSFr9z00dUHDFDcINCuEQiCcBt8EjeMXHerUofBQfLTRRV8bA
	 0hCphbrvvMAYlyd6EgMlZWFibqMFXNJr12vSxI7yVt22rxlRKrs1+h4ZPTe8zUMMEMDyf
	 47GYzTeCX9cbOiRW8JGSzg/MceemUJVhglJ0n3yOqDi4en5SE4wa7JgetAQ2WKE4vpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265700;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=yARdWLlMp7ZM+u59k5EdJxvAzcZKSN+O9OmNKSrISPg=;
	b=xgPHdo8lCtkS3eBU/w/V2x4ySTsgdiOvX5lCmG3Q7Bpb3JLb8CYy6clOELrhEOVg7q4i
	 YAFTqYrOytUgVSBsdRaylu521gXuvWfqhzOtherqXCPOmExMDdW08QHnGp72/d7NeY6m2
	 XPEL5jz0vlrQjRdOCqy5PmYYt8MSIHXTponaFvnMWxESmXLeVGcQsAi8jjplzQ8D1EmVn
	 JW1Lj3/33GuGMDM++lqZeKwLGHRBarahVmxnNuOW0qKUash8fpH/yQHRXI3g0EKyqsM19
	 3Qc7kc12+Tq6f9ZMlt/JtxG8vbQkiGIgEGEDcRruuYsP0x/86xa386VqxjW78f+K7rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IXmSpdt0;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F0606A323;
	Thu, 29 Oct 2026 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 379F0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IXmSpdt0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793265693; x=1793870493; i=deller@gmx.de;
	bh=yARdWLlMp7ZM+u59k5EdJxvAzcZKSN+O9OmNKSrISPg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IXmSpdt068Lb82CToMe2u2nKtVYZVqGsKiHJilw1a7rAqDLD96NOJi2leHmuOfKL
	 VbcD/bFSDlDRo48UG0wYL2X/b+5OZjN62iP+Fi8RSVJ95aFF1Bg9CLhCSXBSQ6e3R
	 e0pM+FOvHKs+NHP2e9ZDzj7y6nALnJxR6jOYtAXx6xxepPuxUt7jmDZJYOc1G4dBy
	 tmTLg+KIf32wNNe3JKcAFh2czWmlfuUG7Cz4Rz5eTLLFGUxbrfsjUDXI0ZbR2KuSg
	 QdGgnHQlzWcvHRSAXBweRhKnqV1Q4o3OrrzTn1B988joIUMb+Jup4DgKUmwWyLGtj
	 uu/RYtVIfRtaDJHGDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1wcuu32hcE-015sHb; Thu, 29
 Oct 2026 10:21:33 +0100
Message-ID: <1261fa6c-b724-46c1-a2a3-82826df1fdb3@gmx.de>
Date: Thu, 29 Oct 2026 10:21:32 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory
 size
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20261027160914.3787276-1-bestswngs@gmail.com>
 <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X4IQzqdBb2RAGG/Pm64X0L0nJvQhTx1L+yIctWx1t+dkafn4gg7
 hM6rnAXJWiTqcciErZnOOKIq8GjX8wrCl9jiX285UkZsbSGVlfu1wGriBjZCJM1YgD3DrAP
 3iELOJ5jZVhMBar5SxrGwrnnmcls8HVikhIKIQKc7aqJwFZWSUVuhSHfcO0kmErtHL4o7H0
 1bxId9GgItXgdDSaREtDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6nLpTkZyfPc=;iVi2Z5rTpkgFq31rco00ov+7/NU
 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

On 10/29/26 09:09, Geert Uytterhoeven wrote:
> Hi Weiming,
>=20
> On Tue, 27 Oct 2026 at 17:16, Weiming Shi <bestswngs@gmail.com> wrote:
>> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
>> overflow get_line_length()'s int multiplication and bypass the
>> video-memory limit, allowing fbcon to write past the framebuffer. The
>> offset additions can also wrap, while an excessive videomemorysize
>> module parameter can be truncated when PAGE_ALIGN() is assigned to
>> unsigned int.
>>
>> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
>> keeping the stride, framebuffer-size, and generic fbdev drawing
>> calculations within their destination types.
>>
>> KASAN reports:
>>
>>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>>      drivers/video/fbdev/core/sysfillrect.c:24
>>    Write of size 8 at addr ffa0000001671000 by task poc/198
>>    sys_fillrect
>>      drivers/video/fbdev/core/sysfillrect.c:24
>>    bit_clear_margins
>>      drivers/video/fbdev/core/bitblit.c:247
>>    fbcon_clear_margins.constprop.0
>>      drivers/video/fbdev/core/fbcon.c:1410
>>    fbcon_switch
>>      drivers/video/fbdev/core/fbcon.c:2261
>>    redraw_screen
>>      drivers/tty/vt/vt.c:994
>>    fbcon_modechanged
>>      drivers/video/fbdev/core/fbcon.c:2693
>>    fbcon_update_vcs
>>      drivers/video/fbdev/core/fbcon.c:2732
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
>> Suggested-by: Helge Deller <deller@gmx.de>
>> Assisted-by: LLM
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>=20
> Thanks for your patch, which is now commit f93dd31db3e23e61 ("fbdev:
> vfb: Validate framebuffer geometry and memory size") in fbdev/for-next.
>=20
>> --- a/drivers/video/fbdev/vfb.c
>> +++ b/drivers/video/fbdev/vfb.c
>> @@ -31,6 +31,9 @@
>>        */
>>
>>   #define VIDEOMEMSIZE   (1*1024*1024)   /* 1 MB */
>> +#define MAX_VIDEOMEMSIZE       (512UL * 1024 * 1024)
>=20
> Is there any point in having a larger limit than 256 MiB
> (i.e. MAX_XRES * MAX_YRES * 32 bpp)?
>=20
>> +#define MAX_XRES               8192U
>> +#define MAX_YRES               8192U
>>
>>   static void *videomemory;
>>   static u_long videomemorysize =3D VIDEOMEMSIZE;
>> @@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
>>                  var->xres =3D 1;
>>          if (!var->yres)
>>                  var->yres =3D 1;
>> +       var->xres =3D min(var->xres, MAX_XRES);
>> +       var->yres =3D min(var->yres, MAX_YRES);
>> +       var->xres_virtual =3D min(var->xres_virtual, MAX_XRES);
>> +       var->yres_virtual =3D min(var->yres_virtual, MAX_YRES);
>=20
> This violates fbdev API rounding rules:
>    1. If a value doesn't fit, it must be rounded up by the driver,
>    2. If a value is too large, -EINVAL must be returned.

Thanks for your review, Geert!
You are right. It's still documented like that in skeletonfb.c
Weiming changed it based on my feedback.
Weiming, no need to resend the patch.
I'll pick up one of your former patches.

Thanks!
Helge

>=20
>>          if (var->xres > var->xres_virtual)
>>                  var->xres_virtual =3D var->xres;
>>          if (var->yres > var->yres_virtual)
>> @@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *=
var,
>>          else
>>                  return -EINVAL;
>>
>> +       var->xoffset =3D min(var->xoffset, MAX_XRES - var->xres);
>> +       var->yoffset =3D min(var->yoffset, MAX_YRES - var->yres);
>=20
> Likewise.
>=20
>> +
>>          if (var->xres_virtual < var->xoffset + var->xres)
>>                  var->xres_virtual =3D var->xoffset + var->xres;
>>          if (var->yres_virtual < var->yoffset + var->yres)
>> @@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
>>   static int vfb_probe(struct platform_device *dev)
>>   {
>>          struct fb_info *info;
>> -       unsigned int size =3D PAGE_ALIGN(videomemorysize);
>> +       unsigned int size;
>>          int retval =3D -ENOMEM;
>>
>> +       videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);
>> +       size =3D PAGE_ALIGN(videomemorysize);
>=20
> Perhaps return -EINVAL, too?
>=20
>> +
>>          /*
>>           * For real video cards we use ioremap.
>>           */
>=20
> Gr{oetje,eeting}s,
>=20
>                          Geert
>=20
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m=
68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.=
 But
> when I'm talking to journalists I just say "programmer" or something lik=
e that.
>                                  -- Linus Torvalds

