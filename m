Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33E35675E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999962; cv=none; b=Rv5sLr83yL2gwXbGoGJdkiE8p3adyLUFVTq+35UqtBUFNMgUpMMplBOn6R7AC7rgXIyk6JrbZPzczCvVT+a4TSTwFhYA7/ctjASWkgKYDiOgI9PVsoC0ac8wkcuOD2gnQQuYP90+LgUsuartYpjZHhZ2jSnIOK7UKrcGQ6rnS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999962; c=relaxed/simple;
	bh=5l6nLVdO88+2acJsOr1UCToSieAPDX3Bwyvphb8xIls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn6IEvNl0qC84/EqVwVmUzU1gaA6J7jFgro+Kl0yj9HN8vFLsG0hOEwCg3Ee/20MDLpzPt2oWMcBATLIRaFs/jMntMkMsAIyvtZa+f+xH+m5CKUeHVFRUOA8pszFD9mpY+ad5bQfdu2D5N4WJcZiX/Ne3FNxork0ryWqinXj/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ArqdH1rX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ArqdH1rX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso5735168a12.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783999959; x=1784604759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=ArqdH1rXOesSkDeZcyrn/gwmYeGCPfhD9ycpZxDFlq1zBr3byohbWaORK5xuqH9P+i
         Kp7BWm7ILY2LeTUxrHADGfcElxoWDlnPpBhtJ9OwCTU5hkGqqiTWQm0Ywi8VvSYSQhx4
         +Cg5J5j7gww51+d9kU01an3h1a3e4Rabush3KBhThPMvWOTRQiNcoknZwBpdgg/mzsTi
         QmsDm3aZlF/Affo/XDS+kP0YFn2VN/nccOxyxycivjBO/FYoSzCL+K9til6FtgxEq2Qd
         WLyI7qrwMz4UBX9JArXVYtfRCWB0a9sca3WoLrGIZ9Q8L8TRKbN899ZQjDFxMkn3yxz7
         Tg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999959; x=1784604759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdiM3wGZvU9W32ITVwJWXfEY5ZH1jUwmribSUCxIuno=;
        b=q6G50RYWp8UyVGfkWj8dveh0C4+RPF0s26Hh0XIKrdVr/jZEzD+rL47k3wFYqBG2Ju
         7EitJHXmE7q3O2mMEBeUPfZPNzxbGrTfh9YVi1u+yfPgt4YQCTRzps95f+IQO/r3y+H3
         Z+P/wg5kUTP6syAwdxbADLcshKvQ9wMghMFEqvVOTQhmAALbLUA80F7MI1moGwHCNQmy
         2ZVRPcwIpALq+IgTvUbzBrSHR7NkBpWrR+htwO5iyc7uU3euSyD3lkafmYEftLaYlaQD
         9J28iXwSIRN4pmOBWW6i5boNQBXuKTCXpFGwvwNeGT1LWDSrkt0ClHsRBNJCiWxqQW7j
         91iA==
X-Forwarded-Encrypted: i=1; AHgh+RoDf1yuqiZTrJnSMK8QdGi27xlP5cnUgyxGaX7j49ccdVinTOvm0+r4NucMmtucmXAhXEw23IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjqlZ1DceA8d/98N6bsSVyQ1pkLJXz6LGQ/yQu/ewsurrFqQj
	Eb7MAhB942++38qfqkrzDhMCuTQu3LILyAD/mwRRIaVHb9e1T7JeFX9Etg4j1LyEUWo=
X-Gm-Gg: AfdE7cnJMcPiLgBbeU/5fTp3HH+C6PLQhhZw1YxGFzecsbqYZILztMYIzTTJ/HcgjPf
	mIqUJwF4V08MSV4MIh6ADGPPmuMeJMXeBMEB1M81WDzQQStMsOWhAmaK54Rk8cr8kAfFt39QM2w
	fovgDu3Q9L6jIX3ZtSCdRS7eOcXTU/DFeCSG/D/O3qaW0einpAKN6dtEVNyBaPveBQ13tjYVB+6
	c9Juc52ifLSPwoKqkT87hqwbhG7acMd/0RD71Y9AMNe+LikP0CpVhNRVw0dBLBJRzWJjGvWIW9T
	DITcg43y3EtOXvj6pp5lySJc51hVmgoYlrT/0DkDS3/TC32DKNfMiZZZUY/Ps09d8/TARCIg2I+
	zs/kCskNLF0Fx7N9KJzEkFQRvdd4ac9a/xWmggskfexY4vIZP5SN1nzkpllteSHC0KhyyYuVfKj
	wHxM1Rc8sbap+ZE5fyr0hwho2Z3DNomvZ+JqiBmE/Pp/4=
X-Received: by 2002:a17:906:f587:b0:c15:e8c8:34f with SMTP id a640c23a62f3a-c161e84b4a7mr493269566b.13.1783999959174;
        Mon, 13 Jul 2026 20:32:39 -0700 (PDT)
Received: from u94a (27-51-48-151.adsl.fetnet.net. [27.51.48.151])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm14334466a34.22.2026.07.13.20.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:32:38 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:32:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for
 raw_tp_writable_reject_nbd_invalid
Message-ID: <alWsBzShn4sgDRl-@u94a>
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
 <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08508d2133284d49e1da297895c85cf854a97bf3.camel@gmail.com>

On Mon, Jul 13, 2026 at 01:47:18PM -0700, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 14:35 +0800, Shung-Hsi Yu wrote:
> > The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> > nbd_send_request tracepoint, which is only present if the selftest kernel is
> > built with CONFIG_BLK_DEV_NBD=y and the kernel built from current BPF selftests
> > config lacks.
> > 
> > Without it, the bpf_raw_tracepoint_open() call always returns with -2, leaving
> > raw_tp_writable_reject_nbd_invalid test always passing without exercising the
> > checks bpf_probe_register().
> > 
> > Cc: <stable@vger.kernel.org> # 5.2.0
> > Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> > Not sure if fixes tag is the right thing to use here, so use the cc
> > stable tag instead to get this config change propogated to other stable
> > branches to make stable BPF CI's job easier.
> 
> Shung-Hsi,
> 
> Thank you for figuring this out.
> I'd suggest we switch to bpf_testmod_test_writable_bare_tp() [1]
> from the test module to avoid the config dependency and let
> Sun pack all of this as a single patch-set to simplify backports
> (if such are necessary). Wdyt?

Make sense, that's probably for the better.

pw-bot: changes-requested

@Sun can you make sure to include the follow tag for [1] when you send
it? Should give a better guarantee that is will be picked up by AUTOSEL.
Thanks!

  Cc: <stable@vger.kernel.org> # 5.2.0
