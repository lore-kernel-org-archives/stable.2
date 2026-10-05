Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02489356747
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195054; cv=none; b=W4QkNHi1AbtIr2lUF/HR0l7uXjaeeix+ue0x5EotkrPXhG1eZFZW2K2FCV7SsADBHIGqkWAmwdH+9eYRf8kFlAIl8bEgcvvG7i7XFIl8mdMKbEEJ40IDT7Wgg3p2R6rBAUXTLjOJ6pikXyJBpWkQFiZl//BQs3bBCUjf0qU3ZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195054; c=relaxed/simple;
	bh=TYp4fNUZkaVTXBnF+9xAI88hDWpmeWOOmfSvViyYoIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut1/zlCnR4UyY0DvCgLY7/puwo359hbFVT+tfiMocerZC5Zy4PRMcTgM5jDpWWxRuknDLaX+QOM+c9nSPl6ivVNVfqoUVbIJP4fU1326IDJ6mb5qt5E7m29uqT/nZwW4T3ys1hP7nQ62nXqcN99NRIqXkHdAdy7s7qR/IZ3I7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkmA1mp5; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkmA1mp5"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-8873070bcd0so485889b3a.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791195052; x=1791799852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V1WU93BRn6zCXOoz/61V2atK8qi7X3MY5yMsA+l4Fdc=;
        b=CkmA1mp5G3KZiuNsveE4gLu9bxB5USiAnuSatGuIvQ4zuEeph5EjFehbIpnLbtuSt+
         FsKGqa0TlY7DFeSo8WnKNk4ZVm6wIJb7iLl+sJ9LjNjdgkf5HgZuNQf/6jY6lzLK+sel
         ICJgfYDdHFRl014bkRg0fR7pIrhZ1fQydnxWTG58iF4Y1mlzz8fRk+4prBxVLk3Hy6sb
         aYNkDqAeJYGHoeA7tijJz42lD918SCQvHxsERKOFTos23hcSK80eHt1ugBOwCMUjswmf
         Jm/LBuJRhSABpca93wTRMtKJoSZ4tkXAnjbgWrgwgeJSOGud9Pzk8DvL3wu3D0AAu1FS
         lTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195052; x=1791799852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1WU93BRn6zCXOoz/61V2atK8qi7X3MY5yMsA+l4Fdc=;
        b=geO4IFgLXWp8ME/sAIQhZC1+wldYG0RH0UlG+jkGdhByEO7WScMA4fvPhtRbyeNyYV
         zH1+fdRioBMbVgz06lw8JWeMCsw8ygGerb8f6vFHtylSPqKrZ5Hii82d1qwEb5x3QWgb
         wJGss14PPcQWkKwOu/DZXqSt8WcMxvAJniSYfnRyrk9byK5PFu8VEzQDxvLCFjAlovxp
         aVzo/Y15QhKPkfU5GYPXRaDX9pyfgiLnlizv5JZF5e3Erf6LuqrXu1zTVad8CNB9l6QB
         QiGp/F6KToa1gUKmp3Q2+pmGF1FdYXyDk/8u4o9elwxh6C2f9njXcpxEH/z0/jBa+TdD
         pxwA==
X-Forwarded-Encrypted: i=1; AKwUvBzhw7e3ij/MEb6XVdtAAp6PFNsJWJzKUBSY+jdCPNDykIbBE6F3N6tTC6Q2bSjDyhFUJbnOfUY=@vger.kernel.org
X-Gm-Message-State: AFuF++m478g3LSspGbS1TspfAvBqrf7liHPwublPYmaDiloLfCtI4cx2
	+XaJXQ58+Jf8hPuK22YUDVWiG14NeJV9cWxybxA1tYqMIGIjMVK1CeuI
X-Gm-Gg: AYBFou0WamP/q/aVWIYp5ce7tvfmV3GWN0ZWYyeRhpn8+F9rdXLzrX4AXIPTlBDSGww
	PC8iKpiIu/vWi3iS1zEmTf63MM6ETQL0C7NpvXeOZSyQJXzE12DYD6Uz0VXf2+yvY05CwdSYKph
	udMcYtQg66itcXrbevft7gfdQmRCXG+TDQBS0WYQSo8mg3BccMVW3uwZ6vJW4Cq0lvdq5e2maS9
	k+CHmqSGOBiuGoHgW36fcyYUOWpBt11QlV2JynEBsl87lZuSdTVq0sWPA0n6ciNRcaR+N/IS885
	1Tibw0xQoFukceDEr7NOqd6lmD6nXWxw5l0TbcUefP0Y+y+/VtM2bni2ORvhZ9a8cpfd6q+/2u5
	mgxPDJugQrYH/ubJCJzgBSSBwHAveEAaFcf05eFaHKRcXwkZT0p+W66OIS/k36SXFqSHQm9XHoZ
	ndxQKZGbrtnN0HUc2Z1HShGDH2Mj2C2zLaltofxcQShIn2ncsHHdNhGFynI2FIFcuuwGHJ26vSZ
	aUpjMy4/IJ0Jw==
X-Received: by 2002:a05:6a00:3d89:b0:88f:a337:2e31 with SMTP id d2e1a72fcca58-88fa3372f25mr674533b3a.12.1791195052202;
        Mon, 05 Oct 2026 03:10:52 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0ca7c6b7sm3219752b3a.44.2026.10.05.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:10:51 -0700 (PDT)
Date: Mon, 5 Oct 2026 18:10:45 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	ljs@kernel.org, roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
Message-ID: <cec875e1-2afc-44bf-929d-b8f2b2a795f8@gmail.com>
References: <20261005062236.564210-1-vernon2gm@gmail.com>
 <20261004233615.df26e580c1bc916c7f3a23b2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004233615.df26e580c1bc916c7f3a23b2@linux-foundation.org>

On Sun, Oct 04, 2026 at 11:36:15PM -0700, Andrew Morton wrote:
> On Mon,  5 Oct 2026 14:22:36 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:
>
> > When the cgroup has no memory pressure at all, writing to
> > /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> > NUMA node, causing increase in the writer cgroup's memory PSI.
> >
> > Due to this reclaim is performed in the context of the write(),
> > accounted as memory pressure on the writer, like
> > commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
> > as memory pressure"). This is unexpected, the phenomenon resembling
> > senpai will appear again.
>
> What is this?

This is commit e22c6ed90aa9, which addresses a scenario mentioned in
memory limits of a cgroup, in detail as follows:

    Currently, this reclaim activity is accounted as memory pressure in the
    cgroup that the writer(!) belongs to.  This is unexpected.  It
    specifically causes problems for senpai
    (https://github.com/facebookincubator/senpai), which is an agent that
    routinely adjusts the memory limits and performs associated reclaim work
    in tens or even hundreds of cgroups running on the host.  The cgroup that
    senpai is running in itself will report elevated levels of memory
    pressure, even though it itself is under no memory shortage or any sort of
    distress.

This is just to explain that similar scenarios will continue to occur,
only this time it is for the /sys/devices/system/nodeX/reclaim knob.

--
Cheers,
Vernon

> > The Documentation/ABI/stable/sysfs-devices-node documentation also
> > notes that "This interface is equivalent to the memcg variant."
> >
> > This patch unifies the semantics of the memcg and node interfaces:
> > per-node proactive reclaim is no longer counted as memory pressure,
> > and the per-node proactive reclaim interface no longer produces
> > phantom pressure.
> >
> > I ran demo[1] that performs per-node proactive reclaim 10000 times
> > in qemu, writer cgroup memory.pressure as follows:
> >
> > without patch:
> >
> > some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> > full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
> >
> > with patch:
> >
> > some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
> > full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
>
