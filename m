Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792432934;
	b=zhmqOuFQSXJhka6b810zA2hJMyQ2uRg5uiEbVL9sl0SiKXv4k5H6ZTtkPyiCQUtRxJH2
	 /GfRwvHhkn+VZgQBzT5L1E64B56pfYeEWR+AMNWWgSh86BY7kcsNgZOlhHGFdrF4FQALQ
	 kwrFxln5FqMKKOt8XKVEqsXLrK1mjJDp+VpkW9BUbK7WT61ZMzIV+T+NA1VxteadIb4Tt
	 mwWrpRZfsnQAKbU+oMKGeLa2/p1D12Ex1R0ZkfC/h+jXLHBrs+tQp/I0vzAkwsqwLHBkN
	 bAqOV/PB0ipbyyrqm5x9dSFnen16AZ0PFLPXwOpjn+pgii/t09h51wBhWyYOE1JHgpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
	b=HbLHsggD6wUWRsitIxOFAgi3J+2+di/gXB6TyhyI+4GvwricOUNLjR8Ula7R6lA5/NYB
	 wkAH9aYbQWcFkYeNzRKaFdjdNZXJWj1+pzQoYtoKrnji2ak6K3edsD1bPP9aaBQuzdq7E
	 /fLqUDuxwzJv/+Xbda2yNU3pIKJpMmdtvi1cul66xfNh+VFfRGSl+33kWhM3eIsikrat1
	 +na8CO8nfPrzb1Wm0+IAq7JqOVA7Rizjb4I3PxBjnJ0lEaVLep31cVhf59Ff1Zgtxfapt
	 eZUCXoUMaaPO+Y3Rbi2sJ7+TiGF1HQXQGmGHHG6g7RrIIudzvxuuZZL0io5cVCyRowg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qJQvN/7K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADB606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAADB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qJQvN/7K
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7538422bso312874a91.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792432933; cv=none;
        d=google.com; s=arc-20260327;
        b=k9H/NF75dBgzigdqYkJL3GLD97yrlutkyO7zI8oqg1SlL41EYiHUCXxITAacBDVfHR
         qf1cW0JPVb3AlaqB8IffEgVrIm5YCaQ1aR2cXMLu9OqCI1G+de7ihnbgReqofX2k47Zu
         1HoQTOT7CLIW3tdO2WmeAM612GjQnWp0QLPHpCjTYtUsUxUHX1tquIOo2OkZaYLImtt6
         8kwZNrsNAl+oCQ1rdDS+VPjK+QjHWCCMBWMCu6AmEiTbHn1fu0IWqROA2cJTGX5kJB6V
         +iwXszDwdvud4MTdJLGRt/hKHcNYtwf0WzoL00qpnX5VfESAdmY+Yze26yk2+L912ymF
         SYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
        fh=AaEDDhovIURDo/Vmj8nMDJ6gx5kjUFghBShKf0vgSYQ=;
        b=Ajf76bZ9uYkhc/e6ENKsygDuESqGmYhiYp+9jgN8iqrNpgpr3DrdTJRXbqceIiOyUP
         xR/FDGNha4R3K+5KD01UWJXfQLam9yAxyplTQYJRlOjhkYc1sx3eZVESf/k//fAsAEjY
         BRElx+tbUo3/9RclZ1NYI01wFxFHm74pkDUvH/BMrTPCw1PE2vqBKIGnPxUx4lBx4abF
         FgmoAvYzixgzwBG9jN2mfFPK+/UiDxXcVsFQiISJ7JGQ9qm0lT50oos56+Q8vKEwr47h
         h/jBcR2bl/h4B4KfymEG935KNVEYjKKTq/FL/rJAPq8FI2mdfeorX3ssgG+odBXfK5hb
         cMYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432933; x=1793037733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
        b=qJQvN/7KojCS7HBvK6Z5ZwxBfB7QttmRlobfb7uaf2+XIudUvsYaCUpDdnNXNe4SPk
         Vn3Qc2UT9CVexBt/UsIl1NJ2MTzqgKLWqSgGPrjmisKFh2ukR7CSL9AGWq/lpzmYPU/C
         mbWdNPqlFqh56LZtM/W/gmbhLLOAVHlQ/ThpDNfAK6fzhrln5SXUH6lj2UzYew1TWTcn
         ux2tXh15km17AgwThmeM1/VYV0FMEWA5Go4WdroPqKomWDZB4nc1TX9xz4lu/wO7dVKm
         XsucJR5xDv999hqFjnqmtMNrkFoLyDLYggGoRvnSVaudHGfyAfykryRSK+jdWIVj3GZP
         S3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432933; x=1793037733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x875RJdjfXCxzZDJCUqQBTmV/vQ+aYgwGesNdJIJmZs=;
        b=vq+Vdy7p87TUAPhu0iqCca71rNc9KZFqtP0ITk34dZRu7exV3Zh9bf6+nHW8NNwAEF
         +SzzLYt/zig0U3420eIn0yw1f7+HcXFZjd1fs1xQq39VsowCGoL7aQsV+MbwDwpl8rbx
         eBmiO6j8fS6S9qsOFL0hHHdfqfRw+DzudCoohg2beM9wL7ucy8E2okbtgPraV5QWsoNG
         SBVreYtSoVn67SnXomtxoL21oTQPcReX/JyaBC4gXCRUVfWyyBg5RQIJFtV/evkBdqQ+
         aOCzC0anew1K6Un95pd1Upyn/Mp6GLeCPtyVIFaxhDSW8yOsbAgvUJm/gAZEP1N8M3lR
         GYHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7pwcqROEnaY1oEKrcZMFFW9Jr1+94X7n9fGcap3ZtDDfhE3lTH3QXphi1CA0HQEkfjgSSpUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKrt6S3P+43IHpYQDmayWhrxEejBZSFvHDtw0v3cFVpK689wtL
	8DXPxCXtp5Q2toWXX250ytWvFkfHLXTw/UvC+J1QCVYERRXyNkSqLvEZpkKQS3pneH1TzUkn6MW
	f7WORm5q52y63qRkxic4f1z4JRxrt4Iw=
X-Gm-Gg: AYBFou1h7TCPVYjX0V2i1wywkM4NJRh9KQ5PUEnK8nf0JzWDgPu7yDlPOVTjQJnME+o
	fXWfRtSULBMBUJBRh0AAptRNhu+e3tDGlcaFb6WLVML8oMTzxEgVk6eASxHkchTxGtSg+eLQrir
	bwYQl2PcX/3gptu4Jvn+0KJB9WhSu78qWSX11zB2MjdJUIMlbE/DXM3vQiaQZawQ9X2NQXnfOSw
	Z+2Ga1IT5nmh4PII5VnkQs5cCMgQDuaf46RFa5YhoSZSosP++ix/6ys94CK4xEPRTwMMcg6uXsp
	Y9xiN//D0os0cKA2XPvC5inci8Yfv9aklZvvTOVm+g144Im0+bj+w1wwJivdfS3LNQuhbbVqMSF
	zPbVwqEfrFXLbB67T6DxpmN37Ax+lGNsmH2tsB2opwg==
X-Received: by 2002:a17:90b:1d4f:b0:3ab:be66:ddc5 with SMTP id
 98e67ed59e1d1-3acef4fda1dmr12483438a91.6.1792432933217; Mon, 19 Oct 2026
 11:02:13 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153942.4067-1-leo.liu@amd.com>
In-Reply-To: <20261019153942.4067-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 14:02:01 -0400
X-Gm-Features: AclHuK-Hr_TiHi7B9j25lZ-SyOtwCmY1t6K0AhTjKN3tb5gC86EVsG2kNO6g25c
Message-ID: <CADnq5_PZBhnJXza6Y7KRTGaM-p1iGOMmV_ST70T+wuxf6rj+vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: call hw_fini for IP blocks whose hw_init failed
To: Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:06=E2=80=AFPM Leo Liu <leo.liu@amd.com> wrote:
>
> When an IP block's hw_init() fails, amdgpu_device_ip_fini_early() skips
> its hw_fini() because status.hw was never set.  For VCN, UVD, VCE, and
> JPEG this leaves their idle work queued after sw_fini() frees the adev
> state the handler touches, causing a use-after-free.
>
> The bug was reported on MI355X after unloading GIM then loading amdgpu.
> GIM's teardown resets the GPU, leaving VCN unresponsive.
> amdgpu_vcn_enc_ring_test_ring() calls amdgpu_ring_commit() =E2=80=94 whic=
h
> schedules the idle work =E2=80=94 before polling rptr.  The poll times ou=
t
> (-ETIMEDOUT), hw_init() fails, hw_fini() is skipped, and the idle work
> handler fires after sw_fini() against freed state.

I think it would be better if hw_init() cleaned up the idle work
handler in its failure path.  Can you cancel the worker in the vcn
ring test helpers if they fail?

Alex

>
> The ticket (Link below) suggests cancelling the idle work on all
> failed-probe/sw_fini paths.  This patch takes a different approach: the
> idle work cancel belongs in hw_fini(), which is already the correct
> counterpart to hw_init() for hardware-domain cleanup.  Rather than
> scattering cancel calls across sw_fini() or every IP's hw_init() error
> path, we ensure hw_fini() is invoked for any block whose hw_init() was
> attempted but failed.
>
> Add status.hw_init_attempted, set it in amdgpu_device_ip_hw_init_phase2()
> on hw_init() failure, and check it alongside status.hw in
> amdgpu_device_ip_fini_early().  This causes fini_early() to call hw_fini(=
)
> for the failed block in its correct reverse-order position =E2=80=94 a si=
ngle
> change in one file that covers all IP types without touching any per-IP
> code.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync=
 call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index b74f9136aa2e..e267fb3774c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2233,6 +2233,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct a=
mdgpu_device *adev)
>                         dev_err(adev->dev,
>                                 "hw_init of IP block <%s> failed %d\n",
>                                 adev->ip_blocks[i].version->funcs->name, =
r);
> +                       adev->ip_blocks[i].status.hw_init_attempted =3D t=
rue;
>                         return r;
>                 }
>                 adev->ip_blocks[i].status.hw =3D true;
> @@ -2902,7 +2903,8 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
>         amdgpu_device_smu_fini_early(adev);
>
>         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
> -               if (!adev->ip_blocks[i].status.hw)
> +               if (!adev->ip_blocks[i].status.hw &&
> +                   !adev->ip_blocks[i].status.hw_init_attempted)
>                         continue;
>
>                 amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.h
> index 5dd6273982c4..bfa27ca05dbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -99,6 +99,7 @@ struct amdgpu_ip_block_status {
>         bool valid;
>         bool sw;
>         bool hw;
> +       bool hw_init_attempted;
>         bool late_initialized;
>         bool hang;
>  };
> --
> 2.43.0
>
