Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680549AA48
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049145; cv=pass; b=Owf/OYHF8X29o70rP8afhDbhsPAyNChr8sj9ymrXcf30NohHKtruaFgVHK6uy+sZ5LTznn3KImSaceJa3k8zGYs2oXPmhXHZkDju0R71ZTCkI1DojNYgg5mszNl/MdXBsL7NjUIDNZ3bBMlPFAHP6j5WYE8XIks0j33gjXQPzMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049145; c=relaxed/simple;
	bh=aq0XRdo/v9me8Ndky6VpXPlxv2W9RbzrTPi3mgX3c5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyq7zzEwK4CceWhtO/hWlK1UdhmKW8d8rvO+XVjvx1Of9VbFLJD9tA81e2BR/HDpbCKeEZF1TH2PYwy8XGYCswjEUXD9h6Jk8E18M2ckulg01U287j+yofZbGSndZB1dJKx/hv49dfzNyVnj/wtDVPPgqHi3NuOEpF4gVcBVH+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWP89eE9; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWP89eE9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so1214279f8f.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049141; cv=none;
        d=google.com; s=arc-20260327;
        b=XXMU5zNIzP4sRVY4AtB/1dK0MI6veYARG52JU0LCxhwXh0JG4saTMRxTHNxotTIJLj
         GZqVZrVazPIEVQdOiW+ugey/Yi6fxKBxs2ZQVEZ7Ji0eiR3/cxPYXXJejawb8KDemw++
         TnlHA7R1P+GsSrJq3AsYn0pemoGUvJeR0HotQKxwWPq7UFVC2WIqAaJMxr22lCQbA//O
         P8imcs+MS21Be7qKh7VfOA0sBAaT+s6zo8dG1Z0kiHMimuppSqwKc13+R8ZkjhzcKwFP
         eYJ9IbYF1esD3GPQsOGo2m4+t8WCnGYoDlG8GonClYkAAiyCdooSFnbJYjHBzYLXb+FW
         2YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZDWH81kE2LXu7r7CHmw08vd9nzvrgNHOzXvRHMwN1I=;
        fh=Xc+mE0A7KljC7ml7q+DPfpMD1UIlg/x90Wmez9dBUDo=;
        b=PU1f3AiSU+ZOBZgpjTZWL4StV5uzorVziSbMfOYtCF3fwTbS8nY+XHFoCSIJQ2Fpps
         8RDxsz3YF0Giw1MShDkEBDkEO0JbcKs7HPZBy6Kae9wb2oV/x8UU1MeFfBvoeYTyn9mY
         idGyitm7cw93arl5DfpKbO9OR2AtCM2ADuiKH39CfVO+8ubvlT0FtbFVcmsQoLm8TvDx
         IGaaH0niuQG2XITEa9ykah1A3jNZLGJOxUmZHxM+Zoc1/FEdbERzeBiXcF1vaaH8Px1T
         uJHfI/47PU9FUVf71xOfHNksgIb3h5cDHyPZN47GKAb1kOODhZ+t8ufu7ZSjZcNxiZ9y
         jI3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789049141; x=1789653941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lZDWH81kE2LXu7r7CHmw08vd9nzvrgNHOzXvRHMwN1I=;
        b=SWP89eE98ZUIl+rLQ4hfEgy12ANCb5slKuNHUSGv5mfMWpXoPRfxv5uGyPy6d0zlgp
         REbUEQO8w2nrS5kRLEQl/7IkZ5xB+0xTSks8wZrvudOqJiy76FWMYAIQ9u5KKFyltUie
         dlZ1FI79DJO1LdWGvPBi6vxfqNwfPGJFhR95AzsaPZUDdrO0PNXlPv5GLMIRlWwEDUmD
         3DZ0wG/stMC4SMs/B2WNtd1KpYk18sRKgMDD73WYTIIJwKWfHXQKKfiiC6A6j5idtqSz
         9admpQYkkICVkZI1T1aRCTrroMEZmMgYw5nrTon63gsM/DdNCNSaet0u6VNSHGZyc3JQ
         5LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049141; x=1789653941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZDWH81kE2LXu7r7CHmw08vd9nzvrgNHOzXvRHMwN1I=;
        b=RXWGAxoN22SeWdpyprn2NHNrqc26k1x177TSglN2PjznvcYyLKQpHWEtCuoHRcDy5r
         5hQpT+Ev1FNbQdHj3kZgqkRcVeida/K6cAG8XFF8blKFRqWShXyh/PqW0PkC0YxMG+Vh
         KixjLcth74akWl41e8dZu+6lN2Yvkrz7cr8Ewm+AlR9BJqdB2IFvM7r5cLgtYjqQ4wyP
         Ej+Wip6tokIAhVqROhcaPt6I/tSChXNLZNfV9TOMUQ2t6Qd39PFSOGbOmS3nJQUd7p03
         qkEefLM954iDc9tfGuj2krDzwlmegu32LTzAeShqURispesek0oNTsTVRC277Z+EEHum
         qSuw==
X-Forwarded-Encrypted: i=1; AKwUvByxm8ycTKkqy3atwagPam2IU1oiE2JCNk4rPYFpRabTap5WGQF16+6q/KUDw6Ylz7P1cpoKNCA=@vger.kernel.org
X-Gm-Message-State: AFuF++nI0XoEIvlwI7iWprOnRNgrOhQrFt5cMIpdnmXmnji1TtoFv8mA
	OBg10J6kCz9Vli0pqGLmSgpxrVzRCUdHyJVYHKBqncCzX2geQZ1E9ZiQYwFuiwLatGxtKtAGnzo
	ZvLubYtEy5Nf1FWVEA1ima9BX7dMnd2mfRrzsCp8=
X-Gm-Gg: AYBFou20VD0BvduF922Nu7exvgKB6gsggI5kZ5TFFTR3Ed2/aAJxCpfQcwlsYGR2d0A
	QWjwrNDCg4Ht8K1r+ROFFNo6mZQJjr0W2NrWIOSBhIQrW+ScIVU3ms/yJ5lAnXHhKeH36M7kift
	q0QM6+qlEetWeq5sSp/tttftX3MzeGOyvNNJmQ92MBr2P95weZP2vPfNkj+CgNQN5l+w2BSSKUi
	22v1EARzDcDNdvERSvgKGFpOt7504dc7oeneyHZxsR8LhhL49zp5T5X6OaJH/WxmtyBriwQMXOo
	Yf30NWsomRkdjFa4kzbP6lB6IYivsPtKXdeETQPhNiA0by21x/leu0qi7Q==
X-Received: by 2002:a5d:59c1:0:b0:485:a306:1f40 with SMTP id
 ffacd0b85a97d-485c23d0ad2mr15722591f8f.13.1789049140789; Thu, 10 Sep 2026
 07:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910123129.16793-1-syedlabeeq@gmail.com> <2026091052-refueling-bulk-afc5@gregkh>
In-Reply-To: <2026091052-refueling-bulk-afc5@gregkh>
From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Date: Thu, 10 Sep 2026 19:05:28 +0500
X-Gm-Features: AcwNN1W5JgR5FjHBCAhO0pCqqhnFzP5rfAy32l0Onizkk4jqYsDMTWfetjjAQG0
Message-ID: <CAF4-o1fLyNVLfmRVYLAwsOMAmT_UU47XDrBD4iA0pS-=5mW57w@mail.gmail.com>
Subject: Re: [PATCH RESEND] usb: storage: sierra_ms: reject short SWoC info transfers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	stern@rowland.harvard.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch on both. i hv sent v2 with the blank line and the Assisted-by ta=
g.

Thanks,
Syed Labeeq

On Thu, Sep 10, 2026 at 6:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Sep 10, 2026 at 05:31:28PM +0500, syedlabeeq wrote:
> > From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
> >
> > sierra_get_swoc_info() requests sizeof(struct swoc_info) (60) bytes
> > from the device via usb_control_msg(), but its callers only treat a
> > negative return value as failure. A device that answers the
> > vendor-specific GetSwocInfo request with a short IN transfer is
> > therefore accepted, leaving the tail of the freshly allocated
> > (kmalloc(), non-zeroing) swoc_info buffer uninitialized.
> >
> > truinst_show() subsequently prints swocInfo->rev, swocInfo->LinuxSKU
> > and swocInfo->LinuxVer from that buffer into the world-readable
> > (0444) "truinst" sysfs attribute. An emulated/malicious USB device
> > (VID 0x1199, PID 0x0fff) can exploit this to disclose up to 5 bytes
> > of stale kernel heap memory (kmalloc-64) to unprivileged userspace,
> > once per sysfs read, indefinitely. On kernels built without
> > init_on_alloc this leaks recently freed heap contents.
> >
> > Only accept the transfer when the full structure was received.
> > sierra_ms_init() already retries failed queries, so well-behaved
> > devices are unaffected.
> >
> > Fixes: 32fe5e393455 ("USB Storage Sierra: TRU-Install feature update")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
> > ---
> > Resend: the first posting was whitespace-mangled by a webmail client;
> > no code changes.
> >  drivers/usb/storage/sierra_ms.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sier=
ra_ms.c
> > index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..8755fda42eed2afd3235283=
e990a35aac14cb829 100644
> > --- a/drivers/usb/storage/sierra_ms.c
> > +++ b/drivers/usb/storage/sierra_ms.c
> > @@ -76,6 +76,12 @@
> >                       (void *) swocInfo,              /* void *data    =
    */
> >                       sizeof(struct swoc_info),       /* __u16 size    =
    */
> >                       USB_CTRL_SET_TIMEOUT);          /* int timeout   =
    */
> > +     /*
> > +      * A short IN transfer leaves the tail of swocInfo uninitialized;
> > +      * only a full transfer is valid.
> > +      */
> > +     if (result !=3D sizeof(struct swoc_info))
> > +             return -EIO;
>
> Don't you need a blank line before this comment?
>
> And did you forget an Assisted-by: tag?
>
> thanks,
>
> greg k-h
