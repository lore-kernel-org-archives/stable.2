Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536172;
	b=OMgOTUEuf8479tRFmN5RuqDWbGmLvHYYoISrp3xLoDbPkhGuDgTjorx/fMQrLcNPQE6k
	 EBDUtzMi66IpniuAwk8tFwv3CO4UcEJcVzVBVNPe5nsvAkh+nDTeew2da/sXlVBCdSLsT
	 YepyjC/Ssw2jhkKjAeL9+ozchnYxBGic+r+YQ08FcuBFOzMN/nRIC/pgSdmiU2mH9mti8
	 E9O6fgSDwQOHnGcb5/C7eDV0dByeMs6ttSx64O1Ldb7vu+CEsS4s3UPpzgqY/X5ZdW4bx
	 R+MXtGtAtFJUlQmqeGKhfDAeWDHoaXD+/YYWTU68nxkIzIZM0KARSIm4EBF26ZBGOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
	b=tzz9AQMs3tnz60K+kRhxO5iXSzUQwEoOeJn03V7xeQL78lfD9hxJ9ftMsKSvfW2mPoWv
	 KtLjkXXmKurI01PD2+LMV+QissJYnXIoifVTTFtN/81Q1l68kPbi4Q+DXWuDAMfCnFFM2
	 xatsWk/ea0I5sH93Fh8bsk5ghCaprQsvkiXoA6TbkCHTbMez8pJaVr/UC6YGXO/TWnmwu
	 5nctsSzM4nI8RjFQvdLucaPke/wlxbtxdcpFSziNwTjUZLoCfXHv+Frr3BTSqrjDoZEAx
	 C3N5iwMl6d+q9BsgiCsc3vniKQQL89eevc0FL5e1wcFpb6gBA5wkecfjYdbSg0Ukfaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7ro8bt8;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A98606A335
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A98606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b7ro8bt8
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2195470f8f.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795536171; x=1796140971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
        b=b7ro8bt8s6WZ6goSKdTR9/b7UJZ+ETxzxEOK0KkeYo2eflpr8rt0OF6cFwV0jnuChQ
         viEH1Te3AgIKQ6/QUdTLdEwn45BzlMSO/KkLMybo1MY4sV3bcqBM7pg4YLoF32KwKm8H
         +lcVjh6X8y92UVgcXyfso+WFDHxbnhGvk/TeyGE0zkXdEfaCDi3p98b1jci2sgSm31fl
         w6EvnZhsiX8/R6QD+XjTHNd9kIQqXTn+eL5AzVDkjKo8hRdiCQHd+U+rWOPGf06yuLs7
         RNL0Mlb4kz0rsO68sTFR1NAJ/TSvmlvW+vAqvMMDbROXjbVQwWAddk9yPnDXxED9W8sD
         MA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536171; x=1796140971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VIP6J/fBo0uMkDHJLPjC6lz8Vse963XInWutXlvbkwI=;
        b=cxhT7gFHV3Xa9Qg84h4RpGSfCIk4CuR6u9AKiamYIK3374t0AlJS41AFKqrX1HLKTM
         n52ySyLEtQ6i3CyKLIE+kSKOPK7iLhQH/T7Ybzy2vApBcn04/JBcsfPSwht2IFlXx6n1
         hJvco5ZbSJ0YMJ/cV6nMdJTFX/Ts8iFuAlFPPYY+He+a1zwfSbOfLHawFODScB8vtRDu
         CygcuKGCEWwsZPSm7e8TWS6uaf8fJyF5YK8aDQZTMTqcnoAp6WufKfvISlTiX+m3ZATh
         oRxIRfA4kJHP/zC4TMwputifmVu9l667jfvmtnljNntQ3DZu3/bUTNnTvGhE8lnAh9C3
         uqfQ==
X-Forwarded-Encrypted: i=1; AL+hErG5jX/WrKE81Me3jExDjV2EOVwyLGdT5HODvrLqOstZbRxZhqrb03Ne8e+IhVbEmuJBwu0xtrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sGSvz/6/G8uwE0Sl62vUzn9vdIKsO6Qaz5E5oqoiJtVlEIPB5
	uNwdCVe3lXbjdTiQ5zY4ZA424uzrG/nrLtgtdPkwPgNTPY4U8cpDlq0l3qu2bCnyaA==
X-Gm-Gg: AZFdTZccW6PcdJX40phie8t0lt7PB613zOAqdvDjqZUE296s8rFbPfl2mgNFJagSoxX
	bStCmlqv/xqgTBWd0kMtRHlpVXjY87nLxafro9ixumZ9it7x3ybiUCJwXw/B1NhpZDemmaE/ON3
	KpHqT7Ol2EKy8aO3nMqIyb8tf/F15rHliIFACqlEc+x9f887yNRzc/l3B2+TyppQqR+y4HCCwvj
	ncxzltgqns1TGbpr4rRbhPyAkLEbIDZFpPvltImd2QcyR2ZKBZBvSUunbVEDn3SjNhehqIAC9jh
	qbmwNcS6ii+H9geHxhu7JXxMvSPJ4Vc2SSa9l+wZlmFFkVdnh2I+fZEAoRqqFphetGkReRp5/n7
	ZrIBggHoWG6nNPm4YeE5oAq9+AEb+2oceVwh3iBG8HZ+pbRoXZvO1xoC4qOqTmXs8WNi3M0IYdN
	ppezIkllhDHElxgJNQFd8+LVIJild9Uybt8qiX3UN1cLJ2wZY63UT5587batwz9md6gZkMCRpyA
	nVTEGDCp0GEze1t2723r4wSLDH1p4X3H56+f1fg4dYBtN8NEYccZ2uZADCOKXqhQwB120MCN5Z4
	PJazMNq76z/EwnmTLOOMB+690drvxOvsS3mcjMK7zsRvTugEsNwr7xiBUHXc
X-Received: by 2002:a05:6000:4541:b0:4aa:d196:f329 with SMTP id ffacd0b85a97d-4abb4c7afc6mr19740332f8f.27.1795536170162;
        Tue, 24 Nov 2026 08:02:50 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:d01b:9df4:1123:37e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm30145984f8f.8.2026.11.24.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:02:49 -0800 (PST)
Date: Tue, 24 Nov 2026 17:02:44 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>, Cen Zhang <blbllhy@gmail.com>,
	James Morris <jmorris@namei.org>,
	Lee Seong Hyeon <ihopenre@gmail.com>,
	Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>,
	Nickolai Zeldovich <nickolai@csail.mit.edu>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <awW1JBtrZUoBcwJq@google.com>
References: <20261120151554.2651743-1-mic@digikod.net>
 <20261121.bd9ab1ba5f9f@gnoack.org>
 <20261123.RailieV3ePah@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123.RailieV3ePah@digikod.net>

On Mon, Nov 23, 2026 at 10:37:22AM +0100, Mickaël Salaün wrote:
> On Sat, Nov 21, 2026 at 10:46:49PM +0100, Günther Noack wrote:
> > On Fri, Nov 20, 2026 at 04:15:52PM +0100, Mickaël Salaün wrote:
> > > landlock_restrict_sibling_threads() write-locks
> > > current->signal->exec_update_lock to serialize TSYNC callers, and holds
> > > it until every sibling thread has run its task_work.  This wait is
> > > unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> > > sibling blocked as a vfork() parent runs it only once its child execs or
> > > exits.
> > > 
> > > Meanwhile, readers of this lock block, mostly in D state:
> > > /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> > > etc.  An unprivileged process can thus stall tools run by other users,
> > > including root, such as ps and top.
> > > 
> > > Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> > > signal_struct.flags bit, protected by sighand->siglock, which is held
> > > only to set or clear the marker.  A second caller still restarts the
> > > syscall, and a cleanup class releases the marker on every return.
> > > 
> > > Like de_thread(), treat a group exit or an ongoing exec as a held
> > > marker: a group exit may overwrite the flags, and both kill the other
> > > threads, which the restart lets the caller handle.
> > > 
> > > Add KUnit tests for taking a free marker and for rejecting a held one.
> > > A concurrent TSYNC caller cannot be started deterministically from user
> > > space, but a KUnit thread has no sibling and can hold the marker itself.
> > > 
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Yihan Ding <dingyihan@uniontech.com>
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > > Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > > Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > ---
> > > 
> > > Changes since the initial report from Lee Seong Hyeon:
> > > - Rewrite the fix, storing the marker in an unused signal_struct.flags
> > >   bit protected by sighand->siglock instead of adding a signal_struct
> > >   field.
> > > - Treat group exit and ongoing exec as a held marker, because group exit
> > >   may overwrite the flags.
> > > - Release the marker with a cleanup class.
> > 
> > It's not clear to me why the cleanup class and the fix are bundled in
> > one commit here.  (I do find the cleanup class useful, but shouldn't a
> > bugfix commit be as minimal as possible so that it is easy for people
> > to apply to their downstream kernels?)
> 
> I included the cleanup class because we needed to change the up_write()
> call anyway, so it's a good opportunity to use an automatic cleanup
> mechanism instead of replacing it with an explicit lock + flag change.
> 
> I also moved the initial check before the initialization because it
> makes more sense there and it was a good opportunity to do it now (I
> updated the comment as well).
> 
> This extra cleanup doesn't have any impact on backporting.

Fair enough, sounds good.

Acked-by: Günther Noack <gnoack@google.com>

—Günther
