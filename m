Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C715E8B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598051; cv=pass; b=Q1XvvRhyHiTX/ibl9ZY2CfAwgfJjsAQYr4oASrHfQOno6uTIkWEglspEfyECBnohzKvVJV2IDkplLIeMcr8eUAMeAn8KUFY1As7lgxDnPidyOkEYvuLR+P1A102Ctmv158XJHUOByOUwQS3mzy5yomG2IQ8yaJ7LBR2VL/qnRfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598051; c=relaxed/simple;
	bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FOn5Wu0QAkDsQLwv+cqu56ghAL1FMiVaVJ0ocTWqEIHLYfHENAufN4SBxc8a3wvpCeWQVFOR6Vb3BQ8m5OnwTPsn9NJTH1MIlx5VbhcvC7Sr85q8VjjClXGbr/7OWNi2TK2EQmvM6MLw9Jvv78s+tgjfX20MV77XsVbKIJDCqEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKJict6Q; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKJict6Q"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1891799f8f.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787598048; cv=none;
        d=google.com; s=arc-20260327;
        b=l7Ad1kLMKjdxyymKuamqIDxYBiKC+89QrRsT3NO1sUqUlKgMY/5jdQEiXDvmBZ5/U6
         l2IdVjzG7xvbmeLzh90FXlE3EHXHRrEyqsWF9Ahfx4M1WGs9ppsYjAHxDUt6H4gwqf9H
         gFhImUJ/2lVOXYg+NDXCXiXVqgGJ4tNeHZXZxZVl0gBE187wrOxxhf/glry3om9Dkw7P
         HIPhr9xK0p2+UEiA/H/hHrIpSm/kAQG8vcFR4Bb8/idcLj4WBTTZolmEzKoyq7gjxuPq
         av5sE66ErSTsYVvrkIUMztTeggkJLvli5KLd0X4xPaVNyB/S7WjotIX9gP8kUZrntkhC
         YNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        fh=Fb4EtPoaskFNfDPSdNG3wA/Q/hQ9b6abCOvimYtsSxE=;
        b=O2hAuQdBf3v12Drv0ZTBCdI85qJ6IO7h+5WTc8H70vnhELIUdKIZ6/EmhiTByZPnWI
         QdXHH02lh+7LgSY+gjX2yId3AReENVNl0SxeSXJLUizHbBAWUOggedObFY1T4kHrVsNR
         jc+fIIF/K4vbdztGpyktTqGZmdmG/3NFt4xkRytmy/UeFJh2XLPb8+vORLT1uq80pM3a
         On3UxUwdIizPiPrjnQc/8jW3dDMwlrKOhK4c+NpxB1s7Z5o4O0zsSiMChxDw9TcMZOcy
         dd6tW8+IKNGNiejsXd7PBWaWaYMjSma0Chtp7incCjNXRk7gSrz52AbTwuOZajqnsGxA
         ysOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787598048; x=1788202848; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        b=rKJict6QvTHwaCWgS8M+Ae6mjxXrTCNaNrXRJZBbaZ2xxuUgIR0LWsTPAqO+t2wGSG
         gUAnJiBpIL22jXCfrSrFXSFa8EkwIUxoKCIDwYZ4KpnmBn/NxDAMD/kkvDxo4hkXJ2Lg
         IQ81c1iFmNTkUraCsaByqsnCz57FHsx6/btHctzCChuwZmRQvGVI0L3KPYbVTmdhGpnY
         Opo08hnpJRASu7f1dAvuiLjCB7dtunH8laT7U8rJqsxg9hCvBZvoLjLqi69xx5XJLjHX
         dBTja2OmvXt4h2UI7BSfiffP51cwlHwnBo+LDZnfzRhdlcjccD5Ep1dbf/kd4m1H2Dip
         mqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787598048; x=1788202848;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BRZPDspEtIyER3A6FuSt6b8MpX3dRuVdqdSh7SiQKIg=;
        b=X8V+Vj/l0hciWzz15xX0l6+Z8H0ohOxOG4MoPUaa6jnS9uSo4rclrIxa2r4pQHT3xe
         z1vv5XX8iXrDCgxK7wLzHApmfY1ivyc4mubMPSaZ4q0TliXv5qTpWAXWQ+9XyvhBO2bS
         AflCTyABF91MoW28VFhDtOiH3KdQx+Oz/Q+wbQS7NIaFiUKK29AiVi3IQl9dynljk+jt
         XqsoUMVvqT11E+RughojkrDSq/+qa8WlzrpBH440OdR4zJAoi7ndJjuWqsPE9rsS5kRP
         8yTaSi9XwAhCtxO2CfPmk3lYbdzbjJXHXb4pFvc9uITqxjADItl5Gm7MsmQo2Ng1w1t/
         QjXA==
X-Gm-Message-State: AFuF++nw8h4E8Iyxd5WzZK0n29wPBLiaMDZTJwZKgDYUZsKGoS91l0mN
	Gm5+JMQeshhDBDLPatgc8hbFejokotoryMM1GDunbq6iloKTX8hSomvNQyeH19fQGosFRsI5zQW
	HUjTiE7Xybmo+6lsa4MdIy+Qo9UwynSHmXREH
X-Gm-Gg: AR+sD131JIFtI+1IkpbO88fAKCpGAoH1NlQIWBGkHBPsaS4c5GV2wXI+RKtEEt1Q9My
	Y5N1v/PdFWxbHLAXUEgU3FkEkKARE0p7ASrpThwqgIviAKlekeTYD/n+VdHBMH5N0N3UVgjgQ7V
	J+QvvP/qXGLTNnJpIHxjUMGt5Pu+smYuRJX/d7QGoC/wWQ8jRP//biRaj4TXjC1GemLDFhx/Lhh
	1uWKIKUa+yLYRCSiqUEwF96G0gE+744VaI5N+5jatV9MIq35suA1t7nf6mPghQLTKGEX0iS7bOd
	ghJFUS3MN0BerwX+qiYN5qXoV51QJN6EyhUpTtiSj6phu394sXggtotOYWny9lnNkihToh8IRJc
	Fdg==
X-Received: by 2002:a05:6000:240c:b0:47f:cb30:8591 with SMTP id
 ffacd0b85a97d-482d9efe383mr1144759f8f.6.1787598047884; Mon, 24 Aug 2026
 12:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Date: Tue, 25 Aug 2026 04:00:34 +0900
X-Gm-Features: AcwNN1XEUmrU5UXLwhrJrZf-M8LpZH4N9FOCA-K6llWPaRMvlJpfMLvXcIQMs4o
Message-ID: <CAPa51zmwhbD2Xc1kFJY8HmpG-DY3OsK=G=h2Yn5ismeGCxo==g@mail.gmail.com>
Subject: [STABLE REQUEST] bpf: backport de36adca6346 to 7.1.y
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please consider backporting the following upstream commit to Linux 7.1.y:

de36adca634634c205a9eb8b56a28175ab7abf5f
("bpf: reject overlarge global subprog argument sizes")

The issue was introduced by:

2cb27158adb3 ("bpf: poison dead stack slots")

which is present in Linux 7.1.

The fix rejects BTF-derived global subprogram argument sizes larger
than S32_MAX. Without the check, the caller-side PTR_TO_STACK
validation can interpret an overlarge size differently from the
callee-side PTR_TO_MEM state, potentially allowing the verifier to
validate accesses outside the actual stack object.

The upstream commit includes a selftest and applies cleanly to the
current linux-7.1.y tree. The fix is present in Linux 7.2 but is not
present in Linux 7.1.10 or the current 7.1 stable queue.

Upstream commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de36adca634634c205a9eb8b56a28175ab7abf5f

Target stable series:

7.1.y

Thank you,
Taegu Ha
