Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215732;
	b=Xkq3FVSiZWY3xznYV3IH7efScmW5YtLRdbm5AJdU5cZyk58Wf2tgOPoSstxX73FkZo9Q
	 vsabXki2IjAt0T4VnxfvaLvl5C5SViJYXgquVdcrVQXx1id5VHTnBuuO/cQ/BMYH5a7pj
	 iXLMIN1fPwy81chih+LvuVK0epSJxyad5lZpQPLHhVthK6b+6HMIKgW42VgWdTbr80HKR
	 FIjmZe/uzP6WNUTahZqk6ZcS07q9Ab3GoBbdFvGzNP20Bp5EfnjFhISD7t+SFY7miHM3K
	 pud3g2IVenGmrIvsneNc2xd+OTX1DFdpOvdaWBNe0WQmHObRQCw4Sg3Jz6BUUtGXUWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215732;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=hY9QOKmbqlDW/lvrqgKdWC28+hetbENKQX2tDEDTPXU=;
	b=VAvJ6z52NcC+g5g/yvo9EzOptUCYfTl7fHOh76LdQ4Hrv27D03cGeQrvK6nqaEntHG+5
	 9iVzARpwFridG3cdR4Zv1dXUDms6jfRpbslZiDvUmx7khx6kFJob3rKZRB81E71j2H2fF
	 +u3A5m442S/9cC6zesPEbnbpQXVng+Ot9yqz5IGEwqlSH9Emtz2m239cx18HNd7m+FAna
	 C0W6yyleIcc8qNSEvcLMkysK4NE1IVTLW3M1tDEK/5X3BlbgrhL5+qBUwBUTRcKK5syrw
	 u2TUvPC/3D3WGWkH4deifKE4RjeqXfhHmvrua9N6h6imWvn43EHFQ6GMP4qb9qnWcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KA8RWHbQ;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40180606A31E;
	Wed, 28 Oct 2026 19:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40180606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KA8RWHbQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793215727; x=1793820527; i=deller@gmx.de;
	bh=hY9QOKmbqlDW/lvrqgKdWC28+hetbENKQX2tDEDTPXU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KA8RWHbQPXUT0GdSLmrXgz70pQY3GcqrH1bqX1ioVIRiJX61flUUY7TwKSj4/bty
	 U9pj2sfOWZMwBMwOnczraHzzk48vmW1ZTt90ZMJpNj20Ze87YdmaGOuEihqP25TDR
	 GK1/kEVrBzWydErX+93NjRCysTIaeSWLy44lEPK4qiw7ir8SG2WtTTnHMpD7CkR8/
	 b10YmNEy1EWru+G+8TlWT7/kJROo79+akzqo+uw8kmyGK3d4uVX/YrgTfTUu6Jdi9
	 7q06w5MLr9OCsyThu5yVwC8joj19PiLWQuoFpRjaf9i7tOmwH962vwaCOaHrplO2e
	 WHZWNYuMiwJIz+0twQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1wssSA0oaL-00krhU; Wed, 28
 Oct 2026 20:28:47 +0100
Message-ID: <c2c13ba6-6a43-4448-9a16-46a6269c5959@gmx.de>
Date: Wed, 28 Oct 2026 20:28:45 +0100
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
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20261027160914.3787276-1-bestswngs@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261027160914.3787276-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:71baTpKi1nLW5oAlBWLfMbvAItxU4jYLMUAJSKeyfP9BecRGVmC
 F6lXoZkTM8Bl2kM2UK4P+wATkFXPHBf2bP6Gdg/R/qannKDZO+cCbt7AtyfTM+tlFb3y5Gd
 KPvifR03yPD27yn5slcjJmu+qlH7F+AT2+6ugRUoEA7g67py7pThlyplr7LEVHzbgKEiiYv
 Q9LktBuf5wGOIixeZjXPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FYXkosWK1tQ=;JLhQgbuqEl881tmaumEFWC7P/HP
 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
 QhXxx1XIXjscRhm50DGdZ3s9

On 10/27/26 17:09, Weiming Shi wrote:
> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> overflow get_line_length()'s int multiplication and bypass the
> video-memory limit, allowing fbcon to write past the framebuffer. The
> offset additions can also wrap, while an excessive videomemorysize
> module parameter can be truncated when PAGE_ALIGN() is assigned to
> unsigned int.
>=20
> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
> keeping the stride, framebuffer-size, and generic fbdev drawing
> calculations within their destination types.
>=20
> KASAN reports:
>=20
>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    Write of size 8 at addr ffa0000001671000 by task poc/198
>    sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    bit_clear_margins
>      drivers/video/fbdev/core/bitblit.c:247
>    fbcon_clear_margins.constprop.0
>      drivers/video/fbdev/core/fbcon.c:1410
>    fbcon_switch
>      drivers/video/fbdev/core/fbcon.c:2261
>    redraw_screen
>      drivers/tty/vt/vt.c:994
>    fbcon_modechanged
>      drivers/video/fbdev/core/fbcon.c:2693
>    fbcon_update_vcs
>      drivers/video/fbdev/core/fbcon.c:2732
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Suggested-by: Helge Deller <deller@gmx.de>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v3:
> - Clamp visible and virtual resolutions and offsets instead of rejecting
>    oversized requests.
> - Clamp videomemorysize before PAGE_ALIGN() instead of rejecting it.
> - Add unsigned suffixes to the limit constants.
>=20
> Changes in v2:
> - Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mod=
e
>    support while bounding all generic fbdev drawing calculations.
> - Cap videomemorysize at 512 MiB.
> - Keep the existing arithmetic types now that all inputs are bounded.
>=20
>   drivers/video/fbdev/vfb.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
applied.

Thanks!
Helge
