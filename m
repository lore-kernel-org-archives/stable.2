Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2D1BD9D0
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815737; cv=pass; b=tCsf5oeLYgX8rGJvbcmyPM4wS00DXERQklNNSGohXkiO7y9oHqhMO5e9slv0FdA4jvZBzfEDVrXGXkaWxcKUSnlddl5DnwGs5Sy/7oMP3hgdwJ7b+ApguCd5NVjojAw0aIZOfjs2oOUNcIQ2yEx2IPrEmhmXUFd7+8Ex2IKThIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815737; c=relaxed/simple;
	bh=bByw82JDW+jqybuuMhYcN7brXCJg3RksqvUBCfrdXss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTz79jlLWnWJgUaUXK51cPwIxm4xLtkPGiYRjgHsk11RSyLqVnJFqHl8nhr7TtWe0w6hik6mJ92nI9xZ7SLtKrfrxOkk2czPe0GzhmKd8odgcJ4NZH80Zpc/Imr54ugPKqjMtNZE+Hl+Eu0IAPoDQFSi8jpI9YrEuVOmMGzXTUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAbB2LNd; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAbB2LNd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c169ae1cb26so360150066b.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 04:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815733; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+VeovLUNX1YEXrCX3+nHnNmzI6ux/I1AeksXH66Q8rfCGWkSp41nXUEMf3Y/KKBAa
         it3MRLCSX0DKaSZ5Bo7xlnW7ISvJWi/8t34OijyiP69N1UaDxjl5w9lzX8NGgsCXSQDK
         XsfO5qtuqw3/z0c6gmqViyW+LegLnL+lxYZuo6wg6gEckvS4ht+uDUvoqupy+MvFb7dT
         SlJELlVtj1SPmGybErG9i4mTJ3VvT0ixVgggAVvH9lEH2+HGQSK4LLxPceQPdanVwwMP
         Hq+MIICRdfYoub+qAMSdpEVFAbcc9fnhVw+4Zjf4MHO1ih4o5qfM7n4ZUs5n7Lec2hHD
         HdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        fh=uiMGrxOt8Q0Y4obMymLU4x6bOCfaVBAgBHqGdsz/l9o=;
        b=VuzrZOj0sWPPp5cIdPKEjw/XcB3R2WqPmD9pdp18rWCsx+JtKQOaFTTj/XCYnWv7VA
         RUNxcylHXfh8LwxLx5Aldgb0tESpp2jaU6Al0u4FBrvtlUFlhKRjUbGdMJJlOnp3edzx
         /svQ3lkC7nSMVOjq8MgmlvzfbVyarAY0CEqvvH6abfb8mm5n8Ze2+R8AQw9A+W+NpK+4
         zSmScI99KZjpbYv8Ll+PWIwgqrc2UPTkPloyqyh68aDgFOX4GvZdD6DXspao0fzjeCAI
         sSqxQDlGWQ8ClG/gtsHAR4tFcWMej2yIoiZiSqo8cJEl6gXAropn7iaEyQQV8pXCjeU/
         MlFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815733; x=1790420533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=LAbB2LNdX2ZXU95IudQkd50Et/wrIRK3vWTqrdvl6aJbMlY73Zip5VxDj+5MHHbIeB
         o3k8aPzxr6PxfSTLdkO64Hb6Githl8YyUmdVfbH/rosHNPivY04s7QnO9Ym7CdmcVZao
         lda7r/3UndP/cOU//mPBdBiXaZZ8Kse503u4xG0cuU+Elb9aH8ElhtbSboBnrX5BeG9T
         A5CiwMUKiCsPtvHZMtOKviOiy7pvoRYOXMxEZb4WPuceg7P8lMok/cjmEfGMBJENyQZI
         6K4sEUD0E6IPuazC8Zuni+CDE5F3N/e4mQhp47yjKR59TDf8r1dtPbsS2TckgOjhndAn
         m76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815733; x=1790420533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=zAe/M1uJpEoyQQwNcuz14dXyiJVmTvXc0FoPeZWwS8zwCPvL/DXAe6hr+8xv7W+lXF
         /OcBDhYS0m8KucSY+Krzj9hiI84c7iTKgdgpwA2USpeSlGkdGP8JQYsyu5AW7l2zUAjU
         cw5Cmmv6pTikV239x1fR/kNshQBQvT7ZWty6Rds+VqV6B6k5YPZIAAmbIAJD8EACLttn
         oHmLo8vKfqHJoQRLxoOBxpacUtGkaGbcfDgvlIMD/nOx2je/AdDFDTXRXREPAjW8GJX6
         ASp3yU4Bb0btyYZ5zjc5HRT50Z+QexchpHJSfSDDXLYRJs2AKG5n+WLOY3brik5/MVmy
         4W5A==
X-Forwarded-Encrypted: i=1; AKwUvBwweyzwzEipmjHRxsFPbRzfPpKKr2rvoXhW6CDZYpalagvdKWRP3mC2HEvsiCmWbRf5gHPWtXg=@vger.kernel.org
X-Gm-Message-State: AFuF++najWK3iY2omQDxG5QmsccNrRtJh2+FX2c7xOoP+ywkiCzujMh4
	HAhXiklTUFPQawrCEXb1wYdOOMHtGDYNmAQ+f7vySe4DEPxqNi8pJex/iN0NeOBCaAJcsvxqBT1
	CiA5kvZOLutWwOG8imUgpz9eJHiw0IIQ=
X-Gm-Gg: AYBFou0y2qtX1FD2YLt7MIAHMQ55JQwt6ismnPU59R9WGBshmq4HbLyjiEac/QyvpXi
	m7JdEXsje+BFoKHw89KgLYOrLD3rrJQh6eDvZ7ol8RJOibNJfqnbyxDZ0n4Fa0cVbVjDJOi4fRF
	JBNahb62EpeDcGnR0XcqyfB8BX8XZiRv9GPWq84+LGYCi5FWO+38CxirpBNQ4ov1WGcsF5vFNng
	sMxyHhlI8D4ZzSVg9RmE8ihQ8Z9IUnnQ51dfVronRbMdj40zZjmFj/Vvt/2tGjcvcyyEGzKFivN
	CsjJ1UnquVBKH+RSSaQdfX0NkMPsnnvNVRoz7LBxlrbJ15VjZaDqJMRKrKDEQqZlgAS81XEg1O1
	slrkU+Y2JCV6keNDFxNFOQXA=
X-Received: by 2002:a17:907:3ea4:b0:c29:6bf0:eb5e with SMTP id
 a640c23a62f3a-c29f5228faemr859476166b.2.1789815732565; Sat, 19 Sep 2026
 04:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
In-Reply-To: <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:01:35 +0800
X-Gm-Features: AcwNN1UE85QfdP_kbjc-baoQeq67vzozL6doVAA_AiHVQ5JgKm4qrrP1ao7fCOs
Message-ID: <CANgPUi3zTjaK5W3mp1-xoLoQmRmqvwMaG_68cNXN0gHmvp02GQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	stable@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=881=
8=E6=97=A5=E5=91=A8=E4=BA=94 01:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/18, bestswngs@gmail.com wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > __bpf_offload_dev_match() falls back to comparing offdev pointers after=
 an
> > exact netdev mismatch.  Bound-only programs normally have NULL offdevs,=
 so
> > unrelated netdevs compare equal; one loaded on an offload-registered ne=
tdev
> > can instead inherit a real offdev and match a sibling port.  An attacke=
r
> > can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
> > metadata kfuncs specialized for the bound driver on the target driver's
> > xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
> > stack xdp_buff as a veth_xdp_buff.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017=
]
> >   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
> >   Call Trace:
> >    ...
> >    tun_build_skb (drivers/net/tun.c:1739)
> >    tun_get_user (drivers/net/tun.c:1856)
> >    tun_chr_write_iter (drivers/net/tun.c:2091)
> >    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> >    ksys_write (fs/read_write.c:739)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Restrict non-offloaded programs to exact netdev matches and retain the
> > shared-offdev fallback only for genuinely offloaded multi-port programs=
.
>
> Any chance you can also add a testcase for this under
> tools/testing/selftests/net/bpf_offload.py?
>
> > Cc: stable@vger.kernel.org
> > Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> > Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/bpf/offload.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 0d6f55695..8c91d00d4 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_pr=
og *prog,
> >               return false;
> >       if (offload->netdev =3D=3D netdev)
> >               return true;
> > +     if (!bpf_prog_is_offloaded(prog->aux))
> > +             return false;
> >
> >       ondev1 =3D bpf_offload_find_netdev(offload->netdev);
> >       ondev2 =3D bpf_offload_find_netdev(netdev);
>
> [..]
>
> > -     return ondev1 && ondev2 && ondev1->offdev =3D=3D ondev2->offdev;
> > +     return ondev1 && ondev2 && ondev1->offdev &&
> > +            ondev1->offdev =3D=3D ondev2->offdev;
> >  }
> >
> >  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *n=
etdev)
>
> Why also have a null check here? Why doing !bpf_prog_is_offloaded above i=
s not
> enough?

Hi,

v2 and self test sent. Thanks.
