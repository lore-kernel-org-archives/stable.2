Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D0386426
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082601; cv=none; b=kpAZv1yMIeNtcxrvsicTVw+ZMP9QiZPuY+1RyhL1IbwN+IlZA2OimCIZCjb1Ts8llf7wc9FdFK75Qudl30C6muA6vpwuFhScn9WoWpJmscTp+JyRguSqM/bxi0zMwvfwkuWsMCqteoDh0ppZKy92C8AvB5ncJ8m1TDyGd8u/xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082601; c=relaxed/simple;
	bh=4DDQRyYGkgnBGoCsxqWFpAn7l7ImXg8ruT5iHXAW6c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2pkDll9y0tnFvp4YRt37uyJnIk0ii5SV1RvqSdBj9x0NLiSwDiVMtNpPQUmYgHfVRillmRE2l38vxk1vtX9mJ/ikRhHTcCMVPD5mR2dptNUv6GR1LU4LcYjrWmMXt+RYPJ01C89aUGZSdUDT47QnVsSKGxc4MXsWF9+hdKa2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M7O4k47/; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M7O4k47/"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-398a5aad413so1296280a91.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082587; x=1792687387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=caZA1e38buXRS2NBD5pSfGkz4UPCMF7jYcB1RuBkGGU=;
        b=J/RSblrDfibQSPWfwBnw96PfujP/YQ7/svxWik1X4NAmPTelQBmT0dURYEtNFD7L9b
         WqYOpfcqV8LeAKooVKLURyp1qlMw0ETzY56vDaQskbjsVtJtuWgyCBAwah6OWU1GWfR4
         bk7vOb2GCcKyzDX1rCjkVUQfL1CUCVhic3usGe5eHLJQ4741QRXWjJZeJAN1Jx/LmHto
         d237XjUm8h49Lw6bTi/9sFiEoKNJUHDXTSMYi/pKLeDmwlaw2WqgGvNodtD8X3k2yGO8
         3BCRLalGdgWOuO7CM7LGpw1CWty57jh3ExaZMn6q/b2dgwl8mnzYckvS+k9wXDBs4x+v
         0odw==
X-Forwarded-Encrypted: i=1; AKwUvBw8DoXE8R6JIvbq9h/DsJAnMNfppl/zy4a9ppXmEYLVY0HQg3E9+1d7xnlh9eSJUQGaN7q9SG4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxN5Vkw+xot0pKM/C+evndAcTYvCQbPCyrmZXDoDWBaDOKXgdN
	Lwvzr2XgAl3H7SkfgyymWZWoBpFJCNGAdzPt7fMYOmmtwEqHOvH8+tlhiSHvagG0ndjTNdwhyRt
	8Vak/uoFi5ps/KbgNDVLBfSdvp6AfKx06NQvlk4IWIllHu2DqX9QE1OoXhGXIZaI2Xo1ULfwc6R
	88Ybo1LnqVu7R1ZZ8Uj6zW8GfHyKzQZTecz5mLcSLW7nA5+PTfrl2DYq8q34+Ww7B6ATYqrL/iJ
	Ncctwd/
X-Gm-Gg: AYBFou2KXsSoG6o65e7fWdtTqzmozOOs0RmrgICzqP1r5xJT1/lNScbuBj2GQ2ixybI
	gihYSKfxie+RI4XGWSQ4uisv0cBFXRb+XuzDapAVprTwd5tgRDb7HxtdrC/Kd1xOman8MGwBkIC
	GE9VKh7647CGiuHpoIDqJl2G/o+blK0Yvbk4LaAWCTKZ0El0zdVIgD30fpGE4B6TccLDjJyE9BJ
	fPqSN6drHkzSqh9eFq90VOuy7l/YiqZEzZ0MtvrZnIm703H67CFHiqEfawr2+4CRAKQoRIc7Qi4
	mxFf6I1oMaNVgBNeI5WpjpRwXXNrPVbc/NPnNrrTXMVuCsSnS8RoF6uhOkJ7xvf+qpQq46Uo7OS
	OvotsAsiDsrkyTgk/RZOx678Q2qEgnxazmrY9o48bXP7ynlOL2Yse98I+ntbN5/XzG8SC2tTOqY
	+3AjG0mhoJnYB3nRaohQBGA/wLLdhNu+ku
X-Received: by 2002:a17:90b:390a:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3ac929e06a8mr3470333a91.17.1792082586692;
        Thu, 15 Oct 2026 09:43:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac9b6913b4sm1653779a91.3.2026.10.15.09.43.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 09:43:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so3309165eec.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792082585; x=1792687385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=caZA1e38buXRS2NBD5pSfGkz4UPCMF7jYcB1RuBkGGU=;
        b=M7O4k47/JTVlGwfkTtjMo20VIxLf/XJBfPIuBwOoQaUv0IVc5LdLta70645Qu1MwVe
         D8w/vd4GrvkKSixfWjT36Byb546cEYPQJsQF6UMBwObS2XTHfNvKb31ZmHCgNQ/+sYRe
         ZIZCuBZTvKY9FBxKWzn58eumWTUsozFQzNFF4=
X-Forwarded-Encrypted: i=1; AKwUvByKwucL1/43qdO0gr3WnNbCfED6zzvJeDwuczNIN6ve3wThkjM0RK1a5megubucfNPFYmEGjs8=@vger.kernel.org
X-Received: by 2002:a05:7301:70b:b0:356:23dd:3c72 with SMTP id 5a478bee46e88-35623dd574fmr22162818eec.4.1792082584999;
        Thu, 15 Oct 2026 09:43:04 -0700 (PDT)
X-Received: by 2002:a05:7301:70b:b0:356:23dd:3c72 with SMTP id
 5a478bee46e88-35623dd574fmr22162783eec.4.1792082584198; Thu, 15 Oct 2026
 09:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013120211.135807-1-matt@ozlabs.org> <20261013120211.135807-2-matt@ozlabs.org>
In-Reply-To: <20261013120211.135807-2-matt@ozlabs.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 15 Oct 2026 09:42:44 -0700
X-Gm-Features: AclHuK8uvZ2yCOXgWUEd0EcP0DV4PFr55gQDJjWOVezQ6ac0lSksAZFJroIxQa0
Message-ID: <CABQX2QP16Aid7tUk2kyPU9mUzB4XHcJKYtO3xsbDOQ3rgGYX6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/vmwgfx: Use get_file_active() for dmabuf->file
To: Matt Evans <matt@ozlabs.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Zhenyu Wang <zhenyuw.linux@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eab8ff065de3bdf7"

--000000000000eab8ff065de3bdf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:02=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote:
>
> 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops") moved the dmabuf .release, and broke the vmwgfx driver's
> assumption that dmabuf->file would remain valid until release.
> Currently, dmabuf->file can be stale after the file closes even if
> .release has not yet been called, and a future commit makes
> dmabuf->file become NULL instead of stale.
>
> In preparation for that future commit, convert
> get_dma_buf_unless_doomed() to use get_file_active(&dmabuf->file)
> which is the safe method to access and get a reference, even when
> dmabuf->file could be NULL.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentr=
y_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx=
/ttm_object.c
> index f9042bafdc93..9137a31eaa1a 100644
> --- a/drivers/gpu/drm/vmwgfx/ttm_object.c
> +++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
> @@ -471,7 +471,7 @@ void ttm_object_device_release(struct ttm_object_devi=
ce **p_tdev)
>   */
>  static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabu=
f)
>  {
> -       return file_ref_get(&dmabuf->file->f_ref);
> +       return get_file_active(&dmabuf->file) !=3D NULL;
>  }
>
>  /**
> --
> 2.47.3

Looks good. Thanks! Feel free to use either Suggested-by or
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--000000000000eab8ff065de3bdf7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGNz
VXkGGumopBKIn/qVTd6ehDVfWD1CXUSQEC9JhfzNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAxNTE2NDMwNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACWwSo1VrUwePCkDwJ6WZMBpRtNDlQM2QN9vcZIO
9VxSmU7FqtizmjvJg3sOF4Nw/bhAWBqoleBylD7Bjacx7w/zGUYcherjG5Sm1oY4A2H0V8zI9cOF
NLrJ7TiPr5R2r6nNfxl7mKgpkhYEXJlr1q/GiXVaWA5tgw/oq4VUkovjez2D3JBrYEq7h3xcgt7O
CtrVX+y8j1nRAsPDf9WFtK+JqjwmA038MpO8mNvCJ6RhjsbEp1/4DjJdEYvG1gAtwbkIA+GAfYYG
mOcaxxZS6Mhu2xTVd+FhWNhRSBoPQtwSTBhPPQrJQ8Dr2mwzZTo1Ml76Rovn/XXAG2Mo1KTg7v4=
--000000000000eab8ff065de3bdf7--
