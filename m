Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007962;
	b=rGEcQ8vN6X3zcI3OSVigRyoleLqTMJAues604jP/HWkqcVl3wvQASOGApjAeRJ3j/5Gy
	 h4oV9E+IrBD1Yhb6mbI50NSrCHSDIhPpb21bdTTa04+zy4i60jPatltGcFMDwAAQ4o36z
	 HHvdM+9QorR1tz4aZ6FIFeBjiPgR0EzYP0IJfnI0EUUNv2aflbSD0QcKA1ghlS+9jG75B
	 kC6o4DnHL65bJZ+f8GKuoKsc9dcA3PFIqXxnKge0l3B5crEg4tfY9/6iL2R2SapdOgCZR
	 EwfxfbYNPNWU9QUXqcY1xoGkGY6khWCfetY+EofcWS278gM9IcmKIqq96qlGX1lAF8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7B46hQ2LzHivCNssq7fei9h39fR9NiIAQnJM4ohrCJk=;
	b=iBweD+hN2EiF7mPWX1p9mhLI476qLQy6CULa9IpUwKxxiU9yTPE/HgmCFaxyW8uWuwXZ
	 8gaog8i9qlug9zU+NDRPyrGVVu35b/PTB+F9HMogx8NP8Hu1VSiQtDh59By1XFtH8bZiT
	 3dwGqb6dbINaiUCxymEdPM+A7NK/ffGyXzI0pM4tYYVOyIinEHhzvdT803ad8DPKHbK0m
	 PFRt7z6fqpCmch5lqK0WHp/xdVFHelxQuXJT/05bgm2XAUpW77IDXM0WvFchtuHIP+7Vc
	 2O16fjNbvmkOc0bJO8pcx55eH/U10YX3IJafTBpGdIk0VFUBmUEl0MBKlTfGWgZbbXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OfZTmcXH;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD8606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 23:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AAD8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OfZTmcXH
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso185034266b.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794007960; x=1794612760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7B46hQ2LzHivCNssq7fei9h39fR9NiIAQnJM4ohrCJk=;
        b=OfZTmcXHxJq/n13bRgHPNOHS6D0LZ+8rpQXF16QPMaYOFnylYTcR9GpmiWt4IkfuvP
         ijKRPCA/RlJW3wmq+Lv543UVCf6Sq1NkszsTxWAYF9jAWa36srWiKSWEtWgCcbmlpKFM
         7KpcuNA+Alwh5DDql3oDE5sxig1WGLZ2pMDjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794007960; x=1794612760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7B46hQ2LzHivCNssq7fei9h39fR9NiIAQnJM4ohrCJk=;
        b=iFkhdD5NgNwmhoDIzBW+lIlwalL+3Iwg9MPOicw1IZ9GeM+YqlM2LUvXw8OIujzI2u
         IKGecNtu//WfCNnFAJLhdzmKrq0cPYuRLEYjCpJXL4peIvscn+0S6TRlVASz9EpVRCzs
         An7QIFe36AeHba7t5SnzFgWCCTgZh3h4BEyJ5CMJ+YY8q6Jcqi+2JOl1O5KZ8MggUB7f
         19enwJBOTvZGSv4mmZVnJSIAZvSIKXuHF6J29/SgTJnoRrF0DR9yLN3emrMQ4OUk6CHT
         M5wnkl34fqXcTZCTZfwc6S/WMNuwp8o6OdNYypsq02JiMT+Tez2Es3n0BY+xSbQgqLeo
         pDPA==
X-Forwarded-Encrypted: i=1; AKwUvBxuwuC9cuzlVkrT38R7UxQmm/kGwRzrYf+tYZN9LW/KsaC/pxZW/DEfKm0nj2i4RUklSozTsXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+P914vmwZg9E5ZwtbvHFfJilM+ZmPyVc8690fn3IK6eNHS7Qw
	K/8AlNnF1MYHET+UkJFpQi/05JgWMeO01wIKvX1NmK+jscDhmhrkXXKc5RnJUlhkrcAT+QR1iZI
	W/ghgpvSu
X-Gm-Gg: AYBFou2g5T/rJEgKH2t40ntuYN2o/xDvNO99QsSlSNKaBpKi0J13nTZF+PsF74BOr2j
	8r7aaF2gQyNcKjPludlbq2G/eDtxaOY7GWboUH7cs02cIdFajK3v0P+5cdqnh5xT4wMp2YjFl0m
	1ehfxi9bNQP1Gaf9Y9snNhDgiW/G9cYGy0hGdm1csAU7Cs+UV11bri0Sy5xj5FSfYYcYJYxYD/2
	Sm1rCy+Gm/AYuqdgYLPORE6WBwT/jKf+Oyw2+za6wGv3EZBUIlTQTglmZ4l8NsqPJ8VzeUUVlkb
	XWI+MqppI94vdZlENbWJosUBmvAC7w/FjTmYgeaFllEDmApw+KmEZ7Yj41WX6mCTBB6meTz1Lhj
	bwzLu/7pHGtmGmpTS1A66zNCMGm20hsDmMID2sCAe9kkcLQXTyvYKE0vhdfM2EFPZ72hnRsdUG5
	rIR9sP4K8aAS1Wn/RG7jMaZcH/Vu9rc6UGq8Yln5ltYUkqooInCYK++rHiGhSbJG3YQoOVY9ssc
	hD3tlWXmFHaF1YRnu+j04VbRpQM+CvIMHraGiLFVLK/jihLKPu5rc2xIZKfHLzvj3oj+z9GLelq
	NnazGQRyoI2ikOUC0y9/iTdhAZLUZ5egKllEyoBWg/f5cQzu9Zu94j64K2DxC5th8L4=
X-Received: by 2002:a17:907:6d13:b0:c4d:2895:e492 with SMTP id a640c23a62f3a-c4d354c5b41mr351435366b.21.1794007960035;
        Fri, 06 Nov 2026 15:32:40 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c5b76sm113329666b.68.2026.11.06.15.32.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 15:32:39 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4919a880834so655259f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 15:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEpX5ZeI3K8Py9aft6wjgWtK0uMqAAEMdfpSiFmxMsQoiSfMpOUTHQd9EKQKjl8e96BWmki3HE=@vger.kernel.org
X-Received: by 2002:a05:6000:2681:b0:48b:e50:7159 with SMTP id
 ffacd0b85a97d-492753729f5mr8115289f8f.30.1794007958300; Fri, 06 Nov 2026
 15:32:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103190622.925741-1-christian.aurichzm@gmail.com>
In-Reply-To: <20261103190622.925741-1-christian.aurichzm@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Nov 2026 15:32:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V_M-TkHo4y_FgdAA5_X=cAp9ePU1mFmX1gfDpr5U-Ytw@mail.gmail.com>
X-Gm-Features: AclHuK8jrSmPQAiT7lk0B4ysq3fyK3cFmyMrzdbG9LbUvSIR5DVI4rvhaQqLsUA
Message-ID: <CAD=FV=V_M-TkHo4y_FgdAA5_X=cAp9ePU1mFmX1gfDpr5U-Ytw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix buffer overflow in the qfThreadInfo packet handler
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jason Wessel <jason.wessel@windriver.com>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 3, 2026 at 11:06=E2=80=AFAM Christian Aurich Zanettini Martins
<christian.aurichzm@gmail.com> wrote:
>
> gdb_cmd_query() answers qfThreadInfo with a thread ID and a comma for
> every online CPU, 9 bytes each, followed by the first page of tasks.
> Only the tasks are paged, KGDB_MAX_THREAD_QUERY at a time, so the CPU
> entries overrun remcom_out_buffer[BUFMAX] once there are enough CPUs.
> On x86, where BUFMAX is 1024, a typical boot hits this from 109 online
> CPUs (222 on arm64 and riscv), and GDB sends qfThreadInfo as soon as it
> connects:
>
>   BUG: KASAN: global-out-of-bounds in pack_threadid+0x2a8/0x2e0
>   Write of size 1 at addr ffffffff86eecc20 by task swapper/0/1
>   ...
>   The buggy address belongs to the variable:
>    remcom_out_buffer+0x400/0x420
>
> Page the CPU entries together with the tasks, so no reply holds more
> than KGDB_MAX_THREAD_QUERY threads. The CPUs still come first, which
> scripts/gdb relies on to detect KGDB.
>
> Fixes: 25fc99991383 ("kgdb: fix gdb serial thread queries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gma=
il.com>
> ---
>
> Notes:
>     Tested in QEMU with KASAN and GDB 15.1. Unpatched, connecting GDB to
>     a 109-CPU guest gives the report above; patched, 109, 128 and 255 CPU=
s
>     return the full thread list with no report.
>
>     Based on v7.4-rc1.
>
>  kernel/debug/gdbstub.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index fc6a7a8c1f6e..02f27e70993c 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -752,15 +752,20 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>                 i =3D 0;
>                 remcom_out_buffer[0] =3D 'm';
>                 ptr =3D remcom_out_buffer + 1;
> -               if (remcom_in_buffer[1] =3D=3D 'f') {
> -                       /* Each cpu is a shadow thread */
> -                       for_each_online_cpu(cpu) {
> -                               ks->thr_query =3D 0;
> +               if (remcom_in_buffer[1] =3D=3D 'f')
> +                       ks->thr_query =3D 0;
> +
> +               /* Each cpu is a shadow thread */
> +               for_each_online_cpu(cpu) {
> +                       if (i >=3D ks->thr_query && !finished) {
>                                 int_to_threadref(thref, -cpu - 2);
>                                 ptr =3D pack_threadid(ptr, thref);
>                                 *(ptr++) =3D ',';
> -                               i++;
> +                               ks->thr_query++;
> +                               if (ks->thr_query % KGDB_MAX_THREAD_QUERY=
 =3D=3D 0)
> +                                       finished =3D 1;
>                         }
> +                       i++;
>                 }

While I'm not an expert on the gdbstub, this looks reasonable to me.
One request I'd make, though: can you unify the CPU and thread code?
Something like:

for_each_online_cpu(cpu)
  append_threadid(ks, &ptr, &i, &finished, -cpu - 2);

for_each_process_thread(g, p)
  append_threadid(ks, &ptr, &i, &finished, p->pid);

-Doug
