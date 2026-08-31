Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6F342523
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176149; cv=pass; b=dYItLUXTmLTyE765T6+UcjOCvIc2LVo9VTXzo5W1plzBZdCDQ+sq5YlVEd30CGBpbgjFMtN+LQmVG6RcKwuQtje2kjGWDxHkIx/4J19gQ61O3zJZLJ7xoKrWS38RgdTHtJGHpVTk2NpUn8iSmWWhHIGCCl5p30xEiGrSOjXFYl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176149; c=relaxed/simple;
	bh=iVsFzxcjtXpLLAPWir7xOZsYFnrqAkLPip0NYRBrV0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0++Eszal3Gp8Fl0vOwtkw1BhmThqp9mKf1cc9WLMA4PLLDXLnz/MlMHqkbB58Gjel3V5G9dn33YQWefr2fAqK5ouByQnqifJHyYwy2+FlmKmoDy46m3Fu2Vcbysq7tabUP/89TfnXXc0dXI6oFH4558LhpOpG9v86DofHRsGAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F5P5uRTu; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5P5uRTu"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848643382fcso3557184b3a.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788176147; cv=none;
        d=google.com; s=arc-20260327;
        b=k79YK4uZbjSAO6W0HgUXJ7WJrofX3x2RvGJVDdl8679SdYzlc6MWIEv8qWTnFcIsNW
         VkeKfKhCljFPMC7whiAEHI3NXlibYVCYvIjBvaUkfV0ydB/oTBgmAK2YI0y0VOv/YCEz
         +Yo2znOjII/TrX4QA28NIth0bD3f06O7LtyN0U/uhYwtSJ/4WoP3EcyqW07bce95VRyK
         /cBHi6FuHeHDgUQkeXEznN0Bb9qtcUzFc5xFw+oGoVkiLIyg65uSOVGDBov8UQb0KkUC
         vN6kmsnM9jxv2tiP39VRcIjPpDrkdO6vsZg4/GusqXx7V+awGqV83iRFiXoYd53Z46Wf
         cJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1+kYYpmqjR7YioulSNP/VCyRhVs3EIdV4wSWvdX0GY=;
        fh=1dihsYcApKK3Yrs5UfTsT1AO2hECPJZhozUjeGf6tI4=;
        b=rCaX9O9AbuUSQIym4RoJqdMu2T9uSecazgc1E/jrEE6zUEbT+lYmHehoYqJrrDOBlc
         k6ie8DFKzw3wZUSCdo8dMddVtgBOF3Mjg6L+Vm5eBUIjCl8gzLi7HYPw7Nme32ineoKu
         9wJgDLR8vFN6dujlFP1LWiC1lyqveMGF1YIDZPnPaKqkCzCqi1tmwbtt40k8f7o4MSZV
         KHaB6XuMuV8a9GzuRphPW0FSbE+0SBaVsNITc0V1clbwY1xj/sahxWSVm8u1Kfuy+GBB
         +zVm+qyCCDkyKM/7NIujCdL/fXASHwS6R5anOEexJKHiJz1txt/WqukRnr7VHsr+H4kK
         9uyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788176147; x=1788780947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1+kYYpmqjR7YioulSNP/VCyRhVs3EIdV4wSWvdX0GY=;
        b=F5P5uRTuy6Gr8DiIlS+YqcTbkx0JynRSTtPY/5B9qaEDclVB4axwWdZkjkR5INgKkZ
         7XpD4zJi98JBjHl2Z0Fnb+23h6VLc09Vs30W/hhwmorYvAc9evyznQOlTlywqv9sDKO5
         dQ4KIozJWrZnxq+sOiZh8Ohzl+VVMDqyQNM2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788176147; x=1788780947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1+kYYpmqjR7YioulSNP/VCyRhVs3EIdV4wSWvdX0GY=;
        b=ddfj2lStECfkvL/4UqFdHmyaMk8iI5GxayCG4/x4oswIVrqcYoJxLp/UpYe5enywsL
         qCV5bp/WsiDqcUfvjdJVr3xsd0bhzS5Csm22FfzAxYeQjvQfKyZnXIeziLMoRBAPUmHr
         nqKSDNiYSUPmD3OtCZ7fvWP+a4MPNumZq6v3CJJPyWnHTg1huqRbJxTRbAZjHDV3qWa9
         1C5rn3sqoPR+QZ6YZiSdsw6mUN2CvfJxgAvAjQ625aVltobAgGwvMIlQHgrOuQkNaqFe
         XfXFsqDADNaGKwp1IoAzRu7jmpElphh7VjRdJlcDRgsrlpaL4IxI5uqpxp4dDbiXmewo
         oqAg==
X-Forwarded-Encrypted: i=1; AHgh+RrPG3Wklldua+sa8B03bULdnQ1W96SjJcv9Bg/e5BdcVdnz4B6OokDvb48sveQkBtTglXCNRIs=@vger.kernel.org
X-Gm-Message-State: AFuF++n9rDREOgEexaMxHqosMQ54MI0/h7NzK/THusg3IDcfkbOEBFEQ
	BYaof5jb2R9eU8kG95dESppy7MgFGnnBMRgsJeE8/ftegexQbIMw9TEL+W93mAiB/Uic3yXlyC6
	ip0+/3EchHJ+H29AY2HkWjzL2HeBMdzvn6ShcFUE9
X-Gm-Gg: AR+sD11t2nzjQm6NHq89Ab9ri4wj/OXvf8g49bBnEhO67vkH/f5NrRAzGFPmU1mQ68+
	TV3jF6muuJbsV2XFERbRr/Po12W9bnzRdvyag1vvoitzyRQ1N3IxLVEvrsTPpA4Ss8VzIEyE5dB
	ojBxCxy0S0d3t+iR85CS0lp3pkxhH9nV2SBPWnH229oJNa3z+RzLZ8C6XlyjJEdIt1YM9VmfVVR
	qabYTuOZSgPpz/tMue5Nr6dJczL7yOdEYmGaUPnkkWz9hJ195uug8phIfKAqtcj8wjdi8mPso3f
	Ehlxm8zjJF79UcZg1taqYV7cZXrEcUAF/FiS+LtCed3rW/POz9snNzkf9SGUXD/Bks03yEe+lts
	=
X-Received: by 2002:a05:6a00:9090:b0:853:50f2:9c03 with SMTP id
 d2e1a72fcca58-85b5a546d3amr655244b3a.11.1788176146691; Mon, 31 Aug 2026
 04:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825234545.2076049-1-jthies@google.com> <apVZVCzUEXp1Ahv2@black.igk.intel.com>
In-Reply-To: <apVZVCzUEXp1Ahv2@black.igk.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Mon, 31 Aug 2026 13:35:35 +0200
X-Gm-Features: AcwNN1UG8a3e-ri9A1fYCTOuTDVKemg5UPzTBUYjlI4nabQw-8x155-qLxr9oOg
Message-ID: <CAMMMRMdiAF1Kx9CAwZrWCiLGjrzVnoQ_Rm-m-UXSAF+fhS+y2A@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: ucsi: displayport: Fix OOB altmode array index
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bleung@chromium.org, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:37=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Aug 25, 2026 at 11:45:45PM +0000, Jameson Thies wrote:
> > The UCSI displayport driver indexes the connector's port altmode array
> > with the GET_CURRENT_CAM response after checking it is not 0xff. The
> > port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
> > returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
> > not equal to 0xff, the kernel may crash with an array index OOB error.
> >
> > Update the UCSI displayport driver to verify the current cam is less
> > than UCSI_MAX_ALTMODES before accessing the port altmode array.
> >
> > Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mod=
e")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jameson Thies <jthies@google.com>
> > ---
> >  drivers/usb/typec/ucsi/displayport.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/u=
csi/displayport.c
> > index 7067f2561b84..8d2032d0762c 100644
> > --- a/drivers/usb/typec/ucsi/displayport.c
> > +++ b/drivers/usb/typec/ucsi/displayport.c
> > @@ -74,7 +74,7 @@ static int ucsi_displayport_enter(struct typec_altmod=
e *alt, u32 *vdo)
> >               cur =3D 0xff;
>
> Can you remove the above line while at it?
>
> >       }
> >
> > -     if (cur !=3D 0xff) {
> > +     if (cur < UCSI_MAX_ALTMODES) {
>
> Shouldn't that be the other way around?
>

Looks fine, but shouldn't we return an error if an invalid value is
received, similar to the Thunderbolt implementation?

        if (cur !=3D 0xff) {
                if (cur >=3D UCSI_MAX_ALTMODES ||
dp->con->port_altmode[cur] !=3D alt)
                        ret =3D -EBUSY;
                else
                        ret =3D 0;
                goto err_unlock;

Thanks,
Andrei
