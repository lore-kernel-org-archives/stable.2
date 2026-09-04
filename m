Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD44F475B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535685; cv=pass; b=D/43giM52pT67J+PtLUZbp2I9C2RE7gNviutZcaphI+EwYdaBbfKsSvWEOkyQTOjl52VvJiB6kzE/MO1mp+E3FBgHOhTm+Ec4EryQOZ8TdvzeHFPZYIc7mNuT15omUZufhtFzs5Hx8m6cm5EWHXiDlsBTebtYIxFIvwoO2pyG70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535685; c=relaxed/simple;
	bh=h1ey2JVwd5mm5rG3ewHFS9R1b94cuUw/eArpKxkqrac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAdh3WhJDPUhEMlYG8YB4dx0eMAQ9n9rCWPn/Z/GVVsmgp4GVT3Uzk8CNp7NqF1P2HKFFZFn9vKWxz1LGDSKK3Lr7JiUCXGTAu1TAJPpPSOq0hDz8+7Oq6KuYZ4I0SriXhOTMUVaDue9J8bK9hKvAJSdg+WViigvSEU3dNkUnDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZLoKssk; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZLoKssk"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48586861639so809368f8f.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 08:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788535681; cv=none;
        d=google.com; s=arc-20260327;
        b=ZytDyrIdny5qZnSW8MAJUR8gdPIbJGuKFqNECJNFNJ+1zXeBPxCEV88z+Cf0w8+uDd
         z8mNzFO2TZaXTK33kWVDcNJmbb43yKMN4wTPX3pbZ8xcktc0dUxbsyAoGJEEOUwdoF95
         3YTN6OntOTBdzo/KkFotRFmjkJ/jIN5YCUCRBJr9tDBexK91kPdZqwL15SdAYTE79raA
         bnRe9JBKL5I+ROxaKlfvET/MprcmYhiWVCbo9ezc0ub165uF5A1khx+p0pf/4PlKnHe9
         DWVzZKYdIhDQ+RhqhdahgFJGkqCiTHPoqlrhcxxz/PFzqXZ/GUBWAzPsKyBNS8EZnJyE
         fSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T29lJmwD9dBzAR+wek9mxqJ9K3zRLSsXJc1YzE+hbpM=;
        fh=zk95s4G2I5Wx2YuxXpohM0NKF6ICIHPyqc8fotdt6VQ=;
        b=iI5eINGtpCd2ObczfcOPGyKb/4HQEdlEbhjH0/d2UHXMzb7gR2kz/0etkvdVcH5/r1
         G7PYHuWNEo/fNEYQf6LdTV8q960OxCayd1U/D6Sxsj4MIj0xLv7MD+5MCL7MA9Mu+IU0
         4qhNxifjgd8BDxAEvDl2sJK3ALNg2obheb1eaBvA4XfWJDwdvYN1I3YBgbsgPBOElh2l
         EyS57i+V8p3beSFvuO7HY3DYAdb5hF3ipnUh5CR7ynmr9par1LGRmPKuNvF0ZBpItBs4
         1IMvehbZ9fLIUOZpmRiQOPhCxnuibvvm3qpElTDPM7yk5HxrthLWzWcvYQCZ/E5qPMd3
         8ppg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535681; x=1789140481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T29lJmwD9dBzAR+wek9mxqJ9K3zRLSsXJc1YzE+hbpM=;
        b=XZLoKsskvRdYE4+g+BLmwJmCqY0qZoo5GoHHw4xuE1gZ3+/5INkrGsgGE6uBFGe3yr
         XEeRRkqehTq+GBiqCE+nKq95OcTDP6j9/2eJE7jM+w8Btv1bFtCAQ1UIVhA5+5OFa71C
         jxSRAEmrzM2vXimr2Hfs7QED4L0rdqrai9NnVhMI3SOg8QVayrPBDYu3KR9XN2RTJ//T
         KP1xzvtGHepzyTaKWMzskf6dF1iv5/WeaqH+6D4GSK5GX677qbP3HNiw5NLZf0YukSYi
         t7FjCr2nc0qcdrFh5Akg+JJfCgnGL3B7feqQq0e4NhfBxLu/AvK0S9Nz4A3OXrHweSjT
         WE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535681; x=1789140481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T29lJmwD9dBzAR+wek9mxqJ9K3zRLSsXJc1YzE+hbpM=;
        b=az5Vk/CP/goFCaNkgEGOdDRrwC76OZLcp9+0NuNl8OKNYtQtLSl4+6BCPEeTLCCtxn
         2XIHV35Q4m7cKKL+wDlzAOgn8yDygNl9TsTDnpGBGPbnFEvTNoto4cCsy4CIdV4f2NE+
         TLF6fdFSrPQfOZwN7ZT+u7p+tFTZcIk1MM51qQmYUZswbkKEL6c8DV5f8mxjxKHnA/ro
         2nnqS8MyihgFXelI13Rahd76fahb+6oRLwCbwS6qdbF9S9qwm61u5GcoYv822cVYj1BW
         ogk39czRmnTxnNryje8FgI9Th1X/0ns9rwGy5J+wD6Wo7xFIez5K81tOY+7B9LBxE0Ho
         nZvw==
X-Forwarded-Encrypted: i=1; AKwUvBwQqXB/k+bQJ0UY4X0wrFKX1on+mlBWyT5gMKPKNSpiXDU8QtF8aoMHepu3QG/A3uUs3PSiSQM=@vger.kernel.org
X-Gm-Message-State: AFuF++n1q1uWXs4tP6NStObTdPwt0eljjrPswVroskmqOimYMTsf3TIT
	ETuMyYsWUwwmEsS15U9J/A/PSTUk/1JzHhEiepomZoXBdXJtSGswcda8cyM8QzbM0yynvEvR/NS
	9qdWeaerhdv2235giUxMBTC1GulcdcPY=
X-Gm-Gg: AYBFou054r5bzwubg/WAIlu1KRmJNn05xi1DhXVjRmq0TulHQUkvd72lZEhmYKgSBYd
	YrAcL9mLdz7xW7A4VoSb6VI/zjMBJNkoFTx7VHVTIFwkRrABT2VpP950AV/wHkzXUxNKpdhew5v
	OhAGTuDt/xXlp4ktTeFjQKYEMyOLMahRjaRwJBd+8qykXrEyHq9ZNj9nGkvEaBHmfo1AZolAdaj
	sZedyWBImgkS1gKXHF1lKPrOGpBXImw6mwKi60I/j599MvX0hGI8BwYtTEKMh5esPrpKag7XMPL
	G2Y1IefgsgzsZ0CsCw5ve69w6w7dI9vX9sjpCXExP7TGE+E=
X-Received: by 2002:a05:6000:460f:b0:485:8226:c69e with SMTP id
 ffacd0b85a97d-4858226c95cmr13165093f8f.29.1788535680814; Fri, 04 Sep 2026
 08:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF4-o1c6XLbJr5umK+FRmMetcRkxH5JnRjMUpWw7OpnkUWbvVQ@mail.gmail.com>
 <2026090452-appetizer-pacifist-57e5@gregkh>
In-Reply-To: <2026090452-appetizer-pacifist-57e5@gregkh>
From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Date: Fri, 4 Sep 2026 20:27:46 +0500
X-Gm-Features: AcwNN1Vsd2BdBTotixMKVes7objjhc-bItxBHrowmHApF-_5BWT3GVZM3mFc-qY
Message-ID: <CAF4-o1fTYbxEb95NVsvcJ7=jdJB+vXpzspqcgwhNn=+FBsOsNg@mail.gmail.com>
Subject: Re: [PATCH] usb: storage: sierra_ms: reject short SWoC info transfers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	stern@rowland.harvard.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the quick look, and apologies for the corrupted patch -- I sent
sent it via a web mail client, which messed up with the whitespaces. I will
resend it properly with git send-email, with the patch also attached.

On the short-transfer concern:

The SWoC query explicitly asks the device for exactly
sizeof(struct swoc_info) (wLength =3D 60). This vendor command has a
fixed-size response, and the driver already implicitly assumes a full
answer today: containsFullLinuxPackage() and truinst_show()
unconditionally read fields at fixed offsets (bytes 9-12) that a short
transfer would never have written. So with a short answer the current code
already makes its mode-switch decision on uninitialized garbage. The
patch only makes that failure explicit instead of silent.

Two further points:

* sierra_ms_init() retries the query up to 3 times on failure, so a
  transient short transfer during probe is tolerated, not fatal.

* There is core precedent: usb_control_msg_recv() in usb/core/message.c
  rejects short transfers with -EREMOTEIO, i.e. the USB core itself
  treats a short control-IN as an error.

To answer the testing question directly and honestly: no, I do not have
the physical hardware, so this was not tested against a real Sierra
TRU-Install device. It was tested with a fully controllable emulated
device (raw_gadget on dummy_hcd, VID 0x1199 PID 0x0fff) against a
self-built 6.12.108 kernel:

* full 60-byte response: enumeration and truinst reads behave exactly as
  before (attribute created, values printed);
* short response: the query now fails with -EIO instead of exposing
  uninitialized heap through the world-readable truinst attribute.

If you would rather avoid any risk on some devices you mentioned, I
can respin this the other way: allocate the swoc_info buffer with
kzalloc() in truinst_show()/sierra_ms_init() instead of rejecting short
transfers. That closes the uninitialized-data exposure without changing
behavior for short answers (the unwritten tail becomes deterministic
zeros). Happy to send whichever variant you prefer.

thanks,
syed labeeq

On Fri, Sep 4, 2026 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Sep 04, 2026 at 07:52:59PM +0500, Syed Labeeq Sajid Bukhari wrote=
:
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
> > Signed-off-by: Syed Labeeq <syedlabeeq@gmail.com>
>
> Did you forget an Assisted-by: tag?
>
>
> > ---
> >  drivers/usb/storage/sierra_ms.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sier=
ra_ms.c
> > index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..8755fda42eed2afd3235283=
e990a35aac14cb829
> > 100644
> > --- a/drivers/usb/storage/sierra_ms.c
> > +++ b/drivers/usb/storage/sierra_ms.c
> > @@ -76,6 +76,12 @@
> >   (void *) swocInfo, /* void *data        */
> >   sizeof(struct swoc_info), /* __u16 size     */
> >   USB_CTRL_SET_TIMEOUT); /* int timeout     */
> > + /*
> > + * A short IN transfer leaves the tail of swocInfo uninitialized;
> > + * only a full transfer is valid.
> > + */
> > + if (result !=3D sizeof(struct swoc_info))
> > + return -EIO;
>
> This is corrupted and can not be applied :(
>
> Also, are you sure the device will not send "short" data?  We've had
> bugs in the past where we have added this type of check and it turned
> out that it broke valid devices, so be careful.
>
> Was this tested with a real device?
>
> thanks,
>
> greg k-h
