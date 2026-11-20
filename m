Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197268;
	b=fPgxXSqAAv5I5KJc/yWjRf0n/aRHOXhY0u+IIzjWG6alI/nxufmgqiBEWjLoAVayL5Yn
	 zwzLkIYykR0XC+H7d1V0tr1B1/H0jemJ1LYLbmbd+f8/QaK0zrZpJ/UQQbDIEQakbxeNd
	 5dFSCHJ2WGqpPjGSKZrnsHoo5LxlD/cpUGUtIxLCGHaPmrfH3NMaCgRURGTSnPFZSa+k8
	 ZLWdzQLNYy42U9pFEzQrjTvdqpQk+536mQCy1JXb4aXcGOGiskeEH5eafn/rku3x1eAEH
	 B89u3nBgqvm4bK4koaPlhfjEyGSzYuSPtBaEcuhDOjQAwwEzyz8n0i4sXqJQD5uzTbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197268;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=g/5ihrOrEYdtMF7cAo12Cb9BZ1N43GpkVryzZU3sJ7o=;
	b=xxXNS9wy5VZeixZkuRxFubH+nAmH9QAvXpQ6ks1AQVXhvuLOvO4opjCxtKhOnCEFn33h
	 EcShTInB9UrEFnCIMukbYVmkyHgM6BQoGXeGHFVzW90LR4DH0Wu8MenH8lQGyqBmCLrnD
	 zMVAm4o7pw1tUcXAbUD9CMjzvyi5qFGq6KsxRwSKOFAggyeFtp/Oc6gPH+NQ9+t5i5wqC
	 jgP9q0gD5WhOzIbpIUkQiuCtYdzgSVuDlMU7xbQcmnFfP/vi8MlIARTkzfD35xqxy61Qt
	 WMPecuaMeGhfcAb3XDc5yuPg87e6TK6Y191hPDombOsUGi1VGwFpw+RiJIHxyeBie3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gtrHjavI;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BE60A381E
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0BE60A381E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gtrHjavI
DKIM2-Signature:  i=1; m=1; t=1795197265;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:eLLd3TlYkxxmEElx3HAkVdbOgMg3
   sVDTxjuLOKbhqgIRjqvTKZ7bojUrtZ/bpdgofuSGyuU/GTwdo6kBLVeY07fNard3lxfEgCRVbWL
   sxXyCbJqV09CHDYSKhplUXTwUVXISV7+H7crPPjtuYVEGk4+2lOepbmobq+sS5u3/ADFMvec8C8
   dELgq3mI8s4R1RM8nUQIUg2dRcZT1yPhh/5+oDQloYYmivr5Ku1wMNYun7sHmDAzZGPHP5H0e2/
   szYx2QZ0spwFxDxFi3Qd+6I9mQ6hX4dZjskY+zaLELlrZ512FrvFsIYCIIRanqAh9UPqM8LTFVL
   KQjS0YaIQ+UGBA==;
Message-Instance:  m=1;
 h=sha256:
   gY+DyrjmI1frdQlhPrGFEEzgCgAYorV6Qt6i4B57LJQ=:
   9spbTM1JbvoboYh77jNITz+p+qG9OC2+VBQBSVbLkEw=,
  sha512:
   qqYSx70Ikd27H2IV1ypGXZ5SqQuSsTiUltdrIEFdq3BKRgKfcUGiiv9lPKpg54arpgYpuNxK24880c0D0SNv0A==:
   xAV3zlV+fsMzEhHaKUZGpFlQ9O+w5QFPbWQ90rHkzqyzizrIvBh6pyEO841oPUIZZ23eN5xVcOdLYCI5bfCfgQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795197254; x=1795802054; i=deller@gmx.de;
	bh=g/5ihrOrEYdtMF7cAo12Cb9BZ1N43GpkVryzZU3sJ7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gtrHjavIVfe/PL+nl/KclbBpl/c2ukvfzqUxtpQl3ihWMB0JopxuIwRFIGA+Yjva
	 Yv5VDPsAHuJtDT9U2QjLNXtIVmoYfSQ5C5Q0v3MDcFN1lgmwl7wy+qGi98tFtZ7yw
	 DqURL8KyhHIKonD8G2FwRHGOA3jmugwQVN1GnHCUVZ5bIPIskrKpXdKOIQRnEuhgI
	 Rpwb+4VpE5hkqnVWAdOLMn4ObwrUcCPAG1Pg6OKeJ1E9Eqs+lopqdhw0eF6MUIEAZ
	 bpU8mbL+smGxogZ0bHlLDNsKnGWX6/g7Bp8BGLwpn26Z56za9zeX5sYel7Zq9wkn7
	 r59x+QLYI1yJ9GPLoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1y92tW0fzg-00dsKQ; Fri, 20
 Nov 2026 18:54:14 +0100
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Jianqiang Zou <jq.zou@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var()
Date: Fri, 20 Nov 2026 18:54:12 +0100
Message-ID: <20261120175413.176249-1-deller@gmx.de>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xqg1wdA17GVAvX0BQHvQneFOqqLbDMfBwXdUyuIGV7YzGDNazj3
 VxR613Ip9xBGm2OehBRFg8eULk+Dnf0KPUexmORoI1lDQS3vMS9oYWtApc4uIv3dsjqFYXt
 O/5ercW49ic+G+AqPuA5VDy22mHqV6e4GNyffdlNj6M3bRWR4J37CX7pFAnvHt3scMae+Ro
 xg69EZeSgEPsD/J7T/3cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aKc4ptsHbyE=;iMwVaLIN6+Wk1StmdFAqQTt2jWc
 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
 mlD5onnTqhJ7uVx

From: Jianqiang Zou <jq.zou@outlook.com>

radeonfb_set_par() derives the dot clock from the user supplied
struct fb_var_screeninfo:

	dotClock =3D 1000000000 / pixClock;

where pixClock is copied from mode->pixclock.  A zero pixclock
bypasses the existing validation and makes the kernel divide by zero
in radeonfb_set_par().

The driver does have a check for this: fb_validate_mode() returns
-EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
the output has no scaler and an EDID-derived mode database is
available:

	if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)
		if (fb_validate_mode(...))
			return -EINVAL;

mon1_modedb is only filled in when an EDID is read, so when no
EDID-derived mode database is available the validation is skipped and
the invalid mode reaches radeonfb_set_par().

Reject a zero pixclock in radeonfb_check_var() before matching the
mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
->fb_set_par(), so the invalid value is rejected before the mode is
applied.  This is the same check other fbdev drivers use (i740fb,
arkfb, s3fb).

Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
single FBIOPUT_VSCREENINFO with pixclock =3D 0 is enough to trigger the
divide error.

Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 drivers/video/fbdev/aty/radeon_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/a=
ty/radeon_base.c
index 387bc5f96765..45dd42134e81 100644
=2D-- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninf=
o *var, struct fb_info *in
         int nom, den;
 	unsigned int pitch;
=20
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (radeon_match_mode(rinfo, &v, var))
 		return -EINVAL;
=20
=2D-=20
2.56.1

