Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795635164;
	b=PBfGo4QLCOWMOiriMUb1eyI+sYfPK/N4PDRCPKml+THErOCBNoN8wFN31iUGdamPqvqP
	 BkRn7HisVzzRYeW6IrjgkayvANUnjsrBkfGnOKQNpvAEe1wHCSKTodZhtx6DoTgOPN21M
	 2WNk6rcn+dNR5xl+gPDuskmVyaQyAnjqsc+mJqOqpjo+PWsQKEln00bPUCtL94pYmf8OW
	 iuRXrD3+EYe5FfFZG/XXp4q2+CuGU6PVYpsTrV58a+vCqgH1K3UOBlWfbM7K882wyAJaW
	 sarRVUSlGy1J7voLItVwNeWmXuZACzqySraTGNtrrosxKPEaooAER86PPt2b8Ih9Pnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=X9M4PV8SNdlzGSgquLvXH/wlU/lqxuN+YYGaruhCqiI=;
	b=Cpf/nm9dliqo1lQzIHUAcXs4C35SSt0iArrNHfDdylh4zUrsKcYD74UsCGW7wtpBeZBF
	 aaCMNHDLdGjm/xHeOPzKol8ExhK5EKJHmn2Riko9+H8VKdznmZoGNLOiiKRQk60BokHhs
	 v3kDghelBH5KvCVFie9KLQCqxVWvGfU47crFKxUwLLg49f04B8jWnkzSVYAsqpuUnPnZJ
	 HDfJZFSCpcPLr2TyNVPRPyXWl2WdtqJ3DRYgGF4hNbyDzEJfkdn9uSaduE4eXaKrXwNZf
	 5EsHj72c5261kHN42r6WF4UpppSEENpO8L/eB/OdXjN1PwH0LD3PwQWYOJ6j0cWp2tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGGc29Pk;
	arc=fail smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77352606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77352606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGGc29Pk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4aa5833c263so5954176f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795635163; cv=none;
        d=google.com; s=arc-20260327;
        b=fwAejCiGmuud5YYyXgcgLdfYLAl9bnSiuw3U6eZQ/CFh1UXmSXfGIl6bI2ka0BXdc8
         1CsyOUMpwUt7bPkcuxhJ243UHla+seOGIXO39KTg/2xEwyPCVGNV/xu6dQ4s/pBPO/rw
         PnSrtPXQiEUMGXVbQshlLGy1sQTtEXsJJL7El4dQPkJy5g4l0uJWE8DLofQgVdEonMG4
         mFejaB08wEKx3tNHBfISRhcYiB5j9Q8/V9jowg4o1o1tUi2Jg5uziIxQvDY+8xzH0opx
         Ja+RGMYl40l5VMZqq1o8TQ0Wpwix3ttF9BWy4kXnwJan59FfPUL96vcsqiiiqCcvR3w/
         hs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X9M4PV8SNdlzGSgquLvXH/wlU/lqxuN+YYGaruhCqiI=;
        fh=F5jUkTsRWpjMSHS1VOLu4nCDm9m6nE5PTqTFPjhXLjI=;
        b=cG665Lnv8vVC5PfX3MOMD6vqPQLYbcoy7VdphpQ4Wiv9uJLxbo3AG7AAha6y69iW6f
         KA4MtzR1MT4y2AYqg+ACGbrd8JM5tX/xiomy1/EUjUq0jHuMOU3INUQIiB8PxZxUwUTi
         kK7zz9zEhZeBWrs9jvTrVUHqggU4IBHln3EzsQNJZqlsh7B0k+ViM2M1gVEMtA4HDrkb
         n6RPx0/nnsJIEJhlWfadQ3ZYQlVcINJY+Za8nubo6z2T3v0t1JlVOYpYZiZU+ZinAtIP
         1j6mmkTwIgtarz1Y9gjuzTBxaMdiDbe5FD2zO0QgWXDId3YteyY2G27irHF1KDsyK5Qr
         w1BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795635163; x=1796239963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X9M4PV8SNdlzGSgquLvXH/wlU/lqxuN+YYGaruhCqiI=;
        b=bGGc29PkecU5bqRWEOkPd4+b4f8KEaLuIdujN4I50RP6BhsiSAPlpPTDbqrZt+H48Z
         mnZsDm44PVahA9C5cpsw4zAKuLSji/bOdsMFwAButV9RLV1Fqb5AbVWWaislnXeRjgQ1
         JaMwai1anktQmbljd1hNIsKg2DHy5BG4dNVPMptnvyXTpbWaEHDh7NyvbttSq6j7Y3eB
         5N9LbHUCfYlba9Q+EPcSMUTnCCqQWiCNwqRl3TZun1XTjutFJWbPkrzmLTiqGBB3LNCf
         9U27pVDGssOUyQFhBXdwpp1NS2qzp/O+Liz9x5iUXiN8KXHKnQb9QyoG2G+z/HAiffTq
         1fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635163; x=1796239963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9M4PV8SNdlzGSgquLvXH/wlU/lqxuN+YYGaruhCqiI=;
        b=WOLSld2mRdo8iI0ax4Wue2dsqo9+oamfL1BStm3Lq7MAaQz/YgCg4xXsbfRqoPfMSO
         ZbSyMZB0vb539eaLONFSUcNDG2B20KVfukkMw2jUCeOijeFdCzPRJuWql9TBTK5daOUN
         +3K9J1KMNerBb9lDElT61GP3SNBRYRtJPJ4fznIr+8hhEUpL6NGKbNDWBZZvLMZxiKLl
         sXfHY5vCZRmv4tZKkIniIfQn3ESWHK6f9LUesm2358/SCcjSyR2I1a5ykn9lImcVZOYQ
         qip6lpVL3SN0N+QQW3ccQyLSqMBEVWYjdqHKk+wdTpfiIjSY1fj+jP4HKzeKV9/c1oVl
         xlPQ==
X-Forwarded-Encrypted: i=1; AL+hErEe2JogoJEvVXF5tRPhvJl5BH4OL9NSE6cx3W4tOL+8Tv+3wQXUcCgtnd1Y2pOR8cHhAZ+YHMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TUFVgoJ7FjsoALqtcd/WttFXMNzFbIK3+pmgEyJLgHa6ZAHGQ
	G6C+J3aVucXXYCUynLyVzpGxs6OBcNkIo8yAHgQY9m1LI0u8e1wY0B3x+BCX95W/tUcmYvE86Ob
	3KE+5v+OS4VdklGKnJQBmvkdF/eVZUgRaGkZuZ8lg
X-Gm-Gg: AZFdTZeBXOz0AugriNRdhLii04VDyM+mWTE0pfv5q1269CGxLxEHIE9D78qPyDigLoU
	zybZ47NYceiEgqpY4y1LYcDFyL4bKdHER7XAC0DQCXBIZL9y5LTqUDitrjkEjhxraRUjGXKwEWR
	8OJE/ImrmyLEohubypdrl7RtBJkEydaT6HMRgrbGvbdu0CcOt8NcyTeZFKlDWwjrcBCFxo9AglM
	aUAtjm81rrapA+dbhtdUFKAsEhiOizosrqaa6BbXDKzNBnTNpAERKjDfM4V/jIs1Hoc6dtZhSNa
	060xZpz2sC9q9Qs791zxbsKiVa4jbi4wFlA3B12FfqghoHFyRq3dorbzW/6Wg5DfFWb4aE6hvKN
	0aQZIdC6ycGUNbo3r7OVa+ynNTxkR3z9Im71B9d8hWGrnM5EGXGN/Wd+fiLYw84BDvdE9yi+sd5
	UqQKBrLazuBo4pu+nWO6LXbJuGZrU1j6GkDjMYZMYQEUx6s5ld3FrYocZ8yCS3kzd8sMgFXRrrY
	SAwjlms2e1pHBGQZPLbWfI2t5bdmSqLFgkyBA==
X-Received: by 2002:a5d:6f06:0:b0:4a6:8d5b:7338 with SMTP id
 ffacd0b85a97d-4abb3a4d35fmr38121765f8f.37.1795635162216; Wed, 25 Nov 2026
 11:32:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org> <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
In-Reply-To: <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 25 Nov 2026 11:32:31 -0800
X-Gm-Features: Aa3M54rVQ8eJKNwIoeqgCfcnaPCAwUQ4sJvYenMtBURouDlRSqpiVSf8nOBT24w
Message-ID: <CAKwvOdmyGdn4ES6Ku+Yovd7a5imzmtmYtd7KB=OMCqKpv1X8rg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 25, 2026 at 12:23:35AM -0700, Nathan Chancellor wrote:
> > Clang's warning is ultimately pointing out that jiffies may have two
> > separate values in this initializer because it is volatile and accessed
> > twice and the order of these accesses is not specified. This could
> > result in unexpected or inconsistent behavior depending on the code
> > author's intent and whether they realized the variable was volatile or
> > not.
> >
> > As two separate accesses is not necessary here, add a local variable to
> > hold the value of jiffies before the designated initializer so that a
> > consistent value is used for initializing both members, clearing up the
> > warning.
>
> None of this tells me why we should not just disable that warning and
> get on with life.

Nathan has provided you 3 different ways to do so. (Could also do ugly
pragma's around this code; disable it for this entire source file via
-Wno-unsequenced-volatile in the Makefile, and finally this diagnostic
was forked into a group; it's now -Wunsequenced-volatile under the
-Wunsequenced group, that could go in W=3D1).  Pick one?

I think the warning has value generally across the tree, even if this
particular single instance "isn't a bug, per se."
--=20
Thanks,
~Nick Desaulniers
