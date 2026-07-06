Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B572EEE7C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357660; cv=none; b=s84hgKQrRB/kxfSgFLje+rzVfKZuAtecFDAPiVBjGWvfkC1EjQkrDiY6GctpiXYDcqfETO/6MHqFcgHXCWFIsXO/sJzdS8dIdavQyUMxHrAN0DzOj9O70L2FKU9FP4QaqzJOJfEzKA+tCuox4QrPzp45ODq8Arsnild5hkQipF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357660; c=relaxed/simple;
	bh=La52E/eiMRqbkoa9U+7aHtBFszAa88Y67rC6/ILJHpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQuEbKp5vDrHCmszAXzm1mqYsqWPRhgi2ubiDnSYNQtDaWqIzWIuQvKkqJqM/aBI2dasB08HSyAFZXVo76FXIywpp5tFuDiYwjCIuoHn3dkdhWV0AFKndjMoVLdFDkM3drvevVoQPDEfcIN/EAHuLUkUYQ5eKRrXyKK9+sHIgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXP9DNGK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXP9DNGK"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb6d00883so2705597e87.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783357657; x=1783962457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bTKln45GM0fk011qbQeayCXILczaZaZoSzdEKWSP20w=;
        b=KXP9DNGKEjHVvZLJ5rIwZMPGFAnltlbmFPUAFbH7UMXwf44WaT0DV5hu2MweMeJ54c
         hsaWHGTFtSaGwhrS6fTcQgHmBkXXoWk0BiUrPVrdsDEyU29cxViPaVYlG04V73rmP6bX
         S34U9xPiPoguE5uqAOKFCn5F7csp8QJ83khHAKsMNod37F5WwN7kyxMHRrLnrpnVHQcx
         Pt6k8p4QfCGqXBy7NOpraSi7ztJK9HomnLkOv6oAwKX2W/5AjKEDSTvyAZkNDweBeueR
         Yvq8oDr0PLnrH2HWlspqHGBQzUnbGrjZ4/dqRohl77NEvEP22vwLR7NRIjARdos9c9tK
         jhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357657; x=1783962457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bTKln45GM0fk011qbQeayCXILczaZaZoSzdEKWSP20w=;
        b=mg7uyZ4Q8UD6W9ebH03eLMcVFXW2razSUUpEXQNOrrY/bLg2YkGyI5NlBQi2LjvCnr
         NOG/MN/OFEUXSXZYBndIdfUd3j6yzdg/5s/l9mYbvne4iUCiDst2CWebK9SI8hceXG2+
         aRyOalDgHQ4d6SdEHMETFpwpuJFGUllhMYFSYkDclixpnUFg5RsvrqQWf94ugRgutqi8
         dO5ZypCPlEfGnN8lrRHh6YBev/k20DhJSUwkyhPbCJqCSK4DHfclMfT+UekLIOT5CjIF
         ta0AgB4SnPQEyB+jKmMg+PCpaekJod1TdIvEB+mH9WbJvPn4ffs9/h5Ecap2bp0nYJ4f
         HrfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1BRDqsdHaa4MPpf2bSAgqXKLXdNR8ZXzngn9Wk392GqnaG1aC5UI+UY3opFq2pelR1xc1BCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIkg9OQ13efamEd8u0tUycHG1g+w4a08bzyHEFLmVfQ0kWUoQ
	HkhPquhH1RE0Rzs9xgCTqSjUONd5xVRCkr2bEwqUP4NcPLdPZMzyBik61masA1EJ
X-Gm-Gg: AfdE7clAxQD4ZBAbHxIsi2puU9JZnBUncZ3M/TmjqeOIvCg08+7VRx16km/o0iLM2qA
	xFH6qK6FCwC1rqoA8XhibFp/LVdyib0ZLpRq4fR0TEn2/t5e+r6Wrry6WdkSpHS7oWWXo/Y+yw0
	2+IaJYQiaB4jtoGLGtdlDQgwMV9SRi9Ul9i/h0AcM+mP0WHws6LQbui8bT9aeb/RqSHmSw5+MqN
	maSbM1Su8aDliGMnrWAZe89rptNuZJaYZlj2sgIhZMMpqN5t7opBDPTryPBMpxpi+1nQnTDsEuH
	QrusIU4mZyEMi1lrMkjetivAcGhzmIC+sEz1zBPixMHY9EG3MZHZkNI47krPeYw5VcP7D+FO8rv
	xK6kXU8lgwVBAndyhwUTv2/VsfpEcAG+X2kyGVvxrXpenQEAQqNSVf0CQzRB+xVEKQ8oXXLJZnQ
	Jcxt/vYNJ2yPFkcxcQKCvNaR0HTGvfvAx4Yo26q1IYiSAORBB6QKBgiiz7nYJ7X6y7hrY7mLvHG
	a2cuJn5TYdG7H+zW/03RreKiaI=
X-Received: by 2002:a05:6512:48cb:b0:5ae:ba8f:f9fa with SMTP id 2adb3069b0e04-5b007c0b9d4mr246661e87.18.1783357657394;
        Mon, 06 Jul 2026 10:07:37 -0700 (PDT)
Received: from buildhost.darklands.se (h-158-174-102-211.A469.priv.bahnhof.se. [158.174.102.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb774sm3031918e87.48.2026.07.06.10.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:07:36 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: jannh@google.com
Cc: arjan@linux.intel.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	jake@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Mon,  6 Jul 2026 19:07:35 +0200
Message-ID: <20260706170735.2941493-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

while testing my Alpha generic-entry series on top of v7.2-rc1, I noticed
that several strace --pidns-translation tests started failing. The same
generic-entry series on top of v7.1-rc1 passes these tests.

I bisected the regression between v7.1-rc1 and v7.2-rc1, always applying
the same generic-entry series before testing, and the first bad commit is:

  6650527444dadc63d84aa939d14ecba4fadb2f69
  proc: protect ptrace_may_access() with exec_update_lock (part 1)

Examples of failing strace tests include:

  signal_receive--pidns-translation.gen.test
  so_peercred--pidns-translation.gen.test
  tgkill--pidns-translation.gen.test
  tkill--pidns-translation.gen.test
  fcntl--pidns-translation.gen.test
  xet_robust_list--pidns-translation.gen.test
  xetpgid--pidns-translation.gen.test
  xetpriority--pidns-translation.gen.test

One simple reproducer is:

  cd strace/tests
  ./xetpgid--pidns-translation.gen.test

The failure looks like this:

  ../../src/strace: NS_* ioctl commands are not supported by the kernel

and the decoded output lacks the expected pidns translation comments, e.g.:

  - getpgid(2 /* 6 in strace's PID NS */) = 0
  + getpgid(2) = 0

Looking at the patch, the relevant part seems to be the change in
fs/proc/namespaces.c: proc_ns_get_link() and proc_ns_readlink() now take
task->signal->exec_update_lock around the ptrace_may_access() check and
namespace link/readlink handling. strace's --decode-pids=pidns code appears
to rely on accessing /proc/<pid>/ns/pid for short-lived tracees in a nested
PID namespace, so this looks like a plausible connection to the failure.

The kernel has the relevant namespace options enabled:

  CONFIG_NAMESPACES=y
  CONFIG_USER_NS=y
  CONFIG_PID_NS=y
  CONFIG_CHECKPOINT_RESTORE=y
  CONFIG_PROC_FS=y

I also tested the basic nsfs ioctls with a small standalone program, both
outside and inside "unshare -Urpf", and NS_GET_NSTYPE,
NS_GET_PID_IN_PIDNS and NS_GET_PID_FROM_PIDNS all work there. So the failure
does not look like missing namespace support or a simple ioctl-number issue;
it seems specific to the proc/ns access pattern used by strace's pidns
translation code.

#regzbot introduced: 6650527444dadc63d84aa939d14ecba4fadb2f69

Thanks,
Magnus
