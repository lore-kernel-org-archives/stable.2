Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201255;
	b=F3pcL7ptzWDb3P/4r7rFdJ9KTFd+nuKWeiVkOkVsWXYIuW4nBDz66ty+gy7GXaePDJ7M
	 /y8dx51SsAgyhPF1nx6nlshalPjO1SaFExzFcNAjR+bxlSHpaVRVJHjj5RuRYZoerz+xX
	 xy3ZFTJuzHsnPJ9JgzedlWp6hNkgs2+xn8jFz6zQQXyUJuecpOMiTY2QnF0jGSMhDNvdm
	 Zm3TxaZVgVfj+PS3Rlp6pObQuLuZN5x/AwZLQyPFIEYKJBoPHOzfUvunLw3SXFb7rsO6E
	 RSu9WaFXGYQXuUiXkgVKFv+E2H9ihX68pVtnek8Zsn74T/VMsWCc5ZGFv5+R5iGPQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2IUJ4prZfGsGzb0Qck/GAuOjhnwEHRfiPDhs17Z4SoU=;
	b=nlAzYrYkUeuQ684fEs+x0JFqR0B4mvh3nZi5SFuclCARK5ZubNCgpdGQ4VQhUzA+M++Y
	 Ip4YuN92RNSVJsLxh6DnZk+mJl/wXYcpjyCs0McWss8sGGXij19xqL0cXBHgEceq2cqHu
	 SAcRDR0qc9MS0nNobznqVlRuCdiPZ9Cm+OtZoAArgP4IYMiSwPlB17cGLQMzajpM4O6Hz
	 TFz6CF085bymxsnape0h8QHXhJma6C2Gpcw2m92AJxe7nj3E/JBmJI0IpeoicIGr6CjZe
	 g1QAPL2G9H5c1RezY/7CRUJj4elDrr7qoRso6x3Lah3KrAEIDSa6K7KlZtWEdQY5Wow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZklHrKxo;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8043606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8043606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZklHrKxo
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd48746a49so811558a12.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201248; x=1795806048; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IUJ4prZfGsGzb0Qck/GAuOjhnwEHRfiPDhs17Z4SoU=;
        b=ZklHrKxo8PI4TUG9EcnZfURC06IahIv2QFJrF+PQZNVoeE3A2hD7BTFl/zpex/XLdE
         OUgO2LYdQ6DKZPNOz/xkP5oEoaKaPsmZZt1Msxy8xylBNrPBPkXj0pFaW9azq+gosh8d
         xQ/EbFB6HWiTdCNX6Fpye9Gt/xVojSVWeIfZqJsZMjWxOAS0FUS7erNcJ3tDVHS4NJGV
         YEq3f10Fe3+KtCCb3ZfhHf52b2RLNiSYi3lOmPC8JYAy7VAMuO1Mo7NUueIj5GhHScph
         H/rwLYUORCbyiNxh//vYtnJpjPDuA5gR+UobB0V4enDoeA+yrR+yO/fRqubGwQZx6nF8
         oY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201248; x=1795806048;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IUJ4prZfGsGzb0Qck/GAuOjhnwEHRfiPDhs17Z4SoU=;
        b=W+BWThCyZdA6B4KQ7KJ0AebgUn3C9T9+Ne5zlBHEyZExIwA/SSZT1ELabRboar9RUd
         EhBO4q/7LlA4msTHSPVTR/OxDfBWDlP/zIuc4XVznFvBS6OzG+eG6Wb6Op2Eibwr8968
         nGPTwrFJQBp+zz3wxbH6bqP1u4V0U2FSCTi//jNW6C5DW/onTHSTcuKmwISYBXu+5M3a
         UIB4YHRYDilXxcp2h1I3BTlBY09l4LdUDjsNuj/PrqjAQgOYYLz8zdlG0AduPdR+41r4
         oYYxlM+OVd7twCl1mfqNGvMZEWA4hrHN0DdR1LQB7Vgt1+jDojhoczvDh1o4Kjhtly3/
         sYdg==
X-Forwarded-Encrypted: i=1; AL+hErFAXskJ4FYBzMnHWPYJYS0kfTUjCCYHDhxO/c9kyyXQSRMe6TYOKGe8j0iac00lw0GIPIAlw0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G5S27zw60SPuWTnXPb9Ofyxo4bLguL8HmEZek0YYyFdGwRmNJ
	oynwGQdG213Z28n/w4KqH2a2JabiTm+mOIonQzBZlTf1C+05suQ94F2+4lYn/DNnKlQOahVpZYN
	rmN0XC/C7hg==
X-Received: from pgiy3.prod.google.com ([2002:a63:de43:0:b0:cca:d82:9104])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db97:b0:3dd:a006:ed90
 with SMTP id adf61e73a8af0-4014bc4e776mr3903412637.38.1795201247965; Fri, 20
 Nov 2026 11:00:47 -0800 (PST)
Date: Fri, 20 Nov 2026 11:00:29 -0800
In-Reply-To: <20261120190031.1587531-1-irogers@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120190031.1587531-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120190031.1587531-2-irogers@google.com>
Subject: [PATCH v2 1/3] scsi: mpi3mr: Return error on all failure exits in mpi3mr_bring_ioc_ready()
From: Ian Rogers <irogers@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>
Cc: Laurence Oberman <loberman@redhat.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In mpi3mr_bring_ioc_ready(), all success paths return 0 directly, while
all failure paths either fall through out_failed or jump to
out_device_not_present and return retval.

However, retval is initialized to 0 at function entry and overwritten
with 0 once mpi3mr_setup_admin_qpair() succeeds. As a result, failure
paths that do not set retval themselves - including unrecoverable fault
checks, PCI device removal during reset or diagnostic-save waits,
failure to reach MRIOC_STATE_RESET, and ready-loop fault/reset-history
exits or timeouts - return 0 (success) to mpi3mr_init_ioc() and
mpi3mr_reinit_ioc(), causing initialization to proceed against a failed
or absent controller.

Set retval = -1 at out_device_not_present whenever retval is 0 so every
failure exit returns a non-zero error while preserving specific error
codes from helper calls.

Found during an x86_64 LLVM=1 allyesconfig warning audit with AI coding
assistant help. Verified with a standalone C logic reproducer and by
building drivers/scsi/mpi3mr/mpi3mr_fw.o with LLVM=1 W=1 (-Werror); not
runtime-tested on MPI3 hardware.

Fixes: 59bd9cfe3fa0 ("scsi: mpi3mr: Code refactor of IOC init - part2")
Cc: stable@vger.kernel.org
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index f0d3cd398dd0..416f27c37535 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1744,6 +1744,8 @@ out_failed:
 	    "failed to bring to ready state,  current state: %s\n",
 	    mpi3mr_iocstate_name(ioc_state));
 out_device_not_present:
+	if (!retval)
+		retval = -1;
 	return retval;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

