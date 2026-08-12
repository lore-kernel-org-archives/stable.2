Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABD37DEBA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505422; cv=pass; b=ibg53ye80f3G+lOCoV36/mlO+iIdrkpMa+mqiulLfr84Zj4D4anEuNazRV2v2vRuXPBJEF585tvHUh5mW7zoWPtSFqrpaTDKLW01oOqDFFZbVpO95SveH5YsTGSMiC3k/pCJuC+rBy7qDV8mY6H6JMlnZI2h4cIKZmt3XmUuGEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505422; c=relaxed/simple;
	bh=VHMPa1wT0GFriQ4MJC6w3IZRrh/sWmiZKFaqKeQcaaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOgWWuH6nGRYmSpN7u1C6nj3QQ0N/9wj8MD6+8mknut6eYRVhoLMwxE9ti///cCB6gtGvE2io3egrsDQPVHIJCKbRZAxkocjxa6Rt8i/ilt5iXhazz4vP8BJb7KMHSyXH66V8Og0VQ1F4S2A0ONZE2iDjsxmajXvf/Tap6jWRmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssm4e70K; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssm4e70K"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6689f36ae56so628339d50.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 20:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786505419; cv=none;
        d=google.com; s=arc-20260327;
        b=k/GsNsrCek1+QStDqMrpg4P+pJCR2NY7yOly2bJFquV4b/0XikOkMYSTVW59O3sABY
         Z6qP9Tq3iomIdsRrgW6tvl+SpRHhnwJQ+/GCPJqRLDA+uA0ZNTjaM4OPVP2Ym5oE+tsE
         YjDj77Yy8deVFV6BtKv26qQv9K+nA+RbWGS8L2JsWKXwaQkufigT1i3NaN18toSK9pPs
         GVjVZfnjb5/Or+biUBTpKwNu3x2y2x2kg0G9pIm9c1knvA01bCupAHjlbsalIkuchroE
         PEj651eYvGoRg1/hTy3db51nJexSJ0wd43EOWUXGrelxEJp6viYSNnglgJFIcAId2NAJ
         YNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4T+oO2E2HkJP7ru0wvu2yagPDSTYhm8rgd0jrMyifnQ=;
        fh=5IFGIAJ7CGYylht6uzl5Znok+dTWveRI0iwf/SEOYzg=;
        b=DVafHLaVEfglWGUr1sDP9YXUNun8AS6N8wGaFwKwBAQ/N+amm/gdhgtSUyFJryNfRL
         2N2iXDy5RcdPN6T9dyzc8w5kBQ3nxjtCpqI9Z3nabM+zVoxX3WpLlGhdpVQtXtIwIRve
         c9Mi2YS+9U/5ODU0RAwEHBTHdUhfHzDCKEQcJ+QtPcuhnr0wwYSbEkOSb32B2sWR4E+i
         8j308hehX67mnWV8IBQQY8fHJALJj2Ew/TN8L8Eq9P5bxCis4qa1u225DyjxGWZGQYXC
         GcTm3cLsdlPGLRpVzyOQ7O/H1Ei4trB/u9piJyVguq/BUkOiuaf8cLsF/NQcC6dyl5eD
         el/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786505419; x=1787110219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4T+oO2E2HkJP7ru0wvu2yagPDSTYhm8rgd0jrMyifnQ=;
        b=Ssm4e70KSkDX3QjQgQ/dT+BxAbPjtiHdFGgVeO8xdYJfTFCvIApXEWQLcxZWUhtG7/
         axh8HbnLZhsXLOlqDjebtn0/1hX/zy6oC2++cAvpRiXNA5tyfjHnaK6hplGt+91R4QZ0
         Ct2jBuC4fz/BmsOpmTyq2B0w1MGV+0GW1HZUCG3bd7OMN6Rihc18/Z9EPP1Dw4JrnLuL
         9Uiqy6ilH8EcQQZ1C4oteFTs0fTC8R433rHBkwl0B6dqCePIZKCN71CIw6iVhp4W+apW
         4EmwHF1CWktI4HtkPP5fSxkykswoEaFSHq8Kiik/nNWXfbAU2ooBnxs0hOShQLmndi0K
         vFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786505419; x=1787110219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4T+oO2E2HkJP7ru0wvu2yagPDSTYhm8rgd0jrMyifnQ=;
        b=f9yn41wYVQRJlICPb7DHpZNCCNecTCvVQkuO4YfEynnN77EjaY2ifIPq7ozQQeuXsS
         0G6exWWKl+b6wfXTrNx5eVvRHRGdlD1nKNuBS/W/5enJYELvJ0qlTsPoZ7Y7L3wB2A5H
         8872mg/KmhS+KaiqYTfW6DzOR3CBBaPtXe8MIuqxOe2ap55WIp9hpnBabpfL9CH6ymmL
         OjVVFEk2iTq6skpaxMATbCuCGEkDBD4lcWkZPRPd5J3oyWAxHLGJQ9t82dJzituslD73
         uQ3hzcJ4wsnVvDoWawSp/StEQElBueJiqcpOvEisU07Iu00Et5F81WJhGXbH2CJGxCQY
         AUDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3dSkNPfcEwGN7lO3pibNmSzWlqLGb3x9guAPxm2PK0BMVrBJlTiaa0deLY2A0jjPakcB/PrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYC8cjUhKQ561HChXTz7wCuN6rbkDJy8GVolW//eSWKYmVUo8
	EvJTKah/aZp3vr7FWQMp+R7+mB/iKB3TauWMbiHEeXOLiCKdT95q/mxE2giRX8eKZYvqgN7sup5
	VEcHIjpRTVyPVFOQ2Nm5t19EdraAkWso=
X-Gm-Gg: AR+sD112N8kResa9gHDJE1Erh6JiEsXyNA3//9QOAhXkmFvfXvTivHUNCMAuSpR3ohy
	hCsOWpHbJqE+Y5NBR+kWhj+ffXp+sFd7R9OzVL/VlIKmcugYfgCIJWvrWvspjdLEjKVI7Xpr18E
	lZzJVWvGitvJLTZTdWJNfZQrmNL3NGFEH5h/6JOZuZ7YIbR9IzU/rbEVRqeDAJ95u27gWFcd0Z2
	yXFRVJzIE1c1O7QmH39cKT6mjvAc3yMv3Z7ZTIPZdJoZQqoSqe62T45OYcsW5oUHiZuFbdunzTd
	WxoBQHRN1rgLOtOFmEysS4V5sN4DevF1LEuhcOenBtBQcISR1X+W7N3jeRWpbSZGxiTnPm1ijnh
	RXs8pZpr5fqgyb2nVH0b24Pr+IIIfsKrS+TBFSbUDjJhez64Wyx7+dclTTqyhIuJPq4WXg9AmG2
	ga6KoeHnbMaft5
X-Received: by 2002:a53:c048:0:20b0:667:911c:54ea with SMTP id
 956f58d0204a3-66b343a018fmr834165d50.46.1786505419260; Tue, 11 Aug 2026
 20:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Z0x2KotE5hgrFn-vzR+XNF_H_vEbZcE_nXmpVz5F2q1vxE6w@mail.gmail.com>
 <2e6a5558-3bc1-4b5e-a9e1-cc03f0e5663e@linuxfoundation.org>
In-Reply-To: <2e6a5558-3bc1-4b5e-a9e1-cc03f0e5663e@linuxfoundation.org>
From: Jason Colapietro <jasoncola1@gmail.com>
Date: Tue, 11 Aug 2026 23:30:07 -0400
X-Gm-Features: AUfX_mxcx9SyGYQhVldnd0YRN7rD50rO5YCaAs1VL5vR5FiDLmM65OCoPgglpMM
Message-ID: <CA+Z0x2+YkSzREfUiU1b9fP_V-k4FK2nEa+-e0eUwRO_MrDLPZg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] usbip: make remote list honor parsable output
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Hongren Zheng <i@zenithal.me>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Colapietro <jasoncola1@gmail.com>
11:26=E2=80=AFPM (1 minute ago)
to Shuah, Valentina, skhan, Hongren, Greg, linux-usb, linux-kernel, stable

The -p option only affects local devices and gadgets. Remote lists still
print their human-readable headings and details, so scripts cannot parse
them using the documented option.

Pass the parsable flag through the remote listing path. Emit the same busid
and usbid record used for local devices while continuing to consume every
interface record from the server.

Fixes: e9837bbb3e69 ("staging: usbip: userspace tools v1.0.0")
Closes: https://www.google.com/url?q=3Dhttps://bugzilla.kernel.org/show_bug=
.cgi?id%3D219502&source=3Dgmail&ust=3D1786591574713000&sa=3DE
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jason Colapietro <jasoncola1@gmail.com>
---
Changes in v3:
- No functional change; resent as 1/2 of a series.
- 2/2 makes -p work regardless of where it appears on the command line.

tools/usb/usbip/src/usbip_list.c | 33 ++++++++++++++++++++------------
1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_l=
ist.c
index 3d810bcca02..b9d60b87e47 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -41,7 +41,7 @@ void usbip_list_usage(void)
printf("usage: %s", usbip_list_usage_string);
}

-static int get_exported_devices(char *host, int sockfd)
+static int get_exported_devices(char *host, int sockfd, bool parsable)
{
char product_name[100];
char class_name[100];
@@ -80,9 +80,11 @@ static int get_exported_devices(char *host, int sockfd)
return 0;
}

- printf("Exportable USB devices\n");
- printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
- printf(" - %s\n", host);
+ if (!parsable) {
+ printf("Exportable USB devices\n");
+ printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
+ printf(" - %s\n", host);
+ }

for (i =3D 0; i < reply.ndev; i++) {
memset(&udev, 0, sizeof(udev));
@@ -98,9 +100,14 @@ static int get_exported_devices(char *host, int sockfd)
usbip_names_get_class(class_name, sizeof(class_name),
udev.bDeviceClass, udev.bDeviceSubClass,
udev.bDeviceProtocol);
- printf("%11s: %s\n", udev.busid, product_name);
- printf("%11s: %s\n", "", udev.path);
- printf("%11s: %s\n", "", class_name);
+ if (parsable) {
+ printf("busid=3D%s#usbid=3D%04x:%04x#\n", udev.busid,
+ udev.idVendor, udev.idProduct);
+ } else {
+ printf("%11s: %s\n", udev.busid, product_name);
+ printf("%11s: %s\n", "", udev.path);
+ printf("%11s: %s\n", "", class_name);
+ }

for (j =3D 0; j < udev.bNumInterfaces; j++) {
rc =3D usbip_net_recv(sockfd, &uintf, sizeof(uintf));
@@ -116,16 +123,18 @@ static int get_exported_devices(char *host, int sockf=
d)
uintf.bInterfaceClass,
uintf.bInterfaceSubClass,
uintf.bInterfaceProtocol);
- printf("%11s: %2d - %s\n", "", j, class_name);
+ if (!parsable)
+ printf("%11s: %2d - %s\n", "", j, class_name);
}

- printf("\n");
+ if (!parsable)
+ printf("\n");
}

return 0;
}

-static int list_exported_devices(char *host)
+static int list_exported_devices(char *host, bool parsable)
{
int rc;
int sockfd;
@@ -138,7 +147,7 @@ static int list_exported_devices(char *host)
}
dbg("connected to %s:%s", host, usbip_port_string);

- rc =3D get_exported_devices(host, sockfd);
+ rc =3D get_exported_devices(host, sockfd, parsable);
if (rc < 0) {
err("failed to get device list from %s", host);
return -1;
@@ -351,7 +360,7 @@ int usbip_list(int argc, char *argv[])
parsable =3D true;
break;
case 'r':
- ret =3D list_exported_devices(optarg);
+ ret =3D list_exported_devices(optarg, parsable);
goto out;
case 'l':
ret =3D list_devices(parsable);
--
2.50.1 (Apple Git-155)
-Jason

On Tue, Aug 11, 2026 at 6:48=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 8/10/26 21:42, Jason Colapietro wrote:
> > The -p option only affects local devices and gadgets. Remote lists stil=
l
> > print their human-readable headings and details, so scripts cannot pars=
e
> > them using the documented option.
> >
> > Pass the parsable flag through the remote listing path. Emit the same b=
usid
> > and usbid record used for local devices while continuing to consume eve=
ry
> > interface record from the server.
>
> What happens without this patch? Can you elaborate with some examples?
>
> >
> > Fixes: e9837bbb3e69 ("staging: usbip: userspace tools v1.0.0")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219502
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: Jason Colapietro <jasoncola1@gmail.com>
> > ---
> > Changes in v2:
> > - Make the email From header match Signed-off-by.
> > - Add Cc: stable@vger.kernel.org.
> >
> >   tools/usb/usbip/src/usbip_list.c | 33 ++++++++++++++++++++-----------=
-
> >   1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usb=
ip_list.c
> > index 3d810bcca02..b9d60b87e47 100644
> > --- a/tools/usb/usbip/src/usbip_list.c
> > +++ b/tools/usb/usbip/src/usbip_list.c
> > @@ -41,7 +41,7 @@ void usbip_list_usage(void)
> >       printf("usage: %s", usbip_list_usage_string);
> >   }
> >
> > -static int get_exported_devices(char *host, int sockfd)
> > +static int get_exported_devices(char *host, int sockfd, bool parsable)
> >   {
> >       char product_name[100];
> >       char class_name[100];
> > @@ -80,9 +80,11 @@ static int get_exported_devices(char *host, int sock=
fd)
> >               return 0;
> >       }
> >
> > -     printf("Exportable USB devices\n");
> > -     printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
> > -     printf(" - %s\n", host);
> > +     if (!parsable) {
> > +             printf("Exportable USB devices\n");
> > +             printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n");
> > +             printf(" - %s\n", host);
> > +     }
> >
> >       for (i =3D 0; i < reply.ndev; i++) {
> >               memset(&udev, 0, sizeof(udev));
> > @@ -98,9 +100,14 @@ static int get_exported_devices(char *host, int soc=
kfd)
> >               usbip_names_get_class(class_name, sizeof(class_name),
> >                                     udev.bDeviceClass, udev.bDeviceSubC=
lass,
> >                                     udev.bDeviceProtocol);
> > -             printf("%11s: %s\n", udev.busid, product_name);
> > -             printf("%11s: %s\n", "", udev.path);
> > -             printf("%11s: %s\n", "", class_name);
> > +             if (parsable) {
> > +                     printf("busid=3D%s#usbid=3D%04x:%04x#\n", udev.bu=
sid,
> > +                            udev.idVendor, udev.idProduct);
> > +             } else {
> > +                     printf("%11s: %s\n", udev.busid, product_name);
> > +                     printf("%11s: %s\n", "", udev.path);
> > +                     printf("%11s: %s\n", "", class_name);
> > +             }
> >
> >               for (j =3D 0; j < udev.bNumInterfaces; j++) {
> >                       rc =3D usbip_net_recv(sockfd, &uintf, sizeof(uint=
f));
> > @@ -116,16 +123,18 @@ static int get_exported_devices(char *host, int s=
ockfd)
> >                                       uintf.bInterfaceClass,
> >                                       uintf.bInterfaceSubClass,
> >                                       uintf.bInterfaceProtocol);
> > -                     printf("%11s: %2d - %s\n", "", j, class_name);
> > +                     if (!parsable)
> > +                             printf("%11s: %2d - %s\n", "", j, class_n=
ame);
> >               }
> >
> > -             printf("\n");
> > +             if (!parsable)
> > +                     printf("\n");
> >       }
> >
> >       return 0;
> >   }
> >
> > -static int list_exported_devices(char *host)
> > +static int list_exported_devices(char *host, bool parsable)
> >   {
> >       int rc;
> >       int sockfd;
> > @@ -138,7 +147,7 @@ static int list_exported_devices(char *host)
> >       }
> >       dbg("connected to %s:%s", host, usbip_port_string);
> >
> > -     rc =3D get_exported_devices(host, sockfd);
> > +     rc =3D get_exported_devices(host, sockfd, parsable);
> >       if (rc < 0) {
> >               err("failed to get device list from %s", host);
> >               return -1;
> > @@ -351,7 +360,7 @@ int usbip_list(int argc, char *argv[])
> >                       parsable =3D true;
> >                       break;
> >               case 'r':
> > -                     ret =3D list_exported_devices(optarg);
> > +                     ret =3D list_exported_devices(optarg, parsable);
> >                       goto out;
> >               case 'l':
> >                       ret =3D list_devices(parsable);
>
> thanks,
> -- Shuah
