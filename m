Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794438385;
	b=EpBLZISNd3/GnE0+SfJFIiYxm5qyB/GkptQovvpcng46f+QNkKj7mmNDeizi6ilsSRoO
	 EYDdql56kRSEIZhauuQA+vWa4WpiXkEcyy112Yk79eP3h5orreltkgBiBulA7aFVTZDDk
	 xKQ+HMd8Z9Ackl3jvaw5XJCApHrNTp0l9ONdlW2MRRxBXLklf/8075rV1Me5Pw52obL/t
	 nHFBREiU5mJe9h3rMn1p3SEpoi/wiUGCR/RQvC8u+rLU92jnYij3WI/QwqBMsf16Id+LA
	 unukbVdL5UyMAYmbgPMkBhmiugWQkQgGp7PLCdYmb3ifPFZiwsb4D8gSfikUN3ZGeNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UBAHlhDi5WQPAtUaYtX9EVzqNVw4F9k31X3Owyz2mLA=;
	b=JYLUszjPyrhyPqpNhFrgzGY/vS3MbKmOnCF47PemSGo+lGFkHFzh5MQEGYqlp1otWwlb
	 sHo7M4iah++HyOX8mStGadiSo+Zg0dO8gKEew9JsegSudtrnuap3xTueMZyCps3tCxoBH
	 CJb1WE2D075+TgaYVfBLkAswvf9lM6WINYR3NIzvQvQYr+unUTd4WIXz9Lg0W26fhiMR+
	 AiGUxqMXUxMK+uNZukosF5aah2K1kA3Bm0VIjIdQI2FRtx4QwLg+YxJj+0Dtbfb0Huc0a
	 j41/cdQshudXV6K65EU6isCvGoZq1DXlbkkm5BETD9Cy8bRBsNA1Mb/5Y5mSt5KCLRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=nuU7BGkg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3F606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC3F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=nuU7BGkg
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so4839341a12.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794438381; cv=none;
        d=google.com; s=arc-20260327;
        b=cvQuC+V3VfWv/mhpXP4nQ7diCAfe28RAnddX/lDorT/JmyeBwO0ZOUtSuhgEEmuydk
         17tN9Kdf4Cb7dmIbY1BAb9IHw+OgPeaM24Ik4jQuCn76uyS56EVOw3iNjYWewL+Tt7Wh
         1Fjhhf/fDag3jnL4IICkAMa/LQtcak+ADwbW7Xhc5gNDin/wFOqLTM01ayNodVMdVOQ9
         w8kzxm4M7BcoQfUkyLkrCX7onEh9FwdCcmnjPrhmsn0p0ImSs9cGeAO1h6tmqzgfaUOn
         4y9AylWfXYebOyDZweTkJ1nQhXsyqUXFQVaWXXM5zUG/qBLDbPG6Gm5mcX36uCbKqcbk
         jjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UBAHlhDi5WQPAtUaYtX9EVzqNVw4F9k31X3Owyz2mLA=;
        fh=bMK/+tmPY5nChx9lF4Ot7Bva0ZVDzJS1nZ+atPDwogs=;
        b=Wn/Nz4NGtpT/tYvxBOO6aiMl4EgKxhHM4waY60HTLNrDZpnMCUVnw0/CfXa1dqeFSV
         +9BRm+xYWnZtQIScY1uEne35AhnYm9bUTcqv96JQxzLlKz5NiXvXOMHUtgDARnh7pd+5
         wccD5lCpfli2s2gbXc2HCa0+I2j41HEZ9PbLF5xRLNAP5znffIVgTlN5JSxgnu7fXfs8
         zJ9r5U1fOH3BC3gKVt+i7Wtzu+X0E00+V5hkUrsC/QvzzbEcdFi0Duq/veC5afPBhS44
         mUVd7RoeLxLIBEVH5555cXJZjQhG9v48mz+sttr/mxvYl5LGr8d77XeRax32AWT0D+VG
         xHZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1794438381; x=1795043181; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBAHlhDi5WQPAtUaYtX9EVzqNVw4F9k31X3Owyz2mLA=;
        b=nuU7BGkgeaBonrt8SiDqzF42Ei7Sj9iRF0pQx0xNoYjkaeJfIUegbcAFZP23/jDlfn
         f/TjmBk0tZ3jzNTo61K/YOkV5OaIT+VENaOUS0OB1yhiK3HjlARMEsdbeT+1WdrTDABo
         LLGSdkG49e0VBARKd5QqZcAM2BpayfoI5AjvoIrQ8MK7xlN7rY6sIE4+yZgRrwxNQVuq
         Od6EaykX2Bp647jWK/q0Wt2YGhhclT2esYQzGg/JMQ7IBeQExgEEpMH+CVwbxjggC8pw
         D7XXn3A1OcIVpxsb+Gv4edqs4ke2WWLGHfLLcW+jXrEi1nB+dhxN3j+3XIBhD0uNCvY2
         AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794438381; x=1795043181;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UBAHlhDi5WQPAtUaYtX9EVzqNVw4F9k31X3Owyz2mLA=;
        b=w2JictNMvcWUvdoLYGiXRypjXzEelBagj8bmFfpDhS98yvDBQL+v+QwGJsOz5NiYS/
         QtOmTkpZw1Qss2YDjBLnPMhVnurU20KQ0HyHV5ZvpWdMx2XwBRngfojhSq/wiuTYtNdp
         K6piM9PKWKe6w4VeeL4HqP5MeL6jY5rI1/30fp5hpGkwDVvqgAR8SbJpguysk2DjoAST
         llw0tAyU76jH6O6O88pTgiSZbKMq+rdxy1/nTWKRm+5yigQYYp4SEMFCeE535vu/ijku
         SlUUX+uzqCN7A1seB5FMb7s/BI/PgFGDNs9qPiH93esYuw4mzBu68oK1mDlq9EdWvCNt
         Ia9g==
X-Forwarded-Encrypted: i=1; AL+hErEfigUvqDW6Wt2J/B16FiUgySwJTaGk64zJvK1W5vznVVdEQ1JOV1dHtMR542uFgKyfyI9Qpy8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/baOqbO+AYS2DOUhHDOcoDc2wh3JnT0RlcTzoj8zZfOiLLd6cw
	DvcY55bKl/ebJGuUKKLABLH+wIw+AwCBVsE5PA4W5xL0Sb4tWTSi7NJkuJYF/0xfvfHLMSQEmeE
	bUDJsSnWLKIggKPal4OZTglNdAu2H4ytnMhYnCJg0VQ==
X-Gm-Gg: AYBFou1/KBdLZ5ncDW/cA9z95QJ1ZyNT4AGOc6J02mMHXxl/rrYtcCIssUXYUmCweoi
	0YQlRR5DLDjznI8NTgQvzrh5r+0Wi1DRRfXIuew2KIK+Fp2HXn6U1ma/Ckz1XIzHvyRw6TKGVr+
	HzgQ8mE8T74ara4hSIBuw85fv5cZCFWMOfkPNadldisOm+T/0/TCeNhbJtFmV5FjR0PEhCfXB0f
	FOuKOvKAz6xvI9gYRdXi2EixCv52NVduRsE+3mFL/XwZRHHvCInRdgpSy5PF+2jxu25B/XxgKkQ
	+2mQvrR+X0oLRqY8QS3EcLl6bEUh9lZmZboz4ohDaSCOKwJArV5BYHiOiuiELcZorNtd1ej2aHs
	+1HMiA2pil/cWrvoi/G0Y7CE+PrFGE3LcU72Vcjg=
X-Received: by 2002:a05:6402:2110:b0:6b4:1037:2b87 with SMTP id
 4fb4d7f45d1cf-6b7778161f1mr2989176a12.31.1794438381548; Wed, 11 Nov 2026
 15:06:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111113029.959595-1-max.kellermann@ionos.com>
In-Reply-To: <20261111113029.959595-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 12 Nov 2026 00:06:09 +0100
X-Gm-Features: AclHuK9aye7AVhvzAeKWqenEAyLYJI-Y8Iege0JrFoT70qCLwujofRbt6K_kSvU
Message-ID: <CAOJNxR+fkE3LigjhojZzk-XOpOBpT-2mqe5ky5ho91TmyFmpxw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix d_lock leak in debugfs mdsc_show()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Max,

Good catch.

I reproduced this on a KASAN + lockdep 7.4-rc1 kernel against a vstart
cluster.  The real window is only a few instructions wide, because
ceph_invalidate_dentry_lease() takes dn->d_lock right after d_move(),
so I widened it with a test-only udelay(2000) in ceph_fill_trace()
between the lease invalidation and the r_dentry/r_old_dentry swap,
plus a 50us delay inside the d_lock sections of mdsc_show().  The load
was 4 tasks doing rename() back and forth while 2 tasks read the
debugfs "mdsc" file in a loop.

Without the patch it locks up within seconds.  The check in mdsc_show()
fires first:

  mdsc_show tid 229 op 4612 r_dentry changed ffff888209d8acb0 ->
ffff8882939b92e8 while d_lock held

and then:

  watchdog: BUG: soft lockup - CPU#4 stuck for 26s! [cat:30609]
   _raw_spin_lock+0x73/0x80
   lockref_get+0xd/0x50
   ceph_mdsc_build_path+0x23e/0x1560 [ceph]
   mdsc_show+0x242/0xab0 [ceph]
   seq_read_iter+0x2e9/0x12d0

The ceph-msgr worker is stuck in handle_reply() waiting for
mdsc->mutex, which the reader holds while it spins.  So this is the
same leaked d_lock as in your report, with the two CPUs arriving in the
other order.

With the patch and the same delays, 120s and ~6300 renames went through
ceph_fill_trace() with no warnings.  bpftrace showed mdsc_show() taking
1-8ms, so the readers really did wait out the window on r_fill_mutex.
A further 180s of renames plus fsstress without the test delays was
also clean.  lockdep stayed enabled throughout, recorded the new
&mdsc->mutex -> &req->r_fill_mutex dependency and reported nothing.

One side effect, not a problem in my view: a debugfs reader now waits
for any reply that is being filled (including readdir_prepopulate on a
large directory) while it holds mdsc->mutex, so it can stall request
handling on that client for that long.  The abort paths you listed
already do the same, and this is debugfs, so I think it is fine.  If
anyone cares, mutex_trylock() with a placeholder in the output would
avoid it.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Wed, 11 Nov 2026 at 12:30, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> mdsc_show() walks the request tree under `mdsc->mutex` and prints the
> request's dentries like this:
>
>   spin_lock(&req->r_old_dentry->d_lock);
>   seq_printf(...);
>   spin_unlock(&req->r_old_dentry->d_lock);
>
> (same for `r_dentry`).  The pointer is loaded again for the
> unlock, but ceph_fill_trace() can change it in the meantime:
> ceph_fill_trace() runs with req->r_fill_mutex held, but not
> mdsc->mutex, and:
>
> - after d_move() for a rename, it swaps `r_dentry` and `r_old_dentry`
> - splice_dentry() replaces `r_dentry` with the spliced alias and drops
>   the request's reference to the old dentry
> - a lookup without a locked parent assigns a new `r_dentry`
>
> If an unsafe rename reply is being processed while mdsc_show() is
> between spin_lock() and spin_unlock(), mdsc_show() unlocks the other
> dentry, and the `d_lock` of the one it locked is never released.  The
> next attempt to lock it spins forever.  I have seen this on a
> production server, where our monitoring reads the debugfs "mdsc" file
> periodically:
>
>  watchdog: BUG: soft lockup - CPU#67 stuck for 48s! [kworker/67:2:3746175]
>  Workqueue: ceph-msgr ceph_con_workfn
>  RIP: 0010:queued_spin_lock_slowpath+0x4a/0x240
>  Call Trace:
>   <TASK>
>   ceph_fill_trace+0x7a4/0x910
>   mds_dispatch+0x9f4/0x1ac0
>   ceph_con_process_message+0x66/0x80
>   ceph_con_v1_try_read+0x392/0x17e0
>   ceph_con_workfn+0x329/0x590
>   process_one_work+0x146/0x2b0
>   worker_thread+0x182/0x2f0
>   kthread+0xe4/0x1d0
>
>  watchdog: BUG: soft lockup - CPU#55 stuck for 49s! [cm4all-kernel-e:16346]
>  RIP: 0010:queued_spin_lock_slowpath+0x1a2/0x240
>  Call Trace:
>   <TASK>
>   lockref_get+0x47/0x60
>   ceph_mdsc_build_path.part.0+0x85/0x2a0
>   mdsc_show+0x239/0x3e0
>   seq_read_iter+0x11f/0x480
>   seq_read+0xfd/0x130
>   full_proxy_read+0x50/0x80
>   vfs_read+0xa4/0x340
>
> Both CPUs were waiting for the `d_lock` of the same dentry, which
> nobody is locked but nobody will unlock it.  The first CPU was in
> update_dentry_lease(), called after the rename swap.  The second one
> was the next read of the debugfs file.  Since the ceph-msgr worker was
> blocked, all requests to that MDS hung.
>
> Replacing `r_dentry` with a spliced alias also means mdsc_show() can
> call dget() on a dentry whose last reference has just been dropped.
>
> Fix this by holding `r_fill_mutex` while mdsc_show() uses `r_dentry`
> and `r_old_dentry`.  Taking r_fill_mutex with mdsc->mutex held is the
> established lock order; __do_request(), handle_forward(),
> ceph_mdsc_wait_request() and ceph_lock_wait_for_completion() do the
> same.
>
> Fixes: 76aa844d5b2f ("ceph: debugfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/debugfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 6a9a5551d9d7..83506d9207fa 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -109,6 +109,14 @@ static int mdsc_show(struct seq_file *s, void *p)
>                 else
>                         seq_puts(s, "\t");
>
> +               /*
> +                * ceph_fill_trace() may replace r_dentry (dropping the
> +                * request's reference to the old one) or swap r_dentry
> +                * and r_old_dentry; it does so while holding
> +                * r_fill_mutex, so hold it while using them.
> +                */
> +               mutex_lock(&req->r_fill_mutex);
> +
>                 if (req->r_inode) {
>                         seq_printf(s, " #%llx", ceph_ino(req->r_inode));
>                 } else if (req->r_dentry) {
> @@ -151,6 +159,8 @@ static int mdsc_show(struct seq_file *s, void *p)
>                                 seq_printf(s, " %s", req->r_path2);
>                 }
>
> +               mutex_unlock(&req->r_fill_mutex);
> +
>                 seq_puts(s, "\n");
>         }
>         mutex_unlock(&mdsc->mutex);
> --
> 2.53.0
>
