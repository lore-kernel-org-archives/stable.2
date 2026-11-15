Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709751;
	b=qllHNXca41u5TexNi4iGcqPTdS9HVYcIzZpuqI6dUUNC7k75UbpcwQCc+gMFiIhcQHEz
	 Z+5LgPwtPQ3QCXZoQiv29BTpSOu5s2h76hmcdj90tbXoCvKcFtMrb4M+NR35omnftyGAt
	 KShLQT7y4n++JUR8EARwUdworL1kQcgCcfzeEH9cPfYAXFFtFcXsFPCrRSCuEISmDC8Eu
	 FUK+Gz/p8jh3MrJfsKsq/HZreXa0caXlai8tUcfOATJNhvoCl9ct4x4PivG6dE/L0kov1
	 0BLI+blQtah9z///YMsWLAz9U3DICX92Vd70pzLn49AYNAG8RPu1Avc9pjuWFc4pMNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
	b=zVkJmbdHannRIZnDmhKS+xuzSthinfJvXve/iWEQdbd2t4A8rCWWjcGqBRdjZ1ZZPxIP
	 vZ06ZiKx3/d5/58CWgXq4A93o2idtyTkSoDnhBBInYLzx0c+80n5vdVykjAJbPAt6wmjF
	 K+7RNX5Day3XhjtOlf0/WQ0lnhDf2VsA84V4pNeSn+EtB4o+p2NpArh/gRnYvrdv5TCos
	 Pnuqs0jvmE4mbl4tpX8Uq1n7HBBa3wjSBxDpf2EsktuLK3mcZVaFBTdsFT6zloNAffFM9
	 mslN8s4ao1dkUdo78/UK1/SOQHj7GlSH/U77vejjkIalfOyFBmTzhwKBxZCYBILIVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+tStDCN;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC8606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52AC8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+tStDCN
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8470d7d430fso914341a34.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794709750; x=1795314550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
        b=T+tStDCNHyTwpVrwpY/oHLqkXZxok0j3rwq91AyNE0mZPek6fIP8b13nuvhrJIUKa6
         ab1Kh/ROheDyxFbx5YhNLKdwQPpuAfv+em7i6tO8eNAGl4rztkwPSbCiHY6B1jVvXfoN
         o4lluGVK+4Gg/8XVtXotyh/feX3v1JHh0z566htkVAuSIMVyBSfBm6WImqIRC6OFv0u3
         yrccVrcpg2IHV66qfkIJs756YbNS7o9c7PTtu0upsnyijkhazliAemD6XeL00AaMJkFs
         JCgxOroc3w4Ddt4bs4GJPrf/PjeaJBWcSqLwS2ntKBZNgeCUIsnbhLPWh5bxnmBLox8V
         uRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794709750; x=1795314550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CDE5oldwyToxMIHZaDAAROi1zR3/FKKlLBPz1nWp5Y=;
        b=DKM8ccFonb2ISb/y7i6CDSXx7XbROCwwBWA5c1pk3n4FsbgQj/M3HWrC8nLlFoCCVS
         Wn+/v3854IfXi7XA+0eW6RzN6c/Mkrp0C+Og0Km5vsPe8AKsP6pLASUz+WONTIQhyyrc
         4Ovuj308buvZlqcfip6LD62GEGdjkWehMs7xCFXSPg+kVwrPhYC7um71nKtbefLYPOER
         FA5oOJ+kjgdNk20202vIzPL+N0KZsx8s68fiGy5M7jPexQGfI2mq3LDVkFJTkaBchaGy
         CnxDgM445nBpOefESfAuqllUHqTktNzM3b8qvDm8q/UoQA8ftIZFjyI1Xxa1FL73TAhZ
         9+3A==
X-Forwarded-Encrypted: i=1; AL+hErGCUi7nHs/1cVoNku8bICfYbk1R86M/wiVPgbxrvLf3fq4kDLmBF6X5DWfqpqTylE8EKPa3qig=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8vnlhmf/7guAWM1dP/tlPlfTmfT5pePxAQ2vv8LalWLlvEuI3
	lkvHm0a4XBlMx+2YHUJk0tX1YT29Ld75WLtl/tDsfRBp5CpVOyfRBsQv
X-Gm-Gg: AYBFou0tkcyePZXnsCZCk+OgCDpVxQG5m0o6EsXLuLyXON094jHQwyiAWiU/EIVt/PP
	y8/4RDXnKlJZA4hv7IAHhOIR0AGmf0uOtFtnkOtCrDOw2UXme6Mizx2ooezrdf/f2XxIAQEQ6AY
	1dsLROf+pGVi2oPNhwh+YmB/E4jXnjnrv5uAA5mBMesWncIR3S4YBfPEtNDFfnlBC40GkPp0r5N
	boCtzzeVafBfnrFyZFQPwMiR/gAIe4bA0l4EkjPbOu7h/M6L8fSPzpGGM18ELWdSMdtrdKANBfZ
	r4wGtLZI+f/m/NYUWOkEyLhBq32mzvzjFJJkkWOuliEhS3rqsPEv4DjzKP6u5zI3kKnTBzQC1fJ
	pACabNPE6VdLONwnhkNw5sedavYvfXyHh3X7cJJ2uXM9ODLpBRVYYb+U5yP0gGulBeRuiKNTYGl
	iiFu9BNWXrPcUA9pMLEwWAnT1Xl6oNhgVD19JKWaxHsCqkN2RHMkUJzz4ID1tXNPAIoBLHSOZEQ
	/zsmRz00S6ozXSsg5KPLsB6kX+Rgae1aO8jNt0dvVf7qweAdrC62NIr+4+cqpjQgaxW+RMwpQtM
	S/56vzeCskw9Lxv5yIDWCnpww1TmnPt3Ac+Bn3Mb2hkjRGfvvJRqasPuTYPpWh/sWUivePLtoHg
	acCoD7O+dRYLSJoh0Plq5DCRCgcJiPVgt
X-Received: by 2002:a05:6808:14d2:b0:568:39f2:1254 with SMTP id 5614622812f47-56e64dfaba9mr5765056b6e.47.1794709750000;
        Sat, 14 Nov 2026 18:29:10 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc412c6sm6246722b6e.4.2026.11.14.18.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:29:09 -0800 (PST)
Date: Sat, 14 Nov 2026 20:29:04 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests: ublk: clear reused batch SQE command flags
Message-ID: <avkY8Hy04c3QzXSv@fedora-laptop>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <202611112258022807A4cJ4GoTzO_Q2qeMKeG1@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202611112258022807A4cJ4GoTzO_Q2qeMKeG1@zte.com.cn>

On Wed, Nov 11, 2026 at 10:58:02PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> Batch FETCH commands set IORING_URING_CMD_MULTISHOT and select a buffer.
> When a SQE slot is reused for a PREP or COMMIT command, batch command
> initialization overwrites the SQE flags but leaves uring_cmd_flags set.
> The multishot flag then disagrees with buffer selection, so
> io_uring_cmd_prep() rejects the command with -EINVAL. The completion
> assertion aborts kublk, leaving a recovery device QUIESCED or its CLI
> waiting for a daemon notification that will never arrive.
> 
> Clear rw_flags when initializing a batch command. The FETCH path sets
> its multishot flag explicitly afterwards.
> 
> Fixes: cb5a6b308700 ("selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on next-20261105 with CONFIG_BLK_DEV_UBLK=y in a local QEMU/KVM
> VM (4 vCPUs, 4 GiB), using real kublk and fio. With the same diagnostic
> kernel and batch null workload, the original binary received -EINVAL
> for a multishot COMMIT without buffer selection and its daemon exited,
> leaving the device QUIESCED. With this change the daemon remained alive
> and the device stayed LIVE before deliberate device deletion.
> 
> The four recovery scripts also passed twice with this change and a
> separate fix for commits arriving after the quiesce cancellation scan.
> 
>  tools/testing/selftests/ublk/batch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
> index 625a9c32a..fcab2ca9e 100644
> --- a/tools/testing/selftests/ublk/batch.c
> +++ b/tools/testing/selftests/ublk/batch.c
> @@ -241,6 +241,7 @@ static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
>  
>  	sqe->fd	= 0;	/* dev->fds[0] */
>  	sqe->opcode	= IORING_OP_URING_CMD;
> +	sqe->rw_flags	= 0;

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
