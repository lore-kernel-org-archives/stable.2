Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7C41D644
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552349; cv=none; b=TMyEUtImmtbo2Z89/0zbe20fv8/1AgFDFpWyJfqcTlRhKjOk27zzIQC9La1UEO5XUF5hAMqpUsy9uNb++uraRN1fdYf5h0jRr4OHx7kfLzVAFkA2Isp7KdbX1lQbU6NAaYdRDQBelVLGoIK0irB01Bd1U4DwMM6RypT4HcHq6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552349; c=relaxed/simple;
	bh=41DugrLF1lmmRW5htz1N+cyn2J2/AaM7HNhYyJP0Cks=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gwhgbBe/lT5+VFxFfOBVFIDEeDhH7bZIAkoM6IcoxdWSlA7KqTZvqLm9S8emQxXsNWvSqdN6qunALal80yP725zX0y+cWUKGHuwQVEJgGFPYBJZYbczkRyGbHCv31MrQ7nT642pZ2P4h1FoP6UVWaV32FkVVG3Ld7a8HTUpuKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=UDjJYntW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="UDjJYntW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so6331120a12.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1784552347; x=1785157147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Lzbm2KZG5O+c26LNxVqcm5DPvdra+IAb3fCtlScUaE=;
        b=UDjJYntWuZ5eCcanXIacGldPw9WMzN4DxV4IfhPXuCjiEkJrefOpwNhSREQzg49Frh
         WXTmk+Qn/nPo7SFnZ6TOEC2It+kyhwCxpoFZVCIhTQmZUe8YUzKku0ZnmapsmjkIK5Xb
         +Nwk+I6Jxn0XMqos7RwKsF6xkRlmg2TpWCmjWLIHnk7942TLRKKefiWP9EQyxuFOpVcj
         6QENy+jQT+Yvf9MrJywcLHs623a/0Q2A3AtIRLHrIbg4Tz83K5W/lpAJwLrFn0Z6Bl/V
         0px8CjyHfnbzERDv3kNlgG5E9SdNV2y/s1wJVX/dbiXmmzLTJQuklfI+gIFxJNIwW65m
         VT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784552347; x=1785157147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Lzbm2KZG5O+c26LNxVqcm5DPvdra+IAb3fCtlScUaE=;
        b=mDKstjgzbjwlQ03Qdtv6j88x69fdy3bkNPSImbILwY78rSROD15X5904sOSXXqDvOB
         fUd8j5PFGH1tN99G9jHQMtmZxk/SHcbS/+9jXDAH9ZFNlLbP2WBuWsbvZgcAkVaQcem3
         T69WkT1dxvFTQUrThf/MWvvQzwgUZuCHauWp9YIFcytNn6DtCIs6553oX1tc55I9xmCr
         Hx4RWLBGAo4JHGaSRQw6yMdil6uF92N8rPY+0mhr5F7bIKn54ScIILX7Or7K30t29Fhk
         0Fwvqbt5X8G9gAX8OnLn1tot8X34f82og2OtCQn65GeYNEHwSormTIN42K4/17GFyoJ3
         DpOQ==
X-Gm-Message-State: AOJu0Yx782nGMAl3Riztvx8P7dIw7z9ueLrX6poaeSDJUTfDDjKzlV80
	g3aaEgmtDi2jZ0HrmqJk+dFANWaihnKdt8RuopYpYQtZ47KvFHrk3xfNodpUl5TJCtqCotb4z2F
	EEO2b
X-Gm-Gg: AfdE7cnuJ0h5bXesQ2ky5CCD2FTjsFzhQ1hMjf0hlVk1dl6nnpz7SQWrMONKu3c2v96
	MzZIO4h8RMOsSdboiVp6gGBHKP/VqxX0u4VvfOLYo7pPOCr28xkvaHxso3EqJ7wQLUSg4AYizeD
	DjJ3hhyT4iJLWPski9Fm3HSYbsmTVWqLf0eq4A4XLZQKtocUQq5Up4zJItnI4PtnMrmcC8/eaXk
	VHq9xXJrdjMO5m+C3GuYtnDSEbjJBKMbJ//OCBvhYmDcdX0mGP2yybXq58T8f1+bhSezfs9+Z4j
	qj2+mX7mgUB7LUO0rAzPqUy6T6ffc10x1mUqVBX/5qMAD6d6wIgawXbIjlR+iptrWv+3qTApraH
	3TvYeU8RTFKXnYR2IHpsI65VMG2Iws+NxwPGuHof/bS8dNJsy7vxwgBAAPZr3G+aJ4v/TSbI=
X-Received: by 2002:a05:6a21:1519:b0:3bf:6c08:4ebb with SMTP id adf61e73a8af0-3c3ad8b2a79mr15612375637.48.1784552346882;
        Mon, 20 Jul 2026 05:59:06 -0700 (PDT)
Received: from 963b246bc1b3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b1f3sm35861396eec.26.2026.07.20.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and
 code is a
 C99 extension [-Werror,-Wdeclara...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 20 Jul 2026 12:59:05 -0000
Message-ID: <178455234467.13416.9935390187344263712@kernelci.org>

New build issue found on stable-rc/linux-5.15.y:

---
 mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement] in security/apparmor/policy.o (security/apparmor/policy.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
security/apparmor/policy.c:1111:10: error: mixing declarations and code is a C99 extension [-Werror,-Wdeclaration-after-statement]
 1111 |         ssize_t udata_sz = udata->size;
      |                 ^
  CC      kernel/tsacct.o
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>
Link: https://lore.kernel.org/all/178455234467.13416.9935390187344263712@kernelci.org/

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:418b90021496bfde5ca7a7b1397343e2894b899e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  76d302b34381c7f1ab7fe4d0882631c2fbbc030c

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a5e0c2a3427a5b0fb023362

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6a5e0c8a3427a5b0fb023447/.config
- dashboard: https://d.kernelci.org/build/maestro:6a5e0c8a3427a5b0fb023447

#kernelci issue maestro:418b90021496bfde5ca7a7b1397343e2894b899e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
