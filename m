Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661118;
	b=wG97VWYRlrq5eM9vTO52F80sx5OZZN2tE0KCPCgdlosZZ3WDQ08Cho19wK/p93THPHHF
	 cu1SXwNwFSpxH2PRcBmiDFGkj6VO7Kq3TopcOcECOEUBO6WWojETQ5PdMbKMZYAVXnXsg
	 FFVDqelvdzEPHo8QIZwEVsn931X6zfcuK/oyh57qyZOfe2gJnq3qG5MEdDx3+nOMPMJX3
	 1AUoke9XB/v6qn7ZSaAT9jQADT8OPAbykZSdR5viwXUdzBvzIEHsj0FwFutHpcqGWyxJR
	 DUT2WBg3iit7gbT7SBHJ2gAx8lVzafCCoMZVBxgpr3D/8ktsC3C98rrrhoorXYPDOwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=7GlQETt5WeF9RW01TOjSC+PQOreKfokGpSVrHkh5SZ0=;
	b=g2mz7YEc3ZQL/zDBwywYlfUWGo6To3YVpJywdAgBPnC4XPjQShLRrtOY0Yk7s33dXEmO
	 l4hOWsJ+TA+SpJj5TvgJWMyZKWFIN8WdCyaxZzOGfRJV0EdegJbRUYUePj+aonkOgskHE
	 9wm10SO49byeZt6sBDQ0CzZT8zMBEfqoz1orVue1VdxrlnFdjIvIYKLlQspzHKVPE43+U
	 j2MdPSkHTg0sxrApz3l195P0GaP6wjPlMr+YkpaPT/jbrPepgsfyfnojwfQCp/F7jSeP+
	 6LXnwiOBwc5XLH/RFDUE9q20O9hHJL12f6eO26UubkdSYAm/hOvtGZ2wQaIC9hCgNGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=j0HtFaWB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64A606A33D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD64A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=j0HtFaWB
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67db0791748so7557728d50.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661117; cv=none;
        d=google.com; s=arc-20260327;
        b=NJvqk8qufcLQENzdh9uJWKksj8bPVxCl0B8RQj3/Itj9l/mVdbztKvZ/SFQxgX0Oyg
         5NBRnsUc4AI0x7/kDPEAI3LWMvmR0nH4zUzwCFCXOudTTZ1XRkLLLW+uvXfRgNWWZFCk
         6jQH4JUI/MH/GTPo8Owye7+UvwcSK/ydDhC3+rRM/L5q46GtRo2leGDZygJEJHDrUA1K
         iUDiatD2DT2hTPk/ex4RQSNyLTPdHnj5UBFRkPzrXSiS6pHw02jjEAD+FdSSCfI+FRm9
         epVV/hfhKv5mksc4yKOulZdlFFLYkEreTfRyvDcdduHXBbKVH+DkblLEUlArDyvvTHPV
         8Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7GlQETt5WeF9RW01TOjSC+PQOreKfokGpSVrHkh5SZ0=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=pXDJfGYx7YgPIgTFt/9z8+np1e2q+Sn69jvyQKt4VJaMAR7eT9MNZw/UhsioxAmiBN
         8A/DCO0qDTp6zOXLRqVNwZ4NnAnpqcxHUU8wE33zvQ0FaVDg5P7kE245gAUSjDbQDrY/
         L58uvivRIC5ViFUDny0IF3kCOVLF29JLBCpiLet4Hp63dyyJaJhAfd2/QGm+1AFvleGg
         sHzSmMfOuEl6WC0TrDVUdsZ4V7qaeN7o7BnTwGi8qCyPE8ilpbcsvXp3EYilNgREJN1r
         +I8id6a8iVU3N74ov2TzIxZHgja4kJDnjipbk2nd3x/3l/13jkDHq5IXc263aYD9RcQD
         QlrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661117; x=1796265917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GlQETt5WeF9RW01TOjSC+PQOreKfokGpSVrHkh5SZ0=;
        b=j0HtFaWBHYJafCAM4FYpMBr/6P7rW5gahhNqWBcFB8MrNDC48o3on2tngLQkZR47U9
         lQQWcYdOqRGYJZvHimCksVA8iiz02dCtBqn83vJpeyNG3Mr4a6eOJdZ57JZU5cvdpXzN
         LMVhkBSV6591Vv++hAzTRYG3cTEIec+Lx9OZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661117; x=1796265917;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7GlQETt5WeF9RW01TOjSC+PQOreKfokGpSVrHkh5SZ0=;
        b=lW7l4Tp0/7nDJHOSnY8C+IegUdgw9RZnOPRVpVVXFxHQ8P6TjxHf7XOxtzLhbWC3MQ
         hauFLK7lYhx/TGs+rjApoJPkNHyMZ72/nhjLWijAzeW9yv1GFizg9KY4HHQDcLfYi6KS
         5obhqdxqFD2CFIpEUZ86ajZUKUgPGdX3ztWrQnbwUjLlxWfHeY1AeFRhFMrme69W0jzv
         6mrz/ml/30wawR1iq9jaLdGo5s6Zd6UwbWnNg8I64qj5EnM4EUgwwcOzDBEuJBx1OJxG
         z22BWJmJl2FvP0CUtzA0x4Pj9SbiHiZG2Kuk7YnBzJGRDjnLvtXv09Djy+axtycFX0cE
         Hq8w==
X-Gm-Message-State: APuU4Z/gKGA5/6iWXKpy5EDyb3RsyIdKO/VBj2/DwLNL0KC4Wba8u1+t
	EZ9YE9IYIO5PN7qmGF4RFRK52RTRjuAVvbRiOxxPwVmo6zI0R+ez5glM3l1zAdOvbe5LPJqZ2ys
	bgSzDoGmQE3zwLrzbGZHx/KDpJrLkgYeBAgTQUR3qpC778Mp+/JlPx7E=
X-Gm-Gg: AZFdTZchpPZcOE0TMld8U188GFT36EAUlFNZQeyfgyP5klFU72lPMnJCHbvpBFw6NeJ
	PfRZ2iRJYeF9DIzjPnUfZFQm8aLmyQZOc2OYk8IFpdX7F5pRWw/vKLFnQvK+MtuCRzz/1hrbHl8
	J3/qItBoty9eeDnlfSyIg4yFbr/mlFYM8KpZczb83RydtAD8A/CXd6dpioXaHXg9u9t0cHElnIX
	vUCNKq5aiFvWQ8+6j4UOyYaubIC2kO1IOKpSa6uKm3EU6oPQd7et9qKlyg8gVkRbQUdV0Rr7CeA
	+oKzi8IoKT8r7JuU/rST6SiFkDBYO7fSX1SDqyRbQ5i6BEMLD2ReJR40dZIq8xyfz9BmReqqiAa
	gJfkbwKorfk/leuzV+WD0BKq7xXWru66oZaxsrhNJEGWwKaH5NEqk8hcl27rXaMLzkRNtEoeku4
	CDxHHAG9Bf+UTL66cJkwfmC3N7N8nUx/WNjCBvhN6SvV8j3JQqGF+q1uLIdcc5v7OOFzteNPq9i
	2yFOACqhvu40uU1LIqPkW/prxgfxwaL+RRMTg==
X-Received: by 2002:a05:690e:144a:b0:67c:1fba:b42c with SMTP id
 956f58d0204a3-67e03d05ec5mr8272137d50.45.1795661116604; Wed, 25 Nov 2026
 18:45:16 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:15 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:15 -0600
X-Gm-Features: Aa3M54ozbwzUaP7eZMD-IzxUqkqe5LLJflJpQube0AAB3rmNBl6zLC3mCEarIp8
Message-ID: <CAFaZ9erowDbi7GrV_kK+7LLqXZeBoH3cv=Ectq6k6TAZ3MPbMQ@mail.gmail.com>
Subject: [PATCH 5.10.y 0/2] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This backports the fix for CVE-2026-99244 to 5.10.y:

  22b7f491be8f signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
  5c0985dd3c32 pid_namespace: prevent TIF_NOTIFY_SIGNAL from
interrupting the reaper

6.1.y and newer already have both. Two changes for 5.10:
- 0x00800000, the bit upstream uses for PF_NO_NOTIFY_SIGNAL, is still
  PF_SWAPWRITE here, so patch 1 uses the unused 0x01000000 instead.
- Patch 2 calls no_notify_signal_save() and no_notify_signal_restore()
  directly instead of guard(no_notify_signal)(), restoring at the
  function's single return. guard() in the middle of that block adds a
  W=1 declaration-after-statement warning on this branch.

Tested on v5.10.275:
- x86_64 allmodconfig W=1 build of the touched signal and pid namespace
  objects, base vs patched, no new warnings
- defconfig boots under QEMU/KVM, and the existing pid_namespace
  regression_enomem selftest passes on base and patched
- No existing test forces task work to interrupt the reaper, so that
  path itself is untested.

I'm sending the same two for 5.15.y right after this.

The two patches follow as separate mails with the same "5.10.y n/2"
subjects. My mail setup can't thread them under this one, sorry about
that.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

Thanks,
Dickson
