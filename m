Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC427175A88
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786190309; cv=pass; b=pyo9OqZwaMQaMzbMz4Q6TI85i/4XKf3RDmBmvWMr+1gPCw/S6ffFYmsNSQawzJ9jg/5ct9rGsl/lMoDt2Ikxs2YAww8no51KC/uK24xkIrb0O/u94IFLsggANrBA02W9yUg8ckWJ+Cz6lhk9qbshgzFYKdPlz++keZ3nKC9Svpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786190309; c=relaxed/simple;
	bh=0I05yqIJVobCKPpNehwIbOT5UR4ceGFpLErIALuaidg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDmpGYG4PyMXp6RkBTMKaeJyTaUyl7pJUC1u+npzgX2l8IR3kjOio08nsZLnDcmV8kXYbzarUU4qgyBcQau4VgUyGwhcu9drvhfDov4WHanEY7IuwMOPbyO2EjNU/g0VH5UKOn0e+uITBF5fi8n8Eo3xRktaiAHlmF60icl3nBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=vhQCUOqg; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="vhQCUOqg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1fbe461f59so39691966b.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 04:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786190306; cv=none;
        d=google.com; s=arc-20260327;
        b=bCREa8h81OFZ54xq5c3+Ai03iYDi60sMYe43pzEmKCS7HnCLrJ/I5pNzennzWmGSl+
         zvulbWRRlt6GkJxpMQjJtjhXkQkg4ofV+eG377oIIJ2OoAINBkRYjWZQ7B+LWQuNITsz
         gAm3te9C29klSBTsWYJZvWDm19y+P49IHAUtwaQ3QDyrMAzTS+KDGD5qXTE22HjytMk9
         8/59CqjXrmk6d0r0bEv1w0aVPHW1mIqut+y0h4ijSWXaVU+lPGjQaqkTn/sKRijasfIU
         1O3ds52vM86bvNASl7U3+1Lm7V8eUPPy72Og51vdm4OoabevL/BHRMyPNcBUIwtFXIB9
         dqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFLOC7eT/c7nh4VUjcAPuBvrszC9BumgNA7gF5Zy1o4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=f0XvFNlJDh0tDywPF9xwLexDY0iKsoV5R8BierNxaQR9B4oW4CtTDpj0cOiiIuMq6u
         Va3pAeOaHWHV47J8weEC/K58kUAVAEMIQT6DsW1vqdbM0oTWhm7Ls4+bk6+WMollwi0Z
         9pNAwB9x+FAJweAiqBlBVKNIgL+snsXD9yVOevO5GXDApiy2ZIsb6/CAAQrEe85DIiv0
         y1wRKbU1rX1/9VOwDvt43lt5Wr75ZjPvsJUpBD/M/tmFCYwU0Ij7fiXL7jQalvIaI71s
         TNt04RDHLilBuUpqKjyXC2H9VydKNubu8jAgz+Uj55UYFklGznOQnn+UBnpjl205wqRD
         BJYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1786190306; x=1786795106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wFLOC7eT/c7nh4VUjcAPuBvrszC9BumgNA7gF5Zy1o4=;
        b=vhQCUOqgJ79GnCHnWZFfOCNJUtSKc/vmI2mWuxlLbmnDDq8d+aUsj4AlVaT/A0bpp1
         aOE1WiEcZcXtpeXn6nxSCP1dKtnH0NcfKy96/IyeBTUTqwg+wKLMFVKgLPtOkziC9fqy
         Mbo/VXSiPwt/dQzZziiveXN1ljO5U515+c9Mb/hubqDzPVkt/LDHwOjCAux9lzA0NXPr
         QFHmvePSX/riMxO44GYUxSs6ct1Vq3yJ883nQgWXyP7swm8MeZosNcHeF3dtp0TQaiJR
         fbVr9KKse2ByU4HofhkAqeHXyz+NpeMq2NJtPV5gHDvQhgDlRuNkJvgczL1enCxLmEJx
         kCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786190306; x=1786795106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFLOC7eT/c7nh4VUjcAPuBvrszC9BumgNA7gF5Zy1o4=;
        b=NPB8hukUduKDCJ47CvJ/nv2KssjndYoP4YQkOvhNCUg/2HGDxn4yaEWlO8uWhm65Pe
         AwhcfL5aJxe2XUs4De3IjtRB+hJ8R0VSgbXRjRnghQvU/4cEsEFho/+A4eqetLsig1em
         QgkkMAMzgEVZDnHPMK8FhH/lImfM5N1ZFp2DuxwWDeN5XJXyl06bMb6czcxiwIzSsZm+
         0hpUmQzMXMcFs3ibHGK3Ee2346oEoOqH3nwPDFU3cIrofCuiKs9+IdOgstfz6jrlVJPx
         IY4mWedclTynWr17ge7PA2rL8dDf1fQ6JyF+mKwPfNbjuuIKHF+DYNcecm/9JeaibQ9d
         RtIQ==
X-Gm-Message-State: AOJu0Yy6oAW2MecvEmapO9TpjgoFHkusRPK6I+SQFdy1Z8Cm49EMvXIP
	JfMGRNQPDmqth9RQczMaazHSGOrZDviAdf5oxRFlxfbqIKzMcGqMD1/Gmj4+eM1g32N5hIthw7G
	695VKDZtC0PcIEECT9b9xr74MIgS8MVLCVLeLI3XuWw==
X-Gm-Gg: AR+sD12mxpZzN3/03HBKvSdh3TpaAvJxFdHiJCuj0A0KW18P0FvWAuWDarZuQpFsQDj
	SqpRqIWgtTbHlrnqmlXfOP2mypjOJBq2qSdpKYiwksb77TMhIL4mfBBrrKCxov/G3uDrGqPyr9i
	QdehNGxi6CCZ7VpQL+p4Xx53AWTSIqzYPeuVwHTB4hIyF8gmRtZelJtf57RN1My2rF9r0pSASdB
	EoNh3lm3syQ2dpTMybACNyzOAQj+PZqRKvyvXm8cHY6HBCkClFvSzx5ZXbq7nrcTBUq4AeT0jgj
	/M5tsW1eIchY5VfoIbEQvDIDvBToWJvzDUQR4Tm30D5ypMPf8bl96AnGwVbVctaPmQplzlmrNdd
	8OtoSnTwt5Oh0
X-Received: by 2002:a17:907:9623:b0:c12:e178:9e68 with SMTP id
 a640c23a62f3a-c2073364351mr755553266b.19.1786190305489; Sat, 08 Aug 2026
 04:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807143428.008222056@linuxfoundation.org>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 8 Aug 2026 20:58:08 +0900
X-Gm-Features: AUfX_mzpwqkgBW1n_k6fWbBqYsVTji7LrFJ3wK3z4zxHOxmeZUH-tab1NrDfySE
Message-ID: <CAKL4bV597kbF3OgUxkYESiao8BksS_RYH_HhCPq5tRy0_1AeRQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Aug 8, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.1.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.8-rc1rv-g91bb55d1d234
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260728, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Sat Aug  8 20:30:10 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
