Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64210301465
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190661; cv=pass; b=j+vPJxkUBdVhrLvRpITgoDRHpYv3cVkjOtklNdzW20h/23NdxaTko0HyKqLgaTs3TkqFRNV2Ml0Ty6ap2hwfO0v5/yMxovJ4sMU9HuANhBRlB7ekxjQezqImkd0Skfn6zw77DHBW/slewtMN6fGOQqwXjXvExM+qq527aayw80s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190661; c=relaxed/simple;
	bh=mqba1T9nauxNnwYVB0xz79JPbzcaMr3EFsx18vTPUkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnpOtWj6zRq/IOPJkXzr1ow3BnXyvjjcUamKwBrWdIOHPuM6FSHG+Pl5614Ld8LVYdwndRH4zOkAEvswzhvgPKo4Yjy3WVqKP+fVTwjJFXh15UZ6KmQVtFVzrT1nMsTLBjmKzybVxyG4tjJIcYE7Vd8lACWV6jE5c6ZFKi4jXFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVFpcKSG; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVFpcKSG"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd523634so12724519c88.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 08:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781190659; cv=none;
        d=google.com; s=arc-20240605;
        b=a/N+3VPaxpLcJKW8iELPFl/uGAMfkVXK9Mm5xx9WYeM0sD0wzlbyz0jkRComsKe/zE
         ZHDgHiZOmHuWQMgoSUJ3grAvzMMDqSmEUCUWUicrYiW4wi+KN/ubQiTJvnj9n8ORFRyw
         1lh886PRYYtv7clQX3Qn6iLGoXGgmMntgJVQTckhWbOu/HosNced7xhcXeacE+JJIEjl
         Elnd+ibVN3g/UxzjuDYIfetHkfNvEW9xjgPnPiqSs4zeGi4YMlv3J002M5X0Hq/W68QZ
         GGvtrY4lHA7J26l7Tcs1t1UwZf+1DGBGvSnkYkrb5ATkhEwKf8roExkFBfKX/3RtxvaV
         AJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        fh=Yz45prcCS0p3DW6e9EGDJSHkIsBx1ia6mBka7cS2CuM=;
        b=fR0lkgvGwYZSRbi7wy8n/J9VobPvLa/M0DEHSA6cI/B+Ie0MnRYXjyq1T1Ki/vaKNh
         ULGx2ha4HoIxUdptWcVPWActn0+SGg9L+fK1xTJmkdisWPPaXLf0mqT7LEx5eIn2dHhN
         ERjZoln7azdHVGBP6rMuGBsyjj+/FiUUYJEA4pG5Y3aUtWZZgZxCEEv+TmdReioNsFxb
         nl0iKBxAazdriAamiq/sHDoTfBj1Dcu/F6w8RI7hr82LCRjD+gPGA96afg1/SXwIbtgN
         G42PZWZL0N48VYFuuOMABSbS0pCtTdJwbEvKsxp7uyH+XB27M2oi3qHwCze28LAD5teO
         4NGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781190659; x=1781795459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        b=QVFpcKSGE7vMkwgzeDGG47E8T2+BQD82hpGgIusIaUA4CDOjp66YYvby9aUVsRHxa/
         SbGokfSUZ0PBSd9mig6IraEuuwGCXYyFLgW1X1bCLzNikartw9Eh2plxCenQgHeGm6hG
         NMmSROF1yWrLofwvUFEKDUSebvbj9xk5VWIfb8oujvZsyCKlIGwgL+uw5HUqoP24jvbf
         yuM+bkrVdIlxgErkCROggsVhk+OEZ4WPxxcvCC85+EOqjKeEmI786DLYjdHgNc3LeaUf
         i2AGMHAZVSQBpxJeTvqZHv/nB7M46H7YN/K7HySXSfP9dCWhRrb1H31uyS3wT+WeXo3a
         O6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190659; x=1781795459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        b=Jn3TBJMZaKl3nkq+19/Y7gToHPkPG/7sC4QWQEnccM5aEURwyL85sFwpcT+2SGz6tb
         W1jiEDVCJvp0WTtIE4HlYMWvcsScJgFzcXZ2v/CMAvxk1+REhCL2Ifp9xyaLankIbAuw
         jY7CYlTWDtPoZfx+ZL/KqCUlomsVVEVbJ4a9ysnYQZJioYeolnTKxil++++OnZdj/8VM
         ixtkviL+JyJiSKbhfCrfU1KQm3uBSXkqgM/OyZZg1nIDzZ/MzOybPq+PoMLyvploil4i
         VJe1XNup9irokb/xr/ujo6rQzGSAouJpyKuqP8UC4/mueu7VHeZSBXqr7C4QdyIEu4BP
         R7gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/13C5dMBo/jI6JaR31Ed6vyVqRpGx0eKyDt9MH/XbvIU5Ho/FyUhCDMDSWHiqe4tqcESRGkag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnvF5Nu+wmYWzM5UuHrxLcE1LrNgxLA2sn1BiDTd73dDVisai
	xYlcyVo/+GGoPj1Aeo0/2DPI4rfTHT5/DyV8JgDNZedNCWFw5JWLrh35ZR1fWbbLKhZAtUEkF9A
	P39DCXPrx3L5HypVNRo16lrTX/Ws/SZDHWQOhT2qW
X-Gm-Gg: Acq92OG1AkaULy2vl3lf3T+85GqpAEfYIE7+639cb0vDGLlNvi8Xo54votWV2YHzEMV
	UL1Thu6ja47TbPU9eCjQEBAi+3tVl06uDWpEPcglkbnc0p+twBU/tAKWfKLo0TFrIXeAgCmh1/F
	f7YQFzbZa69cD92fo/KUCC2MepRzdqtPJfwE2t+MilSdlWQnGSToX9brTrVhdwIJhAQchYvavfJ
	gnFRMA77qIbRJcbrcLR+FtSAz/OUGoB8uccDAsjFnMXecSotn7XAkXjKUSIAp8DSV01Mbk0297j
	yhysefmHoz19Y4ztrEu0gd1luueSkT4YlYWFpJjziX0mmY0XdGKR/lQLTTc=
X-Received: by 2002:a05:701b:4552:20b0:138:44ab:75f7 with SMTP id
 a92af1059eb24-13844ab773cmr770322c88.21.1781190658662; Thu, 11 Jun 2026
 08:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611002437.1671401-1-digonzal@google.com>
In-Reply-To: <20260611002437.1671401-1-digonzal@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 11 Jun 2026 11:10:46 -0400
X-Gm-Features: AVVi8Cd9uZgzE9Vtr2KiKxKuSPVMf5kiWug4xcnQibRwcwPz9EwHUXafig-7Bv0
Message-ID: <CAMzD94SgL2QtQqu26icixW4MVL1D-UsauKbFF6qrtZ7TxCgNfA@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: decrease statistics refresh interval
To: Danny Gonzalez <digonzal@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Li Li <boolli@google.com>, 
	emil.s.tantilov@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Brian Vazquez <brianvv@google.com>

Before patch:

# sar -n DEV 1  | grep eth1
08:09:51         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:52         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:53         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:54         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:55         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:56         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:57         eth1   4225.00   1801.00    736.18   1125.49
0.00      0.00      0.00      0.00
08:09:58         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:59         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:00         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:01         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:02         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:03         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:04         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:05         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:06         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:07         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:08         eth1   3788.00   1435.00    628.26    535.24
0.00      0.00      0.00      0.00

After patch (you can now see background traffic reported right away!):

# sar -n DEV 1 | grep eth1
08:08:33         eth1    527.00    443.00    261.74     76.69
0.00      0.00      0.00      0.00
08:08:34         eth1    440.00    423.00    101.89     78.75
0.00      0.00      0.00      0.00
08:08:35         eth1    356.00    353.00     68.68     57.02
0.00      0.00      0.00      0.00
08:08:36         eth1    437.00    462.00    114.18    124.07
0.00      0.00      0.00      0.00
08:08:37         eth1    377.00    383.00     61.40     65.97
0.00      0.00      0.00      0.00
08:08:38         eth1    335.00    337.00     83.08     75.39
0.00      0.00      0.00      0.00
08:08:39         eth1    387.00    392.00     58.95     74.58
0.00      0.00      0.00      0.00
08:08:40         eth1    351.00    371.00     51.39    103.25
0.00      0.00      0.00      0.00
08:08:41         eth1    339.00    338.00     55.38     54.91
0.00      0.00      0.00      0.00
08:08:42         eth1    324.00    328.00     54.15     55.71
0.00      0.00      0.00      0.00


On Wed, Jun 10, 2026 at 8:24=E2=80=AFPM Danny Gonzalez <digonzal@google.com=
> wrote:
>
> The default 10s statistics refresh interval is too slow for real-time
> monitoring and causes network selftests (e.g., uso.py) to fail when
> verifying traffic immediately after transmission.
>
> A 10s delay also causes aliasing in telemetry tools polling at shorter
> intervals (e.g., 5s), leading to inaccurate rate calculations on
> high-throughput NICs.
>
> Decrease the refresh interval to 250ms to ensure fresh stats and fix
> test failures.
>
> Tested: drivers/net/hw:uso.py now passes
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Signed-off-by: Danny Gonzalez <digonzal@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..e2890d219431 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
>         }
>
>         queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
> -                          msecs_to_jiffies(10000));
> +                          msecs_to_jiffies(250));
>  }
>
>  /**
> --
> 2.54.0.1099.g489fc7bff1-goog
>
