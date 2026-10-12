Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A4190473
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774353; cv=none; b=mGX02VUX2WOwHydM6Gg0262pcWrsa2nGKmMZ/N20IobSudwcgQt1GehWsOcglo5uJTlUZCg3RF5Vs+asSFtI64XV1owBYLVoQ7613ZgKAfClVxcUKCRn45LCaZTr3YBe5gLrsx/NFyzdyqjXLTUGD1hfIGJPRnSQad5Vy9Z85Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774353; c=relaxed/simple;
	bh=HFJ3bTcdbmrMb1MjB0qjlxO4NeEn7LJaB/BqUK+sTCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJUe4H3SXoMoIIqTw6YWuLRVy6m1PMHaKKr6RFNA0e6H9bJ69wNlOdaH4Pj/0pFpnawLPmxyVKAp5FugA/5IdAvTfi/ZNTL3z7SyLk2akfTMRlDrATgOKmgcQ/c3/KBOQLDMaYL42tSELpdYjGfixQQgNEsU2lMmfIY1GZG3g54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldwNn/VM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldwNn/VM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3409D1F0089F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774351;
	bh=HFJ3bTcdbmrMb1MjB0qjlxO4NeEn7LJaB/BqUK+sTCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ldwNn/VMPx8v7Kcn29kRtGMTtOySNQaJkhZOoeM8FkNQ0HB0NQIDV/2XGpccMxNOB
	 Slnqj5nsDcXbwLqHPZlc2iBrAlbPLB5cfDCZcly1suPUvW/+B4W/vXfpGvPJ5JCFcy
	 uYnJ94giE02k/viObsYlNcXL2Zfqpb/kHem9m96UH7lwZo+fyZns09rEr/8nzrlGH4
	 MZWIyPtYEQrrITmMDNzZhjqEc4enlcEAtupiX/6gi3v3MBphwn8+Sglp5tfWuE+mZ0
	 UF0aK0snXDzMoAX4qVR2/8hjz0399ufadXAjcFj3/ehw5ZytknzfwSdQIQ+L8TbymA
	 NkXEE8Tk8/B1A==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91b813ac020so7168626d6.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 20:05:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzixCu1/9GrM3luJynHgmch5pbczISGMv54ysQwhXxf5cYS5y4mTW/rJ9h9i7FPkvHqK1Y+sO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDd7USOj1KIjrzQCIGihFgZoMUg0hBQQ1oOXRK+BYRZOctg+2w
	h1EnG0S1ukFRj9kCiQoKmCN9SSahrWtXn5TNVSQC0jO+4VwshkzwrUV+OGUkUqCfZ/NcLMQdmgO
	WS2ITpH+ZcNtKhhpg9q0GYUokHqQJIDw=
X-Received: by 2002:a05:620a:4487:b0:93c:2c15:e51d with SMTP id
 af79cd13be357-93ebd273655mr1425306985a.46.1791774350592; Sun, 11 Oct 2026
 20:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012022917.1102467-1-vernon2gm@gmail.com>
In-Reply-To: <20261012022917.1102467-1-vernon2gm@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 12 Oct 2026 11:05:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yW-58kLX7PCep=HVfc-CxE6rF7QKZhYjdeLGve7HX6pg@mail.gmail.com>
X-Gm-Features: AclHuK8IPcilkK8uwSMSyfgjCCtsjbWzPblwAMuBWNreMXAjVfMoXdJFAnSD8mc
Message-ID: <CAGsJ_4yW-58kLX7PCep=HVfc-CxE6rF7QKZhYjdeLGve7HX6pg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:29=E2=80=AFAM Vernon Yang <vernon2gm@gmail.com> =
wrote:
>
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> When the cgroup has no memory pressure at all, writing to
> /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> NUMA node, causing increase in the writer cgroup's memory PSI.
>
> Due to this reclaim is performed in the context of the write(),
> accounted as memory pressure on the writer, like
> commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> as memory pressure"). This is unexpected, the similar scenarios (e.g.
> senpai) will continue to occur, only this time it is for the
> /sys/devices/system/nodeX/reclaim knob.
>
> The Documentation/ABI/stable/sysfs-devices-node documentation also
> notes that "This interface is equivalent to the memcg variant."
>
> This patch unifies the semantics of the memcg and node interfaces:
> per-node proactive reclaim is no longer counted as memory pressure,
> and the per-node proactive reclaim interface no longer produces
> phantom pressure.
>
> I ran demo[1] that performs per-node proactive reclaim 10000 times
> in qemu, writer cgroup memory.pressure as follows:
>
> without patch:
>
> some avg10=3D31.53 avg60=3D13.42 avg300=3D3.31 total=3D10602985
> full avg10=3D31.53 avg60=3D13.42 avg300=3D3.31 total=3D10602985
>
> with patch:
>
> some avg10=3D9.59 avg60=3D3.41 avg300=3D0.81 total=3D2686221
> full avg10=3D9.59 avg60=3D3.41 avg300=3D0.81 total=3D2686221
>
> [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_ps=
i
>
> Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
