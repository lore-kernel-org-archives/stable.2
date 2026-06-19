Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C71E4AF
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845199; cv=none; b=qvcQSuqf4W1/bijC+CIxYRdgRG4QCgF0gb7SNZCc6Aq0B7Qhou85Drh+uyvNMThvgbcr5nxKxroGPjcuPOpaQfj1vauzTluwVhRBwXc0SxB3yAH8SG3a/DLeRGVTMbgsMZSW9dawVzhw3i6mceDQpHhLyVgn8RDb4N0oN9fJL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845199; c=relaxed/simple;
	bh=AihCfZhkkK64dI1DNFZckyVX6sL3NsXowmhM/kiNquM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bfq2Htfsc1ihywKnluhB29roqBnA+Z8PYEdm/bI3PRTYmKSlrxPsCnpmMJLg1RyR+PfKb0F9N8RVdr7ioQ9NTGt7CuCZKCDS4OxxaIwia5r3UnzbWOwWvHN/s7sew8qQdygukNWODHrNjZwjAvkw+2DPvT1KkGzUv4Y3wlqW+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NmOIYjA1; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NmOIYjA1"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-bdb3fd39045so216081766b.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781845196; x=1782449996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYZdm8Y3Yr3Vzjy9QSS6ROErtGUQdJmzNY55J2AOdWU=;
        b=NmOIYjA150nOhb02d+h5ZW83K/+q1wOwikYE0dfreEtrzMCP8U4WQGYI6ExUCBJK8H
         xZL0CKLttwAPLXNCN7o84k62dQbiSb3IHBOmXv7K66rJkQg2h8bvj3kHfkE7yVmWyG2W
         Gpqi1KCjq45mqX7oyP80TOoD8ipc13mCiqpZXIZt3ebBIvKMICaOqfju77uHXFbyblew
         aFLW/bfnfiHtU1DTV/PnwSdPNmSuBXi/LBW00nXyekHY3fc9y3PVdHFNprR6RqdtZfrZ
         PVx2hVZes8885bHMEDdE4X3Sb1VpZZIY0rrhh0y/Sty2glzyuXfBbdcFv32ImX8sJyZl
         jG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781845196; x=1782449996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYZdm8Y3Yr3Vzjy9QSS6ROErtGUQdJmzNY55J2AOdWU=;
        b=F3bDSvNkCWWt0EW86/wn7Zi9IKIawYQamoVtWsG+1EhbFNwhcPv6gimq02pc995qWW
         cV33mX/usEFWAafjbV6LlGFIzUySIZoiutf2l7FXPD2tVp2que1CdeDP0Q2Dpb0ftOMp
         wyFzNjggQq1fgQb5EP3cnoK+lzgzZLlrji3bvYTITw1BGKz6NywsLFSH/jy6cbsw5vug
         IV8ks1TR0YVP0rsRpvBVk0xO+eMg/gRNb2JEwcrQqPwiFj68zhfGVA8ghTH670APJXU0
         MMJZnVrB9XbYYpCutOxNhr+g7CFWxdCPgQmzxoMkUbb0QGvV4Ip+aVNEHrbfkL4ICrvd
         MCWQ==
X-Gm-Message-State: AOJu0YwtGD4c62XHvMQZDDhK6nomYTP+qYXCNhT5NJBL0wbL6ICK/qLa
	NK0O/dNFos/nO8Rsab7SBhVmSKNgCv7qU+Bkzse3lyl5k9wCH660pCwRnhB9yybsvhVIIJSoUu9
	6S/M5HwEhSEzO
X-Gm-Gg: AfdE7cmrIkRpTbTwRPaD4hJTc8ArQYvSg0Bgji+tDanUOYNQAjAzHGNOAa7lbWc5/8S
	Y+hcK4pbbQ8FBZLwlGoilxtYBjQEscvROwufX6J33lRgAp9u9SbMdOLi8Bxv24qtOMi/VL0BB2G
	s4wwNI2qdvK+AjIA502Wb32CKx4zPIMZHqViwQScR1kxBsSRmJeML63djncSUtGgNbkiNAvq4ue
	bUYLUFKkDz/N2uyIbUk0ao6daWotDwILT7Mpq1DdXcTsJ/hthoXVIPw0IvG6NwElRd1GMvheRmg
	N1bGCEVgDg/sDPs+WzHTM6lyFfaptYQl+GF/hHTpXJsgfx3s5xlZx0l5NE5SXnZc02ANTIENRX4
	D0RLdDLlYnd+m56TUafhLzh5xEf+UDNgOedArf1xBO5/E0LEjKzT9NJZ2T29NJBBK6DClUViiG8
	v7ZibgyBMv2iFdLxlbS1HGyKRjaAkYjVWrTxt8
X-Received: by 2002:a17:907:7256:b0:bef:87ca:aed1 with SMTP id a640c23a62f3a-c097c9bb898mr89338366b.25.1781845196291;
        Thu, 18 Jun 2026 21:59:56 -0700 (PDT)
Received: from localhost (27-53-24-58.adsl.fetnet.net. [27.53.24.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720c0d84dsm8714365ad.75.2026.06.18.21.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:59:55 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.1 v2 0/2] Fix perf_link failure
Date: Fri, 19 Jun 2026 12:59:46 +0800
Message-ID: <20260619045949.14013-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset address the perf_link failure in 6.1 with patch 2
"selftests/bpf: Check for timeout in perf_link test", which is already
part of newer stable releases.

Previous v1[1] of this patchset was missing get_time_ns() helper, and thus
will cause BPF selftests to fail during compilation. I have confirmed
that with these patches applied, BPF selftests compiles and passes[2].

1: https://lore.kernel.org/stable/20260618074114.16091-1-shung-hsi.yu@suse.com
2: https://github.com/kernel-patches/linux-stable/actions/runs/27805953461/job/82285741662

Ihor Solodrai (1):
  selftests/bpf: Check for timeout in perf_link test

Jiri Olsa (1):
  selftests/bpf: Move get_time_ns to testing_helpers.h

 tools/testing/selftests/bpf/bench.h               |  9 ---------
 .../selftests/bpf/prog_tests/kprobe_multi_test.c  |  8 --------
 .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
 tools/testing/selftests/bpf/testing_helpers.h     | 10 ++++++++++
 4 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.54.0

