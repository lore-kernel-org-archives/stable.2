Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793210205;
	b=B/lp2et6s2YML7bfROpnUvP0EsLs6/u0f0KYwgXaF+L6Mq2ClQO73fAtbs8w863zcuoA
	 w7Ywx8Uif2fr3PIWYkP0btKatBGW0YWIe+S2XWGJQmZWkALJM8dzLirpjzsXurvgjACu/
	 o9ELo4GCxlp+oPlMRlMgmJ3nJpHfrlrgeiN9vPMSj4Y0M9EK8WGljoHxUvtBSwTfPEpJi
	 KbtHkjGVBPK16WSXnFZI1/cfeVq3p0zvlq+a7y0Upo8p7GwMcGoCN5W4sHcRu2aiHJE67
	 K91XozwkodTSjYUzfxGAmBfRwO6T1m7oBVSk9RwaAvMWZlCGqU6g5ozI/Gwas/dOgGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+7QuCpMDuaPEn/821Gdh04dyOpLKWIkef/TiSBsZIMo=;
	b=Iujtz2FJpT316dNS1L1pQU4cZQO5Sb7tR2bwkqFzJBCgOkk0Bm8EbDEtMgT3yfFu6aHl
	 wswX/kS5kO+6RCORiBMXQPxyIdAUSZqQQEU1sI9AGWiqjbgKYw10012kc9o2GNXmZCkEF
	 AYi6NNqV11VXLUxDd4qDCIMFdmjJYhiOQTzrNjluozbjXeJ9qRUQeJPmLK1sM2scIx8nE
	 Ib26Oz7SgCnV9BocIWJleRtz4StdZk+CevRWn2D+SjYdQivDrLLoAq2LXrQS4Umx6vSRi
	 ZnyfT58j7/0ZWnKl5gNbLq8SjHmqL3bOCPpAoPfleLLebvDqVj64k1yXw/JZug4F5yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBmABpD2;
	arc=fail smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B2606A333
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648B2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBmABpD2
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so1571319a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793210204; cv=none;
        d=google.com; s=arc-20260327;
        b=b54px9d1YnK0wvoBjfgdwjQTDZEzaKBIdNpc1bJ1Ajs78h5RR2T/MpiuLnyxQQG56v
         DlO328Vh4XE8aEiyqJrn3kVmSuj3Iwah4e/f0mbxd7qCys239DBJ0Fehcldont+2+ukP
         k/TJI7bqYIqsvWEoGV5TQdjrUx2nakGi7AwkZ97SUwWQy1iCAn+UbTAysmND+TLuH54i
         nsn7MuXr70dQVC4yp7qqIJW7m2NJmTBGLpfsdrxv/0kI4iN2e7cAIjDJnhVxbDt+MxCo
         0JnyOtVou1sYOvf4CS8NFxtxtojMDldawk5Z1++EYf/5VJ1/DTSbLcE9d+Y5Hm+8F88d
         6r4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7QuCpMDuaPEn/821Gdh04dyOpLKWIkef/TiSBsZIMo=;
        fh=4n4q2BmShAqr1ze1N3MBbclm8HOzsM1KNJ8zZjRITn8=;
        b=BaXL+7lnJlCfU6Yv+Rq23oJ6YnonGamG3fwNm6qI4FQZMxU874ApO//OtQIDJ0sEEb
         Rv+npflCyRxZqe8DJWF3JZka+GrU8B+kOQMMXd7WA4VHdfkdlkGsRHyIbnv+/Xd8eorr
         Ufes2+YNB9Czo3ProvQX7uqmGjtx/pCsx+yDDlp4DuDP/9tjYbEHNK43jDvM092tVSRd
         ZMyNs3TZkzROFx7+zFv1bXtxmu6EWsdAPpokhDjjRng4EZefvWkcdqbMskDUoP//q6Ze
         XV3oHJNIWdKTaOxdu1Eh2xKs8ACBsa0ba3nj7It0efLPyZ/KwOBjE3mRgWxd4xZsClnE
         mUYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793210204; x=1793815004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+7QuCpMDuaPEn/821Gdh04dyOpLKWIkef/TiSBsZIMo=;
        b=cBmABpD2dTbyN8N3Nkx9RhLc3X+FY/sh5ng0uHcOzmWu1KrIcemCqswmovukJCLQTw
         p9YOtz/ycR1U0L2FW1+KufDeIpysFXBqROFzeJ/m3jDBtozvsBMbsS4IJyxiWQSWtO2A
         YdtA60A0oIbeOR3Qs3R8hPAIme288xlTLmYS6IfDYncv2GcRcV1rVYp30S6t0M8UjTwc
         NFHT9g+vPsDEMkgOcnV+fe96b7lX5NxJtSHVCPGG7acE3JFTboEunEKHiezUly7Efa7J
         9ypmTy8F5vMI4PiTbpWP6U0OLjqnWPdT9Q4AOmaI5KTZ94HNferCcSQbdV6bC5qNgyew
         c4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210204; x=1793815004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7QuCpMDuaPEn/821Gdh04dyOpLKWIkef/TiSBsZIMo=;
        b=M1Xvsn2Vy/n7K3Wd6es8CmlE8BsXzWfSO35bVZ8T142Rk+izIb8yoCwdAEwdQrRBiH
         KTamHqOVWJUqWZ+izX+iVt3/UmrRE/XQResKQfBQLWlFpvaFy0unDsjGc/T3Bg+fIJfJ
         Lob8InwEh8WQEFz9TraV2EBGQSKVO4jE+3egCL74tIXdhthI6smlgbaEpK4xH81K1TDG
         ovlTB028Bb2eW24/DvbbWaOYjHQXaC0RiZFleZT9aj0KCyimJV+6mcDNL6aD/9YzALgW
         cV74tCe7UtpckIJVlV5SQ2kTLyVNGMvk3whpp4UtcRjmEWrRAVEUUd1TrOnkbJhTgYOj
         BxYg==
X-Gm-Message-State: AFq9FYL8hS/z2J0SJRiPUZV6532D664EevfyQwGitaD465yZlXNicsHK
	1re8BmwfEFf2Q2RR1yw3gHOV5atnQchjs7Aq63R8CwHYDQSnteTOesNwp6U5u3Rd/YPQQqbfAV5
	KMWQ7kGi0xtV6Vnjc/cNU0RPg6TGSilo=
X-Gm-Gg: AYBFou0I+Asiew1UF2NtNWTlKI7gGw+M8VZsWNxbkw09gEKTMDUdUBLZcb4E62HyoRq
	vOoCEZkjxUtADXpT/ZFTImf/W/Mg/+6hRAwZyGL4XrAnlc07fVLC+Qd4kMKxG3NgO84Hs+HFtEY
	iNqK9X/5vsy2Mdm/XaP30SgvOFDyOHzl7SRDOQQwlPMgQ/SVrLD6Z/RR/BclN2iOfFWNG2t6dfQ
	URS8znYvbUdf8ttWoIT4X0FwCu15+TeMjPtQ+3maN6UIlNEMQ1hBT688mGAqdVA6y9c8+mwv92j
	8AL5HD5WjOBrJx59vLuAI/MAW4Y3TSthqylwV5LPCDVY2ZCjZUMcLLGrYa0HlICNaMzr/EVHzBV
	/AwRAq1ESb7g7iIO6FtB42wvuWMeju4xAYcsiwg7XI42i8/n/tRAicog2INgAmbu+TtiN8w==
X-Received: by 2002:aa7:d152:0:b0:6b4:21b3:a407 with SMTP id
 4fb4d7f45d1cf-6b49cbec0d5mr1632982a12.22.1793210203401; Wed, 28 Oct 2026
 10:56:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028165947.349197979@linuxfoundation.org> <20261028165950.290722602@linuxfoundation.org>
In-Reply-To: <20261028165950.290722602@linuxfoundation.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 19:56:32 +0200
X-Gm-Features: AclHuK-tumKlKRu862aY7gzIO6eryO1Aqbm0yAf8iy9yxR8Czrude8p5hPdV6F4
Message-ID: <CAOQ4uxjuTuVpx9GV86vt8JwKk9qOPayV7dx_86EofozKkK_kWQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 122/247] fs: get rid of __FMODE_NONOTIFY kludge
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Guenter Roeck <linux@roeck-us.net>, Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:15=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.

Objection.

This causes a (potential) deadlock regression:

https://lore.kernel.org/linux-unionfs/P4sl5iz--F-9@tuta.io/

Working on a fix, but no reason to backport a commit, which is essentially
code cleanup that causes a regression.

Not sure if this already hit other LTS kernels.

Thanks,
Amir.
