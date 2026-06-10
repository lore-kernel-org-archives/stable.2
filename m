Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A331716B
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070558; cv=pass; b=ZJKKEi9H6bTEvis31+ZrmGiWvA67nlI1k8Ry5u3tFr+yezpZFRN2aowsezEfAcycRsAxDVCALr0UksuQ+5nP4l3l4ia8HBteIMHaD4nKr6OLIfiNZ543T8KF5UHgrEejB3WYcqsGQC+Ezempofr+H2eQ72jsDT+eBhpSzqP+DkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070558; c=relaxed/simple;
	bh=UPqRbt0X5R740pgfqeDdxfhlNiihnRU9VUmOR2dftcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbuKlulhJbpKRxYLZpgAXU9yv3pDABpbGEc3yiGBbm/RD9Y0lqIb9ftKY0kamXfoFemYEKkh3Qti6KSBEIbLYjzQX0lUkCxTWxAxUFi3ic39DU2FzTSA0PXLi1wAqWTjLS4wWiVpxDYnW5OG7Tc+NXG7ATfqs1nLSIzxrPRZ8Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzmG55gN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TozqnaIK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzmG55gN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TozqnaIK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A2ejpU3999743
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hbzw20D8FYSmsWZCeDGMQXWH0ByXuhpAnnM3jTCycD8=; b=lzmG55gNfHca5ZlV
	LpIpnXLZ8vgWQSUA9wzHxBkaxiPDTf6rbWt5lgO5Nf779G/CZyhMeW1IZtSR94oJ
	RLAy2LLgTN5ZmR69Dlyx8PkrCJFACd7DPlxbPSKNGiH8988THSfZ7f993pF55XAE
	0cvTQpKAc4doU063BnOmQATuzwOet6JvVWhMIkjzuU6qVXP+iP4NAfccJ9xW+0fC
	DwqKuI/UAw8EgBD4RW3FRXZR0+uX0pxODdu9uYDGtG/kk3hsx7qaBDmK9y7w53bE
	Yn1pu71ohC4ai5nbuke4M96dFKY4zCz/lP+ArR19AJa3MPUznc0ht3MbVNhQt+TH
	1OMhmQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvgnc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:49:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157f453a27so1245347885a.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 22:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781070556; cv=none;
        d=google.com; s=arc-20240605;
        b=lCuqb6JaMerAFsUfXZMLMQU0+JF7ikE/fJiFnftgPmLpODQtN2LAw69oRSwFaNwv7N
         oEXpf/Dy1jqwYeJ3HK25wFy8TWJEyflfhQ4YQYtjPArhu08Taxi7TlgjOAX1Dj1ByA2V
         0Aca0p6gRGXKWyVVSkHQDEFBPYQCKfEY5uOWn8a18DXOG8OUnhB40s51Kyhc5AVy69bb
         JCergr+CqLLMqvlBlaUstEU8JakbkNJQ1eQ7O3P3Ig7BdIoqGNjCcRDV+J4tNhL2PX7f
         W+NR9FkljOeQ9h7A5fcJcXyqL7tcLvBA96cdtlqD+P6DPSFUUyGAGDiHFnNr4rfZU/ec
         LDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hbzw20D8FYSmsWZCeDGMQXWH0ByXuhpAnnM3jTCycD8=;
        fh=tFfznuHsCUlhvJQAoq7jTn94/jpn1KUnQgcFSWYVroY=;
        b=aLwE4dMKzzLfHBPcmlXVB4GiSRsU9isV7bD+kc6prqXdV+3dxfSdHytAazMa3i6PLc
         COJMtvOlfP6QvIrWsubfr5WDVkWijDCfusH8ihSctORCCF7MZTwJEWYZw6F2o5bg4PWY
         +jj5YfZD75Wu/5DdF+CmfAV9eFHizYYjpYACcZCMwe5TPGhw4IwhdlSHBAS4Ls8TSILY
         c0LkKchRInLg8unXr8IS0NPMnIXBwxG5UYxhX8wHjRPzrtbUJ1V+IPU9udjYZe4PVFAn
         UCLywCuALMi/+CvDuRMyv1qqvAIkQkiawLCHiWMt4ZLzbFwOl4UsVPJTe5doTcssQwDv
         oyzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781070556; x=1781675356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbzw20D8FYSmsWZCeDGMQXWH0ByXuhpAnnM3jTCycD8=;
        b=TozqnaIKv2Q5JuKS1p+/p0VsNsu+oodHyPhrrQ/wsb3fhWlZ/48g1h0gY6LMngrzl8
         KzCrXE0Q72kPgUB8WDFp1H14LPfLo2A4061FQQG8ESHAUqAv1LJ85lwHUCYgGbwxT3bV
         85zErfb3g8SscQyei6ueow3zjqs+/ABO78hhwZT08wBDxKN2AUqwdkFNtQ4pG5jIktoF
         9OGzI5eFFPmfpwwZY4k9RrXCF8Md2ZAUFxEmTbjOxJD7exfRNIv/rvtzC9HAEP2Le3iH
         UmskTc6s8jsqVvLWDR+F282JcK2kk8h+hXM4SczeCOZV50x/bIpaGXHiEEBQMEwfV2Ja
         aR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781070556; x=1781675356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbzw20D8FYSmsWZCeDGMQXWH0ByXuhpAnnM3jTCycD8=;
        b=DIbAAENag9GrHFYFkjoe2RSSx30UFEMr4zdMS2CgXDtPt2uFVoF22TMPIjGr+sXpZu
         Tr0nPjiyteVb9hbvVIs51tayl6UsubnUD78qVok5Lfv+wQaNHVBqSHZo5dfosY/HkpXU
         DCTHIv1/DayS3zeYOPP1z7T7h9HWDqDFq7zW8WZ/vJzJCm7F52GxVBJwmx4G1i8FvZ92
         VAwuiTDUmSMpkP525nOyE5TXvXKVYewAVhv9ydsbT+or0achpNiKWU7zCxmi/pJdw7/C
         htgG/C5otB3QCjkQHZ+r4+TP+/sWolxIWRpVybOrToyzDNp71lnaxmGbxrUrV0jF4pJG
         amZw==
X-Forwarded-Encrypted: i=1; AFNElJ/qcsHj/6XPhQubpuAtmfgV18UJKk+pA7tmkuQcXbbQZyLF+CKYvIOn7aT0BFivBPs3lvLObDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EASr+wztVzPbcFWZUm3rXGwdQ3C0xfw9mK+Gj1zmtz6AfFhR
	PVp6WyEwRZcGXeGqY1E7s43J9TrLSFpLoYmS5CREkdzCK/TBo2itAOo1NIcg0eAlwrhcHYR2ucN
	uobRihq/+P1M+RcdvHrtR3TW02kPVYXSHUaNMHGP3tc4tOg8D61BkDN/DLh46AYU9lmipIdiS8j
	uZsfoMofQXFFtbbUMiOwRc5UMMqq4A2T4eIA==
X-Gm-Gg: Acq92OENWZztkLACiiNcLD4FPc5PBTGImOI/B9orI3W3AYd+h+3u4pzaHYV0lsSRjst
	MVo7CbCbtmNNbc8Xk65TM7dMZpkG83Gx7Eui+vikQ1Cz1vyhr0QEU4AUUZ56qUJjK12taBqnDV4
	6nsXl5OAlRrgKWnZnyojCDaNP1jYSMDPFXef75FyvG4T9i7yY4e6VYdKK91BDgDdkCjkqZALVlw
	s1i8iOPvTlWdBcEEWoVimPoaY3jS0Zwkpo0wb8H7EGJx/VtthohxjBq/otn3VxnrngTz6D6MHfP
	trbs8+GYDBNK4uDDBUUpJqsF1Q5Hk93r
X-Received: by 2002:a05:620a:1d06:b0:914:ca75:e8cb with SMTP id af79cd13be357-915a9d9649emr3729482185a.39.1781070555887;
        Tue, 09 Jun 2026 22:49:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1d06:b0:914:ca75:e8cb with SMTP id
 af79cd13be357-915a9d9649emr3729479185a.39.1781070555453; Tue, 09 Jun 2026
 22:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
In-Reply-To: <20260609193635.2284430-1-tyler.baker@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 07:49:04 +0200
X-Gm-Features: AVVi8Cf8dSXCPgyP7MqAedF6NJffKg2QK_S26zTj2cvlRjGley-OvXYegh_YNCk
Message-ID: <CAFEp6-1ksgRoWjNzDJTrvczSi=8oO_TSr7+V8KB2ZsAssJSuhg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: initialize reset_work at allocation time
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Michal Nazarewicz <mina86@mina86.com>, Felipe Balbi <balbi@kernel.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FxIJFN2By4jj3Q6JI8rSZIVF-e3GSLYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MiBTYWx0ZWRfX8TRUirhfhM7c
 d8Z7hfA7C4KjjwBxsQV858iY3bSpzzu42HObf7fPamejM1MmCAbUoUoO1C1Kf5P8v58GeovFpFU
 PVA+Df+gmvP4mSNiZbkvpsv6Zx8GgfK6HNOpaw0nWl6jTV4peHZwsdRYCFRLkZ+s/KZ5pFC5tHm
 baF84fADf0hV6fV1N3kV//6Dz9dUkfRIap23IPQ0/ZKjVfiPDuqkwBrUDHk42Ws7dLzrx/HURYa
 vcHY3hncV5D+GMV5IjmDMwEqniHPLu/kdP4S8MegKfn+Fx0AOYsN4M/PUP6WtnDGnXxSjjl41Za
 iPfEvYVcjli7jG+G8m22bOZfDrah9NFODkznj1PP7q+/anU8jIXnRRl7wuG+UYF0m/+fRMexmoN
 J6B/hSqztSYB6FhByVplgmaBh4BVMVEIBgQEves78SHHyoc5vOk+94tcAzA5r4bnXHHmGe1gPDb
 G7cMNCqRPuU57/BxIyA==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a28fadc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=mLohLnV0Ck6ZQudTKkoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: FxIJFN2By4jj3Q6JI8rSZIVF-e3GSLYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100052

On Tue, Jun 9, 2026 at 9:36=E2=80=AFPM Tyler Baker <tyler.baker@oss.qualcom=
m.com> wrote:
>
> ffs_fs_kill_sb() unconditionally calls cancel_work_sync() on
> ffs->reset_work when a functionfs instance is unmounted:
>
>         ffs_data_reset(ffs);
>         cancel_work_sync(&ffs->reset_work);
>
> However ffs->reset_work is only ever initialized via INIT_WORK() in
> ffs_func_set_alt() and ffs_func_disable(), and only on the
> FFS_DEACTIVATED path. That state is reached solely by ffs_data_closed()
> when the instance is mounted with the "no_disconnect" option, so for the
> common case (no "no_disconnect", or mounted and unmounted without ever
> being deactivated) reset_work is never initialized.
>
> ffs_data_new() allocates the ffs_data with kzalloc_obj() and does not
> initialize reset_work, and ffs_data_reset()/ffs_data_clear() do not touch
> it either, so reset_work.func is left NULL. cancel_work_sync() on such a
> work then trips the WARN_ON(!work->func) guard in __flush_work():
>
>   WARNING: kernel/workqueue.c:4301 at __flush_work+0x330/0x360, CPU#3: um=
ount
>   Call trace:
>    __flush_work
>    cancel_work_sync
>    ffs_fs_kill_sb [usb_f_fs]
>    deactivate_locked_super
>    deactivate_super
>    cleanup_mnt
>    __cleanup_mnt
>    task_work_run
>    exit_to_user_mode_loop
>    el0_svc
>
> On older kernels cancel_work_sync() on a zero-initialized work struct was
> a silent no-op, which hid the missing initialization.
>
> Initialize reset_work once in ffs_data_new() so it is always valid for
> the lifetime of the ffs_data, and drop the now-redundant INIT_WORK()
> calls from the two deactivation paths.
>
> Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Tested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index 75912ce6ab55..1ee21e29ef73 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -288,6 +288,7 @@ static int ffs_acquire_dev(const char *dev_name, stru=
ct ffs_data *ffs_data);
>  static void ffs_release_dev(struct ffs_dev *ffs_dev);
>  static int ffs_ready(struct ffs_data *ffs);
>  static void ffs_closed(struct ffs_data *ffs);
> +static void ffs_reset_work(struct work_struct *work);
>
>  /* Misc helper functions ***********************************************=
*****/
>
> @@ -2221,6 +2222,7 @@ static struct ffs_data *ffs_data_new(const char *de=
v_name)
>         init_waitqueue_head(&ffs->ev.waitq);
>         init_waitqueue_head(&ffs->wait);
>         init_completion(&ffs->ep0req_completion);
> +       INIT_WORK(&ffs->reset_work, ffs_reset_work);
>
>         /* XXX REVISIT need to update it in some places, or do we? */
>         ffs->ev.can_stall =3D 1;
> @@ -3775,7 +3777,6 @@ static int ffs_func_set_alt(struct usb_function *f,
>         if (ffs->state =3D=3D FFS_DEACTIVATED) {
>                 ffs->state =3D FFS_CLOSING;
>                 spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -               INIT_WORK(&ffs->reset_work, ffs_reset_work);
>                 schedule_work(&ffs->reset_work);
>                 return -ENODEV;
>         }
> @@ -3806,7 +3807,6 @@ static void ffs_func_disable(struct usb_function *f=
)
>         if (ffs->state =3D=3D FFS_DEACTIVATED) {
>                 ffs->state =3D FFS_CLOSING;
>                 spin_unlock_irqrestore(&ffs->eps_lock, flags);
> -               INIT_WORK(&ffs->reset_work, ffs_reset_work);
>                 schedule_work(&ffs->reset_work);
>                 return;
>         }
> --
> 2.43.0
>
