Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD9322B6D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181850; cv=none; b=Qx+HQenW1o5o2Sd+KBK9sVU+zFLGaIT03nga2AnCvs3ZZJ08uz7s6cngsi+meVxiWr3UqMEt9uIF8u8cnoTMTyq1hdxKlnCl8OFW6epELKghoWP6Od0TSGQCJtDOsNqaCDs2G/h+FWTHOlA9vcLjVnFbrMg3t3YS9ugJPmwr1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181850; c=relaxed/simple;
	bh=7Go1pW3kqcjzpvNXBPm8wCORyJtiYwbxuEZdhDPXEl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZczxtRDCuJ7YpIpWQmatv33QyNI9YjS8gU1cUW/DvmpSpTQRJeL1Vl0HYz9OwVD+fmO1fwK+9Ks0ROYVRFgPc6zHN7qSitSZq+8mOYXKOdxtfiMUZU6lCWTtkZX9hAHNiNJiPYliNjsHRmfLGijFqmTokOge5d8FVsOAhehuKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNjA+qqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNjA+qqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B023B1F0089D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791181849;
	bh=7Go1pW3kqcjzpvNXBPm8wCORyJtiYwbxuEZdhDPXEl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TNjA+qqUJDRTWZBsH1n3gz7lESCG3bZsRFEaMpgrCq4Y1zuyYxKUk8htOzw1oKCCu
	 SxQ4byo1vq2hBZe0qs24tzuQAhtAb5lf0xUuRB1+6xBsMMoMb17JYdE1AYee2XXB5H
	 Wwq7hAXJUMTvxXnPM5vhVdhu+Cu0CE6FzsfCw8D3vIeELbvZSJLGtBcyoSdtVaOSKE
	 aBNgnjpXxu6w1rhD8xIYlpsubw019cWNaoo6oD3D7W7zNM/+PuWyW/jPidN5aO1kBC
	 5ex7UrZPk+HZM8e47q2LFjdptnhWmGZ1GxC4OJWvJRPKztmFVDM2+AkJns6T6trPQ7
	 7GF0M1i/ySAOA==
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c5818c4a4so99317485a.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 23:30:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy2slURWjglCfxkxH6Qd+cFNnGYKvJn1vp7glb/EJUcPGUc5bM0rxuwWnppjdH8RjSPCOUVT/c=@vger.kernel.org
X-Gm-Message-State: AFuF++nd5Jw0O8HQ2DRhEQhtLn37dlsX2DjO4XU0TJf6cARGkqCiKWMu
	QtPldonjx7Vx84kVl1lNxA+82BsKiY9UWKeGULBb/s6Tq6SPiNxMNI2z38Zy+ZCGMGL6ZJyiYG/
	CpZzLZ3hnHuCEpTpTbTHttYivFKBNBCQ=
X-Received: by 2002:a05:620a:2591:b0:93b:ec83:80ee with SMTP id
 af79cd13be357-93cf19daf2fmr1840183185a.57.1791181848984; Sun, 04 Oct 2026
 23:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005062236.564210-1-vernon2gm@gmail.com>
In-Reply-To: <20261005062236.564210-1-vernon2gm@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 5 Oct 2026 14:30:36 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>
X-Gm-Features: AclHuK8CRONO2VtLENz3jDK7DYC4CRj5Gx_73AqOwMereSu4SIWXUmZ8CWWfcGc
Message-ID: <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
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

On Mon, Oct 5, 2026 at 2:23=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com> wr=
ote:
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
> as memory pressure"). This is unexpected, the phenomenon resembling
> senpai will appear again.
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

This seems to be a valid concern. Personally, I don't like
having the code depend on whether `__node_reclaim()` and
`node_reclaim()` are called from proactive reclaim or page
allocation.

Can't we check whether `sc->proactive` is true? Am I missing
something?

Best Regards
Barry
