Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB5287510
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670403; cv=pass; b=NoqLnVROvapxRZbuoaeF6+4+yEcYgTXuZq/WDQJ1aX9zNSIA0g63T5LKzhl2GDla7SkHtE40cqpD09keZ9jfWrNTFB6XzlFOtikRDEfElXO9IK1bLsbbHHqeADkVIfImT3EPf19TenWC9RYR00ZXyHz29ig9JADI/rAQfK/yZl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670403; c=relaxed/simple;
	bh=NOQZeUgc07KS/OvgX6TK90IWE1VfXavRads+HOY4Du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAr28IbSDHw4/19yp/AUIw4xzLi/IE9/Bq0CLQ06ppIGUvP6Q5VZAVrLd4mwF4CHIHPmAqgu9M65oUP5AwqijY2/i97OD3YtoGM+PAivCcT3zifzNJAZqgfV+h4a4FjEZVt1ydh7QtKupWtEIBdDArDOtwiBIIy/nZKvy0fzhSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Be9mkyhk; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Be9mkyhk"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so9969a12.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 07:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670401; cv=none;
        d=google.com; s=arc-20240605;
        b=F+syhZngQ4dR6jBHXyIINfeJdUWRdT/b7VvJTJalJaLvKuZ9KCrq80TUOtuJ06zrLr
         /7islYFhkv+fHNjRbObMqEPqANqG9kEw+8PNu2nD4EPzvgBPU0aEXWqRL8zh6cyNfhJA
         fy8jSAcJ+TdYaOn3R7TBa/bFjDTTwKbXNYCGJjY/GUUayaXrKQoT8xBaqwJTQC8OIXZI
         MX6z43PDAFm9jvVrgzG1jrvCeeQc7wLtxaVTXxt1NhZJmNfWuulwKCvZZcJEb2cwJugv
         /oOlKmaNHaf+8o59ag3Nzgw7BJe5JYfSkclYAqxUiU2K5rfoNvrvUlbiPcgmSOOqe6aK
         tGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        fh=C5BMxG+jT+N2zUI8q5uXYzGKEYMnz1pS3VcH6a1+c4k=;
        b=WtK+qLftZmFisUjBUrzxl2vmEMPEUVrn3AO01V7X/Z84Xm2d4N44pCgoYeLSCTBB7e
         XxWbKLKPIhAUaQhjyVActFlyd+1+TwBeZ4h+hC9Zy0tISlRITfP3JUWZYsmElJP0pxM8
         5dTpwLLUs4Bu0qHrWqnFSQ6V/OFEOwju653MY1Fl7uDC1Gl0Oq+6l3KBnJH6Kx6aKweP
         vkHZAda96ErZjx+8dS8yQOkUx0s7d4gkXmWBdHJKG0OT4L75m04t9yjXPnGOCn+GPlUw
         NkI1zvyegmigZ7hxU6kd9O9ZbYwhlDt3Y0TDdOpEK3VEI/Urkx4Cy+ggcvF2s04jMGIT
         fSsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780670401; x=1781275201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        b=Be9mkyhkMVD309c+/wHXBrEtGxXhvdbtwfJe/nxjdkovw99MZwmqPux/Z1IFKkvpFf
         6gxN2EMXD05lcaV6oVNQfivjFi/sJeSIsE+QFuk7gH9h90qqRcdbXExWw2CDyy61ncHw
         HG6cadsbpx9jAWtEghV+AzYktVMELUZczMzHRQIB423v9yujZ0tRkcCTYMuBK9pLHNvs
         hluB+a+DczRfGjj2R7tIRuZUwzjYiAJMUUl2SUtCTvFk46z7HeEbcJEEBYSD+Guf4Lg9
         +LpykZqJlCCORzjao4v7vl8M+5cK8PrHlffVYU5y9fluFnqyXscFFYkzZn5PH8GqiDFC
         ic3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670401; x=1781275201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as1py6QfVQjWXq/H/j8qlkW+Qk+QDS/0K5XkzZmjy6M=;
        b=rAY/Rt+03fDX2erKprg3CPOx5UzV/19wZQ3AkvA/cINTTEljDYNxuBf54KBX1hMhUf
         inUgJj1++gYQMDRHRqVLm4sfblibNSRWVVZ90SdMzR/q0a8KyqhuDjxvZSSiHv369WB9
         W3+0dr+d68WBfMtgZ05DykT5W9mITNNVdZY/KVvr7fovcEJPSjk8WXBFXs2hNbHs86my
         wWP9PQ/pfxKFo1109a6fF8iV+WnUCpKWN27iA7y2ra6/yjapvBtPpTPCCYWo0zyNkUMH
         tMZaGQzTPJC9kAjn4HQRG2+NHpMtOTUoc01b/7WkXbDM0ZuxqooucUiMfF2EJzEYkN0s
         zvVg==
X-Forwarded-Encrypted: i=1; AFNElJ941nmmCGP0spDcqHCk7hl8ve3cbnyrLCrxK2GE/ujLKQ4HqYYCrMopPlpxR+2j0YeV/5+DEK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBP3u6//+phCHa9rX59Rj6wBWdOZgot6las16SCmqUcf4W49QN
	po1LkUhXHzEMFWFbato9ZAIIYMDDAxd/+xiC5ZEt4WYL3ugIba3eyhzT3GwGngEfF4yu6jTo6un
	K45wrCGxmHeq4NnjMoIDIb9HoPUQUp/ArN1vvdozT
X-Gm-Gg: Acq92OGHpfwWeLL+VuJmpSCFXu0xQo3PxqkffvGUM4DPUnVy+2vSp1+bD+hiMnPzxrE
	ffAMU12cGyuCf5YMOzBUVnUq67xvqjHF+3iyuyz7VO7HGrjEcxS/HwxM1beQaXV2uVXN7dKK6UQ
	L6XTGebmH7nufxX/jqg/qL6FMdK+XMJ8fOVMmWsZgk40gCM4WYVEureX9M3p/wZklg5+WtTAV4f
	iTqs5RlMuAqmJGpCSIpBFOMd1mTHENyTyrR9gK2YGAJHfKO7iVIKN0h9SVnrennfOk+tg5U0Kjl
	8v61CMmjFz+0CwgJIFwF+qHkT2vELkY28viGgg451wK6yoZF
X-Received: by 2002:a05:6402:52db:10b0:683:33ae:8689 with SMTP id
 4fb4d7f45d1cf-68fe8b4cf79mr38019a12.4.1780670400617; Fri, 05 Jun 2026
 07:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com> <05811fd9-6a33-48d9-a970-281003466c80@sirena.org.uk>
In-Reply-To: <05811fd9-6a33-48d9-a970-281003466c80@sirena.org.uk>
From: Jann Horn <jannh@google.com>
Date: Fri, 5 Jun 2026 16:39:23 +0200
X-Gm-Features: AVVi8Cf2g5iNAdBBEcbfvUYBHLR4xpYK8oqIRwmCptFF6s_EQcEFjFFXqKVPwDc
Message-ID: <CAG48ez0V5bgEWgZkYaM2z5qfr0w6PXg6YDU8NS19=ZU6XLxTBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 4:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Mon, May 18, 2026 at 06:35:15PM +0200, Jann Horn wrote:
> > Fix the easy cases where procfs currently calls ptrace_may_access() wit=
hout
> > exec_update_lock protection, where the fix is to simply add the extra l=
ock
> > or use mm_access():
>
> >  - do_task_stat(): grab exec_update_lock
> >  - proc_pid_wchan(): grab exec_update_lock
> >  - proc_map_files_lookup(): use mm_access() instead of get_task_mm()
> >  - proc_map_files_readdir(): use mm_access() instead of get_task_mm()
> >  - proc_ns_get_link(): grab exec_update_lock
> >  - proc_ns_readlink(): grab exec_update_lock
>
> It seems that this patch is triggering a failure in the proc selftests
> read test:
>
> # selftests: proc: read
> [  259.127414] ICMPv6: process `read' is using deprecated sysctl (syscall=
) net.ipv6.neigh.default.base_reachable_time - use net.ipv6.neigh.default.b=
ase_reachable_time_ms instead
> [  259.158773] /proc/cgroups lists only v1 controllers, use cgroup.contro=
llers of root cgroup for v2 info
> [  259.177155] sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-a=
ll-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) s=
ak(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-ta=
sks(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) sh=
ow-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) replay-kerne=
l-logs(R)
> # read: proc.h:49: xreaddir: Assertion `de || errno =3D=3D 0' failed.
> # Aborted
> not ok 19 selftests: proc: read # exit=3D134

Thanks for the report!

Yup, https://lore.kernel.org/oe-lkp/202606021924.b6d8a0c2-lkp@intel.com
reported this too, it should be fixed with
https://lore.kernel.org/all/20260604155806.1402880-1-jannh@google.com/
, which has been squashed into the current version of the VFS tree.
