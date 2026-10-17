Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C32F7EE9
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267148; cv=none; b=OmXSvR7cManizjD43pn9krjpRAeO4/VFWnTO95C2qG2fJeciLUZShD1l+dMVlENoKZa2V+UeszzZLAXwX4gkU4jvUaHjA+DfXMeNxWKPwt8p54Kz9c24BVLzE5HvxFJlQpKedGOQcIRA5vboT1tPS6QOyvct3TTrpeeB8QC3pOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267148; c=relaxed/simple;
	bh=Ml000V61fr3YuTld7r7u6ykURZpQlGmMzt64SRhSqA4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=sytFZ1qGzNN2SMTjQde5ruqDo7PK8BiGfNrc6nUF+fX+jcmQ68A/Tk4O9aWiQHjdsQMJobHTeApwGVix1wgA8HY7faTQgI3uaSrXYe5DkMZlAsTwzudKYYbEYmFE8bfkc+MLjHZV6JYK69/ysf57FIvC8dkYJgaf62DUsLOUm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=J9bQj5LK; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="J9bQj5LK"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1698993eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792267146; x=1792871946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HAgaZs7U9Ts9mDMveQXhZnqnkSOSUDsoHpqBUnmOvg0=;
        b=J9bQj5LKD+aVHe8s/slYvevtxHcCmivyfSeSfhcnjC4SdOwqnXyAOPofeyfMwR3gbN
         R81q2Md55lO+GNu2HDud+aYbJJKqwlgprUMxlvvfR9iRf8HU59mEukf49oFAiagHh3mc
         5zGq0z+KCB2ChOpOJP4BPGI7/JUXBg15eiCKl39XlW+S0S9bNeb1EtQQrFEgjyFSfAet
         I53GN7yQgUNQx1XEpMFdeH86nGBruLh4aM56x7jnz/6aYQyS6KycKSW4XduYFGEwNIH7
         8RLDp9D9bJqyL/pinrUkl+dQKAe97IncCoztcsVcjG5PbPCTj/3caVNnP6KL0wilciwI
         fQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792267146; x=1792871946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAgaZs7U9Ts9mDMveQXhZnqnkSOSUDsoHpqBUnmOvg0=;
        b=tqqHK7GSS4uBARMJ2fMvodYJ50eUGGIEwA2EDQoywRmHHCKfl8InnwuRg+twF68kK4
         lnZ8YFPxOp5dag4Mj+Nm9oF9jFzvfu7vPyRqTMywojDhAAJ6ICk2N+B0pzMPop4hb0va
         sJpyxOt9AVPsZClxivF0n7ZOWPuucHwe+FaiA8HxKwGWy7qP34p9dpBi/ES6KTb+8oSg
         fJcHe/3ZBpJrRW1nLt53+9QzwKpBBPtKjc7bxEydwgMKjbWue4JYFYm1utvbqs1tGnTo
         3pkYMPWOdPAjTZWxZhq9JEGH5PJo7CbAHlUTsrNOWp1gZKVxuJBMBsdi8bIHOXGw6eKx
         QFXQ==
X-Gm-Message-State: AFq9FYKgMbo1ll/os1Q7P3yK+77YBbi+q/G9nSUdYalz2om1ZohfJes+
	uW+rX1EEqHE2p6XIaeKKwC2+RZnwzI2plKgipx39W/deP3vgQkfsg6R+OOja3kVABDUPgqJGXTm
	rLVxl
X-Gm-Gg: AYBFou2WGtuhPwF9p5FZ4lvaIg844hn6ttC7RuH8+NHmNo9okV+f0J5IieOgFDD7iRm
	DoSK9pBRY4a4muonoFTQvKoULzZqWagw2ASglg3T03wNSqzjk55M/uCcNoOZkwzrjSoxML3iFHb
	hzArKHhQqCWSmqtl4U6lTSMhqRQC1xnG1R2G0FXO3xAvhafnmnYU40s4289WZRMrMhfgsbpNK0P
	S5W9DuNPhHhjEcC8etlWJqlSWm2ob+XPN8Qyu/zJ5iygw9OjTj9o/Zv1ZOEJIem3rTUaQdCtkmZ
	lw1YOFakZlJzj7jJHkYXXOl22sZqJYYxIQ1rmS0rf1BeSCi3Lhn3k9b8AlSiLblB+pK5eP3z02L
	gDiJXO5cpNrsYyFcs6k6lGfrNK0twol7ac1yBYmL46je72tGZcYz3YzVPHivDLZXB1uDwXVVCTz
	3asENmiYRGli8QPAt8OJISAwdAkQbSaY/USLejsrz5nFKC7bpw+hIwIoSuLbi6f/0=
X-Received: by 2002:a05:7301:428c:b0:35b:7dcd:dd57 with SMTP id 5a478bee46e88-361a0b99d57mr4335423eec.10.1792267145451;
        Sat, 17 Oct 2026 12:59:05 -0700 (PDT)
Received: from 6e52bff8000c ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081fa5a6esm18584708eec.16.2026.10.17.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)label at end of compound
 statement
 is a C23 extension [-Werror,-Wc2...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 17 Oct 2026 19:59:04 -0000
Message-ID: <179226714426.54876.6274550650293482487@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions] in net/sunrpc/svc_xprt.o (net/sunrpc/svc_xprt.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/net/sunrpc/svc_xprt.c:874:1: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
  874 | }
      | ^
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:697e787e9252e3e148ea5672e0816f2159fa228e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  47804a4b58848c9b0a2773013334c8ba54eba310

# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ad3ae6f7c0a66b9cb43aff9

#kernelci issue maestro:697e787e9252e3e148ea5672e0816f2159fa228e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
